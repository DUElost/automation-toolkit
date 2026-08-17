.class public Lcom/ape/offlinescriptmanager/view/c/b;
.super Landroidx/fragment/app/Fragment;
.source ""


# instance fields
.field Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

.field a0:Lcom/ape/offlinescriptmanager/view/c/d;

.field b0:Landroid/os/Handler;

.field c0:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/d/f;",
            ">;"
        }
    .end annotation
.end field

.field d0:Lb/b/a/b/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    return-void
.end method

.method static synthetic l1(Lcom/ape/offlinescriptmanager/view/c/b;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/b;->n1()V

    return-void
.end method

.method public static m1()Lcom/ape/offlinescriptmanager/view/c/b;
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/b;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/view/c/b;-><init>()V

    return-object v0
.end method

.method private n1()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    const-string v1, "TaskFragment"

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->k()V

    const-string v0, "mPageAdapter.getCount()==0"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-static {}, Lb/b/a/b/b/b;->d()Lb/b/a/b/b/b;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/b/b/b;->f()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "load task xml file start"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lb/b/a/b/b/b;->d()Lb/b/a/b/b/b;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/b/b/b;->b()Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "load task xml file fail"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const-string v0, "load task xml file end"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lb/b/a/b/b/b;->d()Lb/b/a/b/b/b;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/b/b/b;->f()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->c0:Ljava/util/List;

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
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->b0:Landroid/os/Handler;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/c/b$f;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/c/b$f;-><init>(Lcom/ape/offlinescriptmanager/view/c/b;)V

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
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshing(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->M()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->j()V

    :cond_6
    :goto_1
    return-void
.end method

.method private o1()V
    .locals 2

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->b0:Landroid/os/Handler;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/b;->n1()V

    return-void
.end method

.method private p1(Landroid/view/View;)V
    .locals 4

    const v0, 0x7f0900d3

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    const v0, 0x7f090157

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f06003c

    const v1, 0x7f06003d

    const v2, 0x7f060018

    invoke-virtual {p1, v0, v0, v1, v2}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h(IIII)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f0c0058

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setProgressView(I)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v1, 0x7f0c0059

    invoke-virtual {p1, v1, v0, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f090106

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/c/b$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/c/b$a;-><init>(Lcom/ape/offlinescriptmanager/view/c/b;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setErrorView(Landroid/view/View;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/ape/offlinescriptmanager/view/c/d;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setAdapterWithProgress(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    const v0, 0x7f0c0056

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->P(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/b$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/c/b$b;-><init>(Lcom/ape/offlinescriptmanager/view/c/b;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/b$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/c/b$c;-><init>(Lcom/ape/offlinescriptmanager/view/c/b;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshListener(La/l/a/a;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/b$d;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/c/b$d;-><init>(Lcom/ape/offlinescriptmanager/view/c/b;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->S(Lcom/jude/easyrecyclerview/d/d$d;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/b$e;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/c/b$e;-><init>(Lcom/ape/offlinescriptmanager/view/c/b;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->T(Lcom/jude/easyrecyclerview/d/d$e;)V

    return-void
.end method


# virtual methods
.method public V(Landroid/content/Context;)V
    .locals 2

    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->V(Landroid/content/Context;)V

    :try_start_0
    move-object v0, p1

    check-cast v0, Lb/b/a/b/a;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b;->d0:Lb/b/a/b/a;
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    new-instance v0, Ljava/lang/ClassCastException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " must implement OnHeadlineSelectedListener"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/ClassCastException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0c0047

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/c/b;->p1(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/b;->o1()V

    return-object p1
.end method

.method public d0()V
    .locals 0

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->d0()V

    return-void
.end method
