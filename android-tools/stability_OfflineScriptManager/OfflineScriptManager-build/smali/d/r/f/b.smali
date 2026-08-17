.class public Ld/r/f/b;
.super Ld/j;
.source ""


# instance fields
.field private final A:Ld/r/b;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/16 p2, 0x8

    iput p2, p1, Ld/f;->j:I

    new-instance p1, Ld/r/b;

    invoke-direct {p1}, Ld/r/b;-><init>()V

    iput-object p1, p0, Ld/r/f/b;->A:Ld/r/b;

    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 0

    invoke-virtual {p1}, Ld/p/b;->N0()V

    iget-object p2, p0, Ld/r/f/b;->A:Ld/r/b;

    invoke-virtual {p2, p1}, Ld/r/b;->b(Ld/p/b;)V

    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/f/b;->A:Ld/r/b;

    invoke-virtual {v0, p1}, Ld/r/b;->d(Ld/p/b;)V

    return-void
.end method

.method public o1(Ld/e;)Z
    .locals 3

    iget-object v0, p0, Ld/r/f/b;->A:Ld/r/b;

    iget-object v1, p0, Ld/g;->l:Ld/s/c;

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v1, v2}, Ld/r/b;->c(Ld/e;Ld/s/c;Ld/s/f;)Z

    move-result p1

    return p1
.end method

.method protected q1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/f/b;->A:Ld/r/b;

    invoke-virtual {v0, p1}, Ld/r/b;->a(Ld/p/b;)V

    return-void
.end method
