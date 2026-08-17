.class Ld/n/j/h/e$b;
.super Ld/n/j/h/e$h;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ld/n/j/h/e;->g(Ljava/nio/channels/SocketChannel;IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic a:Z


# direct methods
.method constructor <init>(Z)V
    .locals 0

    iput-boolean p1, p0, Ld/n/j/h/e$b;->a:Z

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Ld/n/j/h/e$h;-><init>(Ld/n/j/h/e$h;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/net/Socket;)Z
    .locals 1

    iget-boolean v0, p0, Ld/n/j/h/e$b;->a:Z

    invoke-virtual {p1, v0}, Ljava/net/Socket;->setKeepAlive(Z)V

    const/4 p1, 0x1

    return p1
.end method
