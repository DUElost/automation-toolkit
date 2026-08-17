.class public Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;
.super Landroid/app/Service;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;
    }
.end annotation


# static fields
.field private static final s:Landroid/util/SparseIntArray;

.field private static t:I

.field private static u:I

.field private static v:I

.field private static w:I

.field private static x:I

.field private static y:Z

.field private static z:Ljava/lang/String;


# instance fields
.field private b:Z

.field private c:Z

.field private d:Z

.field private e:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

.field private f:Z

.field private g:Landroid/content/ServiceConnection;

.field private h:J

.field private i:J

.field private j:Landroid/content/SharedPreferences;

.field private k:Landroid/view/WindowManager;

.field private l:Landroid/media/projection/MediaProjection;

.field private m:Landroid/hardware/display/VirtualDisplay;

.field private n:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;

.field private o:Landroid/media/MediaRecorder;

.field private p:Landroid/app/NotificationManager;

.field private q:Landroid/app/NotificationChannel;

.field r:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->s:Landroid/util/SparseIntArray;

    const/4 v1, 0x0

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->append(II)V

    const/4 v2, 0x1

    invoke-virtual {v0, v2, v1}, Landroid/util/SparseIntArray;->append(II)V

    const/4 v1, 0x2

    const/16 v2, 0x10e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->append(II)V

    const/4 v1, 0x3

    const/16 v2, 0xb4

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->append(II)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f:Z

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->g:Landroid/content/ServiceConnection;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->i:J

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->q:Landroid/app/NotificationChannel;

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$c;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->r:Landroid/os/Handler;

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    return-object p1
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f:Z

    return p1
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->p()V

    return-void
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->r()V

    return-void
.end method

.method private e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;
    .locals 7

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0e000a

    invoke-static {v0, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "com.ape.offlinescriptmanager.screenrecorder.services.action.stoprecording"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v2}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    new-instance v3, Landroid/content/Intent;

    const-class v4, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

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

    const v6, 0x7f0f028b

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    const v5, 0x7f080079

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    const/16 v5, 0x80

    invoke-static {v0, v5, v5, v2}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    const/4 v0, 0x1

    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    invoke-virtual {v4, v3}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    const/4 v0, 0x2

    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    const v0, 0x7f08007a

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0f028a

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v0, v2, v1}, Landroid/app/Notification$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

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

.method private f()Landroid/hardware/display/VirtualDisplay;
    .locals 9

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    sget v2, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->t:I

    sget v3, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->u:I

    sget v4, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->w:I

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v1}, Landroid/media/MediaRecorder;->getSurface()Landroid/view/Surface;

    move-result-object v6

    const-string v1, "ScreenRecorderActivity"

    const/16 v5, 0x10

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual/range {v0 .. v8}, Landroid/media/projection/MediaProjection;->createVirtualDisplay(Ljava/lang/String;IIIILandroid/view/Surface;Landroid/hardware/display/VirtualDisplay$Callback;Landroid/os/Handler;)Landroid/hardware/display/VirtualDisplay;

    move-result-object v0

    return-object v0
.end method

.method private g()V
    .locals 6

    const-string v0, "SCREENRECORDER"

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v3}, Landroid/media/MediaRecorder;->stop()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->k()V

    const-string v3, "MediaProjection Stopped"

    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->reset()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->m:Landroid/hardware/display/VirtualDisplay;

    invoke-virtual {v0}, Landroid/hardware/display/VirtualDisplay;->release()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    if-eqz v0, :cond_1

    :goto_0
    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->n:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;

    invoke-virtual {v0, v3}, Landroid/media/projection/MediaProjection;->unregisterCallback(Landroid/media/projection/MediaProjection$Callback;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    invoke-virtual {v0}, Landroid/media/projection/MediaProjection;->stop()V

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_0
    move-exception v3

    :try_start_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Fatal exception! Destroying media projection failed.\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v3, Ljava/io/File;

    sget-object v4, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->z:Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "Corrupted file delete successful"

    invoke-static {v0, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const v0, 0x7f0f007c

    invoke-virtual {p0, v0}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->reset()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->m:Landroid/hardware/display/VirtualDisplay;

    invoke-virtual {v0}, Landroid/hardware/display/VirtualDisplay;->release()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->b:Z

    return-void

    :goto_2
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v1}, Landroid/media/MediaRecorder;->reset()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->m:Landroid/hardware/display/VirtualDisplay;

    invoke-virtual {v1}, Landroid/hardware/display/VirtualDisplay;->release()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v1}, Landroid/media/MediaRecorder;->release()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    if-eqz v1, :cond_2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->n:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;

    invoke-virtual {v1, v3}, Landroid/media/projection/MediaProjection;->unregisterCallback(Landroid/media/projection/MediaProjection$Callback;)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    invoke-virtual {v1}, Landroid/media/projection/MediaProjection;->stop()V

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    :cond_2
    throw v0
