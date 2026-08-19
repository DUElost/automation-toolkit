.class public Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;
.super Landroidx/appcompat/app/c;
.source ""

# interfaces
.implements Landroidx/appcompat/widget/Toolbar$f;
.implements Lcom/ape/offlinescriptmanager/view/testcase/a$a;


# instance fields
.field private A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

.field private B:Lcom/ape/offlinescriptmanager/view/testcase/a;

.field C:Landroid/os/Handler;

.field private q:Lb/b/a/a/d/g;

.field private r:Landroidx/appcompat/widget/Toolbar;

.field private s:Landroid/widget/Spinner;

.field private t:Landroid/widget/EditText;

.field private u:Landroid/widget/CheckBox;

.field private v:Landroid/widget/Spinner;

.field private w:Landroid/widget/Spinner;

.field private x:Landroid/widget/Spinner;

.field private y:Landroid/widget/EditText;

.field private z:Landroid/widget/ImageButton;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/appcompat/app/c;-><init>()V

    return-void
.end method

.method static synthetic L(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lb/b/a/a/d/g;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    return-object p0
.end method

.method static synthetic M(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lcom/ape/offlinescriptmanager/view/testcase/a;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    return-object p0
.end method

.method static synthetic N(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;Ljava/lang/String;)Ljava/util/List;
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->T(Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method static synthetic O(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Landroid/widget/Spinner;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->v:Landroid/widget/Spinner;

    return-object p0
.end method

.method static synthetic P(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->V(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method static synthetic Q(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->S()V

    return-void
.end method

.method private R()[Ljava/lang/String;
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

.method private S()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "TestCaseEditActivity"

    const-string v1, "mAdapter.getCount()==0"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->C:Landroid/os/Handler;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V

    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_3

    return-void

    :cond_3
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshing(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->M()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->F()I

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->j()V

    :cond_4
    :goto_0
    return-void
.end method

.method private T(Ljava/lang/String;)Ljava/util/List;
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

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->U(Ljava/lang/String;)Lb/b/a/a/a/a;

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

.method private U(Ljava/lang/String;)Lb/b/a/a/a/a;
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

.method private V(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
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

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->U(Ljava/lang/String;)Lb/b/a/a/a/a;

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

.method private W()V
    .locals 2

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->C:Landroid/os/Handler;

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "intent_key_test_case"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object v0

    check-cast v0, Lb/b/a/a/d/g;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    return-void
.end method

.method private X()V
    .locals 4

    const v0, 0x7f09005d

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v1, 0x7f06003c

    const v2, 0x7f06003d

    const v3, 0x7f060018

    invoke-virtual {v0, v1, v1, v2, v3}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h(IIII)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v1, Landroidx/recyclerview/widget/LinearLayoutManager;

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v1, p0, v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v1, 0x7f0c0058

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setProgressView(I)V

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    const v2, 0x7f0c0059

    invoke-virtual {v0, v2, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f090106

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$d;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$d;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setErrorView(Landroid/view/View;)V

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-virtual {v1, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setAdapterWithProgress(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    const v1, 0x7f0c0056

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/d/d;->P(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$e;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$e;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$f;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$f;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/d/d;->S(Lcom/jude/easyrecyclerview/d/d$d;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->A:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$g;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$g;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshListener(La/l/a/a;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->S()V

    return-void
.end method

.method private Y()V
    .locals 5

    const v0, 0x7f0c0027

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->setContentView(I)V

    const v0, 0x7f0901ba

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/Toolbar;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->r:Landroidx/appcompat/widget/Toolbar;

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->I(Landroidx/appcompat/widget/Toolbar;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->r:Landroidx/appcompat/widget/Toolbar;

    invoke-virtual {v0, p0}, Landroidx/appcompat/widget/Toolbar;->setOnMenuItemClickListener(Landroidx/appcompat/widget/Toolbar$f;)V

    const v0, 0x7f09006d

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->s:Landroid/widget/Spinner;

    const v0, 0x7f090069

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->t:Landroid/widget/EditText;

    const v0, 0x7f090068

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->u:Landroid/widget/CheckBox;

    const v0, 0x7f090057

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->v:Landroid/widget/Spinner;

    const v0, 0x7f09005f

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->w:Landroid/widget/Spinner;

    const v0, 0x7f090066

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->x:Landroid/widget/Spinner;

    const v0, 0x7f090061

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->y:Landroid/widget/EditText;

    const v0, 0x7f09005a

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->z:Landroid/widget/ImageButton;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v0, "uiautomator2"

    const-string v1, "uiautomator"

    const-string v2, "robotium"

    filled-new-array {v0, v1, v2}, [Ljava/lang/String;

    move-result-object v0

    new-instance v1, Landroid/widget/ArrayAdapter;

    const v2, 0x7f0c0089

    invoke-direct {v1, p0, v2, v0}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->s:Landroid/widget/Spinner;

    invoke-virtual {v0, v1}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v0, Landroid/widget/ArrayAdapter;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->R()[Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p0, v2, v1}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->v:Landroid/widget/Spinner;

    invoke-virtual {v1, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v1, Landroid/widget/ArrayAdapter;

    invoke-direct {v1, p0, v2}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I)V

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->w:Landroid/widget/Spinner;

    invoke-virtual {v3, v1}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v3, Landroid/widget/ArrayAdapter;

    invoke-direct {v3, p0, v2}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I)V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->x:Landroid/widget/Spinner;

    invoke-virtual {v2, v3}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->v:Landroid/widget/Spinner;

    new-instance v4, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$b;

    invoke-direct {v4, p0, v1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$b;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;Landroid/widget/ArrayAdapter;)V

    invoke-virtual {v2, v4}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->w:Landroid/widget/Spinner;

    new-instance v4, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;

    invoke-direct {v4, p0, v3}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;Landroid/widget/ArrayAdapter;)V

    invoke-virtual {v2, v4}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v2}, Lb/b/a/a/d/g;->h()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->v:Landroid/widget/Spinner;

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v4}, Lb/b/a/a/d/g;->h()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/ArrayAdapter;->getPosition(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {v2, v0}, Landroid/widget/Spinner;->setSelection(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->k()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v1}, Landroid/widget/ArrayAdapter;->clear()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->h()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->T(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/ArrayAdapter;->addAll(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->w:Landroid/widget/Spinner;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v2}, Lb/b/a/a/d/g;->k()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ArrayAdapter;->getPosition(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Spinner;->setSelection(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->b()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v3}, Landroid/widget/ArrayAdapter;->clear()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->h()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v1}, Lb/b/a/a/d/g;->k()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->V(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/ArrayAdapter;->addAll(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->x:Landroid/widget/Spinner;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v1}, Lb/b/a/a/d/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Landroid/widget/ArrayAdapter;->getPosition(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Spinner;->setSelection(I)V

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->t:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v1}, Lb/b/a/a/d/g;->a()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->u:Landroid/widget/CheckBox;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v1}, Lb/b/a/a/d/g;->j()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->i()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->y:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v1}, Lb/b/a/a/d/g;->i()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->X()V

    return-void
.end method

.method private Z()V
    .locals 8

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->s:Landroid/widget/Spinner;

    invoke-virtual {v0}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->t:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->u:Landroid/widget/CheckBox;

    invoke-virtual {v2}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->v:Landroid/widget/Spinner;

    invoke-virtual {v3}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->w:Landroid/widget/Spinner;

    invoke-virtual {v4}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->x:Landroid/widget/Spinner;

    invoke-virtual {v5}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->y:Landroid/widget/EditText;

    invoke-virtual {v6}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "uiautomator2"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    new-instance v0, Lb/b/a/a/d/i;

    invoke-direct {v0}, Lb/b/a/a/d/i;-><init>()V

    :goto_0
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/b/a/a/d/g;->m(I)V

    invoke-virtual {v0, v2}, Lb/b/a/a/d/g;->l(Z)V

    invoke-virtual {v0, v3}, Lb/b/a/a/d/e;->p(Ljava/lang/String;)V

    invoke-direct {p0, v3}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->U(Ljava/lang/String;)Lb/b/a/a/a/a;

    move-result-object v1

    iget-object v1, v1, Lb/b/a/a/a/a;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/b/a/a/d/e;->r(Ljava/lang/String;)V

    invoke-virtual {v0, v4}, Lb/b/a/a/d/e;->q(Ljava/lang/String;)V

    invoke-virtual {v0, v5}, Lb/b/a/a/d/e;->s(Ljava/lang/String;)V

    :goto_1
    invoke-virtual {v0, v6}, Lb/b/a/a/d/g;->g(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    goto :goto_2

    :cond_0
    const-string v7, "uiautomator"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    new-instance v0, Lb/b/a/a/d/j;

    invoke-direct {v0}, Lb/b/a/a/d/j;-><init>()V

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/b/a/a/d/g;->m(I)V

    invoke-virtual {v0, v2}, Lb/b/a/a/d/g;->l(Z)V

    invoke-virtual {v0, v3}, Lb/b/a/a/d/j;->p(Ljava/lang/String;)V

    invoke-virtual {v0, v4}, Lb/b/a/a/d/j;->o(Ljava/lang/String;)V

    invoke-virtual {v0, v5}, Lb/b/a/a/d/j;->q(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    const-string v7, "robotium"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Lb/b/a/a/d/e;

    invoke-direct {v0}, Lb/b/a/a/d/e;-><init>()V

    goto :goto_0

    :cond_2
    :goto_2
    return-void
.end method

.method public static a0(Landroid/content/Context;Lb/b/a/a/d/g;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "intent_key_test_case"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method


# virtual methods
.method public e(ILjava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->e()Ljava/util/List;

    move-result-object v0

    new-instance v1, Lb/b/a/a/d/b;

    invoke-direct {v1, p2, p3}, Lb/b/a/a/d/b;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p2

    add-int/lit8 p2, p2, -0x1

    if-ge p1, p2, :cond_0

    add-int/lit8 p1, p1, 0x1

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {p1, v0}, Lb/b/a/a/d/g;->n(Ljava/util/List;)V

    return-void
.end method

.method public l(I)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v0}, Lb/b/a/a/d/g;->e()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    invoke-virtual {v1, v0}, Lb/b/a/a/d/g;->n(Ljava/util/List;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/d/d;->N(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->B:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onCreate(Landroid/os/Bundle;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->W()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->Y()V

    return-void
.end method

.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 2

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    const v0, 0x7f090010

    if-eq p1, v0, :cond_1

    const v0, 0x7f09001a

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->Z()V

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->q:Lb/b/a/a/d/g;

    const-string v1, "data_return"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    const/4 v0, -0x1

    invoke-virtual {p0, v0, p1}, Landroid/app/Activity;->setResult(ILandroid/content/Intent;)V

    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    :goto_0
    const/4 p1, 0x1

    return p1
.end method
