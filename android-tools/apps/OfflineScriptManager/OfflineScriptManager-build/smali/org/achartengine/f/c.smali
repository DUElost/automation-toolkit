.class public Lorg/achartengine/f/c;
.super Lorg/achartengine/f/i;
.source ""


# static fields
.field private static synthetic k:[I


# instance fields
.field private j:Lorg/achartengine/f/f;


# direct methods
.method public constructor <init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V
    .locals 1

    invoke-direct {p0, p1, p2}, Lorg/achartengine/f/i;-><init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    new-instance v0, Lorg/achartengine/f/f;

    invoke-direct {v0, p1, p2}, Lorg/achartengine/f/f;-><init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    iput-object v0, p0, Lorg/achartengine/f/c;->j:Lorg/achartengine/f/f;

    return-void
.end method

.method static synthetic K()[I
    .locals 3

    sget-object v0, Lorg/achartengine/f/c;->k:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Lorg/achartengine/h/e$a$a;->values()[Lorg/achartengine/h/e$a$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Lorg/achartengine/h/e$a$a;->g:Lorg/achartengine/h/e$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Lorg/achartengine/h/e$a$a;->f:Lorg/achartengine/h/e$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Lorg/achartengine/h/e$a$a;->e:Lorg/achartengine/h/e$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Lorg/achartengine/h/e$a$a;->c:Lorg/achartengine/h/e$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Lorg/achartengine/h/e$a$a;->d:Lorg/achartengine/h/e$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Lorg/achartengine/h/e$a$a;->b:Lorg/achartengine/h/e$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    sput-object v0, Lorg/achartengine/f/c;->k:[I

    return-object v0
.end method


# virtual methods
.method public A()Lorg/achartengine/f/f;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/f/c;->j:Lorg/achartengine/f/f;

    return-object v0
.end method

.method public G(Lorg/achartengine/h/c;)Z
    .locals 1

    check-cast p1, Lorg/achartengine/h/e;

    invoke-virtual {p1}, Lorg/achartengine/h/e;->s()Lorg/achartengine/f/d;

    move-result-object p1

    sget-object v0, Lorg/achartengine/f/d;->h:Lorg/achartengine/f/d;

    if-eq p1, v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public e(Landroid/graphics/Canvas;Lorg/achartengine/h/c;FFILandroid/graphics/Paint;)V
    .locals 8

    const/high16 v0, 0x41f00000    # 30.0f

    add-float v4, p3, v0

    move-object v1, p1

    move v2, p3

    move v3, p4

    move v5, p4

    move-object v6, p6

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    invoke-virtual {p0, p2}, Lorg/achartengine/f/c;->G(Lorg/achartengine/h/c;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lorg/achartengine/f/c;->j:Lorg/achartengine/f/f;

    const/high16 v0, 0x40a00000    # 5.0f

    add-float v4, p3, v0

    move-object v2, p1

    move-object v3, p2

    move v5, p4

    move v6, p5

    move-object v7, p6

    invoke-virtual/range {v1 .. v7}, Lorg/achartengine/f/f;->e(Landroid/graphics/Canvas;Lorg/achartengine/h/c;FFILandroid/graphics/Paint;)V

    :cond_0
    return-void
.end method

.method public k(I)I
    .locals 0

    const/16 p1, 0x1e

    return p1
.end method

.method protected p(Ljava/util/List;Ljava/util/List;FII)[Lorg/achartengine/f/b;
    .locals 17
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

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v2

    div-int/lit8 v3, v2, 0x2

    new-array v3, v3, [Lorg/achartengine/f/b;

    const/4 v4, 0x0

    :goto_0
    if-lt v4, v2, :cond_0

    return-object v3

    :cond_0
    move-object/from16 v5, p0

    iget-object v6, v5, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v6}, Lorg/achartengine/h/b;->l()I

    move-result v6

    div-int/lit8 v7, v4, 0x2

    new-instance v14, Lorg/achartengine/f/b;

    new-instance v9, Landroid/graphics/RectF;

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Float;

    invoke-virtual {v8}, Ljava/lang/Float;->floatValue()F

    move-result v8

    int-to-float v6, v6

    sub-float/2addr v8, v6

    add-int/lit8 v10, v4, 0x1

    invoke-interface {v0, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Float;

    invoke-virtual {v11}, Ljava/lang/Float;->floatValue()F

    move-result v11

    sub-float/2addr v11, v6

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Float;

    invoke-virtual {v12}, Ljava/lang/Float;->floatValue()F

    move-result v12

    add-float/2addr v12, v6

    invoke-interface {v0, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Float;

    invoke-virtual {v13}, Ljava/lang/Float;->floatValue()F

    move-result v13

    add-float/2addr v13, v6

    invoke-direct {v9, v8, v11, v12, v13}, Landroid/graphics/RectF;-><init>(FFFF)V

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Double;

    invoke-virtual {v6}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v11

    invoke-interface {v1, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Double;

    invoke-virtual {v6}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v15

    move-object v8, v14

    move-wide v10, v11

    move-wide v12, v15

    invoke-direct/range {v8 .. v13}, Lorg/achartengine/f/b;-><init>(Landroid/graphics/RectF;DD)V

    aput-object v14, v3, v7

    add-int/lit8 v4, v4, 0x2

    goto :goto_0
.end method

.method public r(Landroid/graphics/Canvas;Landroid/graphics/Paint;Ljava/util/List;Lorg/achartengine/h/e;FII)V
    .locals 21
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

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    invoke-virtual/range {p2 .. p2}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v4

    invoke-virtual/range {p4 .. p4}, Lorg/achartengine/h/e;->q()F

    move-result v5

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    invoke-virtual/range {p4 .. p4}, Lorg/achartengine/h/e;->p()[Lorg/achartengine/h/e$a;

    move-result-object v5

    array-length v6, v5

    const/4 v7, 0x0

    move v8, v7

    :goto_0
    if-lt v8, v6, :cond_0

    invoke-virtual/range {p4 .. p4}, Lorg/achartengine/h/c;->b()I

    move-result v5

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v5, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    invoke-virtual {v0, v1, v3, v2, v7}, Lorg/achartengine/f/a;->f(Landroid/graphics/Canvas;Ljava/util/List;Landroid/graphics/Paint;Z)V

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    return-void

    :cond_0
    aget-object v9, v5, v8

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v10

    sget-object v11, Lorg/achartengine/h/e$a$a;->b:Lorg/achartengine/h/e$a$a;

    if-eq v10, v11, :cond_16

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->a()I

    move-result v10

    invoke-virtual {v2, v10}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->b()[I

    move-result-object v11

    const/4 v12, 0x2

    const/4 v13, 0x1

    if-nez v11, :cond_1

    invoke-interface {v10, v3}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_1

    :cond_1
    aget v14, v11, v7

    mul-int/2addr v14, v12

    aget v11, v11, v13

    mul-int/2addr v11, v12

    invoke-interface {v3, v14, v11}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object v11

    invoke-interface {v10, v11}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :goto_1
    invoke-static {}, Lorg/achartengine/f/c;->K()[I

    move-result-object v11

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Enum;->ordinal()I

    move-result v14

    aget v11, v11, v14

    const/4 v15, 0x3

    if-eq v11, v12, :cond_4

    if-eq v11, v15, :cond_4

    const/4 v15, 0x4

    if-eq v11, v15, :cond_4

    const/4 v15, 0x5

    if-eq v11, v15, :cond_3

    const/4 v15, 0x6

    if-ne v11, v15, :cond_2

    const/4 v11, 0x0

    goto :goto_2

    :cond_2
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "You have added a new type of filling but have not implemented."

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_3
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->getHeight()I

    move-result v11

    int-to-float v11, v11

    goto :goto_2

    :cond_4
    move/from16 v11, p5

    :goto_2
    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v15

    sget-object v12, Lorg/achartengine/h/e$a$a;->e:Lorg/achartengine/h/e$a$a;

    if-eq v15, v12, :cond_5

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v15

    sget-object v14, Lorg/achartengine/h/e$a$a;->d:Lorg/achartengine/h/e$a$a;

    if-ne v15, v14, :cond_9

    :cond_5
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v15

    if-ne v15, v12, :cond_6

    invoke-interface {v10, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Float;

    invoke-virtual {v12}, Ljava/lang/Float;->floatValue()F

    move-result v12

    cmpg-float v12, v12, v11

    if-ltz v12, :cond_7

    :cond_6
    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v12

    sget-object v15, Lorg/achartengine/h/e$a$a;->d:Lorg/achartengine/h/e$a$a;

    if-ne v12, v15, :cond_8

    invoke-interface {v10, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Float;

    invoke-virtual {v12}, Ljava/lang/Float;->floatValue()F

    move-result v12

    cmpl-float v12, v12, v11

    if-lez v12, :cond_8

    :cond_7
    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Float;

    invoke-interface {v14, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v10, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Float;

    invoke-interface {v14, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move v12, v13

    goto :goto_3

    :cond_8
    move v12, v7

    :goto_3
    const/4 v15, 0x3

    :goto_4
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v13

    if-lt v15, v13, :cond_c

    invoke-interface {v10}, Ljava/util/List;->clear()V

    invoke-interface {v10, v14}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_9
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v13

    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Float;

    invoke-virtual {v9}, Ljava/lang/Float;->floatValue()F

    move-result v9

    const/high16 v12, 0x3f800000    # 1.0f

    add-float/2addr v9, v12

    invoke-static {v9}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v9

    invoke-interface {v10, v7, v9}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v9, v13, -0x2

    invoke-interface {v10, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Float;

    invoke-interface {v10, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {v11}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v9

    invoke-interface {v10, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Float;

    invoke-interface {v10, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v9, v13, 0x1

    invoke-interface {v10, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Float;

    invoke-interface {v10, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move v9, v7

    :goto_5
    add-int/lit8 v11, v13, 0x4

    if-lt v9, v11, :cond_a

    sget-object v9, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v9}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const/4 v11, 0x1

    invoke-virtual {v0, v1, v10, v2, v11}, Lorg/achartengine/f/a;->f(Landroid/graphics/Canvas;Ljava/util/List;Landroid/graphics/Paint;Z)V

    goto/16 :goto_8

    :cond_a
    const/4 v11, 0x1

    add-int/lit8 v12, v9, 0x1

    invoke-interface {v10, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/Float;

    invoke-virtual {v14}, Ljava/lang/Float;->floatValue()F

    move-result v14

    const/16 v16, 0x0

    cmpg-float v14, v14, v16

    if-gez v14, :cond_b

    invoke-static/range {v16 .. v16}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v14

    invoke-interface {v10, v12, v14}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    :cond_b
    add-int/lit8 v9, v9, 0x2

    goto :goto_5

    :cond_c
    const/16 v16, 0x0

    const/16 v17, 0x1

    add-int/lit8 v13, v15, -0x2

    invoke-interface {v10, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Float;

    invoke-virtual {v13}, Ljava/lang/Float;->floatValue()F

    move-result v13

    invoke-interface {v10, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v18

    check-cast v18, Ljava/lang/Float;

    invoke-virtual/range {v18 .. v18}, Ljava/lang/Float;->floatValue()F

    move-result v18

    cmpg-float v19, v13, v11

    if-gez v19, :cond_d

    cmpl-float v19, v18, v11

    if-gtz v19, :cond_e

    :cond_d
    cmpl-float v19, v13, v11

    if-lez v19, :cond_12

    cmpg-float v19, v18, v11

    if-gez v19, :cond_12

    :cond_e
    add-int/lit8 v12, v15, -0x3

    invoke-interface {v10, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Float;

    invoke-virtual {v12}, Ljava/lang/Float;->floatValue()F

    move-result v12

    add-int/lit8 v7, v15, -0x1

    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Float;

    invoke-virtual {v7}, Ljava/lang/Float;->floatValue()F

    move-result v7

    sub-float v19, v7, v12

    sub-float v20, v11, v13

    mul-float v19, v19, v20

    sub-float v13, v18, v13

    div-float v19, v19, v13

    add-float v12, v12, v19

    invoke-static {v12}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v12

    invoke-interface {v14, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {v11}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v12

    invoke-interface {v14, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v12

    sget-object v13, Lorg/achartengine/h/e$a$a;->e:Lorg/achartengine/h/e$a$a;

    if-ne v12, v13, :cond_f

    cmpl-float v12, v18, v11

    if-gtz v12, :cond_10

    :cond_f
    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v12

    sget-object v13, Lorg/achartengine/h/e$a$a;->d:Lorg/achartengine/h/e$a$a;

    if-ne v12, v13, :cond_11

    cmpg-float v12, v18, v11

    if-gez v12, :cond_11

    :cond_10
    add-int/lit8 v15, v15, 0x2

    const/4 v7, 0x2

    const/4 v12, 0x0

    goto :goto_7

    :cond_11
    invoke-static {v7}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    invoke-interface {v14, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static/range {v18 .. v18}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    invoke-interface {v14, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move/from16 v12, v17

    goto :goto_6

    :cond_12
    if-nez v12, :cond_14

    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v7

    sget-object v13, Lorg/achartengine/h/e$a$a;->e:Lorg/achartengine/h/e$a$a;

    if-ne v7, v13, :cond_13

    cmpg-float v7, v18, v11

    if-ltz v7, :cond_14

    :cond_13
    invoke-virtual {v9}, Lorg/achartengine/h/e$a;->c()Lorg/achartengine/h/e$a$a;

    move-result-object v7

    sget-object v13, Lorg/achartengine/h/e$a$a;->d:Lorg/achartengine/h/e$a$a;

    if-ne v7, v13, :cond_15

    cmpl-float v7, v18, v11

    if-lez v7, :cond_15

    :cond_14
    add-int/lit8 v7, v15, -0x1

    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Float;

    invoke-interface {v14, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static/range {v18 .. v18}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    invoke-interface {v14, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_15
    :goto_6
    const/4 v7, 0x2

    :goto_7
    add-int/2addr v15, v7

    const/4 v7, 0x0

    goto/16 :goto_4

    :cond_16
    :goto_8
    add-int/lit8 v8, v8, 0x1

    const/4 v7, 0x0

    goto/16 :goto_0
.end method
