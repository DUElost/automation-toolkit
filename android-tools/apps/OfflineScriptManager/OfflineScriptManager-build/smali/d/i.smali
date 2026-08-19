.class final Ld/i;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Closeable;


# instance fields
.field private final b:Ljava/nio/channels/Pipe$SinkChannel;

.field private final c:Ljava/nio/channels/Pipe$SourceChannel;

.field private final d:Ljava/nio/channels/Selector;

.field private final e:Ljava/nio/ByteBuffer;

.field private final f:Ljava/nio/ByteBuffer;

.field private final g:Ljava/util/concurrent/atomic/AtomicInteger;

.field private h:I

.field private final i:Ld/s/c;

.field private final j:I

.field private final k:Ld/c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/i;

    return-void
.end method

.method constructor <init>(Ld/c;ILd/s/c;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    iput-object v1, p0, Ld/i;->e:Ljava/nio/ByteBuffer;

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    iput-object v1, p0, Ld/i;->f:Ljava/nio/ByteBuffer;

    new-instance v1, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v1, p0, Ld/i;->g:Ljava/util/concurrent/atomic/AtomicInteger;

    iput v2, p0, Ld/i;->h:I

    iput-object p1, p0, Ld/i;->k:Ld/c;

    iput p2, p0, Ld/i;->j:I

    iput-object p3, p0, Ld/i;->i:Ld/s/c;

    :try_start_0
    invoke-static {}, Ljava/nio/channels/Pipe;->open()Ljava/nio/channels/Pipe;

    move-result-object p2

    invoke-virtual {p2}, Ljava/nio/channels/Pipe;->source()Ljava/nio/channels/Pipe$SourceChannel;

    move-result-object p3

    iput-object p3, p0, Ld/i;->c:Ljava/nio/channels/Pipe$SourceChannel;

    invoke-virtual {p2}, Ljava/nio/channels/Pipe;->sink()Ljava/nio/channels/Pipe$SinkChannel;

    move-result-object p2

    iput-object p2, p0, Ld/i;->b:Ljava/nio/channels/Pipe$SinkChannel;

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/nio/channels/SelectableChannel;

    aput-object p2, v1, v2

    aput-object p3, v1, v0

    invoke-static {v1}, Ld/s/e;->f([Ljava/nio/channels/SelectableChannel;)V

    invoke-virtual {p1}, Ld/c;->f()Ljava/nio/channels/Selector;

    move-result-object p1

    iput-object p1, p0, Ld/i;->d:Ljava/nio/channels/Selector;

    invoke-virtual {p3, p1, v0}, Ljava/nio/channels/Pipe$SourceChannel;->register(Ljava/nio/channels/Selector;I)Ljava/nio/channels/SelectionKey;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance p2, Ld/k$b;

    invoke-direct {p2, p1}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw p2
.end method


# virtual methods
.method a()Ljava/nio/channels/SelectableChannel;
    .locals 1

    iget-object v0, p0, Ld/i;->c:Ljava/nio/channels/Pipe$SourceChannel;

    return-object v0
.end method

.method b()V
    .locals 2

    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_0

    iget v0, p0, Ld/i;->h:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ld/i;->h:I

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Ld/i;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    iget-object v0, p0, Ld/i;->c:Ljava/nio/channels/Pipe$SourceChannel;

    iget-object v1, p0, Ld/i;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/channels/Pipe$SourceChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v0
    :try_end_0
    .catch Ljava/nio/channels/ClosedChannelException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    new-instance v1, Ld/k$b;

    invoke-direct {v1, v0}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw v1

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/nio/channels/ClosedChannelException;->printStackTrace()V

    iget-object v0, p0, Ld/i;->i:Ld/s/c;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Ld/s/c;->c(I)V

    return-void
.end method

.method public close()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Ld/i;->c:Ljava/nio/channels/Pipe$SourceChannel;

    invoke-virtual {v0}, Ljava/nio/channels/Pipe$SourceChannel;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    :goto_0
    :try_start_1
    iget-object v1, p0, Ld/i;->b:Ljava/nio/channels/Pipe$SinkChannel;

    invoke-virtual {v1}, Ljava/nio/channels/Pipe$SinkChannel;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    :goto_1
    iget-object v1, p0, Ld/i;->k:Ld/c;

    iget-object v2, p0, Ld/i;->d:Ljava/nio/channels/Selector;

    invoke-virtual {v1, v2}, Ld/c;->c(Ljava/nio/channels/Selector;)Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    throw v0
.end method

.method e()V
    .locals 2

    :goto_0
    :try_start_0
    iget-object v0, p0, Ld/i;->e:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    iget-object v0, p0, Ld/i;->b:Ljava/nio/channels/Pipe$SinkChannel;

    iget-object v1, p0, Ld/i;->e:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/channels/Pipe$SinkChannel;->write(Ljava/nio/ByteBuffer;)I

    move-result v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ld/i;->g:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    new-instance v1, Ld/k$b;

    invoke-direct {v1, v0}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method h(J)Z
    .locals 6

    iget v0, p0, Ld/i;->h:I

    iget-object v1, p0, Ld/i;->g:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ge v0, v1, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v3

    :goto_0
    if-eqz v0, :cond_1

    return v2

    :cond_1
    const-wide/16 v0, 0x0

    cmp-long v4, p1, v0

    const/16 v5, 0x23

    if-nez v4, :cond_2

    :try_start_0
    iget-object p1, p0, Ld/i;->i:Ld/s/c;

    invoke-virtual {p1, v5}, Ld/s/c;->c(I)V

    return v3

    :catch_0
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p1

    goto :goto_2

    :cond_2
    if-gez v4, :cond_3

    iget-object p1, p0, Ld/i;->d:Ljava/nio/channels/Selector;

    invoke-virtual {p1, v0, v1}, Ljava/nio/channels/Selector;->select(J)I

    move-result p1

    goto :goto_1

    :cond_3
    iget-object v0, p0, Ld/i;->d:Ljava/nio/channels/Selector;

    invoke-virtual {v0, p1, p2}, Ljava/nio/channels/Selector;->select(J)I

    move-result p1
    :try_end_0
    .catch Ljava/nio/channels/ClosedSelectorException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    if-nez p1, :cond_4

    iget-object p1, p0, Ld/i;->i:Ld/s/c;

    invoke-virtual {p1, v5}, Ld/s/c;->c(I)V

    return v3

    :cond_4
    iget-object p1, p0, Ld/i;->d:Ljava/nio/channels/Selector;

    invoke-virtual {p1}, Ljava/nio/channels/Selector;->selectedKeys()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->clear()V

    return v2

    :goto_2
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    iget-object p1, p0, Ld/i;->i:Ld/s/c;

    const/4 p2, 0x4

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    return v3
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Signaler["

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Ld/i;->j:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
