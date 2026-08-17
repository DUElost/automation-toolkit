.class public Ld/n/j/h/c;
.super Ld/g;
.source ""

# interfaces
.implements Ld/q/a;


# instance fields
.field protected final m:Ld/n/c;

.field private final n:Ld/n/j/a;

.field private o:Ljava/nio/channels/SocketChannel;

.field private p:Ld/q/b$a;

.field protected final q:Z

.field private r:Z

.field private final s:Ld/n/f;

.field private t:I

.field private final u:Ld/j;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V
    .locals 0

    invoke-direct {p0, p1, p3}, Ld/g;-><init>(Ld/n/d;Ld/f;)V

    new-instance p3, Ld/n/c;

    invoke-direct {p3, p1, p0}, Ld/n/c;-><init>(Ld/n/d;Ld/q/a;)V

    iput-object p3, p0, Ld/n/j/h/c;->m:Ld/n/c;

    iput-object p4, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    const/4 p1, 0x0

    iput-object p1, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    iput-boolean p5, p0, Ld/n/j/h/c;->q:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/n/j/h/c;->r:Z

    iput-object p2, p0, Ld/n/j/h/c;->s:Ld/n/f;

    iget-object p1, p0, Ld/g;->e:Ld/f;

    iget p1, p1, Ld/f;->l:I

    iput p1, p0, Ld/n/j/h/c;->t:I

    invoke-virtual {p4}, Ld/n/j/a;->toString()Ljava/lang/String;

    invoke-virtual {p2}, Ld/n/f;->N0()Ld/j;

    move-result-object p1

    iput-object p1, p0, Ld/n/j/h/c;->u:Ld/j;

    return-void
.end method

.method private H0()V
    .locals 5

    invoke-direct {p0}, Ld/n/j/h/c;->J0()I

    move-result v0

    iget-object v1, p0, Ld/n/j/h/c;->m:Ld/n/c;

    int-to-long v2, v0

    const/4 v4, 0x1

    invoke-virtual {v1, v2, v3, v4}, Ld/n/c;->c(JI)V

    :try_start_0
    iget-object v1, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget-boolean v2, v2, Ld/f;->q:Z

    invoke-virtual {v1, v2}, Ld/n/j/a;->e(Z)Ld/n/j/a$a;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v1, p0, Ld/n/j/h/c;->u:Ld/j;

    iget-object v2, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v2}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ld/j;->X0(Ljava/lang/String;I)V

    iput-boolean v4, p0, Ld/n/j/h/c;->r:Z

    return-void
.end method

