.class public Ld/n/j/e/c;
.super Ld/n/j/h/d;
.source ""


# instance fields
.field private t:Ld/n/j/e/a;


# direct methods
.method public constructor <init>(Ld/n/d;Ld/j;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/n/j/h/d;-><init>(Ld/n/d;Ld/j;Ld/f;)V

    return-void
.end method


# virtual methods
.method public I0()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ld/n/j/e/c;->t:Ld/n/j/e/a;

    invoke-virtual {v0}, Ld/n/j/e/a;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public J0(Ljava/lang/String;)Z
    .locals 2

    new-instance v0, Ld/n/j/e/a;

    invoke-direct {v0, p1}, Ld/n/j/e/a;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ld/n/j/e/c;->t:Ld/n/j/e/a;

    invoke-virtual {v0}, Ld/n/j/e/a;->c()Ljava/net/SocketAddress;

    move-result-object p1

    check-cast p1, Ljava/net/InetSocketAddress;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/net/InetSocketAddress;->getPort()I

    move-result p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-super {p0, p1}, Ld/n/j/h/d;->J0(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method
