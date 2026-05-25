# stability_Start-Log-Scan 离线 org Excel 去重设计

## 背景

`python-tools/stability_Start-Log-Scan` 现有能力是在扫描日志时同时生成两份 AEE 结果：

- 原始结果：`*_org.xls`
- 去重结果：`*.xls`

当前需求不是修改扫描流程，而是新增一个离线入口，对已经生成的 `*_org.xls` 文件再次执行去重，并输出新的去重结果文件。

## 目标

新增一个单文件离线去重能力，满足以下要求：

- 只处理本工具生成的 AEE `*_org.xls`
- 不改动现有扫描、解压、分析、导出链路
- 去重规则必须与扫描期 AEE 去重规则保持一致
- 默认按 `shanghai` 规则执行
- 输出文件名基于输入文件名追加 `_dedup_org` 与时间戳

## 非目标

- 不支持 TNE org Excel
- 不支持修改现有扫描流程生成的原始结果和去重结果
- 不新增第二套独立去重算法
- 不开放额外的相似度、白名单、黑名单命令行参数

## 现状

现有代码已经具备离线去重所需的两个关键基础能力：

1. `modules/common/Excel.py` 中的 `read_aee_rlt_excel()` 可将 `_org.xls` 读取为 `AeeExcelData` 列表
2. `modules/mode/BaseScan.py` 中的 `_aee_to_data_list()` 已实现 AEE 过滤与去重逻辑

因此本次实现应复用现有能力，而不是重写去重算法。

## 方案选择

本次采用在主入口增加独立命令参数的方案。

### 方案

在 `start_log_scan.py` 中新增 `-dedup_org` 参数，进入离线 org Excel 去重模式。

### 不采用的方案

- 复用 `-merge`
  - 语义不准确，`merge` 代表多文件合并，不适合作为单文件离线去重入口
- 新增独立脚本
  - 入口分散，不利于维护和使用

## 命令设计

### 命令形式

```bash
python start_log_scan.py -dedup_org "F:\path\Result_xxx_org.xls"
python start_log_scan.py -dedup_org "F:\path\Result_xxx_org.xls" -side factory
```

### 参数规则

- `-dedup_org`
  - 必填
  - 值为单个 AEE `*_org.xls` 文件路径
- `-side`
  - 可选
  - 仅支持 `shanghai` / `factory`
  - 默认值为 `shanghai`

## 配置设计

离线去重模式仅保留对结果有直接影响的配置映射。

### side 到配置的映射

- `shanghai`
  - `scan_type=shanghai`
  - `pkglist_file=pkglist.txt`
- `factory`
  - `scan_type=factory`
  - `pkglist_file=pkglist_factory.txt`

### 复用现有默认配置

以下配置不新增命令行参数，直接沿用现有默认值或本地配置：

- `ratio_std_aee`
- `ignore_pkglist`
- `blacklist.txt`
- `report_history.txt`

这样可以保证离线去重与扫描期去重规则一致，避免结果漂移。

## 核心流程

### 处理流程

1. 解析命令行参数
2. 若传入 `-dedup_org`，优先进入离线去重模式
3. 校验输入文件
4. 初始化最小去重上下文
5. 读取 `_org.xls`
6. 复用 `_aee_to_data_list()` 执行过滤与去重
7. 生成新的去重结果 Excel
8. 打印输出路径并退出

### 输入校验

必须同时满足以下条件：

- 文件存在
- 扩展名为 `.xls`
- 文件名包含 `_org`

任一条件不满足时直接报错退出，不做自动修正。

## 代码结构设计

### 入口改动

修改文件：

- `python-tools/stability_Start-Log-Scan/start_log_scan.py`

改动内容：

- 新增 `-dedup_org` 参数
- 在参数解析后优先判断是否进入离线去重模式
- 调用新的离线去重执行类

### 新增执行类

新增文件建议：

- `python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py`

职责：

- 接收输入文件路径与 `side`
- 初始化离线去重所需的最小上下文
- 调用 Excel 读取逻辑
- 调用 AEE 去重逻辑
- 导出去重后的 Excel

## 复用策略

### 必须复用的现有能力

- `modules/common/Excel.py::read_aee_rlt_excel()`
- `modules/common/Excel.py::Excel.insertResultAee(..., deduplicated=True)`
- `modules/mode/BaseScan.py::_aee_to_data_list()`

### 为什么必须复用

`_aee_to_data_list()` 不只是字符串相似度比较，还包含：

- 白名单过滤
- `factory` 规则分支
- `data_app` / transsion 特殊处理
- 无效问题过滤
- 设备数聚合

如果重写离线去重逻辑，结果会与扫描期规则不一致。

## 输出设计

### 输出目录

- 与输入文件同目录

### 输出命名

输入：

- `Result_xxx_org.xls`

输出：

- `Result_xxx_org_dedup_org_YYYYMMDD_HHMMSS.xls`

### 命名规则说明

- 不覆盖原始 `_org.xls`
- 不与扫描流程生成的标准去重结果 `*.xls` 混淆
- 文件名包含时间戳，避免重复执行时冲突

## 实现细节

### BaseScan 复用方式

离线执行类可以继承 `BaseScan`，但不能调用 `start_scan()`，因为该方法会触发扫描目录、解压、分析日志等无关流程。

建议方式：

1. 构造离线执行对象
2. 手动调用环境与配置初始化方法
3. 根据 `side` 覆盖 `scan_type` 与 `pkglist_file`
4. 手动加载 `pkglist`、`blacklist`、`report_history`
5. 调用 `_aee_to_data_list()`

### 输出内容

离线模式只输出去重后的结果 Excel，不重新生成原始 org Excel。

## 错误处理

关键路径必须有错误处理，至少覆盖以下场景：

- 输入文件不存在
- 输入文件不是 `.xls`
- 输入文件名不包含 `_org`
- Excel 打开失败
- Excel 内容为空
- 去重后结果为空
- 输出文件写入失败

对于“去重后结果为空”的情况，仍应生成空结果或明确日志提示，避免用户误判为程序未执行。

## 测试建议

至少验证以下场景：

1. 正常输入一个标准 `_org.xls`，能生成 `*_dedup_org_时间戳.xls`
2. `-side` 不传时默认使用 `shanghai`
3. `-side factory` 时能走 `factory` 规则
4. 输入路径不存在时直接失败
5. 输入文件名不含 `_org` 时直接失败
6. 对已经无重复的 `_org.xls` 执行时，结果仍可正常输出
7. 对包含 `DeviceId` 的 org 文件执行后，输出列为 `DeviceCount`

## 风险与边界

### 风险

1. `BaseScan` 初始化对字段依赖较多
   - 实现时必须保证离线模式把必要字段准备完整
2. 历史 org 文件表头可能不完全一致
   - 需要依赖 `read_aee_rlt_excel()` 当前的兼容逻辑

### 边界

- 本次只支持 AEE org Excel
- 本次不改动扫描模式、去重规则与已有结果文件命名
- 本次不扩展到批量目录处理

## 结论

本需求应通过新增 `-dedup_org` 离线入口实现，复用现有 AEE Excel 读取与去重逻辑，在不改动扫描流程的前提下，为已有 `_org.xls` 提供稳定、可复现的离线去重能力。
