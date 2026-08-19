.class public abstract Ld/g;
.super Ld/m;
.source ""


# instance fields
.field protected final e:Ld/f;

.field private f:Z

.field private final g:Ljava/util/concurrent/atomic/AtomicLong;

.field private h:J

.field private i:Ld/g;

.field private final j:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ld/g;",
            ">;"
        }
    .end annotation
.end field

.field private k:I

.field public final l:Ld/s/c;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method protected constructor <init>(Ld/c;I)V
    .locals 2

    invoke-direct {p0, p1, p2}, Ld/m;-><init>(Ld/c;I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/g;->f:Z

    new-instance p2, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v0, 0x0

    invoke-direct {p2, v0, v1}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object p2, p0, Ld/g;->g:Ljava/util/concurrent/atomic/AtomicLong;

    iput-wide v0, p0, Ld/g;->h:J

    const/4 p2, 0x0

    iput-object p2, p0, Ld/g;->i:Ld/g;

    iput p1, p0, Ld/g;->k:I

    new-instance p1, Ld/f;

    invoke-direct {p1}, Ld/f;-><init>()V

    iput-object p1, p0, Ld/g;->e:Ld/f;

    iget-object p1, p1, Ld/f;->P:Ld/s/c;

    iput-object p1, p0, Ld/g;->l:Ld/s/c;

    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Ld/g;->j:Ljava/util/Set;

    return-void
.end method

.method protected constructor <init>(Ld/n/d;Ld/f;)V
    .locals 3

    invoke-direct {p0, p1}, Ld/m;-><init>(Ld/m;)V

    iput-object p2, p0, Ld/g;->e:Ld/f;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/g;->f:Z

    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Ld/g;->g:Ljava/util/concurrent/atomic/AtomicLong;

    iput-wide v1, p0, Ld/g;->h:J

    const/4 v0, 0x0

    iput-object v0, p0, Ld/g;->i:Ld/g;

    iput p1, p0, Ld/g;->k:I

    iget-object p1, p2, Ld/f;->P:Ld/s/c;

    iput-object p1, p0, Ld/g;->l:Ld/s/c;

    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Ld/g;->j:Ljava/util/Set;

    return-void
.end method

.method private E0(Ld/g;)V
    .locals 0

    iput-object p1, p0, Ld/g;->i:Ld/g;

    return-void
.end method

.method private x0()V
    .locals 4

    iget-boolean v0, p0, Ld/g;->f:Z

    if-eqz v0, :cond_1

    iget-wide v0, p0, Ld/g;->h:J

    iget-object v2, p0, Ld/g;->g:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-nez v0, :cond_1

    iget v0, p0, Ld/g;->k:I

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/g;->i:Ld/g;

    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Ld/m;->t0(Ld/g;)V

    :cond_0
    invoke-virtual {p0}, Ld/g;->C0()V

    :cond_1
    return-void
.end method


# virtual methods
.method protected final A0()Z
    .locals 1

    iget-boolean v0, p0, Ld/g;->f:Z

    return v0
.end method

.method protected final B0(Ld/g;)V
    .locals 0

    invoke-direct {p1, p0}, Ld/g;->E0(Ld/g;)V

    invoke-virtual {p0, p1}, Ld/m;->n0(Ld/g;)V

    invoke-virtual {p0, p0, p1}, Ld/m;->k0(Ld/g;Ld/g;)V

    return-void
.end method

.method protected C0()V
    .locals 0

    invoke-virtual {p0}, Ld/g;->y0()V

    return-void
.end method

.method final D0(I)V
    .locals 1

    iget v0, p0, Ld/g;->k:I

    add-int/2addr v0, p1

    iput v0, p0, Ld/g;->k:I

    return-void
.end method

.method protected final F0()V
    .locals 1

    iget-boolean v0, p0, Ld/g;->f:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ld/g;->i:Ld/g;

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget v0, v0, Ld/f;->k:I

    invoke-virtual {p0, v0}, Ld/g;->W(I)V

    return-void

    :cond_1
    invoke-virtual {p0, v0, p0}, Ld/m;->u0(Ld/g;Ld/g;)V

    return-void
.end method

.method final G0()V
    .locals 1

    iget v0, p0, Ld/g;->k:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/g;->k:I

    invoke-direct {p0}, Ld/g;->x0()V

    return-void
.end method

.method protected final O(Ld/g;)V
    .locals 1

    iget-boolean v0, p0, Ld/g;->f:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ld/g;->D0(I)V

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Ld/m;->s0(Ld/g;I)V

    return-void

    :cond_0
    iget-object v0, p0, Ld/g;->j:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method protected final U()V
    .locals 4

    iget-wide v0, p0, Ld/g;->h:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Ld/g;->h:J

    invoke-direct {p0}, Ld/g;->x0()V

    return-void
.end method

.method protected W(I)V
    .locals 2

    iget-object v0, p0, Ld/g;->j:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object p1, p0, Ld/g;->j:Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->size()I

    move-result p1

    invoke-virtual {p0, p1}, Ld/g;->D0(I)V

    iget-object p1, p0, Ld/g;->j:Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->clear()V

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/g;->f:Z

    invoke-direct {p0}, Ld/g;->x0()V

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/g;

    invoke-virtual {p0, v1, p1}, Ld/m;->s0(Ld/g;I)V

    goto :goto_0
.end method

.method protected final X()V
    .locals 0

    invoke-virtual {p0}, Ld/g;->G0()V

    return-void
.end method

.method protected final Y(Ld/g;)V
    .locals 1

    iget-boolean v0, p0, Ld/g;->f:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ld/g;->j:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ld/g;->D0(I)V

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget v0, v0, Ld/f;->k:I

    invoke-virtual {p0, p1, v0}, Ld/m;->s0(Ld/g;I)V

    return-void
.end method

.method protected abstract y0()V
.end method

.method protected z0()V
    .locals 1

    iget-object v0, p0, Ld/g;->g:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    return-void
.end method
