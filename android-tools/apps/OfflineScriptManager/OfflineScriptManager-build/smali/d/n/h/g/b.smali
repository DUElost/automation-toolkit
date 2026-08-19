.class public Ld/n/h/g/b;
.super Ld/n/h/c;
.source ""


# direct methods
.method public constructor <init>(Ld/s/c;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/h/c;-><init>(Ld/s/c;I)V

    iget-object p1, p0, Ld/n/h/c;->i:Ljava/lang/Runnable;

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p2}, Ld/n/h/d;->d(Ljava/lang/Runnable;Z)V

    return-void
.end method


# virtual methods
.method protected h()V
    .locals 4

    iget-object v0, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v0}, Ld/e;->a()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget-object v1, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v1}, Ld/e;->B()I

    move-result v1

    iget-object v2, p0, Ld/n/h/c;->i:Ljava/lang/Runnable;

    const/4 v3, 0x1

    invoke-virtual {p0, v0, v1, v2, v3}, Ld/n/h/d;->f(Ljava/nio/ByteBuffer;ILjava/lang/Runnable;Z)V

    return-void
.end method

.method protected i()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method
