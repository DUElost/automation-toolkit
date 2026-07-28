# 魔学院扫码启动与预先登录 — 设计说明

日期：2026-07-29  
状态：已确认  
范围：`python-tools/universal_Skill`

## 目标

1. 支持从答题入口**二维码图片**解码 URL，启动 `login` / `fill`
2. 支持**预先登录认证**（`login --qr` 保存 `storage_state.json`）
3. `fill --qr`：有登录态则直接填；无/失效则先引导登录再填

## 决策

| 项 | 选择 |
|----|------|
| 用法 | 两阶段 + 缺态兜底（方案 C） |
| 入口域名 | 以二维码 URL 为准（`tinno.m.moxueyuan.com` 等），不强制转 PC 域 |
| 实现 | 扩展现有 `exam_bot.py`，新增 `qr_decode.py` |
| `--qr` / `--url` | 互斥，必须且只能提供一个 |

## CLI

```text
python scripts/exam_bot.py login --qr "<二维码图片>" [--wait 300]
python scripts/exam_bot.py fill --qr "<二维码图片>"
python scripts/exam_bot.py login --url "<URL>"
python scripts/exam_bot.py fill --url "<URL>"
```

## 组件

- `scripts/qr_decode.py`：OpenCV `QRCodeDetector` 解码
- `exam_bot.py`：`--qr` 解析、login/fill 接线、fill 缺态自动 login
- `requirements.txt`：增加 `opencv-python-headless`
- `README.md`：扫码启动与预先登录章节

## 非目标

- 不拍摄摄像头实时扫码
- 不破解验证码；登录仍为人工在弹出浏览器中完成
