# APK 仓库与批量安装（Linux 节点）

单一目录 `incoming` 存放全部 APK；`scripts` 存放安装脚本。  
部署在源站 `/data/apk-repo/`，节点 NFS 挂载为 `/mnt/apk-repo/`。

## 目录结构

```text
/data/apk-repo/
├── incoming/          # Windows 上传 + 节点安装（唯一 APK 目录）
│   ├── cn_xender/
│   └── com_whatsapp/
└── scripts/
    ├── import-apks.sh
    ├── apk-batch-install.sh
    ├── apk-install-app.sh
    └── apps.example.txt
```

**不需要单独的 `apps/` 目录。**

## 源站 Samba（Windows 访问）

`/etc/samba/smb.conf` 末尾：

```ini
[apk-incoming]
   path = /data/apk-repo/incoming
   browseable = yes
   read only = no
   guest ok = no
   valid users = apkadmin
   create mask = 0664
   directory mask = 0775
   force group = smbshare

[apk-scripts]
   path = /data/apk-repo/scripts
   browseable = yes
   read only = no
   guest ok = no
   valid users = apkadmin
   create mask = 0664
   directory mask = 0775
```

Windows 映射：

```text
\\172.21.8.202\apk-incoming   上传/管理 APK
\\172.21.8.202\apk-scripts   查看/更新脚本
```

上传整包后，源站执行（合并 .segments、展平子目录）：

```bash
/data/apk-repo/scripts/import-apks.sh
```

## 从 apps 迁移到 incoming（仅旧环境一次）

```bash
mkdir -p /data/apk-repo/incoming
for d in /data/apk-repo/apps/*/; do
  name=$(basename "$d")
  mkdir -p "/data/apk-repo/incoming/$name"
  cp -a "$d/." "/data/apk-repo/incoming/$name/"
done
/data/apk-repo/scripts/import-apks.sh
# 确认无误后：rm -rf /data/apk-repo/apps
```

## 节点依赖

```bash
sudo apt install -y nfs-common android-tools-adb rsync
sudo mount /mnt/apk-repo
adb devices
```

## 安装用法

```bash
# 批量
/mnt/apk-repo/scripts/apk-batch-install.sh -a cn_xender -a com_whatsapp
/mnt/apk-repo/scripts/apk-batch-install.sh -l /mnt/apk-repo/scripts/apps.example.txt
/mnt/apk-repo/scripts/apk-batch-install.sh -A -c

# 单应用
/mnt/apk-repo/scripts/apk-install-app.sh cn_xender

# 多设备
/mnt/apk-repo/scripts/apk-batch-install.sh -a cn_xender -d SERIAL1 -d SERIAL2 -p
```

路径对应：`/mnt/apk-repo/incoming/<应用名>/`
