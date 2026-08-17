.class public Lorg/achartengine/d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lorg/achartengine/c;


# instance fields
.field private a:Lorg/achartengine/h/b;

.field private b:F

.field private c:F

.field private d:F

.field private e:F

.field private f:Lorg/achartengine/i/c;

.field private g:Lorg/achartengine/i/e;

.field private h:Lorg/achartengine/b;


# direct methods
.method public constructor <init>(Lorg/achartengine/b;Lorg/achartengine/f/a;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object p1, p0, Lorg/achartengine/d;->h:Lorg/achartengine/b;

    invoke-virtual {p1}, Lorg/achartengine/b;->getZoomRectangle()Landroid/graphics/RectF;

    instance-of p1, p2, Lorg/achartengine/f/i;

    if-eqz p1, :cond_0

    move-object p1, p2

    check-cast p1, Lorg/achartengine/f/i;

    invoke-virtual {p1}, Lorg/achartengine/f/i;->B()Lorg/achartengine/h/d;

    move-result-object p1

    goto :goto_0

    :cond_0
    move-object p1, p2

    check-cast p1, Lorg/achartengine/f/e;

    invoke-virtual {p1}, Lorg/achartengine/f/e;->r()Lorg/achartengine/h/b;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    iget-object p1, p0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    invoke-virtual {p1}, Lorg/achartengine/h/b;->A()Z

    move-result p1

    if-eqz p1, :cond_1

    new-instance p1, Lorg/achartengine/i/c;

    invoke-direct {p1, p2}, Lorg/achartengine/i/c;-><init>(Lorg/achartengine/f/a;)V

    iput-object p1, p0, Lorg/achartengine/d;->f:Lorg/achartengine/i/c;

    :cond_1
    iget-object p1, p0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    invoke-virtual {p1}, Lorg/achartengine/h/b;->K()Z

    move-result p1

    if-eqz p1, :cond_2

    new-instance p1, Lorg/achartengine/i/e;

    const/4 v0, 0x1

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-direct {p1, p2, v0, v1}, Lorg/achartengine/i/e;-><init>(Lorg/achartengine/f/a;ZF)V

    iput-object p1, p0, Lorg/achartengine/d;->g:Lorg/achartengine/i/e;

    :cond_2
    return-void
.end method

.method private b(FI)V
    .locals 4

    const v0, 0x3f666666    # 0.9f

    invoke-static {p1, v0}, Ljava/lang/Math;->max(FF)F

    move-result p1

    const v0, 0x3f8ccccd    # 1.1f

    invoke-static {p1, v0}, Ljava/lang/Math;->min(FF)F

    move-result p1

    float-to-double v0, p1

    const-wide v2, 0x3feccccccccccccdL    # 0.9

    cmpl-double v2, v0, v2

    if-lez v2, :cond_0

    const-wide v2, 0x3ff199999999999aL    # 1.1

    cmpg-double v0, v0, v2

    if-gez v0, :cond_0

    iget-object v0, p0, Lorg/achartengine/d;->g:Lorg/achartengine/i/e;

    invoke-virtual {v0, p1}, Lorg/achartengine/i/e;->h(F)V

    iget-object p1, p0, Lorg/achartengine/d;->g:Lorg/achartengine/i/e;

    invoke-virtual {p1, p2}, Lorg/achartengine/i/e;->e(I)V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Landroid/view/MotionEvent;)Z
    .locals 18

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v2

    iget-object v3, v0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    const/4 v4, 0x0

    const/4 v5, 0x1

    const/4 v6, 0x0

    if-eqz v3, :cond_7

    const/4 v3, 0x2

    if-ne v2, v3, :cond_7

    iget v2, v0, Lorg/achartengine/d;->b:F

    cmpl-float v2, v2, v6

    if-gez v2, :cond_0

    iget v2, v0, Lorg/achartengine/d;->c:F

    cmpl-float v2, v2, v6

    if-ltz v2, :cond_a

    :cond_0
    invoke-virtual {v1, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    invoke-virtual {v1, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v7

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v8

    if-le v8, v5, :cond_5

    iget v8, v0, Lorg/achartengine/d;->d:F

    cmpl-float v8, v8, v6

    if-gez v8, :cond_1

    iget v8, v0, Lorg/achartengine/d;->e:F

    cmpl-float v8, v8, v6

    if-ltz v8, :cond_5

    :cond_1
    iget-object v8, v0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    invoke-virtual {v8}, Lorg/achartengine/h/b;->K()Z

    move-result v8

    if-eqz v8, :cond_5

    invoke-virtual {v1, v5}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    invoke-virtual {v1, v5}, Landroid/view/MotionEvent;->getY(I)F

    move-result v1

    sub-float v8, v2, v6

    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    move-result v8

    sub-float v9, v7, v1

    invoke-static {v9}, Ljava/lang/Math;->abs(F)F

    move-result v9

    iget v10, v0, Lorg/achartengine/d;->b:F

    iget v11, v0, Lorg/achartengine/d;->d:F

    sub-float/2addr v10, v11

    invoke-static {v10}, Ljava/lang/Math;->abs(F)F

    move-result v10

    iget v11, v0, Lorg/achartengine/d;->c:F

    iget v12, v0, Lorg/achartengine/d;->e:F

    sub-float/2addr v11, v12

    invoke-static {v11}, Ljava/lang/Math;->abs(F)F

    move-result v11

    iget v12, v0, Lorg/achartengine/d;->c:F

    sub-float v12, v7, v12

    invoke-static {v12}, Ljava/lang/Math;->abs(F)F

    move-result v12

    iget v13, v0, Lorg/achartengine/d;->b:F

    sub-float v13, v2, v13

    invoke-static {v13}, Ljava/lang/Math;->abs(F)F

    move-result v13

    div-float/2addr v12, v13

    iget v13, v0, Lorg/achartengine/d;->e:F

    sub-float v13, v1, v13

    invoke-static {v13}, Ljava/lang/Math;->abs(F)F

    move-result v13

    iget v14, v0, Lorg/achartengine/d;->d:F

    sub-float v14, v6, v14

    invoke-static {v14}, Ljava/lang/Math;->abs(F)F

    move-result v14

    div-float/2addr v13, v14

    float-to-double v14, v12

    const-wide/high16 v16, 0x3fd0000000000000L    # 0.25

    cmpg-double v12, v14, v16

    if-gtz v12, :cond_2

    float-to-double v3, v13

    cmpg-double v3, v3, v16

    if-gtz v3, :cond_2

    div-float/2addr v8, v10

    invoke-direct {v0, v8, v5}, Lorg/achartengine/d;->b(FI)V

    goto :goto_1

    :cond_2
    const-wide v3, 0x400dd70a3d70a3d7L    # 3.73

    cmpl-double v14, v14, v3

    if-ltz v14, :cond_3

    float-to-double v13, v13

    cmpl-double v3, v13, v3

    if-ltz v3, :cond_3

    div-float/2addr v9, v11

    const/4 v3, 0x2

    invoke-direct {v0, v9, v3}, Lorg/achartengine/d;->b(FI)V

    goto :goto_1

    :cond_3
    iget v3, v0, Lorg/achartengine/d;->b:F

    sub-float v3, v2, v3

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    iget v4, v0, Lorg/achartengine/d;->c:F

    sub-float v4, v7, v4

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v4

    cmpl-float v3, v3, v4

    if-ltz v3, :cond_4

    div-float/2addr v8, v10

    goto :goto_0

    :cond_4
    div-float v8, v9, v11

    :goto_0
    const/4 v3, 0x0

    invoke-direct {v0, v8, v3}, Lorg/achartengine/d;->b(FI)V

    :goto_1
    iput v6, v0, Lorg/achartengine/d;->d:F

    iput v1, v0, Lorg/achartengine/d;->e:F

    goto :goto_2

    :cond_5
    iget-object v1, v0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->A()Z

    move-result v1

    if-eqz v1, :cond_6

    iget-object v1, v0, Lorg/achartengine/d;->f:Lorg/achartengine/i/c;

    iget v3, v0, Lorg/achartengine/d;->b:F

    iget v4, v0, Lorg/achartengine/d;->c:F

    invoke-virtual {v1, v3, v4, v2, v7}, Lorg/achartengine/i/c;->e(FFFF)V

    iput v6, v0, Lorg/achartengine/d;->d:F

    iput v6, v0, Lorg/achartengine/d;->e:F

    :cond_6
    :goto_2
    iput v2, v0, Lorg/achartengine/d;->b:F

    iput v7, v0, Lorg/achartengine/d;->c:F

    iget-object v1, v0, Lorg/achartengine/d;->h:Lorg/achartengine/b;

    invoke-virtual {v1}, Lorg/achartengine/b;->a()V

    return v5

    :cond_7
    if-nez v2, :cond_8

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    iput v2, v0, Lorg/achartengine/d;->b:F

    invoke-virtual {v1, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v1

    :goto_3
    iput v1, v0, Lorg/achartengine/d;->c:F

    goto :goto_4

    :cond_8
    const/4 v1, 0x6

    if-eq v2, v5, :cond_9

    if-ne v2, v1, :cond_a

    :cond_9
    iput v6, v0, Lorg/achartengine/d;->b:F

    iput v6, v0, Lorg/achartengine/d;->c:F

    iput v6, v0, Lorg/achartengine/d;->d:F

    iput v6, v0, Lorg/achartengine/d;->e:F

    if-ne v2, v1, :cond_a

    const/high16 v1, -0x40800000    # -1.0f

    iput v1, v0, Lorg/achartengine/d;->b:F

    goto :goto_3

    :cond_a
    :goto_4
    iget-object v1, v0, Lorg/achartengine/d;->a:Lorg/achartengine/h/b;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->w()Z

    move-result v1

    xor-int/2addr v1, v5

    return v1
.end method
