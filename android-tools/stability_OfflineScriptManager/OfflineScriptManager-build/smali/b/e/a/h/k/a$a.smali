.class Lb/e/a/h/k/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/e/a/h/f;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/e/a/h/k/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field private a:I

.field final synthetic b:Lb/e/a/h/k/a;


# direct methods
.method public constructor <init>(Lb/e/a/h/k/a;I)V
    .locals 0

    iput-object p1, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lb/e/a/h/k/a$a;->a:I

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-object v0, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v0, v0, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    iget v1, p0, Lb/e/a/h/k/a$a;->a:I

    invoke-virtual {v0, v1}, Lb/c/a/i/v;->v(I)J

    move-result-wide v0

    return-wide v0
.end method

.method public b(Ljava/nio/channels/WritableByteChannel;)V
    .locals 1

    invoke-virtual {p0}, Lb/e/a/h/k/a$a;->c()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    return-void
.end method

.method public declared-synchronized c()Ljava/nio/ByteBuffer;
    .locals 11

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget v1, p0, Lb/e/a/h/k/a$a;->a:I

    invoke-virtual {v0, v1}, Lb/e/a/h/k/a;->c(I)I

    move-result v0

    iget-object v1, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v2, v1, Lb/e/a/h/k/a;->d:[Ljava/lang/ref/SoftReference;

    aget-object v2, v2, v0

    iget-object v3, v1, Lb/e/a/h/k/a;->e:[I

    aget v3, v3, v0

    add-int/lit8 v3, v3, -0x1

    iget v4, p0, Lb/e/a/h/k/a$a;->a:I

    sub-int/2addr v4, v3

    iget-object v1, v1, Lb/e/a/h/k/a;->h:[[J

    int-to-long v5, v0

    invoke-static {v5, v6}, Lb/e/a/j/b;->a(J)I

    move-result v7

    aget-object v1, v1, v7

    aget-wide v7, v1, v4

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/ref/SoftReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_1

    :cond_0
    :try_start_1
    iget-object v2, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v4, v2, Lb/e/a/h/k/a;->b:Lb/c/a/i/e;

    iget-object v2, v2, Lb/e/a/h/k/a;->f:[J

    invoke-static {v5, v6}, Lb/e/a/j/b;->a(J)I

    move-result v5

    aget-wide v5, v2, v5

    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    aget-wide v9, v1, v2

    iget-object v2, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v2, v2, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    array-length v1, v1

    add-int/2addr v3, v1

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v2, v3}, Lb/c/a/i/v;->v(I)J

    move-result-wide v1

    add-long/2addr v9, v1

    invoke-interface {v4, v5, v6, v9, v10}, Lb/c/a/i/e;->s(JJ)Ljava/nio/ByteBuffer;

    move-result-object v2

    iget-object v1, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v1, v1, Lb/e/a/h/k/a;->d:[Ljava/lang/ref/SoftReference;

    new-instance v3, Ljava/lang/ref/SoftReference;

    invoke-direct {v3, v2}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    aput-object v3, v1, v0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_1
    :try_start_2
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-static {v7, v8}, Lb/e/a/j/b;->a(J)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget-object v1, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v1, v1, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    iget v2, p0, Lb/e/a/h/k/a$a;->a:I

    invoke-virtual {v1, v2}, Lb/c/a/i/v;->v(I)J

    move-result-wide v1

    invoke-static {v1, v2}, Lb/e/a/j/b;->a(J)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v0

    :catch_0
    move-exception v0

    :try_start_3
    new-instance v1, Ljava/io/StringWriter;

    invoke-direct {v1}, Ljava/io/StringWriter;-><init>()V

    new-instance v2, Ljava/io/PrintWriter;

    invoke-direct {v2, v1}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V

    invoke-virtual {v0, v2}, Ljava/io/IOException;->printStackTrace(Ljava/io/PrintWriter;)V

    invoke-static {}, Lb/e/a/h/k/a;->a()Lb/e/a/j/f;

    move-result-object v2

    invoke-virtual {v1}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/IndexOutOfBoundsException;

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Sample(index: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Lb/e/a/h/k/a$a;->a:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " size: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/h/k/a$a;->b:Lb/e/a/h/k/a;

    iget-object v1, v1, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    iget v2, p0, Lb/e/a/h/k/a$a;->a:I

    invoke-virtual {v1, v2}, Lb/c/a/i/v;->v(I)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
