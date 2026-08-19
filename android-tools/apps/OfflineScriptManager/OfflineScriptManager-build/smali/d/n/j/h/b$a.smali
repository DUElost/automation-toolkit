.class public Ld/n/j/h/b$a;
.super Ld/n/j/h/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/j/h/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# direct methods
.method public constructor <init>(Ljava/lang/String;Z)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/j/h/b;-><init>(Ljava/lang/String;Z)V

    return-void
.end method


# virtual methods
.method public e(Ljava/net/SocketAddress;)Z
    .locals 1

    invoke-virtual {p0}, Ld/n/j/h/b;->c()Ljava/net/SocketAddress;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method
