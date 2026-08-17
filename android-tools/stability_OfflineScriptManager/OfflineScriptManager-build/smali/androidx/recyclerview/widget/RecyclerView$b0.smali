.class Landroidx/recyclerview/widget/RecyclerView$b0;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/recyclerview/widget/RecyclerView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "b0"
.end annotation


# instance fields
.field private b:I

.field private c:I

.field d:Landroid/widget/OverScroller;

.field e:Landroid/view/animation/Interpolator;

.field private f:Z

.field private g:Z

.field final synthetic h:Landroidx/recyclerview/widget/RecyclerView;


# direct methods
.method constructor <init>(Landroidx/recyclerview/widget/RecyclerView;)V
    .locals 2

    iput-object p1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Landroidx/recyclerview/widget/RecyclerView;->J0:Landroid/view/animation/Interpolator;

    iput-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->e:Landroid/view/animation/Interpolator;

    const/4 v1, 0x0

    iput-boolean v1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->f:Z

    iput-boolean v1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->g:Z

    new-instance v1, Landroid/widget/OverScroller;

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {v1, p1, v0}, Landroid/widget/OverScroller;-><init>(Landroid/content/Context;Landroid/view/animation/Interpolator;)V

    iput-object v1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    return-void
.end method

.method private a(IIII)I
    .locals 4

    invoke-static {p1}, Ljava/lang/Math;->abs(I)I

    move-result v0

    invoke-static {p2}, Ljava/lang/Math;->abs(I)I

    move-result v1

    if-le v0, v1, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    mul-int/2addr p3, p3

    mul-int/2addr p4, p4

    add-int/2addr p3, p4

    int-to-double p3, p3

    invoke-static {p3, p4}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide p3

    double-to-int p3, p3

    mul-int/2addr p1, p1

    mul-int/2addr p2, p2

    add-int/2addr p1, p2

    int-to-double p1, p1

    invoke-static {p1, p2}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide p1

    double-to-int p1, p1

    iget-object p2, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v2, :cond_1

    invoke-virtual {p2}, Landroid/view/ViewGroup;->getWidth()I

    move-result p2

    goto :goto_1

    :cond_1
    invoke-virtual {p2}, Landroid/view/ViewGroup;->getHeight()I

    move-result p2

    :goto_1
    div-int/lit8 p4, p2, 0x2

    int-to-float p1, p1

    const/high16 v3, 0x3f800000    # 1.0f

    mul-float/2addr p1, v3

    int-to-float p2, p2

    div-float/2addr p1, p2

    invoke-static {v3, p1}, Ljava/lang/Math;->min(FF)F

    move-result p1

    int-to-float p4, p4

    invoke-direct {p0, p1}, Landroidx/recyclerview/widget/RecyclerView$b0;->c(F)F

    move-result p1

    mul-float/2addr p1, p4

    add-float/2addr p4, p1

    if-lez p3, :cond_2

    const/high16 p1, 0x447a0000    # 1000.0f

    int-to-float p2, p3

    div-float/2addr p4, p2

    invoke-static {p4}, Ljava/lang/Math;->abs(F)F

    move-result p2

    mul-float/2addr p2, p1

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p1

    mul-int/lit8 p1, p1, 0x4

    goto :goto_3

    :cond_2
    if-eqz v2, :cond_3

    goto :goto_2

    :cond_3
    move v0, v1

    :goto_2
    int-to-float p1, v0

    div-float/2addr p1, p2

    add-float/2addr p1, v3

    const/high16 p2, 0x43960000    # 300.0f

    mul-float/2addr p1, p2

    float-to-int p1, p1

    :goto_3
    const/16 p2, 0x7d0

    invoke-static {p1, p2}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1
.end method

.method private b()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->g:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->f:Z

    return-void
.end method

.method private c(F)F
    .locals 2

    const/high16 v0, 0x3f000000    # 0.5f

    sub-float/2addr p1, v0

    const v0, 0x3ef1463b

    mul-float/2addr p1, v0

    float-to-double v0, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    double-to-float p1, v0

    return p1
.end method

.method private d()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->f:Z

    iget-boolean v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->g:Z

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->f()V

    :cond_0
    return-void
.end method


