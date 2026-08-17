.class public Lcom/ape/offlinescriptmanager/crashlistener/b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/crashlistener/b$c;,
        Lcom/ape/offlinescriptmanager/crashlistener/b$d;
    }
.end annotation


# static fields
.field private static k:Landroid/content/Intent;


# instance fields
.field private a:Landroid/content/Context;

.field private b:Landroid/media/projection/MediaProjection;

.field private c:Landroid/hardware/display/VirtualDisplay;

.field private d:I

.field private e:I

.field private f:I

.field private g:Landroid/media/ImageReader;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->i()V

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/crashlistener/b;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->l()V

    return-void
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/crashlistener/b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->h:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/crashlistener/b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->i:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/crashlistener/b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->j:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic e(Lcom/ape/offlinescriptmanager/crashlistener/b;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    return-object p0
.end method

.method private f()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->g:Landroid/media/ImageReader;

    if-nez v0, :cond_0

    iget v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->d:I

    iget v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->e:I

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v2}, Landroid/media/ImageReader;->newInstance(IIII)Landroid/media/ImageReader;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->g:Landroid/media/ImageReader;

    :cond_0
    return-void
.end method

.method private h()Landroid/media/projection/MediaProjectionManager;
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const-string v1, "media_projection"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/projection/MediaProjectionManager;

    return-object v0
.end method

.method public static j(Landroid/content/Intent;)V
    .locals 0

    sput-object p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->k:Landroid/content/Intent;

    return-void
.end method

.method private l()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->g:Landroid/media/ImageReader;

    invoke-virtual {v0}, Landroid/media/ImageReader;->acquireLatestImage()Landroid/media/Image;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->m()V

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/b$d;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/b$d;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/b;)V

    const/4 v2, 0x1

    new-array v2, v2, [Landroid/media/Image;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/crashlistener/b$c;->a(Landroid/os/AsyncTask;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    :goto_0
    return-void
.end method

.method private o()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->c:Landroid/hardware/display/VirtualDisplay;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/hardware/display/VirtualDisplay;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->c:Landroid/hardware/display/VirtualDisplay;

    return-void
.end method

.method private p()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->b:Landroid/media/projection/MediaProjection;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/projection/MediaProjection;->stop()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->b:Landroid/media/projection/MediaProjection;

    :cond_0
    return-void
.end method

.method private q()V
    .locals 9

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->f()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->b:Landroid/media/projection/MediaProjection;

    iget v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->d:I

    iget v3, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->e:I

    iget v4, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->f:I

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->g:Landroid/media/ImageReader;

    invoke-virtual {v1}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v6

    const-string v1, "screen-mirror"

    const/16 v5, 0x10

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual/range {v0 .. v8}, Landroid/media/projection/MediaProjection;->createVirtualDisplay(Ljava/lang/String;IIIILandroid/view/Surface;Landroid/hardware/display/VirtualDisplay$Callback;Landroid/os/Handler;)Landroid/hardware/display/VirtualDisplay;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->c:Landroid/hardware/display/VirtualDisplay;

    return-void
.end method


# virtual methods
.method public g()V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->o()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->p()V

    return-void
.end method

.method public i()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget v0, v1, Landroid/util/DisplayMetrics;->densityDpi:I

    iput v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->f:I

    iget v0, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->d:I

    iget v0, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->e:I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const v2, 0x7f0f0066

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->t()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->h:Ljava/lang/String;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const v2, 0x7f0f005f

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const v3, 0x7f0f0062

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->i:Ljava/lang/String;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const v2, 0x7f0f0060

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    const v3, 0x7f0f0065

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->j:Ljava/lang/String;

    return-void
.end method

.method public k()V
    .locals 3

    sget-object v0, Lcom/ape/offlinescriptmanager/crashlistener/b;->k:Landroid/content/Intent;

    if-nez v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.MAIN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.intent.category.LAUNCHER"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->h()Landroid/media/projection/MediaProjectionManager;

    move-result-object v0

    const/4 v1, -0x1

    sget-object v2, Lcom/ape/offlinescriptmanager/crashlistener/b;->k:Landroid/content/Intent;

    invoke-virtual {v0, v1, v2}, Landroid/media/projection/MediaProjectionManager;->getMediaProjection(ILandroid/content/Intent;)Landroid/media/projection/MediaProjection;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->b:Landroid/media/projection/MediaProjection;

    :goto_0
    return-void
.end method

.method public m()V
    .locals 4

    new-instance v0, Landroid/os/Handler;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->a:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/b$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/b$a;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/b;)V

    const-wide/16 v2, 0x5

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/b$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/b$b;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/b;)V

    const-wide/16 v2, 0x1e

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public n()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/b;->b:Landroid/media/projection/MediaProjection;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->k()V

    :goto_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/b;->q()V

    return-void
.end method
