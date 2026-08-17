.class public abstract Lorg/achartengine/f/i;
.super Lorg/achartengine/f/a;
.source ""


# instance fields
.field protected b:Lorg/achartengine/g/d;

.field protected c:Lorg/achartengine/h/d;

.field private d:F

.field private e:F

.field private f:Lorg/achartengine/g/a;

.field private g:Landroid/graphics/Rect;

.field private final h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "[D>;"
        }
    .end annotation
.end field

.field private i:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/util/List<",
            "Lorg/achartengine/f/b;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method protected constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lorg/achartengine/f/a;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V
    .locals 1

    invoke-direct {p0}, Lorg/achartengine/f/a;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    iput-object p1, p0, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    iput-object p2, p0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    return-void
.end method

.method private C(Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;)",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    return-object v0

    :cond_1
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Double;

    invoke-virtual {v1}, Ljava/lang/Double;->isNaN()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private H(Landroid/graphics/Paint$Cap;Landroid/graphics/Paint$Join;FLandroid/graphics/Paint$Style;Landroid/graphics/PathEffect;Landroid/graphics/Paint;)V
    .locals 0

    invoke-virtual {p6, p1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    invoke-virtual {p6, p2}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    invoke-virtual {p6, p3}, Landroid/graphics/Paint;->setStrokeMiter(F)V

    invoke-virtual {p6, p5}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    invoke-virtual {p6, p4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    return-void
.end method

.method private J(Landroid/graphics/Canvas;FZ)V
    .locals 2

    const/high16 v0, 0x3f800000    # 1.0f

    if-eqz p3, :cond_0

    iget p3, p0, Lorg/achartengine/f/i;->d:F

    div-float/2addr v0, p3

    invoke-virtual {p1, v0, p3}, Landroid/graphics/Canvas;->scale(FF)V

    iget p3, p0, Lorg/achartengine/f/i;->e:F

    neg-float v0, p3

    invoke-virtual {p1, p3, v0}, Landroid/graphics/Canvas;->translate(FF)V

    neg-float p2, p2

    iget-object p3, p0, Lorg/achartengine/f/i;->f:Lorg/achartengine/g/a;

    invoke-virtual {p3}, Lorg/achartengine/g/a;->a()F

    move-result p3

    iget-object v0, p0, Lorg/achartengine/f/i;->f:Lorg/achartengine/g/a;

    invoke-virtual {v0}, Lorg/achartengine/g/a;->b()F

    move-result v0

    invoke-virtual {p1, p2, p3, v0}, Landroid/graphics/Canvas;->rotate(FFF)V

    goto :goto_0

    :cond_0
    iget-object p3, p0, Lorg/achartengine/f/i;->f:Lorg/achartengine/g/a;

    invoke-virtual {p3}, Lorg/achartengine/g/a;->a()F

    move-result p3

    iget-object v1, p0, Lorg/achartengine/f/i;->f:Lorg/achartengine/g/a;

    invoke-virtual {v1}, Lorg/achartengine/g/a;->b()F

    move-result v1

    invoke-virtual {p1, p2, p3, v1}, Landroid/graphics/Canvas;->rotate(FFF)V

    iget p2, p0, Lorg/achartengine/f/i;->e:F

    neg-float p3, p2

    invoke-virtual {p1, p3, p2}, Landroid/graphics/Canvas;->translate(FF)V

    iget p2, p0, Lorg/achartengine/f/i;->d:F

    div-float/2addr v0, p2

    invoke-virtual {p1, p2, v0}, Landroid/graphics/Canvas;->scale(FF)V

    :goto_0
    return-void
.end method

.method private z(Landroid/graphics/Paint$Align;)I
    .locals 1

    sget-object v0, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    if-ne p1, v0, :cond_0

    const/4 p1, -0x4

    goto :goto_0

    :cond_0
    const/4 p1, 0x4

    :goto_0
    return p1
.end method


# virtual methods
.method public A()Lorg/achartengine/f/f;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public B()Lorg/achartengine/h/d;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    return-object v0
.end method

.method protected D(DDI)Ljava/util/List;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(DDI)",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;"
        }
    .end annotation

    invoke-static {p1, p2, p3, p4, p5}, Lorg/achartengine/j/b;->b(DDI)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected E([D[DI)Ljava/util/Map;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([D[DI)",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;>;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const/4 v1, 0x0

    :goto_0
    if-lt v1, p3, :cond_0

    return-object v0

    :cond_0
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aget-wide v3, p1, v1

    aget-wide v5, p2, v1

    iget-object v7, p0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v7}, Lorg/achartengine/h/d;->A0()I

    move-result v7

    invoke-static {v3, v4, v5, v6, v7}, Lorg/achartengine/j/b;->b(DDI)Ljava/util/List;

    move-result-object v3

    invoke-direct {p0, v3}, Lorg/achartengine/f/i;->C(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method protected F()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public G(Lorg/achartengine/h/c;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public I(FFI)[D
    .locals 16

    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    iget-object v4, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v4, v3}, Lorg/achartengine/h/d;->o0(I)D

    move-result-wide v4

    iget-object v6, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v6, v3}, Lorg/achartengine/h/d;->n0(I)D

    move-result-wide v6

    iget-object v8, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v8, v3}, Lorg/achartengine/h/d;->z0(I)D

    move-result-wide v8

    iget-object v10, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v10, v3}, Lorg/achartengine/h/d;->y0(I)D

    move-result-wide v10

    iget-object v12, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v12, v3}, Lorg/achartengine/h/d;->T0(I)Z

    move-result v12

    const/4 v13, 0x2

    const/4 v14, 0x1

    const/4 v15, 0x0

    if-eqz v12, :cond_0

    iget-object v12, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v12, v3}, Lorg/achartengine/h/d;->R0(I)Z

    move-result v12

    if-eqz v12, :cond_0

    iget-object v12, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v12, v3}, Lorg/achartengine/h/d;->T0(I)Z

    move-result v12

    if-eqz v12, :cond_0

    iget-object v12, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v12, v3}, Lorg/achartengine/h/d;->S0(I)Z

    move-result v12

    if-nez v12, :cond_1

    :cond_0
    invoke-virtual {v0, v3}, Lorg/achartengine/f/i;->x(I)[D

    move-result-object v3

    aget-wide v4, v3, v15

    aget-wide v6, v3, v14

    aget-wide v8, v3, v13

    const/4 v10, 0x3

    aget-wide v10, v3, v10

    :cond_1
    iget-object v3, v0, Lorg/achartengine/f/i;->g:Landroid/graphics/Rect;

    if-eqz v3, :cond_2

    new-array v12, v13, [D

    iget v13, v3, Landroid/graphics/Rect;->left:I

    int-to-float v13, v13

    sub-float/2addr v1, v13

    float-to-double v14, v1

    sub-double/2addr v6, v4

    mul-double/2addr v14, v6

    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-double v6, v1

    div-double/2addr v14, v6

    add-double/2addr v14, v4

    const/4 v1, 0x0

    aput-wide v14, v12, v1

    iget-object v1, v0, Lorg/achartengine/f/i;->g:Landroid/graphics/Rect;

    iget v3, v1, Landroid/graphics/Rect;->top:I

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v1

    add-int/2addr v3, v1

    int-to-float v1, v3

    sub-float/2addr v1, v2

    float-to-double v1, v1

    sub-double/2addr v10, v8

    mul-double/2addr v1, v10

    iget-object v3, v0, Lorg/achartengine/f/i;->g:Landroid/graphics/Rect;

    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v3

    int-to-double v3, v3

    div-double/2addr v1, v3

    add-double/2addr v1, v8

    const/4 v3, 0x1

    aput-wide v1, v12, v3

    return-object v12

    :cond_2
    move v3, v14

    new-array v4, v13, [D

    float-to-double v5, v1

    const/4 v1, 0x0

    aput-wide v5, v4, v1

    float-to-double v1, v2

    aput-wide v1, v4, v3

    return-object v4
.end method

.method public b(Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;)V
    .locals 50

    move-object/from16 v15, p0

    move-object/from16 v0, p1

    move/from16 v13, p2

    move/from16 v14, p3

    move/from16 v12, p4

    move/from16 v11, p5

    move-object/from16 v10, p6

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->u()Z

    move-result v1

    invoke-virtual {v10, v1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    div-int/lit8 v2, v11, 0x5

    invoke-virtual {v1}, Lorg/achartengine/h/d;->e0()F

    move-result v3

    invoke-virtual {v15, v1, v2, v3}, Lorg/achartengine/f/a;->l(Lorg/achartengine/h/b;IF)I

    move-result v16

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->i()[I

    move-result-object v17

    const/4 v9, 0x1

    aget v1, v17, v9

    add-int v8, v13, v1

    const/4 v7, 0x0

    aget v1, v17, v7

    add-int v6, v14, v1

    add-int v5, v13, v12

    const/16 v18, 0x3

    aget v1, v17, v18

    sub-int v4, v5, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v1}, Lorg/achartengine/g/d;->d()I

    move-result v3

    new-array v2, v3, [Ljava/lang/String;

    move v1, v7

    :goto_0
    if-lt v1, v3, :cond_41

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->y()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->H()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    const/16 v19, 0x1

    move-object/from16 v20, v1

    move-object/from16 v1, p0

    move-object/from16 v21, v2

    move-object/from16 v2, p1

    move/from16 v22, v3

    move-object/from16 v3, v20

    move/from16 v20, v4

    move-object/from16 v4, v21

    move/from16 v23, v5

    move v5, v8

    move/from16 v24, v6

    move/from16 v6, v20

    move/from16 v7, p3

    move/from16 v26, v8

    move/from16 v8, p4

    move/from16 v9, p5

    move/from16 v10, v16

    move v13, v11

    move-object/from16 v11, p6

    move v0, v12

    move/from16 v12, v19

    invoke-virtual/range {v1 .. v12}, Lorg/achartengine/f/a;->d(Landroid/graphics/Canvas;Lorg/achartengine/h/b;[Ljava/lang/String;IIIIIILandroid/graphics/Paint;Z)I

    move-result v1

    move/from16 v19, v1

    goto :goto_1

    :cond_0
    move-object/from16 v21, v2

    move/from16 v22, v3

    move/from16 v20, v4

    move/from16 v23, v5

    move/from16 v24, v6

    move/from16 v26, v8

    move v13, v11

    move v0, v12

    move/from16 v19, v16

    :goto_1
    add-int v11, v14, v13

    const/4 v12, 0x2

    aget v1, v17, v12

    sub-int v1, v11, v1

    sub-int v10, v1, v19

    iget-object v1, v15, Lorg/achartengine/f/i;->g:Landroid/graphics/Rect;

    if-nez v1, :cond_1

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, v15, Lorg/achartengine/f/i;->g:Landroid/graphics/Rect;

    :cond_1
    iget-object v1, v15, Lorg/achartengine/f/i;->g:Landroid/graphics/Rect;

    move/from16 v7, v20

    move/from16 v8, v24

    move/from16 v9, v26

    invoke-virtual {v1, v9, v8, v7, v10}, Landroid/graphics/Rect;->set(IIII)V

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    const/16 v16, 0x0

    const/16 v20, 0x0

    move-object/from16 v1, p0

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    move/from16 v6, p4

    move/from16 v24, v7

    move/from16 v7, p5

    move/from16 v26, v8

    move-object/from16 v8, p6

    move/from16 v28, v9

    move/from16 v9, v16

    move/from16 v16, v10

    move/from16 v10, v20

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/a;->c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V

    invoke-virtual/range {p6 .. p6}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v1

    if-eqz v1, :cond_4

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->o()Landroid/graphics/Typeface;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual/range {p6 .. p6}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->o()Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    :cond_2
    invoke-virtual/range {p6 .. p6}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual/range {p6 .. p6}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Typeface;->getStyle()I

    move-result v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->q()I

    move-result v2

    if-eq v1, v2, :cond_3

    goto :goto_2

    :cond_3
    move-object/from16 v10, p6

    goto :goto_4

    :cond_4
    :goto_2
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->o()Landroid/graphics/Typeface;

    move-result-object v1

    if-eqz v1, :cond_5

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->o()Landroid/graphics/Typeface;

    move-result-object v1

    move-object/from16 v10, p6

    goto :goto_3

    :cond_5
    move-object/from16 v10, p6

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->p()Ljava/lang/String;

    move-result-object v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->q()I

    move-result v2

    invoke-static {v1, v2}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v1

    :goto_3
    invoke-virtual {v10, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    :goto_4
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->j0()Lorg/achartengine/h/d$a;

    move-result-object v9

    sget-object v1, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    if-ne v9, v1, :cond_6

    sub-int v4, v24, v19

    add-int/lit8 v1, v19, -0x14

    add-int v1, v16, v1

    move v7, v1

    move v8, v4

    goto :goto_5

    :cond_6
    move/from16 v7, v16

    move/from16 v8, v24

    :goto_5
    invoke-virtual {v9}, Lorg/achartengine/h/d$a;->a()I

    move-result v6

    const/16 v1, 0x5a

    if-ne v6, v1, :cond_7

    const/16 v20, 0x1

    goto :goto_6

    :cond_7
    const/16 v20, 0x0

    :goto_6
    int-to-float v1, v13

    int-to-float v2, v0

    div-float/2addr v1, v2

    iput v1, v15, Lorg/achartengine/f/i;->d:F

    sub-int v1, v0, v13

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    div-int/2addr v1, v12

    int-to-float v1, v1

    iput v1, v15, Lorg/achartengine/f/i;->e:F

    iget v2, v15, Lorg/achartengine/f/i;->d:F

    const/high16 v3, 0x3f800000    # 1.0f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_8

    const/high16 v2, -0x40800000    # -1.0f

    mul-float/2addr v1, v2

    iput v1, v15, Lorg/achartengine/f/i;->e:F

    :cond_8
    new-instance v1, Lorg/achartengine/g/a;

    move/from16 v5, v23

    div-int/lit8 v2, v5, 0x2

    int-to-float v2, v2

    div-int/lit8 v3, v11, 0x2

    int-to-float v3, v3

    invoke-direct {v1, v2, v3}, Lorg/achartengine/g/a;-><init>(FF)V

    iput-object v1, v15, Lorg/achartengine/f/i;->f:Lorg/achartengine/g/a;

    if-eqz v20, :cond_9

    int-to-float v1, v6

    move-object/from16 v0, p1

    const/4 v4, 0x0

    invoke-direct {v15, v0, v1, v4}, Lorg/achartengine/f/i;->J(Landroid/graphics/Canvas;FZ)V

    goto :goto_7

    :cond_9
    move-object/from16 v0, p1

    const/4 v4, 0x0

    :goto_7
    const v1, -0x7fffffff

    move v2, v4

    move/from16 v3, v22

    :goto_8
    if-lt v2, v3, :cond_40

    move-object/from16 v16, v9

    const/4 v9, 0x1

    add-int/lit8 v2, v1, 0x1

    if-gez v2, :cond_a

    return-void

    :cond_a
    new-array v1, v2, [D

    new-array v12, v2, [D

    new-array v9, v2, [D

    move-object/from16 v23, v9

    new-array v9, v2, [D

    new-array v4, v2, [Z

    move/from16 v24, v5

    new-array v5, v2, [Z

    move/from16 v29, v6

    new-array v6, v2, [Z

    move/from16 v30, v8

    new-array v8, v2, [Z

    move-object/from16 v31, v1

    const/4 v1, 0x0

    :goto_9
    if-lt v1, v2, :cond_3e

    new-array v1, v2, [D

    move-object/from16 v32, v9

    new-array v9, v2, [D

    move-object/from16 v33, v1

    const/4 v1, 0x0

    :goto_a
    if-lt v1, v3, :cond_38

    const/4 v1, 0x0

    :goto_b
    if-lt v1, v2, :cond_34

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, v15, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    const/4 v8, 0x0

    const/16 v22, 0x0

    :goto_c
    if-lt v8, v3, :cond_28

    iget-object v3, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    sub-int v8, v13, v7

    const/16 v34, 0x1

    invoke-virtual {v3}, Lorg/achartengine/h/d;->i0()I

    move-result v35

    move-object/from16 v1, p0

    move v6, v2

    move-object v2, v3

    move-object/from16 v3, p1

    const/4 v5, 0x0

    move/from16 v4, p2

    move/from16 v36, v24

    move v5, v7

    move/from16 v39, v6

    move/from16 v38, v29

    move/from16 v6, p4

    move/from16 v25, v7

    move v7, v8

    move/from16 v29, v30

    move-object/from16 v8, p6

    move-object/from16 v0, v16

    move-object/from16 v13, v23

    move-object/from16 v23, v9

    move/from16 v16, v11

    move-object/from16 v11, v32

    move/from16 v9, v34

    move/from16 v10, v35

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/a;->c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    const/4 v10, 0x0

    aget v7, v17, v10

    const/4 v9, 0x1

    invoke-virtual {v2}, Lorg/achartengine/h/d;->i0()I

    move-result v24

    move/from16 v5, p3

    move v11, v10

    move/from16 v10, v24

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/a;->c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V

    sget-object v1, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    if-ne v0, v1, :cond_b

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    move/from16 v10, v28

    sub-int v6, v10, p2

    sub-int v24, p5, v14

    const/4 v9, 0x1

    invoke-virtual {v2}, Lorg/achartengine/h/d;->i0()I

    move-result v27

    move-object/from16 v1, p0

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    move/from16 v7, v24

    move-object/from16 v8, p6

    move v11, v10

    move/from16 v10, v27

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/a;->c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    aget v6, v17, v18

    invoke-virtual {v2}, Lorg/achartengine/h/d;->i0()I

    move-result v10

    move/from16 v4, v29

    :goto_d
    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/a;->c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V

    goto :goto_e

    :cond_b
    move/from16 v11, v28

    sget-object v1, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    if-ne v0, v1, :cond_c

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    move/from16 v10, v29

    sub-int v6, p4, v10

    sub-int v17, p5, v14

    const/4 v9, 0x1

    invoke-virtual {v2}, Lorg/achartengine/h/d;->i0()I

    move-result v18

    move-object/from16 v1, p0

    move-object/from16 v3, p1

    move v4, v10

    move/from16 v5, p3

    move/from16 v7, v17

    move-object/from16 v8, p6

    move/from16 v10, v18

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/a;->c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    sub-int v6, v11, p2

    invoke-virtual {v2}, Lorg/achartengine/h/d;->i0()I

    move-result v10

    move/from16 v4, p2

    goto :goto_d

    :cond_c
    :goto_e
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->G()Z

    move-result v1

    if-eqz v1, :cond_d

    if-eqz v22, :cond_d

    const/16 v17, 0x1

    goto :goto_f

    :cond_d
    const/16 v17, 0x0

    :goto_f
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->E()Z

    move-result v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->I()Z

    move-result v18

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->D()Z

    move-result v22

    if-nez v17, :cond_f

    if-eqz v1, :cond_e

    goto :goto_10

    :cond_e
    move-object v10, v0

    move/from16 v14, v25

    move/from16 v9, v26

    move/from16 v13, v29

    move/from16 v43, v39

    move-object/from16 v0, p6

    goto/16 :goto_1c

    :cond_f
    :goto_10
    const/4 v1, 0x0

    aget-wide v2, v31, v1

    aget-wide v4, v12, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->p0()I

    move-result v6

    move-object/from16 v1, p0

    invoke-virtual/range {v1 .. v6}, Lorg/achartengine/f/i;->D(DDI)Ljava/util/List;

    move-result-object v1

    invoke-direct {v15, v1}, Lorg/achartengine/f/i;->C(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    move-object/from16 v10, v32

    move/from16 v9, v39

    invoke-virtual {v15, v13, v10, v9}, Lorg/achartengine/f/i;->E([D[DI)Ljava/util/Map;

    move-result-object v24

    if-eqz v17, :cond_10

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->s0()I

    move-result v1

    move-object/from16 v8, p6

    invoke-virtual {v8, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->f()F

    move-result v1

    invoke-virtual {v8, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->q0()Landroid/graphics/Paint$Align;

    move-result-object v1

    invoke-virtual {v8, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    goto :goto_11

    :cond_10
    move-object/from16 v8, p6

    :goto_11
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->v0()[Ljava/lang/Double;

    move-result-object v3

    const/16 v27, 0x0

    aget-wide v32, v33, v27

    aget-wide v30, v31, v27

    aget-wide v34, v12, v27

    move-object/from16 v1, p0

    move-object/from16 v4, p1

    move-object/from16 v5, p6

    move v6, v11

    move/from16 v7, v26

    move-object v12, v8

    move/from16 v8, v25

    move/from16 v39, v9

    move-object/from16 v28, v10

    move-wide/from16 v9, v32

    move-object/from16 v32, v0

    move-object v0, v12

    move/from16 v41, v16

    move-object/from16 v16, v28

    move/from16 v28, v11

    move-wide/from16 v11, v30

    move-object/from16 v27, v13

    move-wide/from16 v13, v34

    invoke-virtual/range {v1 .. v14}, Lorg/achartengine/f/i;->u(Ljava/util/List;[Ljava/lang/Double;Landroid/graphics/Canvas;Landroid/graphics/Paint;IIIDDD)V

    move-object/from16 v2, v24

    move-object/from16 v3, p1

    move-object/from16 v4, p6

    move/from16 v5, v39

    move/from16 v6, v28

    move/from16 v7, v29

    move-object/from16 v9, v23

    move-object/from16 v10, v27

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/i;->w(Ljava/util/Map;Landroid/graphics/Canvas;Landroid/graphics/Paint;IIII[D[D)V

    if-eqz v17, :cond_1a

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->e()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    move/from16 v13, v39

    const/4 v8, 0x0

    :goto_12
    if-lt v8, v13, :cond_11

    move/from16 v39, v13

    goto/16 :goto_18

    :cond_11
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/d;->x0(I)Landroid/graphics/Paint$Align;

    move-result-object v9

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/d;->H0(I)[Ljava/lang/Double;

    move-result-object v10

    array-length v11, v10

    const/4 v12, 0x0

    :goto_13
    if-lt v12, v11, :cond_12

    add-int/lit8 v8, v8, 0x1

    goto :goto_12

    :cond_12
    aget-object v1, v10, v12

    aget-wide v2, v27, v8

    invoke-virtual {v1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v4

    cmpg-double v2, v2, v4

    if-gtz v2, :cond_18

    invoke-virtual {v1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    aget-wide v4, v16, v8

    cmpg-double v2, v2, v4

    if-gtz v2, :cond_18

    move/from16 v14, v25

    int-to-double v2, v14

    aget-wide v4, v23, v8

    invoke-virtual {v1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v6

    aget-wide v24, v27, v8

    sub-double v6, v6, v24

    mul-double/2addr v4, v6

    sub-double/2addr v2, v4

    double-to-float v7, v2

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1, v8}, Lorg/achartengine/h/d;->G0(Ljava/lang/Double;I)Ljava/lang/String;

    move-result-object v24

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/d;->D0(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/d;->B0(I)Landroid/graphics/Paint$Align;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    sget-object v1, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    move-object/from16 v6, v32

    if-ne v6, v1, :cond_16

    sget-object v1, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    if-ne v9, v1, :cond_14

    if-eqz v18, :cond_13

    invoke-direct {v15, v9}, Lorg/achartengine/f/i;->z(Landroid/graphics/Paint$Align;)I

    move-result v1

    move/from16 v5, v28

    add-int/2addr v1, v5

    int-to-float v2, v1

    int-to-float v4, v5

    move-object/from16 v1, p1

    move v3, v7

    move/from16 v25, v11

    move v11, v5

    move v5, v7

    move-object/from16 v28, v10

    move-object v10, v6

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_14

    :cond_13
    move/from16 v25, v11

    move/from16 v11, v28

    move-object/from16 v28, v10

    move-object v10, v6

    :goto_14
    int-to-float v4, v11

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->F0()F

    move-result v1

    sub-float v5, v7, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->C0()F

    move-result v30

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, v24

    move-object/from16 v6, p6

    move/from16 v31, v7

    move/from16 v7, v30

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    move/from16 v39, v13

    move/from16 v13, v29

    goto :goto_15

    :cond_14
    move/from16 v31, v7

    move/from16 v25, v11

    move/from16 v11, v28

    move-object/from16 v28, v10

    move-object v10, v6

    move/from16 v7, v29

    if-eqz v18, :cond_15

    int-to-float v2, v7

    invoke-direct {v15, v9}, Lorg/achartengine/f/i;->z(Landroid/graphics/Paint$Align;)I

    move-result v1

    add-int/2addr v1, v7

    int-to-float v4, v1

    move-object/from16 v1, p1

    move/from16 v3, v31

    move/from16 v5, v31

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    :cond_15
    int-to-float v4, v7

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->F0()F

    move-result v1

    sub-float v5, v31, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->C0()F

    move-result v29

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, v24

    move-object/from16 v6, p6

    move/from16 v39, v13

    move v13, v7

    move/from16 v7, v29

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    :goto_15
    if-eqz v22, :cond_19

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/d;->f0(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v2, v11

    int-to-float v4, v13

    goto :goto_16

    :cond_16
    move/from16 v31, v7

    move/from16 v25, v11

    move/from16 v39, v13

    move/from16 v11, v28

    move/from16 v13, v29

    move-object/from16 v28, v10

    move-object v10, v6

    if-eqz v18, :cond_17

    invoke-direct {v15, v9}, Lorg/achartengine/f/i;->z(Landroid/graphics/Paint$Align;)I

    move-result v1

    sub-int v1, v13, v1

    int-to-float v2, v1

    int-to-float v4, v13

    move-object/from16 v1, p1

    move/from16 v3, v31

    move/from16 v5, v31

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    :cond_17
    add-int/lit8 v1, v13, 0xa

    int-to-float v4, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->F0()F

    move-result v1

    sub-float v5, v31, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->C0()F

    move-result v7

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, v24

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    if-eqz v22, :cond_19

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/d;->f0(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v2, v13

    int-to-float v4, v11

    :goto_16
    move-object/from16 v1, p1

    move/from16 v3, v31

    move/from16 v5, v31

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_17

    :cond_18
    move/from16 v39, v13

    move/from16 v14, v25

    move/from16 v13, v29

    move/from16 v25, v11

    move/from16 v11, v28

    move-object/from16 v28, v10

    move-object/from16 v10, v32

    :cond_19
    :goto_17
    add-int/lit8 v12, v12, 0x1

    move-object/from16 v32, v10

    move/from16 v29, v13

    move-object/from16 v10, v28

    move/from16 v13, v39

    move/from16 v28, v11

    move/from16 v11, v25

    move/from16 v25, v14

    goto/16 :goto_13

    :cond_1a
    :goto_18
    move/from16 v14, v25

    move/from16 v11, v28

    move/from16 v13, v29

    move-object/from16 v10, v32

    if-eqz v17, :cond_1f

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->e()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->e0()F

    move-result v8

    invoke-virtual {v0, v8}, Landroid/graphics/Paint;->setTextSize(F)V

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    sget-object v1, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    if-ne v10, v1, :cond_1d

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->w0()Ljava/lang/String;

    move-result-object v3

    div-int/lit8 v1, p4, 0x2

    move/from16 v9, p2

    add-int/2addr v1, v9

    int-to-float v12, v1

    int-to-float v1, v14

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->f()F

    move-result v2

    const/high16 v4, 0x40800000    # 4.0f

    mul-float/2addr v2, v4

    const/high16 v4, 0x40400000    # 3.0f

    div-float/2addr v2, v4

    add-float/2addr v1, v2

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/d;->t0()F

    move-result v2

    add-float/2addr v1, v2

    add-float v5, v1, v8

    const/4 v7, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move v4, v12

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    move/from16 v6, v39

    const/4 v7, 0x0

    :goto_19
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    if-lt v7, v6, :cond_1b

    invoke-virtual {v1}, Lorg/achartengine/h/b;->d()F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->c()Ljava/lang/String;

    move-result-object v3

    move/from16 v8, p3

    int-to-float v1, v8

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/b;->d()F

    move-result v2

    add-float v5, v1, v2

    const/4 v7, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move v4, v12

    move v9, v6

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    move/from16 v43, v9

    goto/16 :goto_1b

    :cond_1b
    invoke-virtual {v1, v7}, Lorg/achartengine/h/d;->x0(I)Landroid/graphics/Paint$Align;

    move-result-object v1

    sget-object v2, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    if-ne v1, v2, :cond_1c

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v7}, Lorg/achartengine/h/d;->J0(I)Ljava/lang/String;

    move-result-object v3

    int-to-float v1, v9

    add-float v4, v1, v8

    div-int/lit8 v1, p5, 0x2

    add-int v1, p3, v1

    int-to-float v5, v1

    const/high16 v16, -0x3d4c0000    # -90.0f

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v43, v6

    move-object/from16 v6, p6

    move/from16 v17, v12

    move v12, v7

    move/from16 v7, v16

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    move/from16 v25, v36

    goto :goto_1a

    :cond_1c
    move/from16 v43, v6

    move/from16 v17, v12

    move v12, v7

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v12}, Lorg/achartengine/h/d;->J0(I)Ljava/lang/String;

    move-result-object v3

    move/from16 v7, v36

    int-to-float v4, v7

    div-int/lit8 v1, p5, 0x2

    add-int v1, p3, v1

    int-to-float v5, v1

    const/high16 v16, -0x3d4c0000    # -90.0f

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v6, p6

    move/from16 v25, v7

    move/from16 v7, v16

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    :goto_1a
    add-int/lit8 v7, v12, 0x1

    move/from16 v12, v17

    move/from16 v36, v25

    move/from16 v6, v43

    goto/16 :goto_19

    :cond_1d
    move/from16 v9, p2

    move/from16 v43, v39

    sget-object v1, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    if-ne v10, v1, :cond_1e

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->w0()Ljava/lang/String;

    move-result-object v3

    div-int/lit8 v1, p4, 0x2

    add-int/2addr v1, v9

    int-to-float v4, v1

    move/from16 v7, v41

    int-to-float v1, v7

    sub-float/2addr v1, v8

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/d;->t0()F

    move-result v2

    add-float v5, v1, v2

    const/high16 v7, -0x3d4c0000    # -90.0f

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->I0()Ljava/lang/String;

    move-result-object v3

    add-int/lit8 v1, v13, 0x14

    int-to-float v4, v1

    div-int/lit8 v12, p5, 0x2

    add-int v1, p3, v12

    int-to-float v5, v1

    const/4 v7, 0x0

    move-object/from16 v1, p0

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->d()F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->c()Ljava/lang/String;

    move-result-object v3

    int-to-float v1, v9

    add-float v4, v1, v8

    move/from16 v9, v26

    add-int v6, v9, v12

    int-to-float v5, v6

    move-object/from16 v1, p0

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    goto :goto_1c

    :cond_1e
    :goto_1b
    move/from16 v9, v26

    goto :goto_1c

    :cond_1f
    move/from16 v9, v26

    move/from16 v43, v39

    :goto_1c
    sget-object v1, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    if-ne v10, v1, :cond_20

    iget-object v3, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v3}, Lorg/achartengine/h/d;->t0()F

    move-result v1

    float-to-int v1, v1

    add-int v7, p3, v1

    const/4 v12, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v4, v21

    move v5, v11

    move v6, v13

    move/from16 v8, p4

    move/from16 v44, v9

    move/from16 v9, p5

    move-object/from16 v45, v10

    move/from16 v10, v19

    move/from16 v26, v11

    move-object/from16 v11, p6

    invoke-virtual/range {v1 .. v12}, Lorg/achartengine/f/a;->d(Landroid/graphics/Canvas;Lorg/achartengine/h/b;[Ljava/lang/String;IIIIIILandroid/graphics/Paint;Z)I

    move-object/from16 v11, p1

    move/from16 v29, v13

    move/from16 v48, v38

    move-object/from16 v47, v45

    goto :goto_1d

    :cond_20
    move/from16 v44, v9

    move-object/from16 v45, v10

    move/from16 v26, v11

    sget-object v1, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    move-object/from16 v2, v45

    if-ne v2, v1, :cond_21

    move/from16 v12, v38

    int-to-float v11, v12

    move-object/from16 v10, p1

    move-object v9, v2

    const/4 v8, 0x1

    invoke-direct {v15, v10, v11, v8}, Lorg/achartengine/f/i;->J(Landroid/graphics/Canvas;FZ)V

    iget-object v3, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v3}, Lorg/achartengine/h/d;->t0()F

    move-result v1

    float-to-int v1, v1

    add-int v7, p3, v1

    const/16 v16, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v4, v21

    move/from16 v5, v26

    move v6, v13

    move/from16 v8, p4

    move-object/from16 v47, v9

    move/from16 v9, p5

    move/from16 v10, v19

    move/from16 v29, v13

    move v13, v11

    move-object/from16 v11, p6

    move/from16 v48, v12

    move/from16 v12, v16

    invoke-virtual/range {v1 .. v12}, Lorg/achartengine/f/a;->d(Landroid/graphics/Canvas;Lorg/achartengine/h/b;[Ljava/lang/String;IIIIIILandroid/graphics/Paint;Z)I

    move-object/from16 v11, p1

    const/4 v10, 0x0

    invoke-direct {v15, v11, v13, v10}, Lorg/achartengine/f/i;->J(Landroid/graphics/Canvas;FZ)V

    goto :goto_1e

    :cond_21
    move-object/from16 v11, p1

    move-object/from16 v47, v2

    move/from16 v29, v13

    move/from16 v48, v38

    :goto_1d
    const/4 v10, 0x0

    :goto_1e
    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->B()Z

    move-result v1

    if-eqz v1, :cond_26

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->r()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    move/from16 v13, v26

    int-to-float v7, v13

    int-to-float v8, v14

    move/from16 v6, v29

    int-to-float v9, v6

    move-object/from16 v1, p1

    move v2, v7

    move v3, v8

    move v4, v9

    move v5, v8

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->s()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    move v1, v10

    move v12, v1

    move/from16 v5, v43

    :goto_1f
    if-ge v1, v5, :cond_24

    if-eqz v12, :cond_22

    goto :goto_21

    :cond_22
    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->x0(I)Landroid/graphics/Paint$Align;

    move-result-object v2

    sget-object v3, Landroid/graphics/Paint$Align;->RIGHT:Landroid/graphics/Paint$Align;

    if-ne v2, v3, :cond_23

    const/4 v12, 0x1

    goto :goto_20

    :cond_23
    move v12, v10

    :goto_20
    add-int/lit8 v1, v1, 0x1

    goto :goto_1f

    :cond_24
    :goto_21
    sget-object v1, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    move-object/from16 v4, v47

    move/from16 v2, v44

    if-ne v4, v1, :cond_25

    int-to-float v10, v2

    move-object/from16 v1, p1

    move v2, v7

    move v3, v10

    move v4, v7

    move v5, v8

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    if-eqz v12, :cond_26

    move-object/from16 v1, p1

    move v2, v9

    move v3, v10

    goto :goto_22

    :cond_25
    sget-object v1, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    if-ne v4, v1, :cond_26

    int-to-float v3, v2

    move-object/from16 v1, p1

    move v2, v9

    :goto_22
    move v4, v9

    move v5, v8

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    :cond_26
    if-eqz v20, :cond_27

    move/from16 v1, v48

    int-to-float v0, v1

    const/4 v1, 0x1

    invoke-direct {v15, v11, v0, v1}, Lorg/achartengine/f/i;->J(Landroid/graphics/Canvas;FZ)V

    :cond_27
    return-void

    :cond_28
    move v5, v2

    move v14, v7

    move v7, v11

    move-object/from16 v4, v16

    move-object/from16 v27, v23

    move/from16 v25, v24

    move/from16 v2, v26

    move/from16 v13, v28

    move/from16 v1, v29

    move/from16 v6, v30

    move-object/from16 v16, v32

    const/16 v26, 0x1

    move-object v11, v0

    move-object/from16 v23, v9

    move-object v0, v10

    move/from16 v9, p2

    iget-object v10, v15, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v10, v8}, Lorg/achartengine/g/d;->c(I)Lorg/achartengine/g/e;

    move-result-object v10

    invoke-virtual {v10}, Lorg/achartengine/g/e;->o()I

    move-result v24

    invoke-virtual {v10}, Lorg/achartengine/g/e;->h()I

    move-result v28

    if-nez v28, :cond_29

    move/from16 v28, v1

    move/from16 v37, v2

    move/from16 v36, v3

    move-object/from16 v44, v4

    move/from16 v41, v5

    move/from16 v32, v6

    move/from16 v29, v7

    move/from16 v30, v8

    move-object/from16 v40, v12

    move/from16 v42, v14

    const/16 v47, 0x0

    goto/16 :goto_28

    :cond_29
    move/from16 v29, v1

    iget-object v1, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v8}, Lorg/achartengine/h/b;->m(I)Lorg/achartengine/h/c;

    move-result-object v1

    move-object/from16 v22, v1

    check-cast v22, Lorg/achartengine/h/e;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v28, v1

    int-to-float v1, v14

    move/from16 v32, v6

    move/from16 v30, v7

    int-to-double v6, v14

    aget-wide v34, v23, v24

    aget-wide v38, v27, v24

    mul-double v34, v34, v38

    move/from16 v44, v2

    move/from16 v36, v3

    add-double v2, v6, v34

    double-to-float v2, v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v34

    new-instance v3, Ljava/util/LinkedList;

    invoke-direct {v3}, Ljava/util/LinkedList;-><init>()V

    iget-object v1, v15, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-enter v10

    :try_start_0
    aget-wide v39, v31, v24

    aget-wide v41, v12, v24

    invoke-virtual/range {v22 .. v22}, Lorg/achartengine/h/c;->d()Z

    move-result v43

    move-object/from16 v38, v10

    invoke-virtual/range {v38 .. v43}, Lorg/achartengine/g/e;->n(DDZ)Ljava/util/SortedMap;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/SortedMap;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v35

    const/16 v38, -0x1

    move/from16 v39, v38

    :goto_23
    invoke-interface/range {v35 .. v35}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_2e

    invoke-virtual {v10}, Lorg/achartengine/g/e;->d()I

    move-result v2

    if-lez v2, :cond_2c

    invoke-virtual/range {v22 .. v22}, Lorg/achartengine/h/e;->i()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual/range {v22 .. v22}, Lorg/achartengine/h/e;->k()F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    invoke-virtual/range {v22 .. v22}, Lorg/achartengine/h/e;->j()Landroid/graphics/Paint$Align;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    move/from16 v40, v8

    const/4 v8, 0x0

    :goto_24
    if-lt v8, v2, :cond_2a

    move/from16 v41, v5

    goto/16 :goto_26

    :cond_2a
    move/from16 v35, v2

    move-object/from16 v41, v3

    int-to-double v2, v13

    aget-wide v42, v33, v24

    invoke-virtual {v10, v8}, Lorg/achartengine/g/e;->e(I)D

    move-result-wide v45

    aget-wide v47, v31, v24

    sub-double v45, v45, v47

    mul-double v42, v42, v45

    add-double v2, v2, v42

    double-to-float v3, v2

    aget-wide v42, v23, v24

    invoke-virtual {v10, v8}, Lorg/achartengine/g/e;->f(I)D

    move-result-wide v45

    aget-wide v47, v27, v24

    sub-double v45, v45, v47

    mul-double v42, v42, v45

    move-object/from16 v47, v4

    move/from16 v45, v5

    sub-double v4, v6, v42

    double-to-float v5, v4

    invoke-virtual {v10, v8}, Lorg/achartengine/g/e;->c(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v10, v8}, Lorg/achartengine/g/e;->c(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    move/from16 v42, v14

    const/4 v14, 0x0

    invoke-virtual {v0, v2, v14, v4, v1}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v2

    int-to-float v2, v2

    add-float/2addr v2, v3

    cmpg-float v2, v3, v2

    if-gez v2, :cond_2b

    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->getHeight()I

    move-result v2

    int-to-float v2, v2

    cmpg-float v2, v5, v2

    if-gez v2, :cond_2b

    invoke-virtual {v10, v8}, Lorg/achartengine/g/e;->c(I)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v2, v28

    move/from16 v28, v29

    move-object/from16 v29, v1

    move-object/from16 v1, p0

    move-object/from16 v43, v2

    move/from16 v37, v44

    move-object/from16 v2, p1

    move-object/from16 v14, v41

    move/from16 v41, v3

    move-object v3, v4

    move-object/from16 v44, v47

    move/from16 v4, v41

    move/from16 v41, v45

    move-wide/from16 v45, v6

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v6}, Lorg/achartengine/f/a;->h(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto :goto_25

    :cond_2b
    move-object/from16 v43, v28

    move/from16 v28, v29

    move-object/from16 v14, v41

    move/from16 v37, v44

    move/from16 v41, v45

    move-object/from16 v44, v47

    move-object/from16 v29, v1

    move-wide/from16 v45, v6

    :goto_25
    add-int/lit8 v8, v8, 0x1

    move-object v3, v14

    move-object/from16 v1, v29

    move/from16 v2, v35

    move/from16 v5, v41

    move/from16 v14, v42

    move-object/from16 v4, v44

    move-wide/from16 v6, v45

    move/from16 v29, v28

    move/from16 v44, v37

    move-object/from16 v28, v43

    goto/16 :goto_24

    :cond_2c
    move/from16 v41, v5

    move/from16 v40, v8

    :goto_26
    move/from16 v42, v14

    move-object/from16 v43, v28

    move/from16 v28, v29

    move/from16 v37, v44

    move-object v14, v3

    move-object/from16 v44, v4

    invoke-interface/range {v43 .. v43}, Ljava/util/List;->size()I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lez v1, :cond_2d

    move-object/from16 v1, p0

    move-object v2, v10

    move-object/from16 v3, p1

    move-object/from16 v4, p6

    move-object/from16 v5, v43

    move-object/from16 v6, v22

    move/from16 v29, v30

    move/from16 v7, v34

    move/from16 v30, v40

    move/from16 v8, v30

    move-object/from16 v9, v44

    move-object/from16 v40, v12

    const/16 v47, 0x0

    move-object v12, v10

    move/from16 v10, v39

    :try_start_1
    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/i;->s(Lorg/achartengine/g/e;Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FILorg/achartengine/h/d$a;I)V

    move-object/from16 v1, p0

    move-object/from16 v2, v43

    move-object v3, v11

    move/from16 v4, v34

    move/from16 v5, v30

    move/from16 v6, v39

    invoke-virtual/range {v1 .. v6}, Lorg/achartengine/f/i;->p(Ljava/util/List;Ljava/util/List;FII)[Lorg/achartengine/f/b;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v14, v1}, Ljava/util/LinkedList;->addAll(Ljava/util/Collection;)Z

    goto :goto_27

    :cond_2d
    move/from16 v29, v30

    move/from16 v30, v40

    const/16 v47, 0x0

    move-object/from16 v40, v12

    move-object v12, v10

    :goto_27
    monitor-exit v12

    move/from16 v22, v26

    :goto_28
    add-int/lit8 v8, v30, 0x1

    move/from16 v14, p3

    move-object v10, v0

    move-object/from16 v9, v23

    move/from16 v24, v25

    move-object/from16 v23, v27

    move/from16 v11, v29

    move/from16 v30, v32

    move/from16 v3, v36

    move/from16 v26, v37

    move-object/from16 v12, v40

    move/from16 v2, v41

    move/from16 v7, v42

    move-object/from16 v0, p1

    move-object/from16 v32, v16

    move/from16 v29, v28

    move-object/from16 v16, v44

    move/from16 v28, v13

    move/from16 v13, p5

    goto/16 :goto_c

    :cond_2e
    move/from16 v41, v5

    move-wide/from16 v45, v6

    move-object/from16 v40, v12

    move/from16 v42, v14

    move-object/from16 v43, v28

    move/from16 v28, v29

    move/from16 v29, v30

    move/from16 v37, v44

    const/16 v47, 0x0

    move-object v14, v3

    move-object/from16 v44, v4

    move/from16 v30, v8

    move-object v12, v10

    invoke-interface/range {v35 .. v35}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Double;

    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Double;

    invoke-virtual {v4}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v4

    if-gez v39, :cond_30

    invoke-virtual {v15, v4, v5}, Lorg/achartengine/f/a;->n(D)Z

    move-result v6

    if-eqz v6, :cond_2f

    invoke-virtual/range {p0 .. p0}, Lorg/achartengine/f/i;->F()Z

    move-result v6

    if-eqz v6, :cond_30

    :cond_2f
    invoke-virtual {v12, v2, v3}, Lorg/achartengine/g/e;->g(D)I

    move-result v6

    move/from16 v39, v6

    :cond_30
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Double;

    invoke-interface {v11, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Double;

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v15, v4, v5}, Lorg/achartengine/f/a;->n(D)Z

    move-result v1

    if-nez v1, :cond_31

    int-to-double v6, v13

    aget-wide v8, v33, v24

    aget-wide v48, v31, v24

    sub-double v2, v2, v48

    mul-double/2addr v8, v2

    add-double/2addr v6, v8

    double-to-float v1, v6

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    move-object/from16 v10, v43

    invoke-interface {v10, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    aget-wide v1, v23, v24

    aget-wide v6, v27, v24

    sub-double/2addr v4, v6

    mul-double/2addr v1, v4

    sub-double v6, v45, v1

    double-to-float v1, v6

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    :goto_29
    invoke-interface {v10, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2a

    :cond_31
    move-object/from16 v10, v43

    invoke-virtual/range {p0 .. p0}, Lorg/achartengine/f/i;->F()Z

    move-result v1

    if-eqz v1, :cond_32

    int-to-double v4, v13

    aget-wide v6, v33, v24

    aget-wide v8, v31, v24

    sub-double/2addr v2, v8

    mul-double/2addr v6, v2

    add-double/2addr v4, v6

    double-to-float v1, v4

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-interface {v10, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    aget-wide v1, v23, v24

    aget-wide v3, v27, v24

    neg-double v3, v3

    mul-double/2addr v1, v3

    sub-double v6, v45, v1

    double-to-float v1, v6

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    goto :goto_29

    :goto_2a
    move/from16 v9, p2

    move-object v3, v14

    move/from16 v8, v30

    move/from16 v5, v41

    move/from16 v14, v42

    move-object/from16 v4, v44

    move-wide/from16 v6, v45

    move/from16 v30, v29

    move/from16 v44, v37

    move/from16 v29, v28

    move-object/from16 v28, v10

    move-object v10, v12

    move-object/from16 v12, v40

    goto/16 :goto_23

    :cond_32
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_33

    move-object/from16 v1, p0

    move-object v2, v12

    move-object/from16 v3, p1

    move-object/from16 v4, p6

    move-object v5, v10

    move-object/from16 v6, v22

    move/from16 v7, v34

    move/from16 v8, v30

    move-object/from16 v9, v44

    move-object/from16 v43, v10

    move/from16 v10, v39

    invoke-virtual/range {v1 .. v10}, Lorg/achartengine/f/i;->s(Lorg/achartengine/g/e;Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FILorg/achartengine/h/d$a;I)V

    move-object/from16 v1, p0

    move-object/from16 v2, v43

    move-object v3, v11

    move/from16 v4, v34

    move/from16 v5, v30

    move/from16 v6, v39

    invoke-virtual/range {v1 .. v6}, Lorg/achartengine/f/i;->p(Ljava/util/List;Ljava/util/List;FII)[Lorg/achartengine/f/b;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v14, v1}, Ljava/util/LinkedList;->addAll(Ljava/util/Collection;)Z

    invoke-interface/range {v43 .. v43}, Ljava/util/List;->clear()V

    invoke-interface {v11}, Ljava/util/List;->clear()V

    move/from16 v39, v38

    goto :goto_2b

    :cond_33
    move-object/from16 v43, v10

    :goto_2b
    const/4 v1, 0x0

    invoke-virtual {v14, v1}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z

    move/from16 v9, p2

    move-object v10, v12

    move-object v3, v14

    move/from16 v8, v30

    move-object/from16 v12, v40

    move/from16 v5, v41

    move/from16 v14, v42

    move-object/from16 v4, v44

    move-wide/from16 v6, v45

    move/from16 v30, v29

    move/from16 v44, v37

    move/from16 v29, v28

    move-object/from16 v28, v43

    goto/16 :goto_23

    :catchall_0
    move-exception v0

    move-object v12, v10

    :goto_2c
    monitor-exit v12
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    throw v0

    :catchall_1
    move-exception v0

    goto :goto_2c

    :cond_34
    move/from16 v41, v2

    move/from16 v36, v3

    move/from16 v42, v7

    move-object v0, v10

    move-object/from16 v40, v12

    move-object/from16 v44, v16

    move-object/from16 v27, v23

    move/from16 v25, v24

    move/from16 v37, v26

    move/from16 v13, v28

    move/from16 v28, v29

    move-object/from16 v16, v32

    const/16 v26, 0x1

    const/16 v47, 0x0

    move-object/from16 v23, v9

    move/from16 v29, v11

    move/from16 v32, v30

    aget-wide v2, v40, v1

    aget-wide v4, v31, v1

    sub-double/2addr v2, v4

    const-wide/16 v4, 0x0

    cmpl-double v2, v2, v4

    if-eqz v2, :cond_35

    sub-int v8, v32, v13

    int-to-double v2, v8

    aget-wide v6, v40, v1

    aget-wide v8, v31, v1

    sub-double/2addr v6, v8

    div-double/2addr v2, v6

    aput-wide v2, v33, v1

    :cond_35
    aget-wide v2, v16, v1

    aget-wide v6, v27, v1

    sub-double/2addr v2, v6

    cmpl-double v2, v2, v4

    if-eqz v2, :cond_36

    sub-int v7, v42, v37

    int-to-double v2, v7

    aget-wide v4, v16, v1

    aget-wide v6, v27, v1

    sub-double/2addr v4, v6

    div-double/2addr v2, v4

    double-to-float v2, v2

    float-to-double v2, v2

    aput-wide v2, v23, v1

    :cond_36
    if-lez v1, :cond_37

    aget-wide v2, v33, v47

    aput-wide v2, v33, v1

    aget-wide v2, v31, v47

    aput-wide v2, v31, v1

    aget-wide v2, v40, v47

    aput-wide v2, v40, v1

    :cond_37
    add-int/lit8 v1, v1, 0x1

    move/from16 v14, p3

    move-object v10, v0

    move-object/from16 v9, v23

    move/from16 v24, v25

    move-object/from16 v23, v27

    move/from16 v11, v29

    move/from16 v30, v32

    move/from16 v3, v36

    move/from16 v26, v37

    move-object/from16 v12, v40

    move/from16 v2, v41

    move/from16 v7, v42

    move-object/from16 v0, p1

    move-object/from16 v32, v16

    move/from16 v29, v28

    move-object/from16 v16, v44

    move/from16 v28, v13

    move/from16 v13, p5

    goto/16 :goto_b

    :cond_38
    move/from16 v41, v2

    move/from16 v36, v3

    move/from16 v42, v7

    move-object v0, v10

    move-object/from16 v40, v12

    move-object/from16 v44, v16

    move-object/from16 v27, v23

    move/from16 v25, v24

    move/from16 v37, v26

    move/from16 v13, v28

    move/from16 v28, v29

    move-object/from16 v16, v32

    const/16 v26, 0x1

    const/16 v47, 0x0

    move-object/from16 v23, v9

    move/from16 v29, v11

    move/from16 v32, v30

    iget-object v2, v15, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/g/d;->c(I)Lorg/achartengine/g/e;

    move-result-object v2

    invoke-virtual {v2}, Lorg/achartengine/g/e;->o()I

    move-result v3

    invoke-virtual {v2}, Lorg/achartengine/g/e;->h()I

    move-result v7

    if-nez v7, :cond_39

    goto/16 :goto_2e

    :cond_39
    aget-boolean v7, v4, v3

    if-nez v7, :cond_3a

    invoke-virtual {v2}, Lorg/achartengine/g/e;->k()D

    move-result-wide v9

    aget-wide v11, v31, v3

    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    aput-wide v9, v31, v3

    iget-object v7, v15, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {v7, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [D

    aget-wide v9, v31, v3

    aput-wide v9, v7, v47

    :cond_3a
    aget-boolean v7, v5, v3

    if-nez v7, :cond_3b

    invoke-virtual {v2}, Lorg/achartengine/g/e;->i()D

    move-result-wide v9

    aget-wide v11, v40, v3

    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9

    aput-wide v9, v40, v3

    iget-object v7, v15, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {v7, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [D

    aget-wide v9, v40, v3

    aput-wide v9, v7, v26

    :cond_3b
    aget-boolean v7, v6, v3

    if-nez v7, :cond_3c

    invoke-virtual {v2}, Lorg/achartengine/g/e;->l()D

    move-result-wide v9

    aget-wide v11, v27, v3

    double-to-float v7, v9

    float-to-double v9, v7

    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    aput-wide v9, v27, v3

    iget-object v7, v15, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {v7, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [D

    aget-wide v9, v27, v3

    const/4 v11, 0x2

    aput-wide v9, v7, v11

    goto :goto_2d

    :cond_3c
    const/4 v11, 0x2

    :goto_2d
    aget-boolean v7, v8, v3

    if-nez v7, :cond_3d

    invoke-virtual {v2}, Lorg/achartengine/g/e;->j()D

    move-result-wide v9

    aget-wide v11, v16, v3

    double-to-float v2, v9

    float-to-double v9, v2

    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9

    aput-wide v9, v16, v3

    iget-object v2, v15, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-interface {v2, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [D

    aget-wide v9, v16, v3

    aput-wide v9, v2, v18

    :cond_3d
    :goto_2e
    add-int/lit8 v1, v1, 0x1

    move/from16 v14, p3

    move-object v10, v0

    move-object/from16 v9, v23

    move/from16 v24, v25

    move-object/from16 v23, v27

    move/from16 v11, v29

    move/from16 v30, v32

    move/from16 v3, v36

    move/from16 v26, v37

    move-object/from16 v12, v40

    move/from16 v2, v41

    move/from16 v7, v42

    move-object/from16 v0, p1

    move-object/from16 v32, v16

    move/from16 v29, v28

    move-object/from16 v16, v44

    move/from16 v28, v13

    move/from16 v13, p5

    goto/16 :goto_a

    :cond_3e
    move/from16 v41, v2

    move/from16 v36, v3

    move/from16 v42, v7

    move-object v0, v10

    move-object/from16 v40, v12

    move-object/from16 v44, v16

    move-object/from16 v27, v23

    move/from16 v25, v24

    move/from16 v37, v26

    move/from16 v13, v28

    move/from16 v28, v29

    move/from16 v32, v30

    const/16 v26, 0x1

    const/16 v47, 0x0

    move-object/from16 v16, v9

    move/from16 v29, v11

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->o0(I)D

    move-result-wide v2

    aput-wide v2, v31, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->n0(I)D

    move-result-wide v2

    aput-wide v2, v40, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->z0(I)D

    move-result-wide v2

    aput-wide v2, v27, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->y0(I)D

    move-result-wide v2

    aput-wide v2, v16, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->T0(I)Z

    move-result v2

    aput-boolean v2, v4, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->R0(I)Z

    move-result v2

    aput-boolean v2, v5, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->U0(I)Z

    move-result v2

    aput-boolean v2, v6, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/h/d;->S0(I)Z

    move-result v2

    aput-boolean v2, v8, v1

    iget-object v2, v15, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_3f

    iget-object v2, v15, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const/4 v7, 0x4

    new-array v7, v7, [D

    invoke-interface {v2, v3, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3f
    add-int/lit8 v1, v1, 0x1

    move/from16 v14, p3

    move-object v10, v0

    move-object/from16 v9, v16

    move/from16 v24, v25

    move-object/from16 v23, v27

    move/from16 v11, v29

    move/from16 v30, v32

    move/from16 v3, v36

    move/from16 v26, v37

    move-object/from16 v12, v40

    move/from16 v2, v41

    move/from16 v7, v42

    move-object/from16 v16, v44

    move-object/from16 v0, p1

    move/from16 v29, v28

    move/from16 v28, v13

    move/from16 v13, p5

    goto/16 :goto_9

    :cond_40
    move/from16 v36, v3

    move/from16 v47, v4

    move/from16 v25, v5

    move/from16 v42, v7

    move/from16 v32, v8

    move-object/from16 v44, v9

    move-object v0, v10

    move/from16 v29, v11

    move/from16 v37, v26

    move/from16 v13, v28

    const/16 v26, 0x1

    move/from16 v28, v6

    iget-object v3, v15, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v3, v2}, Lorg/achartengine/g/d;->c(I)Lorg/achartengine/g/e;

    move-result-object v3

    invoke-virtual {v3}, Lorg/achartengine/g/e;->o()I

    move-result v3

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v1

    add-int/lit8 v2, v2, 0x1

    move/from16 v14, p3

    move/from16 v3, v36

    move/from16 v26, v37

    const/4 v12, 0x2

    move-object/from16 v0, p1

    move/from16 v28, v13

    move/from16 v13, p5

    goto/16 :goto_8

    :cond_41
    move-object/from16 v21, v2

    move/from16 v36, v3

    move/from16 v24, v4

    move/from16 v25, v5

    move/from16 v37, v6

    move/from16 v47, v7

    move v13, v8

    move/from16 v26, v9

    move-object v0, v10

    iget-object v2, v15, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v2, v1}, Lorg/achartengine/g/d;->c(I)Lorg/achartengine/g/e;

    move-result-object v2

    invoke-virtual {v2}, Lorg/achartengine/g/e;->p()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v21, v1

    add-int/lit8 v1, v1, 0x1

    move/from16 v14, p3

    move/from16 v12, p4

    move/from16 v11, p5

    move-object/from16 v2, v21

    move-object/from16 v0, p1

    move/from16 v13, p2

    goto/16 :goto_0
.end method

.method public m(Lorg/achartengine/g/a;)Lorg/achartengine/g/b;
    .locals 8

    iget-object v0, p0, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    if-eqz v0, :cond_4

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v2, v0

    :goto_0
    if-gez v2, :cond_0

    goto :goto_3

    :cond_0
    const/4 v0, 0x0

    iget-object v1, p0, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lorg/achartengine/f/i;->i:Ljava/util/Map;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    move v3, v0

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_2

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/achartengine/f/b;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lorg/achartengine/f/b;->a()Landroid/graphics/RectF;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {p1}, Lorg/achartengine/g/a;->a()F

    move-result v5

    invoke-virtual {p1}, Lorg/achartengine/g/a;->b()F

    move-result v6

    invoke-virtual {v4, v5, v6}, Landroid/graphics/RectF;->contains(FF)Z

    move-result v4

    if-eqz v4, :cond_2

    new-instance p1, Lorg/achartengine/g/b;

    invoke-virtual {v0}, Lorg/achartengine/f/b;->b()D

    move-result-wide v4

    invoke-virtual {v0}, Lorg/achartengine/f/b;->c()D

    move-result-wide v6

    move-object v1, p1

    invoke-direct/range {v1 .. v7}, Lorg/achartengine/g/b;-><init>(IIDD)V

    return-object p1

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_3
    :goto_2
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    :cond_4
    :goto_3
    invoke-super {p0, p1}, Lorg/achartengine/f/a;->m(Lorg/achartengine/g/a;)Lorg/achartengine/g/b;

    move-result-object p1

    return-object p1
.end method

.method protected abstract p(Ljava/util/List;Ljava/util/List;FII)[Lorg/achartengine/f/b;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;FII)[",
            "Lorg/achartengine/f/b;"
        }
    .end annotation
.end method

.method protected q(Landroid/graphics/Canvas;Lorg/achartengine/g/e;Lorg/achartengine/h/e;Landroid/graphics/Paint;Ljava/util/List;II)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Canvas;",
            "Lorg/achartengine/g/e;",
            "Lorg/achartengine/h/e;",
            "Landroid/graphics/Paint;",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;II)V"
        }
    .end annotation

    move-object/from16 v7, p0

    move-object/from16 v8, p2

    move-object/from16 v9, p5

    move/from16 v10, p7

    invoke-interface/range {p5 .. p5}, Ljava/util/List;->size()I

    move-result v0

    const/4 v11, 0x0

    const/4 v12, 0x1

    if-le v0, v12, :cond_5

    invoke-interface {v9, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-interface {v9, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    move v13, v11

    :goto_0
    invoke-interface/range {p5 .. p5}, Ljava/util/List;->size()I

    move-result v2

    if-lt v13, v2, :cond_0

    goto/16 :goto_4

    :cond_0
    const/4 v14, 0x2

    if-ne v13, v14, :cond_2

    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-interface {v9, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    sub-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->o()I

    move-result v3

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    const/4 v15, 0x3

    if-gtz v2, :cond_1

    invoke-interface {v9, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-interface {v9, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    sub-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->o()I

    move-result v3

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-lez v2, :cond_4

    :cond_1
    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/c;->a()Ljava/text/NumberFormat;

    move-result-object v0

    invoke-virtual {v8, v10}, Lorg/achartengine/g/e;->r(I)D

    move-result-wide v1

    invoke-virtual {v7, v0, v1, v2}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v9, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    invoke-interface {v9, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->l()F

    move-result v1

    sub-float v4, v0, v1

    const/4 v6, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/c;->a()Ljava/text/NumberFormat;

    move-result-object v0

    add-int/lit8 v1, v10, 0x1

    invoke-virtual {v8, v1}, Lorg/achartengine/g/e;->r(I)D

    move-result-wide v1

    invoke-virtual {v7, v0, v1, v2}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    invoke-interface {v9, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->l()F

    move-result v1

    sub-float v4, v0, v1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-interface {v9, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    :goto_1
    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    goto/16 :goto_2

    :cond_2
    if-le v13, v14, :cond_4

    invoke-interface {v9, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    sub-float/2addr v2, v0

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->o()I

    move-result v3

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-gtz v2, :cond_3

    add-int/lit8 v2, v13, 0x1

    invoke-interface {v9, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    sub-float/2addr v2, v1

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->o()I

    move-result v3

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-lez v2, :cond_4

    :cond_3
    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/c;->a()Ljava/text/NumberFormat;

    move-result-object v0

    div-int/lit8 v1, v13, 0x2

    add-int/2addr v1, v10

    invoke-virtual {v8, v1}, Lorg/achartengine/g/e;->r(I)D

    move-result-wide v1

    invoke-virtual {v7, v0, v1, v2}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v9, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    add-int/lit8 v14, v13, 0x1

    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->l()F

    move-result v1

    sub-float v4, v0, v1

    const/4 v6, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    invoke-interface {v9, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    goto :goto_1

    :cond_4
    :goto_2
    add-int/lit8 v13, v13, 0x2

    goto/16 :goto_0

    :cond_5
    :goto_3
    invoke-interface/range {p5 .. p5}, Ljava/util/List;->size()I

    move-result v0

    if-lt v11, v0, :cond_6

    :goto_4
    return-void

    :cond_6
    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/c;->a()Ljava/text/NumberFormat;

    move-result-object v0

    div-int/lit8 v1, v11, 0x2

    add-int/2addr v1, v10

    invoke-virtual {v8, v1}, Lorg/achartengine/g/e;->r(I)D

    move-result-wide v1

    invoke-virtual {v7, v0, v1, v2}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v9, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    add-int/lit8 v0, v11, 0x1

    invoke-interface {v9, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual/range {p3 .. p3}, Lorg/achartengine/h/e;->l()F

    move-result v1

    sub-float v4, v0, v1

    const/4 v6, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    add-int/lit8 v11, v11, 0x2

    goto :goto_3
.end method

.method public abstract r(Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FII)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Canvas;",
            "Landroid/graphics/Paint;",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;",
            "Lorg/achartengine/h/e;",
            "FII)V"
        }
    .end annotation
.end method

.method protected s(Lorg/achartengine/g/e;Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FILorg/achartengine/h/d$a;I)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/achartengine/g/e;",
            "Landroid/graphics/Canvas;",
            "Landroid/graphics/Paint;",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;",
            "Lorg/achartengine/h/e;",
            "FI",
            "Lorg/achartengine/h/d$a;",
            "I)V"
        }
    .end annotation

    move-object/from16 v8, p3

    invoke-virtual/range {p5 .. p5}, Lorg/achartengine/h/c;->c()Lorg/achartengine/h/a;

    move-result-object v9

    invoke-virtual/range {p3 .. p3}, Landroid/graphics/Paint;->getStrokeCap()Landroid/graphics/Paint$Cap;

    move-result-object v10

    invoke-virtual/range {p3 .. p3}, Landroid/graphics/Paint;->getStrokeJoin()Landroid/graphics/Paint$Join;

    move-result-object v11

    invoke-virtual/range {p3 .. p3}, Landroid/graphics/Paint;->getStrokeMiter()F

    move-result v12

    invoke-virtual/range {p3 .. p3}, Landroid/graphics/Paint;->getPathEffect()Landroid/graphics/PathEffect;

    move-result-object v13

    invoke-virtual/range {p3 .. p3}, Landroid/graphics/Paint;->getStyle()Landroid/graphics/Paint$Style;

    move-result-object v14

    if-nez v9, :cond_4

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move-object/from16 v4, p5

    move/from16 v5, p6

    move/from16 v6, p7

    move/from16 v7, p9

    invoke-virtual/range {v0 .. v7}, Lorg/achartengine/f/i;->r(Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FII)V

    move-object/from16 v15, p0

    move-object/from16 v7, p5

    invoke-virtual {v15, v7}, Lorg/achartengine/f/i;->G(Lorg/achartengine/h/c;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual/range {p0 .. p0}, Lorg/achartengine/f/i;->A()Lorg/achartengine/f/f;

    move-result-object v0

    if-eqz v0, :cond_0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move-object/from16 v4, p5

    move/from16 v5, p6

    move/from16 v6, p7

    move/from16 v7, p9

    invoke-virtual/range {v0 .. v7}, Lorg/achartengine/f/f;->r(Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FII)V

    :cond_0
    invoke-virtual/range {p5 .. p5}, Lorg/achartengine/h/e;->n()F

    move-result v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    sget-object v0, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    move-object/from16 v1, p8

    if-ne v1, v0, :cond_1

    sget-object v0, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    goto :goto_0

    :cond_1
    sget-object v0, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    :goto_0
    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    invoke-virtual/range {p5 .. p5}, Lorg/achartengine/h/e;->t()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual/range {p5 .. p5}, Lorg/achartengine/h/e;->m()Landroid/graphics/Paint$Align;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p1

    move-object/from16 v3, p5

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p7

    move/from16 v7, p9

    invoke-virtual/range {v0 .. v7}, Lorg/achartengine/f/i;->q(Landroid/graphics/Canvas;Lorg/achartengine/g/e;Lorg/achartengine/h/e;Landroid/graphics/Paint;Ljava/util/List;II)V

    :cond_2
    if-eqz v9, :cond_3

    move-object/from16 v0, p0

    move-object v1, v10

    move-object v2, v11

    move v3, v12

    move-object v4, v14

    move-object v5, v13

    move-object/from16 v6, p3

    invoke-direct/range {v0 .. v6}, Lorg/achartengine/f/i;->H(Landroid/graphics/Paint$Cap;Landroid/graphics/Paint$Join;FLandroid/graphics/Paint$Style;Landroid/graphics/PathEffect;Landroid/graphics/Paint;)V

    :cond_3
    return-void

    :cond_4
    move-object/from16 v15, p0

    invoke-virtual {v9}, Lorg/achartengine/h/a;->a()[F

    const/4 v0, 0x0

    throw v0
.end method

.method protected t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->j0()Lorg/achartengine/h/d$a;

    move-result-object v0

    invoke-virtual {v0}, Lorg/achartengine/h/d$a;->a()I

    move-result v0

    neg-int v0, v0

    int-to-float v0, v0

    add-float/2addr v0, p6

    const/4 p6, 0x0

    cmpl-float p6, v0, p6

    if-eqz p6, :cond_0

    invoke-virtual {p1, v0, p3, p4}, Landroid/graphics/Canvas;->rotate(FFF)V

    :cond_0
    invoke-virtual/range {p0 .. p5}, Lorg/achartengine/f/a;->h(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V

    if-eqz p6, :cond_1

    neg-float p2, v0

    invoke-virtual {p1, p2, p3, p4}, Landroid/graphics/Canvas;->rotate(FFF)V

    :cond_1
    return-void
.end method

.method protected u(Ljava/util/List;[Ljava/lang/Double;Landroid/graphics/Canvas;Landroid/graphics/Paint;IIIDDD)V
    .locals 22
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;[",
            "Ljava/lang/Double;",
            "Landroid/graphics/Canvas;",
            "Landroid/graphics/Paint;",
            "IIIDDD)V"
        }
    .end annotation

    move-object/from16 v14, p0

    move-object/from16 v7, p4

    move/from16 v8, p7

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v9

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->G()Z

    move-result v10

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->F()Z

    move-result v11

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->I()Z

    move-result v12

    const/4 v13, 0x0

    move v15, v13

    :goto_0
    if-lt v15, v9, :cond_0

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move v4, v10

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move-wide/from16 v8, p8

    move-wide/from16 v10, p10

    move-wide/from16 v12, p12

    invoke-virtual/range {v0 .. v13}, Lorg/achartengine/f/i;->v([Ljava/lang/Double;Landroid/graphics/Canvas;Landroid/graphics/Paint;ZIIIDDD)V

    return-void

    :cond_0
    move-object/from16 v6, p1

    invoke-interface {v6, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Double;

    invoke-virtual {v0}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v4

    move/from16 v3, p5

    int-to-double v0, v3

    sub-double v16, v4, p10

    mul-double v16, v16, p8

    add-double v0, v0, v16

    double-to-float v2, v0

    if-eqz v10, :cond_2

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->s0()I

    move-result v0

    invoke-virtual {v7, v0}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v16, 0x40400000    # 3.0f

    if-eqz v12, :cond_1

    int-to-float v1, v8

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->f()F

    move-result v0

    div-float v0, v0, v16

    add-float v17, v1, v0

    move-object/from16 v0, p3

    move/from16 v18, v1

    move v1, v2

    move/from16 v19, v2

    move/from16 v2, v18

    move/from16 v3, v19

    move-wide/from16 v20, v4

    move/from16 v4, v17

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_1

    :cond_1
    move/from16 v19, v2

    move-wide/from16 v20, v4

    :goto_1
    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->h0()Ljava/text/NumberFormat;

    move-result-object v0

    move-wide/from16 v1, v20

    invoke-virtual {v14, v0, v1, v2}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    int-to-float v0, v8

    iget-object v1, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->f()F

    move-result v1

    const/high16 v3, 0x40800000    # 4.0f

    mul-float/2addr v1, v3

    div-float v1, v1, v16

    add-float/2addr v0, v1

    iget-object v1, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->t0()F

    move-result v1

    add-float v4, v0, v1

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->r0()F

    move-result v16

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    move/from16 v3, v19

    move-object/from16 v5, p4

    move/from16 v6, v16

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    goto :goto_2

    :cond_2
    move/from16 v19, v2

    :goto_2
    if-eqz v11, :cond_3

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v13}, Lorg/achartengine/h/d;->f0(I)I

    move-result v0

    invoke-virtual {v7, v0}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v2, v8

    move/from16 v6, p6

    int-to-float v4, v6

    move-object/from16 v0, p3

    move/from16 v1, v19

    move/from16 v3, v19

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_3

    :cond_3
    move/from16 v6, p6

    :goto_3
    add-int/lit8 v15, v15, 0x1

    goto/16 :goto_0
.end method

.method protected v([Ljava/lang/Double;Landroid/graphics/Canvas;Landroid/graphics/Paint;ZIIIDDD)V
    .locals 19

    move-object/from16 v7, p0

    move-object/from16 v8, p1

    move-object/from16 v9, p3

    move/from16 v10, p7

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->C()Z

    move-result v11

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->I()Z

    move-result v12

    if-eqz p4, :cond_3

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->s0()I

    move-result v0

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setColor(I)V

    array-length v13, v8

    const/4 v14, 0x0

    move v15, v14

    :goto_0
    if-lt v15, v13, :cond_0

    goto/16 :goto_3

    :cond_0
    aget-object v6, v8, v15

    invoke-virtual {v6}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    cmpg-double v0, p10, v0

    if-gtz v0, :cond_2

    invoke-virtual {v6}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    cmpg-double v0, v0, p12

    if-gtz v0, :cond_2

    move/from16 v5, p5

    int-to-double v0, v5

    invoke-virtual {v6}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    sub-double v2, v2, p10

    mul-double v2, v2, p8

    add-double/2addr v0, v2

    double-to-float v4, v0

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->s0()I

    move-result v0

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v16, 0x40400000    # 3.0f

    if-eqz v12, :cond_1

    int-to-float v2, v10

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->f()F

    move-result v0

    div-float v0, v0, v16

    add-float v17, v2, v0

    move-object/from16 v0, p2

    move v1, v4

    move v3, v4

    move/from16 v18, v4

    move/from16 v4, v17

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_1

    :cond_1
    move/from16 v18, v4

    :goto_1
    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v6}, Lorg/achartengine/h/d;->u0(Ljava/lang/Double;)Ljava/lang/String;

    move-result-object v2

    int-to-float v6, v10

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->f()F

    move-result v0

    const/high16 v1, 0x40800000    # 4.0f

    mul-float/2addr v0, v1

    div-float v0, v0, v16

    add-float v4, v6, v0

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->r0()F

    move-result v16

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move/from16 v3, v18

    move-object/from16 v5, p3

    move/from16 v17, v6

    move/from16 v6, v16

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    if-eqz v11, :cond_2

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v14}, Lorg/achartengine/h/d;->f0(I)I

    move-result v0

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setColor(I)V

    move/from16 v6, p6

    int-to-float v4, v6

    move-object/from16 v0, p2

    move/from16 v1, v18

    move/from16 v2, v17

    move/from16 v3, v18

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_2

    :cond_2
    move/from16 v6, p6

    :goto_2
    add-int/lit8 v15, v15, 0x1

    goto/16 :goto_0

    :cond_3
    :goto_3
    return-void
.end method

.method protected w(Ljava/util/Map;Landroid/graphics/Canvas;Landroid/graphics/Paint;IIII[D[D)V
    .locals 22
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;>;",
            "Landroid/graphics/Canvas;",
            "Landroid/graphics/Paint;",
            "IIII[D[D)V"
        }
    .end annotation

    move-object/from16 v7, p0

    move-object/from16 v8, p3

    move/from16 v9, p5

    move/from16 v10, p6

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->j0()Lorg/achartengine/h/d$a;

    move-result-object v11

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->E()Z

    move-result v12

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->G()Z

    move-result v13

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->I()Z

    move-result v14

    move/from16 v6, p4

    const/4 v5, 0x0

    :goto_0
    if-lt v5, v6, :cond_0

    return-void

    :cond_0
    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v5}, Lorg/achartengine/h/d;->B0(I)Landroid/graphics/Paint$Align;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    move-object/from16 v4, p1

    invoke-interface {v4, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v3, v0

    check-cast v3, Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v2

    const/4 v1, 0x0

    :goto_1
    if-lt v1, v2, :cond_1

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Double;

    move-object/from16 v16, v3

    invoke-virtual {v0}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v3

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v5}, Lorg/achartengine/h/d;->x0(I)Landroid/graphics/Paint$Align;

    move-result-object v0

    iget-object v15, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    move/from16 v17, v1

    invoke-static {v3, v4}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    invoke-virtual {v15, v1, v5}, Lorg/achartengine/h/d;->G0(Ljava/lang/Double;I)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    const/4 v1, 0x1

    move/from16 v15, p7

    goto :goto_2

    :cond_2
    move/from16 v15, p7

    const/4 v1, 0x0

    :goto_2
    int-to-double v9, v15

    aget-wide v18, p8, v5

    aget-wide v20, p9, v5

    sub-double v20, v3, v20

    mul-double v18, v18, v20

    sub-double v9, v9, v18

    double-to-float v9, v9

    sget-object v10, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    if-ne v11, v10, :cond_8

    if-eqz v13, :cond_6

    if-nez v1, :cond_6

    iget-object v1, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v5}, Lorg/achartengine/h/d;->D0(I)I

    move-result v1

    invoke-virtual {v8, v1}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v1, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    if-ne v0, v1, :cond_4

    if-eqz v14, :cond_3

    invoke-direct {v7, v0}, Lorg/achartengine/f/i;->z(Landroid/graphics/Paint$Align;)I

    move-result v0

    move/from16 v10, p5

    add-int/2addr v0, v10

    int-to-float v1, v0

    int-to-float v0, v10

    move/from16 v18, v0

    move-object/from16 v0, p2

    move/from16 v19, v2

    move v2, v9

    move-object/from16 v20, v11

    move/from16 v21, v12

    move-wide v11, v3

    move/from16 v3, v18

    move v4, v9

    move v15, v5

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_3

    :cond_3
    move/from16 v10, p5

    move/from16 v19, v2

    move v15, v5

    move-object/from16 v20, v11

    move/from16 v21, v12

    move-wide v11, v3

    :goto_3
    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->h0()Ljava/text/NumberFormat;

    move-result-object v0

    invoke-virtual {v7, v0, v11, v12}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    int-to-float v0, v10

    iget-object v1, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->E0()F

    move-result v1

    sub-float v3, v0, v1

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->F0()F

    move-result v0

    sub-float v4, v9, v0

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->C0()F

    move-result v11

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v5, p3

    move v6, v11

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    goto :goto_4

    :cond_4
    move/from16 v10, p5

    move/from16 v19, v2

    move v15, v5

    move-object/from16 v20, v11

    move/from16 v21, v12

    move-wide v11, v3

    move/from16 v6, p6

    if-eqz v14, :cond_5

    int-to-float v1, v6

    invoke-direct {v7, v0}, Lorg/achartengine/f/i;->z(Landroid/graphics/Paint$Align;)I

    move-result v0

    add-int/2addr v0, v6

    int-to-float v3, v0

    move-object/from16 v0, p2

    move v2, v9

    move v4, v9

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    :cond_5
    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->h0()Ljava/text/NumberFormat;

    move-result-object v0

    invoke-virtual {v7, v0, v11, v12}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    int-to-float v0, v6

    iget-object v1, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->E0()F

    move-result v1

    add-float v3, v0, v1

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->F0()F

    move-result v0

    sub-float v4, v9, v0

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->C0()F

    move-result v11

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v5, p3

    move v12, v6

    move v6, v11

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    goto :goto_5

    :cond_6
    move/from16 v10, p5

    move/from16 v19, v2

    move v15, v5

    move-object/from16 v20, v11

    move/from16 v21, v12

    :goto_4
    move/from16 v12, p6

    :goto_5
    if-eqz v21, :cond_7

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v15}, Lorg/achartengine/h/d;->f0(I)I

    move-result v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v1, v10

    int-to-float v3, v12

    move-object/from16 v0, p2

    move v2, v9

    move v4, v9

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    :cond_7
    move-object/from16 v18, v20

    goto/16 :goto_8

    :cond_8
    move/from16 v10, p5

    move/from16 v6, p6

    move/from16 v19, v2

    move v15, v5

    move-object/from16 v20, v11

    move/from16 v21, v12

    move-wide v11, v3

    sget-object v2, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    move-object/from16 v5, v20

    if-ne v5, v2, :cond_b

    if-eqz v13, :cond_a

    if-nez v1, :cond_a

    iget-object v1, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1, v15}, Lorg/achartengine/h/d;->D0(I)I

    move-result v1

    invoke-virtual {v8, v1}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v14, :cond_9

    invoke-direct {v7, v0}, Lorg/achartengine/f/i;->z(Landroid/graphics/Paint$Align;)I

    move-result v0

    sub-int v0, v6, v0

    int-to-float v1, v0

    int-to-float v3, v6

    move-object/from16 v0, p2

    move v2, v9

    move v4, v9

    move-object/from16 v18, v5

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_6

    :cond_9
    move-object/from16 v18, v5

    :goto_6
    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->h0()Ljava/text/NumberFormat;

    move-result-object v0

    invoke-virtual {v7, v0, v11, v12}, Lorg/achartengine/f/a;->j(Ljava/text/NumberFormat;D)Ljava/lang/String;

    move-result-object v2

    add-int/lit8 v0, v6, 0xa

    int-to-float v0, v0

    iget-object v1, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->E0()F

    move-result v1

    add-float v3, v0, v1

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->F0()F

    move-result v0

    sub-float v4, v9, v0

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->C0()F

    move-result v11

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v5, p3

    move v12, v6

    move v6, v11

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    goto :goto_7

    :cond_a
    move-object/from16 v18, v5

    move v12, v6

    :goto_7
    if-eqz v21, :cond_c

    iget-object v0, v7, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v15}, Lorg/achartengine/h/d;->f0(I)I

    move-result v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v14, :cond_c

    int-to-float v1, v12

    int-to-float v3, v10

    move-object/from16 v0, p2

    move v2, v9

    move v4, v9

    move-object/from16 v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_8

    :cond_b
    move-object/from16 v18, v5

    move v12, v6

    :cond_c
    :goto_8
    add-int/lit8 v1, v17, 0x1

    move-object/from16 v4, p1

    move/from16 v6, p4

    move v9, v10

    move v10, v12

    move v5, v15

    move-object/from16 v3, v16

    move-object/from16 v11, v18

    move/from16 v2, v19

    move/from16 v12, v21

    goto/16 :goto_1
.end method

.method public x(I)[D
    .locals 1

    iget-object v0, p0, Lorg/achartengine/f/i;->h:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [D

    return-object p1
.end method

.method public y()Lorg/achartengine/g/d;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    return-object v0
.end method
