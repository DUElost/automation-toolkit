.class public Ld/p/c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/p/d;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Ld/p/d<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private final a:Ld/p/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f<",
            "TT;>;"
        }
    .end annotation
.end field

.field private b:I

.field private c:I

.field private d:I

.field private final e:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(I)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ld/p/f;

    invoke-direct {v0, p1}, Ld/p/f;-><init>(I)V

    iput-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0}, Ld/p/f;->b()I

    move-result p1

    iput p1, p0, Ld/p/c;->d:I

    iput p1, p0, Ld/p/c;->c:I

    iput p1, p0, Ld/p/c;->b:I

    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0, p1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Ld/p/c;->e:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    invoke-virtual {p0}, Ld/p/c;->c()Z

    iget-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0}, Ld/p/f;->c()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public b(Ljava/lang/Object;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;Z)V"
        }
    .end annotation

    iget-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0, p1}, Ld/p/f;->f(Ljava/lang/Object;)V

    if-nez p2, :cond_0

    iget-object p1, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {p1}, Ld/p/f;->b()I

    move-result p1

    iput p1, p0, Ld/p/c;->d:I

    :cond_0
    return-void
.end method

.method public c()Z
    .locals 4

    iget-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0}, Ld/p/f;->d()I

    move-result v0

    iget v1, p0, Ld/p/c;->c:I

    const/4 v2, 0x1

    if-eq v0, v1, :cond_0

    return v2

    :cond_0
    iget-object v1, p0, Ld/p/c;->e:Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v3, -0x1

    invoke-virtual {v1, v0, v3}, Ljava/util/concurrent/atomic/AtomicInteger;->compareAndSet(II)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Ld/p/c;->e:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v1

    iput v1, p0, Ld/p/c;->c:I

    :cond_1
    iget v1, p0, Ld/p/c;->c:I

    if-eq v0, v1, :cond_3

    if-ne v1, v3, :cond_2

    goto :goto_0

    :cond_2
    return v2

    :cond_3
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public d()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    invoke-virtual {p0}, Ld/p/c;->c()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0}, Ld/p/f;->e()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public e()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget v0, p0, Ld/p/c;->d:I

    iget-object v1, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v1}, Ld/p/f;->b()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0}, Ld/p/f;->g()V

    iget-object v0, p0, Ld/p/c;->a:Ld/p/f;

    invoke-virtual {v0}, Ld/p/f;->a()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public flush()Z
    .locals 4

    iget v0, p0, Ld/p/c;->b:I

    iget v1, p0, Ld/p/c;->d:I

    const/4 v2, 0x1

    if-ne v0, v1, :cond_0

    return v2

    :cond_0
    iget-object v3, p0, Ld/p/c;->e:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v3, v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;->compareAndSet(II)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/p/c;->e:Ljava/util/concurrent/atomic/AtomicInteger;

    iget v1, p0, Ld/p/c;->d:I

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;->set(I)V

    iget v0, p0, Ld/p/c;->d:I

    iput v0, p0, Ld/p/c;->b:I

    const/4 v0, 0x0

    return v0

    :cond_1
    iget v0, p0, Ld/p/c;->d:I

    iput v0, p0, Ld/p/c;->b:I

    return v2
.end method
