.class public Ld/n/i/d/a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/i/d/a$a;
    }
.end annotation


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I
    .locals 6

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p4}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    move-object v0, p0

    move v3, p3

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Ld/n/i/d/a;->b([B[BI[B[B)I

    move-result p1

    return p1
.end method

.method b([B[BI[B[B)I
    .locals 6

    int-to-long v2, p3

    move-object v0, p1

    move-object v1, p2

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/neilalexander/jnacl/crypto/curve25519xsalsa20poly1305;->crypto_box_afternm([B[BJ[B[B)I

    move-result p1

    return p1
.end method

.method c([B[B[B)I
    .locals 0

    invoke-static {p1, p2, p3}, Lcom/neilalexander/jnacl/crypto/curve25519xsalsa20poly1305;->crypto_box_beforenm([B[B[B)I

    move-result p1

    return p1
.end method

.method public d(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I
    .locals 7

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p4}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    move-object v0, p0

    move v3, p3

    move-object v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Ld/n/i/d/a;->e([B[BI[B[B[B)I

    move-result p1

    return p1
.end method

.method public e([B[BI[B[B[B)I
    .locals 7

    int-to-long v2, p3

    move-object v0, p1

    move-object v1, p2

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-static/range {v0 .. v6}, Lcom/neilalexander/jnacl/crypto/curve25519xsalsa20poly1305;->crypto_box([B[BJ[B[B[B)I

    move-result p1

    return p1
.end method

.method public f()[[B
    .locals 4

    const/4 v0, 0x2

    new-array v0, v0, [[B

    sget-object v1, Ld/n/i/d/a$a;->e:Ld/n/i/d/a$a;

    invoke-virtual {v1}, Ld/n/i/d/a$a;->a()I

    move-result v1

    new-array v1, v1, [B

    sget-object v2, Ld/n/i/d/a$a;->f:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    new-array v2, v2, [B

    invoke-static {v1, v2}, Lcom/neilalexander/jnacl/crypto/curve25519xsalsa20poly1305;->crypto_box_keypair([B[B)I

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const/4 v1, 0x1

    aput-object v2, v0, v1

    return-object v0
.end method

.method g(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I
    .locals 7

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p4}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    move-object v0, p0

    move v3, p3

    move-object v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Ld/n/i/d/a;->h([B[BI[B[B[B)I

    move-result p1

    return p1
.end method

.method h([B[BI[B[B[B)I
    .locals 7

    int-to-long v2, p3

    move-object v0, p1

    move-object v1, p2

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-static/range {v0 .. v6}, Lcom/neilalexander/jnacl/crypto/curve25519xsalsa20poly1305;->crypto_box_open([B[BJ[B[B[B)I

    move-result p1

    return p1
.end method

.method i(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I
    .locals 6

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p4}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    move-object v0, p0

    move v3, p3

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Ld/n/i/d/a;->j([B[BI[B[B)I

    move-result p1

    return p1
.end method

.method j([B[BI[B[B)I
    .locals 6

    int-to-long v2, p3

    move-object v0, p1

    move-object v1, p2

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/neilalexander/jnacl/crypto/curve25519xsalsa20poly1305;->crypto_box_open_afternm([B[BJ[B[B)I

    move-result p1

    return p1
.end method

.method k(I)[B
    .locals 0

    invoke-static {p1}, Ld/s/e;->b(I)[B

    move-result-object p1

    return-object p1
.end method

.method l(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I
    .locals 6

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p4}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    move-object v0, p0

    move v3, p3

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Ld/n/i/d/a;->m([B[BI[B[B)I

    move-result p1

    return p1
.end method

.method m([B[BI[B[B)I
    .locals 6

    int-to-long v2, p3

    move-object v0, p1

    move-object v1, p2

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/neilalexander/jnacl/crypto/xsalsa20poly1305;->crypto_secretbox([B[BJ[B[B)I

    move-result p1

    return p1
.end method

.method n(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I
    .locals 6

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p4}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    move-object v0, p0

    move v3, p3

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Ld/n/i/d/a;->o([B[BI[B[B)I

    move-result p1

    return p1
.end method

.method o([B[BI[B[B)I
    .locals 6

    int-to-long v2, p3

    move-object v0, p1

    move-object v1, p2

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/neilalexander/jnacl/crypto/xsalsa20poly1305;->crypto_secretbox_open([B[BJ[B[B)I

    move-result p1

    return p1
.end method
