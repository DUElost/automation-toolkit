.class public Lorg/achartengine/f/h;
.super Lorg/achartengine/f/c;
.source ""


# instance fields
.field private l:Ljava/lang/String;

.field private m:Ljava/lang/Double;


# direct methods
.method public constructor <init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lorg/achartengine/f/c;-><init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    return-void
.end method

.method private L(DD)Ljava/text/DateFormat;
    .locals 4

    iget-object v0, p0, Lorg/achartengine/f/h;->l:Ljava/lang/String;

    if-eqz v0, :cond_0

    :try_start_0
    new-instance v0, Ljava/text/SimpleDateFormat;

    iget-object v1, p0, Lorg/achartengine/f/h;->l:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    const/4 v0, 0x2

    invoke-static {v0}, Ljava/text/SimpleDateFormat;->getDateInstance(I)Ljava/text/DateFormat;

    move-result-object v1

    sub-double/2addr p3, p1

    const-wide p1, 0x4194997000000000L    # 8.64E7

    cmpl-double v2, p3, p1

    if-lez v2, :cond_1

    const-wide v2, 0x41b9bfcc00000000L    # 4.32E8

    cmpg-double v2, p3, v2

    if-gez v2, :cond_1

    const/4 p1, 0x3

    invoke-static {p1, p1}, Ljava/text/SimpleDateFormat;->getDateTimeInstance(II)Ljava/text/DateFormat;

    move-result-object v1

    goto :goto_0

    :cond_1
    cmpg-double p1, p3, p1

    if-gez p1, :cond_2

    invoke-static {v0}, Ljava/text/SimpleDateFormat;->getTimeInstance(I)Ljava/text/DateFormat;

    move-result-object v1

    :cond_2
    :goto_0
    return-object v1
.end method


