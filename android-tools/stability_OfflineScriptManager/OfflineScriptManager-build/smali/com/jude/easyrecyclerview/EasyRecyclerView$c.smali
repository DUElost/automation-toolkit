.class Lcom/jude/easyrecyclerview/EasyRecyclerView$c;
.super Landroidx/recyclerview/widget/RecyclerView$i;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/jude/easyrecyclerview/EasyRecyclerView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "c"
.end annotation


# instance fields
.field private a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

.field private b:Z

.field private c:Z


# direct methods
.method public constructor <init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;Z)V
    .locals 1

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$i;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->b:Z

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->c:Z

    iput-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iput-boolean p2, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->c:Z

    return-void
.end method

.method private e()V
    .locals 5

    const-string v0, "update"

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v0

    instance-of v0, v0, Lcom/jude/easyrecyclerview/d/d;

    const-string v1, "show progress"

    const-string v2, "show empty"

    const-string v3, "no data:"

    const-string v4, "has data"

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v0

    check-cast v0, Lcom/jude/easyrecyclerview/d/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->c:Z

    if-eqz v3, :cond_0

    iget-boolean v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->b:Z

    if-nez v3, :cond_0

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->a(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->c:Z

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->b:Z

    if-nez v0, :cond_3

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$g;->c()I

    move-result v0

    if-nez v0, :cond_4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->c:Z

    if-eqz v3, :cond_2

    iget-boolean v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->b:Z

    if-nez v3, :cond_2

    goto :goto_1

    :cond_2
    move-object v1, v2

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->a(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->c:Z

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->b:Z

    if-nez v0, :cond_3

    :goto_2
    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->k()V

    goto :goto_3

    :cond_3
    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->i()V

    goto :goto_3

    :cond_4
    invoke-static {v4}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    :goto_3
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->b:Z

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    invoke-super {p0}, Landroidx/recyclerview/widget/RecyclerView$i;->a()V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->e()V

    return-void
.end method

.method public b(II)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroidx/recyclerview/widget/RecyclerView$i;->b(II)V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->e()V

    return-void
.end method

.method public d(II)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroidx/recyclerview/widget/RecyclerView$i;->d(II)V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;->e()V

    return-void
.end method
