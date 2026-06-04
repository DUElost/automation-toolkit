# APK 源站 + 节点 完整配置清单

> Debian 13 源站 + NFS 分发 + Samba Windows 管理 + 多节点 ADB 安装  
> 源站 IP：`172.21.8.202`

---

## 环境概览

| 角色 | 主机 | IP |
|------|------|-----|
| 源站 | debian13 | 172.21.8.202 |
| 节点 1 | android-OptiPlex-3080 | 172.21.10.36 |
| 节点 2 | ubunt3 | 172.21.15.20 |
| Windows 管理端 | 任意 | 172.21.x.x |

---

## 目录规划（源站）

```text
/data/apk-repo/
├── incoming/          # 唯一 APK 目录：Windows 上传 + 节点 NFS 安装
└── scripts/           # 安装/整理脚本（Windows 可访问）
    ├── import-apks.sh
    ├── apk-batch-install.sh
    └── apk-install-app.sh
```

> **不需要单独的 `apps/` 目录。** 上传与安装均使用 `incoming/`。

---

## 一、源站配置（172.21.8.202）

### 1.1 基础目录与权限

```bash
mkdir -p /data/apk-repo/{incoming,scripts}

groupadd smbshare 2>/dev/null

chown root:smbshare /data/apk-repo/incoming /data/apk-repo/scripts
chmod 775 /data/apk-repo/incoming /data/apk-repo/scripts

# NFS 只读访问，保持 incoming 可读
chown -R nobody:nogroup /data/apk-repo/incoming
chmod -R 755 /data/apk-repo/incoming
```

### 1.2 NFS 服务（Linux 节点只读访问）

```bash
apt update
apt install -y nfs-kernel-server

cat > /etc/exports <<'EOF'
/data/apk-repo  172.21.0.0/16(ro,sync,no_subtree_check,crossmnt)
EOF

exportfs -ra
systemctl enable --now nfs-server
```

**验证：**

```bash
exportfs -v
showmount -e 172.21.8.202

# 用局域网 IP 测试（不要用 127.0.0.1）
mount -t nfs 172.21.8.202:/data/apk-repo /mnt/apk-test -o ro,vers=4.2
ls /mnt/apk-test/incoming | wc -l
umount /mnt/apk-test
```

> **说明：** exports 限制网段时，`127.0.0.1` 挂载会被拒绝，属正常现象。

### 1.3 Samba 服务（Windows 管理）

```bash
apt install -y samba

useradd -M -s /usr/sbin/nologin apkadmin 2>/dev/null
smbpasswd -a apkadmin
# 按提示设置 Windows 登录密码
```

在 `/etc/samba/smb.conf` **末尾追加**：

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
   force group = smbshare
```

**生效：**

```bash
testparm -s
systemctl enable --now smbd nmbd
systemctl restart smbd
```

**Windows 映射网络驱动器：**

| 路径 | 用途 |
|------|------|
| `\\172.21.8.202\apk-incoming` | 上传/管理 APK（可写） |
| `\\172.21.8.202\apk-scripts` | 查看/更新安装脚本（可写） |

- 用户名：`apkadmin`
- 密码：`smbpasswd` 时设置的密码

### 1.4 整理脚本（incoming 内就地合并分片）

从 `automation-toolkit` 复制 `linux-tools/apk-repo/*` 到 `/data/apk-repo/scripts/`，或见仓库内 `import-apks.sh`。

**作用：** 合并 `.segments`、展平整包上传子目录，**不复制到 apps**。

```bash
chmod +x /data/apk-repo/scripts/*.sh
/data/apk-repo/scripts/import-apks.sh
```

**可选：每 5 分钟自动整理**

```bash
cat > /etc/cron.d/apk-import <<'EOF'
*/5 * * * * root /data/apk-repo/scripts/import-apks.sh >> /var/log/apk-import.log 2>&1
EOF
```

### 1.4.1 从旧版 apps/ 迁移（一次性）

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

### 1.5 源站长期运行

```bash
# 关闭休眠
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

**建议：** 在路由器为源站 MAC `e8:cf:83:4c:77:ea` 绑定固定 IP `172.21.8.202`。

### 1.6 源站验收

```bash
exportfs -v
systemctl is-active nfs-server smbd
du -sh /data/apk-repo/incoming
find /data/apk-repo/incoming -name '*.segments' -o -name '*.part*' | wc -l
/data/apk-repo/scripts/import-apks.sh
```

---

## 二、Windows 管理流程

### 2.1 日常上传

