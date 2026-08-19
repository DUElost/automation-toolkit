.class Lb/c/a/i/k0/d$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/e/a/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/c/a/i/k0/d;->b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic b:J

.field private final synthetic c:Lb/e/a/e;


# direct methods
.method constructor <init>(Lb/c/a/i/k0/d;JLb/e/a/e;)V
    .locals 0

    iput-wide p2, p0, Lb/c/a/i/k0/d$a;->b:J

    iput-object p4, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public close()V
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v0}, Lb/e/a/e;->close()V

    return-void
.end method

.method public j(JJ)Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v0, p1, p2, p3, p4}, Lb/e/a/e;->j(JJ)Ljava/nio/ByteBuffer;

    move-result-object p1

    return-object p1
.end method

.method public l()J
    .locals 2

    iget-object v0, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v0}, Lb/e/a/e;->l()J

    move-result-wide v0

    return-wide v0
.end method

.method public size()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/d$a;->b:J

    return-wide v0
.end method

.method public u(J)V
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v0, p1, p2}, Lb/e/a/e;->u(J)V

    return-void
.end method

.method public y(Ljava/nio/ByteBuffer;)I
    .locals 6

    iget-wide v0, p0, Lb/c/a/i/k0/d$a;->b:J

    iget-object v2, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v2}, Lb/e/a/e;->l()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    int-to-long v0, v0

    iget-wide v2, p0, Lb/c/a/i/k0/d$a;->b:J

    iget-object v4, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v4}, Lb/e/a/e;->l()J

    move-result-wide v4

    sub-long/2addr v2, v4

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    iget-wide v0, p0, Lb/c/a/i/k0/d$a;->b:J

    iget-object v2, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v2}, Lb/e/a/e;->l()J

    move-result-wide v2

    sub-long/2addr v0, v2

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iget-object v1, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v1, v0}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v1

    check-cast v1, Ljava/nio/ByteBuffer;

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->capacity()I

    move-result p1

    return p1

    :cond_1
    iget-object v0, p0, Lb/c/a/i/k0/d$a;->c:Lb/e/a/e;

    invoke-interface {v0, p1}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    move-result p1

    return p1
.end method
