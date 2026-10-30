$ErrorActionPreference = 'Continue'
Get-Process MSBuild, cl, link, signtool -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

$env:DOTNET_ROOT = 'C:\Program Files\dotnet'
$env:DOTNET_MSBUILD_SDK_RESOLVER_CLI_DIR = 'C:\Program Files\dotnet'
$env:MSBuildSDKsPath = 'C:\Program Files\dotnet\sdk\10.0.402\Sdks'
$pwshDir = 'C:\Program Files\WindowsApps\Microsoft.PowerShell_7.6.7.0_x64__8wekyb3d8bbwe'
$amd64Msbuild = 'D:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\amd64'
$env:Path = "C:\Program Files\dotnet;$pwshDir;$amd64Msbuild;$env:LOCALAPPDATA\Microsoft\WindowsApps;" + $env:Path

$root = 'D:\Tinno_auto\automation-toolkit\windows-tools\system_mouse_without_borders'
$log = Join-Path $root 'build-installer.log'
Remove-Item $log -Force -ErrorAction SilentlyContinue

Set-Location (Join-Path $root 'PowerToys')
& '.\tools\build\build-installer.ps1' -Platform x64 -Configuration Release -PerUser true -Force -SkipBuild *>&1 |
    Tee-Object -FilePath $log
Write-Host "EXIT=$LASTEXITCODE"
exit $LASTEXITCODE
