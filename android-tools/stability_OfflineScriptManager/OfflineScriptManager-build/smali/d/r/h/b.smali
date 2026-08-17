.class public Ld/r/h/b;
.super Ld/r/h/d;
.source ""


# instance fields
.field private K:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/r/h/d;-><init>(Ld/c;II)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/r/h/b;->K:Z

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/4 p2, 0x4

    iput p2, p1, Ld/f;->j:I

    return-void
.end method


# virtual methods
.method protected o1(Ld/e;)Z
    .locals 2

    iget-boolean v0, p0, Ld/r/h/b;->K:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfb

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    invoke-super {p0, p1}, Ld/r/h/d;->o1(Ld/e;)Z

    move-result p1

    if-nez p1, :cond_1

    return v1

    :cond_1
    if-nez v0, :cond_2

    iput-boolean v1, p0, Ld/r/h/b;->K:Z

    :cond_2
    const/4 p1, 0x1

    return p1
.end method
