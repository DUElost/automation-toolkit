.class public Lb/b/a/a/d/g;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/b/a/a/d/c;
.implements Ljava/io/Serializable;


# instance fields
.field private b:Z

.field private c:Ljava/lang/String;

.field private d:I

.field private e:Ljava/lang/String;

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/d/b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/b/a/a/d/g;->b:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/a/d/g;->f:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/b/a/a/d/g;->d:I

    return v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    const-string v0, ""

    return-object v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/d/g;->c:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/d/g;->c:Ljava/lang/String;

    return-object v0
.end method

.method public e()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/b/a/a/d/b;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/d/g;->f:Ljava/util/List;

    return-object v0
.end method

.method public f(Lb/b/a/a/d/b;)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lb/b/a/a/d/g;->f:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/d/g;->e:Ljava/lang/String;

    return-void
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    const-string v0, "TestCase"

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    const-string v0, ""

    return-object v0
.end method

.method public i()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/d/g;->e:Ljava/lang/String;

    return-object v0
.end method

.method public j()Z
    .locals 1

    iget-boolean v0, p0, Lb/b/a/a/d/g;->b:Z

    return v0
.end method

.method public k()Ljava/lang/String;
    .locals 1

    const-string v0, ""

    return-object v0
.end method

.method public l(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/b/a/a/d/g;->b:Z

    return-void
.end method

.method public m(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/d/g;->d:I

    return-void
.end method

.method public n(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lb/b/a/a/d/b;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lb/b/a/a/d/g;->f:Ljava/util/List;

    return-void
.end method
