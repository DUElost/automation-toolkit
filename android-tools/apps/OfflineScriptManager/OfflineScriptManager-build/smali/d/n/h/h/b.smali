.class public Ld/n/h/h/b;
.super Ld/n/h/c;
.source ""


# instance fields
.field private final j:Ljava/nio/ByteBuffer;


# direct methods
.method public constructor <init>(Ld/s/c;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/h/c;-><init>(Ld/s/c;I)V

    const/16 p1, 0xa

    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/h/c;->i:Ljava/lang/Runnable;

    const/4 p2, 0x1

    invoke-virtual {p0, p1, p2}, Ld/n/h/d;->d(Ljava/lang/Runnable;Z)V

    return-void
.end method


# virtual methods
.method protected h()V
    .locals 5

    iget-object v0, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v0}, Ld/e;->B()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    const/16 v1, 0xff

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    const/4 v3, 0x2

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    int-to-byte v0, v0

    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    goto :goto_0

    :cond_0
    iget-object v1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    const/16 v3, 0xa

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    const/4 v3, -0x1

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    int-to-long v3, v0

    invoke-static {v1, v3, v4}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    :goto_0
    iget-object v0, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {v1}, Ld/e;->d()I

    move-result v1

    and-int/lit8 v1, v1, 0x1

    int-to-byte v1, v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget-object v0, p0, Ld/n/h/h/b;->j:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    iget-object v3, p0, Ld/n/h/c;->h:Ljava/lang/Runnable;

    invoke-virtual {p0, v0, v1, v3, v2}, Ld/n/h/d;->f(Ljava/nio/ByteBuffer;ILjava/lang/Runnable;Z)V

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
