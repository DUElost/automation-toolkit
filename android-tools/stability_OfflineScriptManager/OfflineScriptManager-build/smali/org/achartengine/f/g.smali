.class public Lorg/achartengine/f/g;
.super Lorg/achartengine/f/c;
.source ""


# instance fields
.field private l:Ljava/lang/String;

.field private m:Ljava/lang/Double;

.field private n:F

.field private o:F

.field private p:Lorg/achartengine/g/a;

.field private q:Lorg/achartengine/g/a;

.field private r:Lorg/achartengine/g/a;


# direct methods
.method public constructor <init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lorg/achartengine/f/c;-><init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    new-instance p1, Lorg/achartengine/g/a;

    invoke-direct {p1}, Lorg/achartengine/g/a;-><init>()V

    iput-object p1, p0, Lorg/achartengine/f/g;->p:Lorg/achartengine/g/a;

    new-instance p1, Lorg/achartengine/g/a;

    invoke-direct {p1}, Lorg/achartengine/g/a;-><init>()V

    iput-object p1, p0, Lorg/achartengine/f/g;->q:Lorg/achartengine/g/a;

    new-instance p1, Lorg/achartengine/g/a;

    invoke-direct {p1}, Lorg/achartengine/g/a;-><init>()V

    iput-object p1, p0, Lorg/achartengine/f/g;->r:Lorg/achartengine/g/a;

    const p1, 0x3eb33333    # 0.35f

    iput p1, p0, Lorg/achartengine/f/g;->n:F

    const/high16 p2, 0x3f800000    # 1.0f

    sub-float/2addr p2, p1

    iput p2, p0, Lorg/achartengine/f/g;->o:F

    return-void
.end method

