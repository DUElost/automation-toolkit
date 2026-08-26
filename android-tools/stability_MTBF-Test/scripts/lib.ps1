#Requires -Version 5.1

function Get-MtbfRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Get-MtbfSuitesRoot {
    return Join-Path (Get-MtbfRoot) "suites"
}

function Get-MtbfTaskDir {
    return Join-Path (Get-MtbfSuitesRoot) "task"
}

function Get-MtbfSuiteApkDir {
    $suiteApk = Join-Path (Get-MtbfSuitesRoot) "apk"
    if (Test-Path $suiteApk) { return $suiteApk }
    return Join-Path (Get-MtbfRoot) "apk"
}

function Get-MtbfSharedConfigDir {
    return Join-Path (Get-MtbfRoot) "config"
}

function Read-PropertiesFile {
    param([string]$Path)
    $props = @{}
    if (-not (Test-Path $Path)) { return $props }
    Get-Content $Path -Encoding UTF8 | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#") -and $line -match '^([^=]+)=(.*)$') {
            $props[$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }
    return $props
}

function Get-MtbfApkNamesFromTaskXml {
    param([string]$TaskXmlPath)
    $raw = Get-Content $TaskXmlPath -Raw -Encoding UTF8
    $names = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    [regex]::Matches($raw, '<apk\s+name="([^"]+)"') | ForEach-Object {
        [void]$names.Add($_.Groups[1].Value.Trim())
    }
    if ($names.Count -eq 0) {
        [void]$names.Add("ReliabilityUiautomatorTestTest.apk")
    }
    return @($names)
}

function Get-MtbfTaskMetaFromXml {
    param([string]$TaskXmlPath)

    $raw = Get-Content $TaskXmlPath -Raw -Encoding UTF8
    $taskName = $null
    $m = [regex]::Match($raw, '<(?:run)?task\b[^>]*\bname="([^"]+)"')
    if ($m.Success) {
        $taskName = $m.Groups[1].Value.Trim()
    }
    $testpointCount = ([regex]::Matches($raw, '<testpoint\b')).Count
    return [PSCustomObject]@{
        TaskName       = $taskName
        TestpointCount = $testpointCount
    }
}

function Resolve-MtbfTestApkPair {
    param(
        [string]$ApkDir,
        [string]$InstrumentApkName
    )

    $instrument = $InstrumentApkName.Trim()
    if ($instrument -notmatch '\.apk$') {
        $instrument = "$instrument.apk"
    }

    # ReliabilityUiautomatorTestTest.apk -> ReliabilityUiautomatorTest.apk
    # StabilityTestWithPomTest.apk -> StabilityTestWithPom.apk
    $hostName = $null
    if ($instrument -match '^(.+)Test\.apk$') {
        $hostName = $Matches[1] + ".apk"
    } else {
        throw "Cannot derive host APK from instrument name: $instrument (expect *Test.apk)"
    }

    $hostPath = Join-Path $ApkDir $hostName
    $testPath = Join-Path $ApkDir $instrument
    return [PSCustomObject]@{
        HostName       = $hostName
        InstrumentName = $instrument
        HostPath       = $hostPath
        InstrumentPath = $testPath
    }
}

function Get-MtbfSuites {
    $taskDir = Get-MtbfTaskDir
    if (-not (Test-Path $taskDir)) { return @() }

    $apkDir = Get-MtbfSuiteApkDir
    $configDir = Get-MtbfSharedConfigDir
    $items = @()

    Get-ChildItem $taskDir -Filter *.xml -File | Sort-Object Name | ForEach-Object {
        $id = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        $apkNames = @(Get-MtbfApkNamesFromTaskXml -TaskXmlPath $_.FullName)
        $metaXml = Get-MtbfTaskMetaFromXml -TaskXmlPath $_.FullName
        $taskName = if ($metaXml.TaskName) { $metaXml.TaskName } else { $id }
        $pairs = @()
        foreach ($apkName in $apkNames) {
            $pairs += Resolve-MtbfTestApkPair -ApkDir $apkDir -InstrumentApkName $apkName
        }

        $items += [PSCustomObject]@{
            Id               = $id
            DisplayName      = $taskName
            TaskName         = $taskName
            FileName         = $_.Name
            TestpointCount   = $metaXml.TestpointCount
            Description      = ("{0} testpoints | file: {1}" -f $metaXml.TestpointCount, $_.Name)
            Root             = $taskDir
            TaskXmlPath      = $_.FullName
            ConfigDir        = $configDir
            ApkDir           = $apkDir
            InstrumentNames  = $apkNames
            ApkPairs         = $pairs
            Meta             = @{}
        }
    }
    return $items
}

function Get-MtbfAvailableApkFamilies {
    param([array]$Suites = @())

    $apkDir = Get-MtbfSuiteApkDir
    $families = @()

    # Known instrument APK families in suites/apk
    $known = @(
        [PSCustomObject]@{
            Key            = "ReliabilityUiautomatorTestTest"
            InstrumentName = "ReliabilityUiautomatorTestTest.apk"
            Label          = "ReliabilityUiautomatorTestTest"
        }
        [PSCustomObject]@{
            Key            = "StabilityTestWithPomTest"
            InstrumentName = "StabilityTestWithPomTest.apk"
            Label          = "StabilityTestWithPomTest"
        }
    )

    foreach ($k in $known) {
        $pair = Resolve-MtbfTestApkPair -ApkDir $apkDir -InstrumentApkName $k.InstrumentName
        $present = (Test-Path $pair.HostPath) -and (Test-Path $pair.InstrumentPath)
        $matchCount = 0
        if ($Suites.Count -gt 0) {
            $matchCount = @($Suites | Where-Object {
                $_.InstrumentNames | Where-Object { $_ -ieq $k.InstrumentName }
            }).Count
        }
        if ($present) {
            $families += [PSCustomObject]@{
                Key            = $k.Key
                InstrumentName = $k.InstrumentName
                Label          = $k.Label
                HostName       = $pair.HostName
                HostPath       = $pair.HostPath
                InstrumentPath = $pair.InstrumentPath
                TaskCount      = $matchCount
            }
        }
    }

    # Also pick up any other *Test.apk in pool not in known list
    if (Test-Path $apkDir) {
        Get-ChildItem $apkDir -Filter "*Test.apk" -File | ForEach-Object {
            $name = $_.Name
            if ($families | Where-Object { $_.InstrumentName -ieq $name }) { return }
            try {
                $pair = Resolve-MtbfTestApkPair -ApkDir $apkDir -InstrumentApkName $name
            } catch { return }
            if (-not (Test-Path $pair.HostPath)) { return }
            $matchCount = @($Suites | Where-Object {
                $_.InstrumentNames | Where-Object { $_ -ieq $name }
            }).Count
            $families += [PSCustomObject]@{
                Key            = [System.IO.Path]::GetFileNameWithoutExtension($name)
                InstrumentName = $name
                Label          = [System.IO.Path]::GetFileNameWithoutExtension($name)
                HostName       = $pair.HostName
                HostPath       = $pair.HostPath
                InstrumentPath = $pair.InstrumentPath
                TaskCount      = $matchCount
            }
        }
    }

    return $families
}

function Filter-MtbfSuitesByInstrumentApk {
    param(
        [array]$Suites,
        [string]$InstrumentName
    )

    $filtered = @()
    foreach ($suite in $Suites) {
        if (-not ($suite.InstrumentNames | Where-Object { $_ -ieq $InstrumentName })) {
            continue
        }
        $pair = Resolve-MtbfTestApkPair -ApkDir $suite.ApkDir -InstrumentApkName $InstrumentName
        $filtered += [PSCustomObject]@{
            Id               = $suite.Id
            DisplayName      = $suite.TaskName
            TaskName         = $suite.TaskName
            FileName         = $suite.FileName
            TestpointCount   = $suite.TestpointCount
            Description      = ("{0} testpoints | file: {1}" -f $suite.TestpointCount, $suite.FileName)
            Root             = $suite.Root
            TaskXmlPath      = $suite.TaskXmlPath
            ConfigDir        = $suite.ConfigDir
            ApkDir           = $suite.ApkDir
            InstrumentNames  = @($InstrumentName)
            ApkPairs         = @($pair)
            Meta             = $suite.Meta
        }
    }
    return $filtered
}

