.class public Ld/r/g/d;
.super Ld/r/g/g;
.source ""


# direct methods
.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/r/g/g;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/4 p2, 0x2

    iput p2, p1, Ld/f;->j:I

    const/4 p2, 0x1

    iput-boolean p2, p1, Ld/f;->s:Z

    return-void
.end method


# virtual methods
.method protected o1(Ld/e;)Z
    .locals 1

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x2d

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method public p1(ILjava/lang/Object;)Z
    .locals 6

    const/4 v0, 0x6

    const/4 v1, 0x0

    const/16 v2, 0x16

    if-eq p1, v0, :cond_0

    const/4 v3, 0x7

    if-eq p1, v3, :cond_0

    :goto_0
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p1, v2}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    if-nez p2, :cond_1

    goto :goto_0

    :cond_1
    invoke-static {p1, p2}, Ld/f;->d(ILjava/lang/Object;)[B

    move-result-object p2

    new-instance v3, Ld/e;

    array-length v4, p2

    const/4 v5, 0x1

    add-int/2addr v4, v5

    invoke-direct {v3, v4}, Ld/e;-><init>(I)V

    if-ne p1, v0, :cond_2

    invoke-virtual {v3, v5}, Ld/e;->p(B)Ld/e;

    goto :goto_1

    :cond_2
    invoke-virtual {v3, v1}, Ld/e;->p(B)Ld/e;

    :goto_1
    invoke-virtual {v3, p2}, Ld/e;->u([B)Ld/e;

    invoke-super {p0, v3}, Ld/r/g/g;->o1(Ld/e;)Z

    move-result p1

    if-eqz p1, :cond_3

    return v5

    :cond_3
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p1, v2}, Ld/s/c;->c(I)V

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Failed to send subscribe/unsubscribe message"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