1. 映射 `\\172.21.8.202\apk-incoming`
2. 拖入单个应用目录（如 `cn_xender`）或整包 `downloaded_apks_...`
3. 源站执行整理：`/data/apk-repo/scripts/import-apks.sh`
4. 在 `\\172.21.8.202\apk-incoming` 确认应用目录

### 2.2 重要提醒

| 不要 | 应该 |
|------|------|
| scp 到 `/tmp/` | 上传到 `incoming/` 或 Samba |
| 只装 `base.apk`（分包应用） | `adb install-multiple *.apk` |
| 在 bash 里直接粘贴 fstab 行 | 写入 `/etc/fstab` |

> `/tmp` 为 12GB tmpfs，整包上传会写满导致 scp 失败。

### 2.3 备选：WinSCP / SFTP

```text
协议：SFTP
主机：172.21.8.202
用户：debian13
远程目录：/data/apk-repo/incoming/
```

### 2.4 修复 Windows SSH 权限（scp 报错时）

```powershell
$sshDir = "$env:USERPROFILE\.ssh"
icacls $sshDir /inheritance:r
icacls $sshDir /grant:r "$($env:USERNAME):(OI)(CI)F"
icacls $sshDir /grant:r "SYSTEM:(OI)(CI)F"
icacls $sshDir /grant:r "Administrators:(OI)(CI)F"

foreach ($f in @("config", "known_hosts")) {
    $p = Join-Path $sshDir $f
    if (Test-Path $p) {
        icacls $p /inheritance:r
        icacls $p /grant:r "$($env:USERNAME):F"
    }
}
```

临时绕过 config 权限：

```powershell
scp -F NUL -r "D:\path\to\app_dir" debian13@172.21.8.202:/data/apk-repo/incoming/
```

---

## 三、Linux 节点通用配置

在 **OptiPlex、ubunt3 及所有节点** 上执行。

### 3.1 安装软件

```bash
sudo apt update
sudo apt install -y nfs-common android-tools-adb rsync
```

### 3.2 NFS 挂载

```bash
sudo mkdir -p /mnt/apk-repo

grep -q '172.21.8.202:/data/apk-repo' /etc/fstab || \
echo '172.21.8.202:/data/apk-repo  /mnt/apk-repo  nfs  ro,vers=4.2,_netdev,nofail,x-systemd.automount  0  0' | sudo tee -a /etc/fstab

sudo systemctl daemon-reload
sudo mount /mnt/apk-repo

mount | grep apk-repo
ls /mnt/apk-repo/incoming | head
```

### 3.3 ADB（USB 调试）

```bash
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"' | \
  sudo tee /etc/udev/rules.d/51-android.rules

sudo groupadd plugdev 2>/dev/null
sudo usermod -aG plugdev "$USER"
sudo udevadm control --reload-rules
sudo udevadm trigger
```

重新插 USB 或注销后：

```bash
adb kill-server && adb start-server
adb devices
```

手机需开启 **USB 调试** 并点 **允许**。

### 3.4 批量安装（使用 NFS 上的 scripts）

脚本位于 `/mnt/apk-repo/scripts/`，源站更新后节点自动可用：

```bash
/mnt/apk-repo/scripts/apk-install-app.sh cn_xender
/mnt/apk-repo/scripts/apk-batch-install.sh -a cn_xender -a com_whatsapp
/mnt/apk-repo/scripts/apk-batch-install.sh -l /mnt/apk-repo/scripts/apps.example.txt
/mnt/apk-repo/scripts/apk-batch-install.sh -A -c
```

多设备：

```bash
/mnt/apk-repo/scripts/apk-batch-install.sh -a cn_xender -d SERIAL1 -d SERIAL2 -p
```

### 3.5 无线 ADB（可选）

```bash
adb tcpip 5555
adb connect <手机IP>:5555
adb devices
/mnt/apk-repo/scripts/apk-install-app.sh cn_xender
```

### 3.6 节点验收

```bash
ping -c 2 172.21.8.202
mountpoint /mnt/apk-repo
adb devices
/mnt/apk-repo/scripts/apk-install-app.sh cn_xender
```

---

## 四、OptiPlex 额外配置（CIFS sonic）

仅 **172.21.10.36** 需要。

```bash
sudo apt install -y cifs-utils

sudo mkdir -p /home/android/sonic_agent/logs/ftp_log/sonic_tinno

sudo tee /etc/cifs-credentials <<'EOF'
username=jxtinno
password=你的密码
EOF
sudo chmod 600 /etc/cifs-credentials

grep -q '172.21.15.4/jxtinno' /etc/fstab || \
echo '//172.21.15.4/jxtinno/sonic_tinno  /home/android/sonic_agent/logs/ftp_log/sonic_tinno  cifs  credentials=/etc/cifs-credentials,dir_mode=0777,file_mode=0777,_netdev,nofail,x-systemd.automount  0  0' | sudo tee -a /etc/fstab

sudo mount /home/android/sonic_agent/logs/ftp_log/sonic_tinno
df -h | grep sonic_tinno
```

