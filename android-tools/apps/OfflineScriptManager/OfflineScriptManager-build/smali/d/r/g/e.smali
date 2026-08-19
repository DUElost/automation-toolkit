.class Ld/r/g/e;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/g/e$a;
    }
.end annotation


# instance fields
.field private a:I

.field private b:B

.field private c:I

.field private d:I

.field e:[Ld/r/g/e;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Ld/r/g/e;->b:B

    iput v0, p0, Ld/r/g/e;->c:I

    iput v0, p0, Ld/r/g/e;->d:I

    iput v0, p0, Ld/r/g/e;->a:I

    const/4 v0, 0x0

    iput-object v0, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    return-void
.end method

.method private c([BIILd/r/g/e$a;Ld/p/b;)V
    .locals 7

    iget v0, p0, Ld/r/g/e;->a:I

    if-lez v0, :cond_0

    invoke-interface {p4, p1, p2, p5}, Ld/r/g/e$a;->a([BILd/p/b;)V

    :cond_0
    if-lt p2, p3, :cond_1

    add-int/lit16 p3, p2, 0x100

    invoke-static {p1, p3}, Ld/s/e;->d([BI)[B

    move-result-object p1

    :cond_1
    iget v0, p0, Ld/r/g/e;->c:I

    if-nez v0, :cond_2

    return-void

    :cond_2
    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_3

    iget-byte v0, p0, Ld/r/g/e;->b:B

    aput-byte v0, p1, p2

    add-int/2addr v2, p2

    iget-object p2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    aget-object v0, p2, v1

    move-object v1, p1

    move v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Ld/r/g/e;->c([BIILd/r/g/e$a;Ld/p/b;)V

    return-void

    :cond_3
    move v6, v1

    :goto_0
    iget v0, p0, Ld/r/g/e;->c:I

    if-ne v6, v0, :cond_4

    return-void

    :cond_4
    iget-byte v0, p0, Ld/r/g/e;->b:B

    add-int/2addr v0, v6

    int-to-byte v0, v0

    aput-byte v0, p1, p2

    iget-object v0, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    aget-object v1, v0, v6

    if-eqz v1, :cond_5

    aget-object v0, v0, v6

    add-int/lit8 v2, p2, 0x1

    move-object v1, p1

    move v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Ld/r/g/e;->c([BIILd/r/g/e$a;Ld/p/b;)V

    :cond_5
    add-int/lit8 v6, v6, 0x1

    goto :goto_0
.end method

.method private d()Z
    .locals 1

    iget v0, p0, Ld/r/g/e;->a:I

    if-nez v0, :cond_0

    iget v0, p0, Ld/r/g/e;->d:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private e([Ld/r/g/e;IZ)[Ld/r/g/e;
    .locals 1

    const-class v0, Ld/r/g/e;

    invoke-static {v0, p1, p2, p3}, Ld/s/e;->e(Ljava/lang/Class;[Ljava/lang/Object;IZ)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ld/r/g/e;

    return-object p1
.end method


# virtual methods
.method public a(Ld/e;II)Z
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p3, :cond_1

    iget p1, p0, Ld/r/g/e;->a:I

    add-int/2addr p1, v1

    iput p1, p0, Ld/r/g/e;->a:I

    if-ne p1, v1, :cond_0

    return v1

    :cond_0
    return v0

    :cond_1
    invoke-virtual {p1, p2}, Ld/e;->e(I)B

    move-result v2

    iget-byte v3, p0, Ld/r/g/e;->b:B

    if-lt v2, v3, :cond_2

    iget v4, p0, Ld/r/g/e;->c:I

    add-int/2addr v4, v3

    if-lt v2, v4, :cond_7

    :cond_2
    iget v4, p0, Ld/r/g/e;->c:I

    if-nez v4, :cond_3

    iput-byte v2, p0, Ld/r/g/e;->b:B

    iput v1, p0, Ld/r/g/e;->c:I

    const/4 v3, 0x0

    iput-object v3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    goto :goto_1

    :cond_3
    if-ne v4, v1, :cond_5

    iget-object v4, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    aget-object v4, v4, v0

    if-ge v3, v2, :cond_4

    sub-int v5, v2, v3

    goto :goto_0

    :cond_4
    sub-int v5, v3, v2

    :goto_0
    add-int/2addr v5, v1

    iput v5, p0, Ld/r/g/e;->c:I

    new-array v5, v5, [Ld/r/g/e;

    iput-object v5, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    invoke-static {v3, v2}, Ljava/lang/Math;->min(II)I

    move-result v5

    int-to-byte v5, v5

    iput-byte v5, p0, Ld/r/g/e;->b:B

    iget-object v6, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    sub-int/2addr v3, v5

    aput-object v4, v6, v3

    goto :goto_1

    :cond_5
    if-ge v3, v2, :cond_6

    sub-int v3, v2, v3

    add-int/2addr v3, v1

    iput v3, p0, Ld/r/g/e;->c:I

    iget-object v4, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    invoke-direct {p0, v4, v3, v1}, Ld/r/g/e;->e([Ld/r/g/e;IZ)[Ld/r/g/e;

    move-result-object v3

    iput-object v3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    goto :goto_1

    :cond_6
    add-int/2addr v3, v4

    sub-int/2addr v3, v2

    iput v3, p0, Ld/r/g/e;->c:I

    iget-object v4, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    invoke-direct {p0, v4, v3, v0}, Ld/r/g/e;->e([Ld/r/g/e;IZ)[Ld/r/g/e;

    move-result-object v3

    iput-object v3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    iput-byte v2, p0, Ld/r/g/e;->b:B

    :cond_7
    :goto_1
    iget v3, p0, Ld/r/g/e;->c:I

    if-ne v3, v1, :cond_9

    iget-object v2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    if-nez v2, :cond_8

    new-array v2, v1, [Ld/r/g/e;

    iput-object v2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    new-instance v3, Ld/r/g/e;

    invoke-direct {v3}, Ld/r/g/e;-><init>()V

    aput-object v3, v2, v0

    iget v2, p0, Ld/r/g/e;->d:I

    add-int/2addr v2, v1

    iput v2, p0, Ld/r/g/e;->d:I

    :cond_8
    iget-object v2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    aget-object v0, v2, v0

    :goto_2
    add-int/2addr p2, v1

    sub-int/2addr p3, v1

    invoke-virtual {v0, p1, p2, p3}, Ld/r/g/e;->a(Ld/e;II)Z

    move-result p1

    return p1

    :cond_9
    iget-object v0, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    iget-byte v3, p0, Ld/r/g/e;->b:B

    sub-int v4, v2, v3

    aget-object v4, v0, v4

    if-nez v4, :cond_a

    sub-int v4, v2, v3

    new-instance v5, Ld/r/g/e;

    invoke-direct {v5}, Ld/r/g/e;-><init>()V

    aput-object v5, v0, v4

    iget v4, p0, Ld/r/g/e;->d:I

    add-int/2addr v4, v1

    iput v4, p0, Ld/r/g/e;->d:I

    :cond_a
    sub-int/2addr v2, v3

    aget-object v0, v0, v2

    goto :goto_2
.end method

.method public b(Ld/r/g/e$a;Ld/p/b;)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Ld/r/g/e;->c([BIILd/r/g/e$a;Ld/p/b;)V

    return-void
.end method

.method public f(Ld/e;II)Z
    .locals 6

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p3, :cond_2

    iget p1, p0, Ld/r/g/e;->a:I

    if-nez p1, :cond_0

    return v0

    :cond_0
    sub-int/2addr p1, v1

    iput p1, p0, Ld/r/g/e;->a:I

    if-nez p1, :cond_1

    return v1

    :cond_1
    return v0

    :cond_2
    invoke-virtual {p1, p2}, Ld/e;->e(I)B

    move-result v2

    iget v3, p0, Ld/r/g/e;->c:I

    if-eqz v3, :cond_10

    iget-byte v4, p0, Ld/r/g/e;->b:B

    if-lt v2, v4, :cond_10

    add-int v5, v4, v3

    if-lt v2, v5, :cond_3

    goto/16 :goto_7

    :cond_3
    if-ne v3, v1, :cond_4

    iget-object v3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    aget-object v3, v3, v0

    goto :goto_0

    :cond_4
    iget-object v3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    sub-int v4, v2, v4

    aget-object v3, v3, v4

    :goto_0
    if-nez v3, :cond_5

    return v0

    :cond_5
    add-int/2addr p2, v1

    sub-int/2addr p3, v1

    invoke-virtual {v3, p1, p2, p3}, Ld/r/g/e;->f(Ld/e;II)Z

    move-result p1

    invoke-direct {v3}, Ld/r/g/e;->d()Z

    move-result p2

    if-eqz p2, :cond_f

    iget p2, p0, Ld/r/g/e;->c:I

    const/4 p3, 0x0

    if-ne p2, v1, :cond_6

    iput-object p3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    iput v0, p0, Ld/r/g/e;->c:I

    iget p2, p0, Ld/r/g/e;->d:I

    sub-int/2addr p2, v1

    iput p2, p0, Ld/r/g/e;->d:I

    goto/16 :goto_6

    :cond_6
    iget-object v3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    iget-byte v4, p0, Ld/r/g/e;->b:B

    sub-int v5, v2, v4

    aput-object p3, v3, v5

    iget v5, p0, Ld/r/g/e;->d:I

    sub-int/2addr v5, v1

    iput v5, p0, Ld/r/g/e;->d:I

    if-ne v5, v1, :cond_9

    if-ne v2, v4, :cond_7

    add-int/lit8 p3, p2, -0x1

    aget-object p3, v3, p3

    sub-int/2addr p2, v1

    add-int/2addr v4, p2

    int-to-byte p2, v4

    iput-byte p2, p0, Ld/r/g/e;->b:B

    goto :goto_1

    :cond_7
    add-int/2addr v4, p2

    sub-int/2addr v4, v1

    if-ne v2, v4, :cond_8

    aget-object p3, v3, v0

    :cond_8
    :goto_1
    new-array p2, v1, [Ld/r/g/e;

    aput-object p3, p2, v0

    iput-object p2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    iput v1, p0, Ld/r/g/e;->c:I

    goto :goto_6

    :cond_9
    if-ne v2, v4, :cond_c

    move p2, v1

    :goto_2
    iget p3, p0, Ld/r/g/e;->c:I

    if-lt p2, p3, :cond_a

    goto :goto_3

    :cond_a
    iget-object v0, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    aget-object v0, v0, p2

    if-eqz v0, :cond_b

    iget-byte v0, p0, Ld/r/g/e;->b:B

    add-int/2addr p2, v0

    int-to-byte v4, p2

    :goto_3
    iget-byte p2, p0, Ld/r/g/e;->b:B

    sub-int p2, v4, p2

    sub-int/2addr p3, p2

    iput p3, p0, Ld/r/g/e;->c:I

    iget-object p2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    invoke-direct {p0, p2, p3, v1}, Ld/r/g/e;->e([Ld/r/g/e;IZ)[Ld/r/g/e;

    move-result-object p2

    iput-object p2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    iput-byte v4, p0, Ld/r/g/e;->b:B

    goto :goto_6

    :cond_b
    add-int/lit8 p2, p2, 0x1

    goto :goto_2

    :cond_c
    add-int/2addr v4, p2

    sub-int/2addr v4, v1

    if-ne v2, v4, :cond_f

    :goto_4
    iget p3, p0, Ld/r/g/e;->c:I

    if-lt v1, p3, :cond_d

    goto :goto_5

    :cond_d
    iget-object v2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    add-int/lit8 v3, p3, -0x1

    sub-int/2addr v3, v1

    aget-object v2, v2, v3

    if-eqz v2, :cond_e

    sub-int p2, p3, v1

    :goto_5
    iput p2, p0, Ld/r/g/e;->c:I

    iget-object p3, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    invoke-direct {p0, p3, p2, v0}, Ld/r/g/e;->e([Ld/r/g/e;IZ)[Ld/r/g/e;

    move-result-object p2

    iput-object p2, p0, Ld/r/g/e;->e:[Ld/r/g/e;

    goto :goto_6

    :cond_e
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_f
    :goto_6
    return p1

    :cond_10
    :goto_7
    return v0
.end method
