.class public abstract Lb/h/a/a/c/a$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/h/a/a/c/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<E:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field protected a:Lb/h/a/a/d/a;

.field protected b:Lb/h/a/a/c/a;

.field private c:Landroid/view/View;

.field protected d:I

.field protected e:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public abstract c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/h/a/a/c/a;",
            "TE;)",
            "Landroid/view/View;"
        }
    .end annotation
.end method

.method public d()I
    .locals 1

    iget v0, p0, Lb/h/a/a/c/a$a;->d:I

    return v0
.end method

.method public e()Landroid/view/ViewGroup;
    .locals 2

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->h()Landroid/view/View;

    move-result-object v0

    sget v1, Lb/h/a/a/a;->node_items:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    return-object v0
.end method

.method public f()Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->i()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lb/h/a/a/c/a$a;->c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public g()Lb/h/a/a/d/a;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a$a;->a:Lb/h/a/a/d/a;

    return-object v0
.end method

.method public h()Landroid/view/View;
    .locals 4

    iget-object v0, p0, Lb/h/a/a/c/a$a;->c:Landroid/view/View;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->f()Landroid/view/View;

    move-result-object v0

    new-instance v1, Lb/h/a/a/d/b;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->d()I

    move-result v3

    invoke-direct {v1, v2, v3}, Lb/h/a/a/d/b;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v1, v0}, Lb/h/a/a/d/b;->b(Landroid/view/View;)V

    iput-object v1, p0, Lb/h/a/a/c/a$a;->c:Landroid/view/View;

    return-object v1
.end method

.method public i()Z
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a$a;->c:Landroid/view/View;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public j(I)V
    .locals 0

    iput p1, p0, Lb/h/a/a/c/a$a;->d:I

    return-void
.end method

.method public k(Lb/h/a/a/d/a;)V
    .locals 0

    iput-object p1, p0, Lb/h/a/a/c/a$a;->a:Lb/h/a/a/d/a;

    return-void
.end method

.method public l(Z)V
    .locals 0

    return-void
.end method

.method public m(Z)V
    .locals 0

    return-void
.end method
