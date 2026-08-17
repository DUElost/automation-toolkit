.class final Ld/h;
.super Ld/m;
.source ""

# interfaces
.implements Ld/q/a;
.implements Ljava/io/Closeable;


# instance fields
.field private final e:Ld/d;

.field private final f:Ld/q/b$a;

.field private final g:Ld/q/b;

.field private h:I

.field private final i:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final j:Ljava/lang/String;


# direct methods
.method constructor <init>(Ld/c;I)V
    .locals 3

    invoke-direct {p0, p1, p2}, Ld/m;-><init>(Ld/c;I)V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object v0, p0, Ld/h;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    iput v0, p0, Ld/h;->h:I

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "reaper-"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ld/h;->j:Ljava/lang/String;

    new-instance v1, Ld/q/b;

    invoke-direct {v1, p1, v0}, Ld/q/b;-><init>(Ld/c;Ljava/lang/String;)V

    iput-object v1, p0, Ld/h;->g:Ld/q/b;

    new-instance v2, Ld/d;

    invoke-direct {v2, p1, v0, p2}, Ld/d;-><init>(Ld/c;Ljava/lang/String;I)V

    iput-object v2, p0, Ld/h;->e:Ld/d;

    invoke-virtual {v2}, Ld/d;->a()Ljava/nio/channels/SelectableChannel;

    move-result-object p1

    invoke-virtual {v1, p1, p0}, Ld/q/b;->h(Ljava/nio/channels/SelectableChannel;Ld/q/a;)Ld/q/b$a;

    move-result-object p1

    iput-object p1, p0, Ld/h;->f:Ld/q/b$a;

    invoke-virtual {v1, p1}, Ld/q/b;->r(Ld/q/b$a;)V

    return-void
.end method

.method private x0()V
    .locals 2

    invoke-virtual {p0}, Ld/m;->h0()V

    iget-object v0, p0, Ld/h;->g:Ld/q/b;

    iget-object v1, p0, Ld/h;->f:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/q/b;->m(Ld/q/b$a;)V

    iget-object v0, p0, Ld/h;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->u()V

    return-void
.end method


# virtual methods
.method A0()V
    .locals 1

    iget-object v0, p0, Ld/h;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ld/m;->r0()V

    :cond_0
    return-void
.end method

.method protected S(Ld/j;)V
    .locals 1

    iget v0, p0, Ld/h;->h:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ld/h;->h:I

    iget-object v0, p0, Ld/h;->g:Ld/q/b;

    invoke-virtual {p1, v0}, Ld/j;->h1(Ld/q/b;)V

    return-void
.end method

.method protected T()V
    .locals 1

    iget v0, p0, Ld/h;->h:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/h;->h:I

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/h;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Ld/h;->x0()V

    :cond_0
    return-void
.end method

.method protected V()V
    .locals 2

    iget-object v0, p0, Ld/h;->i:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    iget v0, p0, Ld/h;->h:I

    if-nez v0, :cond_0

    invoke-direct {p0}, Ld/h;->x0()V

    :cond_0
    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public close()V
    .locals 1

    iget-object v0, p0, Ld/h;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->i()V

    iget-object v0, p0, Ld/h;->e:Ld/d;

    invoke-virtual {v0}, Ld/d;->close()V

    return-void
.end method

.method public e()V
    .locals 3

    :goto_0
    iget-object v0, p0, Ld/h;->e:Ld/d;

    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Ld/d;->b(J)Ld/a;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Ld/a;->a()V

    goto :goto_0
.end method

.method public h(I)V
    .locals 0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method public q()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public s()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method y0()Ld/d;
    .locals 1

    iget-object v0, p0, Ld/h;->e:Ld/d;

    return-object v0
.end method

.method z0()V
    .locals 1

    iget-object v0, p0, Ld/h;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->t()V

    return-void
.end method
