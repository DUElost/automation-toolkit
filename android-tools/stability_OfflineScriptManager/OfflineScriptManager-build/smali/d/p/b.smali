.class public Ld/p/b;
.super Ld/m;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/p/b$a;,
        Ld/p/b$b;
    }
.end annotation


# instance fields
.field private e:Ld/p/d;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/d<",
            "Ld/e;",
            ">;"
        }
    .end annotation
.end field

.field private f:Ld/p/d;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/d<",
            "Ld/e;",
            ">;"
        }
    .end annotation
.end field

.field private g:Z

.field private h:Z

.field private i:I

.field private j:I

.field private k:J

.field private l:J

.field private m:J

.field private n:Ld/p/b;

.field private o:Ld/p/b$a;

.field private p:Ld/p/b$b;

.field private q:Z

.field private r:Ld/s/a;

.field private s:Ld/s/a;

.field private final t:Z

.field private final u:Ld/m;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>(Ld/m;Ld/p/d;Ld/p/d;IIZ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/m;",
            "Ld/p/d<",
            "Ld/e;",
            ">;",
            "Ld/p/d<",
            "Ld/e;",
            ">;IIZ)V"
        }
    .end annotation

    invoke-direct {p0, p1}, Ld/m;-><init>(Ld/m;)V

    iput-object p2, p0, Ld/p/b;->e:Ld/p/d;

    iput-object p3, p0, Ld/p/b;->f:Ld/p/d;

    const/4 p2, 0x1

    iput-boolean p2, p0, Ld/p/b;->g:Z

    iput-boolean p2, p0, Ld/p/b;->h:Z

    iput p5, p0, Ld/p/b;->i:I

    invoke-static {p4}, Ld/p/b;->A0(I)I

    move-result p3

    iput p3, p0, Ld/p/b;->j:I

    const-wide/16 p3, 0x0

    iput-wide p3, p0, Ld/p/b;->k:J

    iput-wide p3, p0, Ld/p/b;->l:J

    iput-wide p3, p0, Ld/p/b;->m:J

    const/4 p3, 0x0

    iput-object p3, p0, Ld/p/b;->n:Ld/p/b;

    iput-object p3, p0, Ld/p/b;->o:Ld/p/b$a;

    sget-object p3, Ld/p/b$b;->b:Ld/p/b$b;

    iput-object p3, p0, Ld/p/b;->p:Ld/p/b$b;

    iput-boolean p2, p0, Ld/p/b;->q:Z

    iput-boolean p6, p0, Ld/p/b;->t:Z

    iput-object p1, p0, Ld/p/b;->u:Ld/m;

    return-void
.end method

.method private static A0(I)I
    .locals 0

    add-int/lit8 p0, p0, 0x1

    div-int/lit8 p0, p0, 0x2

    return p0
.end method

.method private static F0(Ld/e;)Z
    .locals 0

    invoke-virtual {p0}, Ld/e;->n()Z

    move-result p0

    return p0
.end method

