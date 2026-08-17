.class public Lorg/achartengine/h/d;
.super Lorg/achartengine/h/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/achartengine/h/d$a;
    }
.end annotation


# instance fields
.field private J:Ljava/lang/String;

.field private K:[Ljava/lang/String;

.field private L:F

.field private M:[D

.field private N:[D

.field private O:[D

.field private P:[D

.field private Q:I

.field private R:I

.field private S:Lorg/achartengine/h/d$a;

.field private T:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Double;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private U:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/util/Map<",
            "Ljava/lang/Double;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private V:Z

.field private W:Z

.field private X:Z

.field private Y:Z

.field private Z:I

.field private a0:[D

.field private b0:[D

.field private c0:F

.field private d0:F

.field private e0:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "[D>;"
        }
    .end annotation
.end field

.field private f0:F

.field private g0:[I

.field private h0:I

.field private i0:Landroid/graphics/Paint$Align;

.field private j0:[Landroid/graphics/Paint$Align;

.field private k0:F

.field private l0:F

.field private m0:F

.field private n0:[Landroid/graphics/Paint$Align;

.field private o0:I

.field private p0:[I

.field private q0:Z

.field private r0:Ljava/text/NumberFormat;

.field private s0:D

.field private t0:D


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lorg/achartengine/h/d;-><init>(I)V

    return-void
.end method

.method public constructor <init>(I)V
    .locals 4

    invoke-direct {p0}, Lorg/achartengine/h/b;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lorg/achartengine/h/d;->J:Ljava/lang/String;

    const/high16 v0, 0x41400000    # 12.0f

    iput v0, p0, Lorg/achartengine/h/d;->L:F

    const/4 v0, 0x5

    iput v0, p0, Lorg/achartengine/h/d;->Q:I

    iput v0, p0, Lorg/achartengine/h/d;->R:I

    sget-object v0, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    iput-object v0, p0, Lorg/achartengine/h/d;->S:Lorg/achartengine/h/d$a;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/achartengine/h/d;->T:Ljava/util/Map;

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lorg/achartengine/h/d;->U:Ljava/util/Map;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/achartengine/h/d;->V:Z

    iput-boolean v0, p0, Lorg/achartengine/h/d;->W:Z

    iput-boolean v0, p0, Lorg/achartengine/h/d;->X:Z

    iput-boolean v0, p0, Lorg/achartengine/h/d;->Y:Z

    const/4 v1, 0x0

    iput v1, p0, Lorg/achartengine/h/d;->Z:I

    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v2, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    const/high16 v2, 0x40400000    # 3.0f

    iput v2, p0, Lorg/achartengine/h/d;->f0:F

    sget-object v2, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    iput-object v2, p0, Lorg/achartengine/h/d;->i0:Landroid/graphics/Paint$Align;

    const/4 v2, 0x0

    iput v2, p0, Lorg/achartengine/h/d;->k0:F

    iput v2, p0, Lorg/achartengine/h/d;->l0:F

    const/high16 v2, 0x40000000    # 2.0f

    iput v2, p0, Lorg/achartengine/h/d;->m0:F

    const v2, -0x333334

    iput v2, p0, Lorg/achartengine/h/d;->o0:I

    new-array v3, v0, [I

    aput v2, v3, v1

    iput-object v3, p0, Lorg/achartengine/h/d;->p0:[I

    iput-boolean v0, p0, Lorg/achartengine/h/d;->q0:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lorg/achartengine/h/d;->s0:D

    iput-wide v0, p0, Lorg/achartengine/h/d;->t0:D

    iput p1, p0, Lorg/achartengine/h/d;->h0:I

    invoke-virtual {p0, p1}, Lorg/achartengine/h/d;->N0(I)V

    return-void
.end method


# virtual methods
.method public A()Z
    .locals 1

    invoke-virtual {p0}, Lorg/achartengine/h/d;->V0()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lorg/achartengine/h/d;->W0()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public A0()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->R:I

    return v0
.end method

.method public B0(I)Landroid/graphics/Paint$Align;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->j0:[Landroid/graphics/Paint$Align;

    aget-object p1, v0, p1

    return-object p1
.end method

.method public C0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->d0:F

    return v0
.end method

.method public D0(I)I
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->p0:[I

    aget p1, v0, p1

    return p1
.end method

.method public E0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->l0:F

    return v0
.end method

.method public F0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->m0:F

    return v0
.end method

.method public declared-synchronized G0(Ljava/lang/Double;I)Ljava/lang/String;
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/h/d;->U:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-interface {v0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized H0(I)[Ljava/lang/Double;
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/h/d;->U:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Map;

    invoke-interface {p1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object p1

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Double;

    invoke-interface {p1, v0}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/Double;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public I0()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lorg/achartengine/h/d;->J0(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public J0(I)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->K:[Ljava/lang/String;

    aget-object p1, v0, p1

    return-object p1
.end method

.method public K()Z
    .locals 1

    invoke-virtual {p0}, Lorg/achartengine/h/d;->Y0()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lorg/achartengine/h/d;->Z0()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public K0()D
    .locals 2

    iget-wide v0, p0, Lorg/achartengine/h/d;->s0:D

    return-wide v0
.end method

.method public L0()D
    .locals 2

    iget-wide v0, p0, Lorg/achartengine/h/d;->t0:D

    return-wide v0
.end method

.method public M0()[D
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->b0:[D

    return-object v0
.end method

.method public N0(I)V
    .locals 4

    new-array v0, p1, [Ljava/lang/String;

    iput-object v0, p0, Lorg/achartengine/h/d;->K:[Ljava/lang/String;

    new-array v0, p1, [Landroid/graphics/Paint$Align;

    iput-object v0, p0, Lorg/achartengine/h/d;->j0:[Landroid/graphics/Paint$Align;

    new-array v0, p1, [Landroid/graphics/Paint$Align;

    iput-object v0, p0, Lorg/achartengine/h/d;->n0:[Landroid/graphics/Paint$Align;

    new-array v0, p1, [I

    iput-object v0, p0, Lorg/achartengine/h/d;->p0:[I

    new-array v0, p1, [D

    iput-object v0, p0, Lorg/achartengine/h/d;->M:[D

    new-array v0, p1, [D

    iput-object v0, p0, Lorg/achartengine/h/d;->N:[D

    new-array v0, p1, [D

    iput-object v0, p0, Lorg/achartengine/h/d;->O:[D

    new-array v0, p1, [D

    iput-object v0, p0, Lorg/achartengine/h/d;->P:[D

    new-array v0, p1, [I

    iput-object v0, p0, Lorg/achartengine/h/d;->g0:[I

    const/4 v0, 0x0

    :goto_0
    if-lt v0, p1, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lorg/achartengine/h/d;->p0:[I

    const v2, -0x333334

    aput v2, v1, v0

    iget-object v1, p0, Lorg/achartengine/h/d;->g0:[I

    const/16 v2, 0x4b

    const/16 v3, 0xc8

    invoke-static {v2, v3, v3, v3}, Landroid/graphics/Color;->argb(IIII)I

    move-result v2

    aput v2, v1, v0

    invoke-virtual {p0, v0}, Lorg/achartengine/h/d;->O0(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public O0(I)V
    .locals 7

    iget-object v0, p0, Lorg/achartengine/h/d;->M:[D

    const-wide v1, 0x7fefffffffffffffL    # Double.MAX_VALUE

    aput-wide v1, v0, p1

    iget-object v3, p0, Lorg/achartengine/h/d;->N:[D

    const-wide v4, -0x10000000000001L

    aput-wide v4, v3, p1

    iget-object v6, p0, Lorg/achartengine/h/d;->O:[D

    aput-wide v1, v6, p1

    iget-object v1, p0, Lorg/achartengine/h/d;->P:[D

    aput-wide v4, v1, p1

    const/4 v2, 0x4

    new-array v2, v2, [D

    aget-wide v4, v0, p1

    const/4 v0, 0x0

    aput-wide v4, v2, v0

    aget-wide v4, v3, p1

    const/4 v0, 0x1

    aput-wide v4, v2, v0

    aget-wide v3, v6, p1

    const/4 v0, 0x2

    aput-wide v3, v2, v0

    aget-wide v0, v1, p1

    const/4 v3, 0x3

    aput-wide v0, v2, v3

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lorg/achartengine/h/d;->K:[Ljava/lang/String;

    const-string v1, ""

    aput-object v1, v0, p1

    iget-object v0, p0, Lorg/achartengine/h/d;->U:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lorg/achartengine/h/d;->j0:[Landroid/graphics/Paint$Align;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    aput-object v1, v0, p1

    iget-object v0, p0, Lorg/achartengine/h/d;->n0:[Landroid/graphics/Paint$Align;

    sget-object v1, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    aput-object v1, v0, p1

    return-void
.end method

.method public P0()Z
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lorg/achartengine/h/d;->Q0(I)Z

    move-result v0

    return v0
.end method

.method public Q0(I)Z
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public R0(I)Z
    .locals 5

    iget-object v0, p0, Lorg/achartengine/h/d;->N:[D

    aget-wide v1, v0, p1

    const-wide v3, -0x10000000000001L

    cmpl-double p1, v1, v3

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public S0(I)Z
    .locals 5

    iget-object v0, p0, Lorg/achartengine/h/d;->P:[D

    aget-wide v1, v0, p1

    const-wide v3, -0x10000000000001L

    cmpl-double p1, v1, v3

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public T0(I)Z
    .locals 5

    iget-object v0, p0, Lorg/achartengine/h/d;->M:[D

    aget-wide v1, v0, p1

    const-wide v3, 0x7fefffffffffffffL    # Double.MAX_VALUE

    cmpl-double p1, v1, v3

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public U0(I)Z
    .locals 5

    iget-object v0, p0, Lorg/achartengine/h/d;->O:[D

    aget-wide v1, v0, p1

    const-wide v3, 0x7fefffffffffffffL    # Double.MAX_VALUE

    cmpl-double p1, v1, v3

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public V0()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/d;->V:Z

    return v0
.end method

.method public W0()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/d;->W:Z

    return v0
.end method

.method public X0()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/d;->q0:Z

    return v0
.end method

.method public Y0()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/d;->X:Z

    return v0
.end method

.method public Z0()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/d;->Y:Z

    return v0
.end method

.method public a1(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/d;->L:F

    return-void
.end method

.method public b1(I)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/achartengine/h/d;->c1(II)V

    return-void
.end method

.method public c1(II)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->g0:[I

    aput p1, v0, p2

    return-void
.end method

.method public declared-synchronized d0(DLjava/lang/String;)V
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/h/d;->T:Ljava/util/Map;

    invoke-static {p1, p2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    invoke-interface {v0, p1, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public d1(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/d;->Z:I

    return-void
.end method

.method public e0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->L:F

    return v0
.end method

.method public e1(ZZ)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/d;->V:Z

    iput-boolean p2, p0, Lorg/achartengine/h/d;->W:Z

    return-void
.end method

.method public f0(I)I
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->g0:[I

    aget p1, v0, p1

    return p1
.end method

.method public f1(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/d;->f0:F

    return-void
.end method

.method public g0(I)[D
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [D

    return-object p1
.end method

.method public g1([DI)V
    .locals 2

    const/4 v0, 0x0

    aget-wide v0, p1, v0

    invoke-virtual {p0, v0, v1, p2}, Lorg/achartengine/h/d;->k1(DI)V

    const/4 v0, 0x1

    aget-wide v0, p1, v0

    invoke-virtual {p0, v0, v1, p2}, Lorg/achartengine/h/d;->i1(DI)V

    const/4 v0, 0x2

    aget-wide v0, p1, v0

    invoke-virtual {p0, v0, v1, p2}, Lorg/achartengine/h/d;->s1(DI)V

    const/4 v0, 0x3

    aget-wide v0, p1, v0

    invoke-virtual {p0, v0, v1, p2}, Lorg/achartengine/h/d;->q1(DI)V

    return-void
.end method

.method public h0()Ljava/text/NumberFormat;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->r0:Ljava/text/NumberFormat;

    return-object v0
.end method

.method public h1(D)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/achartengine/h/d;->i1(DI)V

    return-void
.end method

.method public i0()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->Z:I

    return v0
.end method

.method public i1(DI)V
    .locals 2

    invoke-virtual {p0, p3}, Lorg/achartengine/h/d;->R0(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    const/4 v1, 0x1

    aput-wide p1, v0, v1

    :cond_0
    iget-object v0, p0, Lorg/achartengine/h/d;->N:[D

    aput-wide p1, v0, p3

    return-void
.end method

.method public j0()Lorg/achartengine/h/d$a;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->S:Lorg/achartengine/h/d$a;

    return-object v0
.end method

.method public j1(D)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/achartengine/h/d;->k1(DI)V

    return-void
.end method

.method public k0()[D
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->a0:[D

    return-object v0
.end method

.method public k1(DI)V
    .locals 2

    invoke-virtual {p0, p3}, Lorg/achartengine/h/d;->T0(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    const/4 v1, 0x0

    aput-wide p1, v0, v1

    :cond_0
    iget-object v0, p0, Lorg/achartengine/h/d;->M:[D

    aput-wide p1, v0, p3

    return-void
.end method

.method public l0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->f0:F

    return v0
.end method

.method public l1(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/d;->Q:I

    return-void
.end method

.method public m0()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->h0:I

    return v0
.end method

.method public m1(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/d;->o0:I

    return-void
.end method

.method public n0(I)D
    .locals 3

    iget-object v0, p0, Lorg/achartengine/h/d;->N:[D

    aget-wide v1, v0, p1

    return-wide v1
.end method

.method public n1(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/d;->q0:Z

    return-void
.end method

.method public o0(I)D
    .locals 3

    iget-object v0, p0, Lorg/achartengine/h/d;->M:[D

    aget-wide v1, v0, p1

    return-wide v1
.end method

.method public o1(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/h/d;->J:Ljava/lang/String;

    return-void
.end method

.method public p0()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->Q:I

    return v0
.end method

.method public p1(D)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/achartengine/h/d;->q1(DI)V

    return-void
.end method

.method public q0()Landroid/graphics/Paint$Align;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->i0:Landroid/graphics/Paint$Align;

    return-object v0
.end method

.method public q1(DI)V
    .locals 2

    invoke-virtual {p0, p3}, Lorg/achartengine/h/d;->S0(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    const/4 v1, 0x3

    aput-wide p1, v0, v1

    :cond_0
    iget-object v0, p0, Lorg/achartengine/h/d;->P:[D

    aput-wide p1, v0, p3

    return-void
.end method

.method public r0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->c0:F

    return v0
.end method

.method public r1(D)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/achartengine/h/d;->s1(DI)V

    return-void
.end method

.method public s0()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->o0:I

    return v0
.end method

.method public s1(DI)V
    .locals 2

    invoke-virtual {p0, p3}, Lorg/achartengine/h/d;->U0(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lorg/achartengine/h/d;->e0:Ljava/util/Map;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    const/4 v1, 0x2

    aput-wide p1, v0, v1

    :cond_0
    iget-object v0, p0, Lorg/achartengine/h/d;->O:[D

    aput-wide p1, v0, p3

    return-void
.end method

.method public t0()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d;->k0:F

    return v0
.end method

.method public t1(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/d;->R:I

    return-void
.end method

.method public declared-synchronized u0(Ljava/lang/Double;)Ljava/lang/String;
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/h/d;->T:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public u1(Landroid/graphics/Paint$Align;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/achartengine/h/d;->v1(Landroid/graphics/Paint$Align;I)V

    return-void
.end method

.method public declared-synchronized v0()[Ljava/lang/Double;
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/achartengine/h/d;->T:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Double;

    invoke-interface {v0, v1}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Double;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public v1(Landroid/graphics/Paint$Align;I)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->j0:[Landroid/graphics/Paint$Align;

    aput-object p1, v0, p2

    return-void
.end method

.method public w0()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->J:Ljava/lang/String;

    return-object v0
.end method

.method public w1(II)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->p0:[I

    aput p2, v0, p1

    return-void
.end method

.method public x0(I)Landroid/graphics/Paint$Align;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->n0:[Landroid/graphics/Paint$Align;

    aget-object p1, v0, p1

    return-object p1
.end method

.method public x1(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/achartengine/h/d;->y1(Ljava/lang/String;I)V

    return-void
.end method

.method public y0(I)D
    .locals 3

    iget-object v0, p0, Lorg/achartengine/h/d;->P:[D

    aget-wide v1, v0, p1

    return-wide v1
.end method

.method public y1(Ljava/lang/String;I)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/d;->K:[Ljava/lang/String;

    aput-object p1, v0, p2

    return-void
.end method

.method public z0(I)D
    .locals 3

    iget-object v0, p0, Lorg/achartengine/h/d;->O:[D

    aget-wide v1, v0, p1

    return-wide v1
.end method

.method public z1(ZZ)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/d;->X:Z

    iput-boolean p2, p0, Lorg/achartengine/h/d;->Y:Z

    return-void
.end method
