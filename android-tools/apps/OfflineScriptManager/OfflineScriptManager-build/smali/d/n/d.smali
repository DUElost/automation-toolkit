.class public Ld/n/d;
.super Ld/m;
.source ""

# interfaces
.implements Ld/q/a;
.implements Ljava/io/Closeable;


# instance fields
.field private final e:Ld/d;

.field private final f:Ld/q/b$a;

.field private final g:Ld/q/b;

.field private final h:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/n/d;

    return-void
.end method

.method public constructor <init>(Ld/c;I)V
    .locals 3

    invoke-direct {p0, p1, p2}, Ld/m;-><init>(Ld/c;I)V

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "iothread-"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ld/n/d;->h:Ljava/lang/String;

    new-instance v1, Ld/q/b;

    invoke-direct {v1, p1, v0}, Ld/q/b;-><init>(Ld/c;Ljava/lang/String;)V

    iput-object v1, p0, Ld/n/d;->g:Ld/q/b;

    new-instance v2, Ld/d;

    invoke-direct {v2, p1, v0, p2}, Ld/d;-><init>(Ld/c;Ljava/lang/String;I)V

    iput-object v2, p0, Ld/n/d;->e:Ld/d;

    invoke-virtual {v2}, Ld/d;->a()Ljava/nio/channels/SelectableChannel;

    move-result-object p1

    invoke-virtual {v1, p1, p0}, Ld/q/b;->h(Ljava/nio/channels/SelectableChannel;Ld/q/a;)Ld/q/b$a;

    move-result-object p1

    iput-object p1, p0, Ld/n/d;->f:Ld/q/b$a;

    invoke-virtual {v1, p1}, Ld/q/b;->r(Ld/q/b$a;)V

    return-void
.end method


# virtual methods
.method public A0()V
    .locals 1

    iget-object v0, p0, Ld/n/d;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->t()V

    return-void
.end method

.method public B0()V
    .locals 0

    invoke-virtual {p0}, Ld/m;->r0()V

    return-void
.end method

.method protected V()V
    .locals 2

    iget-object v0, p0, Ld/n/d;->g:Ld/q/b;

    iget-object v1, p0, Ld/n/d;->f:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/q/b;->m(Ld/q/b$a;)V

    iget-object v0, p0, Ld/n/d;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->u()V

    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public close()V
    .locals 1

    iget-object v0, p0, Ld/n/d;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->i()V

    iget-object v0, p0, Ld/n/d;->e:Ld/d;

    invoke-virtual {v0}, Ld/d;->close()V

    return-void
.end method

.method public e()V
    .locals 3

    :goto_0
    iget-object v0, p0, Ld/n/d;->e:Ld/d;

    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Ld/d;->b(J)Ld/a;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Ld/a;->a()V

    goto :goto_0
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

.method public x0()I
    .locals 1

    iget-object v0, p0, Ld/n/d;->g:Ld/q/b;

    invoke-virtual {v0}, Ld/q/b;->g()I

    move-result v0

    return v0
.end method

.method public y0()Ld/d;
    .locals 1

    iget-object v0, p0, Ld/n/d;->e:Ld/d;

    return-object v0
.end method

.method z0()Ld/q/b;
    .locals 1

    iget-object v0, p0, Ld/n/d;->g:Ld/q/b;

    return-object v0
.end method
