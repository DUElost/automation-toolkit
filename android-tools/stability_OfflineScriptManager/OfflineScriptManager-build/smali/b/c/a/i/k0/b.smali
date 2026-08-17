.class public final Lb/c/a/i/k0/b;
.super Lb/c/a/i/k0/a;
.source ""


# static fields
.field static final synthetic A:Z


# instance fields
.field private n:I

.field private o:I

.field private p:J

.field private q:I

.field private r:I

.field private s:I

.field private t:J

.field private u:J

.field private v:J

.field private w:J

.field private x:I

.field private y:J

.field private z:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/c/a/i/k0/b;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lb/c/a/i/k0/a;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public G()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/b;->v:J

    return-wide v0
.end method

.method public H()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/b;->u:J

    return-wide v0
.end method

.method public I()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/b;->w:J

    return-wide v0
.end method

.method public J()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/b;->n:I

    return v0
.end method

.method public K()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/b;->r:I

    return v0
.end method

.method public L()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/b;->s:I

    return v0
.end method

.method public M()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/b;->p:J

    return-wide v0
.end method

.method public N()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/b;->o:I

    return v0
.end method

.method public O()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/b;->t:J

    return-wide v0
.end method

.method public P()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/b;->q:I

    return v0
.end method

.method public Q()[B
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/b;->z:[B

    return-object v0
.end method

.method public R(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/b;->v:J

    return-void
.end method

.method public S(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/b;->u:J

    return-void
.end method

.method public T(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/b;->w:J

    return-void
.end method

.method public U(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/b;->n:I

    return-void
.end method

.method public V(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/b;->r:I

    return-void
.end method

.method public W(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/b;->s:I

    return-void
.end method

.method public X(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/b;->p:J

    return-void
.end method

.method public Y(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/b;->o:I

    return-void
.end method

.method public Z(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/b;->t:J

    return-void
.end method

.method public a()J
    .locals 8

    iget v0, p0, Lb/c/a/i/k0/b;->q:I

    const/16 v1, 0x10

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v3, :cond_0

    move v3, v1

    goto :goto_0

    :cond_0
    move v3, v2

    :goto_0
    add-int/lit8 v3, v3, 0x1c

    const/4 v4, 0x2

    if-ne v0, v4, :cond_1

    const/16 v2, 0x24

    :cond_1
    add-int/2addr v3, v2

    int-to-long v2, v3

    invoke-virtual {p0}, Lb/e/a/d;->B()J

    move-result-wide v4

    add-long/2addr v2, v4

    iget-boolean v0, p0, Lb/e/a/b;->l:Z

    if-nez v0, :cond_3

    const-wide/16 v4, 0x8

    add-long/2addr v4, v2

    const-wide v6, 0x100000000L

    cmp-long v0, v4, v6

    if-ltz v0, :cond_2

    goto :goto_1

    :cond_2
    const/16 v1, 0x8

    :cond_3
    :goto_1
    int-to-long v0, v1

    add-long/2addr v2, v0

    return-wide v2
.end method

.method public a0(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/b;->q:I

    return-void
.end method

.method public b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
    .locals 8

    const/16 p2, 0x1c

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    const/4 v0, 0x6

    invoke-virtual {p2, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/a;->m:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/b;->q:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/b;->x:I

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/k0/b;->y:J

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/b;->n:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/b;->o:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/b;->r:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/c/a/i/k0/b;->s:I

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/k0/b;->p:J

    iget-object p2, p0, Lb/e/a/b;->k:Ljava/lang/String;

    const-string v0, "mlpa"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    const/16 v0, 0x10

    if-nez p2, :cond_0

    iget-wide v1, p0, Lb/c/a/i/k0/b;->p:J

    ushr-long/2addr v1, v0

    iput-wide v1, p0, Lb/c/a/i/k0/b;->p:J

    :cond_0
    iget p2, p0, Lb/c/a/i/k0/b;->q:I

    const/4 v1, 0x1

    if-ne p2, v1, :cond_1

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    iput-wide v2, p0, Lb/c/a/i/k0/b;->t:J

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    iput-wide v2, p0, Lb/c/a/i/k0/b;->u:J

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    iput-wide v2, p0, Lb/c/a/i/k0/b;->v:J

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    iput-wide v2, p0, Lb/c/a/i/k0/b;->w:J

    :cond_1
    iget p2, p0, Lb/c/a/i/k0/b;->q:I

    const/16 v2, 0x24

    const/4 v3, 0x2

    if-ne p2, v3, :cond_2

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    iput-wide v4, p0, Lb/c/a/i/k0/b;->t:J

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    iput-wide v4, p0, Lb/c/a/i/k0/b;->u:J

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    iput-wide v4, p0, Lb/c/a/i/k0/b;->v:J

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    iput-wide v4, p0, Lb/c/a/i/k0/b;->w:J

    const/16 v4, 0x14

    new-array v4, v4, [B

    iput-object v4, p0, Lb/c/a/i/k0/b;->z:[B

    invoke-virtual {p2, v4}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    :cond_2
    iget-object p2, p0, Lb/e/a/b;->k:Ljava/lang/String;

    const-string v4, "owma"

    invoke-virtual {v4, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    const-wide/16 v5, 0x1c

    const/4 v7, 0x0

    if-eqz p2, :cond_5

    sget-object p2, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {p2, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    sub-long/2addr p3, v5

    iget p2, p0, Lb/c/a/i/k0/b;->q:I

    if-ne p2, v1, :cond_3

    goto :goto_0

    :cond_3
    move v0, v7

    :goto_0
    int-to-long v0, v0

    sub-long/2addr p3, v0

    if-ne p2, v3, :cond_4

    goto :goto_1

    :cond_4
    move v2, v7

    :goto_1
    int-to-long v0, v2

    sub-long/2addr p3, v0

    invoke-static {p3, p4}, Lb/e/a/j/b;->a(J)I

    move-result p2

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    new-instance p1, Lb/c/a/i/k0/b$a;

    invoke-direct {p1, p0, p3, p4, p2}, Lb/c/a/i/k0/b$a;-><init>(Lb/c/a/i/k0/b;JLjava/nio/ByteBuffer;)V

    invoke-virtual {p0, p1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_4

    :cond_5
    sub-long/2addr p3, v5

    iget p2, p0, Lb/c/a/i/k0/b;->q:I

    if-ne p2, v1, :cond_6

    goto :goto_2

    :cond_6
    move v0, v7

    :goto_2
    int-to-long v0, v0

    sub-long/2addr p3, v0

    if-ne p2, v3, :cond_7

    goto :goto_3

    :cond_7
    move v2, v7

    :goto_3
    int-to-long v0, v2

    sub-long/2addr p3, v0

    invoke-virtual {p0, p1, p3, p4, p5}, Lb/e/a/b;->C(Lb/e/a/e;JLb/c/a/b;)V

    :goto_4
    return-void
.end method

.method public b0([B)V
    .locals 0

    iput-object p1, p0, Lb/c/a/i/k0/b;->z:[B

    return-void
.end method

.method public t(Ljava/nio/channels/WritableByteChannel;)V
    .locals 8

    invoke-virtual {p0}, Lb/e/a/b;->F()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    iget v0, p0, Lb/c/a/i/k0/b;->q:I

    const/16 v1, 0x10

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v3, :cond_0

    move v4, v1

    goto :goto_0

    :cond_0
    move v4, v2

    :goto_0
    add-int/lit8 v4, v4, 0x1c

    const/4 v5, 0x2

    if-ne v0, v5, :cond_1

    const/16 v2, 0x24

    :cond_1
    add-int/2addr v4, v2

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    const/4 v2, 0x6

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget v2, p0, Lb/c/a/i/k0/a;->m:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v2, p0, Lb/c/a/i/k0/b;->q:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v2, p0, Lb/c/a/i/k0/b;->x:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget-wide v6, p0, Lb/c/a/i/k0/b;->y:J

    invoke-static {v0, v6, v7}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget v2, p0, Lb/c/a/i/k0/b;->n:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v2, p0, Lb/c/a/i/k0/b;->o:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v2, p0, Lb/c/a/i/k0/b;->r:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v2, p0, Lb/c/a/i/k0/b;->s:I

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget-object v2, p0, Lb/e/a/b;->k:Ljava/lang/String;

    const-string v4, "mlpa"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {p0}, Lb/c/a/i/k0/b;->M()J

    move-result-wide v1

    goto :goto_1

    :cond_2
    invoke-virtual {p0}, Lb/c/a/i/k0/b;->M()J

    move-result-wide v6

    shl-long v1, v6, v1

    :goto_1
    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget v1, p0, Lb/c/a/i/k0/b;->q:I

    if-ne v1, v3, :cond_3

    iget-wide v1, p0, Lb/c/a/i/k0/b;->t:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->u:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->v:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->w:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    :cond_3
    iget v1, p0, Lb/c/a/i/k0/b;->q:I

    if-ne v1, v5, :cond_4

    iget-wide v1, p0, Lb/c/a/i/k0/b;->t:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->u:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->v:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->w:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-object v1, p0, Lb/c/a/i/k0/b;->z:[B

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    :cond_4
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    invoke-virtual {p0, p1}, Lb/e/a/d;->h(Ljava/nio/channels/WritableByteChannel;)V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "AudioSampleEntry{bytesPerSample="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lb/c/a/i/k0/b;->w:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", bytesPerFrame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/k0/b;->v:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", bytesPerPacket="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/k0/b;->u:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", samplesPerPacket="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/k0/b;->t:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", packetSize="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/k0/b;->s:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", compressionId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/k0/b;->r:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", soundVersion="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/k0/b;->q:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", sampleRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/k0/b;->p:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", sampleSize="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/k0/b;->o:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", channelCount="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/k0/b;->n:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", boxes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
