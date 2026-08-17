.class public Ld/n/j/h/d;
.super Ld/g;
.source ""

# interfaces
.implements Ld/q/a;


# static fields
.field private static s:Z


# instance fields
.field private m:Ld/n/j/h/b;

.field private n:Ljava/nio/channels/ServerSocketChannel;

.field private o:Ld/q/b$a;

.field private p:Ld/j;

.field private q:Ljava/lang/String;

.field private final r:Ld/n/c;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-string v0, "os.name"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "win"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    sput-boolean v0, Ld/n/j/h/d;->s:Z

    return-void
.end method

.method public constructor <init>(Ld/n/d;Ld/j;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p3}, Ld/g;-><init>(Ld/n/d;Ld/f;)V

    new-instance p3, Ld/n/c;

    invoke-direct {p3, p1, p0}, Ld/n/c;-><init>(Ld/n/d;Ld/q/a;)V

    iput-object p3, p0, Ld/n/j/h/d;->r:Ld/n/c;

    const/4 p1, 0x0

    iput-object p1, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    iput-object p2, p0, Ld/n/j/h/d;->p:Ld/j;

    return-void
.end method

.method private H0()Ljava/nio/channels/SocketChannel;
    .locals 6

    iget-object v0, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {v0}, Ljava/nio/channels/ServerSocketChannel;->accept()Ljava/nio/channels/SocketChannel;

    move-result-object v0

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget-object v1, v1, Ld/f;->A:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    const/4 v2, 0x1

    if-nez v1, :cond_2

    const/4 v1, 0x0

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-object v3, v3, Ld/f;->A:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-nez v4, :cond_1

    goto :goto_0

    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ld/n/j/h/b$a;

    iget-object v5, p0, Ld/n/j/h/d;->m:Ld/n/j/h/b;

    invoke-virtual {v5}, Ld/n/j/h/b;->c()Ljava/net/SocketAddress;

    move-result-object v5

    invoke-virtual {v4, v5}, Ld/n/j/h/b$a;->e(Ljava/net/SocketAddress;)Z

    move-result v4

    if-eqz v4, :cond_0

    move v1, v2

    :goto_0
    if-nez v1, :cond_2

    :try_start_0
    invoke-virtual {v0}, Ljava/nio/channels/SocketChannel;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    return-object v0

    :cond_2
    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->i:I

    if-eqz v1, :cond_3

    invoke-static {v0, v1}, Ld/n/j/h/e;->b(Ljava/nio/channels/Channel;I)Z

    :cond_3
    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->g:I

    if-eqz v1, :cond_4

    invoke-static {v0, v1}, Ld/n/j/h/e;->f(Ljava/nio/channels/Channel;I)Z

    :cond_4
    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->h:I

    if-eqz v1, :cond_5

    invoke-static {v0, v1}, Ld/n/j/h/e;->e(Ljava/nio/channels/Channel;I)Z

    :cond_5
    sget-boolean v1, Ld/n/j/h/d;->s:Z

    if-nez v1, :cond_6

    invoke-static {v0, v2}, Ld/n/j/h/e;->d(Ljava/nio/channels/Channel;Z)Z

    :cond_6
    return-object v0
.end method

.method private close()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {v0}, Ljava/nio/channels/ServerSocketChannel;->close()V

    iget-object v0, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v1, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    iget-object v2, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {v0, v1, v2}, Ld/j;->V0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v2, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    invoke-static {v0}, Ld/k;->a(Ljava/io/IOException;)I

    move-result v0

    invoke-virtual {v1, v2, v0}, Ld/j;->U0(Ljava/lang/String;I)V

    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    return-void
.end method


