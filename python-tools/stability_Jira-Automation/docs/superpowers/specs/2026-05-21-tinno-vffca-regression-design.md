# Tinno VFFCA Regression Design

**目标**

在不修改 `Transsion_Jira_Tool_20260323` 的前提下，为 `Tinno_Jira_Tool_20260520` 补齐一套可落地的 `VFFCA` 回归决策与解决/关单能力。核心要求是继续复用 `Transsion` 已验证的回归流程思想，但所有实现落在 Tinno 目录内独立维护，避免影响现网使用中的成熟工具。

**边界**

- 仅对 `Tinno_Jira_Tool_20260520` 动刀，不改 `Transsion_Jira_Tool_20260323`
- 只把 `VFFCA` 作为严格版本比较的正式目标项目
- `VCAME` 只保留实验建单用途，不参与正式版本决策模型
- 本次优先补齐回归决策、`build_version` 落库、`fixVersions` 比较、`Resolve/Close` 流转字段处理
- 暂不处理跨项目通用化、重复单联动关闭、复杂工时策略

## 背景结论

### 1. 为什么不能直接抽公共层

`Transsion` 已在投入使用，任何反向抽象或入口改造都有未知影响。因此当前阶段不做“抽公共模块后让 Transsion 回切”的动作，而是采用“影子复用”：

- `Transsion` 保持只读基线
- `Tinno` 在自身目录内复制并适配成熟逻辑
- 待 `Tinno` 稳定后，再评估是否抽共享核心

### 2. 为什么 `VFFCA` 可做严格版本比较

实时确认结果显示：

- `VCAME` 的 `fixVersions` 当前只有 `P1`，无法可靠表达修复落在哪个具体版本
- `VFFCA` 的 `fixVersions` 是真实版本号，例如 `V552AA-HONOR-LX2-16-260515V25_Daily_user_202605150228_sign`

因此版本比较策略必须按项目区分：

- `VFFCA`：严格比较 `build_version / fix_version / current_version`
- `VCAME`：不进入正式严格比较逻辑

### 3. 当前 Tinno 缺口

当前 `Tinno` 已有：

- `P12 + Cookie` 认证
- 建单入口
- 历史快照导出、SQLite 缓存、基本匹配、最小 dry-run 决策

当前 `Tinno` 仍缺：

- `build_version` 正式落库
- 基于 `VFFCA` 的严格版本判断
- 解决状态下的正确动作决策
- `Resolve Issue / Close Issue` 的字段组装与提交
- “修复后再复现”动作分流

## 核心设计

### 1. 不改 Transsion，本次只做 Tinno 内影子复用

复用对象不是“认证、字段、标题模板”这些 Jira 外围逻辑，而是 `Transsion` 成熟的回归主干：

- 历史快照导出
- 匹配与版本比较
- `status + resolution + version` 决策顺序
- SQLite 状态缓存
- 结果汇总输出

这些逻辑在 Tinno 内继续保留独立副本，按 Tinno 的 Jira 字段、认证、标题模板和流转规则适配。

### 2. `build_version` 作为一等字段落库

`build_version` 定义：历史单最初建单时，对应的“出问题版本”。

`current_version` 定义：本轮回归、复测或再次跑批时，正在验证的版本。

`fix_version` 定义：Jira 历史单中记录的修复版本，来源于 `fixVersions`。

数据落库策略：

- 在 `jira_issue_snapshot` 中新增 `build_version`
- 在 `issue_state` 中新增 `build_version`
- 新建单时，从 Excel 行解析 `build_version` 后写入 `issue_state`
- 历史快照导出时，从 Jira `summary / environment / raw_payload` 反解析 `build_version`
- 老数据首次命中时，若数据库为空，自动回填 `build_version`

这样后续所有决策都不再依赖“临时从标题猜版本”。

### 3. 决策顺序必须先看状态，再看版本

回归验证的核心不是纯版本比较，而是：

1. 先匹配历史单
2. 再看 `status`
3. 再看 `resolution`
4. 最后才用 `build_version / fix_version / current_version` 决定该状态分支是否成立

这部分必须延续 `Transsion` 的成熟逻辑，而不是让版本关系抢到第一优先级。

### 4. `VFFCA` 正式决策模型

#### 4.1 命中 Open-like 状态

状态集合：

- `Open`
- `Reopened`
- `In Progress`
- 其他 Tinno 对应 open-like 状态

动作：

- `OPEN_LIKE_UPDATE`

行为：

- 更新历史单 `summary / description / priority`
- 追加评论
- 可选追加 PS

说明：

这里允许“修改标题”，因为标题要反映当前版本和当前复现场景。

#### 4.2 命中 Won't Fix 类解决结果

解决结果集合：

- `问题不修改`
- `Won't Fix`
- `Won't Do`
- `非问题`

动作：

- `WONT_FIX_KEEP`

行为：

- 不新建
- 不做版本决策推进
- 一般只加评论提醒再次复现

#### 4.3 命中 Closed 类状态

状态集合：

- `Closed`
- `已关闭`
- `已关单`

动作：

- `CLOSED_RECREATE`

行为：

- 重新建单
- 不直接复用原单

#### 4.4 命中 Resolved + 完成

这是严格版本比较真正生效的分支。

前置校验：

- `fix_version` 为空：`MANUAL_REVIEW`
- `build_version` 为空：`MANUAL_REVIEW`
- `current_version` 为空：`MANUAL_REVIEW`
- `fix_version <= build_version`：`MANUAL_REVIEW`
- `current_version < build_version`：`MANUAL_REVIEW`

