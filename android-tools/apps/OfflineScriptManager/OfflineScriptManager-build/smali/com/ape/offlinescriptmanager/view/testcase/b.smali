.class public Lcom/ape/offlinescriptmanager/view/testcase/b;
.super Landroidx/fragment/app/Fragment;
.source ""


# instance fields
.field Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

.field a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

.field b0:Landroid/os/Handler;

.field c0:Lb/b/a/a/d/h;

.field d0:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/d/c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    return-void
.end method

.method static synthetic l1(Lcom/ape/offlinescriptmanager/view/testcase/b;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/b;->r1()V

    return-void
.end method

.method static synthetic m1(Lcom/ape/offlinescriptmanager/view/testcase/b;Ljava/lang/String;)Ljava/util/List;
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/b;->s1(Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method static synthetic n1(Lcom/ape/offlinescriptmanager/view/testcase/b;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/ape/offlinescriptmanager/view/testcase/b;->u1(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method static synthetic o1(Lcom/ape/offlinescriptmanager/view/testcase/b;Ljava/lang/String;)Lb/b/a/a/a/a;
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/b;->t1(Ljava/lang/String;)Lb/b/a/a/a/a;

    move-result-object p0

    return-object p0
.end method

.method public static p1()Lcom/ape/offlinescriptmanager/view/testcase/b;
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/b;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/view/testcase/b;-><init>()V

    return-object v0
.end method

.method private q1()[Ljava/lang/String;
    .locals 5

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {}, Lb/b/a/b/b/a;->d()Lb/b/a/b/b/a;

    move-result-object v1

    invoke-virtual {v1}, Lb/b/a/b/b/a;->e()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/a/a;

    iget-object v3, v2, Lb/b/a/a/a/a;->c:Ljava/lang/String;

    if-eqz v3, :cond_0

    const-string v4, ".apk"

    invoke-virtual {v3, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v2, v2, Lb/b/a/a/a/a;->c:Ljava/lang/String;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method

.method private r1()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    const-string v1, "TestCaseFragment"

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->k()V

    const-string v0, "mPageAdapter.getCount()==0"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->c0:Lb/b/a/a/d/h;

    if-nez v0, :cond_1

    const-string v0, "test point is null"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_1
    invoke-virtual {v0}, Lb/b/a/a/d/h;->n()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->d0:Ljava/util/List;

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->b0:Landroid/os/Handler;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/b$f;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/b$f;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V

    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_1

    :cond_3
    :goto_0
    return-void

    :cond_4
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_5

    goto :goto_1

    :cond_5
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshing(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->M()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->j()V

    :cond_6
    :goto_1
    return-void
.end method

.method private s1(Ljava/lang/String;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/b;->t1(Ljava/lang/String;)Lb/b/a/a/a/a;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iget-object p1, p1, Lb/b/a/a/a/a;->g:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/a/b;

    invoke-virtual {v2}, Lb/b/a/a/a/b;->a()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {v2}, Lb/b/a/a/a/b;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2}, Lb/b/a/a/a/b;->a()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {v2}, Lb/b/a/a/a/b;->a()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private t1(Ljava/lang/String;)Lb/b/a/a/a/a;
    .locals 3

    invoke-static {}, Lb/b/a/b/b/a;->d()Lb/b/a/b/b/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/b/b/a;->e()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/a/a;

    iget-object v2, v1, Lb/b/a/a/a/a;->c:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method private u1(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/b;->t1(Ljava/lang/String;)Lb/b/a/a/a/a;

    move-result-object p1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object p1, p1, Lb/b/a/a/a/a;->g:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/a/b;

    invoke-virtual {v1}, Lb/b/a/a/a/b;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Lb/b/a/a/a/b;->b()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private w1(Landroid/view/View;)V
    .locals 4

    const v0, 0x7f0900d3

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    const v0, 0x7f090157

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f06003c

    const v1, 0x7f06003d

    const v2, 0x7f060018

    invoke-virtual {p1, v0, v0, v1, v2}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h(IIII)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f0c0058

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setProgressView(I)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v1, 0x7f0c0059

    invoke-virtual {p1, v1, v0, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f090106

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/b$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/b$a;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setErrorView(Landroid/view/View;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/view/testcase/d;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/ape/offlinescriptmanager/view/testcase/d;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setAdapterWithProgress(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    const v0, 0x7f0c0056

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->P(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/b$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/b$b;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/b$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/b$c;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->S(Lcom/jude/easyrecyclerview/d/d$d;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->a0:Lcom/ape/offlinescriptmanager/view/testcase/d;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/b$d;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/b$d;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->T(Lcom/jude/easyrecyclerview/d/d$e;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/b$e;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/b$e;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshListener(La/l/a/a;)V

    return-void
.end method

.method private x1(Ljava/lang/String;Landroid/view/View;Lb/a/a/f$e;)Lb/a/a/f;
    .locals 1

    new-instance p1, Lb/a/a/f$d;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Lb/a/a/f$d;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x1

    invoke-virtual {p1, p2, v0}, Lb/a/a/f$d;->d(Landroid/view/View;Z)Lb/a/a/f$d;

    const p2, 0x7f0f006f

    invoke-virtual {p1, p2}, Lb/a/a/f$d;->j(I)Lb/a/a/f$d;

    const p2, 0x7f0f006e

    invoke-virtual {p1, p2}, Lb/a/a/f$d;->f(I)Lb/a/a/f$d;

    invoke-virtual {p1, p3}, Lb/a/a/f$d;->b(Lb/a/a/f$e;)Lb/a/a/f$d;

    sget-object p2, Lb/a/a/p;->b:Lb/a/a/p;

    invoke-virtual {p1, p2}, Lb/a/a/f$d;->l(Lb/a/a/p;)Lb/a/a/f$d;

    invoke-virtual {p1}, Lb/a/a/f$d;->a()Lb/a/a/f;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0c0047

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->l()Landroid/os/Bundle;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->l()Landroid/os/Bundle;

    move-result-object p2

    const-string p3, "TEST_POINT"

    invoke-virtual {p2, p3}, Landroid/os/Bundle;->getSerializable(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p2

    check-cast p2, Lb/b/a/a/d/h;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->c0:Lb/b/a/a/d/h;

    :cond_0
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/b;->w1(Landroid/view/View;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->c0:Lb/b/a/a/d/h;

    invoke-virtual {p0, p2}, Lcom/ape/offlinescriptmanager/view/testcase/b;->v1(Lb/b/a/a/d/h;)V

    return-object p1
.end method

.method public d0()V
    .locals 0

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->d0()V

    return-void
.end method

.method public v1(Lb/b/a/a/d/h;)V
    .locals 2

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->b0:Landroid/os/Handler;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->c0:Lb/b/a/a/d/h;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/b;->r1()V

    return-void
.end method

.method public y1(I)V
    .locals 14

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b;->d0:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/d/c;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x7f0c0042

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    const v2, 0x7f0900b3

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v5, v2

    check-cast v5, Landroid/widget/Spinner;

    const v2, 0x7f0900af

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v6, v2

    check-cast v6, Landroid/widget/EditText;

    const v2, 0x7f0900ae

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v7, v2

    check-cast v7, Landroid/widget/CheckBox;

    const v2, 0x7f0900a1

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v8, v2

    check-cast v8, Landroid/widget/Spinner;

    const v2, 0x7f0900a5

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v9, v2

    check-cast v9, Landroid/widget/Spinner;

    const v2, 0x7f0900ac

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v10, v2

    check-cast v10, Landroid/widget/Spinner;

    const v2, 0x7f0900a7

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v11, v2

    check-cast v11, Landroid/widget/EditText;

    const-string v2, "uiautomator2"

    const-string v3, "uiautomator"

    const-string v4, "robotium"

    filled-new-array {v2, v3, v4}, [Ljava/lang/String;

    move-result-object v2

    new-instance v3, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v4

    const v12, 0x7f0c0089

    invoke-direct {v3, v4, v12, v2}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-virtual {v5, v3}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v2, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v3

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/b;->q1()[Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v12, v4}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-virtual {v8, v2}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v3, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4, v12}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v9, v3}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v4, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v13

    invoke-direct {v4, v13, v12}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v10, v4}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v12, Lcom/ape/offlinescriptmanager/view/testcase/b$g;

    invoke-direct {v12, p0, v3}, Lcom/ape/offlinescriptmanager/view/testcase/b$g;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;Landroid/widget/ArrayAdapter;)V

    invoke-virtual {v8, v12}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    new-instance v12, Lcom/ape/offlinescriptmanager/view/testcase/b$h;

    invoke-direct {v12, p0, v8, v4}, Lcom/ape/offlinescriptmanager/view/testcase/b$h;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;Landroid/widget/Spinner;Landroid/widget/ArrayAdapter;)V

    invoke-virtual {v9, v12}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v12

    if-eqz v12, :cond_0

    invoke-interface {v0}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v12}, Landroid/widget/ArrayAdapter;->getPosition(Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v8, v2}, Landroid/widget/Spinner;->setSelection(I)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->k()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v3}, Landroid/widget/ArrayAdapter;->clear()V

    invoke-interface {v0}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/view/testcase/b;->s1(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/ArrayAdapter;->addAll(Ljava/util/Collection;)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->k()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/ArrayAdapter;->getPosition(Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v9, v2}, Landroid/widget/Spinner;->setSelection(I)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->b()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v4}, Landroid/widget/ArrayAdapter;->clear()V

    invoke-interface {v0}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0}, Lb/b/a/a/d/c;->k()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/ape/offlinescriptmanager/view/testcase/b;->u1(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v4, v2}, Landroid/widget/ArrayAdapter;->addAll(Ljava/util/Collection;)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Landroid/widget/ArrayAdapter;->getPosition(Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v10, v2}, Landroid/widget/Spinner;->setSelection(I)V

    :cond_0
    invoke-interface {v0}, Lb/b/a/a/d/c;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->j()Z

    move-result v2

    invoke-virtual {v7, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    invoke-interface {v0}, Lb/b/a/a/d/c;->i()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Lb/b/a/a/d/c;->i()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    const v2, 0x7f0f0072

    invoke-virtual {v0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/ape/offlinescriptmanager/view/testcase/b$i;

    move-object v3, v2

    move-object v4, p0

    move v12, p1

    invoke-direct/range {v3 .. v12}, Lcom/ape/offlinescriptmanager/view/testcase/b$i;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/b;Landroid/widget/Spinner;Landroid/widget/EditText;Landroid/widget/CheckBox;Landroid/widget/Spinner;Landroid/widget/Spinner;Landroid/widget/Spinner;Landroid/widget/EditText;I)V

    invoke-direct {p0, v0, v1, v2}, Lcom/ape/offlinescriptmanager/view/testcase/b;->x1(Ljava/lang/String;Landroid/view/View;Lb/a/a/f$e;)Lb/a/a/f;

    move-result-object p1

    invoke-virtual {p1}, Lb/a/a/f;->show()V

    return-void
.end method
