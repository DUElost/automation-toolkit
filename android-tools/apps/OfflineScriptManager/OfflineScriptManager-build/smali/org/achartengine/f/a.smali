.class public abstract Lorg/achartengine/f/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Serializable;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(FFFFII)[F
    .locals 6

    int-to-float p4, p4

    cmpl-float v0, p1, p4

    const/4 v1, 0x0

    if-lez v0, :cond_2

    sub-float v0, p3, p1

    sub-float v2, p2, p0

    div-float/2addr v0, v2

    sub-float v2, p4, p1

    mul-float v3, v0, p0

    add-float/2addr v2, v3

    div-float/2addr v2, v0

    cmpg-float v4, v2, v1

    if-gez v4, :cond_0

    :goto_0
    sub-float v0, p1, v3

    move v2, v1

    goto :goto_2

    :cond_0
    int-to-float v4, p5

    cmpl-float v5, v2, v4

    if-lez v5, :cond_1

    :goto_1
    mul-float/2addr v0, v4

    add-float/2addr v0, p1

    sub-float/2addr v0, v3

    move v2, v4

    goto :goto_2

    :cond_1
    move v0, p4

    goto :goto_2

    :cond_2
    cmpg-float v0, p1, v1

    if-gez v0, :cond_5

    sub-float v0, p3, p1

    sub-float v2, p2, p0

    div-float/2addr v0, v2

    neg-float v2, p1

    mul-float v3, v0, p0

    add-float/2addr v2, v3

    div-float/2addr v2, v0

    cmpg-float v4, v2, v1

    if-gez v4, :cond_3

    goto :goto_0

    :cond_3
    int-to-float v4, p5

    cmpl-float v5, v2, v4

    if-lez v5, :cond_4

    goto :goto_1

    :cond_4
    move v0, v1

    goto :goto_2

    :cond_5
    move v2, p0

    move v0, p1

    :goto_2
    cmpl-float v3, p3, p4

    if-lez v3, :cond_8

    sub-float/2addr p3, p1

    sub-float/2addr p2, p0

    div-float/2addr p3, p2

    sub-float p2, p4, p1

    mul-float/2addr p0, p3

    add-float/2addr p2, p0

    div-float/2addr p2, p3

    cmpg-float v3, p2, v1

    if-gez v3, :cond_6

    :goto_3
    sub-float p3, p1, p0

    move p2, v1

    goto :goto_4

    :cond_6
    int-to-float p5, p5

    cmpl-float v1, p2, p5

    if-lez v1, :cond_7

    mul-float/2addr p3, p5

    add-float/2addr p3, p1

    sub-float/2addr p3, p0

    move p2, p5

    goto :goto_4

    :cond_7
    move p3, p4

    goto :goto_4

    :cond_8
    cmpg-float p4, p3, v1

    if-gez p4, :cond_b

    sub-float/2addr p3, p1

    sub-float/2addr p2, p0

    div-float/2addr p3, p2

    neg-float p2, p1

    mul-float/2addr p0, p3

    add-float/2addr p2, p0

    div-float/2addr p2, p3

    cmpg-float p4, p2, v1

    if-gez p4, :cond_9

    goto :goto_3

    :cond_9
    int-to-float p4, p5

    cmpl-float p5, p2, p4

    if-lez p5, :cond_a

    mul-float/2addr p3, p4

    add-float/2addr p3, p1

    sub-float/2addr p3, p0

    move p2, p4

    goto :goto_4

    :cond_a
    move p3, v1

    :cond_b
    :goto_4
    const/4 p0, 0x4

    new-array p0, p0, [F

    const/4 p1, 0x0

    aput v2, p0, p1

    const/4 p1, 0x1

    aput v0, p0, p1

    const/4 p1, 0x2

    aput p2, p0, p1

    const/4 p1, 0x3

    aput p3, p0, p1

    return-object p0
.end method


# virtual methods
.method public abstract b(Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;)V
.end method

.method protected c(Lorg/achartengine/h/b;Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;ZI)V
    .locals 6

    invoke-virtual {p1}, Lorg/achartengine/h/b;->v()Z

    move-result v0

    if-nez v0, :cond_0

    if-eqz p8, :cond_2

    :cond_0
    if-eqz p8, :cond_1

    invoke-virtual {p7, p9}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lorg/achartengine/h/b;->b()I

    move-result p1

    invoke-virtual {p7, p1}, Landroid/graphics/Paint;->setColor(I)V

    :goto_0
    sget-object p1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p7, p1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    int-to-float v1, p3

    int-to-float v2, p4

    add-int/2addr p3, p5

    int-to-float v3, p3

    add-int/2addr p4, p6

    int-to-float v4, p4

    move-object v0, p2

    move-object v5, p7

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    :cond_2
    return-void
.end method

.method protected d(Landroid/graphics/Canvas;Lorg/achartengine/h/b;[Ljava/lang/String;IIIIIILandroid/graphics/Paint;Z)I
    .locals 22

    move-object/from16 v7, p0

    move-object/from16 v8, p2

    move-object/from16 v9, p3

    move/from16 v10, p5

    move/from16 v11, p7

    move-object/from16 v12, p10

    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->H()Z

    move-result v0

    const/high16 v1, 0x42000000    # 32.0f

    if-eqz v0, :cond_8

    move/from16 v0, p4

    int-to-float v13, v0

    add-int v0, p6, p8

    sub-int v0, v0, p9

    int-to-float v0, v0

    add-float/2addr v0, v1

    sget-object v2, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    invoke-virtual {v12, v2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->h()F

    move-result v2

    invoke-virtual {v12, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    array-length v2, v9

    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->n()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v14

    move v2, v13

    const/4 v6, 0x0

    :goto_0
    if-lt v6, v14, :cond_0

    goto/16 :goto_7

    :cond_0
    invoke-virtual {v8, v6}, Lorg/achartengine/h/b;->m(I)Lorg/achartengine/h/c;

    move-result-object v3

    invoke-virtual {v7, v6}, Lorg/achartengine/f/a;->k(I)I

    move-result v4

    int-to-float v5, v4

    invoke-virtual {v3}, Lorg/achartengine/h/c;->e()Z

    move-result v4

    if-eqz v4, :cond_7

    aget-object v4, v9, v6

    array-length v15, v9

    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->n()I

    move-result v9

    if-ne v15, v9, :cond_1

    invoke-virtual {v3}, Lorg/achartengine/h/c;->b()I

    move-result v9

    goto :goto_1

    :cond_1
    const v9, -0x333334

    :goto_1
    invoke-virtual {v12, v9}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    new-array v15, v9, [F

    invoke-virtual {v12, v4, v15}, Landroid/graphics/Paint;->getTextWidths(Ljava/lang/String;[F)I

    const/16 v16, 0x0

    move/from16 p6, v14

    const/4 v14, 0x0

    :goto_2
    if-lt v14, v9, :cond_6

    const/high16 v9, 0x41200000    # 10.0f

    add-float v14, v5, v9

    add-float v14, v14, v16

    add-float v9, v2, v14

    if-lez v6, :cond_2

    invoke-virtual {v7, v9, v8, v10, v11}, Lorg/achartengine/f/a;->i(FLorg/achartengine/h/b;II)Z

    move-result v16

    if-eqz v16, :cond_2

    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->h()F

    move-result v2

    add-float/2addr v0, v2

    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->h()F

    move-result v2

    add-float/2addr v1, v2

    add-float v9, v13, v14

    move/from16 v16, v1

    move/from16 v17, v13

    goto :goto_3

    :cond_2
    move/from16 v16, v1

    move/from16 v17, v2

    :goto_3
    move/from16 v21, v9

    move v9, v0

    move/from16 v0, v21

    invoke-virtual {v7, v0, v8, v10, v11}, Lorg/achartengine/f/a;->i(FLorg/achartengine/h/b;II)Z

    move-result v0

    if-eqz v0, :cond_4

    int-to-float v0, v10

    sub-float v0, v0, v17

    sub-float/2addr v0, v5

    const/high16 v1, 0x41200000    # 10.0f

    sub-float/2addr v0, v1

    invoke-virtual {v7, v8}, Lorg/achartengine/f/a;->o(Lorg/achartengine/h/b;)Z

    move-result v2

    if-eqz v2, :cond_3

    int-to-float v0, v11

    sub-float v0, v0, v17

    sub-float/2addr v0, v5

    sub-float/2addr v0, v1

    :cond_3
    const/4 v1, 0x1

    invoke-virtual {v12, v4, v1, v0, v15}, Landroid/graphics/Paint;->breakText(Ljava/lang/String;ZF[F)I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    const/4 v15, 0x0

    invoke-virtual {v4, v15, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "..."

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object/from16 v18, v0

    goto :goto_4

    :cond_4
    const/4 v15, 0x0

    move-object/from16 v18, v4

    :goto_4
    if-nez p11, :cond_5

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v2, v3

    move/from16 v3, v17

    move v4, v9

    move/from16 v19, v5

    move v5, v6

    move/from16 v20, v6

    move-object/from16 v6, p10

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/a;->e(Landroid/graphics/Canvas;Lorg/achartengine/h/c;FFILandroid/graphics/Paint;)V

    add-float v5, v17, v19

    const/high16 v0, 0x40a00000    # 5.0f

    add-float v3, v5, v0

    add-float v4, v9, v0

    move-object/from16 v0, p0

    move-object/from16 v2, v18

    move-object/from16 v5, p10

    invoke-virtual/range {v0 .. v5}, Lorg/achartengine/f/a;->h(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto :goto_5

    :cond_5
    move/from16 v20, v6

    :goto_5
    add-float v2, v17, v14

    move v0, v9

    move v5, v15

    move/from16 v1, v16

    goto :goto_6

    :cond_6
    move/from16 v19, v5

    move/from16 v20, v6

    const/4 v5, 0x0

    aget v6, v15, v14

    add-float v16, v16, v6

    add-int/lit8 v14, v14, 0x1

    move/from16 v5, v19

    move/from16 v6, v20

    goto/16 :goto_2

    :cond_7
    move/from16 v20, v6

    move/from16 p6, v14

    const/4 v5, 0x0

    :goto_6
    add-int/lit8 v6, v20, 0x1

    move-object/from16 v9, p3

    move/from16 v14, p6

    goto/16 :goto_0

    :cond_8
    :goto_7
    invoke-virtual/range {p2 .. p2}, Lorg/achartengine/h/b;->h()F

    move-result v0

    add-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method public abstract e(Landroid/graphics/Canvas;Lorg/achartengine/h/c;FFILandroid/graphics/Paint;)V
.end method

.method protected f(Landroid/graphics/Canvas;Ljava/util/List;Landroid/graphics/Paint;Z)V
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Canvas;",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;",
            "Landroid/graphics/Paint;",
            "Z)V"
        }
    .end annotation

    move-object/from16 v0, p2

    new-instance v1, Landroid/graphics/Path;

    invoke-direct {v1}, Landroid/graphics/Path;-><init>()V

    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->getHeight()I

    move-result v8

    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->getWidth()I

    move-result v9

    invoke-interface/range {p2 .. p2}, Ljava/util/List;->size()I

    move-result v2

    const/4 v10, 0x4

    if-ge v2, v10, :cond_0

    return-void

    :cond_0
    const/4 v11, 0x0

    invoke-interface {v0, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    const/4 v12, 0x1

    invoke-interface {v0, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    const/4 v13, 0x2

    invoke-interface {v0, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Float;

    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v4

    const/4 v14, 0x3

    invoke-interface {v0, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Float;

    invoke-virtual {v5}, Ljava/lang/Float;->floatValue()F

    move-result v5

    move v6, v8

    move v7, v9

    invoke-static/range {v2 .. v7}, Lorg/achartengine/f/a;->a(FFFFII)[F

    move-result-object v2

    aget v3, v2, v11

    aget v4, v2, v12

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    aget v3, v2, v13

    aget v2, v2, v14

    invoke-virtual {v1, v3, v2}, Landroid/graphics/Path;->lineTo(FF)V

    invoke-interface/range {p2 .. p2}, Ljava/util/List;->size()I

    move-result v15

    :goto_0
    if-lt v10, v15, :cond_2

    if-eqz p4, :cond_1

    invoke-interface {v0, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-interface {v0, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-virtual {v1, v2, v0}, Landroid/graphics/Path;->lineTo(FF)V

    :cond_1
    move-object/from16 v7, p1

    move-object/from16 v6, p3

    invoke-virtual {v7, v1, v6}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    return-void

    :cond_2
    move-object/from16 v7, p1

    move-object/from16 v6, p3

    add-int/lit8 v2, v10, -0x1

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    const/4 v4, 0x0

    cmpg-float v3, v3, v4

    if-gez v3, :cond_3

    add-int/lit8 v3, v10, 0x1

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    cmpg-float v3, v3, v4

    if-ltz v3, :cond_6

    :cond_3
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    int-to-float v4, v8

    cmpl-float v3, v3, v4

    if-lez v3, :cond_4

    add-int/lit8 v3, v10, 0x1

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    cmpl-float v3, v3, v4

    if-lez v3, :cond_4

    goto :goto_1

    :cond_4
    add-int/lit8 v3, v10, -0x2

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v4

    invoke-interface {v0, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v5

    add-int/lit8 v2, v10, 0x1

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v16

    move v2, v3

    move v3, v4

    move v4, v5

    move/from16 v5, v16

    move v6, v8

    move v7, v9

    invoke-static/range {v2 .. v7}, Lorg/achartengine/f/a;->a(FFFFII)[F

    move-result-object v2

    if-nez p4, :cond_5

    aget v3, v2, v11

    aget v4, v2, v12

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    :cond_5
    aget v3, v2, v13

    aget v2, v2, v14

    invoke-virtual {v1, v3, v2}, Landroid/graphics/Path;->lineTo(FF)V

    :cond_6
    :goto_1
    add-int/lit8 v10, v10, 0x2

    goto/16 :goto_0
.end method

.method protected g(Landroid/graphics/Canvas;[FLandroid/graphics/Paint;Z)V
    .locals 17

    move-object/from16 v0, p2

    new-instance v1, Landroid/graphics/Path;

    invoke-direct {v1}, Landroid/graphics/Path;-><init>()V

    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->getHeight()I

    move-result v8

    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->getWidth()I

    move-result v9

    array-length v2, v0

    const/4 v10, 0x4

    if-ge v2, v10, :cond_0

    return-void

    :cond_0
    const/4 v11, 0x0

    aget v2, v0, v11

    const/4 v12, 0x1

    aget v3, v0, v12

    const/4 v13, 0x2

    aget v4, v0, v13

    const/4 v14, 0x3

    aget v5, v0, v14

    move v6, v8

    move v7, v9

    invoke-static/range {v2 .. v7}, Lorg/achartengine/f/a;->a(FFFFII)[F

    move-result-object v2

    aget v3, v2, v11

    aget v4, v2, v12

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    aget v3, v2, v13

    aget v2, v2, v14

    invoke-virtual {v1, v3, v2}, Landroid/graphics/Path;->lineTo(FF)V

    array-length v15, v0

    :goto_0
    if-lt v10, v15, :cond_2

    if-eqz p4, :cond_1

    aget v2, v0, v11

    aget v0, v0, v12

    invoke-virtual {v1, v2, v0}, Landroid/graphics/Path;->lineTo(FF)V

    :cond_1
    move-object/from16 v7, p1

    move-object/from16 v6, p3

    invoke-virtual {v7, v1, v6}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    return-void

    :cond_2
    move-object/from16 v7, p1

    move-object/from16 v6, p3

    add-int/lit8 v2, v10, -0x1

    aget v3, v0, v2

    const/4 v4, 0x0

    cmpg-float v3, v3, v4

    if-gez v3, :cond_3

    add-int/lit8 v3, v10, 0x1

    aget v3, v0, v3

    cmpg-float v3, v3, v4

    if-ltz v3, :cond_6

    :cond_3
    aget v3, v0, v2

    int-to-float v4, v8

    cmpl-float v3, v3, v4

    if-lez v3, :cond_4

    add-int/lit8 v3, v10, 0x1

    aget v3, v0, v3

    cmpl-float v3, v3, v4

    if-lez v3, :cond_4

    goto :goto_1

    :cond_4
    add-int/lit8 v3, v10, -0x2

    aget v3, v0, v3

    aget v4, v0, v2

    aget v5, v0, v10

    add-int/lit8 v2, v10, 0x1

    aget v16, v0, v2

    move v2, v3

    move v3, v4

    move v4, v5

    move/from16 v5, v16

    move v6, v8

    move v7, v9

    invoke-static/range {v2 .. v7}, Lorg/achartengine/f/a;->a(FFFFII)[F

    move-result-object v2

    if-nez p4, :cond_5

    aget v3, v2, v11

    aget v4, v2, v12

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    :cond_5
    aget v3, v2, v13

    aget v2, v2, v14

    invoke-virtual {v1, v3, v2}, Landroid/graphics/Path;->lineTo(FF)V

    :cond_6
    :goto_1
    add-int/lit8 v10, v10, 0x2

    goto :goto_0
.end method

.method protected h(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V
    .locals 6

    if-eqz p2, :cond_1

    const-string v0, "\n"

    invoke-virtual {p2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p2

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    const/4 v1, 0x0

    move v2, v1

    move v3, v2

    :goto_0
    array-length v4, p2

    if-lt v2, v4, :cond_0

    goto :goto_1

    :cond_0
    aget-object v4, p2, v2

    int-to-float v5, v3

    add-float/2addr v5, p4

    invoke-virtual {p1, v4, p3, v5, p5}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    aget-object v4, p2, v2

    aget-object v5, p2, v2

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {p5, v4, v1, v5, v0}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v4

    add-int/2addr v3, v4

    add-int/lit8 v3, v3, 0x5

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method protected i(FLorg/achartengine/h/b;II)Z
    .locals 2

    int-to-float p3, p3

    cmpl-float p3, p1, p3

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-lez p3, :cond_0

    move p3, v0

    goto :goto_0

    :cond_0
    move p3, v1

    :goto_0
    invoke-virtual {p0, p2}, Lorg/achartengine/f/a;->o(Lorg/achartengine/h/b;)Z

    move-result p2

    if-eqz p2, :cond_2

    int-to-float p2, p4

    cmpl-float p1, p1, p2

    if-lez p1, :cond_1

    goto :goto_1

    :cond_1
    move v0, v1

    :goto_1
    move p3, v0

    :cond_2
    return p3
.end method

.method protected j(Ljava/text/NumberFormat;D)Ljava/lang/String;
    .locals 2

    if-eqz p1, :cond_0

    invoke-virtual {p1, p2, p3}, Ljava/text/NumberFormat;->format(D)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_0
    invoke-static {p2, p3}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-double v0, v0

    cmpl-double p1, p2, v0

    if-nez p1, :cond_1

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-static {p2, p3}, Ljava/lang/Math;->round(D)J

    move-result-wide p2

    invoke-static {p2, p3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-static {p2, p3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_1
    return-object p1
.end method

.method public abstract k(I)I
.end method

.method protected l(Lorg/achartengine/h/b;IF)I
    .locals 2

    invoke-virtual {p1}, Lorg/achartengine/h/b;->g()I

    move-result v0

    invoke-virtual {p1}, Lorg/achartengine/h/b;->H()Z

    move-result v1

    if-eqz v1, :cond_0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    move p2, v0

    :goto_0
    invoke-virtual {p1}, Lorg/achartengine/h/b;->H()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lorg/achartengine/h/b;->G()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lorg/achartengine/h/b;->f()F

    move-result p1

    const/high16 p2, 0x40800000    # 4.0f

    mul-float/2addr p1, p2

    const/high16 p2, 0x40400000    # 3.0f

    div-float/2addr p1, p2

    add-float/2addr p1, p3

    float-to-int p2, p1

    :cond_1
    return p2
.end method

.method public m(Lorg/achartengine/g/a;)Lorg/achartengine/g/b;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public n(D)Z
    .locals 2

    invoke-static {p1, p2}, Ljava/lang/Double;->isNaN(D)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1, p2}, Ljava/lang/Double;->isInfinite(D)Z

    move-result v0

    if-nez v0, :cond_0

    const-wide v0, 0x7fefffffffffffffL    # Double.MAX_VALUE

    cmpl-double p1, p1, v0

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method public o(Lorg/achartengine/h/b;)Z
    .locals 1

    instance-of v0, p1, Lorg/achartengine/h/d;

    if-eqz v0, :cond_0

    check-cast p1, Lorg/achartengine/h/d;

    invoke-virtual {p1}, Lorg/achartengine/h/d;->j0()Lorg/achartengine/h/d$a;

    move-result-object p1

    sget-object v0, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    if-ne p1, v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
