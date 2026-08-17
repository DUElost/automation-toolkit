.class public Ld/s/e;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final a:Ljava/security/SecureRandom;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/security/SecureRandom;

    invoke-direct {v0}, Ljava/security/SecureRandom;-><init>()V

    sput-object v0, Ld/s/e;->a:Ljava/security/SecureRandom;

    return-void
.end method

.method public static a(Ljava/nio/channels/SocketChannel;)Ld/n/j/a;
    .locals 1

    invoke-virtual {p0}, Ljava/nio/channels/SocketChannel;->socket()Ljava/net/Socket;

    move-result-object p0

    invoke-virtual {p0}, Ljava/net/Socket;->getRemoteSocketAddress()Ljava/net/SocketAddress;

    move-result-object p0

    new-instance v0, Ld/n/j/a;

    invoke-direct {v0, p0}, Ld/n/j/a;-><init>(Ljava/net/SocketAddress;)V

    return-object v0
.end method

.method public static b(I)[B
    .locals 1

    new-array p0, p0, [B

    sget-object v0, Ld/s/e;->a:Ljava/security/SecureRandom;

    invoke-virtual {v0, p0}, Ljava/security/SecureRandom;->nextBytes([B)V

    return-object p0
.end method

.method public static c()I
    .locals 1

    sget-object v0, Ld/s/e;->a:Ljava/security/SecureRandom;

    invoke-virtual {v0}, Ljava/security/SecureRandom;->nextInt()I

    move-result v0

    return v0
.end method

.method public static d([BI)[B
    .locals 2

    new-array p1, p1, [B

    if-eqz p0, :cond_0

    array-length v0, p0

    const/4 v1, 0x0

    invoke-static {p0, v1, p1, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_0
    return-object p1
.end method

.method public static e(Ljava/lang/Class;[Ljava/lang/Object;IZ)[Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;[TT;IZ)[TT;"
        }
    .end annotation

    array-length v0, p1

    const/4 v1, 0x0

    if-le p2, v0, :cond_1

    invoke-static {p0, p2}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Ljava/lang/Object;

    if-eqz p3, :cond_0

    array-length p2, p1

    invoke-static {p1, v1, p0, v1, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0

    :cond_0
    array-length p3, p1

    sub-int/2addr p2, p3

    array-length p3, p1

    invoke-static {p1, v1, p0, p2, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :goto_0
    move-object p1, p0

    goto :goto_1

    :cond_1
    array-length v0, p1

    if-ge p2, v0, :cond_3

    invoke-static {p0, p2}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Ljava/lang/Object;

    if-eqz p3, :cond_2

    array-length p3, p1

    sub-int/2addr p3, p2

    invoke-static {p1, p3, p0, v1, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0

    :cond_2
    invoke-static {p1, v1, p0, v1, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0

    :cond_3
    :goto_1
    return-object p1
.end method

.method public static varargs f([Ljava/nio/channels/SelectableChannel;)V
    .locals 0

    invoke-static {p0}, Ld/n/j/h/e;->i([Ljava/nio/channels/SelectableChannel;)V

    return-void
.end method