.end method

.method private h()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v1, 0x7f0f007d

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "yyyyMMdd_hhmmss"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v2, 0x7f0f007e

    invoke-virtual {p0, v2}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "recording"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v2

    new-instance v3, Ljava/text/SimpleDateFormat;

    invoke-direct {v3, v0}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private i()Ljava/lang/String;
    .locals 3

    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    const-string v1, "window"

    invoke-virtual {p0, v1}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager;

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->k:Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget v1, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    sput v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->w:I

    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "x"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private k()V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->z:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$b;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V

    const/4 v2, 0x0

    invoke-static {p0, v0, v2, v1}, Landroid/media/MediaScannerConnection;->scanFile(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;Landroid/media/MediaScannerConnection$OnScanCompletedListener;)V

    return-void
.end method

.method private l()V
    .locals 4

    :try_start_0
    sget-boolean v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->y:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioSource(I)V

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setVideoSource(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setOutputFormat(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    sget-object v2, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->z:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    sget v2, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->t:I

    sget v3, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->u:I

    invoke-virtual {v0, v2, v3}, Landroid/media/MediaRecorder;->setVideoSize(II)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setVideoEncoder(I)V

    sget-boolean v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->y:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    sget v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->x:I

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setVideoEncodingBitRate(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    sget v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->v:I

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setVideoFrameRate(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->k:Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    sget-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->s:Landroid/util/SparseIntArray;

    add-int/lit8 v0, v0, 0x5a

    invoke-virtual {v1, v0}, Landroid/util/SparseIntArray;->get(I)I

    move-result v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v1, v0}, Landroid/media/MediaRecorder;->setOrientationHint(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->prepare()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    :goto_0
    return-void
.end method

.method private m()V
    .locals 6
    .annotation build Landroid/annotation/TargetApi;
        value = 0x1a
    .end annotation

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->pause()V

    iget-wide v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->i:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->h:J

    sub-long/2addr v2, v4

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->i:J

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.screenrecorder.services.action.resumerecording"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    new-instance v2, Landroid/app/Notification$Action;

    const v3, 0x7f0f0289

    invoke-virtual {p0, v3}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x1080024

    invoke-direct {v2, v4, v3, v0}, Landroid/app/Notification$Action;-><init>(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)V

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const/16 v2, 0x1389

    invoke-direct {p0, v0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->s(Landroid/app/Notification;I)V

    const v0, 0x7f0f028c

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    sget-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/a$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/a$a;

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->k(Lcom/ape/offlinescriptmanager/screenrecorder/a$a;)V

    :cond_0
    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->d:Z

    if-eqz v0, :cond_1

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "com.orpheusdroid.screenrecorder.DISABLETOUCH"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/app/Service;->sendBroadcast(Landroid/content/Intent;)V

    :cond_1
    return-void
.end method

.method private n()V
    .locals 6
    .annotation build Landroid/annotation/TargetApi;
        value = 0x1a
    .end annotation

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->resume()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->h:J

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    new-instance v2, Landroid/app/Notification$Action;

    const v3, 0x7f0f0288

    invoke-virtual {p0, v3}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x1080023

    invoke-direct {v2, v4, v3, v0}, Landroid/app/Notification$Action;-><init>(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)V

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->i:J

    sub-long/2addr v2, v4

    invoke-virtual {v0, v2, v3}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const/16 v2, 0x1389

    invoke-direct {p0, v0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->s(Landroid/app/Notification;I)V

    const v0, 0x7f0f028e

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    sget-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/a$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/a$a;

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->k(Lcom/ape/offlinescriptmanager/screenrecorder/a$a;)V

    :cond_0
    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->d:Z

    if-eqz v0, :cond_1

    if-eqz v0, :cond_1

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "com.orpheusdroid.screenrecorder.SHOWTOUCH"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/app/Service;->sendBroadcast(Landroid/content/Intent;)V

    :cond_1
    return-void
.end method

.method private o(Ljava/lang/String;)V
    .locals 1

    const-string v0, "x"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    aget-object v0, p1, v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->t:I

    const/4 v0, 0x1

    aget-object p1, p1, v0

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    sput p1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->u:I

    return-void
.end method

.method private p()V
    .locals 6

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0e000a

    invoke-static {v0, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    new-instance v2, Landroid/content/Intent;

    const-class v3, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    sget-object v3, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->z:Ljava/lang/String;

    const-string v4, "edit_video"

    invoke-virtual {v2, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 v3, 0x0

    const/high16 v4, 0x8000000

    invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    const v5, 0x7f0f0296

    invoke-virtual {p0, v5}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v5}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v1

    invoke-static {p0, v3, v1, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    new-instance v4, Landroidx/core/app/g$b;

    invoke-direct {v4, p0}, Landroidx/core/app/g$b;-><init>(Landroid/content/Context;)V

    const v5, 0x7f0f0295

    invoke-virtual {p0, v5}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroidx/core/app/g$b;->i(Ljava/lang/CharSequence;)Landroidx/core/app/g$b;

    const v5, 0x7f0f0294

    invoke-virtual {p0, v5}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroidx/core/app/g$b;->h(Ljava/lang/CharSequence;)Landroidx/core/app/g$b;

    const v5, 0x7f080079

    invoke-virtual {v4, v5}, Landroidx/core/app/g$b;->l(I)Landroidx/core/app/g$b;

    const/16 v5, 0x80

    invoke-static {v0, v5, v5, v3}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroidx/core/app/g$b;->k(Landroid/graphics/Bitmap;)Landroidx/core/app/g$b;

    const/4 v0, 0x1

    invoke-virtual {v4, v0}, Landroidx/core/app/g$b;->f(Z)Landroidx/core/app/g$b;

    invoke-virtual {v4, v1}, Landroidx/core/app/g$b;->g(Landroid/app/PendingIntent;)Landroidx/core/app/g$b;

    const v0, 0x7f0f0293

    invoke-virtual {p0, v0}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v3, 0x1080052

    invoke-virtual {v4, v3, v0, v1}, Landroidx/core/app/g$b;->a(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroidx/core/app/g$b;

    const v0, 0x7f0f0070

    invoke-virtual {p0, v0}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x108003e

    invoke-virtual {v4, v1, v0, v2}, Landroidx/core/app/g$b;->a(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroidx/core/app/g$b;

    invoke-virtual {v4}, Landroidx/core/app/g$b;->b()Landroid/app/Notification;

    move-result-object v0

    const/16 v1, 0x138a

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->s(Landroid/app/Notification;I)V

    return-void
.end method

.method private q(Landroid/app/Notification;I)V
    .locals 0

    invoke-virtual {p0, p2, p1}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;)V

    return-void
.end method

.method private r()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->m:Landroid/hardware/display/VirtualDisplay;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->g()V

    return-void
.end method

.method private s(Landroid/app/Notification;I)V
    .locals 1

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    invoke-virtual {v0, p2, p1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void
.end method


# virtual methods
.method public j()V
    .locals 5

    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v1, 0x7f0f0280

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->i()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v1, 0x7f0f007f

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "30"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->v:I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v1, 0x7f0f0054

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "7130317"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->x:I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v1, 0x7f0f004f

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    sput-boolean v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->y:Z

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v1, 0x7f0f0287

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v3, Lcom/ape/offlinescriptmanager/screenrecorder/a;->a:Ljava/lang/String;

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v3

    const-string v4, "mounted"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    :cond_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v3, 0x7f0f026d

    invoke-virtual {p0, v3}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->c:Z

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j:Landroid/content/SharedPreferences;

    const v3, 0x7f0f0279

    invoke-virtual {p0, v3}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->d:Z

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->h()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ".mp4"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->z:Ljava/lang/String;

    return-void
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

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->p:Landroid/app/NotificationManager;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    new-instance v0, Landroid/app/NotificationChannel;

    const/4 v1, 0x3

    const-string v2, "offlinescriptmanager_id"

    const-string v3, "offlinescriptmanager_name"

    invoke-direct {v0, v2, v3, v1}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->q:Landroid/app/NotificationChannel;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->enableLights(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->q:Landroid/app/NotificationChannel;

    const v1, -0xff0100

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setLightColor(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->q:Landroid/app/NotificationChannel;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->p:Landroid/app/NotificationManager;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->q:Landroid/app/NotificationChannel;

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 0

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 5

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I

    move-result p3

    const-string v0, "com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording"

    const/4 v1, -0x1

    const/4 v2, 0x1

    const/4 v3, 0x0

    sparse-switch p3, :sswitch_data_0

    :goto_0
    move p2, v1

    goto :goto_1

    :sswitch_0
    const-string p3, "com.ape.offlinescriptmanager.screenrecorder.services.action.startrecording"

    invoke-virtual {p2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    const/4 p2, 0x3

    goto :goto_1

    :sswitch_1
    const-string p3, "com.ape.offlinescriptmanager.screenrecorder.services.action.resumerecording"

    invoke-virtual {p2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1

    goto :goto_0

    :cond_1
    const/4 p2, 0x2

    goto :goto_1

    :sswitch_2
    const-string p3, "com.ape.offlinescriptmanager.screenrecorder.services.action.stoprecording"

    invoke-virtual {p2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_2

    goto :goto_0

    :cond_2
    move p2, v2

    goto :goto_1

    :sswitch_3
    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_3

    goto :goto_0

    :cond_3
    move p2, v3

    :goto_1
    const/16 p3, 0x20

    packed-switch p2, :pswitch_data_0

    goto/16 :goto_4

    :pswitch_0
    iget-boolean p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->b:Z

    if-nez p2, :cond_8

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->j()V

    const-string p2, "recorder_intent_data"

    invoke-virtual {p1, p2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p2

    check-cast p2, Landroid/content/Intent;

    const-string v4, "recorder_intent_result"

    invoke-virtual {p1, v4, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    new-instance v1, Landroid/media/MediaRecorder;

    invoke-direct {v1}, Landroid/media/MediaRecorder;-><init>()V

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l()V

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;

    const/4 v4, 0x0

    invoke-direct {v1, p0, v4}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;)V

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->n:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;

    const-string v1, "media_projection"

    invoke-virtual {p0, v1}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/projection/MediaProjectionManager;

    invoke-virtual {v1, p1, p2}, Landroid/media/projection/MediaProjectionManager;->getMediaProjection(ILandroid/content/Intent;)Landroid/media/projection/MediaProjection;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->l:Landroid/media/projection/MediaProjection;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->n:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;

    invoke-virtual {p1, p2, v4}, Landroid/media/projection/MediaProjection;->registerCallback(Landroid/media/projection/MediaProjection$Callback;Landroid/os/Handler;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f()Landroid/hardware/display/VirtualDisplay;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->m:Landroid/hardware/display/VirtualDisplay;

    :try_start_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->o:Landroid/media/MediaRecorder;

    invoke-virtual {p1}, Landroid/media/MediaRecorder;->start()V

    iget-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->c:Z

    if-eqz p1, :cond_4

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/app/Service;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->g:Landroid/content/ServiceConnection;

    invoke-virtual {p0, p1, p2, v2}, Landroid/app/Service;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    :cond_4
    iget-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f:Z

    if-eqz p1, :cond_5

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    sget-object p2, Lcom/ape/offlinescriptmanager/screenrecorder/a$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/a$a;

    invoke-virtual {p1, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->k(Lcom/ape/offlinescriptmanager/screenrecorder/a$a;)V

    :cond_5
    iput-boolean v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->b:Z

    iget-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->d:Z

    if-eqz p1, :cond_6

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string p2, "com.orpheusdroid.screenrecorder.SHOWTOUCH"

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p1, p3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/app/Service;->sendBroadcast(Landroid/content/Intent;)V

    :cond_6
    const p1, 0x7f0f028f

    invoke-static {p0, p1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    const-string p1, "SCREENRECORDER"

    const-string p2, "Mediarecorder reached Illegal state exception. Did you start the recording twice?"

    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const p1, 0x7f0f027f

    invoke-static {p0, p1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    iput-boolean v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->b:Z

    :goto_2
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0x1a

    const/16 p3, 0x1389

    if-lt p1, p2, :cond_7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->h:J

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-static {p0, v3, p1, v3}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    new-instance p2, Landroid/app/Notification$Action;

    const v0, 0x1080023

    const v1, 0x7f0f0288

    invoke-virtual {p0, v1}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p2, v0, v1, p1}, Landroid/app/Notification$Action;-><init>(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)V

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object p1

    goto :goto_3

    :cond_7
    invoke-direct {p0, v4}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->e(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object p1

    :goto_3
    invoke-virtual {p1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p1

    invoke-direct {p0, p1, p3}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->q(Landroid/app/Notification;I)V

    goto :goto_4

    :cond_8
    const p1, 0x7f0f0291

    invoke-static {p0, p1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_4

    :pswitch_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->n()V

    goto :goto_4

    :pswitch_2
    iget-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->f:Z

    if-eqz p1, :cond_9

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->g:Landroid/content/ServiceConnection;

    invoke-virtual {p0, p1}, Landroid/app/Service;->unbindService(Landroid/content/ServiceConnection;)V

    :cond_9
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->r()V

    iget-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->d:Z

    if-eqz p1, :cond_a

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string p2, "com.orpheusdroid.screenrecorder.DISABLETOUCH"

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p1, p3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/app/Service;->sendBroadcast(Landroid/content/Intent;)V

    :cond_a
    invoke-virtual {p0, v2}, Landroid/app/Service;->stopForeground(Z)V

    goto :goto_4

    :pswitch_3
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->m()V

    :goto_4
    return v2

    nop

    :sswitch_data_0
    .sparse-switch
        -0xaca6d23 -> :sswitch_3
        0x208f25cd -> :sswitch_2
        0x36887682 -> :sswitch_1
        0x70106df1 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
