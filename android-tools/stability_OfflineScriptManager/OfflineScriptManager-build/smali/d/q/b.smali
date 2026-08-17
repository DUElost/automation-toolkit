.class public final Ld/q/b;
.super Ld/q/c;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/q/b$a;
    }
.end annotation


# instance fields
.field private final f:Ld/c;

.field private final g:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ld/q/b$a;",
            ">;"
        }
    .end annotation
.end field

.field private h:Z

.field private final i:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final j:Ljava/util/concurrent/CountDownLatch;

.field private k:Ljava/nio/channels/Selector;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/q/b;

    return-void
.end method

.method public constructor <init>(Ld/c;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0, p2}, Ld/q/c;-><init>(Ljava/lang/String;)V

    const/4 p2, 0x0

    iput-boolean p2, p0, Ld/q/b;->h:Z

    new-instance p2, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {p2}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object p2, p0, Ld/q/b;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    new-instance p2, Ljava/util/concurrent/CountDownLatch;

    const/4 v0, 0x1

    invoke-direct {p2, v0}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object p2, p0, Ld/q/b;->j:Ljava/util/concurrent/CountDownLatch;

    iput-object p1, p0, Ld/q/b;->f:Ld/c;

    new-instance p2, Ljava/util/HashSet;

    invoke-direct {p2}, Ljava/util/HashSet;-><init>()V

    iput-object p2, p0, Ld/q/b;->g:Ljava/util/Set;

    invoke-virtual {p1}, Ld/c;->f()Ljava/nio/channels/Selector;

    move-result-object p1

    iput-object p1, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    return-void
.end method

.method private j(IJJ)I
    .locals 4

    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long/2addr v2, p4

    const-wide/16 p4, 0x2

    div-long/2addr p2, p4

    cmp-long p2, v2, p2

    if-gez p2, :cond_0

    goto :goto_0

    :cond_0
    move p1, v1

    goto :goto_1

    :cond_1
    :goto_0
    add-int/lit8 p1, p1, 0x1

    :goto_1
    const/16 p2, 0xa

    if-le p1, p2, :cond_2

    invoke-direct {p0}, Ld/q/b;->k()V

    goto :goto_2

    :cond_2
    move v1, p1

    :goto_2
    return v1
.end method

.method private k()V
    .locals 3

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v2, " rebuilding selector"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    iget-object v0, p0, Ld/q/b;->f:Ld/c;

    invoke-virtual {v0}, Ld/c;->f()Ljava/nio/channels/Selector;

    move-result-object v0

    iget-object v1, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    iput-object v0, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/q/b;->h:Z

    iget-object v0, p0, Ld/q/b;->f:Ld/c;

    invoke-virtual {v0, v1}, Ld/c;->c(Ljava/nio/channels/Selector;)Z

    return-void
.end method

.method private l(Ld/q/b$a;IZ)V
    .locals 0

    if-eqz p3, :cond_0

    invoke-static {p1}, Ld/q/b$a;->b(Ld/q/b$a;)I

    move-result p3

    or-int/2addr p2, p3

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ld/q/b$a;->b(Ld/q/b$a;)I

    move-result p3

    not-int p2, p2

    and-int/2addr p2, p3

    :goto_0
    invoke-static {p1, p2}, Ld/q/b$a;->c(Ld/q/b$a;I)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/q/b;->h:Z

    return-void
.end method


