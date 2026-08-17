.class public Ld/n/h/i/b;
.super Ld/n/h/c;
.source ""


# instance fields
.field private final j:Ljava/nio/ByteBuffer;


# direct methods
.method public constructor <init>(Ld/s/c;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/h/c;-><init>(Ld/s/c;I)V

    const/16 p1, 0x9

    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/h/c;->i:Ljava/lang/Runnable;

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p2}, Ld/n/h/d;->d(Ljava/lang/Runnable;Z)V

    return-void
.end method


# virtual methods
.method protected h()V
    .locals 5

    iget-object v0, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v0}, Ld/e;->j()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    int-to-byte v0, v0

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    iget-object v2, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v2}, Ld/e;->B()I

    move-result v2

    const/16 v3, 0xff

    if-le v2, v3, :cond_1

    or-int/lit8 v0, v0, 0x2

    int-to-byte v0, v0

    :cond_1
    iget-object v2, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v2}, Ld/e;->l()Z

    move-result v2

    if-eqz v2, :cond_2

    or-int/lit8 v0, v0, 0x4

    int-to-byte v0, v0

    :cond_2
    iget-object v2, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v2}, Ld/e;->B()I

    move-result v2

    iget-object v4, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v4, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget-object v0, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    if-le v2, v3, :cond_3

    const/16 v3, 0x9

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    int-to-long v2, v2

    invoke-static {v0, v2, v3}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    goto :goto_1

    :cond_3
    const/4 v3, 0x2

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    int-to-byte v2, v2

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    :goto_1
    iget-object v0, p0, Ld/n/h/i/b;->j:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v2

    iget-object v3, p0, Ld/n/h/c;->h:Ljava/lang/Runnable;

    invoke-virtual {p0, v0, v2, v3, v1}, Ld/n/h/d;->f(Ljava/nio/ByteBuffer;ILjava/lang/Runnable;Z)V

    return-void
.end method

.method protected i()V
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
