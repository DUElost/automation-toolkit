.class public Ld/r/f/a;
.super Ld/j;
.source ""


# instance fields
.field private final A:Ld/r/a;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/4 p2, 0x7

    iput p2, p1, Ld/f;->j:I

    new-instance p1, Ld/r/a;

    invoke-direct {p1}, Ld/r/a;-><init>()V

    iput-object p1, p0, Ld/r/f/a;->A:Ld/r/a;

    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 0

    iget-object p2, p0, Ld/r/f/a;->A:Ld/r/a;

    invoke-virtual {p2, p1}, Ld/r/a;->b(Ld/p/b;)V

    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/f/a;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->d(Ld/p/b;)V

    return-void
.end method

.method protected n1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/f/a;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->a(Ld/p/b;)V

    return-void
.end method
