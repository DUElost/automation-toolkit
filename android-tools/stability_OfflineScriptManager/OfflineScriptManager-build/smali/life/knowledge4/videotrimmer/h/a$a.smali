.class public abstract Llife/knowledge4/videotrimmer/h/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llife/knowledge4/videotrimmer/h/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "a"
.end annotation


# instance fields
.field private b:Ljava/lang/String;

.field private c:J

.field private d:J

.field private e:Ljava/lang/String;

.field private f:Z

.field private g:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation
.end field

.field private h:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>(Ljava/lang/String;JLjava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object v0, p0, Llife/knowledge4/videotrimmer/h/a$a;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    const-string v0, ""

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/h/a$a;->b:Ljava/lang/String;

    :cond_0
    const-wide/16 v1, 0x0

    cmp-long p1, p2, v1

    if-lez p1, :cond_1

    iput-wide p2, p0, Llife/knowledge4/videotrimmer/h/a$a;->c:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    add-long/2addr v1, p2

    iput-wide v1, p0, Llife/knowledge4/videotrimmer/h/a$a;->d:J

    :cond_1
    invoke-virtual {v0, p4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    iput-object p4, p0, Llife/knowledge4/videotrimmer/h/a$a;->e:Ljava/lang/String;

    :cond_2
    return-void
.end method

.method static synthetic a(Llife/knowledge4/videotrimmer/h/a$a;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/h/a$a;->e:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic b(Llife/knowledge4/videotrimmer/h/a$a;)Z
    .locals 0

    iget-boolean p0, p0, Llife/knowledge4/videotrimmer/h/a$a;->f:Z

    return p0
.end method

.method static synthetic c(Llife/knowledge4/videotrimmer/h/a$a;Z)Z
    .locals 0

    iput-boolean p1, p0, Llife/knowledge4/videotrimmer/h/a$a;->f:Z

    return p1
.end method

.method static synthetic d(Llife/knowledge4/videotrimmer/h/a$a;)J
    .locals 2

    iget-wide v0, p0, Llife/knowledge4/videotrimmer/h/a$a;->c:J

    return-wide v0
.end method

.method static synthetic e(Llife/knowledge4/videotrimmer/h/a$a;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/h/a$a;->b:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic f(Llife/knowledge4/videotrimmer/h/a$a;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/h/a$a;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object p0
.end method

.method static synthetic g(Llife/knowledge4/videotrimmer/h/a$a;Ljava/util/concurrent/Future;)Ljava/util/concurrent/Future;
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/h/a$a;->g:Ljava/util/concurrent/Future;

    return-object p1
.end method

.method private i()V
    .locals 8

    iget-object v0, p0, Llife/knowledge4/videotrimmer/h/a$a;->b:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Llife/knowledge4/videotrimmer/h/a$a;->e:Ljava/lang/String;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Llife/knowledge4/videotrimmer/h/a;->a()Ljava/lang/ThreadLocal;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    const-class v0, Llife/knowledge4/videotrimmer/h/a;

    monitor-enter v0

    :try_start_0
    invoke-static {}, Llife/knowledge4/videotrimmer/h/a;->b()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, p0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v1, p0, Llife/knowledge4/videotrimmer/h/a$a;->e:Ljava/lang/String;

    if-eqz v1, :cond_2

    invoke-static {v1}, Llife/knowledge4/videotrimmer/h/a;->c(Ljava/lang/String;)Llife/knowledge4/videotrimmer/h/a$a;

    move-result-object v1

    if-eqz v1, :cond_2

    iget-wide v2, v1, Llife/knowledge4/videotrimmer/h/a$a;->c:J

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-eqz v2, :cond_1

    iget-wide v2, p0, Llife/knowledge4/videotrimmer/h/a$a;->d:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long/2addr v2, v6

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    iput-wide v2, v1, Llife/knowledge4/videotrimmer/h/a$a;->c:J

    :cond_1
    invoke-static {v1}, Llife/knowledge4/videotrimmer/h/a;->e(Llife/knowledge4/videotrimmer/h/a$a;)V

    :cond_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method


# virtual methods
.method public abstract h()V
.end method

.method public run()V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/h/a$a;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-static {}, Llife/knowledge4/videotrimmer/h/a;->a()Ljava/lang/ThreadLocal;

    move-result-object v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/h/a$a;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    invoke-virtual {p0}, Llife/knowledge4/videotrimmer/h/a$a;->h()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/h/a$a;->i()V

    return-void

    :catchall_0
    move-exception v0

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/h/a$a;->i()V

    throw v0
.end method
