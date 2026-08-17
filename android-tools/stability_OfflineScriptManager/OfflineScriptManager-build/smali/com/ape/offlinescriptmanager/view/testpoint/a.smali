.class public Lcom/ape/offlinescriptmanager/view/testpoint/a;
.super Landroidx/fragment/app/Fragment;
.source ""


# instance fields
.field Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

.field a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

.field b0:Landroid/os/Handler;

.field c0:Lb/b/a/a/d/f;

.field d0:Ljava/lang/String;

.field e0:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/d/h;",
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

.method static synthetic l1(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->o1()V

    return-void
.end method

.method static synthetic m1(Lcom/ape/offlinescriptmanager/view/testpoint/a;Lb/b/a/a/d/f;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->s1(Lb/b/a/a/d/f;)V

    return-void
.end method

.method public static n1()Lcom/ape/offlinescriptmanager/view/testpoint/a;
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testpoint/a;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/view/testpoint/a;-><init>()V

    return-object v0
.end method

.method private o1()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->k()V

    const-string v0, "TestCaseFragment"

    const-string v1, "mPageAdapter.getCount()==0"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {v0}, Lb/b/a/a/d/f;->i()Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->e0:Ljava/util/ArrayList;

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
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->b0:Landroid/os/Handler;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testpoint/a$f;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a$f;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V

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
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshing(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->M()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->j()V

    :cond_6
    :goto_1
    return-void
.end method

.method private r1(Landroid/view/View;)V
    .locals 4

    const v0, 0x7f0900d3

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    const v0, 0x7f090157

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f06003c

    const v1, 0x7f06003d

    const v2, 0x7f060018

    invoke-virtual {p1, v0, v0, v1, v2}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h(IIII)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f0c0058

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setProgressView(I)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v1, 0x7f0c0059

    invoke-virtual {p1, v1, v0, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f090106

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testpoint/a$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a$a;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setErrorView(Landroid/view/View;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/view/testpoint/c;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/ape/offlinescriptmanager/view/testpoint/c;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setAdapterWithProgress(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    const v0, 0x7f0c0056

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->P(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testpoint/a$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a$b;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testpoint/a$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a$c;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->S(Lcom/jude/easyrecyclerview/d/d$d;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testpoint/a$d;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a$d;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->T(Lcom/jude/easyrecyclerview/d/d$e;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testpoint/a$e;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a$e;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshListener(La/l/a/a;)V

    return-void
.end method

.method private s1(Lb/b/a/a/d/f;)V
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/g;

    invoke-direct {v0, p1}, Lcom/ape/offlinescriptmanager/utils/m/g;-><init>(Lb/b/a/a/d/f;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/m/g;->k()Z

    return-void
.end method

.method private t1(Ljava/lang/String;Landroid/view/View;Lb/a/a/f$e;)Lb/a/a/f;
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
.method public V(Landroid/content/Context;)V
    .locals 0

    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->V(Landroid/content/Context;)V

    return-void
.end method

.method public c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0c0049

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->l()Landroid/os/Bundle;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->l()Landroid/os/Bundle;

    move-result-object p2

    const-string p3, "TASK"

    invoke-virtual {p2, p3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->d0:Ljava/lang/String;

    invoke-virtual {p0, p2}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->p1(Ljava/lang/String;)Lb/b/a/a/d/f;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    :cond_0
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->r1(Landroid/view/View;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    invoke-virtual {p0, p2}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->q1(Lb/b/a/a/d/f;)V

    return-object p1
.end method

.method public d0()V
    .locals 0

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->d0()V

    return-void
.end method

.method public p1(Ljava/lang/String;)Lb/b/a/a/d/f;
    .locals 1

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-static {}, Lb/b/a/b/b/b;->d()Lb/b/a/b/b/b;

    move-result-object p1

    invoke-virtual {p1, v0}, Lb/b/a/b/b/b;->e(Ljava/io/File;)Lb/b/a/a/d/f;

    move-result-object p1

    return-object p1
.end method

.method public q1(Lb/b/a/a/d/f;)V
    .locals 1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->b0:Landroid/os/Handler;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->o1()V

    return-void
.end method

.method public u1(I)V
    .locals 10

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->e0:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v3, v0

    check-cast v3, Lb/b/a/a/d/h;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0c0041

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0900b8

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    move-object v6, v1

    check-cast v6, Landroid/widget/CheckBox;

    const v1, 0x7f0900b6

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    move-object v4, v1

    check-cast v4, Landroid/widget/EditText;

    const v1, 0x7f0900b9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    move-object v5, v1

    check-cast v5, Landroid/widget/EditText;

    invoke-virtual {v3}, Lb/b/a/a/d/h;->m()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v3}, Lb/b/a/a/d/h;->m()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    invoke-virtual {v3}, Lb/b/a/a/d/h;->j()Z

    move-result v1

    invoke-virtual {v6, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    invoke-virtual {v3}, Lb/b/a/a/d/h;->a()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f0f0073

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;

    move-object v1, v9

    move-object v2, p0

    move v7, p1

    invoke-direct/range {v1 .. v7}, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;-><init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;Lb/b/a/a/d/h;Landroid/widget/EditText;Landroid/widget/EditText;Landroid/widget/CheckBox;I)V

    invoke-direct {p0, v8, v0, v9}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->t1(Ljava/lang/String;Landroid/view/View;Lb/a/a/f$e;)Lb/a/a/f;

    move-result-object p1

    invoke-virtual {p1}, Lb/a/a/f;->show()V

    return-void
.end method
