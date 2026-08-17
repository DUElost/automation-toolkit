.class public Ld/r/h/a;
.super Ld/j;
.source ""


# instance fields
.field private final A:Ld/r/a;

.field private final B:Ld/r/b;

.field private C:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/4 p2, 0x5

    iput p2, p1, Ld/f;->j:I

    new-instance p1, Ld/r/a;

    invoke-direct {p1}, Ld/r/a;-><init>()V

    iput-object p1, p0, Ld/r/h/a;->A:Ld/r/a;

    new-instance p1, Ld/r/b;

    invoke-direct {p1}, Ld/r/b;-><init>()V

    iput-object p1, p0, Ld/r/h/a;->B:Ld/r/b;

    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 0

    iget-boolean p2, p0, Ld/r/h/a;->C:Z

    if-eqz p2, :cond_0

    new-instance p2, Ld/e;

    invoke-direct {p2}, Ld/e;-><init>()V

    invoke-virtual {p1, p2}, Ld/p/b;->Q0(Ld/e;)Z

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_0
    iget-object p2, p0, Ld/r/h/a;->A:Ld/r/a;

    invoke-virtual {p2, p1}, Ld/r/a;->b(Ld/p/b;)V

    iget-object p2, p0, Ld/r/h/a;->B:Ld/r/b;

    invoke-virtual {p2, p1}, Ld/r/b;->b(Ld/p/b;)V

    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/h/a;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->d(Ld/p/b;)V

    iget-object v0, p0, Ld/r/h/a;->B:Ld/r/b;

    invoke-virtual {v0, p1}, Ld/r/b;->d(Ld/p/b;)V

    return-void
.end method

.method protected n1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/h/a;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->a(Ld/p/b;)V

    return-void
.end method

.method protected o1(Ld/e;)Z
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Ld/r/h/a;->s1(Ld/e;Ld/s/f;)Z

    move-result p1

    return p1
.end method

.method protected p1(ILjava/lang/Object;)Z
    .locals 1

    const/16 v0, 0x33

    if-ne p1, v0, :cond_0

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/h/a;->C:Z

    const/4 p1, 0x1

    return p1

    :cond_0
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 p2, 0x16

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1
.end method

.method protected q1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/h/a;->B:Ld/r/b;

    invoke-virtual {v0, p1}, Ld/r/b;->a(Ld/p/b;)V

    return-void
.end method

.method protected final r1(Ld/s/f;)Ld/e;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/s/f<",
            "Ld/p/b;",
            ">;)",
            "Ld/e;"
        }
    .end annotation

    iget-object v0, p0, Ld/r/h/a;->A:Ld/r/a;

    iget-object v1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v0, v1, p1}, Ld/r/a;->c(Ld/s/c;Ld/s/f;)Ld/e;

    move-result-object p1

    return-object p1
.end method

.method protected final s1(Ld/e;Ld/s/f;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/e;",
            "Ld/s/f<",
            "Ld/p/b;",
            ">;)Z"
        }
    .end annotation

    iget-object v0, p0, Ld/r/h/a;->B:Ld/r/b;

    iget-object v1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v0, p1, v1, p2}, Ld/r/b;->c(Ld/e;Ld/s/c;Ld/s/f;)Z

    move-result p1

    return p1
.end method

.method protected t1()Ld/e;
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ld/r/h/a;->r1(Ld/s/f;)Ld/e;

    move-result-object v0

    return-object v0
.end method