# virtual methods
.method protected D(DDI)Ljava/util/List;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(DDI)",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;"
        }
    .end annotation

    move-object v0, p0

    move/from16 v1, p5

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iget-object v3, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v3}, Lorg/achartengine/h/d;->X0()Z

    move-result v3

    const/4 v4, 0x0

    if-nez v3, :cond_8

    iget-object v3, v0, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v3}, Lorg/achartengine/g/d;->d()I

    move-result v3

    if-lez v3, :cond_7

    iget-object v3, v0, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v3, v4}, Lorg/achartengine/g/d;->c(I)Lorg/achartengine/g/e;

    move-result-object v3

    invoke-virtual {v3}, Lorg/achartengine/g/e;->h()I

    move-result v5

    const/4 v6, -0x1

    move v7, v4

    move v8, v7

    :goto_0
    if-lt v7, v5, :cond_5

    if-ge v8, v1, :cond_1

    move v1, v6

    :goto_1
    add-int v4, v6, v8

    if-lt v1, v4, :cond_0

    goto :goto_3

    :cond_0
    invoke-virtual {v3, v1}, Lorg/achartengine/g/e;->q(I)D

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    int-to-float v6, v8

    int-to-float v7, v1

    div-float/2addr v6, v7

    move v7, v4

    :goto_2
    if-ge v4, v5, :cond_4

    if-lt v7, v1, :cond_2

    goto :goto_3

    :cond_2
    int-to-float v8, v4

    mul-float/2addr v8, v6

    invoke-static {v8}, Ljava/lang/Math;->round(F)I

    move-result v8

    invoke-virtual {v3, v8}, Lorg/achartengine/g/e;->q(I)D

    move-result-wide v8

    cmpg-double v10, p1, v8

    if-gtz v10, :cond_3

    cmpg-double v10, v8, p3

    if-gtz v10, :cond_3

    invoke-static {v8, v9}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v8

    invoke-interface {v2, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v7, v7, 0x1

    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_4
    :goto_3
    return-object v2

    :cond_5
    invoke-virtual {v3, v7}, Lorg/achartengine/g/e;->q(I)D

    move-result-wide v9

    cmpg-double v11, p1, v9

    if-gtz v11, :cond_6

    cmpg-double v9, v9, p3

    if-gtz v9, :cond_6

    add-int/lit8 v8, v8, 0x1

    if-gez v6, :cond_6

    move v6, v7

    :cond_6
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_7
    invoke-super/range {p0 .. p5}, Lorg/achartengine/f/i;->D(DDI)Ljava/util/List;

    move-result-object v1

    return-object v1

    :cond_8
    iget-object v3, v0, Lorg/achartengine/f/h;->m:Ljava/lang/Double;

    const-wide v5, 0x4194997000000000L    # 8.64E7

    if-nez v3, :cond_9

    rem-double v7, p1, v5

    sub-double v7, p1, v7

    add-double/2addr v7, v5

    new-instance v3, Ljava/util/Date;

    invoke-static {p1, p2}, Ljava/lang/Math;->round(D)J

    move-result-wide v9

    invoke-direct {v3, v9, v10}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v3}, Ljava/util/Date;->getTimezoneOffset()I

    move-result v3

    mul-int/lit8 v3, v3, 0x3c

    mul-int/lit16 v3, v3, 0x3e8

    int-to-double v9, v3

    add-double/2addr v7, v9

    invoke-static {v7, v8}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v3

    iput-object v3, v0, Lorg/achartengine/f/h;->m:Ljava/lang/Double;

    :cond_9
    const/16 v3, 0x19

    if-le v1, v3, :cond_a

    move v1, v3

    :cond_a
    sub-double v7, p3, p1

    int-to-double v9, v1

    div-double/2addr v7, v9

    const-wide/16 v9, 0x0

    cmpg-double v3, v7, v9

    if-gtz v3, :cond_b

    return-object v2

    :cond_b
    cmpg-double v3, v7, v5

    const-wide/high16 v9, 0x4000000000000000L    # 2.0

    if-gtz v3, :cond_d

    :goto_4
    div-double v11, v5, v9

    cmpg-double v3, v7, v11

    if-ltz v3, :cond_c

    goto :goto_6

    :cond_c
    move-wide v5, v11

    goto :goto_4

    :cond_d
    :goto_5
    cmpl-double v3, v7, v5

    if-gtz v3, :cond_10

    :goto_6
    iget-object v3, v0, Lorg/achartengine/f/h;->m:Ljava/lang/Double;

    invoke-virtual {v3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v7

    iget-object v3, v0, Lorg/achartengine/f/h;->m:Ljava/lang/Double;

    invoke-virtual {v3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v9

    sub-double/2addr v9, p1

    div-double/2addr v9, v5

    invoke-static {v9, v10}, Ljava/lang/Math;->floor(D)D

    move-result-wide v9

    mul-double/2addr v9, v5

    sub-double/2addr v7, v9

    :goto_7
    cmpg-double v3, v7, p3

    if-gez v3, :cond_f

    add-int/lit8 v3, v4, 0x1

    if-le v4, v1, :cond_e

    goto :goto_8

    :cond_e
    invoke-static {v7, v8}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-double/2addr v7, v5

    move v4, v3

    goto :goto_7

    :cond_f
    :goto_8
    return-object v2

    :cond_10
    mul-double/2addr v5, v9

    goto :goto_5
.end method

.method public M(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/f/h;->l:Ljava/lang/String;

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

    move-object/from16 v7, p1

    move-object/from16 v8, p4

    move/from16 v9, p7

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v10

    if-lez v10, :cond_4

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->G()Z

    move-result v11

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->F()Z

    move-result v12

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->I()Z

    move-result v13

    const/4 v15, 0x0

    invoke-interface {v7, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Double;

    invoke-virtual {v0}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    add-int/lit8 v2, v10, -0x1

    invoke-interface {v7, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Double;

    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    invoke-direct {v14, v0, v1, v2, v3}, Lorg/achartengine/f/h;->L(DD)Ljava/text/DateFormat;

    move-result-object v6

    move v5, v15

    :goto_0
    if-lt v5, v10, :cond_0

    goto/16 :goto_4

    :cond_0
    invoke-interface {v7, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Double;

    invoke-virtual {v0}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v3

    move/from16 v2, p5

    int-to-double v0, v2

    move/from16 v17, v5

    move-object/from16 v16, v6

    long-to-double v5, v3

    sub-double v5, v5, p10

    mul-double v5, v5, p8

    add-double/2addr v0, v5

    double-to-float v6, v0

    if-eqz v11, :cond_2

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->s0()I

    move-result v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v18, 0x40400000    # 3.0f

    if-eqz v13, :cond_1

    int-to-float v5, v9

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->f()F

    move-result v0

    div-float v0, v0, v18

    add-float v19, v5, v0

    move-object/from16 v0, p3

    move v1, v6

    move v2, v5

    move-wide v4, v3

    move v3, v6

    move/from16 v20, v10

    move/from16 v21, v11

    move-wide v10, v4

    move/from16 v4, v19

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_1

    :cond_1
    move/from16 v20, v10

    move/from16 v21, v11

    move-wide v10, v3

    :goto_1
    new-instance v0, Ljava/util/Date;

    invoke-direct {v0, v10, v11}, Ljava/util/Date;-><init>(J)V

    move-object/from16 v10, v16

    invoke-virtual {v10, v0}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    int-to-float v0, v9

    iget-object v1, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->f()F

    move-result v1

    const/high16 v3, 0x40800000    # 4.0f

    mul-float/2addr v1, v3

    div-float v1, v1, v18

    add-float/2addr v0, v1

    iget-object v1, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->t0()F

    move-result v1

    add-float v4, v0, v1

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->r0()F

    move-result v11

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    move v3, v6

    move-object/from16 v5, p4

    move/from16 v16, v6

    move v6, v11

    invoke-virtual/range {v0 .. v6}, Lorg/achartengine/f/i;->t(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;F)V

    goto :goto_2

    :cond_2
    move/from16 v20, v10

    move/from16 v21, v11

    move-object/from16 v10, v16

    move/from16 v16, v6

    :goto_2
    if-eqz v12, :cond_3

    iget-object v0, v14, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v0, v15}, Lorg/achartengine/h/d;->f0(I)I

    move-result v0

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v2, v9

    move/from16 v6, p6

    int-to-float v4, v6

    move-object/from16 v0, p3

    move/from16 v1, v16

    move/from16 v3, v16

    move-object/from16 v5, p4

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    goto :goto_3

    :cond_3
    move/from16 v6, p6

    :goto_3
    add-int/lit8 v5, v17, 0x1

    move-object v6, v10

    move/from16 v10, v20

    move/from16 v11, v21

    goto/16 :goto_0

    :cond_4
    :goto_4
    move/from16 v6, p6

    const/4 v4, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move-wide/from16 v8, p8

    move-wide/from16 v10, p10

    move-wide/from16 v12, p12

    invoke-virtual/range {v0 .. v13}, Lorg/achartengine/f/i;->v([Ljava/lang/Double;Landroid/graphics/Canvas;Landroid/graphics/Paint;ZIIIDDD)V

    return-void
.end method