.method private L(Ljava/util/List;Lorg/achartengine/g/a;IIF)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;",
            "Lorg/achartengine/g/a;",
            "IIF)V"
        }
    .end annotation

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    add-int/lit8 p3, p3, 0x1

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/Float;

    invoke-virtual {p3}, Ljava/lang/Float;->floatValue()F

    move-result p3

    invoke-interface {p1, p4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    add-int/lit8 p4, p4, 0x1

    invoke-interface {p1, p4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Float;

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    sub-float/2addr v1, v0

    sub-float/2addr p1, p3

    mul-float/2addr v1, p5

    add-float/2addr v0, v1

    invoke-virtual {p2, v0}, Lorg/achartengine/g/a;->c(F)V

    mul-float/2addr p1, p5

    add-float/2addr p3, p1

    invoke-virtual {p2, p3}, Lorg/achartengine/g/a;->d(F)V

    return-void
.end method

.method private M(DD)Ljava/text/DateFormat;
    .locals 4

    iget-object v0, p0, Lorg/achartengine/f/g;->l:Ljava/lang/String;

    if-eqz v0, :cond_0

    :try_start_0
    new-instance v0, Ljava/text/SimpleDateFormat;

    iget-object v1, p0, Lorg/achartengine/f/g;->l:Ljava/lang/String;

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

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, v0, Lorg/achartengine/f/i;->c:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/d;->X0()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_4

    iget-object v2, v0, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v2}, Lorg/achartengine/g/d;->d()I

    move-result v2

    if-lez v2, :cond_3

    iget-object v2, v0, Lorg/achartengine/f/i;->b:Lorg/achartengine/g/d;

    invoke-virtual {v2, v3}, Lorg/achartengine/g/d;->c(I)Lorg/achartengine/g/e;

    move-result-object v2

    invoke-virtual {v2}, Lorg/achartengine/g/e;->h()I

    move-result v4

    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "viking flag ---------length : "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :goto_0
    if-lt v3, v4, :cond_0

    return-object v1

    :cond_0
    if-eqz v3, :cond_1

    add-int/lit8 v5, v4, -0x1

    if-ne v3, v5, :cond_2

    :cond_1
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "viking flag ---------: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lorg/achartengine/g/e;->q(I)D

    move-result-wide v7

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lorg/achartengine/g/e;->q(I)D

    move-result-wide v5

    invoke-static {v5, v6}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_3
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "viking flag -----------------------super"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    invoke-super/range {p0 .. p5}, Lorg/achartengine/f/i;->D(DDI)Ljava/util/List;

    move-result-object v1

    return-object v1

    :cond_4
    iget-object v2, v0, Lorg/achartengine/f/g;->m:Ljava/lang/Double;

    const-wide v4, 0x4194997000000000L    # 8.64E7

    if-nez v2, :cond_5

    rem-double v6, p1, v4

    sub-double v6, p1, v6

    add-double/2addr v6, v4

    new-instance v2, Ljava/util/Date;

    invoke-static {p1, p2}, Ljava/lang/Math;->round(D)J

    move-result-wide v8

    invoke-direct {v2, v8, v9}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2}, Ljava/util/Date;->getTimezoneOffset()I

    move-result v2

    mul-int/lit8 v2, v2, 0x3c

    mul-int/lit16 v2, v2, 0x3e8

    int-to-double v8, v2

    add-double/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v2

    iput-object v2, v0, Lorg/achartengine/f/g;->m:Ljava/lang/Double;

    :cond_5
    const/16 v2, 0x19

    move/from16 v6, p5

    if-le v6, v2, :cond_6

    goto :goto_1

    :cond_6
    move v2, v6

    :goto_1
    sub-double v6, p3, p1

    int-to-double v8, v2

    div-double/2addr v6, v8

    const-wide/16 v8, 0x0

    cmpg-double v8, v6, v8

    if-gtz v8, :cond_7

    return-object v1

    :cond_7
    cmpg-double v8, v6, v4

    const-wide/high16 v9, 0x4000000000000000L    # 2.0

    if-gtz v8, :cond_9

    :goto_2
    div-double v11, v4, v9

    cmpg-double v8, v6, v11

    if-ltz v8, :cond_8

    goto :goto_4

    :cond_8
    move-wide v4, v11

    goto :goto_2

    :cond_9
    :goto_3
    cmpl-double v8, v6, v4

    if-gtz v8, :cond_c

    :goto_4
    iget-object v6, v0, Lorg/achartengine/f/g;->m:Ljava/lang/Double;

    invoke-virtual {v6}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v6

    iget-object v8, v0, Lorg/achartengine/f/g;->m:Ljava/lang/Double;

    invoke-virtual {v8}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v8

    sub-double/2addr v8, p1

    div-double/2addr v8, v4

    invoke-static {v8, v9}, Ljava/lang/Math;->floor(D)D

    move-result-wide v8

    mul-double/2addr v8, v4

    sub-double/2addr v6, v8

    :goto_5
    cmpg-double v8, v6, p3

    if-gez v8, :cond_b

    add-int/lit8 v8, v3, 0x1

    if-le v3, v2, :cond_a

    goto :goto_6

    :cond_a
    invoke-static {v6, v7}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-double/2addr v6, v4

    move v3, v8

    goto :goto_5

    :cond_b
    :goto_6
    return-object v1

    :cond_c
    mul-double/2addr v4, v9

    goto :goto_3
.end method

