.class public Lb/b/a/a/c/h;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/b/a/a/c/b;
.implements Ljava/io/Serializable;


# instance fields
.field private b:Ljava/lang/String;

.field private c:I

.field private d:Z

.field private e:I

.field private f:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/c/h;->c:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lb/b/a/a/c/h;->d:Z

    iput v0, p0, Lb/b/a/a/c/h;->e:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/a/c/h;->f:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/h;->c:I

    return v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/h;->c:I

    return-void
.end method

.method public c(Lb/b/a/a/c/c;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lb/b/a/a/c/h;->f:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public d()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/h;->e:I

    return v0
.end method

.method public e()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/c;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/c/h;->f:Ljava/util/ArrayList;

    return-object v0
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/b/a/a/c/c;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/c/h;->f:Ljava/util/ArrayList;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public g()Z
    .locals 1

    iget-boolean v0, p0, Lb/b/a/a/c/h;->d:Z

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/h;->b:Ljava/lang/String;

    return-object v0
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/h;->b:Ljava/lang/String;

    return-void
.end method

.method public i(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/h;->e:I

    return-void
.end method

.method public j(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/b/a/a/c/h;->d:Z

    return-void
.end method
