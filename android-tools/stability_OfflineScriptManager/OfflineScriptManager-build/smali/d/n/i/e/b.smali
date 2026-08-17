.class public Ld/n/i/e/b;
.super Ld/n/i/a;
.source ""


# direct methods
.method public constructor <init>(Ld/n/f;Ld/n/j/a;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/n/i/a;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "GSSAPI mechanism is not yet implemented"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method public m(Ld/e;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public q(Ld/e;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public y()Ld/n/i/a$b;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public z()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