.method private I0()Ljava/nio/channels/SocketChannel;
    .locals 1

    :try_start_0
    iget-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0}, Ljava/nio/channels/SocketChannel;->finishConnect()Z

    iget-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private J0()I
    .locals 4

    iget v0, p0, Ld/n/j/h/c;->t:I

    invoke-static {}, Ld/s/e;->c()I

    move-result v1

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget v3, v2, Ld/f;->l:I

    rem-int/2addr v1, v3

    add-int/2addr v0, v1

    iget v1, v2, Ld/f;->m:I

    if-lez v1, :cond_0

    if-le v1, v3, :cond_0

    iget v2, p0, Ld/n/j/h/c;->t:I

    mul-int/lit8 v2, v2, 0x2

    invoke-static {v2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    iput v1, p0, Ld/n/j/h/c;->t:I

    :cond_0
    return v0
.end method

.method private K0()Z
    .locals 5

    iget-object v0, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    if-eqz v0, :cond_9

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget-boolean v1, v1, Ld/f;->q:Z

    invoke-virtual {v0, v1}, Ld/n/j/a;->e(Z)Ld/n/j/a$a;

    iget-object v0, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v0}, Ld/n/j/a;->f()Ld/n/j/a$a;

    move-result-object v0

    if-eqz v0, :cond_8

    invoke-interface {v0}, Ld/n/j/a$a;->c()Ljava/net/SocketAddress;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-static {}, Ljava/nio/channels/SocketChannel;->open()Ljava/nio/channels/SocketChannel;

    move-result-object v2

    iput-object v2, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    const/4 v3, 0x0

    if-nez v2, :cond_1

    invoke-interface {v0}, Ld/n/j/a$a;->b()Ld/n/j/c;

    move-result-object v2

    sget-object v4, Ld/n/j/d;->c:Ld/n/j/d;

    if-ne v2, v4, :cond_1

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget-boolean v2, v2, Ld/f;->q:Z

    if-eqz v2, :cond_1

    iget-object v0, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v0, v3}, Ld/n/j/a;->e(Z)Ld/n/j/a$a;

    move-result-object v0

    if-nez v0, :cond_0

    return v3

    :cond_0
    invoke-interface {v0}, Ld/n/j/a$a;->c()Ljava/net/SocketAddress;

    move-result-object v1

    invoke-static {}, Ljava/nio/channels/SocketChannel;->open()Ljava/nio/channels/SocketChannel;

    move-result-object v2

    iput-object v2, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    :cond_1
    invoke-interface {v0}, Ld/n/j/a$a;->b()Ld/n/j/c;

    move-result-object v2

    sget-object v4, Ld/n/j/d;->c:Ld/n/j/d;

    if-ne v2, v4, :cond_2

    iget-object v2, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-static {v2}, Ld/n/j/h/e;->a(Ljava/nio/channels/SelectableChannel;)V

    :cond_2
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/nio/channels/SelectableChannel;

    iget-object v4, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    aput-object v4, v2, v3

    invoke-static {v2}, Ld/n/j/h/e;->i([Ljava/nio/channels/SelectableChannel;)V

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget v2, v2, Ld/f;->g:I

    if-eqz v2, :cond_3

    iget-object v3, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-static {v3, v2}, Ld/n/j/h/e;->f(Ljava/nio/channels/Channel;I)Z

    :cond_3
    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget v2, v2, Ld/f;->h:I

    if-eqz v2, :cond_4

    iget-object v3, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-static {v3, v2}, Ld/n/j/h/e;->e(Ljava/nio/channels/Channel;I)Z

    :cond_4
    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget v2, v2, Ld/f;->i:I

    if-eqz v2, :cond_5

    iget-object v3, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-static {v3, v2}, Ld/n/j/h/e;->b(Ljava/nio/channels/Channel;I)Z

    :cond_5
    invoke-interface {v0}, Ld/n/j/a$a;->a()Ljava/net/SocketAddress;

    :try_start_0
    iget-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0, v1}, Ljava/nio/channels/SocketChannel;->connect(Ljava/net/SocketAddress;)Z

    move-result v0

    if-nez v0, :cond_6

    iget-object v1, p0, Ld/g;->l:Ld/s/c;

    const/16 v2, 0x24

    invoke-virtual {v1, v2}, Ld/s/c;->c(I)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_6
    return v0

    :catch_0
    move-exception v0

    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    :cond_7
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Socket address not resolved"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_8
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Address not resolved"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_9
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Null address"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private L0()V
    .locals 3

    :try_start_0
    invoke-direct {p0}, Ld/n/j/h/c;->K0()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    iget-object v1, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0, v1}, Ld/n/c;->a(Ljava/nio/channels/SelectableChannel;)Ld/q/b$a;

    move-result-object v0

    iput-object v0, p0, Ld/n/j/h/c;->p:Ld/q/b$a;

    invoke-virtual {p0}, Ld/n/j/h/c;->q()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    iget-object v1, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0, v1}, Ld/n/c;->a(Ljava/nio/channels/SelectableChannel;)Ld/q/b$a;

    move-result-object v0

    iput-object v0, p0, Ld/n/j/h/c;->p:Ld/q/b$a;

    iget-object v1, p0, Ld/n/j/h/c;->m:Ld/n/c;

    invoke-virtual {v1, v0}, Ld/n/c;->l(Ld/q/b$a;)V

    iget-object v0, p0, Ld/n/j/h/c;->u:Ld/j;

    iget-object v1, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v1}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Ld/j;->W0(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Ld/n/j/h/c;->close()V

    :cond_1
    invoke-direct {p0}, Ld/n/j/h/c;->H0()V

    :goto_0
    return-void
.end method


# virtual methods
.method protected R()V
    .locals 1

    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->f()V

    iget-boolean v0, p0, Ld/n/j/h/c;->q:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Ld/n/j/h/c;->H0()V

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Ld/n/j/h/c;->L0()V

    :goto_0
    return-void
.end method

.method protected W(I)V
    .locals 2

    iget-boolean v0, p0, Ld/n/j/h/c;->r:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ld/n/c;->d(I)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/n/j/h/c;->r:Z

    :cond_0
    iget-object v0, p0, Ld/n/j/h/c;->p:Ld/q/b$a;

    if-eqz v0, :cond_1

    iget-object v1, p0, Ld/n/j/h/c;->m:Ld/n/c;

    invoke-virtual {v1, v0}, Ld/n/c;->g(Ld/q/b$a;)V

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/j/h/c;->p:Ld/q/b$a;

    :cond_1
    iget-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Ld/n/j/h/c;->close()V

    :cond_2
    invoke-super {p0, p1}, Ld/g;->W(I)V

    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method protected close()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0}, Ljava/nio/channels/SocketChannel;->close()V

    iget-object v0, p0, Ld/n/j/h/c;->u:Ld/j;

    iget-object v1, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v1}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0, v1, v2}, Ld/j;->V0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Ld/n/j/h/c;->u:Ld/j;

    iget-object v2, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v2}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0}, Ld/k;->a(Ljava/io/IOException;)I

    move-result v0

    invoke-virtual {v1, v2, v0}, Ld/j;->U0(Ljava/lang/String;I)V

    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    return-void