.method public static G0([Ld/m;[I[Z)[Ld/p/b;
    .locals 13

    const/4 v0, 0x2

    new-array v0, v0, [Ld/p/b;

    const/4 v1, 0x0

    aget-boolean v2, p2, v1

    if-eqz v2, :cond_0

    new-instance v2, Ld/p/e;

    invoke-direct {v2}, Ld/p/e;-><init>()V

    goto :goto_0

    :cond_0
    new-instance v2, Ld/p/c;

    sget-object v3, Ld/b;->c:Ld/b;

    invoke-virtual {v3}, Ld/b;->a()I

    move-result v3

    invoke-direct {v2, v3}, Ld/p/c;-><init>(I)V

    :goto_0
    const/4 v3, 0x1

    aget-boolean v4, p2, v3

    if-eqz v4, :cond_1

    new-instance v4, Ld/p/e;

    invoke-direct {v4}, Ld/p/e;-><init>()V

    goto :goto_1

    :cond_1
    new-instance v4, Ld/p/c;

    sget-object v5, Ld/b;->c:Ld/b;

    invoke-virtual {v5}, Ld/b;->a()I

    move-result v5

    invoke-direct {v4, v5}, Ld/p/c;-><init>(I)V

    :goto_1
    move-object v11, v4

    new-instance v12, Ld/p/b;

    aget-object v5, p0, v1

    aget v8, p1, v3

    aget v9, p1, v1

    aget-boolean v10, p2, v1

    move-object v4, v12

    move-object v6, v2

    move-object v7, v11

    invoke-direct/range {v4 .. v10}, Ld/p/b;-><init>(Ld/m;Ld/p/d;Ld/p/d;IIZ)V

    aput-object v12, v0, v1

    new-instance v12, Ld/p/b;

    aget-object v5, p0, v3

    aget v8, p1, v1

    aget v9, p1, v3

    aget-boolean v10, p2, v3

    move-object v4, v12

    move-object v6, v11

    move-object v7, v2

    invoke-direct/range {v4 .. v10}, Ld/p/b;-><init>(Ld/m;Ld/p/d;Ld/p/d;IIZ)V

    aput-object v12, v0, v3

    aget-object p0, v0, v1

    aget-object p1, v0, v3

    invoke-direct {p0, p1}, Ld/p/b;->O0(Ld/p/b;)V

    aget-object p0, v0, v3

    aget-object p1, v0, v1

    invoke-direct {p0, p1}, Ld/p/b;->O0(Ld/p/b;)V

    return-object v0
.end method

.method private H0()V
    .locals 2

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->b:Ld/p/b$b;

    if-ne v0, v1, :cond_0

    sget-object v0, Ld/p/b$b;->c:Ld/p/b$b;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ld/p/b;->f:Ld/p/d;

    iget-object v0, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, v0}, Ld/m;->m0(Ld/p/b;)V

    sget-object v0, Ld/p/b$b;->e:Ld/p/b$b;

    :goto_0
    iput-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    return-void
.end method

.method private O0(Ld/p/b;)V
    .locals 0

    iput-object p1, p0, Ld/p/b;->n:Ld/p/b;

    return-void
.end method


# virtual methods
.method public B0()V
    .locals 2

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->e:Ld/p/b$b;

    if-ne v0, v1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ld/p/b;->f:Ld/p/d;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ld/p/d;->flush()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, v0}, Ld/m;->a0(Ld/p/b;)V

    :cond_1
    return-void
.end method

.method public C0()Ld/s/a;
    .locals 1

    iget-object v0, p0, Ld/p/b;->s:Ld/s/a;

    return-object v0
.end method

.method public D0()Ld/s/a;
    .locals 1

    iget-object v0, p0, Ld/p/b;->r:Ld/s/a;

    return-object v0
.end method

.method public E0()V
    .locals 2

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->b:Ld/p/b$b;

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ld/p/b;->e:Ld/p/d;

    iget-boolean v0, p0, Ld/p/b;->t:Z

    if-eqz v0, :cond_1

    new-instance v0, Ld/p/e;

    invoke-direct {v0}, Ld/p/e;-><init>()V

    goto :goto_0

    :cond_1
    new-instance v0, Ld/p/c;

    sget-object v1, Ld/b;->c:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v1

    invoke-direct {v0, v1}, Ld/p/c;-><init>(I)V

    :goto_0
    iput-object v0, p0, Ld/p/b;->e:Ld/p/d;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/p/b;->g:Z

    iget-object v0, p0, Ld/p/b;->n:Ld/p/b;

    iget-object v1, p0, Ld/p/b;->e:Ld/p/d;

    invoke-virtual {p0, v0, v1}, Ld/m;->i0(Ld/p/b;Ld/p/d;)V

    return-void
.end method

.method protected I()V
    .locals 2

    iget-boolean v0, p0, Ld/p/b;->g:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->b:Ld/p/b$b;

    if-eq v0, v1, :cond_0

    sget-object v1, Ld/p/b$b;->d:Ld/p/b$b;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/p/b;->g:Z

    iget-object v0, p0, Ld/p/b;->o:Ld/p/b$a;

    invoke-interface {v0, p0}, Ld/p/b$a;->t(Ld/p/b;)V

    :cond_1
    return-void
.end method

.method public I0()Ld/e;
    .locals 8

    iget-boolean v0, p0, Ld/p/b;->g:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v2, Ld/p/b$b;->b:Ld/p/b$b;

    if-eq v0, v2, :cond_1

    sget-object v2, Ld/p/b$b;->d:Ld/p/b$b;

    if-eq v0, v2, :cond_1

    return-object v1

    :cond_1
    :goto_0
    iget-object v0, p0, Ld/p/b;->e:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->d()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/e;

    if-nez v0, :cond_2

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/p/b;->g:Z

    return-object v1

    :cond_2
    invoke-virtual {v0}, Ld/e;->m()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-static {v0}, Ld/s/a;->a(Ld/e;)Ld/s/a;

    move-result-object v0

    iput-object v0, p0, Ld/p/b;->s:Ld/s/a;

    goto :goto_0

    :cond_3
    invoke-virtual {v0}, Ld/e;->n()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-direct {p0}, Ld/p/b;->H0()V

    return-object v1

    :cond_4
    invoke-virtual {v0}, Ld/e;->j()Z

    move-result v1

    if-nez v1, :cond_5

    invoke-virtual {v0}, Ld/e;->o()Z

    move-result v1

    if-nez v1, :cond_5

    iget-wide v1, p0, Ld/p/b;->k:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Ld/p/b;->k:J

    :cond_5
    iget v1, p0, Ld/p/b;->j:I

    if-lez v1, :cond_6

    iget-wide v2, p0, Ld/p/b;->k:J

    int-to-long v4, v1

    rem-long v4, v2, v4

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-nez v1, :cond_6

    iget-object v1, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, v1, v2, v3}, Ld/m;->b0(Ld/p/b;J)V

    :cond_6
    return-object v0
.end method

.method protected J(J)V
    .locals 0

    iput-wide p1, p0, Ld/p/b;->m:J

    iget-boolean p1, p0, Ld/p/b;->h:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object p2, Ld/p/b$b;->b:Ld/p/b$b;

    if-ne p1, p2, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/p/b;->h:Z

    iget-object p1, p0, Ld/p/b;->o:Ld/p/b$a;

    invoke-interface {p1, p0}, Ld/p/b$a;->m(Ld/p/b;)V

    :cond_0
    return-void
.end method

.method public J0()V
    .locals 1

    iget-object v0, p0, Ld/p/b;->f:Ld/p/d;

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Ld/p/b;->f:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->e()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/e;

    if-nez v0, :cond_0

    :cond_1
    return-void
.end method

.method public K0(Ld/p/b$a;)V
    .locals 0

    iput-object p1, p0, Ld/p/b;->o:Ld/p/b$a;

    return-void
.end method

.method public L0(II)V
    .locals 0

    invoke-static {p1}, Ld/p/b;->A0(I)I

    move-result p1

    iput p1, p0, Ld/p/b;->j:I

    iput p2, p0, Ld/p/b;->i:I

    return-void
.end method

.method public M0(Ld/s/a;)V
    .locals 0

    iput-object p1, p0, Ld/p/b;->r:Ld/s/a;

    return-void
.end method

.method protected N(Ld/p/d;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/p/d<",
            "Ld/e;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Ld/p/b;->f:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->flush()Z

    :cond_0
    :goto_0
    iget-object v0, p0, Ld/p/b;->f:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->d()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/e;

    if-nez v0, :cond_2

    iput-object p1, p0, Ld/p/b;->f:Ld/p/d;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/p/b;->h:Z

    iget-object p1, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v0, Ld/p/b$b;->b:Ld/p/b$b;

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Ld/p/b;->o:Ld/p/b$a;

    invoke-interface {p1, p0}, Ld/p/b$a;->v(Ld/p/b;)V

    :cond_1
    return-void

    :cond_2
    invoke-virtual {v0}, Ld/e;->j()Z

    move-result v0

    if-nez v0, :cond_0

    iget-wide v0, p0, Ld/p/b;->l:J

    const-wide/16 v2, 0x1

    sub-long/2addr v0, v2

    iput-wide v0, p0, Ld/p/b;->l:J

    goto :goto_0
.end method

.method public N0()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/p/b;->q:Z

    return-void
.end method

.method protected P()V
    .locals 3

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->b:Ld/p/b$b;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_0

    iget-boolean v0, p0, Ld/p/b;->q:Z

    if-eqz v0, :cond_1

    sget-object v0, Ld/p/b$b;->d:Ld/p/b$b;

    iput-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    goto :goto_1

    :cond_0
    sget-object v1, Ld/p/b$b;->c:Ld/p/b$b;

    if-ne v0, v1, :cond_2

    :cond_1
    sget-object v0, Ld/p/b$b;->e:Ld/p/b$b;

    :goto_0
    iput-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    iput-object v2, p0, Ld/p/b;->f:Ld/p/d;

    iget-object v0, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, v0}, Ld/m;->m0(Ld/p/b;)V

    goto :goto_1

    :cond_2
    sget-object v1, Ld/p/b$b;->f:Ld/p/b$b;

    if-ne v0, v1, :cond_3

    sget-object v0, Ld/p/b$b;->g:Ld/p/b$b;

    goto :goto_0

    :cond_3
    :goto_1
    return-void
.end method

.method public P0(Z)V
    .locals 4

    iput-boolean p1, p0, Ld/p/b;->q:Z

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->f:Ld/p/b$b;

    if-eq v0, v1, :cond_5

    sget-object v2, Ld/p/b$b;->g:Ld/p/b$b;

    if-ne v0, v2, :cond_0

    goto :goto_2

    :cond_0
    sget-object v2, Ld/p/b$b;->e:Ld/p/b$b;

    if-ne v0, v2, :cond_1

    return-void

    :cond_1
    sget-object v3, Ld/p/b$b;->b:Ld/p/b$b;

    if-ne v0, v3, :cond_2

    :goto_0
    iget-object p1, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, p1}, Ld/m;->l0(Ld/p/b;)V

    iput-object v1, p0, Ld/p/b;->p:Ld/p/b$b;

    goto :goto_1

    :cond_2
    sget-object v3, Ld/p/b$b;->d:Ld/p/b$b;

    if-ne v0, v3, :cond_3

    if-nez p1, :cond_3

    const/4 p1, 0x0

    iput-object p1, p0, Ld/p/b;->f:Ld/p/d;

    iget-object p1, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, p1}, Ld/m;->m0(Ld/p/b;)V

    iput-object v2, p0, Ld/p/b;->p:Ld/p/b$b;

    goto :goto_1

    :cond_3
    if-eq v0, v3, :cond_4

    sget-object p1, Ld/p/b$b;->c:Ld/p/b$b;

    if-ne v0, p1, :cond_4

    goto :goto_0

    :cond_4
    :goto_1
    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/p/b;->h:Z

    iget-object v0, p0, Ld/p/b;->f:Ld/p/d;

    if-eqz v0, :cond_5

    invoke-virtual {p0}, Ld/p/b;->J0()V

    new-instance v0, Ld/e;

    invoke-direct {v0}, Ld/e;-><init>()V

    invoke-virtual {v0}, Ld/e;->k()V

    iget-object v1, p0, Ld/p/b;->f:Ld/p/d;

    invoke-interface {v1, v0, p1}, Ld/p/d;->b(Ljava/lang/Object;Z)V

    invoke-virtual {p0}, Ld/p/b;->B0()V

    :cond_5
    :goto_2
    return-void
