.class public Lb/b/a/a/c/f;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/b/a/a/c/b;
.implements Ljava/io/Serializable;


# instance fields
.field private b:Ljava/lang/String;

.field private c:I

.field private d:I

.field private e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/h;",
            ">;"
        }
    .end annotation
.end field

.field private f:I

.field private g:I

.field private h:I

.field private i:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput v0, p0, Lb/b/a/a/c/f;->c:I

    const v1, 0xf731400

    iput v1, p0, Lb/b/a/a/c/f;->d:I

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lb/b/a/a/c/f;->e:Ljava/util/ArrayList;

    iput v0, p0, Lb/b/a/a/c/f;->f:I

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/c/f;->g:I

    const/4 v1, 0x2

    iput v1, p0, Lb/b/a/a/c/f;->h:I

    iput-boolean v0, p0, Lb/b/a/a/c/f;->i:Z

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/f;->c:I

    return v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/f;->c:I

    return-void
.end method

.method public c(Lb/b/a/a/c/h;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lb/b/a/a/c/f;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public d()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/f;->g:I

    return v0
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lb/b/a/a/c/f;->i:Z

    return v0
.end method

.method public f()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/f;->f:I

    return v0
.end method

.method public g()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/f;->h:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/f;->b:Ljava/lang/String;

    return-object v0
.end method

.method public h()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/h;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/c/f;->e:Ljava/util/ArrayList;

    return-object v0
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/f;->d:I

    return v0
.end method

.method public j(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/f;->g:I

    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/f;->b:Ljava/lang/String;

    return-void
.end method

.method public l(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/b/a/a/c/f;->i:Z

    return-void
.end method

.method public m(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/f;->f:I

    return-void
.end method

.method public n(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/f;->h:I

    return-void
.end method

.method public o(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/f;->d:I

    return-void
.end method
