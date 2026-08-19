#Requires -Version 5.1
<#
.SYNOPSIS
    从 ATTS 工程编译并 platform 签名 AutoTestTool.apk，输出到 stability_PowerCycle-Test/apk/
#>
param(
    [string]$ConfigFile = (Join-Path $PSScriptRoot "app-config.properties")
)

$ErrorActionPreference = "Stop"
$ManagerDir = $PSScriptRoot
$AndroidToolsRoot = Split-Path $ManagerDir -Parent
$VendorDir = Join-Path $AndroidToolsRoot "vendor"
$TestApkDir = Join-Path $AndroidToolsRoot "stability_PowerCycle-Test\apk"
$OutputApk = Join-Path $TestApkDir "AutoTestTool.apk"
$SignerJar = Join-Path $VendorDir "uber-apk-signer.jar"
$DistDir = Join-Path $ManagerDir "dist"

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

function Resolve-BuildJavaHome {
    param([string]$ConfiguredHome)

    if ($ConfiguredHome -and (Test-Path (Join-Path $ConfiguredHome "bin\java.exe"))) {
        return (Resolve-Path $ConfiguredHome).Path
    }

    $candidates = @(
        $env:JAVA_HOME,
        $env:JDK_HOME,
        "D:\Program Files\Android\Android Studio\jbr",
        "C:\Program Files\Android\Android Studio\jbr",
        "$env:LOCALAPPDATA\Programs\Android Studio\jbr",
        "D:\Android\Android Studio\jbr"
    ) | Where-Object { $_ }

    foreach ($candidateHome in $candidates) {
        $javaExe = Join-Path $candidateHome "bin\java.exe"
        if (-not (Test-Path $javaExe)) { continue }
        $verText = cmd /c "`"$javaExe`" -version 2>&1"
        if ($verText -match 'version "1\.8' -or $verText -match 'version "8\.') { continue }
        return (Resolve-Path $candidateHome).Path
    }

    throw @"
未找到 Java 11+。当前 PATH 可能是 Java 8，ATTS/AGP 8.5 无法使用。

请在 app-config.properties 设置:
  java.home=D:\Program Files\Android\Android Studio\jbr

或临时执行:
  set JAVA_HOME=D:\Program Files\Android\Android Studio\jbr
  build-powercycle-apk.bat
"@
}

function Use-BuildJava {
    param([string]$JavaHome)
    $env:JAVA_HOME = $JavaHome
    $env:JDK_HOME = $JavaHome
    $env:PATH = (Join-Path $JavaHome "bin") + ";" + $env:PATH
    $ver = cmd /c "`"$(Join-Path $JavaHome 'bin\java.exe')`" -version 2>&1" | Select-Object -First 1
    Write-Host "  JAVA_HOME = $JavaHome"
    Write-Host "  $ver"
}

function Get-PlatformKeystore {
    param([string]$Pk8Path, [string]$PemPath, [string]$OutDir)
    if (-not (Test-Path $Pk8Path)) { throw "platform.pk8 不存在: $Pk8Path" }
    if (-not (Test-Path $PemPath)) { throw "platform.x509.pem 不存在: $PemPath" }
    if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }
    $keyPem = Join-Path $OutDir "platform_key.pem"
    $p12 = Join-Path $OutDir "platform.p12"
    $jks = Join-Path $OutDir "platform.jks"
    & openssl pkcs8 -inform DER -nocrypt -in $Pk8Path -out $keyPem
    if ($LASTEXITCODE -ne 0) { throw "openssl pkcs8 失败" }
    & openssl pkcs12 -export -in $PemPath -inkey $keyPem -out $p12 -password pass:android -name platform
    if ($LASTEXITCODE -ne 0) { throw "openssl pkcs12 失败" }
    if (Test-Path $jks) { Remove-Item $jks -Force }
    $keytool = (Get-Command keytool -ErrorAction SilentlyContinue).Source
    if (-not $keytool) {
        $javaHome = (Get-Command java).Source | Split-Path | Split-Path
        $keytool = Join-Path $javaHome "bin\keytool.exe"
    }
    & $keytool -importkeystore -destkeystore $jks -srckeystore $p12 -srcstoretype PKCS12 -srcstorepass android -deststorepass android -destkeypass android -noprompt
    if ($LASTEXITCODE -ne 0) { throw "keytool importkeystore 失败" }
    return $jks
}

$config = Read-Config $ConfigFile
$attsDir = $config["atts.project.dir"]
$javaHome = Resolve-BuildJavaHome -ConfiguredHome $config["java.home"]
$variant = if ($config["build.variant"]) { $config["build.variant"] } else { "debug" }
$abi = if ($config["target.abi"]) { $config["target.abi"] } else { "arm64-v8a" }
$signMode = if ($config["sign.mode"]) { $config["sign.mode"] } else { "platform" }
$platformPk8 = $config["platform.pk8"]
$platformPem = $config["platform.x509.pem"]

if (-not (Test-Path $attsDir)) { throw "ATTS 工程不存在: $attsDir" }
if (-not (Test-Path $SignerJar)) { throw "缺少签名工具: $SignerJar" }

Write-Step "选择构建 JDK"
Use-BuildJava -JavaHome $javaHome

Write-Step "Gradle assemble$($variant.Substring(0,1).ToUpper() + $variant.Substring(1)) @ $attsDir"
Push-Location $attsDir
try {
    if (Test-Path ".\gradlew.bat") {
        & .\gradlew.bat "assemble$($variant.Substring(0,1).ToUpper() + $variant.Substring(1))" --no-daemon
    } else {
        & gradle "assemble$($variant.Substring(0,1).ToUpper() + $variant.Substring(1))"
    }
    if ($LASTEXITCODE -ne 0) { throw "Gradle 构建失败" }
} finally {
    Pop-Location
}

$builtApk = Join-Path $attsDir "app\build\outputs\apk\$variant\app-$abi-$variant.apk"
if (-not (Test-Path $builtApk)) {
    $builtApk = Join-Path $attsDir "app\build\outputs\apk\$variant\app-$variant.apk"
}
if (-not (Test-Path $builtApk)) { throw "未找到构建产物，请检查 ABI/variant: $builtApk" }

Write-Step "签名 APK ($signMode)"
if (-not (Test-Path $DistDir)) { New-Item -ItemType Directory -Path $DistDir | Out-Null }
$unsigned = Join-Path $DistDir "AutoTestTool-unsigned.apk"
Copy-Item $builtApk $unsigned -Force

if ($signMode -eq "platform") {
    $signDir = Join-Path $VendorDir "platform-sign"
    $platformJks = Get-PlatformKeystore -Pk8Path $platformPk8 -PemPath $platformPem -OutDir $signDir
    & java -jar $SignerJar -a $unsigned --ks $platformJks --ksAlias platform --ksPass android --ksKeyPass android --allowResign --overwrite
} else {
    & java -jar $SignerJar -a $unsigned --allowResign --overwrite
}
if ($LASTEXITCODE -ne 0) { throw "APK 签名失败" }

$signed = Get-ChildItem (Join-Path $DistDir "*.apk") | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if (-not $signed) { throw "未找到签名 APK" }

if (-not (Test-Path $TestApkDir)) { New-Item -ItemType Directory -Path $TestApkDir | Out-Null }
Copy-Item $signed.FullName $OutputApk -Force

Write-Host "`n构建完成!" -ForegroundColor Green
Write-Host "  输出: $OutputApk"
Write-Host "  大小: $([math]::Round((Get-Item $OutputApk).Length / 1MB, 2)) MB"
Write-Host "`n下一步: cd stability_PowerCycle-Test\scripts && deploy.bat"
