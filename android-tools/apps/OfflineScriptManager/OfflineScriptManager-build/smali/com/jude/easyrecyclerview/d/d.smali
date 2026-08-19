.class public abstract Lcom/jude/easyrecyclerview/d/d;
.super Landroidx/recyclerview/widget/RecyclerView$g;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/jude/easyrecyclerview/d/d$e;,
        Lcom/jude/easyrecyclerview/d/d$d;,
        Lcom/jude/easyrecyclerview/d/d$g;,
        Lcom/jude/easyrecyclerview/d/d$f;,
        Lcom/jude/easyrecyclerview/d/d$c;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Landroidx/recyclerview/widget/RecyclerView$g<",
        "Lcom/jude/easyrecyclerview/d/a;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation
.end field

.field private d:Lcom/jude/easyrecyclerview/d/c;

.field e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/jude/easyrecyclerview/d/d$c;",
            ">;"
        }
    .end annotation
.end field

.field f:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/jude/easyrecyclerview/d/d$c;",
            ">;"
        }
    .end annotation
.end field

.field private g:Lcom/jude/easyrecyclerview/d/d$d;

.field private h:Lcom/jude/easyrecyclerview/d/d$e;

.field private final i:Ljava/lang/Object;

.field private j:Z

.field private k:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$g;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->i:Ljava/lang/Object;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/d/d;->j:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/jude/easyrecyclerview/d/d;->J(Landroid/content/Context;Ljava/util/List;)V

    return-void
.end method