.end method

.method protected Q()V
    .locals 3

    iget-object v0, p0, Ld/p/b;->o:Ld/p/b$a;

    invoke-interface {v0, p0}, Ld/p/b$a;->a(Ld/p/b;)V

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v1, Ld/p/b$b;->f:Ld/p/b$b;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_0

    iput-object v2, p0, Ld/p/b;->f:Ld/p/d;

    iget-object v0, p0, Ld/p/b;->n:Ld/p/b;

    invoke-virtual {p0, v0}, Ld/m;->m0(Ld/p/b;)V

    :cond_0
    iget-object v0, p0, Ld/p/b;->e:Ld/p/d;

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-boolean v0, p0, Ld/p/b;->t:Z

    if-nez v0, :cond_3

    :cond_2
    iget-object v0, p0, Ld/p/b;->e:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->d()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    :cond_3
    iput-object v2, p0, Ld/p/b;->e:Ld/p/d;

    return-void
.end method

.method public Q0(Ld/e;)Z
    .locals 4

    invoke-virtual {p0}, Ld/p/b;->z0()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    invoke-virtual {p1}, Ld/e;->o()Z

    move-result v1

    iget-object v2, p0, Ld/p/b;->f:Ld/p/d;

    invoke-interface {v2, p1, v0}, Ld/p/d;->b(Ljava/lang/Object;Z)V

    if-nez v0, :cond_1

    if-nez v1, :cond_1

    iget-wide v0, p0, Ld/p/b;->l:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Ld/p/b;->l:J

    :cond_1
    const/4 p1, 0x1

    return p1
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/p/b;->u:Ld/m;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Ld/p/b;->u:Ld/m;

    invoke-virtual {v2}, Ld/m;->G()I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "]->"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Ld/p/b;->n:Ld/p/b;

    iget-object v2, v2, Ld/p/b;->u:Ld/m;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/p/b;->n:Ld/p/b;

    iget-object v1, v1, Ld/p/b;->u:Ld/m;

    invoke-virtual {v1}, Ld/m;->G()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "])"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public x0()Z
    .locals 6

    iget v0, p0, Ld/p/b;->i:I

    const/4 v1, 0x1

    if-lez v0, :cond_0

    iget-wide v2, p0, Ld/p/b;->l:J

    iget-wide v4, p0, Ld/p/b;->m:J

    sub-long/2addr v2, v4

    int-to-long v4, v0

    cmp-long v0, v2, v4

    if-ltz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    xor-int/2addr v0, v1

    return v0
