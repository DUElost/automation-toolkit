# Automation Toolkit - Windows PowerShell 脚本

param(
    [Parameter(Position=0)]
    [ValidateSet("help", "list", "install", "install-python", "run-perf-filler", "clean", "test")]
    [string]$Command = "help"
)

$ErrorActionPreference = "Stop"

function Show-Help {
    Write-Host "Automation Toolkit - 常用命令" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "工具列表:"
    Write-Host "  .\toolkit.ps1 list              - 列出所有工具"
    Write-Host ""
    Write-Host "安装:"
    Write-Host "  .\toolkit.ps1 install           - 安装所有工具依赖"
    Write-Host "  .\toolkit.ps1 install-python    - 安装 Python 工具依赖"
    Write-Host ""
    Write-Host "运行:"
    Write-Host "  .\toolkit.ps1 run-perf-filler   - 运行 Performance Excel Filler"
    Write-Host ""
    Write-Host "其他:"
    Write-Host "  .\toolkit.ps1 clean             - 清理临时文件"
    Write-Host "  .\toolkit.ps1 test              - 运行测试"
    Write-Host ""
    Write-Host "示例:"
    Write-Host "  .\toolkit.ps1 run-perf-filler"
}

function Show-List {
    Write-Host "Python 工具:" -ForegroundColor Yellow
    Write-Host "  - performance-excel-filler: SMT 性能测试结果自动填充"
    Write-Host ""
    Write-Host "Android 工具:" -ForegroundColor Yellow
    Write-Host "  (暂无)"
    Write-Host ""
    Write-Host "Java 平台:" -ForegroundColor Yellow
    Write-Host "  (暂无)"
}

function Install-PythonTools {
    Write-Host "安装 Python 工具依赖..." -ForegroundColor Green
    $reqFile = "python-tools\performance-excel-filler\requirements.txt"
    if (Test-Path $reqFile) {
        pip install -r $reqFile
    } else {
        Write-Host "未找到 requirements.txt" -ForegroundColor Yellow
    }
}

function Run-PerfFiller {
    Write-Host "运行 Performance Excel Filler..." -ForegroundColor Green
    Set-Location "python-tools\performance-excel-filler"
    python main.py
    Set-Location "..\..\"
}

function Clean-TempFiles {
    Write-Host "清理临时文件..." -ForegroundColor Green
    Get-ChildItem -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Recurse -File -Filter "*.pyc" | Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Recurse -File -Filter "*.log" | Remove-Item -Force -ErrorAction SilentlyContinue
    Write-Host "清理完成" -ForegroundColor Green
}

function Run-Tests {
    Write-Host "运行测试..." -ForegroundColor Green
    Set-Location "python-tools\performance-excel-filler"
    try {
        python -m pytest
    } catch {
        Write-Host "测试跳过 (pytest 未安装或无测试文件)" -ForegroundColor Yellow
    }
    Set-Location "..\..\"
}

# 执行命令
switch ($Command) {
    "help" { Show-Help }
    "list" { Show-List }
    "install" { Install-PythonTools }
    "install-python" { Install-PythonTools }
    "run-perf-filler" { Run-PerfFiller }
    "clean" { Clean-TempFiles }
    "test" { Run-Tests }
}