.end method

.method public e()V
    .locals 0

    return-void
.end method

.method public h(I)V
    .locals 0

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/n/j/h/c;->r:Z

    invoke-direct {p0}, Ld/n/j/h/c;->L0()V

    return-void
.end method

.method public q()V
    .locals 6

    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    iget-object v1, p0, Ld/n/j/h/c;->p:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->g(Ld/q/b$a;)V

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/j/h/c;->p:Ld/q/b$a;

    invoke-direct {p0}, Ld/n/j/h/c;->I0()Ljava/nio/channels/SocketChannel;

    move-result-object v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Ld/n/j/h/c;->close()V

    invoke-direct {p0}, Ld/n/j/h/c;->H0()V

    return-void

    :cond_0
    :try_start_0
    invoke-static {v1}, Ld/n/j/h/e;->h(Ljava/nio/channels/SocketChannel;)V

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget v3, v2, Ld/f;->w:I

    iget v4, v2, Ld/f;->x:I

    iget v5, v2, Ld/f;->y:I

    iget v2, v2, Ld/f;->z:I

    invoke-static {v1, v3, v4, v5, v2}, Ld/n/j/h/e;->g(Ljava/nio/channels/SocketChannel;IIII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v2, Ld/n/g;

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-object v4, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v4}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v1, v3, v4}, Ld/n/g;-><init>(Ljava/nio/channels/SocketChannel;Ld/f;Ljava/lang/String;)V
    :try_end_1
    .catch Ld/k$c; {:try_start_1 .. :try_end_1} :catch_0

    iput-object v0, p0, Ld/n/j/h/c;->o:Ljava/nio/channels/SocketChannel;

    iget-object v0, p0, Ld/n/j/h/c;->s:Ld/n/f;

    invoke-virtual {p0, v0, v2}, Ld/m;->c0(Ld/n/f;Ld/n/b;)V

    invoke-virtual {p0}, Ld/g;->F0()V

    iget-object v0, p0, Ld/n/j/h/c;->u:Ld/j;

    iget-object v2, p0, Ld/n/j/h/c;->n:Ld/n/j/a;

    invoke-virtual {v2}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Ld/j;->Y0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V

    :catch_0
    return-void

    :catch_1
    move-exception v0

    new-instance v1, Ld/k$b;

    invoke-direct {v1, v0}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public s()V
    .locals 0

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->J:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected y0()V
    .locals 1

    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->o()V

    return-void
.end method
