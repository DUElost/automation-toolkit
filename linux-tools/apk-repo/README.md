# APK 批量安装脚本（Linux 节点）

部署到源站 `/data/apk-repo/scripts/`，节点通过 NFS 挂载后在 `/mnt/apk-repo/scripts/` 使用。

## 部署

在源站 **172.21.8.202**：

```bash
mkdir -p /data/apk-repo/scripts
# 复制本目录下脚本到 /data/apk-repo/scripts/
chmod +x /data/apk-repo/scripts/*.sh
chown -R nobody:nogroup /data/apk-repo/scripts
chmod -R 755 /data/apk-repo/scripts
```

节点无需单独复制，NFS 挂载后即可用。

## 依赖

```bash
sudo apt install -y nfs-common android-tools-adb rsync
sudo mount /mnt/apk-repo   # 或已写入 fstab
adb devices                # 确认设备在线
```

## 用法

```bash
# 安装单个/多个应用（本节点全部在线设备）
/mnt/apk-repo/scripts/apk-batch-install.sh -a cn_xender -a com_whatsapp

# 快捷单应用
/mnt/apk-repo/scripts/apk-install-app.sh cn_xender
/mnt/apk-repo/scripts/apk-install-app.sh com_whatsapp DEVICE_SERIAL

# 从列表文件批量安装
/mnt/apk-repo/scripts/apk-batch-install.sh -l /mnt/apk-repo/scripts/apps.example.txt

# 安装 apps 下全部应用
/mnt/apk-repo/scripts/apk-batch-install.sh -A

# 指定多台设备
/mnt/apk-repo/scripts/apk-batch-install.sh -a cn_xender -d SERIAL1 -d SERIAL2

# 多设备并行（USB _hub 性能允许时）
/mnt/apk-repo/scripts/apk-batch-install.sh -l batch.txt -p

# 失败后继续
/mnt/apk-repo/scripts/apk-batch-install.sh -A -c

# 仅预览
/mnt/apk-repo/scripts/apk-batch-install.sh -A -n
```

## 日志

- 运行日志：`/var/log/apk-batch-install/run-YYYYMMDD-HHMMSS.log`
- 摘要：`/var/log/apk-batch-install/last-run.summary`
- 本地缓存：`/var/cache/apk-repo/<应用名>/`

## 说明

- 单 APK 使用 `adb install -r`
- Split APK 自动使用 `adb install-multiple`
- 安装前从 NFS 同步到本地缓存，减少网络抖动导致失败
- 默认逐设备串行；`-p` 为多设备并行，同一设备内仍串行装多个应用