.end method

.method public y0()Z
    .locals 3

    iget-boolean v0, p0, Ld/p/b;->g:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v2, Ld/p/b$b;->b:Ld/p/b$b;

    if-eq v0, v2, :cond_1

    sget-object v2, Ld/p/b$b;->d:Ld/p/b$b;

    if-eq v0, v2, :cond_1

    return v1

    :cond_1
    iget-object v0, p0, Ld/p/b;->e:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->c()Z

    move-result v0

    if-nez v0, :cond_2

    iput-boolean v1, p0, Ld/p/b;->g:Z

    return v1

    :cond_2
    iget-object v0, p0, Ld/p/b;->e:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/e;

    invoke-static {v0}, Ld/p/b;->F0(Ld/e;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Ld/p/b;->e:Ld/p/d;

    invoke-interface {v0}, Ld/p/d;->d()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/e;

    invoke-direct {p0}, Ld/p/b;->H0()V

    return v1

    :cond_3
    const/4 v0, 0x1

    return v0
.end method

.method public z0()Z
    .locals 3

    iget-boolean v0, p0, Ld/p/b;->h:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Ld/p/b;->p:Ld/p/b$b;

    sget-object v2, Ld/p/b$b;->b:Ld/p/b$b;

    if-eq v0, v2, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ld/p/b;->x0()Z

    move-result v0

    const/4 v2, 0x1

    xor-int/2addr v0, v2

    if-eqz v0, :cond_1

    iput-boolean v1, p0, Ld/p/b;->h:Z

    return v1

    :cond_1
    return v2

    :cond_2
    :goto_0
    return v1
.end method