function Resolve-MtbfSuite {
    param([string]$SuiteId)

    if ($SuiteId) {
        $match = @(Get-MtbfSuites | Where-Object {
            $_.Id -eq $SuiteId -or
            $_.Id -eq ([System.IO.Path]::GetFileNameWithoutExtension($SuiteId)) -or
            $_.TaskXmlPath -eq $SuiteId
        })
        if ($match.Count -eq 0) {
            $available = (Get-MtbfSuites | ForEach-Object { $_.Id }) -join ", "
            throw "Suite not found: $SuiteId. Available: $available"
        }
        return $match[0]
    }

    $suites = @(Get-MtbfSuites)
    if ($suites.Count -eq 1) { return $suites[0] }

    $root = Get-MtbfRoot
    $legacyConfig = Join-Path $root "config\runtask.xml"
    if ($suites.Count -eq 0 -and (Test-Path $legacyConfig)) {
        $apkDir = Join-Path $root "apk"
        return [PSCustomObject]@{
            Id           = "legacy"
            DisplayName  = "legacy (config/runtask.xml)"
            Description  = "Root config/ + apk/"
            Root         = $root
            TaskXmlPath  = $legacyConfig
            ConfigDir    = Join-Path $root "config"
            ApkDir       = $apkDir
            ApkPairs     = @(Resolve-MtbfTestApkPair -ApkDir $apkDir -InstrumentApkName "ReliabilityUiautomatorTestTest.apk")
            Meta         = @{}
        }
    }

    throw "Multiple suites found. Use -Suite <id> or run runAll.bat to select interactively."
}

function Get-MtbfSharedApkDir {
    $root = Get-MtbfRoot
    $shared = Join-Path $root "shared\apk"
    if (Test-Path $shared) { return $shared }
    return Join-Path $root "apk"
}

function Get-MtbfSharedJarDir {
    return Join-Path (Get-MtbfRoot) "shared\jar"
}

function Normalize-MtbfMode {
    param([string]$Mode)
    if (-not $Mode) { return "" }
    switch -Regex ($Mode.Trim()) {
        '^(?i)jar$' { return "jar" }
        '^(?i)(apk|offline|offlinescriptmanager)$' { return "apk" }
        default { throw "Unknown mode '$Mode'. Use: jar | apk" }
    }
}

function Save-MtbfLastMode {
    param([string]$Mode)
    $mode = Normalize-MtbfMode -Mode $Mode
    $path = Join-Path (Get-MtbfRoot) ".last-mode"
    Set-Content -Path $path -Value $mode -Encoding UTF8 -NoNewline
}

function Get-MtbfLastMode {
    $path = Join-Path (Get-MtbfRoot) ".last-mode"
    if (-not (Test-Path $path)) { return $null }
    $raw = (Get-Content $path -Raw -Encoding UTF8).Trim()
    if (-not $raw) { return $null }
    try { return (Normalize-MtbfMode -Mode $raw) } catch { return $null }
}

function Resolve-MtbfMode {
    param(
        [string]$Mode = "",
        [switch]$Interactive,
        [switch]$AllowEmpty
    )

    if ($Mode) {
        return (Normalize-MtbfMode -Mode $Mode)
    }
    if ($Interactive) {
        $picked = Select-MtbfModeInteractive
        if (-not $picked -and -not $AllowEmpty) {
            throw "Mode selection cancelled."
        }
        return $picked
    }
    $last = Get-MtbfLastMode
    if ($last) { return $last }
    if ($AllowEmpty) { return $null }
    throw "Mode required. Pass -Mode jar|apk, or run interactively."
}

function Select-MtbfModeInteractive {
    while ($true) {
        Clear-Host
        Write-Host "MTBF Offline Test - Mode Selection" -ForegroundColor Cyan
        Write-Host "Root: $(Get-MtbfRoot)" -ForegroundColor DarkGray
        $last = Get-MtbfLastMode
        if ($last) {
            Write-Host "Last mode: $last" -ForegroundColor DarkGray
        }

        $devices = @(Get-MtbfConnectedDevices)
        if ($devices.Count -eq 0) {
            Write-Host "`nNo adb devices connected." -ForegroundColor Red
        } else {
            Write-Host "`nConnected devices ($($devices.Count)):" -ForegroundColor Green
            foreach ($d in $devices) { Write-Host "  - $d" }
        }

        Write-Host ""
        Write-Host "Step 0/2 - Select run mode:" -ForegroundColor Cyan
        Write-Host -NoNewline "   1) " -ForegroundColor Yellow
        Write-Host "jar offline" -ForegroundColor White
        Write-Host "       sevice.jar @ /data/local/tmp (needs root; no platform OfflineScriptManager)" -ForegroundColor DarkGray
        Write-Host -NoNewline "   2) " -ForegroundColor Yellow
        Write-Host "OfflineScriptManager (apk)" -ForegroundColor White
        Write-Host "       system-uid OfflineScriptManager.apk (needs matching platform sign)" -ForegroundColor DarkGray
        Write-Host "   Q) Quit" -ForegroundColor DarkGray
        Write-Host ""
        $choice = Read-Host "Select mode [1-2/Q]"
        if ($choice -match '^[Qq]$') { return $null }
        if ($choice -eq "1") { return "jar" }
        if ($choice -eq "2") { return "apk" }
        Write-Host "Invalid selection." -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
}

function Resolve-MtbfOfflineApkPath {
    param([string]$SuiteApkDir)

    $candidates = @(
        (Join-Path $SuiteApkDir "OfflineScriptManager.apk")
        (Join-Path (Get-MtbfSharedApkDir) "OfflineScriptManager.apk")
        (Join-Path (Get-MtbfRoot) "apk\OfflineScriptManager.apk")
    )
    foreach ($path in $candidates) {
        if (Test-Path $path) { return $path }
    }
    throw "OfflineScriptManager.apk not found. Place it in shared/apk/ or suites/apk/"
}

function Resolve-MtbfSeviceJarPath {
    $candidates = @(
        (Join-Path (Get-MtbfSharedJarDir) "sevice.jar")
        (Join-Path (Get-MtbfRoot) "data\offline\sevice.jar")
    )
    foreach ($path in $candidates) {
        if (Test-Path $path) { return $path }
    }
    throw "sevice.jar not found. Place it in shared/jar/"
}

function Test-MtbfSuiteApks {
    param(
        $Suite,
        [switch]$RequireTestApks,
        [string]$Mode = "apk"
    )

    $mode = if ($Mode) { Normalize-MtbfMode -Mode $Mode } else { "apk" }
    $missing = @()
    if ($RequireTestApks -or $Suite) {
        $pairs = if ($Suite -and $Suite.ApkPairs) { $Suite.ApkPairs } else { @() }
        foreach ($pair in $pairs) {
            if (-not (Test-Path $pair.HostPath)) { $missing += $pair.HostName }
            if (-not (Test-Path $pair.InstrumentPath)) { $missing += $pair.InstrumentName }
        }
    }
    $apkDir = if ($Suite) { $Suite.ApkDir } else { Get-MtbfSuiteApkDir }
    if ($mode -eq "apk") {
        try {
            Resolve-MtbfOfflineApkPath -SuiteApkDir $apkDir | Out-Null
        } catch {
            $missing += "OfflineScriptManager.apk"
        }
    } else {
        try {
            Resolve-MtbfSeviceJarPath | Out-Null
        } catch {
            $missing += "sevice.jar"
        }
    }
    return $missing
}

function Show-MtbfApkFamilyMenu {
    param([array]$Families)

    Write-Host ""
    Write-Host "Step 1/2 - Select APK family:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $Families.Count; $i++) {
        $f = $Families[$i]
        $num = $i + 1
        Write-Host -NoNewline ("  {0,2}) " -f $num) -ForegroundColor Yellow
        Write-Host $f.Label -ForegroundColor White
        Write-Host ("       installs: {0} + {1}" -f $f.HostName, $f.InstrumentName) -ForegroundColor DarkGray
        Write-Host ("       matched task XML: {0}" -f $f.TaskCount) -ForegroundColor DarkGray
    }
    Write-Host "   Q) Quit" -ForegroundColor DarkGray
}