.method private D(Landroid/view/ViewGroup;I)Landroid/view/View;
    .locals 4

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/jude/easyrecyclerview/d/d$c;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    if-ne v3, p2, :cond_0

    invoke-interface {v1, p1}, Lcom/jude/easyrecyclerview/d/d$c;->a(Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p2, Landroidx/recyclerview/widget/StaggeredGridLayoutManager$c;

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-direct {p2, v0}, Landroidx/recyclerview/widget/StaggeredGridLayoutManager$c;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    :goto_0
    invoke-virtual {p2, v2}, Landroidx/recyclerview/widget/StaggeredGridLayoutManager$c;->g(Z)V

    invoke-virtual {p1, p2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-object p1

    :cond_1
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/jude/easyrecyclerview/d/d$c;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    if-ne v3, p2, :cond_2

    invoke-interface {v1, p1}, Lcom/jude/easyrecyclerview/d/d$c;->a(Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p2, Landroidx/recyclerview/widget/StaggeredGridLayoutManager$c;

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-direct {p2, v0}, Landroidx/recyclerview/widget/StaggeredGridLayoutManager$c;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    :cond_3
    const/4 p1, 0x0

    return-object p1
.end method

.method private J(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "TT;>;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/d;->k:Landroid/content/Context;

    iput-object p2, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    return-void
.end method

.method static synthetic x(Lcom/jude/easyrecyclerview/d/d;)Lcom/jude/easyrecyclerview/d/d$d;
    .locals 0

    iget-object p0, p0, Lcom/jude/easyrecyclerview/d/d;->g:Lcom/jude/easyrecyclerview/d/d$d;

    return-object p0
.end method

.method static synthetic y(Lcom/jude/easyrecyclerview/d/d;)Lcom/jude/easyrecyclerview/d/d$e;
    .locals 0

    iget-object p0, p0, Lcom/jude/easyrecyclerview/d/d;->h:Lcom/jude/easyrecyclerview/d/d$e;

    return-object p0
.end method


# virtual methods
.method public A(Ljava/util/Collection;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "+TT;>;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {p1}, Ljava/util/Collection;->size()I

    move-result v1

    :goto_0
    invoke-interface {v0, v1}, Lcom/jude/easyrecyclerview/d/c;->a(I)V

    :cond_1
    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/Collection;->size()I

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->i:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    monitor-exit v0

    goto :goto_1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_2
    :goto_1
    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/d/d;->j:Z

    if-eqz p1, :cond_3

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    :cond_3
    return-void
.end method

.method public B(Lcom/jude/easyrecyclerview/d/d$c;)V
    .locals 1

    const-string v0, "ItemView can\'t be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public C()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/jude/easyrecyclerview/d/c;->clear()V

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->i:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/d/d;->j:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    :cond_1
    return-void

    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public E()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->k:Landroid/content/Context;

    return-object v0
.end method

.method public F()I
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method G()Lcom/jude/easyrecyclerview/d/c;
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    if-nez v0, :cond_0

    new-instance v0, Lcom/jude/easyrecyclerview/d/b;

    invoke-direct {v0, p0}, Lcom/jude/easyrecyclerview/d/b;-><init>(Lcom/jude/easyrecyclerview/d/d;)V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    return-object v0
.end method

.method public H(I)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)TT;"
        }
    .end annotation

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public I(I)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public final K(Lcom/jude/easyrecyclerview/d/a;I)V
    .locals 2

    iget-object v0, p1, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    invoke-virtual {v0, p2}, Landroid/view/View;->setId(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p2, v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/jude/easyrecyclerview/d/d$c;

    iget-object p1, p1, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    invoke-interface {p2, p1}, Lcom/jude/easyrecyclerview/d/d$c;->b(Landroid/view/View;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    sub-int v0, p2, v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int/2addr v0, v1

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-eqz v1, :cond_1

    if-ltz v0, :cond_1

    iget-object p2, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {p2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/jude/easyrecyclerview/d/d$c;

    iget-object p1, p1, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    invoke-interface {p2, p1}, Lcom/jude/easyrecyclerview/d/d$c;->b(Landroid/view/View;)V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    sub-int/2addr p2, v0

    invoke-virtual {p0, p1, p2}, Lcom/jude/easyrecyclerview/d/d;->v(Lcom/jude/easyrecyclerview/d/a;I)V

    return-void
.end method

.method public final L(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/jude/easyrecyclerview/d/d;->D(Landroid/view/ViewGroup;I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance p1, Lcom/jude/easyrecyclerview/d/d$g;

    invoke-direct {p1, p0, v0}, Lcom/jude/easyrecyclerview/d/d$g;-><init>(Lcom/jude/easyrecyclerview/d/d;Landroid/view/View;)V

    return-object p1

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/jude/easyrecyclerview/d/d;->w(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;

    move-result-object p1

    iget-object p2, p0, Lcom/jude/easyrecyclerview/d/d;->g:Lcom/jude/easyrecyclerview/d/d$d;

    if-eqz p2, :cond_1

    iget-object p2, p1, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    new-instance v0, Lcom/jude/easyrecyclerview/d/d$a;

    invoke-direct {v0, p0, p1}, Lcom/jude/easyrecyclerview/d/d$a;-><init>(Lcom/jude/easyrecyclerview/d/d;Lcom/jude/easyrecyclerview/d/a;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object p2, p0, Lcom/jude/easyrecyclerview/d/d;->h:Lcom/jude/easyrecyclerview/d/d$e;

    if-eqz p2, :cond_2

    iget-object p2, p1, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    new-instance v0, Lcom/jude/easyrecyclerview/d/d$b;

    invoke-direct {v0, p0, p1}, Lcom/jude/easyrecyclerview/d/d$b;-><init>(Lcom/jude/easyrecyclerview/d/d;Lcom/jude/easyrecyclerview/d/a;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_2
    return-object p1
.end method

.method public M()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    const-string v1, "You should invoking setLoadMore() first"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    invoke-interface {v0}, Lcom/jude/easyrecyclerview/d/c;->e()V

    return-void
.end method

.method public N(I)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->i:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/d/d;->j:Z

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    :cond_0
    return-void

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public O()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    const-string v1, "You should invoking setLoadMore() first"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    invoke-interface {v0}, Lcom/jude/easyrecyclerview/d/c;->d()V

    return-void
.end method

.method public P(I)Landroid/view/View;
    .locals 4

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->G()Lcom/jude/easyrecyclerview/d/c;

    move-result-object p1

    invoke-interface {p1, v0}, Lcom/jude/easyrecyclerview/d/c;->c(Landroid/view/View;)V

    return-object v0
.end method

.method public Q(ILcom/jude/easyrecyclerview/d/d$f;)Landroid/view/View;
    .locals 4

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->G()Lcom/jude/easyrecyclerview/d/c;

    move-result-object p1

    invoke-interface {p1, v0, p2}, Lcom/jude/easyrecyclerview/d/c;->f(Landroid/view/View;Lcom/jude/easyrecyclerview/d/d$f;)V

    return-object v0
.end method

.method public R(I)Landroid/view/View;
    .locals 4

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->E()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/d;->G()Lcom/jude/easyrecyclerview/d/c;

    move-result-object p1

    invoke-interface {p1, v0}, Lcom/jude/easyrecyclerview/d/c;->b(Landroid/view/View;)V

    return-object v0
.end method

.method public S(Lcom/jude/easyrecyclerview/d/d$d;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/d;->g:Lcom/jude/easyrecyclerview/d/d$d;

    return-void
.end method

.method public T(Lcom/jude/easyrecyclerview/d/d$e;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/d;->h:Lcom/jude/easyrecyclerview/d/d$e;

    return-void
.end method

.method public final c()I
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method public d(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public final e(I)I
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/jude/easyrecyclerview/d/d$c;

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result p1

    return p1

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    sub-int v0, p1, v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int/2addr v0, v1

    if-ltz v0, :cond_1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/d;->f:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/jude/easyrecyclerview/d/d$c;

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result p1

    return p1

    :cond_1
    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    sub-int/2addr p1, v0

    invoke-virtual {p0, p1}, Lcom/jude/easyrecyclerview/d/d;->I(I)I

    move-result p1

    return p1
.end method

.method public bridge synthetic l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
    .locals 0

    check-cast p1, Lcom/jude/easyrecyclerview/d/a;

    invoke-virtual {p0, p1, p2}, Lcom/jude/easyrecyclerview/d/d;->K(Lcom/jude/easyrecyclerview/d/a;I)V

    return-void
.end method

.method public bridge synthetic n(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$c0;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lcom/jude/easyrecyclerview/d/d;->L(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;

    move-result-object p1

    return-object p1
.end method

.method public v(Lcom/jude/easyrecyclerview/d/a;I)V
    .locals 0

    invoke-virtual {p0, p2}, Lcom/jude/easyrecyclerview/d/d;->H(I)Ljava/lang/Object;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/jude/easyrecyclerview/d/a;->N(Ljava/lang/Object;)V

    return-void
.end method

.method public abstract w(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;
.end method

.method public z(Ljava/lang/Object;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->d:Lcom/jude/easyrecyclerview/d/c;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    const/4 v1, 0x1

    :goto_0
    invoke-interface {v0, v1}, Lcom/jude/easyrecyclerview/d/c;->a(I)V

    :cond_1
    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d;->i:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d;->c:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    goto :goto_1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_2
    :goto_1
    iget-boolean p1, p0, Lcom/jude/easyrecyclerview/d/d;->j:Z

    if-eqz p1, :cond_3

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    :cond_3
    return-void
.end method
