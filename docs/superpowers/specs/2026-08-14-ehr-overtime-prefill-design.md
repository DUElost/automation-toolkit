# EHR 加班申请（预填不提交）— 设计说明

日期：2026-08-14  
状态：已确认  
范围：`python-tools/universal_Skill_task`  
前置：

- `docs/superpowers/specs/2026-08-12-bpm-ehr-login-design.md`（BPM 登录 → 门户 → EHR）
- `docs/superpowers/specs/2026-08-14-ehr-overtime-dry-run-design.md`（只读决策）

## 目标

本阶段在 dry-run 决策之上，验证「打开加班申请并预填」可行性，**禁止**在 EHR 中提交/保存加班申请。

成功标准：

1. 复用现有登录、导航、考勤/加班查询读取与决策引擎
2. 仅当 `action=APPLY` 时进入「加班申请」并预填表单
3. 预填：加班类别（平日/周末）、开始日期时间、结束日期时间、事由「待确认」
4. 全程不点击提交/保存/送审类按钮；`ALLOW_SUBMIT_OVERTIME` 保持 `False`
5. 预填完成后浏览器保持打开，终端等待用户按 Enter 再退出
6. `SKIP_*` 只写决策日志，不进入申请页

## 决策

| 项 | 选择 |
|----|------|
| 架构 | 独立入口 + 独立填表模块（方案 2） |
| 触发 | 仅 `APPLY` 才打开并预填 |
| 事由 | 固定「待确认」 |
| 加班类别 | 平日 →「平日加班」；周末 →「周末加班」 |
| 提交 | 硬禁止；入口若发现 `ALLOW_SUBMIT_OVERTIME=True` 则拒绝启动 |
| 核对 | 填完后 `input()` 等待 Enter；另存预填截图到 `artifacts/` |
| 时数字段 | 不填（系统自动；跨午休由系统减时） |

## 模块结构

```text
python-tools/universal_Skill_task/
├── ehr_overtime_apply.py       # 打开加班申请 + 按 Decision 预填（无提交）
├── main_overtime_prefill.py    # 新入口：决策后按需预填
├── ehr_nav.py                  # 增补 open_overtime_apply()（经首页）
└── （复用）overtime_rules / overtime_decision / ehr_attendance /
            ehr_overtime_query / bpm_login / navigate_ehr / cert_dialog / browser / config
```

`main_overtime_dry_run.py` 保持只读，本阶段不改其行为。

## 流程

1. 加载配置 → 登录 BPM → 打开 EHR → 等首页就绪
2. 首页 → 我的考勤 → 读目标日（北京时间昨天）打卡
3. 首页 → 加班查询 → 读目标日已有申请
4. `build_decision` → 控制台 + `artifacts/overtime_decision_YYYYMMDD_HHMMSS.log`
5. 若非 `APPLY`：说明原因；等待 Enter 后退出（可不进申请页）
6. 若 `APPLY`：首页 → 加班申请 → 定位控件 → 填类别 / 起止 / 事由
7. 截图 `artifacts/overtime_prefill_YYYYMMDD_HHMMSS.png`，提示人工核对
8. 终端 `input()` 等待 Enter → 关闭浏览器

## 导航约定

与 dry-run 相同：EHR 内跳转必须先点「首页」，再点目标入口。禁止 `page.go_back()`。

新增入口文案：「加班申请」（经首页快捷方式）。

## 安全硬约束

- `ALLOW_SUBMIT_OVERTIME = False`；`main_overtime_prefill` 启动时校验，为 `True` 则立即退出
- `ehr_overtime_apply` 不实现任何 submit/save 函数
- 白名单点击：仅「首页」「加班申请」及填表所需的非提交控件（下拉、日期格等）
- 黑名单：提交、保存、确定、送审、同意提交等文案/选择器一律禁止点击
- 找不到控件或填写失败：截图并抛错，不得尝试提交

表单 DOM 以实现时只读探针为准；选择器集中在 `ehr_overtime_apply.py`。

## Decision 与预填映射

| Decision 字段 | 表单 |
|---------------|------|
| `day_kind=weekday` | 加班类别 = 平日加班 |
| `day_kind=weekend` | 加班类别 = 周末加班 |
| `target_date` + `proposed_start` | 开始日期、开始时间 |
| `target_date` + `proposed_end` | 结束日期、结束时间（同日；本阶段不处理跨日） |
| （固定） | 事由 = 待确认 |

日期展示格式以实现时 EHR 控件为准（探针已见考勤侧为 `DD/MM/YYYY`）。

## 非目标

- 真实提交 / 保存 / 送审
- 打开或绕过 `ALLOW_SUBMIT_OVERTIME`
- 自动处理 `SKIP_DIFF_MANUAL`
- 跨午夜打卡、多段拆单、补卡、节日加班专用路径
- 修改 dry-run 入口语义

## 测试策略

- 现有规则与决策单测继续通过
- 新增：提交类文案黑名单测试（确保不允许列表含提交意图）
- 实机：先探针「加班申请」页字段，再固化选择器；至少一次昨日 `APPLY` 预填人工核对

## 风险与假设

- 加班申请页可能在 iframe 内；读写需覆盖 frames
- 日期控件可能是 My97DatePicker，填写方式以实现时探针为准（直接填 input 或点选）
- 证书弹窗继续用现有 `cert_dialog`
- 公司站点可能仅内网可达
