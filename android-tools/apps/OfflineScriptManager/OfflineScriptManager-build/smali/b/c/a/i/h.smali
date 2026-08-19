.class public Lb/c/a/i/h;
.super Lb/e/a/b;
.source ""

# interfaces
.implements Lb/c/a/i/b;


# instance fields
.field private m:I

.field private n:I


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "dref"

    invoke-direct {p0, v0}, Lb/e/a/b;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a()J
    .locals 6

    invoke-virtual {p0}, Lb/e/a/d;->B()J

    move-result-wide v0

    const-wide/16 v2, 0x8

    add-long/2addr v0, v2

    iget-boolean v4, p0, Lb/e/a/b;->l:Z

    if-nez v4, :cond_1

    add-long/2addr v2, v0

    const-wide v4, 0x100000000L

    cmp-long v2, v2, v4

    if-ltz v2, :cond_0

    goto :goto_0

    :cond_0
    const/16 v2, 0x8

    goto :goto_1

    :cond_1
    :goto_0
    const/16 v2, 0x10

    :goto_1
    int-to-long v2, v2

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
    .locals 2

    const/16 p2, 0x8

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    invoke-static {p2}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/h;->m:I

    invoke-static {p2}, Lb/c/a/e;->j(Ljava/nio/ByteBuffer;)I

    move-result p2

    iput p2, p0, Lb/c/a/i/h;->n:I

    const-wide/16 v0, 0x8

    sub-long/2addr p3, v0

    invoke-virtual {p0, p1, p3, p4, p5}, Lb/e/a/b;->C(Lb/e/a/e;JLb/c/a/b;)V

    return-void
.end method

.method public t(Ljava/nio/channels/WritableByteChannel;)V
    .locals 3

    invoke-virtual {p0}, Lb/e/a/b;->F()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    const/16 v0, 0x8

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Lb/c/a/i/h;->m:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/c/a/i/h;->n:I

    invoke-static {v0, v1}, Lb/c/a/f;->f(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    int-to-long v1, v1

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    invoke-virtual {p0, p1}, Lb/e/a/d;->h(Ljava/nio/channels/WritableByteChannel;)V

    return-void
.end method
