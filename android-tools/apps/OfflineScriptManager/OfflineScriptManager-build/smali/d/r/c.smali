.class public Ld/r/c;
.super Ld/j;
.source ""


# instance fields
.field private A:Ld/p/b;

.field private B:Ld/p/b;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/4 p2, 0x0

    iput p2, p1, Ld/f;->j:I

    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 0

    iget-object p2, p0, Ld/r/c;->A:Ld/p/b;

    if-nez p2, :cond_0

    iput-object p1, p0, Ld/r/c;->A:Ld/p/b;

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Ld/p/b;->P0(Z)V

    :goto_0
    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/c;->A:Ld/p/b;

    if-ne v0, p1, :cond_1

    iget-object v0, p0, Ld/r/c;->B:Ld/p/b;

    const/4 v1, 0x0

    if-ne v0, p1, :cond_0

    invoke-virtual {v0}, Ld/p/b;->C0()Ld/s/a;

    iput-object v1, p0, Ld/r/c;->B:Ld/p/b;

    :cond_0
    iput-object v1, p0, Ld/r/c;->A:Ld/p/b;

    :cond_1
    return-void
.end method

.method protected n1(Ld/p/b;)V
    .locals 0

    return-void
.end method

.method protected o1(Ld/e;)Z
    .locals 1

    iget-object v0, p0, Ld/r/c;->A:Ld/p/b;

    if-eqz v0, :cond_2

    invoke-virtual {v0, p1}, Ld/p/b;->Q0(Ld/e;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Ld/r/c;->A:Ld/p/b;

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_1
    const/4 p1, 0x1

    return p1

    :cond_2
    :goto_0
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x23

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1
.end method

.method protected q1(Ld/p/b;)V
    .locals 0

    return-void
.end method

.method protected y0()V
    .locals 0

    invoke-super {p0}, Ld/j;->y0()V

    return-void
.end method
