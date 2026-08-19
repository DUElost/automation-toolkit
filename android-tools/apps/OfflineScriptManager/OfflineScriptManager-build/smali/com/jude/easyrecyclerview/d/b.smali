.class public Lcom/jude/easyrecyclerview/d/b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/jude/easyrecyclerview/d/c;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/jude/easyrecyclerview/d/b$a;
    }
.end annotation


# instance fields
.field private a:Lcom/jude/easyrecyclerview/d/b$a;

.field private b:Lcom/jude/easyrecyclerview/d/d$f;

.field private c:Z

.field private d:Z

.field private e:Z

.field private f:I


# direct methods
.method public constructor <init>(Lcom/jude/easyrecyclerview/d/d;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->d:Z

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->e:Z

    const/16 v0, 0x123

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b;->f:I

    new-instance v0, Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/jude/easyrecyclerview/d/b$a;-><init>(Lcom/jude/easyrecyclerview/d/b;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->B(Lcom/jude/easyrecyclerview/d/d$c;)V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "addData"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "recycler"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->d:Z

    if-eqz v0, :cond_3

    const/16 v1, 0x123

    if-nez p1, :cond_1

    iget p1, p0, Lcom/jude/easyrecyclerview/d/b;->f:I

    if-eq p1, v1, :cond_0

    const/16 v0, 0x104

    if-ne p1, v0, :cond_4

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/d/b$a;->i()V

    goto :goto_0

    :cond_1
    if-eqz v0, :cond_4

    iget p1, p0, Lcom/jude/easyrecyclerview/d/b;->f:I

    if-eq p1, v1, :cond_2

    const/16 v0, 0x2dc

    if-ne p1, v0, :cond_4

    :cond_2
    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/d/b$a;->h()V

    goto :goto_0

    :cond_3
    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/d/b;->e:Z

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/d/b$a;->i()V

    const/16 p1, 0x198

    iput p1, p0, Lcom/jude/easyrecyclerview/d/b;->f:I

    :cond_4
    :goto_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    return-void
.end method

.method public b(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/d/b$a;->f(Landroid/view/View;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/d/b;->e:Z

    const-string p1, "recycler"

    const-string v0, "setNoMore"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public c(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/d/b$a;->d(Landroid/view/View;)V

    const-string p1, "recycler"

    const-string v0, "setErrorMore"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public clear()V
    .locals 2

    const-string v0, "recycler"

    const-string v1, "clear"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v0, 0x123

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b;->f:I

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/b$a;->c()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    return-void
.end method

.method public d()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/b$a;->h()V

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/b;->h()V

    return-void
.end method

.method public e()V
    .locals 2

    const-string v0, "recycler"

    const-string v1, "pauseLoadMore"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/b$a;->g()V

    const/16 v0, 0x2dc

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b;->f:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    return-void
.end method

.method public f(Landroid/view/View;Lcom/jude/easyrecyclerview/d/d$f;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->a:Lcom/jude/easyrecyclerview/d/b$a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/d/b$a;->e(Landroid/view/View;)V

    iput-object p2, p0, Lcom/jude/easyrecyclerview/d/b;->b:Lcom/jude/easyrecyclerview/d/d$f;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/d/b;->d:Z

    const-string p1, "recycler"

    const-string p2, "setMore"

    invoke-static {p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public g()V
    .locals 0

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/b;->d()V

    return-void
.end method

.method public h()V
    .locals 2

    const-string v0, "recycler"

    const-string v1, "onMoreViewShowed"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b;->b:Lcom/jude/easyrecyclerview/d/d$f;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/jude/easyrecyclerview/d/b;->c:Z

    invoke-interface {v0}, Lcom/jude/easyrecyclerview/d/d$f;->a()V

    :cond_0
    return-void
.end method