# virtual methods
.method public h(Ljava/nio/channels/SelectableChannel;Ld/q/a;)Ld/q/b$a;
    .locals 1

    new-instance v0, Ld/q/b$a;

    invoke-direct {v0, p1, p2}, Ld/q/b$a;-><init>(Ljava/nio/channels/SelectableChannel;Ld/q/a;)V

    iget-object p1, p0, Ld/q/b;->g:Ljava/util/Set;

    invoke-interface {p1, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ld/q/c;->b(I)V

    return-object v0
.end method

.method public i()V
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Ld/q/b;->u()V

    iget-object v0, p0, Ld/q/b;->j:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->await()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iget-object v0, p0, Ld/q/b;->f:Ld/c;

    iget-object v1, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-virtual {v0, v1}, Ld/c;->c(Ljava/nio/channels/Selector;)Z

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_0
    move-exception v0

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :goto_1
    return-void

    :goto_2
    iget-object v1, p0, Ld/q/b;->f:Ld/c;

    iget-object v2, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-virtual {v1, v2}, Ld/c;->c(Ljava/nio/channels/Selector;)Z

    throw v0
.end method

.method public m(Ld/q/b$a;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p1, v0}, Ld/q/b$a;->a(Ld/q/b$a;Z)V

    iput-boolean v0, p0, Ld/q/b;->h:Z

    const/4 p1, -0x1

    invoke-virtual {p0, p1}, Ld/q/c;->b(I)V

    return-void
.end method

.method public n(Ld/q/b$a;)V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Ld/q/b;->l(Ld/q/b$a;IZ)V

    return-void
.end method

.method public o(Ld/q/b$a;)V
    .locals 2

    const/4 v0, 0x4

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Ld/q/b;->l(Ld/q/b$a;IZ)V

    return-void
.end method

.method public p(Ld/q/b$a;)V
    .locals 2

    const/16 v0, 0x10

    const/4 v1, 0x1

    invoke-direct {p0, p1, v0, v1}, Ld/q/b;->l(Ld/q/b$a;IZ)V

    return-void
.end method

.method public q(Ld/q/b$a;)V
    .locals 2

    const/16 v0, 0x8

    const/4 v1, 0x1

    invoke-direct {p0, p1, v0, v1}, Ld/q/b;->l(Ld/q/b$a;IZ)V

    return-void
.end method

.method public r(Ld/q/b$a;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, v0}, Ld/q/b;->l(Ld/q/b$a;IZ)V

    return-void
.end method

.method public run()V
    .locals 9

    const/4 v0, 0x0

    move v2, v0

    :goto_0
    iget-object v1, p0, Ld/q/b;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, p0, Ld/q/b;->j:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void

    :cond_0
    invoke-virtual {p0}, Ld/q/c;->f()J

    move-result-wide v3

    iget-boolean v1, p0, Ld/q/b;->h:Z

    if-eqz v1, :cond_7

    iput-boolean v0, p0, Ld/q/b;->h:Z

    iget-object v1, p0, Ld/q/b;->g:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_2

    goto :goto_4

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ld/q/b$a;

    invoke-static {v5}, Ld/q/b$a;->d(Ld/q/b$a;)Ljava/nio/channels/SelectableChannel;

    move-result-object v6

    iget-object v7, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-virtual {v6, v7}, Ljava/nio/channels/SelectableChannel;->keyFor(Ljava/nio/channels/Selector;)Ljava/nio/channels/SelectionKey;

    move-result-object v6

    invoke-static {v5}, Ld/q/b$a;->e(Ld/q/b$a;)Z

    move-result v7

    if-nez v7, :cond_5

    invoke-static {v5}, Ld/q/b$a;->d(Ld/q/b$a;)Ljava/nio/channels/SelectableChannel;

    move-result-object v7

    invoke-virtual {v7}, Ljava/nio/channels/SelectableChannel;->isOpen()Z

    move-result v7

    if-nez v7, :cond_3

    goto :goto_3

    :cond_3
    if-nez v6, :cond_4

    invoke-static {v5}, Ld/q/b$a;->d(Ld/q/b$a;)Ljava/nio/channels/SelectableChannel;

    move-result-object v6

    invoke-virtual {v6}, Ljava/nio/channels/SelectableChannel;->isOpen()Z

    move-result v6

    if-eqz v6, :cond_1

    :try_start_0
    invoke-static {v5}, Ld/q/b$a;->d(Ld/q/b$a;)Ljava/nio/channels/SelectableChannel;

    move-result-object v6

    iget-object v7, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-static {v5}, Ld/q/b$a;->b(Ld/q/b$a;)I

    move-result v8

    invoke-virtual {v6, v7, v8, v5}, Ljava/nio/channels/SelectableChannel;->register(Ljava/nio/channels/Selector;ILjava/lang/Object;)Ljava/nio/channels/SelectionKey;
    :try_end_0
    .catch Ljava/nio/channels/CancelledKeyException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/nio/channels/ClosedSelectorException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/nio/channels/ClosedChannelException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v5

    goto :goto_2

    :catch_1
    move-exception v5

    goto :goto_2

    :catch_2
    move-exception v5

    :goto_2
    invoke-virtual {v5}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    :cond_4
    invoke-virtual {v6}, Ljava/nio/channels/SelectionKey;->isValid()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-static {v5}, Ld/q/b$a;->b(Ld/q/b$a;)I

    move-result v5

    invoke-virtual {v6, v5}, Ljava/nio/channels/SelectionKey;->interestOps(I)Ljava/nio/channels/SelectionKey;

    goto :goto_1

    :cond_5
    :goto_3
    if-eqz v6, :cond_6

    invoke-virtual {v6}, Ljava/nio/channels/SelectionKey;->cancel()V

    :cond_6
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :goto_1

    :cond_7
    :goto_4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    :try_start_1
    iget-object v1, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-virtual {v1, v3, v4}, Ljava/nio/channels/Selector;->select(J)I

    move-result v1
    :try_end_1
    .catch Ljava/nio/channels/ClosedSelectorException; {:try_start_1 .. :try_end_1} :catch_6
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_5

    if-nez v1, :cond_8

    move-object v1, p0

    invoke-direct/range {v1 .. v6}, Ld/q/b;->j(IJJ)I

    move-result v2

    goto/16 :goto_0

    :cond_8
    iget-object v1, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-virtual {v1}, Ljava/nio/channels/Selector;->selectedKeys()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_9
    :goto_5
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_a

    goto/16 :goto_0

    :cond_a
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/nio/channels/SelectionKey;

    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->attachment()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ld/q/b$a;

    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    invoke-static {v4}, Ld/q/b$a;->e(Ld/q/b$a;)Z

    move-result v5

    if-eqz v5, :cond_b

    goto :goto_5

    :cond_b
    :try_start_2
    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isValid()Z

    move-result v5

    if-eqz v5, :cond_c

    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isAcceptable()Z

    move-result v5

    if-eqz v5, :cond_c

    invoke-static {v4}, Ld/q/b$a;->f(Ld/q/b$a;)Ld/q/a;

    move-result-object v5

    invoke-interface {v5}, Ld/q/a;->b()V

    :cond_c
    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isValid()Z

    move-result v5

    if-eqz v5, :cond_d

    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isConnectable()Z

    move-result v5

    if-eqz v5, :cond_d

    invoke-static {v4}, Ld/q/b$a;->f(Ld/q/b$a;)Ld/q/a;

    move-result-object v5

    invoke-interface {v5}, Ld/q/a;->q()V

    :cond_d
    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isValid()Z

    move-result v5

    if-eqz v5, :cond_e

    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isWritable()Z

    move-result v5

    if-eqz v5, :cond_e

    invoke-static {v4}, Ld/q/b$a;->f(Ld/q/b$a;)Ld/q/a;

    move-result-object v5

    invoke-interface {v5}, Ld/q/a;->s()V

    :cond_e
    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isValid()Z

    move-result v5

    if-eqz v5, :cond_9

    invoke-virtual {v3}, Ljava/nio/channels/SelectionKey;->isReadable()Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-static {v4}, Ld/q/b$a;->f(Ld/q/b$a;)Ld/q/a;

    move-result-object v3

    invoke-interface {v3}, Ld/q/a;->e()V
    :try_end_2
    .catch Ljava/nio/channels/CancelledKeyException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_3

    goto :goto_5

    :catch_3
    move-exception v3

    invoke-virtual {v3}, Ljava/lang/RuntimeException;->printStackTrace()V

    goto :goto_5

    :catch_4
    move-exception v3

    invoke-virtual {v3}, Ljava/nio/channels/CancelledKeyException;->printStackTrace()V

    goto :goto_5

    :catch_5
    move-exception v0

    new-instance v1, Ld/k$b;

    invoke-direct {v1, v0}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw v1

    :catch_6
    move-exception v1

    invoke-direct {p0}, Ld/q/b;->k()V

    invoke-virtual {v1}, Ljava/nio/channels/ClosedSelectorException;->printStackTrace()V

    iget-object v1, p0, Ld/q/b;->f:Ld/c;

    invoke-virtual {v1}, Ld/c;->j()Ld/s/c;

    move-result-object v1

    const/4 v3, 0x4

    invoke-virtual {v1, v3}, Ld/s/c;->c(I)V

    goto/16 :goto_0
.end method

.method public s(Ld/q/b$a;)V
    .locals 2

    const/4 v0, 0x4

    const/4 v1, 0x1

    invoke-direct {p0, p1, v0, v1}, Ld/q/b;->l(Ld/q/b$a;IZ)V

    return-void
.end method

.method public t()V
    .locals 1

    iget-object v0, p0, Ld/q/c;->d:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public u()V
    .locals 2

    iget-object v0, p0, Ld/q/b;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/q/b;->h:Z

    iget-object v0, p0, Ld/q/b;->k:Ljava/nio/channels/Selector;

    invoke-virtual {v0}, Ljava/nio/channels/Selector;->wakeup()Ljava/nio/channels/Selector;

    return-void
.end method
