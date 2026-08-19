.class public Lorg/achartengine/i/b;
.super Lorg/achartengine/i/a;
.source ""


# direct methods
.method public constructor <init>(Lorg/achartengine/f/a;)V
    .locals 0

    invoke-direct {p0, p1}, Lorg/achartengine/i/a;-><init>(Lorg/achartengine/f/a;)V

    return-void
.end method


# virtual methods
.method public e()V
    .locals 20

    move-object/from16 v0, p0

    iget-object v1, v0, Lorg/achartengine/i/a;->a:Lorg/achartengine/f/a;

    instance-of v2, v1, Lorg/achartengine/f/i;

    if-eqz v2, :cond_7

    check-cast v1, Lorg/achartengine/f/i;

    invoke-virtual {v1}, Lorg/achartengine/f/i;->y()Lorg/achartengine/g/d;

    move-result-object v1

    if-nez v1, :cond_0

    return-void

    :cond_0
    iget-object v1, v0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->m0()I

    move-result v1

    iget-object v2, v0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v2}, Lorg/achartengine/h/d;->P0()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_3

    :goto_0
    if-lt v3, v1, :cond_1

    goto/16 :goto_3

    :cond_1
    iget-object v2, v0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v2, v3}, Lorg/achartengine/h/d;->Q0(I)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, v0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v2, v3}, Lorg/achartengine/h/d;->g0(I)[D

    move-result-object v4

    invoke-virtual {v2, v4, v3}, Lorg/achartengine/h/d;->g1([DI)V

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_3
    iget-object v2, v0, Lorg/achartengine/i/a;->a:Lorg/achartengine/f/a;

    check-cast v2, Lorg/achartengine/f/i;

    invoke-virtual {v2}, Lorg/achartengine/f/i;->y()Lorg/achartengine/g/d;

    move-result-object v2

    invoke-virtual {v2}, Lorg/achartengine/g/d;->b()[Lorg/achartengine/g/e;

    move-result-object v2

    array-length v4, v2

    if-lez v4, :cond_8

    move v5, v3

    :goto_1
    if-lt v5, v1, :cond_4

    goto/16 :goto_3

    :cond_4
    const/4 v6, 0x4

    new-array v7, v6, [D

    fill-array-data v7, :array_0

    move v8, v3

    :goto_2
    const/4 v9, 0x2

    const/4 v10, 0x3

    const/4 v11, 0x1

    if-lt v8, v4, :cond_5

    aget-wide v12, v7, v11

    aget-wide v14, v7, v3

    sub-double/2addr v12, v14

    invoke-static {v12, v13}, Ljava/lang/Math;->abs(D)D

    move-result-wide v12

    const-wide/high16 v14, 0x4044000000000000L    # 40.0

    div-double/2addr v12, v14

    aget-wide v16, v7, v10

    aget-wide v18, v7, v9

    sub-double v16, v16, v18

    invoke-static/range {v16 .. v17}, Ljava/lang/Math;->abs(D)D

    move-result-wide v16

    div-double v16, v16, v14

    iget-object v8, v0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    new-array v6, v6, [D

    aget-wide v14, v7, v3

    sub-double/2addr v14, v12

    aput-wide v14, v6, v3

    aget-wide v14, v7, v11

    add-double/2addr v14, v12

    aput-wide v14, v6, v11

    aget-wide v11, v7, v9

    sub-double v11, v11, v16

    aput-wide v11, v6, v9

    aget-wide v11, v7, v10

    add-double v11, v11, v16

    aput-wide v11, v6, v10

    invoke-virtual {v8, v6, v5}, Lorg/achartengine/h/d;->g1([DI)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_5
    aget-object v12, v2, v8

    invoke-virtual {v12}, Lorg/achartengine/g/e;->o()I

    move-result v12

    if-ne v5, v12, :cond_6

    aget-wide v12, v7, v3

    aget-object v14, v2, v8

    invoke-virtual {v14}, Lorg/achartengine/g/e;->k()D

    move-result-wide v14

    invoke-static {v12, v13, v14, v15}, Ljava/lang/Math;->min(DD)D

    move-result-wide v12

    aput-wide v12, v7, v3

    aget-wide v12, v7, v11

    aget-object v14, v2, v8

    invoke-virtual {v14}, Lorg/achartengine/g/e;->i()D

    move-result-wide v14

    invoke-static {v12, v13, v14, v15}, Ljava/lang/Math;->max(DD)D

    move-result-wide v12

    aput-wide v12, v7, v11

    aget-wide v11, v7, v9

    aget-object v13, v2, v8

    invoke-virtual {v13}, Lorg/achartengine/g/e;->l()D

    move-result-wide v13

    invoke-static {v11, v12, v13, v14}, Ljava/lang/Math;->min(DD)D

    move-result-wide v11

    aput-wide v11, v7, v9

    aget-wide v11, v7, v10

    aget-object v9, v2, v8

    invoke-virtual {v9}, Lorg/achartengine/g/e;->j()D

    move-result-wide v13

    invoke-static {v11, v12, v13, v14}, Ljava/lang/Math;->max(DD)D

    move-result-wide v11

    aput-wide v11, v7, v10

    :cond_6
    add-int/lit8 v8, v8, 0x1

    goto :goto_2

    :cond_7
    check-cast v1, Lorg/achartengine/f/e;

    invoke-virtual {v1}, Lorg/achartengine/f/e;->r()Lorg/achartengine/h/b;

    move-result-object v1

    invoke-virtual {v1}, Lorg/achartengine/h/b;->j()F

    move-result v2

    invoke-virtual {v1, v2}, Lorg/achartengine/h/b;->U(F)V

    :cond_8
    :goto_3
    return-void

    nop

    :array_0
    .array-data 8
        0x7fefffffffffffffL    # Double.MAX_VALUE
        -0x10000000000001L
        0x7fefffffffffffffL    # Double.MAX_VALUE
        -0x10000000000001L
    .end array-data
.end method
