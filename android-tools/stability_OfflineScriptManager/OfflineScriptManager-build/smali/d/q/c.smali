.class abstract Ld/q/c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/q/c$a;
    }
.end annotation


# instance fields
.field private final b:Ljava/util/concurrent/atomic/AtomicInteger;

.field private final c:Ld/s/d;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/s/d<",
            "Ljava/lang/Long;",
            "Ld/q/c$a;",
            ">;"
        }
    .end annotation
.end field

.field protected final d:Ljava/lang/Thread;

.field private e:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/q/c;

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p0, p1}, Ld/q/c;->e(Ljava/lang/String;)Ljava/lang/Thread;

    move-result-object p1

    iput-object p1, p0, Ld/q/c;->d:Ljava/lang/Thread;

    new-instance p1, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v0, 0x0

    invoke-direct {p1, v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object p1, p0, Ld/q/c;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    new-instance p1, Ld/s/d;

    invoke-direct {p1}, Ld/s/d;-><init>()V

    iput-object p1, p0, Ld/q/c;->c:Ld/s/d;

    return-void
.end method


# virtual methods
.method public a(JLd/q/a;I)V
    .locals 2

    invoke-virtual {p0}, Ld/q/c;->d()J

    move-result-wide v0

    add-long/2addr v0, p1

    new-instance p1, Ld/q/c$a;

    invoke-direct {p1, p3, p4}, Ld/q/c$a;-><init>(Ld/q/a;I)V

    iget-object p2, p0, Ld/q/c;->c:Ld/s/d;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    invoke-virtual {p2, p3, p1}, Ld/s/d;->e(Ljava/lang/Comparable;Ljava/lang/Object;)Z

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/q/c;->e:Z

    return-void
.end method

.method protected b(I)V
    .locals 1

    iget-object v0, p0, Ld/q/c;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicInteger;->addAndGet(I)I

    return-void
.end method

.method public c(Ld/q/a;I)V
    .locals 1

    new-instance v0, Ld/q/c$a;

    invoke-direct {v0, p1, p2}, Ld/q/c$a;-><init>(Ld/q/a;I)V

    iget-object p1, p0, Ld/q/c;->c:Ld/s/d;

    invoke-virtual {p1, v0}, Ld/s/d;->b(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/q/c$a;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Ld/q/c$a;->a(Ld/q/c$a;Z)V

    return-void
.end method

.method d()J
    .locals 2

    invoke-static {}, Ld/s/b;->a()J

    move-result-wide v0

    return-wide v0
.end method

.method e(Ljava/lang/String;)Ljava/lang/Thread;
    .locals 1

    new-instance v0, Ljava/lang/Thread;

    invoke-direct {v0, p0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Ljava/lang/Thread;->setDaemon(Z)V

    return-object v0
.end method

.method protected f()J
    .locals 9

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/q/c;->e:Z

    iget-object v0, p0, Ld/q/c;->c:Ld/s/d;

    invoke-virtual {v0}, Ld/s/d;->f()Z

    move-result v0

    const-wide/16 v1, 0x0

    if-eqz v0, :cond_0

    return-wide v1

    :cond_0
    invoke-virtual {p0}, Ld/q/c;->d()J

    move-result-wide v3

    iget-object v0, p0, Ld/q/c;->c:Ld/s/d;

    invoke-virtual {v0}, Ld/s/d;->a()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_2

    iget-boolean v0, p0, Ld/q/c;->e:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Ld/q/c;->f()J

    move-result-wide v0

    return-wide v0

    :cond_1
    return-wide v1

    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ld/q/c$a;

    invoke-static {v6}, Ld/q/c$a;->b(Ld/q/c$a;)Z

    move-result v7

    if-eqz v7, :cond_3

    iget-object v7, p0, Ld/q/c;->c:Ld/s/d;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Long;

    :goto_1
    invoke-virtual {v7, v5, v6}, Ld/s/d;->g(Ljava/lang/Comparable;Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Long;

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v7

    cmp-long v7, v7, v3

    if-lez v7, :cond_4

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    sub-long/2addr v0, v3

    return-wide v0

    :cond_4
    invoke-static {v6}, Ld/q/c$a;->c(Ld/q/c$a;)Ld/q/a;

    move-result-object v7

    invoke-static {v6}, Ld/q/c$a;->d(Ld/q/c$a;)I

    move-result v8

    invoke-interface {v7, v8}, Ld/q/a;->h(I)V

    iget-object v7, p0, Ld/q/c;->c:Ld/s/d;

    goto :goto_1
.end method

.method public g()I
    .locals 1

    iget-object v0, p0, Ld/q/c;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    return v0
.end method