function Show-MtbfSuiteMenu {
    param(
        [array]$Suites,
        [string]$InstrumentName = "",
        [string]$Mode = "apk"
    )

    Write-Host ""
    if ($InstrumentName) {
        Write-Host "Step 2/2 - Select task (matched APK: $InstrumentName):" -ForegroundColor Cyan
    } else {
        Write-Host "Available MTBF tasks (suites/task/*.xml):" -ForegroundColor Cyan
    }
    for ($i = 0; $i -lt $Suites.Count; $i++) {
        $suite = $Suites[$i]
        $num = $i + 1
        Write-Host -NoNewline ("  {0,2}) " -f $num) -ForegroundColor Yellow
        Write-Host $suite.TaskName -ForegroundColor White
        Write-Host ("       testpoints={0} | file={1}" -f $suite.TestpointCount, $suite.FileName) -ForegroundColor DarkGray
        $missing = Test-MtbfSuiteApks -Suite $suite -Mode $Mode
        if ($missing.Count -gt 0) {
            Write-Host "       Missing: $($missing -join ', ')" -ForegroundColor Yellow
        }
    }
    Write-Host "   B) Back to APK selection" -ForegroundColor DarkGray
    Write-Host "   Q) Quit" -ForegroundColor DarkGray
}

function Select-MtbfSuiteInteractive {
    param(
        [string]$Mode = "",
        [string]$Serial = ""
    )

    if (-not $Mode) {
        $Mode = Select-MtbfModeInteractive
        if (-not $Mode) { return $null }
    } else {
        $Mode = Normalize-MtbfMode -Mode $Mode
    }

    $targetSerials = @(Resolve-MtbfDevices -Serial $Serial -Interactive -AllowEmpty)
    if ($targetSerials.Count -eq 0) { return $null }
    $deviceLabel = $targetSerials -join ', '

    $allSuites = @(Get-MtbfSuites)
    if ($allSuites.Count -eq 0) {
        throw "No task XML under suites/task/. Put task XML files there first."
    }

    $families = @(Get-MtbfAvailableApkFamilies -Suites $allSuites)
    if ($families.Count -eq 0) {
        throw "No test APK pairs found under suites/apk/ (expect *Test.apk + matching host apk)."
    }

    while ($true) {
        Clear-Host
        Write-Host "MTBF Offline Test - Suite Selection" -ForegroundColor Cyan
        Write-Host "Mode: $Mode" -ForegroundColor Green
        Write-Host "Device(s): $deviceLabel" -ForegroundColor Green
        Write-Host "Root: $(Get-MtbfRoot)" -ForegroundColor DarkGray
        Write-Host "APK pool: $(Get-MtbfSuiteApkDir)" -ForegroundColor DarkGray

        $devices = @(Get-MtbfConnectedDevices)
        if ($devices.Count -eq 0) {
            Write-Host "`nNo adb devices connected." -ForegroundColor Red
        } else {
            Write-Host "`nConnected devices ($($devices.Count)):" -ForegroundColor Green
            foreach ($d in $devices) {
                if ($targetSerials -contains $d) {
                    Write-Host "  - $d  <-- target" -ForegroundColor White
                } else {
                    Write-Host "  - $d" -ForegroundColor DarkGray
                }
            }
        }

        # Refresh task counts
        $families = @(Get-MtbfAvailableApkFamilies -Suites $allSuites)
        Show-MtbfApkFamilyMenu -Families $families
        Write-Host ""
        $apkChoice = Read-Host "Select APK [1-$($families.Count)/Q]"
        if ($apkChoice -match '^[Qq]$') { return $null }
        if ($apkChoice -notmatch '^\d+$') {
            Write-Host "Invalid selection." -ForegroundColor Yellow
            Start-Sleep -Seconds 1
            continue
        }
        $apkIndex = [int]$apkChoice - 1
        if ($apkIndex -lt 0 -or $apkIndex -ge $families.Count) {
            Write-Host "Invalid selection." -ForegroundColor Yellow
            Start-Sleep -Seconds 1
            continue
        }

        $family = $families[$apkIndex]
        $filtered = @(Filter-MtbfSuitesByInstrumentApk -Suites $allSuites -InstrumentName $family.InstrumentName)

        while ($true) {
            Clear-Host
            Write-Host "MTBF Offline Test - Suite Selection" -ForegroundColor Cyan
            Write-Host "Mode: $Mode" -ForegroundColor Green
            Write-Host "Device(s): $deviceLabel" -ForegroundColor Green
            Write-Host "Root: $(Get-MtbfRoot)" -ForegroundColor DarkGray
            Write-Host "Selected APK: $($family.Label)" -ForegroundColor Green
            Write-Host "APK pool: $(Get-MtbfSuiteApkDir)" -ForegroundColor DarkGray

            $devices = @(Get-MtbfConnectedDevices)
            if ($devices.Count -eq 0) {
                Write-Host "`nNo adb devices connected." -ForegroundColor Red
            } else {
                Write-Host "`nConnected devices ($($devices.Count)):" -ForegroundColor Green
                foreach ($d in $devices) {
                    if ($targetSerials -contains $d) {
                        Write-Host "  - $d  <-- target" -ForegroundColor White
                    } else {
                        Write-Host "  - $d" -ForegroundColor DarkGray
                    }
                }
            }

            if ($filtered.Count -eq 0) {
                Write-Host ""
                Write-Host "No task XML references [$($family.InstrumentName)]." -ForegroundColor Yellow
                Write-Host "Put matching <apk name=`"$($family.InstrumentName)`" /> in suites/task/*.xml" -ForegroundColor DarkGray
                Write-Host ""
                Write-Host "  [B] Back to APK selection" -ForegroundColor DarkGray
                Write-Host "  [Q] Quit" -ForegroundColor DarkGray
                Write-Host ""
                $emptyChoice = Read-Host "Select [B/Q]"
                if ($emptyChoice -match '^[Qq]$') { return $null }
                break
            }

            Show-MtbfSuiteMenu -Suites $filtered -InstrumentName $family.InstrumentName -Mode $Mode
            Write-Host ""
            $xmlChoice = Read-Host "Select task [1-$($filtered.Count)/B/Q]"
            if ($xmlChoice -match '^[Qq]$') { return $null }
            if ($xmlChoice -match '^[Bb]$') { break }
            if ($xmlChoice -match '^\d+$') {
                $xmlIndex = [int]$xmlChoice - 1
                if ($xmlIndex -ge 0 -and $xmlIndex -lt $filtered.Count) {
                    $picked = $filtered[$xmlIndex]
                    $picked | Add-Member -NotePropertyName SelectedIndex -NotePropertyValue ($xmlIndex + 1) -Force
                    $picked | Add-Member -NotePropertyName Mode -NotePropertyValue $Mode -Force
                    $picked | Add-Member -NotePropertyName Serials -NotePropertyValue $targetSerials -Force
                    $picked | Add-Member -NotePropertyName Serial -NotePropertyValue ($targetSerials -join ',') -Force
                    return $picked
                }
            }
            Write-Host "Invalid selection." -ForegroundColor Yellow
            Start-Sleep -Seconds 1
        }
    }
}

function Confirm-MtbfAction {
    param(
        [string]$Prompt,
        [string]$Default = "Y"
    )

    while ($true) {
        $answer = Read-Host $Prompt
        if (-not $answer) { $answer = $Default }
        switch -Regex ($answer) {
            '^[Yy]$' { return $true }
            '^[Nn]$' { return $false }
            '^[Qq]$' { return $null }
            default { Write-Host "Enter Y, N, or Q." -ForegroundColor Yellow }
        }
    }
}

function Get-MtbfConnectedDevices {
    # Clear ANDROID_SERIAL temporarily so listing is never filtered to one device
    $prev = $env:ANDROID_SERIAL
    Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue
    try {
        $lines = adb devices 2>$null | Select-Object -Skip 1
        $devices = @()
        foreach ($line in $lines) {
            if ($line -match '^(\S+)\s+device\s*$') {
                $devices += $Matches[1]
            }
        }
        return $devices
    } finally {
        if ($null -ne $prev -and $prev -ne "") {
            $env:ANDROID_SERIAL = $prev
        }
    }
}

function Save-MtbfLastSerial {
    param([string]$Serial)
    if (-not $Serial) { return }
    $path = Join-Path (Get-MtbfRoot) ".last-serial"
    Set-Content -Path $path -Value $Serial -Encoding UTF8 -NoNewline
}

function Get-MtbfLastSerial {
    $path = Join-Path (Get-MtbfRoot) ".last-serial"
    if (-not (Test-Path $path)) { return $null }
    $s = (Get-Content $path -Raw -Encoding UTF8).Trim()
    if (-not $s) { return $null }
    return $s
}

function Get-MtbfLastSerialList {
    $raw = Get-MtbfLastSerial
    if (-not $raw) { return @() }
    return @(Parse-MtbfSerialList -Serial $raw -ConnectedOnly:$false)
}

function Set-MtbfAdbTarget {
    param([string]$Serial)
    if (-not $Serial) {
        Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue
        return
    }
    $env:ANDROID_SERIAL = $Serial
    Write-Host "Target device: $Serial" -ForegroundColor Green
}

function Invoke-MtbfAdb {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [switch]$IgnoreExitCode,
        [switch]$Quiet,
        [int]$Retries = 3
    )

    # Always pass -s when ANDROID_SERIAL is set (more reliable than env alone under jobs)
    $argsBase = @()
    if ($env:ANDROID_SERIAL) {
        $argsBase += @('-s', $env:ANDROID_SERIAL)
    }
    $argsBase += $Arguments

    $attempt = 0
    $lastText = ""
    $lastCode = 1
    while ($attempt -lt [Math]::Max(1, $Retries)) {
        $attempt++
        $prev = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'
        try {
            $out = & adb @argsBase 2>&1
            $lastCode = $LASTEXITCODE
        } finally {
            $ErrorActionPreference = $prev
        }

        $lines = @($out | ForEach-Object { "$_" })
        $lastText = ($lines -join "`n")
        if (-not $Quiet) {
            foreach ($line in $lines) {
                if ($line) { Write-Host $line -ForegroundColor DarkGray }
            }
        }

        if ($IgnoreExitCode -or $lastCode -eq 0) {
            return $lastText
        }

        $transient = $lastText -match '(?i)abb_exec|Error:\s*closed|device .* not found|offline|connection reset|protocol fault|Can''t find service:\s*package|no devices/emulators|still booting|device offline'
        if (-not $transient -or $attempt -ge $Retries) {
            break
        }
        Write-Host ("  adb retry {0}/{1} after transient error..." -f $attempt, $Retries) -ForegroundColor Yellow
        if ($env:ANDROID_SERIAL) {
            Wait-MtbfDeviceOnline -Serial $env:ANDROID_SERIAL -TimeoutSec 60
            try { Wait-MtbfPackageService -TimeoutSec 90 } catch { Start-Sleep -Seconds 5 }
        } else {
            Start-Sleep -Seconds 5
        }
    }

    if (-not $IgnoreExitCode -and $lastCode -ne 0) {
        throw ("adb {0} failed (exit={1}): {2}" -f ($Arguments -join ' '), $lastCode, ($lastText -replace "`n", ' | '))
    }
    return $lastText
}

function Wait-MtbfDeviceOnline {
    param(
        [Parameter(Mandatory = $true)][string]$Serial,
        [int]$TimeoutSec = 60
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSec)
    while ((Get-Date) -lt $deadline) {
        # Avoid ANDROID_SERIAL filtering in Get-MtbfConnectedDevices
        $devs = @(Get-MtbfConnectedDevices)
        if ($devs -contains $Serial) {
            return
        }
        # also accept "device" state via adb get-state
        $prev = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'
        $state = (& adb -s $Serial get-state 2>&1 | Out-String).Trim()
        $ErrorActionPreference = $prev
        if ($state -eq 'device') { return }
        Start-Sleep -Seconds 2
    }
    throw "Device '$Serial' not online within ${TimeoutSec}s. Check USB/adb."
}

function Parse-MtbfSerialList {
    param(
        [string]$Serial,
        [switch]$ConnectedOnly
    )

    if (-not $Serial) { return @() }
    $raw = $Serial.Trim()
    $connected = @(Get-MtbfConnectedDevices)

    if ($raw -match '^(?i)(all|\*)$') {
        if ($connected.Count -eq 0) { throw "No adb devices connected." }
        return $connected
    }

    $parts = @($raw -split '[,;\s]+' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if ($parts.Count -eq 0) { return @() }

    $result = @()
    foreach ($p in $parts) {
        if ($ConnectedOnly) {
            if ($connected -notcontains $p) {
                throw "Device '$p' not connected. Available: $($connected -join ', ')"
            }
        }
        if ($result -notcontains $p) { $result += $p }
    }
    return $result
}

function Select-MtbfDevicesInteractive {
    $devices = @(Get-MtbfConnectedDevices)
    if ($devices.Count -eq 0) {
        throw "No adb devices connected."
    }
    if ($devices.Count -eq 1) {
        return @($devices[0])
    }

    $lastList = @(Get-MtbfLastSerialList | Where-Object { $devices -contains $_ })
    Write-Host ""
    Write-Host "Multiple devices connected. Select one or more:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $devices.Count; $i++) {
        $mark = if ($lastList -contains $devices[$i]) { " (last)" } else { "" }
        Write-Host -NoNewline ("  {0,2}) " -f ($i + 1)) -ForegroundColor Yellow
        Write-Host ($devices[$i] + $mark) -ForegroundColor White
    }
    Write-Host "   A) All devices" -ForegroundColor Yellow
    Write-Host "   Q) Quit" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "Examples: 1 | 1,2 | A" -ForegroundColor DarkGray

    while ($true) {
        $prompt = "Select device(s) [1-$($devices.Count)/A/Q]"
        if ($lastList.Count -gt 0) {
            $prompt = "Select device(s) [1-$($devices.Count)/A/Q] (Enter=last: $($lastList -join ','))"
        }
        $choice = Read-Host $prompt
        if (-not $choice -and $lastList.Count -gt 0) {
            return $lastList
        }
        if ($choice -match '^[Qq]$') { return $null }
        if ($choice -match '^[Aa]$') { return $devices }

        # "1,2" or "1 2" index list
        $tokens = @($choice -split '[,;\s]+' | Where-Object { $_ })
        if ($tokens.Count -eq 0) {
            Write-Host "Invalid selection." -ForegroundColor Yellow
            continue
        }

        $picked = @()
        $ok = $true
        foreach ($t in $tokens) {
            if ($t -notmatch '^\d+$') {
                # allow typing serial directly
                if ($devices -contains $t) {
                    if ($picked -notcontains $t) { $picked += $t }
                    continue
                }
                $ok = $false
                break
            }
            $i = [int]$t - 1
            if ($i -lt 0 -or $i -ge $devices.Count) {
                $ok = $false
                break
            }
            if ($picked -notcontains $devices[$i]) { $picked += $devices[$i] }
        }
        if ($ok -and $picked.Count -gt 0) {
            return $picked
        }
        Write-Host "Invalid selection. Use indexes like 1,2 or A for all." -ForegroundColor Yellow
    }
}

function Resolve-MtbfDevices {
    param(
        [string]$Serial = "",
        [switch]$Interactive,
        [switch]$AllowEmpty
    )

    $devices = @(Get-MtbfConnectedDevices)
    if ($devices.Count -eq 0) {
        throw "No adb devices connected."
    }

    if ($Serial) {
        $picked = @(Parse-MtbfSerialList -Serial $Serial -ConnectedOnly)
        Save-MtbfLastSerial -Serial ($picked -join ',')
        if ($picked.Count -eq 1) { Set-MtbfAdbTarget -Serial $picked[0] }
        else { Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue }
        return $picked
    }

    if ($devices.Count -eq 1) {
        Save-MtbfLastSerial -Serial $devices[0]
        Set-MtbfAdbTarget -Serial $devices[0]
        return @($devices[0])
    }

    if ($Interactive) {
        $picked = Select-MtbfDevicesInteractive
        if (-not $picked -or $picked.Count -eq 0) {
            if ($AllowEmpty) { return @() }
            throw "Device selection cancelled."
        }
        Save-MtbfLastSerial -Serial ($picked -join ',')
        if ($picked.Count -eq 1) { Set-MtbfAdbTarget -Serial $picked[0] }
        else { Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue }
        return @($picked)
    }

    $lastList = @(Get-MtbfLastSerialList | Where-Object { $devices -contains $_ })
    if ($lastList.Count -gt 0) {
        Save-MtbfLastSerial -Serial ($lastList -join ',')
        if ($lastList.Count -eq 1) { Set-MtbfAdbTarget -Serial $lastList[0] }
        else { Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue }
        return $lastList
    }

    throw "Multiple devices connected ($($devices -join ', ')). Pass -Serial all|id1,id2 or run interactively."
}

# Backward-compatible single-device helper
function Resolve-MtbfDevice {
    param(
        [string]$Serial = "",
        [switch]$Interactive,
        [switch]$AllowEmpty
    )
    $list = @(Resolve-MtbfDevices -Serial $Serial -Interactive:$Interactive -AllowEmpty:$AllowEmpty)
    if ($list.Count -eq 0) { return $null }
    return $list[0]
}

function Invoke-MtbfForEachDeviceParallel {
    param(
        [Parameter(Mandatory = $true)][string[]]$Serials,
        [Parameter(Mandatory = $true)][string]$SuiteId,
        [Parameter(Mandatory = $true)][ValidateSet("deploy", "run")][string]$Action,
        [string]$Mode = "",
        [int]$TaskTimes = 0,
        [string]$Tester = "",
        [switch]$Start,
        [switch]$RedeployConfig
    )

    $serials = @($Serials | Where-Object { $_ } | Select-Object -Unique)
    if ($serials.Count -eq 0) { throw "No target devices." }

    Save-MtbfLastSerial -Serial ($serials -join ',')
    Write-MtbfStep ("Devices ({0}): {1}" -f $serials.Count, ($serials -join ', '))
    # Sequential: parallel adb install/push frequently breaks with "abb_exec ... closed"
    # and PowerShell Stop-mode treats adb stderr progress as terminating errors.
    Write-Host "Running $Action sequentially on $($serials.Count) device(s)..." -ForegroundColor Cyan

    $failed = @()
    $okList = @()
    $suite = Resolve-MtbfSuite -SuiteId $SuiteId

    foreach ($serial in $serials) {
        Write-Host ""
        Write-Host ("========== [{0}] {1} begin ==========" -f $serial, $Action) -ForegroundColor Cyan
        try {
            Wait-MtbfDeviceOnline -Serial $serial -TimeoutSec 60
            Set-MtbfAdbTarget -Serial $serial
            if ($Action -eq "deploy") {
                Invoke-MtbfDeploy -Suite $suite -Mode $Mode -TaskTimes $TaskTimes -Tester $Tester -Start:$Start
            } else {
                Invoke-MtbfRun -Suite $suite -Mode $Mode -TaskTimes $TaskTimes -Tester $Tester -RedeployConfig:$RedeployConfig
            }
            Write-Host ("========== [{0}] {1} OK ==========" -f $serial, $Action) -ForegroundColor Green
            $okList += $serial
        } catch {
            Write-Host ("========== [{0}] {1} FAIL: {2} ==========" -f $serial, $Action, $_) -ForegroundColor Red
            $failed += $serial
        }
        # After root/install on one device, peer devices may briefly drop — wait longer
        Start-Sleep -Seconds 8
    }

    Write-Host ""
    Write-Host "Summary:" -ForegroundColor Cyan
    foreach ($s in $okList) {
        Write-Host ("  OK   {0}" -f $s) -ForegroundColor Green
    }
    foreach ($s in $failed) {
        Write-Host ("  FAIL {0}" -f $s) -ForegroundColor Red
    }

    if ($failed.Count -gt 0) {
        throw ("Multi-device {0} failed on: {1}" -f $Action, ($failed -join ', '))
    }
}

function Invoke-MtbfStopMulti {
    param(
        [string[]]$Serials,
        [string]$Mode = "",
        [switch]$Force
    )

    $serials = @($Serials | Where-Object { $_ } | Select-Object -Unique)
    if ($serials.Count -eq 0) {
        $serials = @(Get-MtbfConnectedDevices)
    }
    if ($serials.Count -eq 0) { throw "No adb devices connected." }

    Save-MtbfLastSerial -Serial ($serials -join ',')
    Write-MtbfStep ("Stop on devices ({0}): {1}" -f $serials.Count, ($serials -join ', '))

    $failed = @()
    foreach ($serial in $serials) {
        Write-Host ""
        Write-Host ("----- stop [{0}] -----" -f $serial) -ForegroundColor Cyan
        try {
            Set-MtbfAdbTarget -Serial $serial
            Stop-MtbfTask -Mode $Mode -Force:$Force
            Write-Host ("[{0}] stopped" -f $serial) -ForegroundColor Green
        } catch {
            Write-Host ("[{0}] stop failed: {1}" -f $serial, $_) -ForegroundColor Red
            $failed += $serial
        }
    }

    if ($failed.Count -gt 0) {
        throw ("Stop failed on: {0}" -f ($failed -join ', '))
    }
}

function Save-MtbfLastSuite {
    param([string]$SuiteId)
    $path = Join-Path (Get-MtbfRoot) ".last-suite"
    Set-Content -Path $path -Value $SuiteId -Encoding UTF8 -NoNewline
}

function Get-MtbfLastSuite {
    $path = Join-Path (Get-MtbfRoot) ".last-suite"
    if (-not (Test-Path $path)) { return $null }
    $id = (Get-Content $path -Raw -Encoding UTF8).Trim()
    if (-not $id) { return $null }
    $match = Get-MtbfSuites | Where-Object { $_.Id -eq $id }
    if ($match) { return $match }
    return $null
}

function Read-MtbfConfig {
    param([string]$Root = (Get-MtbfRoot))
    $cfg = @{
        "task.times"        = 100
        "run.duration.days" = 7
        "tester.name"       = "tester"
        "auto.start"        = "false"
        "auto.resume"       = "true"
    }
    $path = Join-Path $Root "test-config.properties"
    if (-not (Test-Path $path)) { return $cfg }
    Get-Content $path -Encoding UTF8 | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#") -and $line -match '^([^=]+)=(.*)$') {
            $cfg[$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }
    return $cfg
}

function Write-MtbfStep([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

function Set-RuntaskTimes {
    param([string]$RuntaskPath, [int]$Times)
    if ($Times -le 0) { return }
    $xml = Get-Content $RuntaskPath -Raw -Encoding UTF8
    # Support both <runtask times="N"> and <task times="N">
    $xml = $xml -replace '(<(?:run)?task\b[^>]*\btimes=")\d+(")', "`${1}$Times`${2}"
    Set-Content -Path $RuntaskPath -Value $xml -Encoding UTF8 -NoNewline
}

function ConvertTo-MtbfDeviceRuntaskXml {
    param([string]$XmlContent)
    # OfflineScriptManager parser (utils.m.b) only accepts root tag <runtask>
    $xml = $XmlContent
    $xml = $xml -replace '<task\b', '<runtask'
    $xml = $xml -replace '</task\s*>', '</runtask>'
    return $xml
}

function Repair-MtbfRuntaskRunners {
    param([string]$XmlContent)

    # Installed Reliability/Pom APKs register androidx runner; OfflineScriptManager
    # defaults missing <runner> to android.support.test... which fails instrument.
    $xml = $XmlContent
    $xml = $xml -replace 'android\.support\.test\.runner\.AndroidJUnitRunner',
        'androidx.test.runner.AndroidJUnitRunner'

    $runnerLine = '<runner name="androidx.test.runner.AndroidJUnitRunner" />'
    $pattern = '(?s)(<testcase\b[^>]*\btype="uiautomator2"[^>]*>)(.*?)(</testcase>)'
    $xml = [regex]::Replace($xml, $pattern, {
        param($m)
        $open = $m.Groups[1].Value
        $body = $m.Groups[2].Value
        $close = $m.Groups[3].Value
        if ($body -notmatch '<runner\b') {
            if ($body -match '(?s)(.*?)(\s*)$') {
                $body = $Matches[1].TrimEnd() + "`r`n      $runnerLine`r`n    "
            }
        }
        return $open + $body + $close
    })
    return $xml
}

function Wait-MtbfPackageService {
    param([int]$TimeoutSec = 180)

    $serial = $env:ANDROID_SERIAL
    $deadline = (Get-Date).AddSeconds($TimeoutSec)
    while ((Get-Date) -lt $deadline) {
        if ($serial) {
            try { Wait-MtbfDeviceOnline -Serial $serial -TimeoutSec 20 } catch { Start-Sleep -Seconds 2; continue }
        }
        $prev = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'
        try {
            if ($serial) {
                $boot = (& adb -s $serial shell getprop sys.boot_completed 2>&1 | Out-String).Trim()
                $chk = (& adb -s $serial shell service check package 2>&1 | Out-String).Trim()
                $pm = (& adb -s $serial shell pm path android 2>&1 | Out-String).Trim()
            } else {
                $boot = (& adb shell getprop sys.boot_completed 2>&1 | Out-String).Trim()
                $chk = (& adb shell service check package 2>&1 | Out-String).Trim()
                $pm = (& adb shell pm path android 2>&1 | Out-String).Trim()
            }
        } finally {
            $ErrorActionPreference = $prev
        }
        if ($boot -eq '1' -and $chk -match '(?i)Service package:\s*found' -and $pm -match '(?i)^package:') {
            return
        }
        Start-Sleep -Seconds 3
    }
    throw "device/package manager not ready within ${TimeoutSec}s on '$serial' (boot_completed/package)."
}

function Install-MtbfApks {
    param(
        $Suite,
        [string]$Mode = "apk"
    )

    $mode = Normalize-MtbfMode -Mode $Mode
    $missing = Test-MtbfSuiteApks -Suite $Suite -RequireTestApks -Mode $mode
    if ($missing.Count -gt 0) {
        throw "Missing: $($missing -join ', '). Expected under: $($Suite.ApkDir) / shared/"
    }

    Write-MtbfStep "Wait until boot + package manager are ready"
    Wait-MtbfPackageService -TimeoutSec 180

    Write-MtbfStep "Install test APKs from $($Suite.ApkDir)"
    foreach ($pair in $Suite.ApkPairs) {
        Write-Host "  -> $($pair.HostName)" -ForegroundColor DarkGray
        Invoke-MtbfAdb -Arguments @('install', '-r', '-g', $pair.HostPath) -Retries 5 | Out-Null
        Write-Host "  -> $($pair.InstrumentName)" -ForegroundColor DarkGray
        Invoke-MtbfAdb -Arguments @('install', '-r', '-g', $pair.InstrumentPath) -Retries 5 | Out-Null
    }

    if ($mode -eq "apk") {
        $offlineApk = Resolve-MtbfOfflineApkPath -SuiteApkDir $Suite.ApkDir
        Write-MtbfStep "Install OfflineScriptManager (platform/system)"
        Write-Host "  -> $offlineApk" -ForegroundColor DarkGray
        Invoke-MtbfAdb -Arguments @('shell', 'am', 'force-stop', 'com.ape.offlinescriptmanager') -IgnoreExitCode -Quiet | Out-Null
        Invoke-MtbfAdb -Arguments @('uninstall', 'com.ape.offlinescriptmanager') -IgnoreExitCode -Quiet | Out-Null
        Invoke-MtbfAdb -Arguments @('install', '-r', $offlineApk) -Retries 5 | Out-Null
    }
}

function Push-MtbfConfig {
    param(
        [string]$ConfigDir,
        [string]$RuntaskPath,
        [string]$Mode = "apk"
    )

    $mode = Normalize-MtbfMode -Mode $Mode
    Write-MtbfStep "Push config"
    $dataXml = Join-Path $ConfigDir "UiAutomatorTestData.xml"
    if (Test-Path $dataXml) {
        Invoke-MtbfAdb -Arguments @('push', $dataXml, '/sdcard/UiAutomatorTestData.xml') | Out-Null
    } else {
        Write-Warning "UiAutomatorTestData.xml not found under $ConfigDir (skip)"
    }

    if ($mode -eq "jar") {
        Invoke-MtbfAdb -Arguments @('push', $RuntaskPath, '/data/local/tmp/runtask.xml') | Out-Null
        Invoke-MtbfAdb -Arguments @('push', $RuntaskPath, '/sdcard/runtask.xml') -IgnoreExitCode -Quiet | Out-Null
    } else {
        Invoke-MtbfAdb -Arguments @('push', $RuntaskPath, '/sdcard/runtask.xml') | Out-Null
        Invoke-MtbfAdb -Arguments @('shell', 'appops', 'set', 'com.ape.offlinescriptmanager', 'MANAGE_EXTERNAL_STORAGE', 'allow') -IgnoreExitCode -Quiet | Out-Null
    }
}

function Assert-MtbfDeviceRoot {
    Write-MtbfStep "Ensure adb root for jar offline"
    Invoke-MtbfAdb -Arguments @('root') -IgnoreExitCode -Quiet | Out-Null
    Start-Sleep -Seconds 2
    if ($env:ANDROID_SERIAL) {
        Wait-MtbfDeviceOnline -Serial $env:ANDROID_SERIAL -TimeoutSec 45
    }
    $who = (Invoke-MtbfAdb -Arguments @('shell', 'whoami') -Quiet).Trim()
    if ($who -ne "root") {
        throw "jar mode requires root. whoami='$who'. Enable rooted adb / adb root first."
    }
    Write-Host "  whoami = root" -ForegroundColor Green
}

function Push-MtbfJarRuntime {
    $jarPath = Resolve-MtbfSeviceJarPath
    Write-MtbfStep "Push sevice.jar + cmd.sh to /data/local/tmp/"
    Write-Host "  -> $jarPath" -ForegroundColor DarkGray
    Invoke-MtbfAdb -Arguments @('push', $jarPath, '/data/local/tmp/sevice.jar') | Out-Null

    $cmdLocal = Join-Path $env:TEMP ("mtbf-cmd-{0}-{1}.sh" -f $PID, ($env:ANDROID_SERIAL -replace '[^\w\-]', '_'))
    # Match 552 OfflineRun cmd.sh (keep intentional class name spelling Sevice)
    @(
        '# /system/bin/sh'
        'trap "" HUP'
        'dalvikvm -classpath /data/local/tmp/sevice.jar com.tinno.soft.test.sevice.Sevice &'
        ''
    ) -join "`n" | Set-Content -Path $cmdLocal -Encoding ASCII -NoNewline

    Invoke-MtbfAdb -Arguments @('push', $cmdLocal, '/data/local/tmp/cmd.sh') | Out-Null
    Invoke-MtbfAdb -Arguments @('shell', 'chmod', '755', '/data/local/tmp/cmd.sh', '/data/local/tmp/sevice.jar') -IgnoreExitCode -Quiet | Out-Null
    Remove-Item $cmdLocal -Force -ErrorAction SilentlyContinue
}

function Test-MtbfJarServiceRunning {
    $serial = $env:ANDROID_SERIAL
    $prev = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        if ($serial) {
            $out = (& adb -s $serial shell "ps -A 2>/dev/null | grep -E 'dalvikvm|app_process' | grep -v grep" 2>&1 | Out-String)
        } else {
            $out = (& adb shell "ps -A 2>/dev/null | grep -E 'dalvikvm|app_process' | grep -v grep" 2>&1 | Out-String)
        }
    } finally {
        $ErrorActionPreference = $prev
    }
    if ($out -match 'dalvikvm') { return $true }
    if ($out -match 'app_process') { return $true }
    return $false
}

function Stop-MtbfJarService {
    Write-MtbfStep "Stop jar Sevice (dalvikvm)"
    Invoke-MtbfAdb -Arguments @('shell', 'sh', '-c', "pkill -f '/data/local/tmp/sevice.jar' 2>/dev/null; pkill -f 'com.tinno.soft.test.sevice.Sevice' 2>/dev/null") -IgnoreExitCode -Quiet | Out-Null
    Start-Sleep -Seconds 1
}

function Start-MtbfJarService {
    Assert-MtbfDeviceRoot
    Stop-MtbfJarService
    Push-MtbfJarRuntime
    Write-MtbfStep "Start jar Sevice on device"
    $serial = $env:ANDROID_SERIAL
    # Detached start: a foreground `adb shell` often blocks even with `&`.
    if ($serial) {
        $null = Start-Process -FilePath "adb" -ArgumentList @('-s', $serial, 'shell', 'sh', '/data/local/tmp/cmd.sh') -WindowStyle Hidden -PassThru
    } else {
        $null = Start-Process -FilePath "adb" -ArgumentList @('shell', 'sh', '/data/local/tmp/cmd.sh') -WindowStyle Hidden -PassThru
    }
    Start-Sleep -Seconds 5
    for ($i = 0; $i -lt 8; $i++) {
        if (Test-MtbfJarServiceRunning) {
            Write-Host "  jar Sevice is running" -ForegroundColor Green
            return
        }
        Start-Sleep -Seconds 2
    }
}

function Set-MtbfPrefs {
    param([string]$Tester, [bool]$AutoResume = $true)
    Write-MtbfStep "Write app prefs (data collection + tester)"
    adb root | Out-Null
    Start-Sleep -Seconds 2
    $prefDir = "/data/data/com.ape.offlinescriptmanager/shared_prefs"
    $tmpDir = Join-Path $env:TEMP "mtbf-prefs-$PID"
    if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
    New-Item -ItemType Directory -Path $tmpDir | Out-Null

    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="isUpdating" value="true"/>
</map>
"@ | Set-Content -Path (Join-Path $tmpDir "update_data.xml") -Encoding UTF8 -NoNewline

    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="task_creator">$Tester</string>
</map>
"@ | Set-Content -Path (Join-Path $tmpDir "test_task_data.xml") -Encoding UTF8 -NoNewline

    $resumeVal = if ($AutoResume) { "true" } else { "false" }
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_resume" value="$resumeVal"/>
</map>
"@ | Set-Content -Path (Join-Path $tmpDir "mtbf_runner.xml") -Encoding UTF8 -NoNewline

    adb shell "mkdir -p $prefDir"
    adb push (Join-Path $tmpDir "update_data.xml") "$prefDir/update_data.xml"
    adb push (Join-Path $tmpDir "test_task_data.xml") "$prefDir/test_task_data.xml"
    adb push (Join-Path $tmpDir "mtbf_runner.xml") "$prefDir/mtbf_runner.xml"
    adb shell "chown system:system $prefDir/update_data.xml $prefDir/test_task_data.xml $prefDir/mtbf_runner.xml"
    adb shell "chmod 660 $prefDir/update_data.xml $prefDir/test_task_data.xml $prefDir/mtbf_runner.xml"
    Remove-Item $tmpDir -Recurse -Force
}

function Set-MtbfDeviceStability {
    Write-MtbfStep "Apply device stability settings (7-day MTBF)"
    Invoke-MtbfAdb -Arguments @('root') -IgnoreExitCode -Quiet | Out-Null
    Start-Sleep -Seconds 1
    Invoke-MtbfAdb -Arguments @('shell', 'svc', 'power', 'stayon', 'true') -IgnoreExitCode -Quiet | Out-Null
    Invoke-MtbfAdb -Arguments @('shell', 'settings', 'put', 'system', 'screen_off_timeout', '2147483647') -IgnoreExitCode -Quiet | Out-Null
    Invoke-MtbfAdb -Arguments @('shell', 'settings', 'put', 'global', 'stay_on_while_plugged_in', '7') -IgnoreExitCode -Quiet | Out-Null
    Invoke-MtbfAdb -Arguments @('shell', 'locksettings', 'set-disabled', 'true') -IgnoreExitCode -Quiet | Out-Null
}

function Test-RunTaskServiceRunning {
    $out = adb shell "dumpsys activity services com.ape.offlinescriptmanager 2>/dev/null" 2>&1 | Out-String
    return ($out -match "RunTaskService")
}

function Set-MtbfAutoResume {
    param([bool]$Enabled)
    adb root | Out-Null
    Start-Sleep -Seconds 1
    $prefDir = "/data/data/com.ape.offlinescriptmanager/shared_prefs"
    $tmpFile = Join-Path $env:TEMP "mtbf_runner-$PID.xml"
    $resumeVal = if ($Enabled) { "true" } else { "false" }
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_resume" value="$resumeVal"/>
</map>
"@ | Set-Content -Path $tmpFile -Encoding UTF8 -NoNewline
    adb shell "mkdir -p $prefDir"
    adb push $tmpFile "$prefDir/mtbf_runner.xml"
    adb shell "chown system:system $prefDir/mtbf_runner.xml"
    adb shell "chmod 660 $prefDir/mtbf_runner.xml"
    Remove-Item $tmpFile -Force -ErrorAction SilentlyContinue
}

function Stop-MtbfTask {
    param(
        [switch]$Force,
        [string]$Mode = ""
    )

    if (-not $Mode) {
        $Mode = Get-MtbfLastMode
    }
    if (-not $Mode) {
        # Best-effort: stop both if mode unknown
        Write-Warning "Mode unknown; stopping jar + apk runners if present."
        Stop-MtbfJarService
        $Mode = "apk"
    } else {
        $Mode = Normalize-MtbfMode -Mode $Mode
    }

    if ($Mode -eq "jar") {
        Stop-MtbfJarService
        if (Test-MtbfJarServiceRunning) {
            throw "Failed to stop jar Sevice. Try: adb shell pkill -f sevice.jar"
        }
        return
    }

    Write-MtbfStep "Disable auto-resume (prevent watchdog restart)"
    Set-MtbfAutoResume -Enabled $false

    if (Test-RunTaskServiceRunning) {
        Write-MtbfStep "Stop RunTaskService gracefully"
        adb shell am startservice -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.stop
        Start-Sleep -Seconds 3
    } else {
        Write-Host "RunTaskService is not running." -ForegroundColor Yellow
    }

    if ($Force -or (Test-RunTaskServiceRunning)) {
        Write-MtbfStep "Force stop OfflineScriptManager"
        adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
        Start-Sleep -Seconds 1
    }

    if (Test-RunTaskServiceRunning) {
        throw "Failed to stop RunTaskService. Try: stop.bat -Force"
    }
}

function Start-MtbfTask {
    param([string]$Mode = "apk")

    $mode = Normalize-MtbfMode -Mode $Mode
    if ($mode -eq "jar") {
        Start-MtbfJarService
        return
    }

    adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
    adb shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity | Out-Null
    Start-Sleep -Seconds 2
    adb shell am start-foreground-service -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.start
    Start-Sleep -Seconds 2
    adb shell am broadcast -a com.ape.offlinescriptmanager.action.MTBF_KEEPALIVE -n com.ape.offlinescriptmanager/.receiver.MtbfAutoResumeReceiver 2>$null | Out-Null
}

function Assert-MtbfDeviceRuntaskMatches {
    param(
        $Suite,
        [string]$Mode = "apk"
    )

    $mode = Normalize-MtbfMode -Mode $Mode
    $devicePath = if ($mode -eq "jar") { "/data/local/tmp/runtask.xml" } else { "/sdcard/runtask.xml" }

    Write-MtbfStep "Verify device $devicePath matches selection"
    $tmp = Join-Path $env:TEMP ("mtbf-device-runtask-verify-{0}-{1}.xml" -f $PID, ($env:ANDROID_SERIAL -replace '[^\w\-]', '_'))
    Invoke-MtbfAdb -Arguments @('pull', $devicePath, $tmp) | Out-Null
    if (-not (Test-Path $tmp)) {
        throw "Cannot pull $devicePath for verification."
    }

    $raw = Get-Content $tmp -Raw -Encoding UTF8
    Remove-Item $tmp -Force -ErrorAction SilentlyContinue

    $nameMatch = [regex]::Match($raw, '<(?:run)?task\b[^>]*\bname="([^"]+)"')
    $timesMatch = [regex]::Match($raw, '<(?:run)?task\b[^>]*\btimes="([^"]+)"')
    $deviceName = if ($nameMatch.Success) { $nameMatch.Groups[1].Value } else { "" }
    $deviceTimes = if ($timesMatch.Success) { $timesMatch.Groups[1].Value } else { "?" }
    $deviceTp = ([regex]::Matches($raw, '<testpoint\b')).Count
    $expected = $Suite.TaskName

    Write-Host ("  selected : {0}" -f $expected) -ForegroundColor DarkGray
    Write-Host ("  device   : {0}" -f $deviceName) -ForegroundColor DarkGray
    Write-Host ("  times    : {0}" -f $deviceTimes) -ForegroundColor DarkGray
    Write-Host ("  testpoints: {0}" -f $deviceTp) -ForegroundColor DarkGray

    if ($deviceName -ne $expected) {
        throw "Device runtask mismatch. selected='$expected' device='$deviceName'"
    }
    Write-Host "  OK: device runtask matches selected task." -ForegroundColor Green
}

function Test-MtbfSystemUid {
    $info = adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Out-String
    if ($info -notmatch "sharedUser=SharedUserSetting.*android\.uid\.system") {
        throw "OfflineScriptManager is not system uid. Use platform-signed APK from apps/OfflineScriptManager build."
    }
}

function New-MtbfRuntaskWork {
    param(
        $Suite,
        [int]$TaskTimes
    )

    $runtaskSrc = $Suite.TaskXmlPath
    if (-not $runtaskSrc -or -not (Test-Path $runtaskSrc)) {
        throw "task XML not found for suite: $($Suite.Id)"
    }

    $runtaskWork = Join-Path $env:TEMP "mtbf-runtask-$PID.xml"
    $xml = Get-Content $runtaskSrc -Raw -Encoding UTF8
    $xml = ConvertTo-MtbfDeviceRuntaskXml -XmlContent $xml
    $xml = Repair-MtbfRuntaskRunners -XmlContent $xml
    Set-Content -Path $runtaskWork -Value $xml -Encoding UTF8 -NoNewline

    $uiaCount = ([regex]::Matches($xml, '<testcase\b[^>]*\btype="uiautomator2"')).Count
    $runnerCount = ([regex]::Matches($xml, 'androidx\.test\.runner\.AndroidJUnitRunner')).Count
    Write-Host ("  uiautomator2 cases={0}, androidx runners={1}" -f $uiaCount, $runnerCount) -ForegroundColor DarkGray
    if ($uiaCount -gt 0 -and $runnerCount -lt $uiaCount) {
        Write-Warning "Some uiautomator2 cases may still miss androidx runner"
    }

    if ($TaskTimes -gt 0) {
        Write-MtbfStep "Set task times=$TaskTimes"
        Set-RuntaskTimes -RuntaskPath $runtaskWork -Times $TaskTimes
    } else {
        Write-MtbfStep "Keep original times from task XML"
    }
    return $runtaskWork
}

function Invoke-MtbfDeploy {
    param(
        [Parameter(Mandatory = $true)]$Suite,
        [int]$TaskTimes = 0,
        [string]$Tester = "",
        [string]$Mode = "",
        [switch]$Start
    )

    if (-not $Mode -and $Suite.PSObject.Properties.Name -contains "Mode" -and $Suite.Mode) {
        $Mode = $Suite.Mode
    }
    $mode = Resolve-MtbfMode -Mode $Mode -AllowEmpty
    if (-not $mode) { $mode = "apk" }

    $root = Get-MtbfRoot
    $cfg = Read-MtbfConfig -Root $root
    if ($TaskTimes -le 0) { $TaskTimes = [int]$cfg["task.times"] }
    if (-not $Tester) { $Tester = $cfg["tester.name"] }
    $autoStart = $Start -or ($cfg["auto.start"] -eq "true")
    $autoResume = ($cfg["auto.resume"] -eq "true")

    Write-MtbfStep "Mode: $mode | Suite: $($Suite.DisplayName)"
    Write-Host "  task: $($Suite.TaskXmlPath)" -ForegroundColor DarkGray
    $runtaskWork = New-MtbfRuntaskWork -Suite $Suite -TaskTimes $TaskTimes

    Install-MtbfApks -Suite $Suite -Mode $mode
    Push-MtbfConfig -ConfigDir $Suite.ConfigDir -RuntaskPath $runtaskWork -Mode $mode
    Assert-MtbfDeviceRuntaskMatches -Suite $Suite -Mode $mode

    if ($mode -eq "apk") {
        Test-MtbfSystemUid
        Set-MtbfDeviceStability
        Set-MtbfPrefs -Tester $Tester -AutoResume:$autoResume
    } else {
        Assert-MtbfDeviceRoot
        Set-MtbfDeviceStability
        Push-MtbfJarRuntime
    }

    Save-MtbfLastSuite -SuiteId $Suite.Id
    Save-MtbfLastMode -Mode $mode

    Write-Host "`nDeploy complete. mode=$mode" -ForegroundColor Green
    if ($mode -eq "apk") {
        adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Select-String "sharedUser|versionName" | ForEach-Object { $_.Line.Trim() }
    } else {
        Write-Host "  sevice.jar -> /data/local/tmp/sevice.jar" -ForegroundColor DarkGray
        Write-Host "  runtask   -> /data/local/tmp/runtask.xml" -ForegroundColor DarkGray
    }

    if ($autoStart) {
        Write-MtbfStep "Auto start task"
        Start-MtbfTask -Mode $mode
        if ($mode -eq "jar") {
            if (Test-MtbfJarServiceRunning) {
                Write-Host "Jar Sevice started. USB can be unplugged. Results: /sdcard/results/realresult/" -ForegroundColor Green
            } else {
                Write-Warning "Jar Sevice may not be running. Check: adb shell ps -A | findstr dalvikvm"
            }
        } else {
            if (Test-RunTaskServiceRunning) {
                Write-Host "Task started. Auto-resume=$autoResume. Results: /sdcard/results/realresult/" -ForegroundColor Green
            } else {
                Write-Warning "RunTaskService may not be running. Check: adb shell dumpsys activity services com.ape.offlinescriptmanager"
            }
        }
    } else {
        Write-Host "Start manually: scripts\run.bat -Mode $mode -Suite `"$($Suite.Id)`"" -ForegroundColor Yellow
    }
}

function Invoke-MtbfRun {
    param(
        [Parameter(Mandatory = $true)]$Suite,
        [int]$TaskTimes = 0,
        [string]$Tester = "",
        [string]$Mode = "",
        [switch]$RedeployConfig
    )

    if (-not $Mode -and $Suite.PSObject.Properties.Name -contains "Mode" -and $Suite.Mode) {
        $Mode = $Suite.Mode
    }
    $mode = Resolve-MtbfMode -Mode $Mode -AllowEmpty
    if (-not $mode) { $mode = Get-MtbfLastMode }
    if (-not $mode) { $mode = "apk" }

    $root = Get-MtbfRoot
    $cfg = Read-MtbfConfig -Root $root
    if ($TaskTimes -le 0) { $TaskTimes = [int]$cfg["task.times"] }
    if (-not $Tester) { $Tester = $cfg["tester.name"] }
    $autoResume = ($cfg["auto.resume"] -eq "true")

    Write-MtbfStep "Mode: $mode | Suite: $($Suite.DisplayName)"
    $runtaskWork = New-MtbfRuntaskWork -Suite $Suite -TaskTimes $TaskTimes

    if ($RedeployConfig) {
        Push-MtbfConfig -ConfigDir $Suite.ConfigDir -RuntaskPath $runtaskWork -Mode $mode
    } elseif ($mode -eq "jar") {
        Invoke-MtbfAdb -Arguments @('push', $runtaskWork, '/data/local/tmp/runtask.xml') | Out-Null
        Invoke-MtbfAdb -Arguments @('push', $runtaskWork, '/sdcard/runtask.xml') -IgnoreExitCode -Quiet | Out-Null
    } else {
        Invoke-MtbfAdb -Arguments @('push', $runtaskWork, '/sdcard/runtask.xml') | Out-Null
    }
    Assert-MtbfDeviceRuntaskMatches -Suite $Suite -Mode $mode

    if ($mode -eq "apk") {
        Set-MtbfPrefs -Tester $Tester -AutoResume:$autoResume
    }

    Save-MtbfLastSuite -SuiteId $Suite.Id
    Save-MtbfLastMode -Mode $mode
    Write-MtbfStep "Start offline MTBF task ($mode)"
    Start-MtbfTask -Mode $mode

    if ($mode -eq "jar") {
        if (Test-MtbfJarServiceRunning) {
            Write-Host "`nJar Sevice started. USB can be unplugged. Results: /sdcard/results/realresult/" -ForegroundColor Green
        } else {
            Write-Warning "Jar Sevice may not be running."
        }
    } else {
        if (Test-RunTaskServiceRunning) {
            Write-Host "`nTask started. Auto-resume=$autoResume. Results: /sdcard/results/realresult/" -ForegroundColor Green
        } else {
            Write-Warning "RunTaskService may not be running."
        }
    }
    Write-Host "Stop: scripts\stop.bat -Mode $mode"
}
