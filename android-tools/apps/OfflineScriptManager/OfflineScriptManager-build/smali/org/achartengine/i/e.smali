.class public Lorg/achartengine/i/e;
.super Lorg/achartengine/i/a;
.source ""


# instance fields
.field private c:Z

.field private d:F

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/achartengine/i/g;",
            ">;"
        }
    .end annotation
.end field

.field private f:Z

.field private g:Z


# direct methods
.method public constructor <init>(Lorg/achartengine/f/a;ZF)V
    .locals 0

    invoke-direct {p0, p1}, Lorg/achartengine/i/a;-><init>(Lorg/achartengine/f/a;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lorg/achartengine/i/e;->e:Ljava/util/List;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lorg/achartengine/i/e;->f:Z

    iput-boolean p1, p0, Lorg/achartengine/i/e;->g:Z

    iput-boolean p2, p0, Lorg/achartengine/i/e;->c:Z

    invoke-virtual {p0, p3}, Lorg/achartengine/i/e;->h(F)V

    return-void
.end method

.method private declared-synchronized f(Lorg/achartengine/i/f;)V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/i/e;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/achartengine/i/g;

    invoke-interface {v1, p1}, Lorg/achartengine/i/g;->a(Lorg/achartengine/i/f;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method


# virtual methods
.method public e(I)V
    .locals 32

    move-object/from16 v6, p0

    move/from16 v7, p1

    iget-object v0, v6, Lorg/achartengine/i/a;->a:Lorg/achartengine/f/a;

    instance-of v1, v0, Lorg/achartengine/f/i;

    if-eqz v1, :cond_15

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->m0()I

    move-result v8

    const/4 v9, 0x0

    move v10, v9

    :goto_0
    if-lt v10, v8, :cond_0

    goto/16 :goto_6

    :cond_0
    invoke-virtual {v6, v10}, Lorg/achartengine/i/a;->b(I)[D

    move-result-object v0

    invoke-virtual {v6, v0, v10}, Lorg/achartengine/i/a;->a([DI)V

    iget-object v1, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v1}, Lorg/achartengine/h/d;->M0()[D

    move-result-object v1

    aget-wide v2, v0, v9

    const/4 v4, 0x1

    aget-wide v11, v0, v4

    add-double/2addr v2, v11

    const-wide/high16 v11, 0x4000000000000000L    # 2.0

    div-double/2addr v2, v11

    const/4 v13, 0x2

    aget-wide v14, v0, v13

    const/4 v5, 0x3

    aget-wide v16, v0, v5

    add-double v14, v14, v16

    div-double/2addr v14, v11

    aget-wide v16, v0, v4

    aget-wide v18, v0, v9

    sub-double v16, v16, v18

    aget-wide v18, v0, v5

    aget-wide v20, v0, v13

    sub-double v18, v18, v20

    div-double v20, v16, v11

    sub-double v22, v2, v20

    add-double v20, v2, v20

    div-double v24, v18, v11

    sub-double v26, v14, v24

    add-double v24, v14, v24

    if-nez v10, :cond_5

    if-eqz v1, :cond_2

    aget-wide v28, v1, v9

    cmpg-double v0, v22, v28

    if-lez v0, :cond_1

    aget-wide v22, v1, v4

    cmpl-double v0, v20, v22

    if-ltz v0, :cond_2

    :cond_1
    move v0, v4

    goto :goto_1

    :cond_2
    move v0, v9

    :goto_1
    iput-boolean v0, v6, Lorg/achartengine/i/e;->f:Z

    if-eqz v1, :cond_4

    aget-wide v20, v1, v13

    cmpg-double v0, v26, v20

    if-lez v0, :cond_3

    aget-wide v20, v1, v5

    cmpl-double v0, v24, v20

    if-ltz v0, :cond_4

    :cond_3
    move v0, v4

    goto :goto_2

    :cond_4
    move v0, v9

    :goto_2
    iput-boolean v0, v6, Lorg/achartengine/i/e;->g:Z

    :cond_5
    iget-boolean v0, v6, Lorg/achartengine/i/e;->c:Z

    if-eqz v0, :cond_b

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->Y0()Z

    move-result v0

    const/high16 v20, 0x3f800000    # 1.0f

    if-eqz v0, :cond_8

    if-eq v7, v4, :cond_6

    if-nez v7, :cond_8

    :cond_6
    iget-boolean v0, v6, Lorg/achartengine/i/e;->f:Z

    if-eqz v0, :cond_7

    iget v0, v6, Lorg/achartengine/i/e;->d:F

    cmpg-float v0, v0, v20

    if-ltz v0, :cond_8

    :cond_7
    iget v0, v6, Lorg/achartengine/i/e;->d:F

    float-to-double v11, v0

    div-double v16, v16, v11

    :cond_8
    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->Z0()Z

    move-result v0

    if-eqz v0, :cond_f

    if-eq v7, v13, :cond_9

    if-nez v7, :cond_f

    :cond_9
    iget-boolean v0, v6, Lorg/achartengine/i/e;->g:Z

    if-eqz v0, :cond_a

    iget v0, v6, Lorg/achartengine/i/e;->d:F

    cmpg-float v0, v0, v20

    if-ltz v0, :cond_f

    :cond_a
    iget v0, v6, Lorg/achartengine/i/e;->d:F

    float-to-double v11, v0

    div-double v18, v18, v11

    goto :goto_3

    :cond_b
    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->Y0()Z

    move-result v0

    if-eqz v0, :cond_d

    iget-boolean v0, v6, Lorg/achartengine/i/e;->f:Z

    if-nez v0, :cond_d

    if-eq v7, v4, :cond_c

    if-nez v7, :cond_d

    :cond_c
    iget v0, v6, Lorg/achartengine/i/e;->d:F

    float-to-double v11, v0

    mul-double v16, v16, v11

    :cond_d
    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->Z0()Z

    move-result v0

    if-eqz v0, :cond_f

    iget-boolean v0, v6, Lorg/achartengine/i/e;->g:Z

    if-nez v0, :cond_f

    if-eq v7, v13, :cond_e

    if-nez v7, :cond_f

    :cond_e
    iget v0, v6, Lorg/achartengine/i/e;->d:F

    float-to-double v11, v0

    mul-double v18, v18, v11

    :cond_f
    :goto_3
    move-wide/from16 v11, v16

    move-wide/from16 v30, v18

    if-eqz v1, :cond_10

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    move-wide/from16 v17, v14

    invoke-virtual {v0}, Lorg/achartengine/h/d;->K0()D

    move-result-wide v13

    aget-wide v19, v1, v4

    aget-wide v23, v1, v9

    move/from16 v25, v10

    sub-double v9, v19, v23

    invoke-static {v13, v14, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->L0()D

    move-result-wide v13

    aget-wide v19, v1, v5

    const/4 v0, 0x2

    aget-wide v23, v1, v0

    sub-double v0, v19, v23

    invoke-static {v13, v14, v0, v1}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    goto :goto_4

    :cond_10
    move/from16 v25, v10

    move-wide/from16 v17, v14

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->K0()D

    move-result-wide v9

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->L0()D

    move-result-wide v0

    :goto_4
    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9

    move-wide/from16 v11, v30

    invoke-static {v11, v12, v0, v1}, Ljava/lang/Math;->max(DD)D

    move-result-wide v11

    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->Y0()Z

    move-result v0

    if-eqz v0, :cond_12

    if-eq v7, v4, :cond_11

    if-nez v7, :cond_12

    :cond_11
    const-wide/high16 v0, 0x4000000000000000L    # 2.0

    div-double/2addr v9, v0

    sub-double v4, v2, v9

    add-double/2addr v9, v2

    move-object/from16 v0, p0

    move-wide v1, v4

    move-wide v3, v9

    move/from16 v5, v25

    invoke-virtual/range {v0 .. v5}, Lorg/achartengine/i/a;->c(DDI)V

    :cond_12
    iget-object v0, v6, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0}, Lorg/achartengine/h/d;->Z0()Z

    move-result v0

    if-eqz v0, :cond_14

    const/4 v0, 0x2

    if-eq v7, v0, :cond_13

    if-nez v7, :cond_14

    :cond_13
    const-wide/high16 v0, 0x4000000000000000L    # 2.0

    div-double/2addr v11, v0

    sub-double v1, v17, v11

    add-double v3, v17, v11

    move-object/from16 v0, p0

    move/from16 v5, v25

    invoke-virtual/range {v0 .. v5}, Lorg/achartengine/i/a;->d(DDI)V

    :cond_14
    add-int/lit8 v10, v25, 0x1

    const/4 v9, 0x0

    goto/16 :goto_0

    :cond_15
    check-cast v0, Lorg/achartengine/f/e;

    invoke-virtual {v0}, Lorg/achartengine/f/e;->r()Lorg/achartengine/h/b;

    move-result-object v0

    iget-boolean v1, v6, Lorg/achartengine/i/e;->c:Z

    if-eqz v1, :cond_16

    invoke-virtual {v0}, Lorg/achartengine/h/b;->k()F

    move-result v1

    iget v2, v6, Lorg/achartengine/i/e;->d:F

    mul-float/2addr v1, v2

    goto :goto_5

    :cond_16
    invoke-virtual {v0}, Lorg/achartengine/h/b;->k()F

    move-result v1

    iget v2, v6, Lorg/achartengine/i/e;->d:F

    div-float/2addr v1, v2

    :goto_5
    invoke-virtual {v0, v1}, Lorg/achartengine/h/b;->U(F)V

    :goto_6
    new-instance v0, Lorg/achartengine/i/f;

    iget-boolean v1, v6, Lorg/achartengine/i/e;->c:Z

    iget v2, v6, Lorg/achartengine/i/e;->d:F

    invoke-direct {v0, v1, v2}, Lorg/achartengine/i/f;-><init>(ZF)V

    invoke-direct {v6, v0}, Lorg/achartengine/i/e;->f(Lorg/achartengine/i/f;)V

    return-void
.end method

.method public declared-synchronized g()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/i/e;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/achartengine/i/g;

    invoke-interface {v1}, Lorg/achartengine/i/g;->b()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public h(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/i/e;->d:F

    return-void
.end method
