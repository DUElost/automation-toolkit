.class public abstract Lorg/achartengine/i/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field protected a:Lorg/achartengine/f/a;

.field protected b:Lorg/achartengine/h/d;


# direct methods
.method public constructor <init>(Lorg/achartengine/f/a;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/achartengine/i/a;->a:Lorg/achartengine/f/a;

    instance-of v0, p1, Lorg/achartengine/f/i;

    if-eqz v0, :cond_0

    check-cast p1, Lorg/achartengine/f/i;

    invoke-virtual {p1}, Lorg/achartengine/f/i;->B()Lorg/achartengine/h/d;

    move-result-object p1

    iput-object p1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    :cond_0
    return-void
.end method


# virtual methods
.method public a([DI)V
    .locals 5

    iget-object v0, p0, Lorg/achartengine/i/a;->a:Lorg/achartengine/f/a;

    instance-of v1, v0, Lorg/achartengine/f/i;

    if-eqz v1, :cond_3

    check-cast v0, Lorg/achartengine/f/i;

    invoke-virtual {v0, p2}, Lorg/achartengine/f/i;->x(I)[D

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v1, p2}, Lorg/achartengine/h/d;->T0(I)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x0

    aget-wide v2, v0, v1

    aput-wide v2, p1, v1

    iget-object v2, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    aget-wide v3, p1, v1

    invoke-virtual {v2, v3, v4, p2}, Lorg/achartengine/h/d;->k1(DI)V

    :cond_0
    iget-object v1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v1, p2}, Lorg/achartengine/h/d;->R0(I)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x1

    aget-wide v2, v0, v1

    aput-wide v2, p1, v1

    iget-object v2, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    aget-wide v3, p1, v1

    invoke-virtual {v2, v3, v4, p2}, Lorg/achartengine/h/d;->i1(DI)V

    :cond_1
    iget-object v1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v1, p2}, Lorg/achartengine/h/d;->U0(I)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x2

    aget-wide v2, v0, v1

    aput-wide v2, p1, v1

    iget-object v2, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    aget-wide v3, p1, v1

    invoke-virtual {v2, v3, v4, p2}, Lorg/achartengine/h/d;->s1(DI)V

    :cond_2
    iget-object v1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v1, p2}, Lorg/achartengine/h/d;->S0(I)Z

    move-result v1

    if-nez v1, :cond_3

    const/4 v1, 0x3

    aget-wide v2, v0, v1

    aput-wide v2, p1, v1

    iget-object v0, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    aget-wide v1, p1, v1

    invoke-virtual {v0, v1, v2, p2}, Lorg/achartengine/h/d;->q1(DI)V

    :cond_3
    return-void
.end method

.method public b(I)[D
    .locals 9

    iget-object v0, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0, p1}, Lorg/achartengine/h/d;->o0(I)D

    move-result-wide v0

    iget-object v2, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v2, p1}, Lorg/achartengine/h/d;->n0(I)D

    move-result-wide v2

    iget-object v4, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v4, p1}, Lorg/achartengine/h/d;->z0(I)D

    move-result-wide v4

    iget-object v6, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v6, p1}, Lorg/achartengine/h/d;->y0(I)D

    move-result-wide v6

    const/4 p1, 0x4

    new-array p1, p1, [D

    const/4 v8, 0x0

    aput-wide v0, p1, v8

    const/4 v0, 0x1

    aput-wide v2, p1, v0

    const/4 v0, 0x2

    aput-wide v4, p1, v0

    const/4 v0, 0x3

    aput-wide v6, p1, v0

    return-object p1
.end method

.method protected c(DDI)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0, p1, p2, p5}, Lorg/achartengine/h/d;->k1(DI)V

    iget-object p1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {p1, p3, p4, p5}, Lorg/achartengine/h/d;->i1(DI)V

    return-void
.end method

.method protected d(DDI)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {v0, p1, p2, p5}, Lorg/achartengine/h/d;->s1(DI)V

    iget-object p1, p0, Lorg/achartengine/i/a;->b:Lorg/achartengine/h/d;

    invoke-virtual {p1, p3, p4, p5}, Lorg/achartengine/h/d;->q1(DI)V

    return-void
.end method
