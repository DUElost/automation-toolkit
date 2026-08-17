.class Ld/n/j/h/e$a;
.super Ld/n/j/h/e$h;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ld/n/j/h/e;->h(Ljava/nio/channels/SocketChannel;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Ld/n/j/h/e$h;-><init>(Ld/n/j/h/e$h;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/net/Socket;)Z
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljava/net/Socket;->setTcpNoDelay(Z)V

    return v0
.end method
