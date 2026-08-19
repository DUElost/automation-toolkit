#Requires -Version 5.1
<#
.SYNOPSIS
    从 OfflineScriptManager-build 工程重新打包 OfflineScriptManager.apk

.DESCRIPTION
    1. 读取 app-config.properties 中的 expiry.date
    2. 补丁 smali 中的过期日期字符串
    3. apktool 重打包 + uber-apk-signer 签名
    4. 输出到 data/offline/OfflineScriptManager.apk

    后续只需修改 app-config.properties 再运行本脚本即可。
#>
param(
    [string]$ConfigFile = (Join-Path $PSScriptRoot "app-config.properties")
)

$ErrorActionPreference = "Stop"
$OfflineDir = $PSScriptRoot
$AndroidToolsRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$VendorDir = Join-Path $AndroidToolsRoot "vendor"
$BuildDir = Join-Path $OfflineDir "OfflineScriptManager-build"
$OutputApk = Join-Path $OfflineDir "OfflineScriptManager.apk"
$DistApk = Join-Path $OfflineDir "dist\OfflineScriptManager-unsigned.apk"
$SignedApk = Join-Path $OfflineDir "dist\OfflineScriptManager-signed.apk"
$ApktoolJar = Join-Path $VendorDir "apktool\apktool.jar"
$SignerJar = Join-Path $VendorDir "uber-apk-signer.jar"
$SmaliFile = Join-Path $BuildDir "smali\com\ape\offlinescriptmanager\utils\k.smali"
$JavaConfig = Join-Path $OfflineDir "offline-apk-src\com\ape\offlinescriptmanager\utils\AppConfig.java"

function Read-Config {
    param([string]$Path)
    $cfg = @{}
    Get-Content $Path -Encoding UTF8 | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#") -and $line -match '^([^=]+)=(.*)$') {
            $cfg[$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }
    return $cfg
}