# virtual methods
.method public I0()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ld/n/j/h/d;->m:Ld/n/j/h/b;

    invoke-virtual {v0}, Ld/n/j/h/b;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public J0(Ljava/lang/String;)Z
    .locals 4

    new-instance v0, Ld/n/j/h/b;

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget-boolean v1, v1, Ld/f;->q:Z

    invoke-direct {v0, p1, v1}, Ld/n/j/h/b;-><init>(Ljava/lang/String;Z)V

    iput-object v0, p0, Ld/n/j/h/d;->m:Ld/n/j/h/b;

    invoke-virtual {v0}, Ld/n/j/h/b;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    const/4 p1, 0x0

    :try_start_0
    invoke-static {}, Ljava/nio/channels/ServerSocketChannel;->open()Ljava/nio/channels/ServerSocketChannel;

    move-result-object v0

    iput-object v0, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/j/h/d;->m:Ld/n/j/h/b;

    invoke-virtual {v0}, Ld/n/j/h/b;->b()Ld/n/j/c;

    move-result-object v0

    sget-object v1, Ld/n/j/d;->c:Ld/n/j/d;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-boolean v0, v0, Ld/f;->q:Z

    :cond_0
    iget-object v0, p0, Ld/n/j/h/d;->m:Ld/n/j/h/b;

    invoke-virtual {v0}, Ld/n/j/h/b;->b()Ld/n/j/c;

    move-result-object v0

    sget-object v1, Ld/n/j/d;->c:Ld/n/j/d;

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-static {v0}, Ld/n/j/h/e;->a(Ljava/nio/channels/SelectableChannel;)V

    :cond_1
    const/4 v0, 0x1

    new-array v1, v0, [Ljava/nio/channels/SelectableChannel;

    iget-object v2, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    aput-object v2, v1, p1

    invoke-static {v1}, Ld/n/j/h/e;->i([Ljava/nio/channels/SelectableChannel;)V

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->g:I

    if-eqz v1, :cond_2

    iget-object v2, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-static {v2, v1}, Ld/n/j/h/e;->f(Ljava/nio/channels/Channel;I)Z

    :cond_2
    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->h:I

    if-eqz v1, :cond_3

    iget-object v2, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-static {v2, v1}, Ld/n/j/h/e;->e(Ljava/nio/channels/Channel;I)Z

    :cond_3
    sget-boolean v1, Ld/n/j/h/d;->s:Z

    if-nez v1, :cond_4

    iget-object v1, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-static {v1, v0}, Ld/n/j/h/e;->d(Ljava/nio/channels/Channel;Z)Z

    :cond_4
    iget-object v1, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {v1}, Ljava/nio/channels/ServerSocketChannel;->socket()Ljava/net/ServerSocket;

    move-result-object v1

    iget-object v2, p0, Ld/n/j/h/d;->m:Ld/n/j/h/b;

    invoke-virtual {v2}, Ld/n/j/h/b;->c()Ljava/net/SocketAddress;

    move-result-object v2

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget v3, v3, Ld/f;->n:I

    invoke-virtual {v1, v2, v3}, Ljava/net/ServerSocket;->bind(Ljava/net/SocketAddress;I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    iget-object p1, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v1, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    iget-object v2, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {p1, v1, v2}, Ld/j;->b1(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V

    return v0

    :catch_0
    invoke-direct {p0}, Ld/n/j/h/d;->close()V

    iget-object v0, p0, Ld/g;->l:Ld/s/c;

    const/16 v1, 0x30

    invoke-virtual {v0, v1}, Ld/s/c;->c(I)V

    return p1
.end method

.method protected R()V
    .locals 2

    iget-object v0, p0, Ld/n/j/h/d;->r:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->f()V

    iget-object v0, p0, Ld/n/j/h/d;->r:Ld/n/c;

    iget-object v1, p0, Ld/n/j/h/d;->n:Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {v0, v1}, Ld/n/c;->a(Ljava/nio/channels/SelectableChannel;)Ld/q/b$a;

    move-result-object v0

    iput-object v0, p0, Ld/n/j/h/d;->o:Ld/q/b$a;

    iget-object v1, p0, Ld/n/j/h/d;->r:Ld/n/c;

    invoke-virtual {v1, v0}, Ld/n/c;->k(Ld/q/b$a;)V

    return-void
.end method

.method protected W(I)V
    .locals 2

    iget-object v0, p0, Ld/n/j/h/d;->r:Ld/n/c;

    iget-object v1, p0, Ld/n/j/h/d;->o:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->g(Ld/q/b$a;)V

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/j/h/d;->o:Ld/q/b$a;

    invoke-direct {p0}, Ld/n/j/h/d;->close()V

    invoke-super {p0, p1}, Ld/g;->W(I)V

    return-void
.end method

.method public b()V
    .locals 7

    :try_start_0
    invoke-direct {p0}, Ld/n/j/h/d;->H0()Ljava/nio/channels/SocketChannel;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v1, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    const/16 v2, 0x31

    invoke-virtual {v0, v1, v2}, Ld/j;->R0(Ljava/lang/String;I)V

    return-void

    :cond_0
    invoke-static {v0}, Ld/n/j/h/e;->h(Ljava/nio/channels/SocketChannel;)V

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v2, v1, Ld/f;->w:I

    iget v3, v1, Ld/f;->x:I

    iget v4, v1, Ld/f;->y:I

    iget v1, v1, Ld/f;->z:I

    invoke-static {v0, v2, v3, v4, v1}, Ld/n/j/h/e;->g(Ljava/nio/channels/SocketChannel;IIII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v1, Ld/n/g;

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget-object v3, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    invoke-direct {v1, v0, v2, v3}, Ld/n/g;-><init>(Ljava/nio/channels/SocketChannel;Ld/f;Ljava/lang/String;)V
    :try_end_1
    .catch Ld/k$c; {:try_start_1 .. :try_end_1} :catch_0

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget-wide v2, v2, Ld/f;->c:J

    invoke-virtual {p0, v2, v3}, Ld/m;->C(J)Ld/n/d;

    move-result-object v2

    iget-object v3, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v4, p0, Ld/g;->e:Ld/f;

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static {v2, v6, v3, v4, v5}, Ld/r/d;->e(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)Ld/n/f;

    move-result-object v2

    invoke-virtual {v2}, Ld/n/f;->z0()V

    invoke-virtual {p0, v2}, Ld/g;->B0(Ld/g;)V

    invoke-virtual {p0, v2, v1, v6}, Ld/m;->d0(Ld/n/f;Ld/n/b;Z)V

    iget-object v1, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v2, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Ld/j;->S0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V

    return-void

    :catch_0
    iget-object v0, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v1, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    const/16 v2, 0x16

    invoke-virtual {v0, v1, v2}, Ld/j;->R0(Ljava/lang/String;I)V

    return-void

    :catch_1
    move-exception v0

    iget-object v1, p0, Ld/n/j/h/d;->p:Ld/j;

    iget-object v2, p0, Ld/n/j/h/d;->q:Ljava/lang/String;

    invoke-static {v0}, Ld/k;->a(Ljava/io/IOException;)I

    move-result v0

    invoke-virtual {v1, v2, v0}, Ld/j;->R0(Ljava/lang/String;I)V

    return-void
.end method

.method public e()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
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

.method public y0()V
    .locals 1

    iget-object v0, p0, Ld/n/j/h/d;->r:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->o()V

    return-void
.end method