校验通过后再分流：

- `build_version < current_version < fix_version`
  - 动作：`RESOLVED_FIXED_WAIT_NEW_VERSION`
  - 含义：当前版本还没到修复版本，不能记 PASS，也不应视为“修复后再次复现”

- `current_version >= fix_version` 且本轮再次命中
  - 动作：进入“修复后复现”分支
  - 默认先落为 `MANUAL_REVIEW`
  - 后续如业务确认可自动 reopen，再切到 `REOPEN`

- `current_version >= fix_version` 且本轮未命中
  - 动作：进入 `REGRESSION_PASS` 计数逻辑

### 5. `Resolve Issue / Close Issue` 流转逻辑

实时查询显示，Tinno Jira 对 `VFFCA/VCAME` 风格项目在 `Resolve Issue` 与 `Close Issue` 上要求：

- `resolution` 必填
- `fixVersions` 可填，且对 `VFFCA` 应填真实版本号
- `worklog` 当前为可选
- `customfield_10144 ~ customfield_10147`
- `customfield_10701`
- `customfield_10702`
当前接口返回为可选

因此本次实现策略是：

- `Resolve Issue`
  - 必填 `resolution=完成`
  - 必填 `fixVersions=[真实 fix_version]`
  - 其他字段先按最小空策略，不强制下发

- `Close Issue`
  - 必填 `resolution=完成`
  - 若需要，可继续保留相同 `fixVersions`

`fixVersions` 来源：

- 对 `VFFCA` 直接使用 Jira 项目真实版本允许值
- 运行时用 `transitions.fields` 或项目 versions 结果校验
- 如果目标版本不在允许值中，进入 `MANUAL_REVIEW`

### 6. 回归 PASS 逻辑

仅对满足以下条件的问题进行 PASS 判定：

- 历史单状态为 `Resolved/Closed`
- `resolution=完成`
- `fix_version`、`build_version`、`current_version` 三者关系合法
- 本轮没有再次命中
- `current_version >= fix_version`

PASS 行为：

- 第 1 次：添加 PASS 备注，记录 `verified_versions`
- 达到阈值后：执行 `Close Issue`

如果 `current_version < fix_version`，则不记 PASS。

## 文件设计

### Tinno 入口层

- `Tinno_Jira_Tool_20260520/create_tinno_jira_batch_from_excel.py`
  - 保留 Tinno CLI 与主流程编排
  - 补 `build_version` 生命周期管理
  - 补 `Resolve/Close` 的执行分支
  - 保持 `Transsion` 不受影响

### Tinno 适配层

- `Tinno_Jira_Tool_20260520/tinno_batch_jira_common.py`
  - Tinno Jira 客户端适配
  - 快照字段提取
  - 标题/环境中的版本解析
  - 流转字段辅助函数

- `Tinno_Jira_Tool_20260520/jira_p12_client.py`
  - 保持 Tinno 认证与 REST 请求封装
  - 如需，补充 transitions / versions 相关细节支持

### Tinno 回归逻辑层

- `Tinno_Jira_Tool_20260520/tinno_regression_executor.py`
  - 继续承载动作决策
  - 增加 `build_version` 参与的决策判断

- `Tinno_Jira_Tool_20260520/tinno_regression_store.py`
  - 新增 `build_version` 持久化字段
  - 增加旧数据自动回填支持

### 测试层

- `Tinno_Jira_Tool_20260520/test/test_tinno_regression_entry.py`
  - 扩版本状态与决策覆盖

- 可能新增：
  - `test_tinno_regression_executor.py`
  - `test_tinno_regression_store.py`
  - `test_tinno_resolve_transition.py`

## 错误处理

- `fix_version` 为空：不自动推进解决后逻辑
- `build_version` 解析失败：不自动推进解决后逻辑
- `current_version` 为空：不自动推进解决后逻辑
- `fix_version` 不在 Jira 允许值中：不自动 resolve/close
- 流转字段检查失败：返回 `MANUAL_REVIEW`
- 流转 API 失败：保留 execution result 与 Excel summary，标记失败原因

## 验证策略

### 单元验证

- 版本解析
- `build_version` 落库与旧数据回填
- `status + resolution + version` 组合决策
- `Resolve/Close` 字段组装

### 联调验证

- `VFFCA` dry-run
  - 验证快照导出
  - 验证严格版本比较
  - 验证命中历史单后的动作输出

- 独立 regression verify dry-run
  - 验证 PASS 候选筛选
  - 验证 `current_version >= fix_version` 门槛

### 风险控制

- 不修改 `Transsion` 代码
- 先 dry-run，再考虑真实写入
- 真实写入只针对 `Tinno` 目标项目验证

## 不做的事

- 不抽公共核心给 `Transsion` 回切
- 不把 `VCAME/P1` 混入正式严格版本策略
- 不在本轮引入重复单联动关闭
- 不在本轮强制下发复杂工时/根因模板

## 结论

当前最稳的方案不是改造 `Transsion`，也不是仅靠标题模板/认证差异去硬迁移，而是：

- 保持 `Transsion` 只读稳定
- 在 `Tinno` 内复用成熟回归主干
- 以 `VFFCA` 为正式严格版本比较项目
- 让 `build_version` 成为数据库中的一等字段
- 用“状态优先、版本校验随后”的顺序来恢复回归验证的真实核心

