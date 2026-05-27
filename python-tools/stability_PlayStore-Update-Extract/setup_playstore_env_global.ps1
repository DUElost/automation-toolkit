Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Get-Location).Path
$PlaystoreApiCommit = "4f84862e0a0d8668aff32204472ea282675c9793"

Write-Host ""
Write-Host "================ Install Dependencies ================" -ForegroundColor Cyan

try {
    python -m pip uninstall -y playstoreapi | Out-Null
} catch {
}

python -m pip install `
    "git+https://github.com/ABhiTheModder/playstoreapi@$PlaystoreApiCommit" `
    "requests==2.33.1" `
    "urllib3==2.6.3" `
    "protobuf==7.34.1"

$PkgDir = (python -c "import pathlib, playstoreapi; print(pathlib.Path(playstoreapi.__file__).resolve().parent)").Trim()
if (-not $PkgDir) {
    throw "Failed to locate playstoreapi package directory"
}
$Pb2File = Join-Path $PkgDir "googleplay_pb2.py"

if (-not (Test-Path $Pb2File)) {
    Write-Host ""
    Write-Host "================ Generate googleplay_pb2.py ================" -ForegroundColor Cyan

    $TmpDir = Join-Path $env:TEMP ("playstoreapi_fix_" + [guid]::NewGuid().ToString("N"))
    $ProtocExe = (Get-Command protoc -ErrorAction SilentlyContinue).Source

    if (-not $ProtocExe) {
        throw "protoc.exe not found in PATH"
    }

    try {
        git clone --filter=blob:none https://github.com/ABhiTheModder/playstoreapi $TmpDir | Out-Null
        git -C $TmpDir checkout $PlaystoreApiCommit | Out-Null

        & $ProtocExe `
            -I $TmpDir `
            --python_out=$PkgDir `
            (Join-Path $TmpDir "googleplay.proto")

        if (-not (Test-Path $Pb2File)) {
            throw "googleplay_pb2.py generation failed"
        }
    } finally {
        if (Test-Path $TmpDir) {
            Remove-Item -Recurse -Force $TmpDir
        }
    }
}

Write-Host ""
Write-Host "================ Dependency Check ================" -ForegroundColor Cyan
python -m pip show playstoreapi
python -m pip freeze | Select-String -Pattern "playstoreapi|requests|urllib3|protobuf"

Write-Host ""
Write-Host "================ File Check ================" -ForegroundColor Cyan
python -c "import playstoreapi.googleplay as g, pathlib, hashlib; p=pathlib.Path(g.__file__); print('googleplay.py =', p); print('sha256 =', hashlib.sha256(p.read_bytes()).hexdigest())"
python -c "import pathlib, playstoreapi; p=pathlib.Path(playstoreapi.__file__).resolve().parent / 'googleplay_pb2.py'; print('googleplay_pb2.py =', p, 'exists =', p.exists())"

Write-Host ""
Write-Host "================ Anonymous Auth Check ================" -ForegroundColor Cyan
python -c "from playstoreapi.googleplay import GooglePlayAPI; api=GooglePlayAPI('en_US','America/New_York'); api.ssl_verify=True; api.login(anonymous=True); print('Anonymous auth OK, GSF ID =', api.gsfId)"

$Downloader = Join-Path $ProjectRoot "playstore_downloader.py"
if (Test-Path $Downloader) {
    Write-Host ""
    Write-Host "================ Downloader Check ================" -ForegroundColor Cyan
    python $Downloader "com.android.chrome" "--dry-run"
}

Write-Host ""
Write-Host "System Python environment setup and verification completed." -ForegroundColor Green
