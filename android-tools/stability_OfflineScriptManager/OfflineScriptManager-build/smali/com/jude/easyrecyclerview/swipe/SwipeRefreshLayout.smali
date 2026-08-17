.class public Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;
.super Landroid/widget/FrameLayout;
.source ""


# static fields
.field private static final J:Ljava/lang/String;

.field private static final K:[I


# instance fields
.field private A:Landroid/view/animation/Animation;

.field private B:F

.field private C:Z

.field private D:I

.field private E:I

.field private F:Z

.field private G:Landroid/view/animation/Animation$AnimationListener;

.field private final H:Landroid/view/animation/Animation;

.field private final I:Landroid/view/animation/Animation;

.field private b:Landroid/view/View;

.field private c:La/l/a/a;

.field private d:Z

.field private e:I

.field private f:F

.field private g:I

.field private h:I

.field private i:Z

.field private j:F

.field private k:F

.field private l:Z

.field private m:I

.field private n:Z

.field private o:Z

.field private final p:Landroid/view/animation/DecelerateInterpolator;

.field private q:Lcom/jude/easyrecyclerview/swipe/a;

.field private r:I

.field protected s:I

.field private t:F

.field protected u:I

.field private v:Lcom/jude/easyrecyclerview/swipe/b;

.field private w:Landroid/view/animation/Animation;

.field private x:Landroid/view/animation/Animation;

.field private y:Landroid/view/animation/Animation;

.field private z:Landroid/view/animation/Animation;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const-class v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->J:Ljava/lang/String;

    const/4 v0, 0x1

    new-array v0, v0, [I

    const/4 v1, 0x0

    const v2, 0x101000e

    aput v2, v0, v1

    sput-object v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->K:[I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 3

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    const/high16 v1, -0x40800000    # -1.0f

    iput v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->i:Z

    const/4 v1, -0x1

    iput v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    iput v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->r:I

    new-instance v1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;

    invoke-direct {v1, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->G:Landroid/view/animation/Animation$AnimationListener;

    new-instance v1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;

    invoke-direct {v1, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->H:Landroid/view/animation/Animation;

    new-instance v1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$g;

    invoke-direct {v1, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$g;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->I:Landroid/view/animation/Animation;

    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v1

    iput v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->e:I

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x10e0001

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    iput v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->g:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->setWillNotDraw(Z)V

    new-instance v1, Landroid/view/animation/DecelerateInterpolator;

    const/high16 v2, 0x40000000    # 2.0f

    invoke-direct {v1, v2}, Landroid/view/animation/DecelerateInterpolator;-><init>(F)V

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->p:Landroid/view/animation/DecelerateInterpolator;

    sget-object v1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->K:[I

    invoke-virtual {p1, p2, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object p1

    const/4 p2, 0x1

    invoke-virtual {p1, v0, p2}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v0

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->setEnabled(Z)V

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p1

    iget v0, p1, Landroid/util/DisplayMetrics;->density:F

    const/high16 v1, 0x42200000    # 40.0f

    mul-float v2, v0, v1

    float-to-int v2, v2

    iput v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->D:I

    mul-float/2addr v0, v1

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->E:I

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->t()V

    invoke-static {p0, p2}, La/f/l/r;->T(Landroid/view/ViewGroup;Z)V

    iget p1, p1, Landroid/util/DisplayMetrics;->density:F

    const/high16 v0, 0x42800000    # 64.0f

    mul-float/2addr p1, v0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B:F

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    invoke-virtual {p0, p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->requestDisallowInterceptTouchEvent(Z)V

    return-void
.end method

.method private A(ZZ)V
    .locals 1

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    if-eq v0, p1, :cond_1

    iput-boolean p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->C:Z

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u()V

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    if-eqz p1, :cond_0

    iget p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->G:Landroid/view/animation/Animation$AnimationListener;

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q(ILandroid/view/animation/Animation$AnimationListener;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->G:Landroid/view/animation/Animation$AnimationListener;

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F(Landroid/view/animation/Animation$AnimationListener;)V

    :cond_1
    :goto_0
    return-void
.end method

.method private B(IZ)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0}, Landroid/widget/ImageView;->bringToFront()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->offsetTopAndBottom(I)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getTop()I

    move-result p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    if-eqz p2, :cond_0

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0xb

    if-ge p1, p2, :cond_0

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->invalidate()V

    :cond_0
    return-void
.end method

.method private C(II)Landroid/view/animation/Animation;
    .locals 2

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->w()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    new-instance v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;

    invoke-direct {v0, p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;II)V

    const-wide/16 p1, 0x12c

    invoke-virtual {v0, p1, p2}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1, v1}, Lcom/jude/easyrecyclerview/swipe/a;->d(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->clearAnimation()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    return-object v0
.end method

.method private D()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b;->getAlpha()I

    move-result v0

    const/16 v1, 0xff

    invoke-direct {p0, v0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->C(II)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->z:Landroid/view/animation/Animation;

    return-void
.end method

.method private E()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b;->getAlpha()I

    move-result v0

    const/16 v1, 0x4c

    invoke-direct {p0, v0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->C(II)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->y:Landroid/view/animation/Animation;

    return-void
.end method

.method private F(Landroid/view/animation/Animation$AnimationListener;)V
    .locals 3

    new-instance v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$c;

    invoke-direct {v0, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$c;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->x:Landroid/view/animation/Animation;

    const-wide/16 v1, 0x96

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/a;->d(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->clearAnimation()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->x:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method private G(ILandroid/view/animation/Animation$AnimationListener;)V
    .locals 2

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s:I

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->w()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b;->getAlpha()I

    move-result p1

    int-to-float p1, p1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-static {p1}, La/f/l/r;->v(Landroid/view/View;)F

    move-result p1

    :goto_0
    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->t:F

    new-instance p1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;

    invoke-direct {p1, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->A:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x96

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    if-eqz p2, :cond_1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1, p2}, Lcom/jude/easyrecyclerview/swipe/a;->d(Landroid/view/animation/Animation$AnimationListener;)V

    :cond_1
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->clearAnimation()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->A:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method private H(Landroid/view/animation/Animation$AnimationListener;)V
    .locals 3

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    const/16 v1, 0xff

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/b;->setAlpha(I)V

    :cond_0
    new-instance v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$b;

    invoke-direct {v0, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$b;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->w:Landroid/view/animation/Animation;

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->g:I

    int-to-long v1, v1

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/a;->d(Landroid/view/animation/Animation$AnimationListener;)V

    :cond_1
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->clearAnimation()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->w:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method static synthetic a(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    return p0
.end method

.method static synthetic b(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/b;
    .locals 0

    iget-object p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    return-object p0
.end method

.method static synthetic c(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;Landroid/view/animation/Animation$AnimationListener;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F(Landroid/view/animation/Animation$AnimationListener;)V

    return-void
.end method

.method static synthetic d(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F:Z

    return p0
.end method

.method static synthetic e(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)F
    .locals 0

    iget p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B:F

    return p0
.end method

.method static synthetic f(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;F)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->y(F)V

    return-void
.end method

.method static synthetic g(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)F
    .locals 0

    iget p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->t:F

    return p0
.end method

.method static synthetic h(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->C:Z

    return p0
.end method

.method static synthetic i(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)La/l/a/a;
    .locals 0

    iget-object p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->c:La/l/a/a;

    return-object p0
.end method

.method static synthetic j(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/a;
    .locals 0

    iget-object p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    return-object p0
.end method

.method static synthetic k(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setColorViewAlpha(I)V

    return-void
.end method

.method static synthetic l(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n:Z

    return p0
.end method

.method static synthetic m(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;F)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setAnimationProgress(F)V

    return-void
.end method

.method static synthetic n(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)I
    .locals 0

    iget p0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    return p0
.end method

.method static synthetic o(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;I)I
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    return p1
.end method

.method static synthetic p(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;IZ)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B(IZ)V

    return-void
.end method

.method private q(ILandroid/view/animation/Animation$AnimationListener;)V
    .locals 2

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s:I

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->H:Landroid/view/animation/Animation;

    invoke-virtual {p1}, Landroid/view/animation/Animation;->reset()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->H:Landroid/view/animation/Animation;

    const-wide/16 v0, 0xc8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->H:Landroid/view/animation/Animation;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->p:Landroid/view/animation/DecelerateInterpolator;

    invoke-virtual {p1, v0}, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    if-eqz p2, :cond_0

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1, p2}, Lcom/jude/easyrecyclerview/swipe/a;->d(Landroid/view/animation/Animation$AnimationListener;)V

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->clearAnimation()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->H:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method private r(ILandroid/view/animation/Animation$AnimationListener;)V
    .locals 2

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->G(ILandroid/view/animation/Animation$AnimationListener;)V

    goto :goto_0

    :cond_0
    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s:I

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->I:Landroid/view/animation/Animation;

    invoke-virtual {p1}, Landroid/view/animation/Animation;->reset()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->I:Landroid/view/animation/Animation;

    const-wide/16 v0, 0xc8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->I:Landroid/view/animation/Animation;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->p:Landroid/view/animation/DecelerateInterpolator;

    invoke-virtual {p1, v0}, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    if-eqz p2, :cond_1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1, p2}, Lcom/jude/easyrecyclerview/swipe/a;->d(Landroid/view/animation/Animation$AnimationListener;)V

    :cond_1
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->clearAnimation()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->I:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    :goto_0
    return-void
.end method

.method private setAnimationProgress(F)V
    .locals 1

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->w()Z

    move-result v0

    if-eqz v0, :cond_0

    const/high16 v0, 0x437f0000    # 255.0f

    mul-float/2addr p1, v0

    float-to-int p1, p1

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setColorViewAlpha(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-static {v0, p1}, La/f/l/r;->e0(Landroid/view/View;F)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-static {v0, p1}, La/f/l/r;->f0(Landroid/view/View;F)V

    :goto_0
    return-void
.end method

.method private setColorViewAlpha(I)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b;->setAlpha(I)V

    return-void
.end method

.method private t()V
    .locals 4

    new-instance v0, Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, -0x50506

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {v0, v1, v2, v3}, Lcom/jude/easyrecyclerview/swipe/a;-><init>(Landroid/content/Context;IF)V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    new-instance v0, Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, p0}, Lcom/jude/easyrecyclerview/swipe/b;-><init>(Landroid/content/Context;Landroid/view/View;)V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, v2}, Lcom/jude/easyrecyclerview/swipe/b;->k(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    return-void
.end method

.method private u()V
    .locals 4

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    if-nez v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_1

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-class v3, Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v2, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v2

    if-eqz v2, :cond_0

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    goto :goto_1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method private v(Landroid/view/MotionEvent;I)F
    .locals 0

    invoke-static {p1, p2}, La/f/l/h;->a(Landroid/view/MotionEvent;I)I

    move-result p2

    if-gez p2, :cond_0

    const/high16 p1, -0x40800000    # -1.0f

    return p1

    :cond_0
    invoke-static {p1, p2}, La/f/l/h;->e(Landroid/view/MotionEvent;I)F

    move-result p1

    return p1
.end method

.method private w()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-ge v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private x(Landroid/view/animation/Animation;)Z
    .locals 1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/view/animation/Animation;->hasStarted()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/animation/Animation;->hasEnded()Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private y(F)V
    .locals 2

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s:I

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    sub-int/2addr v1, v0

    int-to-float v1, v1

    mul-float/2addr v1, p1

    float-to-int p1, v1

    add-int/2addr v0, p1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getTop()I

    move-result p1

    sub-int/2addr v0, p1

    const/4 p1, 0x0

    invoke-direct {p0, v0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B(IZ)V

    return-void
.end method

.method private z(Landroid/view/MotionEvent;)V
    .locals 3

    invoke-static {p1}, La/f/l/h;->b(Landroid/view/MotionEvent;)I

    move-result v0

    invoke-static {p1, v0}, La/f/l/h;->d(Landroid/view/MotionEvent;I)I

    move-result v1

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    if-ne v1, v2, :cond_1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {p1, v0}, La/f/l/h;->d(Landroid/view/MotionEvent;I)I

    move-result p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    :cond_1
    return-void
.end method


# virtual methods
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method protected getChildDrawingOrder(II)I
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->r:I

    if-gez v0, :cond_0

    return p2

    :cond_0
    add-int/lit8 p1, p1, -0x1

    if-ne p2, p1, :cond_1

    return v0

    :cond_1
    if-lt p2, v0, :cond_2

    add-int/lit8 p2, p2, 0x1

    :cond_2
    return p2
.end method

.method public getProgressCircleDiameter()I
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/widget/ImageView;->getMeasuredHeight()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 6

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u()V

    invoke-static {p1}, La/f/l/h;->c(Landroid/view/MotionEvent;)I

    move-result v0

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    if-nez v0, :cond_0

    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o:Z

    :cond_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->isEnabled()Z

    move-result v1

    if-eqz v1, :cond_a

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o:Z

    if-nez v1, :cond_a

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s()Z

    move-result v1

    if-nez v1, :cond_a

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    if-eqz v1, :cond_1

    goto/16 :goto_1

    :cond_1
    const/high16 v1, -0x40800000    # -1.0f

    const/4 v3, 0x1

    if-eqz v0, :cond_7

    const/4 v4, -0x1

    if-eq v0, v3, :cond_6

    const/4 v5, 0x2

    if-eq v0, v5, :cond_3

    const/4 v1, 0x3

    if-eq v0, v1, :cond_6

    const/4 v1, 0x6

    if-eq v0, v1, :cond_2

    goto :goto_0

    :cond_2
    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->z(Landroid/view/MotionEvent;)V

    goto :goto_0

    :cond_3
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    if-ne v0, v4, :cond_4

    sget-object p1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->J:Ljava/lang/String;

    const-string v0, "Got ACTION_MOVE event but don\'t have an active pointer id."

    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    :cond_4
    invoke-direct {p0, p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v(Landroid/view/MotionEvent;I)F

    move-result p1

    cmpl-float v0, p1, v1

    if-nez v0, :cond_5

    return v2

    :cond_5
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->k:F

    sub-float/2addr p1, v0

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->e:I

    int-to-float v2, v1

    cmpl-float p1, p1, v2

    if-lez p1, :cond_9

    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    if-nez p1, :cond_9

    int-to-float p1, v1

    add-float/2addr v0, p1

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->j:F

    iput-boolean v3, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    const/16 v0, 0x4c

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/swipe/b;->setAlpha(I)V

    goto :goto_0

    :cond_6
    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    iput v4, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    goto :goto_0

    :cond_7
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    iget-object v4, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v4}, Landroid/widget/ImageView;->getTop()I

    move-result v4

    sub-int/2addr v0, v4

    invoke-direct {p0, v0, v3}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B(IZ)V

    invoke-static {p1, v2}, La/f/l/h;->d(Landroid/view/MotionEvent;I)I

    move-result v0

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    invoke-direct {p0, p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v(Landroid/view/MotionEvent;I)F

    move-result p1

    cmpl-float v0, p1, v1

    if-nez v0, :cond_8

    return v2

    :cond_8
    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->k:F

    :cond_9
    :goto_0
    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    return p1

    :cond_a
    :goto_1
    return v2
.end method

.method protected onLayout(ZIIII)V
    .locals 2

    invoke-super/range {p0 .. p5}, Landroid/widget/FrameLayout;->onLayout(ZIIII)V

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getMeasuredWidth()I

    move-result p1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getMeasuredHeight()I

    move-result p2

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getChildCount()I

    move-result p3

    if-nez p3, :cond_0

    return-void

    :cond_0
    iget-object p3, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    if-nez p3, :cond_1

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u()V

    :cond_1
    iget-object p3, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    if-nez p3, :cond_2

    return-void

    :cond_2
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingLeft()I

    move-result p4

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingTop()I

    move-result p5

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingLeft()I

    move-result v0

    sub-int v0, p1, v0

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingRight()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingTop()I

    move-result v1

    sub-int/2addr p2, v1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingBottom()I

    move-result v1

    sub-int/2addr p2, v1

    add-int/2addr v0, p4

    add-int/2addr p2, p5

    invoke-virtual {p3, p4, p5, v0, p2}, Landroid/view/View;->layout(IIII)V

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p2}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result p2

    iget-object p3, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p3}, Landroid/widget/ImageView;->getMeasuredHeight()I

    move-result p3

    iget-object p4, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    div-int/lit8 p1, p1, 0x2

    div-int/lit8 p2, p2, 0x2

    sub-int p5, p1, p2

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    add-int/2addr p1, p2

    add-int/2addr p3, v0

    invoke-virtual {p4, p5, v0, p1, p3}, Landroid/widget/ImageView;->layout(IIII)V

    return-void
.end method

.method public onMeasure(II)V
    .locals 3

    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->onMeasure(II)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    if-nez p1, :cond_0

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u()V

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    if-nez p1, :cond_1

    return-void

    :cond_1
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getMeasuredWidth()I

    move-result p2

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingLeft()I

    move-result v0

    sub-int/2addr p2, v0

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingRight()I

    move-result v0

    sub-int/2addr p2, v0

    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {p2, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getMeasuredHeight()I

    move-result v1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingTop()I

    move-result v2

    sub-int/2addr v1, v2

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getPaddingBottom()I

    move-result v2

    sub-int/2addr v1, v2

    invoke-static {v1, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v1

    invoke-virtual {p1, p2, v1}, Landroid/view/View;->measure(II)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->D:I

    invoke-static {p2, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->E:I

    invoke-static {v1, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-virtual {p1, p2, v0}, Landroid/widget/ImageView;->measure(II)V

    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F:Z

    if-nez p1, :cond_2

    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->i:Z

    if-nez p1, :cond_2

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->i:Z

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getMeasuredHeight()I

    move-result p1

    neg-int p1, p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    :cond_2
    const/4 p1, -0x1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->r:I

    const/4 p1, 0x0

    :goto_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getChildCount()I

    move-result p2

    if-ge p1, p2, :cond_4

    invoke-virtual {p0, p1}, Landroid/widget/FrameLayout;->getChildAt(I)Landroid/view/View;

    move-result-object p2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    if-ne p2, v0, :cond_3

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->r:I

    goto :goto_1

    :cond_3
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_4
    :goto_1
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 14

    invoke-static {p1}, La/f/l/h;->c(Landroid/view/MotionEvent;)I

    move-result v0

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    if-nez v0, :cond_0

    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o:Z

    :cond_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->isEnabled()Z

    move-result v1

    if-eqz v1, :cond_15

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o:Z

    if-nez v1, :cond_15

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s()Z

    move-result v1

    if-eqz v1, :cond_1

    goto/16 :goto_4

    :cond_1
    const/4 v1, 0x1

    if-eqz v0, :cond_13

    const/high16 v3, 0x3f000000    # 0.5f

    const/4 v4, 0x0

    if-eq v0, v1, :cond_e

    const/4 v5, 0x2

    if-eq v0, v5, :cond_4

    const/4 v5, 0x3

    if-eq v0, v5, :cond_e

    const/4 v2, 0x5

    if-eq v0, v2, :cond_3

    const/4 v2, 0x6

    if-eq v0, v2, :cond_2

    goto/16 :goto_3

    :cond_2
    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->z(Landroid/view/MotionEvent;)V

    goto/16 :goto_3

    :cond_3
    invoke-static {p1}, La/f/l/h;->b(Landroid/view/MotionEvent;)I

    move-result v0

    invoke-static {p1, v0}, La/f/l/h;->d(Landroid/view/MotionEvent;I)I

    move-result p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    goto/16 :goto_3

    :cond_4
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    invoke-static {p1, v0}, La/f/l/h;->a(Landroid/view/MotionEvent;I)I

    move-result v0

    if-gez v0, :cond_5

    sget-object p1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->J:Ljava/lang/String;

    const-string v0, "Got ACTION_MOVE event but have an invalid active pointer id."

    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    :cond_5
    invoke-static {p1, v0}, La/f/l/h;->e(Landroid/view/MotionEvent;I)F

    move-result p1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->j:F

    sub-float/2addr p1, v0

    mul-float/2addr p1, v3

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    if-eqz v0, :cond_14

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/b;->r(Z)V

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    div-float v0, p1, v0

    cmpg-float v5, v0, v4

    if-gez v5, :cond_6

    return v2

    :cond_6
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v5, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    float-to-double v6, v0

    const-wide v8, 0x3fd999999999999aL    # 0.4

    sub-double/2addr v6, v8

    const-wide/16 v8, 0x0

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    double-to-float v6, v6

    const/high16 v7, 0x40a00000    # 5.0f

    mul-float/2addr v6, v7

    const/high16 v7, 0x40400000    # 3.0f

    div-float/2addr v6, v7

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result v7

    iget v8, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    sub-float/2addr v7, v8

    iget-boolean v8, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F:Z

    if-eqz v8, :cond_7

    iget v8, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B:F

    iget v9, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    int-to-float v9, v9

    sub-float/2addr v8, v9

    goto :goto_0

    :cond_7
    iget v8, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B:F

    :goto_0
    const/high16 v9, 0x40000000    # 2.0f

    mul-float v10, v8, v9

    invoke-static {v7, v10}, Ljava/lang/Math;->min(FF)F

    move-result v7

    div-float/2addr v7, v8

    invoke-static {v4, v7}, Ljava/lang/Math;->max(FF)F

    move-result v7

    const/high16 v10, 0x40800000    # 4.0f

    div-float/2addr v7, v10

    float-to-double v10, v7

    const-wide/high16 v12, 0x4000000000000000L    # 2.0

    invoke-static {v10, v11, v12, v13}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v12

    sub-double/2addr v10, v12

    double-to-float v7, v10

    mul-float/2addr v7, v9

    mul-float v10, v8, v7

    mul-float/2addr v10, v9

    iget v11, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    mul-float/2addr v8, v0

    add-float/2addr v8, v10

    float-to-int v0, v8

    add-int/2addr v11, v0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    :cond_8
    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n:Z

    if-nez v0, :cond_9

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-static {v0, v5}, La/f/l/r;->e0(Landroid/view/View;F)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-static {v0, v5}, La/f/l/r;->f0(Landroid/view/View;F)V

    :cond_9
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    cmpg-float v2, p1, v0

    if-gez v2, :cond_c

    iget-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n:Z

    if-eqz v2, :cond_a

    div-float/2addr p1, v0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setAnimationProgress(F)V

    :cond_a
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b;->getAlpha()I

    move-result p1

    const/16 v0, 0x4c

    if-le p1, v0, :cond_b

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->y:Landroid/view/animation/Animation;

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->x(Landroid/view/animation/Animation;)Z

    move-result p1

    if-nez p1, :cond_b

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->E()V

    :cond_b
    const p1, 0x3f4ccccd    # 0.8f

    mul-float v0, v6, p1

    iget-object v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-static {p1, v0}, Ljava/lang/Math;->min(FF)F

    move-result p1

    invoke-virtual {v2, v4, p1}, Lcom/jude/easyrecyclerview/swipe/b;->p(FF)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-static {v5, v6}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/swipe/b;->j(F)V

    goto :goto_1

    :cond_c
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b;->getAlpha()I

    move-result p1

    const/16 v0, 0xff

    if-ge p1, v0, :cond_d

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->z:Landroid/view/animation/Animation;

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->x(Landroid/view/animation/Animation;)Z

    move-result p1

    if-nez p1, :cond_d

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->D()V

    :cond_d
    :goto_1
    const/high16 p1, -0x41800000    # -0.25f

    const v0, 0x3ecccccd    # 0.4f

    mul-float/2addr v6, v0

    add-float/2addr v6, p1

    mul-float/2addr v7, v9

    add-float/2addr v6, v7

    mul-float/2addr v6, v3

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1, v6}, Lcom/jude/easyrecyclerview/swipe/b;->m(F)V

    iget p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    sub-int/2addr v11, p1

    invoke-direct {p0, v11, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B(IZ)V

    goto :goto_3

    :cond_e
    iget v5, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    const/4 v6, -0x1

    if-ne v5, v6, :cond_10

    if-ne v0, v1, :cond_f

    sget-object p1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->J:Ljava/lang/String;

    const-string v0, "Got ACTION_UP event but don\'t have an active pointer id."

    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_f
    return v2

    :cond_10
    invoke-static {p1, v5}, La/f/l/h;->a(Landroid/view/MotionEvent;I)I

    move-result v0

    invoke-static {p1, v0}, La/f/l/h;->e(Landroid/view/MotionEvent;I)F

    move-result p1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->j:F

    sub-float/2addr p1, v0

    mul-float/2addr p1, v3

    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    cmpl-float p1, p1, v0

    if-lez p1, :cond_11

    invoke-direct {p0, v1, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->A(ZZ)V

    goto :goto_2

    :cond_11
    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1, v4, v4}, Lcom/jude/easyrecyclerview/swipe/b;->p(FF)V

    const/4 p1, 0x0

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n:Z

    if-nez v0, :cond_12

    new-instance p1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$e;

    invoke-direct {p1, p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$e;-><init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V

    :cond_12
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    invoke-direct {p0, v0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->r(ILandroid/view/animation/Animation$AnimationListener;)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1, v2}, Lcom/jude/easyrecyclerview/swipe/b;->r(Z)V

    :goto_2
    iput v6, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    return v2

    :cond_13
    invoke-static {p1, v2}, La/f/l/h;->d(Landroid/view/MotionEvent;I)I

    move-result p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m:I

    iput-boolean v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l:Z

    :cond_14
    :goto_3
    return v1

    :cond_15
    :goto_4
    return v2
.end method

.method public requestDisallowInterceptTouchEvent(Z)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->requestDisallowInterceptTouchEvent(Z)V

    return-void
.end method

.method public s()Z
    .locals 5

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, -0x1

    const/16 v2, 0xe

    if-ge v0, v2, :cond_5

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    instance-of v2, v0, Landroid/widget/AbsListView;

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_2

    check-cast v0, Landroid/widget/AbsListView;

    invoke-virtual {v0}, Landroid/widget/AbsListView;->getChildCount()I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0}, Landroid/widget/AbsListView;->getFirstVisiblePosition()I

    move-result v1

    if-gtz v1, :cond_1

    invoke-virtual {v0, v4}, Landroid/widget/AbsListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getTop()I

    move-result v1

    invoke-virtual {v0}, Landroid/widget/AbsListView;->getPaddingTop()I

    move-result v0

    if-ge v1, v0, :cond_0

    goto :goto_0

    :cond_0
    move v3, v4

    :cond_1
    :goto_0
    return v3

    :cond_2
    invoke-static {v0, v1}, La/f/l/r;->b(Landroid/view/View;I)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getScrollY()I

    move-result v0

    if-lez v0, :cond_3

    goto :goto_1

    :cond_3
    move v3, v4

    :cond_4
    :goto_1
    return v3

    :cond_5
    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b:Landroid/view/View;

    invoke-static {v0, v1}, La/f/l/r;->b(Landroid/view/View;I)Z

    move-result v0

    return v0
.end method

.method public varargs setColorScheme([I)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setColorSchemeResources([I)V

    return-void
.end method

.method public varargs setColorSchemeColors([I)V
    .locals 1

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b;->l([I)V

    return-void
.end method

.method public varargs setColorSchemeResources([I)V
    .locals 4

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    array-length v1, p1

    new-array v1, v1, [I

    const/4 v2, 0x0

    :goto_0
    array-length v3, p1

    if-ge v2, v3, :cond_0

    aget v3, p1, v2

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    aput v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setColorSchemeColors([I)V

    return-void
.end method

.method public setDistanceToTriggerSync(I)V
    .locals 0

    int-to-float p1, p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f:F

    return-void
.end method

.method public setOnRefreshListener(La/l/a/a;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->c:La/l/a/a;

    return-void
.end method

.method public setProgressBackgroundColor(I)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setProgressBackgroundColorSchemeResource(I)V

    return-void
.end method

.method public setProgressBackgroundColorSchemeColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/a;->setBackgroundColor(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b;->k(I)V

    return-void
.end method

.method public setProgressBackgroundColorSchemeResource(I)V
    .locals 1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getColor(I)I

    move-result p1

    invoke-virtual {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setProgressBackgroundColorSchemeColor(I)V

    return-void
.end method

.method public setRefreshing(Z)V
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    if-eq v1, p1, :cond_1

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d:Z

    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F:Z

    if-nez p1, :cond_0

    iget p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B:F

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    int-to-float v1, v1

    add-float/2addr p1, v1

    goto :goto_0

    :cond_0
    iget p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B:F

    :goto_0
    float-to-int p1, p1

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h:I

    sub-int/2addr p1, v1

    const/4 v1, 0x1

    invoke-direct {p0, p1, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->B(IZ)V

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->C:Z

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->G:Landroid/view/animation/Animation$AnimationListener;

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->H(Landroid/view/animation/Animation$AnimationListener;)V

    goto :goto_1

    :cond_1
    invoke-direct {p0, p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->A(ZZ)V

    :goto_1
    return-void
.end method

.method public setSize(I)V
    .locals 2

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    if-nez p1, :cond_1

    const/high16 v1, 0x42600000    # 56.0f

    goto :goto_0

    :cond_1
    const/high16 v1, 0x42200000    # 40.0f

    :goto_0
    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, v1

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->D:I

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->E:I

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b;->t(I)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->q:Lcom/jude/easyrecyclerview/swipe/a;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->v:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method
