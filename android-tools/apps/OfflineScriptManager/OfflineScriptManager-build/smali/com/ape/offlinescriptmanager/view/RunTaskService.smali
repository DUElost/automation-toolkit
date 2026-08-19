.class public Lcom/ape/offlinescriptmanager/view/RunTaskService;
.super Landroid/app/Service;
.source ""

# interfaces
.implements Lcom/ape/offlinescriptmanager/utils/l/f$a;


# static fields
.field private static final l:Ljava/lang/String;


# instance fields
.field b:Lcom/ape/offlinescriptmanager/utils/l/f;

.field public c:Landroid/os/Handler;

.field d:Lcom/ape/offlinescriptmanager/utils/m/c;

.field private e:Landroid/app/NotificationManager;

.field private f:Landroid/app/NotificationChannel;

.field private g:Landroid/app/Notification$Builder;

.field private h:Landroid/app/Notification$Builder;

.field private i:Ljava/lang/String;

.field private j:I

.field private k:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->d:Lcom/ape/offlinescriptmanager/utils/m/c;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f:Landroid/app/NotificationChannel;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->g:Landroid/app/Notification$Builder;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->h:Landroid/app/Notification$Builder;

    const/4 v0, 0x0

    iput v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->j:I

    iput v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k:I

    return-void
.end method

