.PHONY: help list install install-python install-android build-android test clean

# 默认目标
help:
	@echo "Automation Toolkit - 常用命令"
	@echo ""
	@echo "工具列表:"
	@echo "  make list              - 列出所有工具"
	@echo ""
	@echo "安装:"
	@echo "  make install           - 安装所有工具依赖"
	@echo "  make install-python    - 安装 Python 工具依赖"
	@echo ""
	@echo "运行:"
	@echo "  make run-perf-filler   - 运行 Performance Excel Filler"
	@echo ""
	@echo "其他:"
	@echo "  make clean             - 清理临时文件"
	@echo "  make test              - 运行测试"

# 列出所有工具
list:
	@echo "Python 工具:"
	@echo "  - performance-excel-filler: SMT 性能测试结果自动填充"
	@echo ""
	@echo "Android 工具:"
	@echo "  (暂无)"
	@echo ""
	@echo "Java 平台:"
	@echo "  (暂无)"

# 安装所有工具依赖
install: install-python

# 安装 Python 工具依赖
install-python:
	@echo "安装 Python 工具依赖..."
	@if [ -f "python-tools/performance-excel-filler/requirements.txt" ]; then \
		pip install -r python-tools/performance-excel-filler/requirements.txt; \
	fi

# 运行 Performance Excel Filler
run-perf-filler:
	@cd python-tools/performance-excel-filler && python main.py

# 清理临时文件
clean:
	@echo "清理临时文件..."
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type f -name "*.log" -delete 2>/dev/null || true

# 运行测试
test:
	@echo "运行测试..."
	@cd python-tools/performance-excel-filler && python -m pytest || true
