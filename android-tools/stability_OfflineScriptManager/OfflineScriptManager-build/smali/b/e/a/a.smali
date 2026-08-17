.class public abstract Lb/e/a/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/c/a/i/b;


# static fields
.field private static h:Lb/e/a/j/f;


# instance fields
.field protected b:Ljava/lang/String;

.field private c:[B

.field private d:Lb/c/a/i/e;

.field e:Z

.field private f:Ljava/nio/ByteBuffer;

.field private g:Ljava/nio/ByteBuffer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/a;

    invoke-static {v0}, Lb/e/a/j/f;->a(Ljava/lang/Class;)Lb/e/a/j/f;

    move-result-object v0

    sput-object v0, Lb/e/a/a;->h:Lb/e/a/j/f;

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    iput-object p1, p0, Lb/e/a/a;->b:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lb/e/a/a;->e:Z

    return-void
.end method

.method private f(Ljava/nio/ByteBuffer;)V
    .locals 2

    invoke-direct {p0}, Lb/e/a/a;->i()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lb/e/a/a;->a()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lb/c/a/d;->F(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    goto :goto_0

    :cond_0
    const-wide/16 v0, 0x1

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lb/c/a/d;->F(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p0}, Lb/e/a/a;->a()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->i(Ljava/nio/ByteBuffer;J)V

    :goto_0
    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v0

    const-string v1, "uuid"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lb/e/a/a;->g()[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    :cond_1
    return-void
.end method

.method private i()Z
    .locals 10

    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v0

    const-string v1, "uuid"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0x18

    goto :goto_0

    :cond_0
    const/16 v0, 0x8

    :goto_0
    iget-boolean v1, p0, Lb/e/a/a;->e:Z

    const/4 v2, 0x1

    const-wide v3, 0x100000000L

    const/4 v5, 0x0

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Lb/e/a/a;->e()J

    move-result-wide v6

    iget-object v1, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    goto :goto_1

    :cond_1
    move v1, v5

    :goto_1
    int-to-long v8, v1

    add-long/2addr v6, v8

    int-to-long v0, v0

    add-long/2addr v6, v0

    cmp-long v0, v6, v3

    if-gez v0, :cond_2

    return v2

    :cond_2
    return v5

    :cond_3
    iget-object v1, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    add-int/2addr v1, v0

    int-to-long v0, v1

    cmp-long v0, v0, v3

    if-gez v0, :cond_4

    return v2

    :cond_4
    return v5
.end method


# virtual methods
.method public a()J
    .locals 6

    iget-boolean v0, p0, Lb/e/a/a;->e:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lb/e/a/a;->e()J

    move-result-wide v2

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v0

    goto :goto_0

    :cond_1
    move v0, v1

    :goto_0
    int-to-long v2, v0

    :goto_1
    const-wide v4, 0xfffffff8L

    cmp-long v0, v2, v4

    const/16 v4, 0x8

    if-ltz v0, :cond_2

    move v0, v4

    goto :goto_2

    :cond_2
    move v0, v1

    :goto_2
    add-int/2addr v0, v4

    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v4

    const-string v5, "uuid"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    const/16 v4, 0x10

    goto :goto_3

    :cond_3
    move v4, v1

    :goto_3
    add-int/2addr v0, v4

    int-to-long v4, v0

    add-long/2addr v2, v4

    iget-object v0, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    if-nez v0, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    :goto_4
    int-to-long v0, v1

    add-long/2addr v2, v0

    return-wide v2
.end method

.method public b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
    .locals 0

    invoke-interface {p1}, Lb/e/a/e;->l()J

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    invoke-static {p3, p4}, Lb/e/a/j/b;->a(J)I

    move-result p2

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    iput-object p2, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    :goto_0
    iget-object p2, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p2

    if-gtz p2, :cond_0

    iget-object p1, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iput-boolean p2, p0, Lb/e/a/a;->e:Z

    return-void

    :cond_0
    iget-object p2, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    invoke-interface {p1, p2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    goto :goto_0
.end method

.method protected abstract c(Ljava/nio/ByteBuffer;)V
.end method

.method protected abstract d(Ljava/nio/ByteBuffer;)V
.end method

.method protected abstract e()J
.end method

.method public g()[B
    .locals 1

    iget-object v0, p0, Lb/e/a/a;->c:[B

    return-object v0
.end method

.method public getParent()Lb/c/a/i/e;
    .locals 1

    iget-object v0, p0, Lb/e/a/a;->d:Lb/c/a/i/e;

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/e/a/a;->b:Ljava/lang/String;

    return-object v0
.end method

.method public h()Z
    .locals 1

    iget-boolean v0, p0, Lb/e/a/a;->e:Z

    return v0
.end method

.method public final declared-synchronized j()V
    .locals 3

    monitor-enter p0

    :try_start_0
    sget-object v0, Lb/e/a/a;->h:Lb/e/a/j/f;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "parsing details of "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    iget-object v0, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_1

    const/4 v1, 0x1

    iput-boolean v1, p0, Lb/e/a/a;->e:Z

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    invoke-virtual {p0, v0}, Lb/e/a/a;->c(Ljava/nio/ByteBuffer;)V

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public m(Lb/c/a/i/e;)V
    .locals 0

    iput-object p1, p0, Lb/e/a/a;->d:Lb/c/a/i/e;

    return-void
.end method

.method public t(Ljava/nio/channels/WritableByteChannel;)V
    .locals 4

    iget-boolean v0, p0, Lb/e/a/a;->e:Z

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lb/e/a/a;->a()J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-direct {p0, v0}, Lb/e/a/a;->f(Ljava/nio/ByteBuffer;)V

    invoke-virtual {p0, v0}, Lb/e/a/a;->d(Ljava/nio/ByteBuffer;)V

    iget-object v1, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    :goto_0
    iget-object v1, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    if-gtz v1, :cond_0

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lb/e/a/a;->g:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    goto :goto_0

    :cond_1
    :goto_1
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    :goto_2
    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    goto :goto_5

    :cond_2
    invoke-direct {p0}, Lb/e/a/a;->i()Z

    move-result v0

    const/16 v1, 0x10

    if-eqz v0, :cond_3

    const/16 v0, 0x8

    goto :goto_3

    :cond_3
    move v0, v1

    :goto_3
    invoke-virtual {p0}, Lb/e/a/a;->getType()Ljava/lang/String;

    move-result-object v2

    const-string v3, "uuid"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_4

    goto :goto_4

    :cond_4
    move v1, v3

    :goto_4
    add-int/2addr v0, v1

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-direct {p0, v0}, Lb/e/a/a;->f(Ljava/nio/ByteBuffer;)V

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    iget-object v0, p0, Lb/e/a/a;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object v0

    goto :goto_2

    :goto_5
    return-void
.end method
