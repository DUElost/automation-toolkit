.class public La/m/q;
.super La/m/m;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        La/m/q$b;
    }
.end annotation


# instance fields
.field private K:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "La/m/m;",
            ">;"
        }
    .end annotation
.end field

.field private L:Z

.field M:I

.field N:Z

.field private O:I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, La/m/m;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    const/4 v0, 0x1

    iput-boolean v0, p0, La/m/q;->L:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, La/m/q;->N:Z

    iput v0, p0, La/m/q;->O:I

    return-void
.end method

.method private m0()V
    .locals 3

    new-instance v0, La/m/q$b;

    invoke-direct {v0, p0}, La/m/q$b;-><init>(La/m/q;)V

    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, v0}, La/m/m;->a(La/m/m$f;)La/m/m;

    goto :goto_0

    :cond_0
    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iput v0, p0, La/m/q;->M:I

    return-void
.end method


# virtual methods
.method public M(Landroid/view/View;)V
    .locals 3

    invoke-super {p0, p1}, La/m/m;->M(Landroid/view/View;)V

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1}, La/m/m;->M(Landroid/view/View;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public bridge synthetic O(La/m/m$f;)La/m/m;
    .locals 0

    invoke-virtual {p0, p1}, La/m/q;->g0(La/m/m$f;)La/m/q;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic P(Landroid/view/View;)La/m/m;
    .locals 0

    invoke-virtual {p0, p1}, La/m/q;->h0(Landroid/view/View;)La/m/q;

    move-result-object p1

    return-object p1
.end method

.method public Q(Landroid/view/View;)V
    .locals 3

    invoke-super {p0, p1}, La/m/m;->Q(Landroid/view/View;)V

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1}, La/m/m;->Q(Landroid/view/View;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method protected S()V
    .locals 4

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, La/m/m;->Z()V

    invoke-virtual {p0}, La/m/m;->o()V

    return-void

    :cond_0
    invoke-direct {p0}, La/m/q;->m0()V

    iget-boolean v0, p0, La/m/q;->L:Z

    if-nez v0, :cond_2

    const/4 v0, 0x1

    :goto_0
    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    add-int/lit8 v2, v0, -0x1

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    new-instance v3, La/m/q$a;

    invoke-direct {v3, p0, v2}, La/m/q$a;-><init>(La/m/q;La/m/m;)V

    invoke-virtual {v1, v3}, La/m/m;->a(La/m/m$f;)La/m/m;

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, La/m/m;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, La/m/m;->S()V

    goto :goto_2

    :cond_2
    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    invoke-virtual {v1}, La/m/m;->S()V

    goto :goto_1

    :cond_3
    :goto_2
    return-void
.end method

.method public bridge synthetic T(J)La/m/m;
    .locals 0

    invoke-virtual {p0, p1, p2}, La/m/q;->i0(J)La/m/q;

    return-object p0
.end method

.method public U(La/m/m$e;)V
    .locals 3

    invoke-super {p0, p1}, La/m/m;->U(La/m/m$e;)V

    iget v0, p0, La/m/q;->O:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, La/m/q;->O:I

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1}, La/m/m;->U(La/m/m$e;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public bridge synthetic V(Landroid/animation/TimeInterpolator;)La/m/m;
    .locals 0

    invoke-virtual {p0, p1}, La/m/q;->j0(Landroid/animation/TimeInterpolator;)La/m/q;

    move-result-object p1

    return-object p1
.end method

.method public W(La/m/g;)V
    .locals 2

    invoke-super {p0, p1}, La/m/m;->W(La/m/g;)V

    iget v0, p0, La/m/q;->O:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, La/m/q;->O:I

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    invoke-virtual {v1, p1}, La/m/m;->W(La/m/g;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public X(La/m/p;)V
    .locals 3

    invoke-super {p0, p1}, La/m/m;->X(La/m/p;)V

    iget v0, p0, La/m/q;->O:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, La/m/q;->O:I

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1}, La/m/m;->X(La/m/p;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public bridge synthetic Y(J)La/m/m;
    .locals 0

    invoke-virtual {p0, p1, p2}, La/m/q;->l0(J)La/m/q;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic a(La/m/m$f;)La/m/m;
    .locals 0

    invoke-virtual {p0, p1}, La/m/q;->b0(La/m/m$f;)La/m/q;

    move-result-object p1

    return-object p1
.end method

.method a0(Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    invoke-super {p0, p1}, La/m/m;->a0(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\n"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, La/m/m;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, La/m/m;->a0(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public bridge synthetic b(Landroid/view/View;)La/m/m;
    .locals 0

    invoke-virtual {p0, p1}, La/m/q;->c0(Landroid/view/View;)La/m/q;

    move-result-object p1

    return-object p1
.end method

.method public b0(La/m/m$f;)La/m/q;
    .locals 0

    invoke-super {p0, p1}, La/m/m;->a(La/m/m$f;)La/m/m;

    move-object p1, p0

    check-cast p1, La/m/q;

    return-object p1
.end method

.method public c0(Landroid/view/View;)La/m/q;
    .locals 2

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    invoke-virtual {v1, p1}, La/m/m;->b(Landroid/view/View;)La/m/m;

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-super {p0, p1}, La/m/m;->b(Landroid/view/View;)La/m/m;

    move-object p1, p0

    check-cast p1, La/m/q;

    return-object p1
.end method

.method public bridge synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, La/m/q;->l()La/m/m;

    move-result-object v0

    return-object v0
.end method

.method public d0(La/m/m;)La/m/q;
    .locals 4

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iput-object p0, p1, La/m/m;->s:La/m/q;

    iget-wide v0, p0, La/m/m;->d:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-ltz v2, :cond_0

    invoke-virtual {p1, v0, v1}, La/m/m;->T(J)La/m/m;

    :cond_0
    iget v0, p0, La/m/q;->O:I

    and-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_1

    invoke-virtual {p0}, La/m/m;->r()Landroid/animation/TimeInterpolator;

    move-result-object v0

    invoke-virtual {p1, v0}, La/m/m;->V(Landroid/animation/TimeInterpolator;)La/m/m;

    :cond_1
    iget v0, p0, La/m/q;->O:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_2

    invoke-virtual {p0}, La/m/m;->v()La/m/p;

    move-result-object v0

    invoke-virtual {p1, v0}, La/m/m;->X(La/m/p;)V

    :cond_2
    iget v0, p0, La/m/q;->O:I

    and-int/lit8 v0, v0, 0x4

    if-eqz v0, :cond_3

    invoke-virtual {p0}, La/m/m;->u()La/m/g;

    move-result-object v0

    invoke-virtual {p1, v0}, La/m/m;->W(La/m/g;)V

    :cond_3
    iget v0, p0, La/m/q;->O:I

    and-int/lit8 v0, v0, 0x8

    if-eqz v0, :cond_4

    invoke-virtual {p0}, La/m/m;->q()La/m/m$e;

    move-result-object v0

    invoke-virtual {p1, v0}, La/m/m;->U(La/m/m$e;)V

    :cond_4
    return-object p0
.end method

.method public e0(I)La/m/m;
    .locals 1

    if-ltz p1, :cond_1

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, La/m/m;

    return-object p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public f(La/m/s;)V
    .locals 3

    iget-object v0, p1, La/m/s;->b:Landroid/view/View;

    invoke-virtual {p0, v0}, La/m/m;->F(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    iget-object v2, p1, La/m/s;->b:Landroid/view/View;

    invoke-virtual {v1, v2}, La/m/m;->F(Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1, p1}, La/m/m;->f(La/m/s;)V

    iget-object v2, p1, La/m/s;->c:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-void
.end method

.method public f0()I
    .locals 1

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public g0(La/m/m$f;)La/m/q;
    .locals 0

    invoke-super {p0, p1}, La/m/m;->O(La/m/m$f;)La/m/m;

    move-object p1, p0

    check-cast p1, La/m/q;

    return-object p1
.end method

.method h(La/m/s;)V
    .locals 3

    invoke-super {p0, p1}, La/m/m;->h(La/m/s;)V

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1}, La/m/m;->h(La/m/s;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public h0(Landroid/view/View;)La/m/q;
    .locals 2

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    invoke-virtual {v1, p1}, La/m/m;->P(Landroid/view/View;)La/m/m;

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-super {p0, p1}, La/m/m;->P(Landroid/view/View;)La/m/m;

    move-object p1, p0

    check-cast p1, La/m/q;

    return-object p1
.end method

.method public i(La/m/s;)V
    .locals 3

    iget-object v0, p1, La/m/s;->b:Landroid/view/View;

    invoke-virtual {p0, v0}, La/m/m;->F(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, La/m/m;

    iget-object v2, p1, La/m/s;->b:Landroid/view/View;

    invoke-virtual {v1, v2}, La/m/m;->F(Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1, p1}, La/m/m;->i(La/m/s;)V

    iget-object v2, p1, La/m/s;->c:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-void
.end method

.method public i0(J)La/m/q;
    .locals 4

    invoke-super {p0, p1, p2}, La/m/m;->T(J)La/m/m;

    iget-wide v0, p0, La/m/m;->d:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1, p2}, La/m/m;->T(J)La/m/m;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object p0
.end method

.method public j0(Landroid/animation/TimeInterpolator;)La/m/q;
    .locals 3

    iget v0, p0, La/m/q;->O:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, La/m/q;->O:I

    iget-object v0, p0, La/m/q;->K:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, La/m/m;

    invoke-virtual {v2, p1}, La/m/m;->V(Landroid/animation/TimeInterpolator;)La/m/m;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    invoke-super {p0, p1}, La/m/m;->V(Landroid/animation/TimeInterpolator;)La/m/m;

    move-object p1, p0

    check-cast p1, La/m/q;

    return-object p1
.end method

.method public k0(I)La/m/q;
    .locals 3

    const/4 v0, 0x1

    if-eqz p1, :cond_1

    if-ne p1, v0, :cond_0

    const/4 p1, 0x0

    iput-boolean p1, p0, La/m/q;->L:Z

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/util/AndroidRuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid parameter for TransitionSet ordering: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Landroid/util/AndroidRuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    iput-boolean v0, p0, La/m/q;->L:Z

    :goto_0
    return-object p0
.end method

.method public l()La/m/m;
    .locals 4

    invoke-super {p0}, La/m/m;->l()La/m/m;

    move-result-object v0

    check-cast v0, La/m/q;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, La/m/q;->K:Ljava/util/ArrayList;

    iget-object v1, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    iget-object v3, p0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, La/m/m;

    invoke-virtual {v3}, La/m/m;->l()La/m/m;

    move-result-object v3

    invoke-virtual {v0, v3}, La/m/q;->d0(La/m/m;)La/m/q;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public l0(J)La/m/q;
    .locals 0

    invoke-super {p0, p1, p2}, La/m/m;->Y(J)La/m/m;

    move-object p1, p0

    check-cast p1, La/m/q;

    return-object p1
.end method

.method protected n(Landroid/view/ViewGroup;La/m/t;La/m/t;Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/ViewGroup;",
            "La/m/t;",
            "La/m/t;",
            "Ljava/util/ArrayList<",
            "La/m/s;",
            ">;",
            "Ljava/util/ArrayList<",
            "La/m/s;",
            ">;)V"
        }
    .end annotation

    move-object v0, p0

    invoke-virtual {p0}, La/m/m;->x()J

    move-result-wide v1

    iget-object v3, v0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_3

    iget-object v5, v0, La/m/q;->K:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    move-object v6, v5

    check-cast v6, La/m/m;

    const-wide/16 v7, 0x0

    cmp-long v5, v1, v7

    if-lez v5, :cond_2

    iget-boolean v5, v0, La/m/q;->L:Z

    if-nez v5, :cond_0

    if-nez v4, :cond_2

    :cond_0
    invoke-virtual {v6}, La/m/m;->x()J

    move-result-wide v9

    cmp-long v5, v9, v7

    if-lez v5, :cond_1

    add-long/2addr v9, v1

    invoke-virtual {v6, v9, v10}, La/m/m;->Y(J)La/m/m;

    goto :goto_1

    :cond_1
    invoke-virtual {v6, v1, v2}, La/m/m;->Y(J)La/m/m;

    :cond_2
    :goto_1
    move-object v7, p1

    move-object v8, p2

    move-object v9, p3

    move-object/from16 v10, p4

    move-object/from16 v11, p5

    invoke-virtual/range {v6 .. v11}, La/m/m;->n(Landroid/view/ViewGroup;La/m/t;La/m/t;Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method
