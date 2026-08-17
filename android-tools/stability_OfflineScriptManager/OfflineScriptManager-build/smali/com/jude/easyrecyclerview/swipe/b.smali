.class Lcom/jude/easyrecyclerview/swipe/b;
.super Landroid/graphics/drawable/Drawable;
.source ""

# interfaces
.implements Landroid/graphics/drawable/Animatable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/jude/easyrecyclerview/swipe/b$d;
    }
.end annotation


# static fields
.field private static final n:Landroid/view/animation/Interpolator;

.field private static final o:Landroid/view/animation/Interpolator;


# instance fields
.field private final b:[I

.field private final c:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/view/animation/Animation;",
            ">;"
        }
    .end annotation
.end field

.field private final d:Lcom/jude/easyrecyclerview/swipe/b$d;

.field private e:F

.field private f:Landroid/content/res/Resources;

.field private g:Landroid/view/View;

.field private h:Landroid/view/animation/Animation;

.field private i:F

.field private j:D

.field private k:D

.field l:Z

.field private final m:Landroid/graphics/drawable/Drawable$Callback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v0}, Landroid/view/animation/LinearInterpolator;-><init>()V

    sput-object v0, Lcom/jude/easyrecyclerview/swipe/b;->n:Landroid/view/animation/Interpolator;

    new-instance v0, La/i/a/a/b;

    invoke-direct {v0}, La/i/a/a/b;-><init>()V

    sput-object v0, Lcom/jude/easyrecyclerview/swipe/b;->o:Landroid/view/animation/Interpolator;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/view/View;)V
    .locals 4

    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    const/4 v0, 0x1

    new-array v1, v0, [I

    const/4 v2, 0x0

    const/high16 v3, -0x1000000

    aput v3, v1, v2

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b;->b:[I

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/jude/easyrecyclerview/swipe/b;->c:Ljava/util/ArrayList;

    new-instance v2, Lcom/jude/easyrecyclerview/swipe/b$c;

    invoke-direct {v2, p0}, Lcom/jude/easyrecyclerview/swipe/b$c;-><init>(Lcom/jude/easyrecyclerview/swipe/b;)V

    iput-object v2, p0, Lcom/jude/easyrecyclerview/swipe/b;->m:Landroid/graphics/drawable/Drawable$Callback;

    iput-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b;->g:Landroid/view/View;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->f:Landroid/content/res/Resources;

    new-instance p1, Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-direct {p1, v2}, Lcom/jude/easyrecyclerview/swipe/b$d;-><init>(Landroid/graphics/drawable/Drawable$Callback;)V

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {p1, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->y([I)V

    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/swipe/b;->t(I)V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b;->q()V

    return-void
.end method

.method static synthetic a(Lcom/jude/easyrecyclerview/swipe/b;FLcom/jude/easyrecyclerview/swipe/b$d;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/b;->g(FLcom/jude/easyrecyclerview/swipe/b$d;)V

    return-void
.end method

.method static synthetic b(Lcom/jude/easyrecyclerview/swipe/b;Lcom/jude/easyrecyclerview/swipe/b$d;)F
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/swipe/b;->i(Lcom/jude/easyrecyclerview/swipe/b$d;)F

    move-result p0

    return p0
.end method

.method static synthetic c(Lcom/jude/easyrecyclerview/swipe/b;FLcom/jude/easyrecyclerview/swipe/b$d;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/b;->s(FLcom/jude/easyrecyclerview/swipe/b$d;)V

    return-void
.end method

.method static synthetic d()Landroid/view/animation/Interpolator;
    .locals 1

    sget-object v0, Lcom/jude/easyrecyclerview/swipe/b;->o:Landroid/view/animation/Interpolator;

    return-object v0
.end method

.method static synthetic e(Lcom/jude/easyrecyclerview/swipe/b;)F
    .locals 0

    iget p0, p0, Lcom/jude/easyrecyclerview/swipe/b;->i:F

    return p0
.end method

.method static synthetic f(Lcom/jude/easyrecyclerview/swipe/b;F)F
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->i:F

    return p1
.end method

.method private g(FLcom/jude/easyrecyclerview/swipe/b$d;)V
    .locals 4

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/b;->s(FLcom/jude/easyrecyclerview/swipe/b$d;)V

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->k()F

    move-result v0

    const v1, 0x3f4ccccd    # 0.8f

    div-float/2addr v0, v1

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->floor(D)D

    move-result-wide v0

    const-wide/high16 v2, 0x3ff0000000000000L    # 1.0

    add-double/2addr v0, v2

    double-to-float v0, v0

    invoke-direct {p0, p2}, Lcom/jude/easyrecyclerview/swipe/b;->i(Lcom/jude/easyrecyclerview/swipe/b$d;)F

    move-result v1

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->l()F

    move-result v2

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->j()F

    move-result v3

    sub-float/2addr v3, v1

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->l()F

    move-result v1

    sub-float/2addr v3, v1

    mul-float/2addr v3, p1

    add-float/2addr v2, v3

    invoke-virtual {p2, v2}, Lcom/jude/easyrecyclerview/swipe/b$d;->D(F)V

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->j()F

    move-result v1

    invoke-virtual {p2, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->z(F)V

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->k()F

    move-result v1

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->k()F

    move-result v2

    sub-float/2addr v0, v2

    mul-float/2addr v0, p1

    add-float/2addr v1, v0

    invoke-virtual {p2, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->B(F)V

    return-void
.end method

.method private h(FII)I
    .locals 6

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    shr-int/lit8 v0, p2, 0x18

    and-int/lit16 v0, v0, 0xff

    shr-int/lit8 v1, p2, 0x10

    and-int/lit16 v1, v1, 0xff

    shr-int/lit8 v2, p2, 0x8

    and-int/lit16 v2, v2, 0xff

    and-int/lit16 p2, p2, 0xff

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/Integer;->intValue()I

    move-result p3

    shr-int/lit8 v3, p3, 0x18

    and-int/lit16 v3, v3, 0xff

    shr-int/lit8 v4, p3, 0x10

    and-int/lit16 v4, v4, 0xff

    shr-int/lit8 v5, p3, 0x8

    and-int/lit16 v5, v5, 0xff

    and-int/lit16 p3, p3, 0xff

    sub-int/2addr v3, v0

    int-to-float v3, v3

    mul-float/2addr v3, p1

    float-to-int v3, v3

    add-int/2addr v0, v3

    shl-int/lit8 v0, v0, 0x18

    sub-int/2addr v4, v1

    int-to-float v3, v4

    mul-float/2addr v3, p1

    float-to-int v3, v3

    add-int/2addr v1, v3

    shl-int/lit8 v1, v1, 0x10

    or-int/2addr v0, v1

    sub-int/2addr v5, v2

    int-to-float v1, v5

    mul-float/2addr v1, p1

    float-to-int v1, v1

    add-int/2addr v2, v1

    shl-int/lit8 v1, v2, 0x8

    or-int/2addr v0, v1

    sub-int/2addr p3, p2

    int-to-float p3, p3

    mul-float/2addr p1, p3

    float-to-int p1, p1

    add-int/2addr p2, p1

    or-int p1, v0, p2

    return p1
.end method

.method private i(Lcom/jude/easyrecyclerview/swipe/b$d;)F
    .locals 6

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->m()F

    move-result v0

    float-to-double v0, v0

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->d()D

    move-result-wide v2

    const-wide v4, 0x401921fb54442d18L    # 6.283185307179586

    mul-double/2addr v2, v4

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    double-to-float p1, v0

    return p1
.end method

.method private o(DDDDFF)V
    .locals 4

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b;->f:Landroid/content/res/Resources;

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    float-to-double v2, v1

    mul-double/2addr p1, v2

    iput-wide p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->j:D

    mul-double/2addr p3, v2

    iput-wide p3, p0, Lcom/jude/easyrecyclerview/swipe/b;->k:D

    double-to-float p1, p7

    mul-float/2addr p1, v1

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->E(F)V

    mul-double/2addr p5, v2

    invoke-virtual {v0, p5, p6}, Lcom/jude/easyrecyclerview/swipe/b$d;->u(D)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->x(I)V

    mul-float/2addr p9, v1

    mul-float/2addr p10, v1

    invoke-virtual {v0, p9, p10}, Lcom/jude/easyrecyclerview/swipe/b$d;->r(FF)V

    iget-wide p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->j:D

    double-to-int p1, p1

    iget-wide p2, p0, Lcom/jude/easyrecyclerview/swipe/b;->k:D

    double-to-int p2, p2

    invoke-virtual {v0, p1, p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->A(II)V

    return-void
.end method

.method private q()V
    .locals 3

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    new-instance v1, Lcom/jude/easyrecyclerview/swipe/b$a;

    invoke-direct {v1, p0, v0}, Lcom/jude/easyrecyclerview/swipe/b$a;-><init>(Lcom/jude/easyrecyclerview/swipe/b;Lcom/jude/easyrecyclerview/swipe/b$d;)V

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/view/animation/Animation;->setRepeatCount(I)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/view/animation/Animation;->setRepeatMode(I)V

    sget-object v2, Lcom/jude/easyrecyclerview/swipe/b;->n:Landroid/view/animation/Interpolator;

    invoke-virtual {v1, v2}, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    new-instance v2, Lcom/jude/easyrecyclerview/swipe/b$b;

    invoke-direct {v2, p0, v0}, Lcom/jude/easyrecyclerview/swipe/b$b;-><init>(Lcom/jude/easyrecyclerview/swipe/b;Lcom/jude/easyrecyclerview/swipe/b$d;)V

    invoke-virtual {v1, v2}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b;->h:Landroid/view/animation/Animation;

    return-void
.end method

.method private s(FLcom/jude/easyrecyclerview/swipe/b$d;)V
    .locals 2

    const/high16 v0, 0x3f400000    # 0.75f

    cmpl-float v1, p1, v0

    if-lez v1, :cond_0

    sub-float/2addr p1, v0

    const/high16 v0, 0x3e800000    # 0.25f

    div-float/2addr p1, v0

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->i()I

    move-result v0

    invoke-virtual {p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->f()I

    move-result v1

    invoke-direct {p0, p1, v0, v1}, Lcom/jude/easyrecyclerview/swipe/b;->h(FII)I

    move-result p1

    invoke-virtual {p2, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->v(I)V

    :cond_0
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 5

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v1

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/b;->e:F

    invoke-virtual {v0}, Landroid/graphics/Rect;->exactCenterX()F

    move-result v3

    invoke-virtual {v0}, Landroid/graphics/Rect;->exactCenterY()F

    move-result v4

    invoke-virtual {p1, v2, v3, v4}, Landroid/graphics/Canvas;->rotate(FFF)V

    iget-object v2, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v2, p1, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->a(Landroid/graphics/Canvas;Landroid/graphics/Rect;)V

    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->restoreToCount(I)V

    return-void
.end method

.method public getAlpha()I
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->c()I

    move-result v0

    return v0
.end method

.method public getIntrinsicHeight()I
    .locals 2

    iget-wide v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->k:D

    double-to-int v0, v0

    return v0
.end method

.method public getIntrinsicWidth()I
    .locals 2

    iget-wide v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->j:D

    double-to-int v0, v0

    return v0
.end method

.method public getOpacity()I
    .locals 1

    const/4 v0, -0x3

    return v0
.end method

.method public isRunning()Z
    .locals 6

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->c:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/animation/Animation;

    invoke-virtual {v4}, Landroid/view/animation/Animation;->hasStarted()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {v4}, Landroid/view/animation/Animation;->hasEnded()Z

    move-result v4

    if-nez v4, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return v2
.end method

.method public j(F)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->s(F)V

    return-void
.end method

.method public k(I)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->t(I)V

    return-void
.end method

.method public varargs l([I)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->y([I)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->x(I)V

    return-void
.end method

.method public m(F)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->B(F)V

    return-void
.end method

.method n(F)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->e:F

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->invalidateSelf()V

    return-void
.end method

.method public p(FF)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->D(F)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {p1, p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->z(F)V

    return-void
.end method

.method public r(Z)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->C(Z)V

    return-void
.end method

.method public setAlpha(I)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->q(I)V

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->w(Landroid/graphics/ColorFilter;)V

    return-void
.end method

.method public start()V
    .locals 3

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->reset()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->F()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->e()F

    move-result v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->h()F

    move-result v1

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->l:Z

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->h:Landroid/view/animation/Animation;

    const-wide/16 v1, 0x29a

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->x(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->p()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->h:Landroid/view/animation/Animation;

    const-wide/16 v1, 0x534

    :goto_0
    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->g:Landroid/view/View;

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method public stop()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->g:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->clearAnimation()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/swipe/b;->n(F)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->C(Z)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->x(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b;->d:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->p()V

    return-void
.end method

.method public t(I)V
    .locals 22

    if-nez p1, :cond_0

    const-wide/high16 v1, 0x404c000000000000L    # 56.0

    const-wide/high16 v3, 0x404c000000000000L    # 56.0

    const-wide/high16 v5, 0x4029000000000000L    # 12.5

    const-wide/high16 v7, 0x4008000000000000L    # 3.0

    const/high16 v9, 0x41400000    # 12.0f

    const/high16 v10, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    invoke-direct/range {v0 .. v10}, Lcom/jude/easyrecyclerview/swipe/b;->o(DDDDFF)V

    goto :goto_0

    :cond_0
    const-wide/high16 v12, 0x4044000000000000L    # 40.0

    const-wide/high16 v14, 0x4044000000000000L    # 40.0

    const-wide v16, 0x4021800000000000L    # 8.75

    const-wide/high16 v18, 0x4004000000000000L    # 2.5

    const/high16 v20, 0x41200000    # 10.0f

    const/high16 v21, 0x40a00000    # 5.0f

    move-object/from16 v11, p0

    invoke-direct/range {v11 .. v21}, Lcom/jude/easyrecyclerview/swipe/b;->o(DDDDFF)V

    :goto_0
    return-void
.end method