.method public N(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/f/g;->l:Ljava/lang/String;

    return-void
.end method

.method protected f(Landroid/graphics/Canvas;Ljava/util/List;Landroid/graphics/Paint;Z)V
    .locals 18
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

    move-object/from16 v6, p0

    move-object/from16 v7, p2

    move/from16 v8, p4

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "viking flag --------------------circular : "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    new-instance v15, Landroid/graphics/Path;

    invoke-direct {v15}, Landroid/graphics/Path;-><init>()V

    const/4 v14, 0x0

    invoke-interface {v7, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    const/4 v13, 0x1

    invoke-interface {v7, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v15, v0, v1}, Landroid/graphics/Path;->moveTo(FF)V

    invoke-interface/range {p2 .. p2}, Ljava/util/List;->size()I

    move-result v0

    if-eqz v8, :cond_0

    add-int/lit8 v0, v0, -0x4

    :cond_0
    move v12, v0

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "viking flag --------------------length : "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    move v3, v14

    :goto_0
    if-lt v3, v12, :cond_3

    if-eqz v8, :cond_2

    move v0, v12

    :goto_1
    add-int/lit8 v1, v12, 0x4

    if-lt v0, v1, :cond_1

    invoke-interface {v7, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-interface {v7, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v15, v0, v1}, Landroid/graphics/Path;->lineTo(FF)V

    goto :goto_2

    :cond_1
    invoke-interface {v7, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    add-int/lit8 v2, v0, 0x1

    invoke-interface {v7, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-virtual {v15, v1, v2}, Landroid/graphics/Path;->lineTo(FF)V

    add-int/lit8 v0, v0, 0x2

    goto :goto_1

    :cond_2
    :goto_2
    move-object/from16 v11, p1

    move-object/from16 v10, p3

    invoke-virtual {v11, v15, v10}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    return-void

    :cond_3
    move-object/from16 v11, p1

    move-object/from16 v10, p3

    add-int/lit8 v9, v3, 0x2

    if-ge v9, v12, :cond_4

    move v5, v9

    goto :goto_3

    :cond_4
    move v5, v3

    :goto_3
    add-int/lit8 v0, v3, 0x4

    if-ge v0, v12, :cond_5

    move/from16 v16, v0

    goto :goto_4

    :cond_5
    move/from16 v16, v5

    :goto_4
    iget-object v2, v6, Lorg/achartengine/f/g;->p:Lorg/achartengine/g/a;

    iget v4, v6, Lorg/achartengine/f/g;->o:F

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move/from16 v17, v4

    move v4, v5

    move v13, v5

    move/from16 v5, v17

    invoke-direct/range {v0 .. v5}, Lorg/achartengine/f/g;->L(Ljava/util/List;Lorg/achartengine/g/a;IIF)V

    iget-object v0, v6, Lorg/achartengine/f/g;->q:Lorg/achartengine/g/a;

    invoke-interface {v7, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v0, v1}, Lorg/achartengine/g/a;->c(F)V

    iget-object v0, v6, Lorg/achartengine/f/g;->q:Lorg/achartengine/g/a;

    add-int/lit8 v5, v13, 0x1

    invoke-interface {v7, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v0, v1}, Lorg/achartengine/g/a;->d(F)V

    iget-object v2, v6, Lorg/achartengine/f/g;->r:Lorg/achartengine/g/a;

    iget v5, v6, Lorg/achartengine/f/g;->n:F

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move v3, v13

    move/from16 v4, v16

    invoke-direct/range {v0 .. v5}, Lorg/achartengine/f/g;->L(Ljava/util/List;Lorg/achartengine/g/a;IIF)V

    iget-object v0, v6, Lorg/achartengine/f/g;->p:Lorg/achartengine/g/a;

    invoke-virtual {v0}, Lorg/achartengine/g/a;->a()F

    move-result v0

    iget-object v1, v6, Lorg/achartengine/f/g;->p:Lorg/achartengine/g/a;

    invoke-virtual {v1}, Lorg/achartengine/g/a;->b()F

    move-result v1

    iget-object v2, v6, Lorg/achartengine/f/g;->q:Lorg/achartengine/g/a;

    invoke-virtual {v2}, Lorg/achartengine/g/a;->a()F

    move-result v2

    iget-object v3, v6, Lorg/achartengine/f/g;->q:Lorg/achartengine/g/a;

    invoke-virtual {v3}, Lorg/achartengine/g/a;->b()F

    move-result v13

    iget-object v3, v6, Lorg/achartengine/f/g;->r:Lorg/achartengine/g/a;

    invoke-virtual {v3}, Lorg/achartengine/g/a;->a()F

    move-result v3

    iget-object v4, v6, Lorg/achartengine/f/g;->r:Lorg/achartengine/g/a;

    invoke-virtual {v4}, Lorg/achartengine/g/a;->b()F

    move-result v4

    move v5, v9

    move-object v9, v15

    move v10, v0

    move v11, v1

    move v0, v12

    move v12, v2

    const/4 v1, 0x1

    move v2, v14

    move v14, v3

    move-object v3, v15

    move v15, v4

    invoke-virtual/range {v9 .. v15}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    move v12, v0

    move v13, v1

    move v14, v2

    move-object v15, v3

    move v3, v5

    goto/16 :goto_0
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

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "viking flag -------------------length label: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

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

    invoke-direct {v14, v0, v1, v2, v3}, Lorg/achartengine/f/g;->M(DD)Ljava/text/DateFormat;

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