.method static synthetic f(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->h:Landroid/app/Notification$Builder;

    return-object p0
.end method

.method static synthetic g(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->g:Landroid/app/Notification$Builder;

    return-object p0
.end method

.method private h(Ljava/lang/String;)V
    .locals 4

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/utils/a;-><init>(Landroid/content/Context;)V

    const-wide/16 v1, 0x2

    invoke-virtual {v0, v1, v2}, Lcom/ape/offlinescriptmanager/utils/a;->e(J)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "com.ape.offlinescriptmanager.pref"

    const-string v2, "export_data_no_empty"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lcom/ape/offlinescriptmanager/utils/a;->h(Ljava/lang/String;Ljava/lang/String;Z)V

    new-instance v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-virtual {p0}, Landroid/app/Service;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    invoke-direct {v0, v1, p1, v3, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/b;-><init>(Landroid/content/Context;Ljava/lang/String;ZZ)V

    new-array p1, v3, [Ljava/lang/Void;

    invoke-virtual {v0, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p0}, Lcom/ape/offlinescriptmanager/utils/a;->j(Landroid/content/Context;)V

    :goto_0
    return-void
.end method

.method private m(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    const-string v0, ""

    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object p1

    const-string v1, "android.os.SystemProperties"

    invoke-virtual {p1, v1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p1

    const/4 v1, 0x1

    new-array v2, v1, [Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, "get"

    invoke-virtual {p1, v3, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, p2}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    aput-object v3, v1, v4

    invoke-virtual {v2, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, p1

    :catch_0
    return-object v0
.end method

.method private o()V
    .locals 10

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object v0

    const-string v1, "uiautomator"

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/utils/a;->f(Ljava/lang/String;)V

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    new-instance v3, Landroid/content/Intent;

    const-class v4, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v4, "com.ape.offlinescriptmanager.view.RunTaskService.action.stop"

    invoke-virtual {v3, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-static {p0, v2, v3, v2}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const-string v4, "offlinescriptmanager_id"

    const/16 v5, 0x1a

    if-lt v3, v5, :cond_0

    new-instance v6, Landroid/app/Notification$Builder;

    invoke-direct {v6, p0, v4}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v6, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->h:Landroid/app/Notification$Builder;

    :cond_0
    iget-object v6, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->h:Landroid/app/Notification$Builder;

    const-string v7, "OSM Tool Running"

    invoke-virtual {v6, v7}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v6

    const-string v7, "task is running"

    invoke-virtual {v6, v7}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v6

    const v7, 0x7f0e000a

    invoke-virtual {v6, v7}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v6, v8, v9}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    move-result-object v6

    const v8, 0x7f0f0282

    invoke-virtual {p0, v8}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v7, v8, v2}, Landroid/app/Notification$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    const/16 v6, 0x271a

    invoke-virtual {v0, v6, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->h:Landroid/app/Notification$Builder;

    invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    const/16 v9, 0x22

    if-lt v3, v9, :cond_start_fg_legacy

    const/4 v9, 0x2

    invoke-virtual {p0, v6, v2, v9}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;I)V

    goto :goto_start_fg_done

    :cond_start_fg_legacy
    invoke-virtual {p0, v6, v2}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;)V

    :goto_start_fg_done

    if-lt v3, v5, :cond_1

    new-instance v2, Landroid/app/Notification$Builder;

    invoke-direct {v2, p0, v4}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->g:Landroid/app/Notification$Builder;

    :cond_1
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->g:Landroid/app/Notification$Builder;

    const-string v3, "OSM Tool Result"

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    invoke-virtual {v2, v7}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;

    invoke-virtual {p0}, Landroid/app/Service;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, p0, v2, v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;-><init>(Lcom/ape/offlinescriptmanager/view/RunTaskService;Landroid/os/Looper;Landroid/app/NotificationManager;)V

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/app/NotificationManager;->cancelAll()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/b;->b()V

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/l/f;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/utils/l/f;-><init>(Lcom/ape/offlinescriptmanager/utils/l/f$a;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->b:Lcom/ape/offlinescriptmanager/utils/l/f;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/receiver/MtbfAutoResumeReceiver;->scheduleKeepAlive(Landroid/content/Context;)V

    return-void
.end method

.method private p()V
    .locals 2

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object v0

    const-string v1, "uiautomator"

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/utils/a;->f(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->b:Lcom/ape/offlinescriptmanager/utils/l/f;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/l/f;->o()V

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/app/Service;->stopForeground(Z)V

    invoke-virtual {p0}, Landroid/app/Service;->stopSelf()V

    return-void
.end method

.method public static q(Landroid/app/Activity;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.view.RunTaskService.action.start"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    invoke-virtual {p0, v0}, Landroid/app/Activity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :goto_0
    return-void
.end method


# virtual methods
.method public a(Lb/b/a/a/c/c;)V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    invoke-interface {p1}, Lb/b/a/a/c/c;->b()Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const-string p1, "Current:%s"

    invoke-static {p1, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public b(Lb/b/a/a/b/h;)Lb/b/a/a/b/h;
    .locals 2

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/a;->b()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "startbattery"

    invoke-virtual {p1, v1, v0}, Lb/b/a/a/b/h;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-object p1
.end method

.method public c(Lb/b/a/a/c/f;)V
    .locals 2

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->q()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->i:Ljava/lang/String;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->b:Lcom/ape/offlinescriptmanager/utils/l/f;

    invoke-virtual {v1, v0, p1}, Lcom/ape/offlinescriptmanager/utils/l/f;->c(Ljava/lang/String;Lb/b/a/a/c/f;)V

    return-void
.end method

.method public d(Lb/b/a/a/b/h;)Lb/b/a/a/b/h;
    .locals 12

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    sget-object v1, Lb/b/a/a/b/g;->g:Lb/b/a/a/b/g;

    if-ne v0, v1, :cond_1

    sget-object v0, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    invoke-virtual {p1, v0}, Lb/b/a/a/b/h;->o(Lb/b/a/a/b/g;)V

    :cond_1
    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->m()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lb/b/a/a/b/h;->l(J)V

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    sget-object v1, Lb/b/a/a/b/g;->e:Lb/b/a/a/b/g;

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_3

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    sget-object v2, Lb/b/a/a/b/g;->d:Lb/b/a/a/b/g;

    invoke-virtual {v0, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    sget-object v2, Lb/b/a/a/b/g;->h:Lb/b/a/a/b/g;

    invoke-virtual {v0, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/a/b/g;->a()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    invoke-virtual {v2}, Lb/b/a/a/b/g;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k:I

    goto :goto_1

    :cond_3
    :goto_0
    iget v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->j:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->j:I

    :cond_4
    :goto_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    iget v3, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->j:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v1

    const-string v1, "Pass:%s;Fail:%s"

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    invoke-virtual {p1}, Lb/b/a/a/b/h;->g()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lb/b/a/a/b/h;->h()Ljava/util/Map;

    move-result-object v0

    const-string v1, "startbattery"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v9

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/a;->b()I

    move-result v0

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v1

    invoke-virtual {v1}, Lb/b/a/a/b/g;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Lb/b/a/a/b/h;->i()J

    move-result-wide v5

    invoke-virtual {p1}, Lb/b/a/a/b/h;->e()J

    move-result-wide v7

    invoke-virtual {p1}, Lb/b/a/a/b/h;->h()Ljava/util/Map;

    move-result-object v1

    const-string v2, "regression"

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v11

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object v2

    move v10, v0

    invoke-virtual/range {v2 .. v11}, Lcom/ape/offlinescriptmanager/utils/a;->g(Ljava/lang/String;Ljava/lang/String;JJIII)V

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "stopbattery"

    invoke-virtual {p1, v1, v0}, Lb/b/a/a/b/h;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-object p1
.end method

.method public e(Lb/b/a/a/c/f;)V
    .locals 3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->i:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->n(Ljava/io/File;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->d:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->n()Ljava/util/Map;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->i:Ljava/lang/String;

    invoke-virtual {p0}, Landroid/app/Service;->getBaseContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0, p1, v0, v1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l(Ljava/util/Map;Ljava/lang/String;Landroid/content/Context;)Ljava/util/Map;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->r(Ljava/util/Map;)Z

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {p1}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object p1

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    iget v2, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v1

    iget v1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->j:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const-string v1, "Finished;Pass:%s;Fail:%s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->c:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->i:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->h(Ljava/lang/String;)V

    invoke-virtual {p0, v2}, Landroid/app/Service;->stopForeground(Z)V

    invoke-virtual {p0}, Landroid/app/Service;->stopSelf()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/b;->a()V

    return-void
.end method

.method public i()Ljava/lang/String;
    .locals 1

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object v0
.end method

.method public j(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    const-string v0, "ro.internal.build.version"

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->m(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "ro.tinternal.build.version"

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->m(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public k(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/f;->a()Lcom/ape/offlinescriptmanager/utils/f;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/ape/offlinescriptmanager/utils/f;->h(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    new-instance v0, Ljava/io/File;

    const-string v1, "TESTS-RealResult-TestPoints.xml"

    invoke-direct {v0, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public l(Ljava/util/Map;Ljava/lang/String;Landroid/content/Context;)Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/String;",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    const-string v0, "test_task_data"

    const/4 v1, 0x0

    invoke-virtual {p3, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    if-eqz p1, :cond_0

    const-string v1, "reslut_dir_name"

    invoke-interface {p1, v1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p2, "task_creator"

    const-string v1, "tester"

    invoke-interface {v0, p2, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, p2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->i()Ljava/lang/String;

    move-result-object p2

    const-string v0, "device_project"

    invoke-interface {p1, v0, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0, p3}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->j(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "device_version"

    invoke-interface {p1, p3, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-object p1
.end method

.method public n(Ljava/io/File;)Z
    .locals 4

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    sget-object p1, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    const-string v0, "load result xml file fail have no xml file"

    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->c(Ljava/lang/String;)V

    return v1

    :cond_0
    const-string v0, "load result xml file start"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    sget-object v2, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    invoke-static {v2, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->d:Lcom/ape/offlinescriptmanager/utils/m/c;

    :try_start_0
    new-instance v0, Ljava/io/BufferedInputStream;

    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v3}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->d:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-virtual {p1, v0}, Lcom/ape/offlinescriptmanager/utils/m/a;->c(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string p1, "load result xml file end"

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    invoke-static {v2, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const-string p1, "load result xml file fail"

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/b;->c(Ljava/lang/String;)V

    sget-object v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v1
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 4

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->e:Landroid/app/NotificationManager;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    new-instance v0, Landroid/app/NotificationChannel;

    const/4 v1, 0x3

    const-string v2, "offlinescriptmanager_id"

    const-string v3, "offlinescriptmanager_name"

    invoke-direct {v0, v2, v3, v1}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f:Landroid/app/NotificationChannel;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->enableLights(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f:Landroid/app/NotificationChannel;

    const v1, -0xff0100

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setLightColor(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f:Landroid/app/NotificationChannel;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->e:Landroid/app/NotificationManager;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f:Landroid/app/NotificationChannel;

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_0
    return-void
.end method

.method public onTimeout(II)V
    .locals 2

    sget-object v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    const-string v1, "onTimeout: stopping RunTaskService gracefully"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->p()V

    return-void
.end method

.method public onDestroy()V
    .locals 2

    sget-object v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    const-string v1, "onDestroy"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    const-string p2, "com.ape.offlinescriptmanager.view.RunTaskService.action.start"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1

    const-string p2, "com.ape.offlinescriptmanager.view.RunTaskService.action.stop"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->p()V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->o()V

    :goto_0
    const/4 p1, 0x2

    return p1
.end method

.method public r(Ljava/util/Map;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)Z"
        }
    .end annotation

    const/4 v0, 0x0

    const-string v1, "upload result xml file fail, test_result_map is null"

    if-eqz p1, :cond_0

    new-instance v2, Lcom/ape/offlinescriptmanager/utils/l/h;

    invoke-direct {v2, p1}, Lcom/ape/offlinescriptmanager/utils/l/h;-><init>(Ljava/util/Map;)V

    invoke-virtual {v2}, Lcom/ape/offlinescriptmanager/utils/l/h;->e()Z

    move-result p1

    if-nez p1, :cond_1

    :cond_0
    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/b;->c(Ljava/lang/String;)V

    sget-object p1, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    invoke-static {p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v0

    :cond_1
    const-string p1, "send result xml file to master is success"

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    sget-object v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x1

    return p1
.end method
