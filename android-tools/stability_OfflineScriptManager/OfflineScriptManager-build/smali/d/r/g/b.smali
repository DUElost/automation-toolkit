.class Ld/r/g/b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/g/b$a;
    }
.end annotation


# instance fields
.field private a:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private b:I

.field private c:I

.field private d:I

.field private e:[Ld/r/g/b;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Ld/r/g/b;->b:I

    iput v0, p0, Ld/r/g/b;->c:I

    iput v0, p0, Ld/r/g/b;->d:I

    const/4 v0, 0x0

    iput-object v0, p0, Ld/r/g/b;->a:Ljava/util/Set;

    iput-object v0, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    return-void
.end method

.method private b(Ld/e;IILd/p/b;)Z
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p3, :cond_2

    iget-object p1, p0, Ld/r/g/b;->a:Ljava/util/Set;

    if-nez p1, :cond_0

    move v0, v1

    :cond_0
    if-nez p1, :cond_1

    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Ld/r/g/b;->a:Ljava/util/Set;

    :cond_1
    iget-object p1, p0, Ld/r/g/b;->a:Ljava/util/Set;

    invoke-interface {p1, p4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return v0

    :cond_2
    invoke-virtual {p1, p2}, Ld/e;->e(I)B

    move-result v2

    iget v3, p0, Ld/r/g/b;->b:I

    if-lt v2, v3, :cond_3

    iget v4, p0, Ld/r/g/b;->c:I

    add-int/2addr v4, v3

    if-lt v2, v4, :cond_8

    :cond_3
    iget v4, p0, Ld/r/g/b;->c:I

    if-nez v4, :cond_4

    iput v2, p0, Ld/r/g/b;->b:I

    iput v1, p0, Ld/r/g/b;->c:I

    const/4 v3, 0x0

    iput-object v3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    goto :goto_1

    :cond_4
    if-ne v4, v1, :cond_6

    iget-object v4, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v4, v4, v0

    if-ge v3, v2, :cond_5

    sub-int v5, v2, v3

    goto :goto_0

    :cond_5
    sub-int v5, v3, v2

    :goto_0
    add-int/2addr v5, v1

    iput v5, p0, Ld/r/g/b;->c:I

    new-array v5, v5, [Ld/r/g/b;

    iput-object v5, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    invoke-static {v3, v2}, Ljava/lang/Math;->min(II)I

    move-result v5

    iput v5, p0, Ld/r/g/b;->b:I

    iget-object v6, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    sub-int/2addr v3, v5

    aput-object v4, v6, v3

    goto :goto_1

    :cond_6
    if-ge v3, v2, :cond_7

    sub-int v3, v2, v3

    add-int/2addr v3, v1

    iput v3, p0, Ld/r/g/b;->c:I

    iget-object v4, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    invoke-direct {p0, v4, v3, v1}, Ld/r/g/b;->f([Ld/r/g/b;IZ)[Ld/r/g/b;

    move-result-object v3

    iput-object v3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    goto :goto_1

    :cond_7
    add-int/2addr v3, v4

    sub-int/2addr v3, v2

    iput v3, p0, Ld/r/g/b;->c:I

    iget-object v4, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    invoke-direct {p0, v4, v3, v0}, Ld/r/g/b;->f([Ld/r/g/b;IZ)[Ld/r/g/b;

    move-result-object v3

    iput-object v3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    iput v2, p0, Ld/r/g/b;->b:I

    :cond_8
    :goto_1
    iget v3, p0, Ld/r/g/b;->c:I

    if-ne v3, v1, :cond_a

    iget-object v2, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    if-nez v2, :cond_9

    new-array v2, v1, [Ld/r/g/b;

    iput-object v2, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    new-instance v3, Ld/r/g/b;

    invoke-direct {v3}, Ld/r/g/b;-><init>()V

    aput-object v3, v2, v0

    iget v2, p0, Ld/r/g/b;->d:I

    add-int/2addr v2, v1

    iput v2, p0, Ld/r/g/b;->d:I

    :cond_9
    iget-object v2, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v0, v2, v0

    :goto_2
    add-int/2addr p2, v1

    sub-int/2addr p3, v1

    invoke-direct {v0, p1, p2, p3, p4}, Ld/r/g/b;->b(Ld/e;IILd/p/b;)Z

    move-result p1

    return p1

    :cond_a
    iget-object v0, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    iget v3, p0, Ld/r/g/b;->b:I

    sub-int v4, v2, v3

    aget-object v4, v0, v4

    if-nez v4, :cond_b

    sub-int v4, v2, v3

    new-instance v5, Ld/r/g/b;

    invoke-direct {v5}, Ld/r/g/b;-><init>()V

    aput-object v5, v0, v4

    iget v4, p0, Ld/r/g/b;->d:I

    add-int/2addr v4, v1

    iput v4, p0, Ld/r/g/b;->d:I

    :cond_b
    sub-int/2addr v2, v3

    aget-object v0, v0, v2

    goto :goto_2
.end method

.method private d()Z
    .locals 1

    iget-object v0, p0, Ld/r/g/b;->a:Ljava/util/Set;

    if-nez v0, :cond_0

    iget v0, p0, Ld/r/g/b;->d:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private f([Ld/r/g/b;IZ)[Ld/r/g/b;
    .locals 1

    const-class v0, Ld/r/g/b;

    invoke-static {v0, p1, p2, p3}, Ld/s/e;->e(Ljava/lang/Class;[Ljava/lang/Object;IZ)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ld/r/g/b;

    return-object p1
.end method

.method private i(Ld/e;IILd/p/b;)Z
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez p3, :cond_2

    iget-object p1, p0, Ld/r/g/b;->a:Ljava/util/Set;

    if-eqz p1, :cond_0

    invoke-interface {p1, p4}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    iget-object p1, p0, Ld/r/g/b;->a:Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_0

    iput-object v0, p0, Ld/r/g/b;->a:Ljava/util/Set;

    :cond_0
    iget-object p1, p0, Ld/r/g/b;->a:Ljava/util/Set;

    if-nez p1, :cond_1

    return v2

    :cond_1
    return v1

    :cond_2
    invoke-virtual {p1, p2}, Ld/e;->e(I)B

    move-result v3

    iget v4, p0, Ld/r/g/b;->c:I

    if-eqz v4, :cond_10

    iget v5, p0, Ld/r/g/b;->b:I

    if-lt v3, v5, :cond_10

    add-int v6, v5, v4

    if-lt v3, v6, :cond_3

    goto/16 :goto_8

    :cond_3
    if-ne v4, v2, :cond_4

    iget-object v4, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v4, v4, v1

    goto :goto_0

    :cond_4
    iget-object v4, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    sub-int v5, v3, v5

    aget-object v4, v4, v5

    :goto_0
    if-nez v4, :cond_5

    return v1

    :cond_5
    add-int/2addr p2, v2

    sub-int/2addr p3, v2

    invoke-direct {v4, p1, p2, p3, p4}, Ld/r/g/b;->i(Ld/e;IILd/p/b;)Z

    move-result p1

    invoke-direct {v4}, Ld/r/g/b;->d()Z

    move-result p2

    if-eqz p2, :cond_f

    iget p2, p0, Ld/r/g/b;->c:I

    if-ne p2, v2, :cond_6

    iput-object v0, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    iput v1, p0, Ld/r/g/b;->c:I

    iget p2, p0, Ld/r/g/b;->d:I

    sub-int/2addr p2, v2

    iput p2, p0, Ld/r/g/b;->d:I

    goto/16 :goto_7

    :cond_6
    iget-object p3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    iget p4, p0, Ld/r/g/b;->b:I

    sub-int v4, v3, p4

    aput-object v0, p3, v4

    iget p3, p0, Ld/r/g/b;->d:I

    sub-int/2addr p3, v2

    iput p3, p0, Ld/r/g/b;->d:I

    if-ne p3, v2, :cond_9

    move p2, v1

    :goto_1
    iget p3, p0, Ld/r/g/b;->c:I

    if-lt p2, p3, :cond_7

    goto :goto_2

    :cond_7
    iget-object p3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object p3, p3, p2

    if-eqz p3, :cond_8

    :goto_2
    iget p3, p0, Ld/r/g/b;->b:I

    add-int/2addr p3, p2

    iput p3, p0, Ld/r/g/b;->b:I

    iput v2, p0, Ld/r/g/b;->c:I

    iget-object p3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object p2, p3, p2

    new-array p3, v2, [Ld/r/g/b;

    aput-object p2, p3, v1

    iput-object p3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    goto :goto_7

    :cond_8
    add-int/lit8 p2, p2, 0x1

    goto :goto_1

    :cond_9
    if-ne v3, p4, :cond_c

    move p2, v2

    :goto_3
    iget p3, p0, Ld/r/g/b;->c:I

    if-lt p2, p3, :cond_a

    goto :goto_4

    :cond_a
    iget-object p4, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object p4, p4, p2

    if-eqz p4, :cond_b

    :goto_4
    iget p4, p0, Ld/r/g/b;->b:I

    add-int/2addr p4, p2

    iput p4, p0, Ld/r/g/b;->b:I

    sub-int/2addr p3, p2

    iput p3, p0, Ld/r/g/b;->c:I

    iget-object p2, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    invoke-direct {p0, p2, p3, v2}, Ld/r/g/b;->f([Ld/r/g/b;IZ)[Ld/r/g/b;

    move-result-object p2

    iput-object p2, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    goto :goto_7

    :cond_b
    add-int/lit8 p2, p2, 0x1

    goto :goto_3

    :cond_c
    add-int/2addr p4, p2

    sub-int/2addr p4, v2

    if-ne v3, p4, :cond_f

    :goto_5
    iget p2, p0, Ld/r/g/b;->c:I

    if-lt v2, p2, :cond_d

    goto :goto_6

    :cond_d
    iget-object p3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    add-int/lit8 p4, p2, -0x1

    sub-int/2addr p4, v2

    aget-object p3, p3, p4

    if-eqz p3, :cond_e

    :goto_6
    sub-int/2addr p2, v2

    iput p2, p0, Ld/r/g/b;->c:I

    iget-object p3, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    invoke-direct {p0, p3, p2, v1}, Ld/r/g/b;->f([Ld/r/g/b;IZ)[Ld/r/g/b;

    move-result-object p2

    iput-object p2, p0, Ld/r/g/b;->e:[Ld/r/g/b;

    goto :goto_7

    :cond_e
    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    :cond_f
    :goto_7
    return p1

    :cond_10
    :goto_8
    return v1
.end method

.method private j(Ld/p/b;[BIILd/r/g/b$a;Ld/r/g/f;)Z
    .locals 20

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move/from16 v2, p3

    iget-object v3, v0, Ld/r/g/b;->a:Ljava/util/Set;

    const/4 v4, 0x0

    move-object/from16 v12, p1

    if-eqz v3, :cond_0

    invoke-interface {v3, v12}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, v0, Ld/r/g/b;->a:Ljava/util/Set;

    invoke-interface {v3}, Ljava/util/Set;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    move-object/from16 v3, p5

    move-object/from16 v13, p6

    invoke-interface {v3, v4, v1, v2, v13}, Ld/r/g/b$a;->a(Ld/p/b;[BILd/r/g/f;)V

    iput-object v4, v0, Ld/r/g/b;->a:Ljava/util/Set;

    goto :goto_0

    :cond_0
    move-object/from16 v3, p5

    move-object/from16 v13, p6

    :goto_0
    move/from16 v5, p4

    if-lt v2, v5, :cond_1

    add-int/lit16 v5, v2, 0x100

    invoke-static {v1, v5}, Ld/s/e;->d([BI)[B

    move-result-object v1

    :cond_1
    move v14, v5

    iget v5, v0, Ld/r/g/b;->c:I

    const/4 v15, 0x1

    if-nez v5, :cond_2

    return v15

    :cond_2
    const/4 v11, 0x0

    if-ne v5, v15, :cond_4

    iget v5, v0, Ld/r/g/b;->b:I

    int-to-byte v5, v5

    aput-byte v5, v1, v2

    add-int/lit8 v8, v2, 0x1

    iget-object v2, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v5, v2, v11

    move-object/from16 v6, p1

    move-object v7, v1

    move v9, v14

    move-object/from16 v10, p5

    move v1, v11

    move-object/from16 v11, p6

    invoke-direct/range {v5 .. v11}, Ld/r/g/b;->j(Ld/p/b;[BIILd/r/g/b$a;Ld/r/g/f;)Z

    iget-object v2, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v2, v2, v1

    invoke-direct {v2}, Ld/r/g/b;->d()Z

    move-result v2

    if-eqz v2, :cond_3

    iput-object v4, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    iput v1, v0, Ld/r/g/b;->c:I

    iget v1, v0, Ld/r/g/b;->d:I

    sub-int/2addr v1, v15

    iput v1, v0, Ld/r/g/b;->d:I

    :cond_3
    return v15

    :cond_4
    iget v6, v0, Ld/r/g/b;->b:I

    add-int/2addr v5, v6

    sub-int/2addr v5, v15

    move v10, v5

    move v9, v6

    move v8, v11

    :goto_1
    iget v5, v0, Ld/r/g/b;->c:I

    if-ne v8, v5, :cond_9

    iget v1, v0, Ld/r/g/b;->d:I

    if-nez v1, :cond_5

    iput-object v4, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    iput v11, v0, Ld/r/g/b;->c:I

    goto :goto_3

    :cond_5
    if-ne v1, v15, :cond_6

    iget-object v1, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    iget v2, v0, Ld/r/g/b;->b:I

    sub-int v2, v10, v2

    aget-object v1, v1, v2

    new-array v2, v15, [Ld/r/g/b;

    aput-object v1, v2, v11

    iput-object v2, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    iput v15, v0, Ld/r/g/b;->c:I

    :goto_2
    iput v10, v0, Ld/r/g/b;->b:I

    goto :goto_3

    :cond_6
    iget v1, v0, Ld/r/g/b;->b:I

    if-gt v10, v1, :cond_7

    add-int/2addr v5, v1

    sub-int/2addr v5, v15

    if-ge v9, v5, :cond_8

    :cond_7
    iget-object v2, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    sub-int/2addr v9, v10

    add-int/2addr v9, v15

    iput v9, v0, Ld/r/g/b;->c:I

    new-array v3, v9, [Ld/r/g/b;

    iput-object v3, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    sub-int v1, v10, v1

    invoke-static {v2, v1, v3, v11, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_2

    :cond_8
    :goto_3
    return v15

    :cond_9
    iget v5, v0, Ld/r/g/b;->b:I

    add-int/2addr v5, v8

    int-to-byte v5, v5

    aput-byte v5, v1, v2

    iget-object v5, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v6, v5, v8

    if-eqz v6, :cond_c

    aget-object v5, v5, v8

    add-int/lit8 v16, v2, 0x1

    move-object/from16 v6, p1

    move-object v7, v1

    move/from16 v17, v8

    move/from16 v8, v16

    move/from16 v18, v9

    move v9, v14

    move/from16 v19, v10

    move-object/from16 v10, p5

    move/from16 v16, v11

    move-object/from16 v11, p6

    invoke-direct/range {v5 .. v11}, Ld/r/g/b;->j(Ld/p/b;[BIILd/r/g/b$a;Ld/r/g/f;)Z

    iget-object v5, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v5, v5, v17

    invoke-direct {v5}, Ld/r/g/b;->d()Z

    move-result v5

    if-eqz v5, :cond_a

    iget-object v5, v0, Ld/r/g/b;->e:[Ld/r/g/b;

    aput-object v4, v5, v17

    iget v5, v0, Ld/r/g/b;->d:I

    sub-int/2addr v5, v15

    iput v5, v0, Ld/r/g/b;->d:I

    move/from16 v7, v18

    move/from16 v6, v19

    goto :goto_5

    :cond_a
    iget v5, v0, Ld/r/g/b;->b:I

    add-int v8, v17, v5

    move/from16 v6, v19

    if-ge v8, v6, :cond_b

    add-int v10, v17, v5

    goto :goto_4

    :cond_b
    move v10, v6

    :goto_4
    add-int v8, v17, v5

    move/from16 v7, v18

    if-le v8, v7, :cond_d

    add-int v8, v17, v5

    move v9, v8

    goto :goto_6

    :cond_c
    move/from16 v17, v8

    move v7, v9

    move v6, v10

    move/from16 v16, v11

    :goto_5
    move v10, v6

    :cond_d
    move v9, v7

    :goto_6
    add-int/lit8 v8, v17, 0x1

    move/from16 v11, v16

    goto/16 :goto_1
.end method


# virtual methods
.method public a(Ld/e;Ld/p/b;)Z
    .locals 2

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    invoke-direct {p0, p1, v1, v0, p2}, Ld/r/g/b;->b(Ld/e;IILd/p/b;)Z

    move-result p1

    return p1
.end method

.method final c(Ld/p/b;)Z
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1, v1, p1}, Ld/r/g/b;->b(Ld/e;IILd/p/b;)Z

    move-result p1

    return p1
.end method

.method public e(Ljava/nio/ByteBuffer;ILd/r/g/b$a;Ld/r/g/f;)V
    .locals 6

    const/4 v0, 0x0

    move-object v1, p0

    move v2, v0

    :goto_0
    iget-object v3, v1, Ld/r/g/b;->a:Ljava/util/Set;

    if-eqz v3, :cond_1

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-nez v4, :cond_0

    goto :goto_2

    :cond_0
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ld/p/b;

    const/4 v5, 0x0

    invoke-interface {p3, v4, v5, v0, p4}, Ld/r/g/b$a;->a(Ld/p/b;[BILd/r/g/f;)V

    goto :goto_1

    :cond_1
    :goto_2
    if-nez p2, :cond_2

    goto :goto_4

    :cond_2
    iget v3, v1, Ld/r/g/b;->c:I

    if-nez v3, :cond_3

    goto :goto_4

    :cond_3
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    iget v4, v1, Ld/r/g/b;->c:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_5

    iget v4, v1, Ld/r/g/b;->b:I

    if-eq v3, v4, :cond_4

    goto :goto_4

    :cond_4
    iget-object v1, v1, Ld/r/g/b;->e:[Ld/r/g/b;

    aget-object v1, v1, v0

    :goto_3
    add-int/lit8 v2, v2, 0x1

    add-int/lit8 p2, p2, -0x1

    goto :goto_0

    :cond_5
    iget v5, v1, Ld/r/g/b;->b:I

    if-lt v3, v5, :cond_8

    add-int/2addr v4, v5

    if-lt v3, v4, :cond_6

    goto :goto_4

    :cond_6
    iget-object v1, v1, Ld/r/g/b;->e:[Ld/r/g/b;

    sub-int v4, v3, v5

    aget-object v4, v1, v4

    if-nez v4, :cond_7

    goto :goto_4

    :cond_7
    sub-int/2addr v3, v5

    aget-object v1, v1, v3

    goto :goto_3

    :cond_8
    :goto_4
    return-void
.end method

.method public g(Ld/e;Ld/p/b;)Z
    .locals 2

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    invoke-direct {p0, p1, v1, v0, p2}, Ld/r/g/b;->i(Ld/e;IILd/p/b;)Z

    move-result p1

    return p1
.end method

.method public h(Ld/p/b;Ld/r/g/b$a;Ld/r/g/f;)Z
    .locals 8

    const/4 v0, 0x0

    new-array v3, v0, [B

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v6, p2

    move-object v7, p3

    invoke-direct/range {v1 .. v7}, Ld/r/g/b;->j(Ld/p/b;[BIILd/r/g/b$a;Ld/r/g/f;)Z

    move-result p1

    return p1
.end method