# virtual methods
.method public e(II)V
    .locals 10

    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setScrollState(I)V

    const/4 v0, 0x0

    iput v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->c:I

    iput v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->b:I

    iget-object v1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/high16 v6, -0x80000000

    const v7, 0x7fffffff

    const/high16 v8, -0x80000000

    const v9, 0x7fffffff

    move v4, p1

    move v5, p2

    invoke-virtual/range {v1 .. v9}, Landroid/widget/OverScroller;->fling(IIIIIIII)V

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->f()V

    return-void
.end method

.method f()V
    .locals 1

    iget-boolean v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->f:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->g:Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p0}, Landroid/view/ViewGroup;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-static {v0, p0}, La/f/l/r;->L(Landroid/view/View;Ljava/lang/Runnable;)V

    :goto_0
    return-void
.end method

.method public g(IIILandroid/view/animation/Interpolator;)V
    .locals 6

    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->e:Landroid/view/animation/Interpolator;

    if-eq v0, p4, :cond_0

    iput-object p4, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->e:Landroid/view/animation/Interpolator;

    new-instance v0, Landroid/widget/OverScroller;

    iget-object v1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, p4}, Landroid/widget/OverScroller;-><init>(Landroid/content/Context;Landroid/view/animation/Interpolator;)V

    iput-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    :cond_0
    iget-object p4, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v0, 0x2

    invoke-virtual {p4, v0}, Landroidx/recyclerview/widget/RecyclerView;->setScrollState(I)V

    const/4 p4, 0x0

    iput p4, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->c:I

    iput p4, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->b:I

    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    const/4 v1, 0x0

    const/4 v2, 0x0

    move v3, p1

    move v4, p2

    move v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/widget/OverScroller;->startScroll(IIIII)V

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0x17

    if-ge p1, p2, :cond_1

    iget-object p1, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    invoke-virtual {p1}, Landroid/widget/OverScroller;->computeScrollOffset()Z

    :cond_1
    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->f()V

    return-void
.end method

.method public h(IILandroid/view/animation/Interpolator;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0, v0}, Landroidx/recyclerview/widget/RecyclerView$b0;->a(IIII)I

    move-result v0

    if-nez p3, :cond_0

    sget-object p3, Landroidx/recyclerview/widget/RecyclerView;->J0:Landroid/view/animation/Interpolator;

    :cond_0
    invoke-virtual {p0, p1, p2, v0, p3}, Landroidx/recyclerview/widget/RecyclerView$b0;->g(IIILandroid/view/animation/Interpolator;)V

    return-void
.end method

.method public i()V
    .locals 1

    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p0}, Landroid/view/ViewGroup;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object v0, p0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    invoke-virtual {v0}, Landroid/widget/OverScroller;->abortAnimation()V

    return-void
.end method

