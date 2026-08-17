.class public Lcom/ape/offlinescriptmanager/view/b/a;
.super Landroidx/fragment/app/Fragment;
.source ""


# instance fields
.field Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

.field a0:Lcom/ape/offlinescriptmanager/view/b/c;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    return-void
.end method

.method static synthetic l1(Lcom/ape/offlinescriptmanager/view/b/a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/b/a;->n1()V

    return-void
.end method

.method public static m1()Lcom/ape/offlinescriptmanager/view/b/a;
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/b/a;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/view/b/a;-><init>()V

    return-object v0
.end method

.method private n1()V
    .locals 0

    return-void
.end method

.method private o1()V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/b/a;->n1()V

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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f06003c

    const v1, 0x7f06003d

    const v2, 0x7f060018

    invoke-virtual {p1, v0, v0, v1, v2}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h(IIII)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v0, 0x7f0c0058

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setProgressView(I)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v1, 0x7f0c0059

    invoke-virtual {p1, v1, v0, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f090106

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/b/a$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/b/a$a;-><init>(Lcom/ape/offlinescriptmanager/view/b/a;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setErrorView(Landroid/view/View;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Landroidx/recyclerview/widget/d;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, v2}, Landroidx/recyclerview/widget/d;-><init>(Landroid/content/Context;I)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b(Landroidx/recyclerview/widget/RecyclerView$n;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/view/b/c;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/ape/offlinescriptmanager/view/b/c;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->a0:Lcom/ape/offlinescriptmanager/view/b/c;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setAdapterWithProgress(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->a0:Lcom/ape/offlinescriptmanager/view/b/c;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/b/a$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/b/a$b;-><init>(Lcom/ape/offlinescriptmanager/view/b/a;)V

    const v1, 0x7f0c0057

    invoke-virtual {p1, v1, v0}, Lcom/jude/easyrecyclerview/d/d;->Q(ILcom/jude/easyrecyclerview/d/d$f;)Landroid/view/View;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->a0:Lcom/ape/offlinescriptmanager/view/b/c;

    const v0, 0x7f0c005a

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->R(I)Landroid/view/View;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->a0:Lcom/ape/offlinescriptmanager/view/b/c;

    const v0, 0x7f0c0056

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->P(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/b/a$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/b/a$c;-><init>(Lcom/ape/offlinescriptmanager/view/b/a;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->a0:Lcom/ape/offlinescriptmanager/view/b/c;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/b/a$d;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/b/a$d;-><init>(Lcom/ape/offlinescriptmanager/view/b/a;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/d/d;->S(Lcom/jude/easyrecyclerview/d/d$d;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/a;->Z:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/b/a$e;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/b/a$e;-><init>(Lcom/ape/offlinescriptmanager/view/b/a;)V

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshListener(La/l/a/a;)V

    return-void
.end method


# virtual methods
.method public c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0c0047

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/view/b/a;->p1(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/b/a;->o1()V

    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/Fragment;->c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public d0()V
    .locals 0

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->d0()V

    return-void
.end method
