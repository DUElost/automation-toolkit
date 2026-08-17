.class public Ld/n/j/a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/j/a$a;
    }
.end annotation


# instance fields
.field private final a:Ld/n/j/b;

.field private final b:Ljava/lang/String;

.field private c:Ld/n/j/a$a;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Ld/n/j/b;->b(Ljava/lang/String;)Ld/n/j/b;

    move-result-object p1

    iput-object p1, p0, Ld/n/j/a;->a:Ld/n/j/b;

    iput-object p2, p0, Ld/n/j/a;->b:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    return-void
.end method

.method public constructor <init>(Ljava/net/SocketAddress;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

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

    iput-object p1, p0, Ld/n/j/a;->b:Ljava/lang/String;

    sget-object p1, Ld/n/j/b;->f:Ld/n/j/b;

    iput-object p1, p0, Ld/n/j/a;->a:Ld/n/j/b;

    const/4 p1, 0x0

    iput-object p1, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ld/n/j/a;->b:Ljava/lang/String;

    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Ld/n/j/a;->b:Ljava/lang/String;

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v0

    if-lez v0, :cond_0

    iget-object v1, p0, Ld/n/j/a;->b:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Ld/n/j/a;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c()Z
    .locals 1

    iget-object v0, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public d()Ld/n/j/b;
    .locals 1

    iget-object v0, p0, Ld/n/j/a;->a:Ld/n/j/b;

    return-object v0
.end method

.method public e(Z)Ld/n/j/a$a;
    .locals 2

    sget-object v0, Ld/n/j/b;->f:Ld/n/j/b;

    iget-object v1, p0, Ld/n/j/a;->a:Ld/n/j/b;

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ld/n/j/h/b;

    iget-object v1, p0, Ld/n/j/a;->b:Ljava/lang/String;

    invoke-direct {v0, v1, p1}, Ld/n/j/h/b;-><init>(Ljava/lang/String;Z)V

    iput-object v0, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    return-object v0

    :cond_0
    sget-object p1, Ld/n/j/b;->e:Ld/n/j/b;

    iget-object v0, p0, Ld/n/j/a;->a:Ld/n/j/b;

    invoke-virtual {p1, v0}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    new-instance p1, Ld/n/j/e/a;

    iget-object v0, p0, Ld/n/j/a;->b:Ljava/lang/String;

    invoke-direct {p1, v0}, Ld/n/j/e/a;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    return-object p1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public f()Ld/n/j/a$a;
    .locals 1

    iget-object v0, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    sget-object v0, Ld/n/j/b;->f:Ld/n/j/b;

    iget-object v1, p0, Ld/n/j/a;->a:Ld/n/j/b;

    if-ne v0, v1, :cond_0

    invoke-virtual {p0}, Ld/n/j/a;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    invoke-interface {v0}, Ld/n/j/a$a;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    sget-object v0, Ld/n/j/b;->e:Ld/n/j/b;

    iget-object v1, p0, Ld/n/j/a;->a:Ld/n/j/b;

    if-ne v0, v1, :cond_1

    invoke-virtual {p0}, Ld/n/j/a;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/n/j/a;->c:Ld/n/j/a$a;

    invoke-interface {v0}, Ld/n/j/a$a;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_1
    iget-object v0, p0, Ld/n/j/a;->a:Ld/n/j/b;

    if-eqz v0, :cond_2

    iget-object v0, p0, Ld/n/j/a;->b:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/n/j/a;->a:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/n/j/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_2
    const-string v0, ""

    return-object v0
.end method
