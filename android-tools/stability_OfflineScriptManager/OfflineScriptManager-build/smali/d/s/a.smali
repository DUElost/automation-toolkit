.class public Ld/s/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private final a:[B


# direct methods
.method private constructor <init>([B)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ld/s/a;->a:[B

    return-void
.end method

.method public static a(Ld/e;)Ld/s/a;
    .locals 1

    invoke-virtual {p0}, Ld/e;->c()[B

    move-result-object p0

    const/4 v0, 0x1

    invoke-static {p0, v0}, Ld/s/a;->c([BZ)Ld/s/a;

    move-result-object p0

    return-object p0
.end method

.method public static b([B)Ld/s/a;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Ld/s/a;->c([BZ)Ld/s/a;

    move-result-object p0

    return-object p0
.end method

.method private static c([BZ)Ld/s/a;
    .locals 2

    if-eqz p1, :cond_0

    array-length p1, p0

    new-array p1, p1, [B

    array-length v0, p0

    const/4 v1, 0x0

    invoke-static {p0, v1, p1, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance p0, Ld/s/a;

    invoke-direct {p0, p1}, Ld/s/a;-><init>([B)V

    return-object p0

    :cond_0
    new-instance p1, Ld/s/a;

    invoke-direct {p1, p0}, Ld/s/a;-><init>([B)V

    return-object p1
.end method


# virtual methods
.method public d()[B
    .locals 1

    iget-object v0, p0, Ld/s/a;->a:[B

    return-object v0
.end method

.method public e()I
    .locals 1

    iget-object v0, p0, Ld/s/a;->a:[B

    array-length v0, v0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 1

    instance-of v0, p1, Ld/s/a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/s/a;->a:[B

    check-cast p1, Ld/s/a;

    iget-object p1, p1, Ld/s/a;->a:[B

    invoke-static {v0, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Ld/s/a;->a:[B

    invoke-static {v0}, Ljava/util/Arrays;->hashCode([B)I

    move-result v0

    return v0
.end method
