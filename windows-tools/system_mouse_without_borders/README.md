# system_mouse_without_borders

基于 [PowerToys Mouse Without Borders](https://github.com/microsoft/PowerToys) 的本地定制版（MIT）。

用于：修复单向剪切板、提高局域网文件传输速度、将剪贴板传文件上限从 **100MB** 提高到 **1GB**。

## 目录

```
system_mouse_without_borders/
├── README.md                 # 本说明
├── PATCHES.md                # 改动清单
└── PowerToys/                # sparse clone（仅含 MouseWithoutBorders 模块源码）
    └── src/modules/MouseWithoutBorders/
```

> `PowerToys/` 为嵌套 git 仓库，已被父仓库 `.gitignore` 忽略。完整编译需自行补全 PowerToys 工程依赖（见下文）。

## Tinno 补丁摘要

| 项 | 原值 | 新值 |
|----|------|------|
| 剪贴板文件上限 | 100MB | **1GB** |
| 大剪贴板超时 | 30s | **600s** |
| 网络读写缓冲 | 1MB | **8MB** |
| TCP Send/Recv 缓冲 | ~320KB / ~1MB | **8MB** |
| Helper 保活 | 仅启动时 | **每次出站剪贴板前检测并重启** |

## 源码位置（已改文件）

- `PowerToys/src/modules/MouseWithoutBorders/App/Core/Clipboard.cs`
- `PowerToys/src/modules/MouseWithoutBorders/App/Core/Common.cs`
- `PowerToys/src/modules/MouseWithoutBorders/App/Core/Helper.cs`
- `PowerToys/src/modules/MouseWithoutBorders/App/Class/SocketStuff.cs`
- `PowerToys/src/modules/MouseWithoutBorders/App/Form/frmMatrix.Designer.cs`

## 编译与部署

当前 `PowerToys/` 为 **完整源码树**（由 GitHub zip 解压得到，已打上 Tinno 补丁），可直接用 VS 打开编译。

> 说明：`git sparse-checkout disable` / `git clone` 在部分网络下会因 `RPC failed / Connection was reset` 失败。
> 已改用 `codeload.github.com` 下载 `main.zip` + `tar` 解压（避免 Expand-Archive 长路径问题）。

### 编译

1. 安装 [Visual Studio 2022](https://visualstudio.microsoft.com/)（含 Desktop C++ / .NET 工作负载，按 PowerToys 官方要求）。
2. 打开 `PowerToys\PowerToys.slnx`（或按上游 README 的构建步骤）。
3. 编译后得到 `PowerToys.MouseWithoutBorders*` 与 Helper。

### 部署

1. **两台机器**都替换同版本 MWB 相关文件后重启 PowerToys。
2. 两边必须使用同一套补丁构建，否则缓冲/上限不一致可能异常。

### 若需重新拉取完整源码（网络不稳时）

```powershell
cd D:\Tinno_auto\automation-toolkit\windows-tools\system_mouse_without_borders
curl.exe -L --http1.1 --retry 10 --retry-all-errors -C - -o PowerToys-main.zip `
  https://codeload.github.com/microsoft/PowerToys/zip/refs/heads/main
mkdir PowerToys_extract
tar -xf PowerToys-main.zip -C PowerToys_extract
# 再用 _tinno_mwb_src_backup\ 或 tinno-mwb-clipboard-1gb.patch 覆盖/应用补丁
```

## 验证清单

- [ ] 无键鼠本机复制文本 → 对端粘贴成功（此前单向失败场景）
- [ ] 对端复制 → 本机粘贴仍正常
- [ ] 复制约 200MB / 800MB 单文件可传到对端
- [ ] >1GB 文件被拒绝并提示 greater than 1GB
- [ ] 锁屏/UAC 后再复制，Helper 能自动恢复

## 上游

- 仓库：https://github.com/microsoft/PowerToys
- 许可：MIT
- 模块：`src/modules/MouseWithoutBorders`
