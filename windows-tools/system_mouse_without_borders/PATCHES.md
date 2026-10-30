# Tinno MWB 补丁明细

相对上游 PowerToys `main`（sparse：`src/modules/MouseWithoutBorders`）。

## 1. 剪切板单向失效（本机→对端）

**原因**：Service / 桌面切换后 `PowerToys.MouseWithoutBordersHelper` 易僵死，出站剪贴板依赖 Helper。

**改动**：

- `Helper.EnsureClipboardHelperAlive()`：进程或窗口缺失时清理并重启 Helper。
- `RunDDHelper()`：窗口在但进程已死时也走重启路径。
- `Clipboard.CheckClipboardEx()`：出站分享前调用 `EnsureClipboardHelperAlive()`。

## 2. 文件上限 100MB → 1GB

| 文件 | 改动 |
|------|------|
| `Clipboard.cs` | `MAX_CLIPBOARD_FILE_SIZE_CAN_BE_SENT = 1024u * 1024 * 1024` |
| `Clipboard.cs` | 提示文案 `100MB` → `1GB` |
| `frmMatrix.Designer.cs` | Transfer file tooltip `<1GB` |
| UnitTests dump | 期望值同步为 `1073741824` |

## 3. 传输速度与大文件超时

| 文件 | 改动 |
|------|------|
| `Common.cs` | `NETWORK_STREAM_BUF_SIZE` 1MB → **8MB** |
| `SocketStuff.cs` | 握手后 socket 缓冲改为 `NETWORK_STREAM_BUF_SIZE` |
| `SocketStuff.cs` | `SendFileEx` 发送前设置 120s timeout + 8MB 缓冲 |
| `Clipboard.cs` | `BIG_CLIPBOARD_DATA_TIMEOUT` 30s → **600s** |
| `Clipboard.cs` | `ShakeHand` I/O timeout 30s → **600s**，缓冲对齐 8MB |

## 标记

源码中带 `Tinno patch` 注释，便于 rebase / 合并上游时检索。
