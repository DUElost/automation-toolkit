.class public Lb/e/a/h/i/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/e/a/h/i/c;


# instance fields
.field private a:D


# direct methods
.method public constructor <init>(D)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lb/e/a/h/i/a;->a:D

    return-void
.end method


# virtual methods
.method public a(Lb/e/a/h/g;)[J
    .locals 21

    move-object/from16 v0, p0

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v1

    invoke-virtual {v1}, Lb/e/a/h/h;->g()J

    move-result-wide v1

    iget-wide v3, v0, Lb/e/a/h/i/a;->a:D

    long-to-double v1, v1

    mul-double/2addr v3, v1

    double-to-long v3, v3

    const/4 v5, 0x0

    new-array v6, v5, [J

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->f()[J

    move-result-object v7

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->w()[J

    move-result-object v8

    const-wide/16 v9, 0x1

    const/4 v11, 0x1

    if-eqz v7, :cond_4

    array-length v12, v7

    new-array v13, v12, [J

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->k()J

    move-result-wide v14

    const-wide/16 v16, 0x0

    move v1, v5

    move-wide/from16 v18, v16

    :goto_0
    array-length v2, v8

    if-lt v1, v2, :cond_2

    move v1, v5

    :goto_1
    add-int/lit8 v2, v12, -0x1

    if-lt v1, v2, :cond_0

    aget-wide v8, v13, v2

    sub-long/2addr v14, v8

    const-wide/16 v8, 0x2

    div-long/2addr v3, v8

    cmp-long v1, v14, v3

    if-lez v1, :cond_5

    new-array v1, v11, [J

    aget-wide v2, v7, v2

    aput-wide v2, v1, v5

    invoke-static {v6, v1}, Lb/e/a/j/i;->a([J[J)[J

    move-result-object v6

    goto :goto_3

    :cond_0
    aget-wide v8, v13, v1

    add-int/lit8 v2, v1, 0x1

    aget-wide v18, v13, v2

    cmp-long v10, v16, v18

    if-gtz v10, :cond_1

    sub-long v8, v8, v16

    invoke-static {v8, v9}, Ljava/lang/Math;->abs(J)J

    move-result-wide v8

    sub-long v18, v18, v16

    invoke-static/range {v18 .. v19}, Ljava/lang/Math;->abs(J)J

    move-result-wide v18

    cmp-long v8, v8, v18

    if-gez v8, :cond_1

    new-array v8, v11, [J

    aget-wide v9, v7, v1

    aput-wide v9, v8, v5

    invoke-static {v6, v8}, Lb/e/a/j/i;->a([J[J)[J

    move-result-object v6

    aget-wide v8, v13, v1

    add-long/2addr v8, v3

    move-wide/from16 v16, v8

    :cond_1
    move v1, v2

    goto :goto_1

    :cond_2
    move-object/from16 v20, v6

    int-to-long v5, v1

    add-long/2addr v5, v9

    invoke-static {v7, v5, v6}, Ljava/util/Arrays;->binarySearch([JJ)I

    move-result v2

    if-ltz v2, :cond_3

    aput-wide v18, v13, v2

    :cond_3
    aget-wide v5, v8, v1

    add-long v18, v18, v5

    add-int/lit8 v1, v1, 0x1

    move-object/from16 v6, v20

    const/4 v5, 0x0

    goto :goto_0

    :cond_4
    new-array v3, v11, [J

    const/4 v4, 0x0

    aput-wide v9, v3, v4

    const-wide/16 v4, 0x0

    move-object v6, v3

    move-wide v9, v4

    const/4 v3, 0x0

    :goto_2
    array-length v7, v8

    if-lt v3, v7, :cond_6

    iget-wide v1, v0, Lb/e/a/h/i/a;->a:D

    cmpg-double v1, v9, v1

    if-gez v1, :cond_5

    array-length v1, v6

    if-le v1, v11, :cond_5

    array-length v1, v6

    sub-int/2addr v1, v11

    new-array v1, v1, [J

    array-length v2, v6

    sub-int/2addr v2, v11

    const/4 v3, 0x0

    invoke-static {v6, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v6, v1

    :cond_5
    :goto_3
    return-object v6

    :cond_6
    aget-wide v12, v8, v3

    long-to-double v12, v12

    div-double/2addr v12, v1

    add-double/2addr v9, v12

    iget-wide v12, v0, Lb/e/a/h/i/a;->a:D

    cmpl-double v7, v9, v12

    if-ltz v7, :cond_8

    if-lez v3, :cond_7

    new-array v7, v11, [J

    add-int/lit8 v9, v3, 0x1

    int-to-long v9, v9

    const/4 v12, 0x0

    aput-wide v9, v7, v12

    invoke-static {v6, v7}, Lb/e/a/j/i;->a([J[J)[J

    move-result-object v6

    goto :goto_4

    :cond_7
    const/4 v12, 0x0

    :goto_4
    move-wide v9, v4

    goto :goto_5

    :cond_8
    const/4 v12, 0x0

    :goto_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2
.end method
