# EHR 加班申请（只读决策）— 设计说明

日期：2026-08-14  
状态：已确认  
范围：`python-tools/universal_Skill_task`  
前置：`docs/superpowers/specs/2026-08-12-bpm-ehr-login-design.md`（BPM 登录 → 门户 → EHR）

## 目标

本阶段验证「只读采集 + 决策日志」可行性，**禁止**在 EHR 中提交加班申请。

成功标准：

1. 使用北京时间确定目标日 = 昨天
2. 在 EHR「我的考勤」读取目标日打卡记录
3. 在 EHR「加班查询」读取目标日已有加班申请
4. 按已确认规则计算是否申请及起止时间
5. 将完整决策输出到控制台与日志文件
6. 全程不点击加班申请的提交/保存类按钮

## 决策

| 项 | 选择 |
|----|------|
| 架构 | 决策引擎与 UI 只读分离（方案 1） |
| 时区 | `Asia/Shanghai`（北京时间） |
| 目标日 | 运行时刻的「昨天」 |
| 提交 | 硬禁止：`ALLOW_SUBMIT_OVERTIME=False`（默认且本阶段不可打开） |
| 事由 | 日志固定写「待确认」 |
| 与已有申请 | 一致则跳过；不一致则 `SKIP_DIFF_MANUAL`，仍不提交 |

## 模块结构

```text
python-tools/universal_Skill_task/
├── overtime_rules.py           # 纯函数：取整、平日/周末、比对
├── ehr_nav.py                  # 仅经「首页」跳转
├── ehr_attendance.py           # 读我的考勤
├── ehr_overtime_query.py       # 读加班查询
├── overtime_decision.py        # 组装 Decision
├── main_overtime_dry_run.py    # 只读入口
└── tests/test_overtime_rules.py
```

复用现有：`config` / `browser` / `bpm_login` / `navigate_ehr` / `cert_dialog`。

## 导航约定（EHR）

系统无可靠「返回」。页面间跳转必须：

1. 点击顶栏 **首页**
2. 再点目标入口（我的考勤 / 加班查询）

禁止 `page.go_back()`。

数据位置约定（人工确认）：

- 我的考勤：**底部**为最新
- 加班查询：**顶部**为最新

## 规则（已确认示例）

### 取整

- **结束时间（向下半小时）**：分钟 &lt; 30 → `HH:00`；分钟 ≥ 30 → `HH:30`
- **周末开始时间（向上半小时）**：已在 `:00`/`:30` 不变；`01–29` → 该小时 `:30`；`31–59` → 下一小时 `:00`

### 平日

- 开始固定 `19:00`
- 结束 = 最晚打卡向下取半小时
- 最晚打卡 &lt; 19:00，或取整后结束 ≤ 开始 → `SKIP_NO_NEED`（不申请）

### 周末

- 开始 = 最早打卡向上取半小时
- 结束 = 最晚打卡向下取半小时
- 若结束落在 `[18:00, 19:00)` → 强制 `18:00`
- 若开始 &lt; 18:00 且结束 &gt; 19:00（跨过 18:00–19:00）→ 结束再减 1 小时

### 系统行为（只记日志）

- 时段跨 `12:00–13:00` 时，系统自动减 1 小时时数；脚本不填时数字段

### 与已有申请比对

- 无记录且应申请 → `APPLY`（本阶段仅日志）
- 有记录且起止一致 → `SKIP_ALREADY_SAME`
- 有记录但起止不一致 → `SKIP_DIFF_MANUAL`

## Decision 日志字段

```text
target_date=YYYY-MM-DD (weekday|weekend)
punches=[...]
existing=[...] | none
action=APPLY | SKIP_NO_NEED | SKIP_ALREADY_SAME | SKIP_DIFF_MANUAL
proposed_start=HH:MM | none
proposed_end=HH:MM | none
reason=待确认
notes=...
```

输出位置：控制台 + `artifacts/overtime_decision_YYYYMMDD_HHMMSS.log`

## 流程

1. 加载配置并登录 BPM，进入 EHR
2. 首页 → 我的考勤 → 解析目标日打卡
3. 首页 → 加班查询 → 解析目标日已有申请
4. `decide_overtime(...)` 计算 Decision
5. 写日志；浏览器可短时保持打开便于肉眼核对
6. 退出（不进入加班申请提交页）

可选（默认关闭）：只读打开「加班申请」页，截取表单字段名写入日志，仍禁止提交。

## 非目标

- 真实提交/保存加班申请
- 自动处理 `SKIP_DIFF_MANUAL`
- 跨午夜打卡、补卡、多段拆单
- 打开 `ALLOW_SUBMIT_OVERTIME` 后的写路径（需另开需求并明确批准）

## 风险与假设

- 考勤/加班查询表格 DOM 以实现时探针为准；选择器集中在对应模块
- 打卡可能多条；平日用最晚、周末用最早+最晚
- 证书弹窗继续用现有 `cert_dialog` 自动确认
- 公司站点可能仅内网可达
