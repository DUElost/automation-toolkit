.class Ld/n/j/h/e$f;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/j/h/e$g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ld/n/j/h/e;->d(Ljava/nio/channels/Channel;Z)Z
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

    iput-boolean p1, p0, Ld/n/j/h/e$f;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/net/Socket;)Z
    .locals 1

    iget-boolean v0, p0, Ld/n/j/h/e$f;->a:Z

    invoke-virtual {p1, v0}, Ljava/net/Socket;->setReuseAddress(Z)V

    const/4 p1, 0x1

    return p1
.end method

.method public b(Ljava/net/ServerSocket;)Z
    .locals 1

    iget-boolean v0, p0, Ld/n/j/h/e$f;->a:Z

    invoke-virtual {p1, v0}, Ljava/net/ServerSocket;->setReuseAddress(Z)V

    const/4 p1, 0x1

    return p1
.end method
