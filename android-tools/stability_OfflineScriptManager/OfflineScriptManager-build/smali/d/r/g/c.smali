.class public Ld/r/g/c;
.super Ld/r/g/f;
.source ""


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/r/g/f;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/4 p2, 0x1

    iput p2, p1, Ld/f;->j:I

    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 0

    invoke-virtual {p1}, Ld/p/b;->N0()V

    invoke-super {p0, p1, p2}, Ld/r/g/f;->k1(Ld/p/b;Z)V

    return-void
.end method
