.class public Ld/r/g/g;
.super Ld/j;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/g/g$a;
    }
.end annotation


# instance fields
.field private final A:Ld/r/a;

.field private final B:Ld/r/g/a;

.field private final C:Ld/r/g/e;

.field private final D:Ld/r/g/e$a;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    new-instance p1, Ld/r/g/g$a;

    const/4 p2, 0x0

    invoke-direct {p1, p0, p2}, Ld/r/g/g$a;-><init>(Ld/r/g/g;Ld/r/g/g$a;)V

    iput-object p1, p0, Ld/r/g/g;->D:Ld/r/g/e$a;

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/16 p2, 0xa

    iput p2, p1, Ld/f;->j:I

    const/4 p2, 0x0

    iput p2, p1, Ld/f;->k:I

    new-instance p1, Ld/r/a;

    invoke-direct {p1}, Ld/r/a;-><init>()V

    iput-object p1, p0, Ld/r/g/g;->A:Ld/r/a;

    new-instance p1, Ld/r/g/a;

    invoke-direct {p1}, Ld/r/g/a;-><init>()V

    iput-object p1, p0, Ld/r/g/g;->B:Ld/r/g/a;

    new-instance p1, Ld/r/g/e;

    invoke-direct {p1}, Ld/r/g/e;-><init>()V

    iput-object p1, p0, Ld/r/g/g;->C:Ld/r/g/e;

    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    return-void
.end method

.method static synthetic r1(Ld/r/g/g;[BILd/p/b;)Z
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/r/g/g;->s1([BILd/p/b;)Z

    move-result p0

    return p0
.end method

.method private s1([BILd/p/b;)Z
    .locals 3

    new-instance v0, Ld/e;

    add-int/lit8 v1, p2, 0x1

    invoke-direct {v0, v1}, Ld/e;-><init>(I)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ld/e;->p(B)Ld/e;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, p1, v2, p2}, Ld/e;->v([BII)Ld/e;

    invoke-virtual {p3, v0}, Ld/p/b;->Q0(Ld/e;)Z

    move-result p1

    return p1
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 1

    iget-object p2, p0, Ld/r/g/g;->A:Ld/r/a;

    invoke-virtual {p2, p1}, Ld/r/a;->b(Ld/p/b;)V

    iget-object p2, p0, Ld/r/g/g;->B:Ld/r/g/a;

    invoke-virtual {p2, p1}, Ld/r/g/a;->b(Ld/p/b;)V

    iget-object p2, p0, Ld/r/g/g;->C:Ld/r/g/e;

    iget-object v0, p0, Ld/r/g/g;->D:Ld/r/g/e$a;

    invoke-virtual {p2, v0, p1}, Ld/r/g/e;->b(Ld/r/g/e$a;Ld/p/b;)V

    invoke-virtual {p1}, Ld/p/b;->B0()V

    return-void
.end method

.method protected l1(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/g/g;->C:Ld/r/g/e;

    iget-object v1, p0, Ld/r/g/g;->D:Ld/r/g/e$a;

    invoke-virtual {v0, v1, p1}, Ld/r/g/e;->b(Ld/r/g/e$a;Ld/p/b;)V

    invoke-virtual {p1}, Ld/p/b;->B0()V

    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/g/g;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->d(Ld/p/b;)V

    iget-object v0, p0, Ld/r/g/g;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->h(Ld/p/b;)V

    return-void
.end method

.method protected n1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/g/g;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->a(Ld/p/b;)V

    return-void
.end method

.method protected o1(Ld/e;)Z
    .locals 4

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-lez v0, :cond_1

    invoke-virtual {p1, v1}, Ld/e;->e(I)B

    move-result v3

    if-ne v3, v2, :cond_1

    iget-object v1, p0, Ld/r/g/g;->C:Ld/r/g/e;

    sub-int/2addr v0, v2

    invoke-virtual {v1, p1, v2, v0}, Ld/r/g/e;->a(Ld/e;II)Z

    :cond_0
    :goto_0
    iget-object v0, p0, Ld/r/g/g;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->f(Ld/e;)Z

    move-result p1

    return p1

    :cond_1
    if-lez v0, :cond_0

    invoke-virtual {p1, v1}, Ld/e;->e(I)B

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Ld/r/g/g;->C:Ld/r/g/e;

    sub-int/2addr v0, v2

    invoke-virtual {v1, p1, v2, v0}, Ld/r/g/e;->f(Ld/e;II)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :cond_2
    return v2
.end method

.method protected q1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/g/g;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->a(Ld/p/b;)V

    return-void
.end method
