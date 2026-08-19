.class public final Lb/c/a/i/k0/d;
.super Lb/c/a/i/k0/a;
.source ""

# interfaces
.implements Lb/c/a/i/e;


# instance fields
.field private n:I

.field private o:I

.field private p:D

.field private q:D

.field private r:I

.field private s:Ljava/lang/String;

.field private t:I

.field private u:[J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/c/a/i/k0/d;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    const-string v0, "avc1"

    invoke-direct {p0, v0}, Lb/c/a/i/k0/a;-><init>(Ljava/lang/String;)V

    const-wide/high16 v0, 0x4052000000000000L    # 72.0

    iput-wide v0, p0, Lb/c/a/i/k0/d;->p:D

    iput-wide v0, p0, Lb/c/a/i/k0/d;->q:D

    const/4 v0, 0x1

    iput v0, p0, Lb/c/a/i/k0/d;->r:I

    const-string v0, ""

    iput-object v0, p0, Lb/c/a/i/k0/d;->s:Ljava/lang/String;

    const/16 v0, 0x18

    iput v0, p0, Lb/c/a/i/k0/d;->t:I

    const/4 v0, 0x3

    new-array v0, v0, [J

    iput-object v0, p0, Lb/c/a/i/k0/d;->u:[J

    return-void
.end method


# virtual methods
.method public G()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/d;->s:Ljava/lang/String;

    return-object v0
.end method

.method public H()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/d;->t:I

    return v0
.end method

.method public I()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/d;->r:I

    return v0
.end method

.method public J()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/d;->o:I

    return v0
.end method

.method public K()D
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/d;->p:D

    return-wide v0
.end method

.method public L()D
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/d;->q:D

    return-wide v0
.end method

.method public M()I
    .locals 1

    iget v0, p0, Lb/c/a/i/k0/d;->n:I

    return v0
.end method

.method public N(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/c/a/i/k0/d;->s:Ljava/lang/String;

    return-void
.end method

.method public O(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/d;->t:I

    return-void
.end method

.method public P(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/d;->r:I

    return-void
.end method

.method public Q(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/d;->o:I

    return-void
.end method

.method public R(D)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/d;->p:D

    return-void
.end method

.method public S(D)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/k0/d;->q:D

    return-void
.end method

.method public T(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/k0/d;->n:I

    return-void
.end method

.method public a()J
    .locals 6

    invoke-virtual {p0}, Lb/e/a/d;->B()J

    move-result-wide v0

    const-wide/16 v2, 0x4e

    add-long/2addr v0, v2

    iget-boolean v2, p0, Lb/e/a/b;->l:Z

    if-nez v2, :cond_1

    const-wide/16 v2, 0x8

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
    .locals 6

    invoke-interface {p1}, Lb/e/a/e;->l()J

    move-result-wide v0

    add-long/2addr v0, p3

    const/16 p2, 0x4e

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    const/4 v2, 0x6

    invoke-virtual {p2, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v2

    iput v2, p0, Lb/c/a/i/k0/a;->m:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    iget-object v2, p0, Lb/c/a/i/k0/d;->u:[J

    const/4 v3, 0x0

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    aput-wide v4, v2, v3

    iget-object v2, p0, Lb/c/a/i/k0/d;->u:[J

    const/4 v3, 0x1

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    aput-wide v4, v2, v3

    iget-object v2, p0, Lb/c/a/i/k0/d;->u:[J

    const/4 v3, 0x2

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    aput-wide v4, v2, v3

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v2

    iput v2, p0, Lb/c/a/i/k0/d;->n:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v2

    iput v2, p0, Lb/c/a/i/k0/d;->o:I

    invoke-static {p2}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v2

    iput-wide v2, p0, Lb/c/a/i/k0/d;->p:D

    invoke-static {p2}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v2

    iput-wide v2, p0, Lb/c/a/i/k0/d;->q:D

    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v2

    iput v2, p0, Lb/c/a/i/k0/d;->r:I

    invoke-static {p2}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v2

    const/16 v3, 0x1f

    if-le v2, v3, :cond_0

    move v2, v3

    :cond_0
    new-array v4, v2, [B

    invoke-virtual {p2, v4}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-static {v4}, Lb/c/a/h;->a([B)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lb/c/a/i/k0/d;->s:Ljava/lang/String;

    if-ge v2, v3, :cond_1

    sub-int/2addr v3, v2

    new-array v2, v3, [B

    invoke-virtual {p2, v2}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    :cond_1
    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v2

    iput v2, p0, Lb/c/a/i/k0/d;->t:I

    invoke-static {p2}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    new-instance p2, Lb/c/a/i/k0/d$a;

    invoke-direct {p2, p0, v0, v1, p1}, Lb/c/a/i/k0/d$a;-><init>(Lb/c/a/i/k0/d;JLb/e/a/e;)V

    const-wide/16 v0, 0x4e

    sub-long/2addr p3, v0

    invoke-virtual {p0, p2, p3, p4, p5}, Lb/e/a/b;->C(Lb/e/a/e;JLb/c/a/b;)V

    return-void
.end method

.method public t(Ljava/nio/channels/WritableByteChannel;)V
    .locals 5

    invoke-virtual {p0}, Lb/e/a/b;->F()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    const/16 v0, 0x4e

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    const/4 v1, 0x6

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget v1, p0, Lb/c/a/i/k0/a;->m:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget-object v2, p0, Lb/c/a/i/k0/d;->u:[J

    aget-wide v3, v2, v1

    invoke-static {v0, v3, v4}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-object v2, p0, Lb/c/a/i/k0/d;->u:[J

    const/4 v3, 0x1

    aget-wide v3, v2, v3

    invoke-static {v0, v3, v4}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-object v2, p0, Lb/c/a/i/k0/d;->u:[J

    const/4 v3, 0x2

    aget-wide v3, v2, v3

    invoke-static {v0, v3, v4}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->M()I

    move-result v2

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->J()I

    move-result v2

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->L()D

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    const-wide/16 v2, 0x0

    invoke-static {v0, v2, v3}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->I()I

    move-result v2

    invoke-static {v0, v2}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->G()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lb/c/a/h;->c(Ljava/lang/String;)I

    move-result v2

    invoke-static {v0, v2}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->G()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lb/c/a/h;->b(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->G()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lb/c/a/h;->c(Ljava/lang/String;)I

    move-result v2

    :goto_0
    const/16 v3, 0x1f

    if-lt v2, v3, :cond_0

    invoke-virtual {p0}, Lb/c/a/i/k0/d;->H()I

    move-result v1

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    const v1, 0xffff

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    invoke-virtual {p0, p1}, Lb/e/a/d;->h(Ljava/nio/channels/WritableByteChannel;)V

    return-void

    :cond_0
    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    goto :goto_0
.end method
