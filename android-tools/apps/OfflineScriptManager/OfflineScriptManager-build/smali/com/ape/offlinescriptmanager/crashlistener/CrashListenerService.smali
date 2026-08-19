.class public Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;
.super Landroid/app/Service;
.source ""


# static fields
.field public static h:Z = false


# instance fields
.field b:Landroid/app/ActivityManager;

.field c:I

.field private d:J

.field private e:Lcom/ape/offlinescriptmanager/crashlistener/b;

.field private f:Landroid/app/NotificationManager;

.field private g:Landroid/app/NotificationChannel;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->c:I

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g:Landroid/app/NotificationChannel;

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object p0

    return-object p0
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;Landroid/app/Notification;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->l(Landroid/app/Notification;I)V

    return-void
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;)J
    .locals 2

    iget-wide v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->d:J

    return-wide v0
.end method

.method private d()V
    .locals 3

    const-string v0, "200"

    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const v2, 0x7f0f0063

    :try_start_0
    invoke-virtual {p0, v2}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    iput-wide v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->d:J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    invoke-static {v0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->d:J

    :goto_0
    return-void
.end method

.method private e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;
    .locals 8

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0e000a

    invoke-static {v0, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "com.ape.offlinescriptmanager.screenshot.services.action.stoplistening"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v2}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    new-instance v3, Landroid/content/Intent;

    const-class v4, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {p0, v2, v3, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x1a

    if-lt v4, v5, :cond_0

    new-instance v4, Landroid/app/Notification$Builder;

    const-string v5, "offlinescriptmanager_id"

    invoke-direct {v4, p0, v5}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f0f0064

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v5

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-virtual {v7, v6}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/app/Notification$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v5

    const v6, 0x7f080079

    invoke-virtual {v5, v6}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v5

    const/16 v6, 0x80

    invoke-static {v0, v6, v6, v2}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-virtual {v5, v0}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object v0

    const v2, 0x7f08007a

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v5, 0x7f0f028a

    invoke-virtual {v3, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3, v1}, Landroid/app/Notification$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    :goto_0
    if-eqz p1, :cond_1

    invoke-virtual {v4, p1}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    :cond_1
    return-object v4
.end method

.method private f()V
    .locals 3

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    const/16 v2, 0x1b59

    invoke-direct {p0, v1, v2}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->l(Landroid/app/Notification;I)V

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;

    invoke-direct {v1, p0, v0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;Landroid/app/Notification$Action;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->d()V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->j()V

    return-void
.end method

.method private g()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->e:Lcom/ape/offlinescriptmanager/crashlistener/b;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->g()V

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/app/Service;->stopForeground(Z)V

    sput-boolean v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->h:Z

    invoke-virtual {p0}, Landroid/app/Service;->stopSelf()V

    return-void
.end method

.method private h()V
    .locals 0

    return-void
.end method

.method private i()V
    .locals 0

    return-void
.end method

.method public static k(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.screenshot.services.action.startlistening"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method private l(Landroid/app/Notification;I)V
    .locals 0

    invoke-virtual {p0, p2, p1}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;)V

    return-void
.end method


# virtual methods
.method public j()V
    .locals 2

    const/4 v0, 0x0

    sput-boolean v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->h:Z

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->b:Landroid/app/ActivityManager;

    if-nez v0, :cond_0

    const-string v0, "activity"

    invoke-virtual {p0, v0}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->b:Landroid/app/ActivityManager;

    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public m()V
    .locals 2

    sget-boolean v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->h:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-virtual {p0}, Landroid/app/Service;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->e:Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->m()V

    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Not yet implemented"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public onCreate()V
    .locals 4

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->f:Landroid/app/NotificationManager;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    new-instance v0, Landroid/app/NotificationChannel;

    const/4 v1, 0x3

    const-string v2, "offlinescriptmanager_id"

    const-string v3, "offlinescriptmanager_name"

    invoke-direct {v0, v2, v3, v1}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g:Landroid/app/NotificationChannel;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->enableLights(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g:Landroid/app/NotificationChannel;

    const v1, -0xff0100

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setLightColor(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g:Landroid/app/NotificationChannel;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->f:Landroid/app/NotificationManager;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g:Landroid/app/NotificationChannel;

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g()V

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 1

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result p2

    const/4 p3, 0x1

    const/4 v0, -0x1

    sparse-switch p2, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    const-string p2, "com.ape.offlinescriptmanager.screenshot.services.action.startlistening"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    goto :goto_0

    :sswitch_1
    const-string p2, "com.ape.offlinescriptmanager.screenshot.services.action.resumelistening"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x2

    goto :goto_0

    :sswitch_2
    const-string p2, "com.ape.offlinescriptmanager.screenshot.services.action.pauselistening"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    move v0, p3

    goto :goto_0

    :sswitch_3
    const-string p2, "com.ape.offlinescriptmanager.screenshot.services.action.stoplistening"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_3

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    :goto_0
    packed-switch v0, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->f()V

    goto :goto_1

    :pswitch_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->i()V

    goto :goto_1

    :pswitch_2
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->h()V

    goto :goto_1

    :pswitch_3
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->g()V

    :goto_1
    return p3

    :sswitch_data_0
    .sparse-switch
        -0x3e29eb2d -> :sswitch_3
        -0xf590f15 -> :sswitch_2
        0x1d1d4688 -> :sswitch_1
        0x6b81cbff -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
