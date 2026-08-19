.class public Lb/c/a/i/j0/a;
.super Ljava/util/AbstractList;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/AbstractList<",
        "Lb/e/a/h/f;",
        ">;"
    }
.end annotation


# instance fields
.field b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public varargs constructor <init>(Lb/c/a/i/f0;[Lb/c/a/d;)V
    .locals 4

    invoke-direct {p0}, Ljava/util/AbstractList;-><init>()V

    invoke-virtual {p1}, Lb/e/a/b;->getParent()Lb/c/a/i/e;

    move-result-object v0

    check-cast v0, Lb/c/a/i/b;

    invoke-interface {v0}, Lb/c/a/i/b;->getParent()Lb/c/a/i/e;

    move-result-object v0

    invoke-virtual {p1}, Lb/e/a/b;->getParent()Lb/c/a/i/e;

    move-result-object v1

    const-class v2, Lb/c/a/i/i0/a;

    invoke-interface {v1, v2}, Lb/c/a/i/e;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    array-length p2, p2

    if-gtz p2, :cond_0

    new-instance p2, Lb/e/a/h/k/a;

    invoke-virtual {p1}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object p1

    invoke-virtual {p1}, Lb/c/a/i/g0;->A()J

    move-result-wide v1

    invoke-direct {p2, v1, v2, v0}, Lb/e/a/h/k/a;-><init>(JLb/c/a/i/e;)V

    iput-object p2, p0, Lb/c/a/i/j0/a;->b:Ljava/util/List;

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "The TrackBox comes from a standard MP4 file. Only use the additionalFragments param if you are dealing with ( fragmented MP4 files AND additional fragments in standalone files )"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    new-instance v1, Lb/e/a/h/k/b;

    invoke-virtual {p1}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object p1

    invoke-virtual {p1}, Lb/c/a/i/g0;->A()J

    move-result-wide v2

    invoke-direct {v1, v2, v3, v0, p2}, Lb/e/a/h/k/b;-><init>(JLb/c/a/i/e;[Lb/c/a/d;)V

    iput-object v1, p0, Lb/c/a/i/j0/a;->b:Ljava/util/List;

    :goto_0
    return-void
.end method


# virtual methods
.method public a(I)Lb/e/a/h/f;
    .locals 1

    iget-object v0, p0, Lb/c/a/i/j0/a;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lb/e/a/h/f;

    return-object p1
.end method

.method public bridge synthetic get(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lb/c/a/i/j0/a;->a(I)Lb/e/a/h/f;

    move-result-object p1

    return-object p1
.end method

.method public size()I
    .locals 1

    iget-object v0, p0, Lb/c/a/i/j0/a;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method
