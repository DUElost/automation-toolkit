.class public Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;
.super Landroid/app/Service;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$e;
    }
.end annotation


# instance fields
.field private b:Landroid/view/WindowManager;

.field private c:Landroid/widget/LinearLayout;

.field private d:Landroid/view/View;

.field private e:Landroid/widget/ImageButton;

.field private f:Landroid/widget/ImageButton;

.field private g:Landroid/os/IBinder;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$e;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$e;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->g:Landroid/os/IBinder;

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    return-object p0
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->h()V

    return-void
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f()V

    return-void
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/widget/LinearLayout;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->c:Landroid/widget/LinearLayout;

    return-object p0
.end method

.method static synthetic e(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/WindowManager;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->b:Landroid/view/WindowManager;

    return-object p0
.end method

.method private f()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->l(II)Landroid/animation/ValueAnimator;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$b;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    return-void
.end method

.method private g(I)I
    .locals 2

    invoke-virtual {p0}, Landroid/app/Service;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    int-to-float p1, p1

    iget v0, v0, Landroid/util/DisplayMetrics;->xdpi:F

    const/high16 v1, 0x43200000    # 160.0f

    div-float/2addr v0, v1

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private h()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {v1, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-static {v1, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    invoke-virtual {v3, v0, v2}, Landroid/view/View;->measure(II)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getMeasuredWidth()I

    move-result v0

    invoke-direct {p0, v1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->l(II)Landroid/animation/ValueAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    return-void
.end method

.method private i()V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/app/Service;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method private j()V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.screenrecorder.services.action.resumerecording"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/app/Service;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method private l(II)Landroid/animation/ValueAnimator;
    .locals 2

    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x0

    aput p1, v0, v1

    const/4 p1, 0x1

    aput p2, v0, p1

    invoke-static {v0}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$c;

    invoke-direct {p2, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V

    invoke-virtual {p1, p2}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    return-object p1
.end method

.method private m()V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.ape.offlinescriptmanager.screenrecorder.services.action.stoprecording"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/app/Service;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method


# virtual methods
.method public k(Lcom/ape/offlinescriptmanager/screenrecorder/a$a;)V
    .locals 3

    sget-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$d;->a:[I

    invoke-virtual {p1}, Ljava/lang/Enum;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eq p1, v1, :cond_1

    const/4 v2, 0x2

    if-eq p1, v2, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->e:Landroid/widget/ImageButton;

    invoke-virtual {p1, v1}, Landroid/widget/ImageButton;->setEnabled(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setEnabled(Z)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->e:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setEnabled(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f:Landroid/widget/ImageButton;

    invoke-virtual {p1, v1}, Landroid/widget/ImageButton;->setEnabled(Z)V

    :goto_0
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1

    const-string p1, "SCREENRECORDER"

    const-string v0, "Binding successful!"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->g:Landroid/os/IBinder;

    return-object p1
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090145

    if-eq p1, v0, :cond_2

    const v0, 0x7f09015a

    if-eq p1, v0, :cond_1

    const v0, 0x7f090189

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->m()V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->j()V

    goto :goto_0

    :cond_2
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->i()V

    :goto_0
    const-string p1, "vibrator"

    invoke-virtual {p0, p1}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/Vibrator;

    const-wide/16 v0, 0x64

    invoke-virtual {p1, v0, v1}, Landroid/os/Vibrator;->vibrate(J)V

    return-void
.end method

.method public onDestroy()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->c:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->b:Landroid/view/WindowManager;

    invoke-interface {v1, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    :cond_0
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 7

    const-string p1, "window"

    invoke-virtual {p0, p1}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/WindowManager;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->b:Landroid/view/WindowManager;

    const-string p1, "layout_inflater"

    invoke-virtual {p0, p1}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/LayoutInflater;

    const p2, 0x7f0c0055

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/LinearLayout;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->c:Landroid/widget/LinearLayout;

    const p2, 0x7f09008f

    invoke-virtual {p1, p2}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    const p2, 0x7f090189

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageButton;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    const p3, 0x7f090145

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageButton;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->e:Landroid/widget/ImageButton;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    const p3, 0x7f09015a

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageButton;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f:Landroid/widget/ImageButton;

    const/4 p3, 0x0

    invoke-virtual {p2, p3}, Landroid/widget/ImageButton;->setEnabled(Z)V

    invoke-virtual {p1, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p1

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x18

    if-ge p2, v0, :cond_0

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->e:Landroid/widget/ImageButton;

    const/16 v0, 0x8

    invoke-virtual {p2, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f:Landroid/widget/ImageButton;

    invoke-virtual {p2, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    const v1, 0x7f0900c0

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d:Landroid/view/View;

    const v1, 0x7f0900c1

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->e:Landroid/widget/ImageButton;

    invoke-virtual {p2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f:Landroid/widget/ImageButton;

    invoke-virtual {p2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :goto_0
    new-instance p2, Landroid/view/WindowManager$LayoutParams;

    const/4 v1, -0x2

    const v0, 0x7f0f026e

    invoke-virtual {p0, v0}, Landroid/app/Service;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/16 v6, 0x64

    invoke-interface {p1, v0, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->g(I)I

    move-result v2

    const/16 v3, 0x7d2

    const/16 v4, 0x8

    const/4 v5, -0x3

    move-object v0, p2

    invoke-direct/range {v0 .. v5}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    const p1, 0x800033

    iput p1, p2, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iput p3, p2, Landroid/view/WindowManager$LayoutParams;->x:I

    iput v6, p2, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->b:Landroid/view/WindowManager;

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->c:Landroid/widget/LinearLayout;

    invoke-interface {p1, p3, p2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :try_start_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->c:Landroid/widget/LinearLayout;

    new-instance p3, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;

    invoke-direct {p3, p0, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;Landroid/view/WindowManager$LayoutParams;)V

    invoke-virtual {p1, p3}, Landroid/widget/LinearLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 p1, 0x1

    return p1
.end method

.method public onUnbind(Landroid/content/Intent;)Z
    .locals 2

    const-string v0, "SCREENRECORDER"

    const-string v1, "Unbinding and stopping service"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Landroid/app/Service;->stopSelf()V

    invoke-super {p0, p1}, Landroid/app/Service;->onUnbind(Landroid/content/Intent;)Z

    move-result p1

    return p1
.end method
