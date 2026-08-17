.class public Ld/c;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/c$a;,
        Ld/c$b;,
        Ld/c$c;
    }
.end annotation


# static fields
.field private static w:Ljava/util/concurrent/atomic/AtomicInteger;


# instance fields
.field private a:I

.field private final b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ld/j;",
            ">;"
        }
    .end annotation
.end field

.field private final c:Ljava/util/Deque;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Deque<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private final d:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private e:Z

.field private final f:Ljava/util/concurrent/locks/Lock;

.field private final g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/nio/channels/Selector;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ld/h;

.field private final i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ld/n/d;",
            ">;"
        }
    .end annotation
.end field

.field private j:I

.field private k:[Ld/d;

.field private final l:Ld/d;

.field private final m:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ld/c$a;",
            ">;"
        }
    .end annotation
.end field

.field private final n:Ljava/util/concurrent/locks/Lock;

.field private o:I

.field private p:I

.field private q:Z

.field private final r:Ljava/util/concurrent/locks/Lock;

.field private final s:Ljava/util/concurrent/locks/Lock;

.field private final t:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ld/c$b;",
            ">;"
        }
    .end annotation
.end field

.field private u:Z

.field private final v:Ld/s/c;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    sput-object v0, Ld/c;->w:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Ld/c;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/c;->g:Ljava/util/List;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ld/c;->t:Ljava/util/Map;

    new-instance v0, Ld/s/c;

    invoke-direct {v0}, Ld/s/c;-><init>()V

    iput-object v0, p0, Ld/c;->v:Ld/s/c;

    const v0, -0x54523502

    iput v0, p0, Ld/c;->a:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/c;->e:Z

    const/4 v2, 0x0

    iput-object v2, p0, Ld/c;->h:Ld/h;

    iput v0, p0, Ld/c;->j:I

    iput-object v2, p0, Ld/c;->k:[Ld/d;

    const/16 v2, 0x400

    iput v2, p0, Ld/c;->o:I

    iput v1, p0, Ld/c;->p:I

    iput-boolean v0, p0, Ld/c;->u:Z

    iput-boolean v1, p0, Ld/c;->q:Z

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    new-instance v0, Ld/d;

    const-string v1, "terminater"

    const/4 v2, -0x1

    invoke-direct {v0, p0, v1, v2}, Ld/d;-><init>(Ld/c;Ljava/lang/String;I)V

    iput-object v0, p0, Ld/c;->l:Ld/d;

    new-instance v0, Ljava/util/ArrayDeque;

    invoke-direct {v0}, Ljava/util/ArrayDeque;-><init>()V

    iput-object v0, p0, Ld/c;->c:Ljava/util/Deque;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/c;->i:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/c;->b:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ld/c;->m:Ljava/util/Map;

    return-void
.end method

.method private d(Ld/j;Ld/f;Ld/c$b;Ld/c$c;)V
    .locals 7

    invoke-virtual {p1}, Ld/g;->z0()V

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object v0

    invoke-virtual {p1}, Ld/m;->G()I

    move-result v1

    invoke-virtual {v0, v1}, Ld/m;->v0(I)V

    iget-boolean v0, p2, Ld/f;->t:Z

    if-nez v0, :cond_0

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object v0

    invoke-virtual {v0}, Ld/p/b;->I0()Ld/e;

    :cond_0
    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v0

    iget-object v0, v0, Ld/c$a;->b:Ld/f;

    iget v0, v0, Ld/f;->a:I

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget v0, p2, Ld/f;->b:I

    if-eqz v0, :cond_1

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v0

    iget-object v0, v0, Ld/c$a;->b:Ld/f;

    iget v0, v0, Ld/f;->a:I

    iget v2, p2, Ld/f;->b:I

    add-int/2addr v0, v2

    goto :goto_0

    :cond_1
    move v0, v1

    :goto_0
    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v2

    iget-object v2, v2, Ld/c$a;->b:Ld/f;

    iget v2, v2, Ld/f;->b:I

    if-eqz v2, :cond_2

    iget v2, p2, Ld/f;->a:I

    if-eqz v2, :cond_2

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v2

    iget-object v2, v2, Ld/c$a;->b:Ld/f;

    iget v2, v2, Ld/f;->b:I

    iget v3, p2, Ld/f;->a:I

    add-int/2addr v2, v3

    goto :goto_1

    :cond_2
    move v2, v1

    :goto_1
    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v3

    iget-object v3, v3, Ld/c$a;->b:Ld/f;

    iget-boolean v3, v3, Ld/f;->K:Z

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-eqz v3, :cond_4

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v3

    iget-object v3, v3, Ld/c$a;->b:Ld/f;

    iget v3, v3, Ld/f;->j:I

    const/4 v6, 0x5

    if-eq v3, v6, :cond_3

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v3

    iget-object v3, v3, Ld/c$a;->b:Ld/f;

    iget v3, v3, Ld/f;->j:I

    const/4 v6, 0x7

    if-eq v3, v6, :cond_3

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v3

    iget-object v3, v3, Ld/c$a;->b:Ld/f;

    iget v3, v3, Ld/f;->j:I

    const/16 v6, 0x8

    if-eq v3, v6, :cond_3

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v3

    iget-object v3, v3, Ld/c$a;->b:Ld/f;

    iget v3, v3, Ld/f;->j:I

    if-eq v3, v5, :cond_3

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object v3

    iget-object v3, v3, Ld/c$a;->b:Ld/f;

    iget v3, v3, Ld/f;->j:I

    if-ne v3, v4, :cond_4

    :cond_3
    move v3, v5

    goto :goto_2

    :cond_4
    move v3, v1

    :goto_2
    new-array v4, v4, [I

    const/4 v6, -0x1

    if-eqz v3, :cond_5

    move v0, v6

    :cond_5
    aput v0, v4, v1

    if-eqz v3, :cond_6

    move v2, v6

    :cond_6
    aput v2, v4, v5

    invoke-static {p3}, Ld/c$b;->c(Ld/c$b;)Ld/p/b;

    move-result-object v0

    aget v2, v4, v5

    aget v3, v4, v1

    invoke-virtual {v0, v2, v3}, Ld/p/b;->L0(II)V

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object v0

    aget v2, v4, v1

    aget v3, v4, v5

    invoke-virtual {v0, v2, v3}, Ld/p/b;->L0(II)V

    sget-object v0, Ld/c$c;->c:Ld/c$c;

    if-ne p4, v0, :cond_7

    new-instance p4, Ld/a;

    const/4 v0, 0x0

    sget-object v2, Ld/a$a;->f:Ld/a$a;

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object v3

    invoke-direct {p4, v0, v2, v3}, Ld/a;-><init>(Ld/m;Ld/a$a;Ljava/lang/Object;)V

    invoke-virtual {p1, p4}, Ld/m;->M(Ld/a;)V

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object p4

    iget-object p4, p4, Ld/c$a;->a:Ld/j;

    invoke-virtual {p1, p4}, Ld/m;->j0(Ld/j;)V

    goto :goto_3

    :cond_7
    invoke-static {p3}, Ld/c$b;->c(Ld/c$b;)Ld/p/b;

    move-result-object p4

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object v0

    invoke-virtual {p4, p1, v0, v1}, Ld/m;->f0(Ld/g;Ld/p/b;Z)V

    :goto_3
    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object p1

    iget-object p1, p1, Ld/c$a;->b:Ld/f;

    iget-boolean p1, p1, Ld/f;->t:Z

    if-eqz p1, :cond_8

    invoke-static {p3}, Ld/c$b;->b(Ld/c$b;)Ld/c$a;

    move-result-object p1

    iget-object p1, p1, Ld/c$a;->a:Ld/j;

    invoke-virtual {p1}, Ld/j;->N0()Z

    move-result p1

    if-eqz p1, :cond_8

    new-instance p1, Ld/e;

    iget-byte p4, p2, Ld/f;->d:B

    invoke-direct {p1, p4}, Ld/e;-><init>(I)V

    iget-object p4, p2, Ld/f;->e:[B

    iget-byte p2, p2, Ld/f;->d:B

    invoke-virtual {p1, p4, v1, p2}, Ld/e;->v([BII)Ld/e;

    const/16 p2, 0x40

    invoke-virtual {p1, p2}, Ld/e;->y(I)V

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object p2

    invoke-virtual {p2, p1}, Ld/p/b;->Q0(Ld/e;)Z

    invoke-static {p3}, Ld/c$b;->a(Ld/c$b;)Ld/p/b;

    move-result-object p1

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_8
    return-void
.end method

.method private h()V
    .locals 2

    iget-object v0, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v0, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v0, p0, Ld/c;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    iget-object v0, p0, Ld/c;->h:Ld/h;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ld/h;->close()V

    :cond_1
    iget-object v0, p0, Ld/c;->l:Ld/d;

    invoke-virtual {v0}, Ld/d;->close()V

    const v0, -0x21524111

    iput v0, p0, Ld/c;->a:I

    return-void

    :cond_2
    :try_start_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/nio/channels/Selector;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/nio/channels/Selector;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception v0

    iget-object v1, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0

    :cond_3
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/n/d;

    invoke-virtual {v0}, Ld/n/d;->close()V

    goto :goto_1

    :cond_4
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/n/d;

    invoke-virtual {v1}, Ld/n/d;->B0()V

    goto :goto_0
.end method

.method private n()V
    .locals 7

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget v0, p0, Ld/c;->p:I

    iget v1, p0, Ld/c;->o:I

    add-int/2addr v1, v0

    const/4 v2, 0x2

    add-int/2addr v1, v2

    iput v1, p0, Ld/c;->j:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    iget-object v1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    iget v1, p0, Ld/c;->j:I

    new-array v1, v1, [Ld/d;

    iput-object v1, p0, Ld/c;->k:[Ld/d;

    const/4 v3, 0x0

    iget-object v4, p0, Ld/c;->l:Ld/d;

    aput-object v4, v1, v3

    new-instance v1, Ld/h;

    const/4 v3, 0x1

    invoke-direct {v1, p0, v3}, Ld/h;-><init>(Ld/c;I)V

    iput-object v1, p0, Ld/c;->h:Ld/h;

    iget-object v4, p0, Ld/c;->k:[Ld/d;

    invoke-virtual {v1}, Ld/h;->y0()Ld/d;

    move-result-object v1

    aput-object v1, v4, v3

    iget-object v1, p0, Ld/c;->h:Ld/h;

    invoke-virtual {v1}, Ld/h;->z0()V

    move v1, v2

    :goto_0
    add-int/lit8 v4, v0, 0x2

    if-ne v1, v4, :cond_1

    iget v0, p0, Ld/c;->j:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    sub-int/2addr v0, v3

    :goto_1
    if-ge v0, v4, :cond_0

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :cond_0
    :try_start_3
    iget-object v1, p0, Ld/c;->c:Ljava/util/Deque;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Ld/c;->k:[Ld/d;

    const/4 v2, 0x0

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    :cond_1
    new-instance v4, Ld/n/d;

    invoke-direct {v4, p0, v1}, Ld/n/d;-><init>(Ld/c;I)V

    iget-object v5, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v5, p0, Ld/c;->k:[Ld/d;

    invoke-virtual {v4}, Ld/n/d;->y0()Ld/d;

    move-result-object v6

    aput-object v6, v5, v1

    invoke-virtual {v4}, Ld/n/d;->A0()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catchall_0
    move-exception v0

    iget-object v1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :catchall_1
    move-exception v0

    iget-object v1, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method


# virtual methods
.method public a()Z
    .locals 2

    iget v0, p0, Ld/c;->a:I

    const v1, -0x54523502

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method b(J)Ld/n/d;
    .locals 7

    iget-object v0, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    const/4 v0, -0x1

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v2, v3, :cond_1

    return-object v1

    :cond_1
    const-wide/16 v3, 0x0

    cmp-long v5, p1, v3

    if-eqz v5, :cond_2

    const-wide/16 v5, 0x1

    shl-long/2addr v5, v2

    and-long/2addr v5, p1

    cmp-long v3, v5, v3

    if-lez v3, :cond_4

    :cond_2
    iget-object v3, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ld/n/d;

    invoke-virtual {v3}, Ld/n/d;->x0()I

    move-result v3

    if-eqz v1, :cond_3

    if-ge v3, v0, :cond_4

    :cond_3
    iget-object v0, p0, Ld/c;->i:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/n/d;

    move-object v1, v0

    move v0, v3

    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public c(Ljava/nio/channels/Selector;)Z
    .locals 1

    iget-object v0, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    :try_start_1
    invoke-virtual {p1}, Ljava/nio/channels/Selector;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception p1

    :try_start_2
    new-instance v0, Ld/k$b;

    invoke-direct {v0, p1}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_0
    :goto_0
    iget-object p1, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return v0

    :catchall_0
    move-exception p1

    iget-object v0, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method e(Ljava/lang/String;Ld/j;)V
    .locals 2

    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->t:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/c$b;

    if-eqz v0, :cond_0

    iget-object v1, p0, Ld/c;->m:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/c$a;

    iget-object p1, p1, Ld/c$a;->b:Ld/f;

    sget-object v1, Ld/c$c;->c:Ld/c$c;

    invoke-direct {p0, p2, p1, v0, v1}, Ld/c;->d(Ld/j;Ld/f;Ld/c$b;Ld/c$c;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method public f()Ljava/nio/channels/Selector;
    .locals 2

    iget-object v0, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    invoke-static {}, Ljava/nio/channels/Selector;->open()Ljava/nio/channels/Selector;

    move-result-object v0

    iget-object v1, p0, Ld/c;->g:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v1, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-object v0

    :catchall_0
    move-exception v0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_1
    new-instance v1, Ld/k$b;

    invoke-direct {v1, v0}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    iget-object v1, p0, Ld/c;->s:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method

.method public g(I)Ld/j;
    .locals 3

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Ld/c;->n()V

    :cond_0
    iget-boolean v0, p0, Ld/c;->e:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Ld/c;->c:Ljava/util/Deque;

    invoke-interface {v0}, Ljava/util/Deque;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Ld/c;->c:Ljava/util/Deque;

    invoke-interface {v0}, Ljava/util/Deque;->pollLast()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    sget-object v1, Ld/c;->w:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v1

    invoke-static {p1, p0, v0, v1}, Ld/r/d;->b(ILd/c;II)Ld/j;

    move-result-object p1

    if-nez p1, :cond_1

    iget-object p1, p0, Ld/c;->c:Ljava/util/Deque;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/Deque;->addLast(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    const/4 p1, 0x0

    return-object p1

    :cond_1
    :try_start_1
    iget-object v1, p0, Ld/c;->b:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Ld/c;->k:[Ld/d;

    invoke-virtual {p1}, Ld/j;->c1()Ld/d;

    move-result-object v2

    aput-object v2, v1, v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-object p1

    :cond_2
    :try_start_2
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "EMFILE"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_3
    new-instance p1, Ld/k$a;

    invoke-direct {p1}, Ld/k$a;-><init>()V

    throw p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :catchall_0
    move-exception p1

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method i(Ld/j;)V
    .locals 3

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    invoke-virtual {p1}, Ld/m;->G()I

    move-result v0

    iget-object v1, p0, Ld/c;->c:Ljava/util/Deque;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Ld/c;->k:[Ld/d;

    const/4 v2, 0x0

    aput-object v2, v1, v0

    iget-object v0, p0, Ld/c;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-boolean p1, p0, Ld/c;->e:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Ld/c;->b:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Ld/c;->h:Ld/h;

    invoke-virtual {p1}, Ld/h;->A0()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method public j()Ld/s/c;
    .locals 1

    iget-object v0, p0, Ld/c;->v:Ld/s/c;

    return-object v0
.end method

.method k(Ljava/lang/String;)Ld/c$a;
    .locals 2

    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->m:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/c$a;

    if-nez p1, :cond_0

    new-instance p1, Ld/c$a;

    const/4 v0, 0x0

    new-instance v1, Ld/f;

    invoke-direct {v1}, Ld/f;-><init>()V

    invoke-direct {p1, v0, v1}, Ld/c$a;-><init>(Ld/j;Ld/f;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-object p1

    :cond_0
    :try_start_1
    iget-object v0, p1, Ld/c$a;->a:Ld/j;

    invoke-virtual {v0}, Ld/g;->z0()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method public l(I)I
    .locals 3

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    iget p1, p0, Ld/c;->o:I

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget p1, p0, Ld/c;->p:I

    goto :goto_0

    :cond_1
    const/16 v0, 0x46

    if-ne p1, v0, :cond_2

    iget-boolean p1, p0, Ld/c;->q:Z

    goto :goto_0

    :cond_2
    const/16 v0, 0x2a

    if-ne p1, v0, :cond_3

    iget-boolean p1, p0, Ld/c;->u:Z

    :goto_0
    return p1

    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "option = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method m()Ld/m;
    .locals 1

    iget-object v0, p0, Ld/c;->h:Ld/h;

    return-object v0
.end method

.method o(Ljava/lang/String;Ld/c$a;[Ld/p/b;)V
    .locals 3

    new-instance v0, Ld/c$b;

    const/4 v1, 0x0

    aget-object v1, p3, v1

    const/4 v2, 0x1

    aget-object p3, p3, v2

    invoke-direct {v0, p2, v1, p3}, Ld/c$b;-><init>(Ld/c$a;Ld/p/b;Ld/p/b;)V

    iget-object p3, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p3}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object p3, p0, Ld/c;->m:Ljava/util/Map;

    invoke-interface {p3, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ld/c$a;

    if-nez p3, :cond_0

    iget-object p2, p2, Ld/c$a;->a:Ld/j;

    invoke-virtual {p2}, Ld/g;->z0()V

    iget-object p2, p0, Ld/c;->t:Ljava/util/Map;

    invoke-interface {p2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_0
    iget-object p1, p3, Ld/c$a;->a:Ld/j;

    iget-object p2, p3, Ld/c$a;->b:Ld/f;

    sget-object p3, Ld/c$c;->b:Ld/c$c;

    invoke-direct {p0, p1, p2, v0, p3}, Ld/c;->d(Ld/j;Ld/f;Ld/c$b;Ld/c$c;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iget-object p1, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method p(Ljava/lang/String;Ld/c$a;)Z
    .locals 1

    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->m:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/c$a;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p2, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1

    :catchall_0
    move-exception p1

    iget-object p2, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method

.method q(ILd/a;)V
    .locals 1

    iget-object v0, p0, Ld/c;->k:[Ld/d;

    aget-object p1, v0, p1

    invoke-virtual {p1, p2}, Ld/d;->e(Ld/a;)V

    return-void
.end method

.method public r(II)Z
    .locals 3

    const/4 v0, 0x1

    const/4 v1, 0x2

    if-ne p1, v1, :cond_0

    if-lt p2, v0, :cond_0

    iget-object p1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iput p2, p0, Ld/c;->o:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iget-object p1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto :goto_1

    :catchall_0
    move-exception p1

    iget-object p2, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1

    :cond_0
    if-ne p1, v0, :cond_1

    if-ltz p2, :cond_1

    iget-object p1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_1
    iput p2, p0, Ld/c;->p:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    iget-object p2, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1

    :cond_1
    const/16 v1, 0x46

    const/4 v2, 0x0

    if-ne p1, v1, :cond_3

    if-ltz p2, :cond_3

    iget-object p1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->lock()V

    if-eqz p2, :cond_2

    move v2, v0

    :cond_2
    :try_start_2
    iput-boolean v2, p0, Ld/c;->q:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_0

    :catchall_2
    move-exception p1

    iget-object p2, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1

    :cond_3
    const/16 v1, 0x2a

    if-ne p1, v1, :cond_5

    if-ltz p2, :cond_5

    iget-object p1, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->lock()V

    if-eqz p2, :cond_4

    move v2, v0

    :cond_4
    :try_start_3
    iput-boolean v2, p0, Ld/c;->u:Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    goto :goto_0

    :goto_1
    return v0

    :catchall_3
    move-exception p1

    iget-object p2, p0, Ld/c;->r:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1

    :cond_5
    return v2
.end method

.method public s()V
    .locals 3

    iget-object v0, p0, Ld/c;->t:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_3

    iget-boolean v0, p0, Ld/c;->e:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Ld/c;->e:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/c;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v0, p0, Ld/c;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/c;->h:Ld/h;

    invoke-virtual {v0}, Ld/h;->A0()V

    goto :goto_2

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/j;

    invoke-virtual {v1}, Ld/j;->i1()V

    goto :goto_1

    :cond_1
    :goto_2
    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    iget-object v0, p0, Ld/c;->l:Ld/d;

    const-wide/16 v1, -0x1

    invoke-virtual {v0, v1, v2}, Ld/d;->b(J)Ld/a;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    goto :goto_3

    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_3
    :goto_3
    iget-object v0, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    :try_start_1
    invoke-direct {p0}, Ld/c;->h()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    :catchall_0
    move-exception v0

    iget-object v1, p0, Ld/c;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0

    :cond_4
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Ld/c;->g(I)Ld/j;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v2, v1}, Ld/j;->K0(Ljava/lang/String;)Z

    invoke-virtual {v2}, Ld/j;->close()V

    goto/16 :goto_0
.end method

.method t(Ld/j;)V
    .locals 2

    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Ld/c;->m:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_1

    iget-object p1, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :cond_1
    :try_start_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/c$a;

    iget-object v1, v1, Ld/c$a;->a:Ld/j;

    if-ne v1, p1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    iget-object v0, p0, Ld/c;->n:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw p1
.end method
