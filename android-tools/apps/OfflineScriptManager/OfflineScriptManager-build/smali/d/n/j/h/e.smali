.class public Ld/n/j/h/e;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/j/h/e$g;,
        Ld/n/j/h/e$h;
    }
.end annotation


# direct methods
.method public static a(Ljava/nio/channels/SelectableChannel;)V
    .locals 0

    return-void
.end method

.method public static b(Ljava/nio/channels/Channel;I)Z
    .locals 1

    new-instance v0, Ld/n/j/h/e$e;

    invoke-direct {v0, p1}, Ld/n/j/h/e$e;-><init>(I)V

    invoke-static {p0, v0}, Ld/n/j/h/e;->c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z

    move-result p0

    return p0
.end method

.method private static c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z
    .locals 1

    :try_start_0
    instance-of v0, p0, Ljava/nio/channels/ServerSocketChannel;

    if-eqz v0, :cond_0

    check-cast p0, Ljava/nio/channels/ServerSocketChannel;

    invoke-virtual {p0}, Ljava/nio/channels/ServerSocketChannel;->socket()Ljava/net/ServerSocket;

    move-result-object p0

    invoke-interface {p1, p0}, Ld/n/j/h/e$g;->b(Ljava/net/ServerSocket;)Z

    move-result p0

    return p0

    :cond_0
    instance-of v0, p0, Ljava/nio/channels/SocketChannel;

    if-eqz v0, :cond_1

    check-cast p0, Ljava/nio/channels/SocketChannel;

    invoke-virtual {p0}, Ljava/nio/channels/SocketChannel;->socket()Ljava/net/Socket;

    move-result-object p0

    invoke-interface {p1, p0}, Ld/n/j/h/e$g;->a(Ljava/net/Socket;)Z

    move-result p0
    :try_end_0
    .catch Ljava/net/SocketException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0

    :catch_0
    move-exception p0

    new-instance p1, Ld/k$b;

    invoke-direct {p1, p0}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw p1
.end method

.method public static d(Ljava/nio/channels/Channel;Z)Z
    .locals 1

    new-instance v0, Ld/n/j/h/e$f;

    invoke-direct {v0, p1}, Ld/n/j/h/e$f;-><init>(Z)V

    invoke-static {p0, v0}, Ld/n/j/h/e;->c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z

    move-result p0

    return p0
.end method

.method public static e(Ljava/nio/channels/Channel;I)Z
    .locals 1

    new-instance v0, Ld/n/j/h/e$c;

    invoke-direct {v0, p1}, Ld/n/j/h/e$c;-><init>(I)V

    invoke-static {p0, v0}, Ld/n/j/h/e;->c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z

    move-result p0

    return p0
.end method

.method public static f(Ljava/nio/channels/Channel;I)Z
    .locals 1

    new-instance v0, Ld/n/j/h/e$d;

    invoke-direct {v0, p1}, Ld/n/j/h/e$d;-><init>(I)V

    invoke-static {p0, v0}, Ld/n/j/h/e;->c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z

    move-result p0

    return p0
.end method

.method public static g(Ljava/nio/channels/SocketChannel;IIII)V
    .locals 0

    const/4 p2, 0x1

    if-ne p1, p2, :cond_0

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    new-instance p1, Ld/n/j/h/e$b;

    invoke-direct {p1, p2}, Ld/n/j/h/e$b;-><init>(Z)V

    invoke-static {p0, p1}, Ld/n/j/h/e;->c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z

    return-void
.end method

.method public static h(Ljava/nio/channels/SocketChannel;)V
    .locals 1

    new-instance v0, Ld/n/j/h/e$a;

    invoke-direct {v0}, Ld/n/j/h/e$a;-><init>()V

    invoke-static {p0, v0}, Ld/n/j/h/e;->c(Ljava/nio/channels/Channel;Ld/n/j/h/e$g;)Z

    return-void
.end method

.method public static varargs i([Ljava/nio/channels/SelectableChannel;)V
    .locals 4

    array-length v0, p0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-lt v2, v0, :cond_0

    return-void

    :cond_0
    aget-object v3, p0, v2

    invoke-virtual {v3, v1}, Ljava/nio/channels/SelectableChannel;->configureBlocking(Z)Ljava/nio/channels/SelectableChannel;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method