**OptiPlex 最终自动挂载：**

| 挂载点 | 类型 | 来源 |
|--------|------|------|
| `/mnt/apk-repo` | NFS | `172.21.8.202:/data/apk-repo` |
| `.../sonic_tinno` | CIFS | `//172.21.15.4/jxtinno/sonic_tinno` |

---

## 五、APK 安装规则

| APK 类型 | 目录特征 | 安装方式 |
|----------|----------|----------|
| 单包 | 仅 `base.apk` | `adb install -r base.apk` |
| Split APK | `base.apk` + `config.*.apk` 等 | `adb install-multiple *.apk` |
| 含 `.segments` 分片 | `.base.apk.segments/` 等 | 必须先 `import-apks.sh` 合并 |

**推荐：** 使用 `/mnt/apk-repo/scripts/apk-install-app.sh <目录名>` 或 `apk-batch-install.sh`。

---

## 六、整体架构

```text
Windows
  │ Samba → \\172.21.8.202\apk-incoming（APK）
  │         \\172.21.8.202\apk-scripts（脚本）
  ▼
/data/apk-repo/incoming/     ← 唯一 APK 目录
  │ import-apks.sh（就地合并 .segments）
  │ NFS 只读（172.21.0.0/16）
  ▼
节点 /mnt/apk-repo/incoming/
  │ /mnt/apk-repo/scripts/apk-batch-install.sh
  ▼
Android 设备
```

---

## 七、故障排查

| 现象 | 原因 | 处理 |
|------|------|------|
| NFS `access denied` | 节点 IP 不在 exports 网段 | 源站改为 `172.21.0.0/16`，`exportfs -ra` |
| NFS 127.0.0.1 失败 | exports 不含 localhost | 用 `172.21.8.202` 测试 |
| scp 到 `/tmp` 失败 | tmpfs 12G 已满 | 改用 `incoming/` 或 Samba |
| `chown: invalid group smbshare` | 组未创建 | 先 `groupadd smbshare` |
| `cannot stat '.../*'` | 空目录 + glob | 用 `cp -a "$d." dest/` |
| Split 安装失败 | 只装了 base | `adb install-multiple *.apk` |
| 空 `.segments` 目录 | 模块未下载 | `rm -rf` 删除即可 |
| fstab 行在 bash 报错 | 误当命令执行 | 写入 `/etc/fstab` 后 `mount` |
| Windows 连不上 Samba | 服务/防火墙 | `systemctl status smbd`，放行 445 |
| 开机未挂载 | 网络未就绪 | fstab 加 `_netdev,nofail,x-systemd.automount` |

---

## 八、配置完成检查表

### 源站 debian13

- [ ] `/data/apk-repo/{incoming,scripts}` 已创建
- [ ] NFS exports `172.21.0.0/16`，`exportfs -v` 有输出
- [ ] Samba `apk-incoming` / `apk-scripts` Windows 可访问
- [ ] `import-apks.sh` 可执行
- [ ] `incoming` 无 `.part*` / 空 `.segments`
- [ ] 源站 IP 固定为 172.21.8.202

### Windows

- [ ] 已映射 `\\172.21.8.202\apk-incoming` 与 `apk-scripts`
- [ ] 上传测试目录成功
- [ ] 执行 import 后在 incoming 可见

### 每个 Linux 节点

- [ ] `/mnt/apk-repo` NFS 挂载成功
- [ ] `/etc/fstab` 已写入 NFS 行
- [ ] `adb devices` 可见设备
- [ ] `/mnt/apk-repo/scripts/apk-install-app.sh cn_xender` 安装成功

### OptiPlex 额外

- [ ] CIFS `sonic_tinno` 挂载成功

---

## 九、新节点快速部署（复制即用）

```bash
sudo apt update
sudo apt install -y nfs-common android-tools-adb rsync

sudo mkdir -p /mnt/apk-repo
echo '172.21.8.202:/data/apk-repo  /mnt/apk-repo  nfs  ro,vers=4.2,_netdev,nofail,x-systemd.automount  0  0' | sudo tee -a /etc/fstab

sudo systemctl daemon-reload
sudo mount /mnt/apk-repo

# 试装：/mnt/apk-repo/scripts/apk-install-app.sh cn_xender
```

---

*文档版本：2026-05-28*
