.class public Ld/n/j/e/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/j/a$a;


# instance fields
.field private a:Ljava/lang/String;

.field private final b:Ljava/net/InetSocketAddress;

.field private final c:Ljava/net/SocketAddress;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ";"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    aget-object v1, p1, v0

    invoke-virtual {p0, v1, v0, v0}, Ld/n/j/e/a;->d(Ljava/lang/String;ZZ)Ljava/net/InetSocketAddress;

    move-result-object v1

    iput-object v1, p0, Ld/n/j/e/a;->b:Ljava/net/InetSocketAddress;

    array-length v1, p1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    aget-object v2, p1, v1

    const-string v3, ""

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    aget-object p1, p1, v1

    invoke-virtual {p0, p1, v0, v0}, Ld/n/j/e/a;->d(Ljava/lang/String;ZZ)Ljava/net/InetSocketAddress;

    move-result-object p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-object p1, p0, Ld/n/j/e/a;->c:Ljava/net/SocketAddress;

    return-void
.end method


# virtual methods
.method public a()Ljava/net/SocketAddress;
    .locals 1

    iget-object v0, p0, Ld/n/j/e/a;->c:Ljava/net/SocketAddress;

    return-object v0
.end method

.method public b()Ld/n/j/c;
    .locals 1

    sget-object v0, Ld/n/j/d;->b:Ld/n/j/d;

    return-object v0
.end method

.method public c()Ljava/net/SocketAddress;
    .locals 1

    iget-object v0, p0, Ld/n/j/e/a;->b:Ljava/net/InetSocketAddress;

    return-object v0
.end method

.method public d(Ljava/lang/String;ZZ)Ljava/net/InetSocketAddress;
    .locals 0

    iput-object p1, p0, Ld/n/j/e/a;->a:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result p1

    if-gez p1, :cond_0

    neg-int p1, p1

    :cond_0
    const p2, 0xd8f0

    rem-int/2addr p1, p2

    add-int/lit16 p1, p1, 0x2710

    :try_start_0
    new-instance p2, Ljava/net/InetSocketAddress;

    const/4 p3, 0x0

    invoke-static {p3}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object p3

    invoke-direct {p2, p3, p1}, Ljava/net/InetSocketAddress;-><init>(Ljava/net/InetAddress;I)V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    move-exception p1

    new-instance p2, Ljava/lang/IllegalArgumentException;

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw p2
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Ld/n/j/e/a;->a:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, ""

    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "ipc://"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Ld/n/j/e/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
