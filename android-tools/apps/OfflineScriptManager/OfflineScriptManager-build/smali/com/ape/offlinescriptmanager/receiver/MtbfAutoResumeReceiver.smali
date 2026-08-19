.class public Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;
.super Landroid/content/BroadcastReceiver;
.source ""


# static fields
.field public static final ACTION_KEEPALIVE:Ljava/lang/String; = "com.ape.offlinescriptmanager.action.MTBF_KEEPALIVE"

.field private static final PREFS_NAME:Ljava/lang/String; = "mtbf_runner"

.field private static final PREF_AUTO_RESUME:Ljava/lang/String; = "auto_resume"

.field private static final REQUEST_CODE:I = 0x4d544246

.field private static final TAG:Ljava/lang/String; = "MtbfAutoResume"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private static isAutoResumeEnabled(Landroid/content/Context;)Z
    .locals 3

    const-string v0, "mtbf_runner"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v0, "auto_resume"

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method private static isRunTaskServiceRunning(Landroid/content/Context;)Z
    .locals 4

    const-string v0, "activity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/ActivityManager;

    const/16 v0, 0x64

    invoke-virtual {p0, v0}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    :cond_0
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v0}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v0

    const-string v2, "com.ape.offlinescriptmanager.view.RunTaskService"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_1
    goto :goto_0

    :cond_2
    return v1
.end method

.method public static scheduleKeepAlive(Landroid/content/Context;)V
    .locals 6

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;->isAutoResumeEnabled(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.action.MTBF_KEEPALIVE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v1, 0x4000000

    const v2, 0x4d544246

    invoke-static {p0, v2, v0, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    const-string v1, "alarm"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/AlarmManager;

    if-nez p0, :cond_1

    return-void

    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    const-wide/32 v3, 0x1b7740

    add-long/2addr v1, v3

    const/4 v3, 0x2

    invoke-virtual {p0, v3, v1, v2, v0}, Landroid/app/AlarmManager;->setAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    return-void
.end method

.method private static startRunTaskService(Landroid/content/Context;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.view.RunTaskService.action.start"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :goto_0
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;->isAutoResumeEnabled(Landroid/content/Context;)Z

    move-result p2

    if-nez p2, :cond_1

    return-void

    :cond_1
    invoke-static {p1}, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;->isRunTaskServiceRunning(Landroid/content/Context;)Z

    move-result p2

    if-nez p2, :cond_2

    const-string p2, "MtbfAutoResume"

    const-string v0, "RunTaskService not running, restarting"

    invoke-static {p2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;->startRunTaskService(Landroid/content/Context;)V

    :cond_2
    invoke-static {p1}, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;->scheduleKeepAlive(Landroid/content/Context;)V

    return-void
.end method
