.class public Lb/h/a/a/c/a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/h/a/a/c/a$a;,
        Lb/h/a/a/c/a$c;,
        Lb/h/a/a/c/a$b;
    }
.end annotation


# instance fields
.field private a:I

.field private b:I

.field private c:Lb/h/a/a/c/a;

.field private d:Z

.field private e:Z

.field private final f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/h/a/a/c/a;",
            ">;"
        }
    .end annotation
.end field

.field private g:Lb/h/a/a/c/a$a;

.field private h:Lb/h/a/a/c/a$b;

.field private i:Lb/h/a/a/c/a$c;

.field private j:Ljava/lang/Object;

.field private k:Z


# direct methods
.method public constructor <init>(Ljava/lang/Object;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/h/a/a/c/a;->e:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/h/a/a/c/a;->f:Ljava/util/List;

    iput-object p1, p0, Lb/h/a/a/c/a;->j:Ljava/lang/Object;

    return-void
.end method

.method private c()I
    .locals 1

    iget v0, p0, Lb/h/a/a/c/a;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lb/h/a/a/c/a;->b:I

    return v0
.end method

.method public static p()Lb/h/a/a/c/a;
    .locals 2

    new-instance v0, Lb/h/a/a/c/a;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lb/h/a/a/c/a;-><init>(Ljava/lang/Object;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lb/h/a/a/c/a;->s(Z)V

    return-object v0
.end method


# virtual methods
.method public a(Lb/h/a/a/c/a;)Lb/h/a/a/c/a;
    .locals 1

    iput-object p0, p1, Lb/h/a/a/c/a;->c:Lb/h/a/a/c/a;

    invoke-direct {p0}, Lb/h/a/a/c/a;->c()I

    move-result v0

    iput v0, p1, Lb/h/a/a/c/a;->a:I

    iget-object v0, p0, Lb/h/a/a/c/a;->f:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public varargs b([Lb/h/a/a/c/a;)Lb/h/a/a/c/a;
    .locals 3

    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    invoke-virtual {p0, v2}, Lb/h/a/a/c/a;->a(Lb/h/a/a/c/a;)Lb/h/a/a/c/a;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object p0
.end method

.method public d()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/h/a/a/c/a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/h/a/a/c/a;->f:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public e()Lb/h/a/a/c/a$b;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->h:Lb/h/a/a/c/a$b;

    return-object v0
.end method

.method public f()I
    .locals 1

    iget v0, p0, Lb/h/a/a/c/a;->a:I

    return v0
.end method

.method public g()Lb/h/a/a/c/a$c;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->i:Lb/h/a/a/c/a$c;

    return-object v0
.end method

.method public h()Lb/h/a/a/c/a;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->c:Lb/h/a/a/c/a;

    return-object v0
.end method

.method public i()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->j:Ljava/lang/Object;

    return-object v0
.end method

.method public j()Lb/h/a/a/c/a$a;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->g:Lb/h/a/a/c/a$a;

    return-object v0
.end method

.method public k()Z
    .locals 1

    iget-boolean v0, p0, Lb/h/a/a/c/a;->k:Z

    return v0
.end method

.method public l()Z
    .locals 4

    invoke-virtual {p0}, Lb/h/a/a/c/a;->n()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lb/h/a/a/c/a;->c:Lb/h/a/a/c/a;

    iget-object v0, v0, Lb/h/a/a/c/a;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v2, p0, Lb/h/a/a/c/a;->c:Lb/h/a/a/c/a;

    iget-object v2, v2, Lb/h/a/a/c/a;->f:Ljava/util/List;

    const/4 v3, 0x1

    sub-int/2addr v0, v3

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    iget v0, v0, Lb/h/a/a/c/a;->a:I

    iget v2, p0, Lb/h/a/a/c/a;->a:I

    if-ne v0, v2, :cond_0

    move v1, v3

    :cond_0
    return v1
.end method

.method public m()Z
    .locals 1

    invoke-virtual {p0}, Lb/h/a/a/c/a;->v()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public n()Z
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->c:Lb/h/a/a/c/a;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public o()Z
    .locals 1

    iget-boolean v0, p0, Lb/h/a/a/c/a;->e:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lb/h/a/a/c/a;->d:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public q(Z)Lb/h/a/a/c/a;
    .locals 0

    iput-boolean p1, p0, Lb/h/a/a/c/a;->k:Z

    return-object p0
.end method

.method public r(Lb/h/a/a/c/a$c;)Lb/h/a/a/c/a;
    .locals 0

    iput-object p1, p0, Lb/h/a/a/c/a;->i:Lb/h/a/a/c/a$c;

    return-object p0
.end method

.method public s(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/h/a/a/c/a;->e:Z

    return-void
.end method

.method public t(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/h/a/a/c/a;->d:Z

    return-void
.end method

.method public u(Lb/h/a/a/c/a$a;)Lb/h/a/a/c/a;
    .locals 0

    iput-object p1, p0, Lb/h/a/a/c/a;->g:Lb/h/a/a/c/a$a;

    if-eqz p1, :cond_0

    iput-object p0, p1, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    :cond_0
    return-object p0
.end method

.method public v()I
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method