.method public run()V
    .locals 23

    move-object/from16 v0, p0

    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, v1, Landroidx/recyclerview/widget/RecyclerView;->n:Landroidx/recyclerview/widget/RecyclerView$o;

    if-nez v1, :cond_0

    invoke-virtual/range {p0 .. p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->i()V

    return-void

    :cond_0
    invoke-direct/range {p0 .. p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->b()V

    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->v()V

    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->d:Landroid/widget/OverScroller;

    iget-object v2, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v2, v2, Landroidx/recyclerview/widget/RecyclerView;->n:Landroidx/recyclerview/widget/RecyclerView$o;

    iget-object v2, v2, Landroidx/recyclerview/widget/RecyclerView$o;->g:Landroidx/recyclerview/widget/RecyclerView$y;

    invoke-virtual {v1}, Landroid/widget/OverScroller;->computeScrollOffset()Z

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    if-eqz v3, :cond_1c

    iget-object v3, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v3, v3, Landroidx/recyclerview/widget/RecyclerView;->u0:[I

    invoke-virtual {v1}, Landroid/widget/OverScroller;->getCurrX()I

    move-result v12

    invoke-virtual {v1}, Landroid/widget/OverScroller;->getCurrY()I

    move-result v13

    iget v6, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->b:I

    sub-int v14, v12, v6

    iget v6, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->c:I

    sub-int v15, v13, v6

    iput v12, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->b:I

    iput v13, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->c:I

    iget-object v6, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v10, 0x0

    const/4 v11, 0x1

    move v7, v14

    move v8, v15

    move-object v9, v3

    invoke-virtual/range {v6 .. v11}, Landroidx/recyclerview/widget/RecyclerView;->G(II[I[II)Z

    move-result v6

    const/4 v7, 0x1

    if-eqz v6, :cond_1

    aget v6, v3, v5

    sub-int/2addr v14, v6

    aget v3, v3, v7

    sub-int/2addr v15, v3

    :cond_1
    iget-object v3, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v6, v3, Landroidx/recyclerview/widget/RecyclerView;->m:Landroidx/recyclerview/widget/RecyclerView$g;

    if-eqz v6, :cond_4

    iget-object v6, v3, Landroidx/recyclerview/widget/RecyclerView;->w0:[I

    invoke-virtual {v3, v14, v15, v6}, Landroidx/recyclerview/widget/RecyclerView;->g1(II[I)V

    iget-object v3, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v3, v3, Landroidx/recyclerview/widget/RecyclerView;->w0:[I

    aget v6, v3, v5

    aget v3, v3, v7

    sub-int v8, v14, v6

    sub-int v9, v15, v3

    if-eqz v2, :cond_5

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$y;->b()Z

    move-result v10

    if-nez v10, :cond_5

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$y;->c()Z

    move-result v10

    if-eqz v10, :cond_5

    iget-object v10, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v10, v10, Landroidx/recyclerview/widget/RecyclerView;->i0:Landroidx/recyclerview/widget/RecyclerView$z;

    invoke-virtual {v10}, Landroidx/recyclerview/widget/RecyclerView$z;->b()I

    move-result v10

    if-eqz v10, :cond_3

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$y;->a()I

    move-result v11

    if-lt v11, v10, :cond_2

    sub-int/2addr v10, v7

    invoke-virtual {v2, v10}, Landroidx/recyclerview/widget/RecyclerView$y;->f(I)V

    :cond_2
    sub-int v10, v14, v8

    sub-int v11, v15, v9

    invoke-virtual {v2, v10, v11}, Landroidx/recyclerview/widget/RecyclerView$y;->d(II)V

    goto :goto_0

    :cond_3
    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$y;->g()V

    throw v4

    :cond_4
    move v3, v5

    move v6, v3

    move v8, v6

    move v9, v8

    :cond_5
    :goto_0
    iget-object v10, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v10, v10, Landroidx/recyclerview/widget/RecyclerView;->p:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_6

    iget-object v10, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v10}, Landroid/view/ViewGroup;->invalidate()V

    :cond_6
    iget-object v10, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v10}, Landroid/view/ViewGroup;->getOverScrollMode()I

    move-result v10

    const/4 v11, 0x2

    if-eq v10, v11, :cond_7

    iget-object v10, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v10, v14, v15}, Landroidx/recyclerview/widget/RecyclerView;->u(II)V

    :cond_7
    iget-object v10, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    const/16 v21, 0x0

    const/16 v22, 0x1

    move-object/from16 v16, v10

    move/from16 v17, v6

    move/from16 v18, v3

    move/from16 v19, v8

    move/from16 v20, v9

    invoke-virtual/range {v16 .. v22}, Landroidx/recyclerview/widget/RecyclerView;->H(IIII[II)Z

    move-result v10

    if-nez v10, :cond_10

    if-nez v8, :cond_8

    if-eqz v9, :cond_10

    :cond_8
    invoke-virtual {v1}, Landroid/widget/OverScroller;->getCurrVelocity()F

    move-result v10

    float-to-int v10, v10

    if-eq v8, v12, :cond_a

    if-gez v8, :cond_9

    neg-int v4, v10

    goto :goto_1

    :cond_9
    if-lez v8, :cond_a

    move v4, v10

    goto :goto_1

    :cond_a
    move v4, v5

    :goto_1
    if-eq v9, v13, :cond_c

    if-gez v9, :cond_b

    neg-int v10, v10

    goto :goto_2

    :cond_b
    if-lez v9, :cond_c

    goto :goto_2

    :cond_c
    move v10, v5

    :goto_2
    iget-object v5, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getOverScrollMode()I

    move-result v5

    if-eq v5, v11, :cond_d

    iget-object v5, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v5, v4, v10}, Landroidx/recyclerview/widget/RecyclerView;->c(II)V

    :cond_d
    if-nez v4, :cond_e

    if-eq v8, v12, :cond_e

    invoke-virtual {v1}, Landroid/widget/OverScroller;->getFinalX()I

    move-result v4

    if-nez v4, :cond_10

    :cond_e
    if-nez v10, :cond_f

    if-eq v9, v13, :cond_f

    invoke-virtual {v1}, Landroid/widget/OverScroller;->getFinalY()I

    move-result v4

    if-nez v4, :cond_10

    :cond_f
    invoke-virtual {v1}, Landroid/widget/OverScroller;->abortAnimation()V

    :cond_10
    if-nez v6, :cond_11

    if-eqz v3, :cond_12

    :cond_11
    iget-object v4, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v4, v6, v3}, Landroidx/recyclerview/widget/RecyclerView;->L(II)V

    :cond_12
    iget-object v4, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-static {v4}, Landroidx/recyclerview/widget/RecyclerView;->f(Landroidx/recyclerview/widget/RecyclerView;)Z

    move-result v4

    if-nez v4, :cond_13

    iget-object v4, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v4}, Landroid/view/ViewGroup;->invalidate()V

    :cond_13
    if-eqz v15, :cond_14

    iget-object v4, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v4, v4, Landroidx/recyclerview/widget/RecyclerView;->n:Landroidx/recyclerview/widget/RecyclerView$o;

    invoke-virtual {v4}, Landroidx/recyclerview/widget/RecyclerView$o;->k()Z

    move-result v4

    if-eqz v4, :cond_14

    if-ne v3, v15, :cond_14

    move v3, v7

    goto :goto_3

    :cond_14
    const/4 v3, 0x0

    :goto_3
    if-eqz v14, :cond_15

    iget-object v4, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v4, v4, Landroidx/recyclerview/widget/RecyclerView;->n:Landroidx/recyclerview/widget/RecyclerView$o;

    invoke-virtual {v4}, Landroidx/recyclerview/widget/RecyclerView$o;->j()Z

    move-result v4

    if-eqz v4, :cond_15

    if-ne v6, v14, :cond_15

    move v4, v7

    goto :goto_4

    :cond_15
    const/4 v4, 0x0

    :goto_4
    if-nez v14, :cond_16

    if-eqz v15, :cond_18

    :cond_16
    if-nez v4, :cond_18

    if-eqz v3, :cond_17

    goto :goto_5

    :cond_17
    const/4 v3, 0x0

    goto :goto_6

    :cond_18
    :goto_5
    move v3, v7

    :goto_6
    invoke-virtual {v1}, Landroid/widget/OverScroller;->isFinished()Z

    move-result v1

    if-nez v1, :cond_1a

    if-nez v3, :cond_19

    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v7}, Landroidx/recyclerview/widget/RecyclerView;->m0(I)Z

    move-result v1

    if-nez v1, :cond_19

    goto :goto_7

    :cond_19
    invoke-virtual/range {p0 .. p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->f()V

    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v3, v1, Landroidx/recyclerview/widget/RecyclerView;->g0:Landroidx/recyclerview/widget/f;

    if-eqz v3, :cond_1c

    invoke-virtual {v3, v1, v14, v15}, Landroidx/recyclerview/widget/f;->f(Landroidx/recyclerview/widget/RecyclerView;II)V

    goto :goto_8

    :cond_1a
    :goto_7
    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroidx/recyclerview/widget/RecyclerView;->setScrollState(I)V

    sget-boolean v1, Landroidx/recyclerview/widget/RecyclerView;->F0:Z

    if-eqz v1, :cond_1b

    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, v1, Landroidx/recyclerview/widget/RecyclerView;->h0:Landroidx/recyclerview/widget/f$b;

    invoke-virtual {v1}, Landroidx/recyclerview/widget/f$b;->b()V

    :cond_1b
    iget-object v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->h:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v7}, Landroidx/recyclerview/widget/RecyclerView;->a(I)V

    :cond_1c
    :goto_8
    if-eqz v2, :cond_1f

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$y;->b()Z

    move-result v1

    if-eqz v1, :cond_1d

    const/4 v1, 0x0

    invoke-virtual {v2, v1, v1}, Landroidx/recyclerview/widget/RecyclerView$y;->d(II)V

    :cond_1d
    iget-boolean v1, v0, Landroidx/recyclerview/widget/RecyclerView$b0;->g:Z

    if-eqz v1, :cond_1e

    goto :goto_9

    :cond_1e
    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$y;->g()V

    const/4 v1, 0x0

    throw v1

    :cond_1f
    :goto_9
    invoke-direct/range {p0 .. p0}, Landroidx/recyclerview/widget/RecyclerView$b0;->d()V

    return-void
.end method