function Write-Step([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

function Write-Utf8NoBom {
    param([string]$Path, [string]$Content)
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
}

function Get-PlatformKeystore {
    param([string]$Pk8Path, [string]$PemPath, [string]$OutDir)
    if (-not (Test-Path $Pk8Path)) { throw "platform.pk8 不存在: $Pk8Path" }
    if (-not (Test-Path $PemPath)) { throw "platform.x509.pem 不存在: $PemPath" }
    if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }
    $keyPem = Join-Path $OutDir "platform_key.pem"
    $p12 = Join-Path $OutDir "platform.p12"
    $jks = Join-Path $OutDir "platform.jks"
    $pk8Full = (Resolve-Path $Pk8Path).Path
    $pemFull = (Resolve-Path $PemPath).Path
    & openssl pkcs8 -inform DER -nocrypt -in $pk8Full -out $keyPem
    if ($LASTEXITCODE -ne 0) { throw "openssl pkcs8 失败" }
    & openssl pkcs12 -export -in $pemFull -inkey $keyPem -out $p12 -password pass:android -name platform
    if ($LASTEXITCODE -ne 0) { throw "openssl pkcs12 失败" }
    if (Test-Path $jks) { Remove-Item $jks -Force }
    $keytool = (Get-Command keytool -ErrorAction SilentlyContinue).Source
    if (-not $keytool) {
        $javaHome = (Get-Command java).Source | Split-Path | Split-Path
        $keytool = Join-Path $javaHome "bin\keytool.exe"
    }
    if (-not (Test-Path $keytool)) { throw "未找到 keytool" }
    & $keytool -importkeystore -destkeystore $jks -srckeystore $p12 -srcstoretype PKCS12 -srcstorepass android -deststorepass android -destkeypass android -noprompt
    if ($LASTEXITCODE -ne 0) { throw "keytool importkeystore 失败" }
    return $jks
}

Write-Step "读取配置: $ConfigFile"
if (-not (Test-Path $ConfigFile)) { throw "配置文件不存在: $ConfigFile" }
$config = Read-Config $ConfigFile

$expiryDate = $config["expiry.date"]
if (-not $expiryDate) { throw "app-config.properties 缺少 expiry.date" }
if ($expiryDate -notmatch '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$') {
    throw "expiry.date 格式错误，应为 yyyy-MM-dd HH:mm:ss，当前: $expiryDate"
}

$disableCheck = ($config["disable.expiry.check"] -eq "true")
$removeSharedUserId = if ($null -ne $config["remove.shared.user.id"]) { $config["remove.shared.user.id"] -eq "true" } else { $true }
$signMode = if ($config["sign.mode"]) { $config["sign.mode"] } else { "debug" }
$platformPk8 = $config["platform.pk8"]
$platformPem = $config["platform.x509.pem"]
$versionName = if ($config["version.name"]) { $config["version.name"] } else { "1.2.2-patched" }
$versionCode = if ($config["version.code"]) { $config["version.code"] } else { "10203" }

Write-Host "  expiry.date          = $expiryDate"
Write-Host "  disable.expiry.check = $disableCheck"
Write-Host "  remove.shared.user.id= $removeSharedUserId"
Write-Host "  sign.mode            = $signMode"
Write-Host "  version              = $versionName ($versionCode)"

foreach ($tool in @($ApktoolJar, $SignerJar)) {
    if (-not (Test-Path $tool)) { throw "缺少工具: $tool" }
}
if (-not (Test-Path $BuildDir)) { throw "缺少 apktool 工程: $BuildDir" }
if (-not (Test-Path $SmaliFile)) { throw "缺少 smali 文件: $SmaliFile" }

Write-Step "同步 Java 源码中的 EXPIRY_DATE"
if (Test-Path $JavaConfig) {
    $javaText = Get-Content $JavaConfig -Raw -Encoding UTF8
    $javaText = $javaText -replace 'EXPIRY_DATE = "[^"]*"', "EXPIRY_DATE = `"$expiryDate`""
    $javaText = $javaText -replace 'DISABLE_EXPIRY_CHECK = (true|false|True|False)', "DISABLE_EXPIRY_CHECK = $(if ($disableCheck) { 'true' } else { 'false' })"
    Set-Content -Path $JavaConfig -Value $javaText -Encoding UTF8 -NoNewline
}

Write-Step "补丁 smali 过期日期"
$smali = Get-Content $SmaliFile -Raw -Encoding UTF8
$oldPattern = 'const-string v0, "\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}"'
$newLine = "const-string v0, `"$expiryDate`""
if ($smali -notmatch $oldPattern) {
    throw "smali 中未找到可替换的日期字符串，请检查 $SmaliFile"
}
$smali = [regex]::Replace($smali, $oldPattern, $newLine, 1)
Write-Utf8NoBom -Path $SmaliFile -Content $smali

if ($disableCheck) {
    Write-Step "补丁 smali: 跳过过期检查 (d 方法恒返回 false)"
    # .method public d()Z ... 将过期判断改为直接 return false
    $smali = Get-Content $SmaliFile -Raw -Encoding UTF8
    if ($smali -match '(?s)(\.method public d\(\)Z\s+\.locals \d+\s+)') {
        $replacement = @"
.method public d()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
"@
        $smali = $smali -replace '(?s)\.method public d\(\)Z.*?\.end method', $replacement
        Write-Utf8NoBom -Path $SmaliFile -Content $smali
    } else {
        Write-Warning "未能自动补丁 d() 方法，请手动修改 smali"
    }
}

$manifestFile = Join-Path $BuildDir "AndroidManifest.xml"
if (Test-Path $manifestFile) {
    $manifest = Get-Content $manifestFile -Raw -Encoding UTF8
    if ($removeSharedUserId) {
        Write-Step "Remove sharedUserId from AndroidManifest for debug install"
        $manifest = $manifest -replace '\s*android:sharedUserId="android\.uid\.system"', ''
    } elseif ($manifest -notmatch 'android:sharedUserId="android\.uid\.system"') {
        Write-Step "Restore sharedUserId in AndroidManifest for system install"
        $manifest = $manifest -replace '<manifest xmlns:android="http://schemas.android.com/apk/res/android"', '<manifest xmlns:android="http://schemas.android.com/apk/res/android" android:sharedUserId="android.uid.system"'
    }
    Write-Utf8NoBom -Path $manifestFile -Content $manifest
}

Write-Step "更新 apktool.yml 版本号"
$apktoolYml = Join-Path $BuildDir "apktool.yml"
$yml = Get-Content $apktoolYml -Raw -Encoding UTF8
$yml = $yml -replace 'versionCode: \d+', "versionCode: $versionCode"
$yml = $yml -replace 'versionName: [^\r\n]+', "versionName: $versionName"
Write-Utf8NoBom -Path $apktoolYml -Content $yml

Write-Step "apktool 重打包"
$distDir = Join-Path $OfflineDir "dist"
if (-not (Test-Path $distDir)) { New-Item -ItemType Directory -Path $distDir | Out-Null }
if (Test-Path $DistApk) { Remove-Item $DistApk -Force }
if (Test-Path $SignedApk) { Remove-Item $SignedApk -Force }

& java -jar $ApktoolJar b $BuildDir -o $DistApk
if ($LASTEXITCODE -ne 0) { throw "apktool build 失败" }

Write-Step "签名 APK"
if ($signMode -eq "platform") {
    $signDir = Join-Path $VendorDir "platform-sign"
    $platformJks = Get-PlatformKeystore -Pk8Path $platformPk8 -PemPath $platformPem -OutDir $signDir
    & java -jar $SignerJar -a $DistApk --ks $platformJks --ksAlias platform --ksPass android --ksKeyPass android --allowResign --overwrite
} else {
    & java -jar $SignerJar -a $DistApk --allowResign --overwrite
}
if ($LASTEXITCODE -ne 0) { throw "APK 签名失败" }

$builtApk = Get-ChildItem (Join-Path $distDir "*.apk") | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if (-not $builtApk) { throw "未找到签名后的 APK" }

Write-Step "备份并输出最终 APK"
$backup = Join-Path $OfflineDir "OfflineScriptManager.apk.original"
if ((Test-Path $OutputApk) -and -not (Test-Path $backup)) {
    Copy-Item $OutputApk $backup -Force
    Write-Host "  已备份原 APK -> OfflineScriptManager.apk.original"
}
Copy-Item $builtApk.FullName $OutputApk -Force

Write-Host "`n构建完成!" -ForegroundColor Green
Write-Host "  输出: $OutputApk"
Write-Host "  大小: $([math]::Round((Get-Item $OutputApk).Length / 1MB, 2)) MB"
Write-Host "`n安装命令:"
if ($signMode -eq "platform") {
    Write-Host "  deploy-system-offline-apk.bat"
} else {
    Write-Host "  adb install -r `"$OutputApk`""
}
Write-Host "  adb shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity"
