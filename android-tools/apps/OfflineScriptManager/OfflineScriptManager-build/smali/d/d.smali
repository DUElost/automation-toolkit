.class public final Ld/d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Closeable;


# instance fields
.field private final b:Ld/p/c;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/c<",
            "Ld/a;",
            ">;"
        }
    .end annotation
.end field

.field private final c:Ld/i;

.field private final d:Ljava/util/concurrent/locks/Lock;

.field private e:Z

.field private final f:Ljava/lang/String;

.field private final g:Ld/s/c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/d;

    return-void
.end method

.method public constructor <init>(Ld/c;Ljava/lang/String;I)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Ld/c;->j()Ld/s/c;

    move-result-object v0

    iput-object v0, p0, Ld/d;->g:Ld/s/c;

    new-instance v1, Ld/p/c;

    sget-object v2, Ld/b;->d:Ld/b;

    invoke-virtual {v2}, Ld/b;->a()I

    move-result v2

    invoke-direct {v1, v2}, Ld/p/c;-><init>(I)V

    iput-object v1, p0, Ld/d;->b:Ld/p/c;

    new-instance v2, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v2}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v2, p0, Ld/d;->d:Ljava/util/concurrent/locks/Lock;

    new-instance v2, Ld/i;

    invoke-direct {v2, p1, p3, v0}, Ld/i;-><init>(Ld/c;ILd/s/c;)V

    iput-object v2, p0, Ld/d;->c:Ld/i;

    invoke-virtual {v1}, Ld/p/c;->d()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/a;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/d;->e:Z

    iput-object p2, p0, Ld/d;->f:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a()Ljava/nio/channels/SelectableChannel;
    .locals 1

    iget-object v0, p0, Ld/d;->c:Ld/i;

    invoke-virtual {v0}, Ld/i;->a()Ljava/nio/channels/SelectableChannel;

    move-result-object v0

    return-object v0
.end method

.method public b(J)Ld/a;
    .locals 1

    iget-boolean v0, p0, Ld/d;->e:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/d;->b:Ld/p/c;

    invoke-virtual {v0}, Ld/p/c;->d()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/a;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/d;->e:Z

    :cond_1
    iget-object v0, p0, Ld/d;->c:Ld/i;

    invoke-virtual {v0, p1, p2}, Ld/i;->h(J)Z

    move-result p1

    if-nez p1, :cond_2

    const/4 p1, 0x0

    return-object p1

    :cond_2
    iget-object p1, p0, Ld/d;->c:Ld/i;

    invoke-virtual {p1}, Ld/i;->b()V

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/d;->e:Z

    iget-object p1, p0, Ld/d;->b:Ld/p/c;

    invoke-virtual {p1}, Ld/p/c;->d()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/a;

    return-object p1
.end method

.method public close()V
    .locals 1

    iget-object v0, p0, Ld/d;->d:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    iget-object v0, p0, Ld/d;->d:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    iget-object v0, p0, Ld/d;->c:Ld/i;

    invoke-virtual {v0}, Ld/i;->close()V

    return-void
.end method

.method e(Ld/a;)V
    .locals 2

    iget-object v0, p0, Ld/d;->d:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/d;->b:Ld/p/c;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Ld/p/c;->b(Ljava/lang/Object;Z)V

    iget-object p1, p0, Ld/d;->b:Ld/p/c;

    invoke-virtual {p1}, Ld/p/c;->flush()Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Ld/d;->d:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    if-nez p1, :cond_0

    iget-object p1, p0, Ld/d;->c:Ld/i;

    invoke-virtual {p1}, Ld/i;->e()V

    :cond_0
    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Ld/d;->d:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/d;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
