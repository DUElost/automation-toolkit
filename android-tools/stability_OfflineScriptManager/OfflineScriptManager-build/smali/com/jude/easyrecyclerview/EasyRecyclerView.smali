.class public Lcom/jude/easyrecyclerview/EasyRecyclerView;
.super Landroid/widget/FrameLayout;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/jude/easyrecyclerview/EasyRecyclerView$c;
    }
.end annotation


# instance fields
.field protected b:Landroidx/recyclerview/widget/RecyclerView;

.field protected c:Landroid/view/ViewGroup;

.field protected d:Landroid/view/ViewGroup;

.field protected e:Landroid/view/ViewGroup;

.field private f:I

.field private g:I

.field private h:I

.field protected i:Z

.field protected j:I

.field protected k:I

.field protected l:I

.field protected m:I

.field protected n:I

.field protected o:I

.field protected p:Landroidx/recyclerview/widget/RecyclerView$t;

.field protected q:Landroidx/recyclerview/widget/RecyclerView$t;

.field protected r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-virtual {p0, p2}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d(Landroid/util/AttributeSet;)V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->f()V

    return-void
.end method

.method static synthetic a(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g(Ljava/lang/String;)V

    return-void
.end method

.method private c()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setRefreshing(Z)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    return-void
.end method

.method private f()V
    .locals 4

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->isInEditMode()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    sget v1, Lcom/jude/easyrecyclerview/b;->layout_progress_recyclerview:I

    invoke-virtual {v0, v1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    sget v1, Lcom/jude/easyrecyclerview/a;->ptr_layout:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    iput-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setEnabled(Z)V

    sget v1, Lcom/jude/easyrecyclerview/a;->progress:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    iput-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    iget v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->f:I

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    iget v2, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->f:I

    iget-object v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    :cond_1
    sget v1, Lcom/jude/easyrecyclerview/a;->empty:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    iput-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    iget v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g:I

    if-eqz v1, :cond_2

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    iget v2, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g:I

    iget-object v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    :cond_2
    sget v1, Lcom/jude/easyrecyclerview/a;->error:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    iput-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    iget v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h:I

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    iget v2, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h:I

    iget-object v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    :cond_3
    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e(Landroid/view/View;)V

    return-void
.end method

.method private static g(Ljava/lang/String;)V
    .locals 0

    return-void
.end method


# virtual methods
.method public b(Landroidx/recyclerview/widget/RecyclerView$n;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/RecyclerView;->i(Landroidx/recyclerview/widget/RecyclerView$n;)V

    return-void
.end method

.method protected d(Landroid/util/AttributeSet;)V
    .locals 3

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lcom/jude/easyrecyclerview/c;->superrecyclerview:[I

    invoke-virtual {v0, p1, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object p1

    :try_start_0
    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_recyclerClipToPadding:I

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v0

    iput-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->i:Z

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_recyclerPadding:I

    const/high16 v2, -0x40800000    # -1.0f

    invoke-virtual {p1, v0, v2}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->j:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_recyclerPaddingTop:I

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->k:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_recyclerPaddingBottom:I

    invoke-virtual {p1, v0, v2}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_recyclerPaddingLeft:I

    invoke-virtual {p1, v0, v2}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->m:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_recyclerPaddingRight:I

    invoke-virtual {p1, v0, v2}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->n:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_scrollbarStyle:I

    const/4 v2, -0x1

    invoke-virtual {p1, v0, v2}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->o:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_layout_empty:I

    invoke-virtual {p1, v0, v1}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_layout_progress:I

    invoke-virtual {p1, v0, v1}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->f:I

    sget v0, Lcom/jude/easyrecyclerview/c;->superrecyclerview_layout_error:I

    invoke-virtual {p1, v0, v1}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v0

    iput v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->h:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    return-void

    :catchall_0
    move-exception v0

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    throw v0
.end method

.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method protected e(Landroid/view/View;)V
    .locals 4

    const v0, 0x102000a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroidx/recyclerview/widget/RecyclerView;

    iput-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    if-eqz p1, :cond_1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setHasFixedSize(Z)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->i:Z

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setClipToPadding(Z)V

    new-instance p1, Lcom/jude/easyrecyclerview/EasyRecyclerView$a;

    invoke-direct {p1, p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView$a;-><init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;)V

    iput-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->p:Landroidx/recyclerview/widget/RecyclerView$t;

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/RecyclerView;->l(Landroidx/recyclerview/widget/RecyclerView$t;)V

    iget p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->j:I

    int-to-float v0, p1

    const/high16 v1, -0x40800000    # -1.0f

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1, p1, p1, p1}, Landroid/view/ViewGroup;->setPadding(IIII)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    iget v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->m:I

    iget v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->k:I

    iget v2, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->n:I

    iget v3, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l:I

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/view/ViewGroup;->setPadding(IIII)V

    :goto_0
    iget p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->o:I

    const/4 v0, -0x1

    if-eq p1, v0, :cond_1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->setScrollBarStyle(I)V

    :cond_1
    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    return-void
.end method

.method public getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v0

    return-object v0
.end method

.method public getEmptyView()Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getErrorView()Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getProgressView()Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getRecyclerView()Landroidx/recyclerview/widget/RecyclerView;
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    return-object v0
.end method

.method public getSwipeToRefresh()Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    return-object v0
.end method

.method public h(IIII)V
    .locals 3

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v1, 0x4

    new-array v1, v1, [I

    const/4 v2, 0x0

    aput p1, v1, v2

    const/4 p1, 0x1

    aput p2, v1, p1

    const/4 p1, 0x2

    aput p3, v1, p1

    const/4 p1, 0x3

    aput p4, v1, p1

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setColorSchemeColors([I)V

    return-void
.end method

.method public i()V
    .locals 2

    const-string v0, "showEmpty"

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    :goto_0
    return-void
.end method

.method public j()V
    .locals 2

    const-string v0, "showError"

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    :goto_0
    return-void
.end method

.method public k()V
    .locals 2

    const-string v0, "showProgress"

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->l()V

    :goto_0
    return-void
.end method

.method public l()V
    .locals 2

    const-string v0, "showRecycler"

    invoke-static {v0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->g(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    return-void
.end method

.method public setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    new-instance v0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;-><init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;Z)V

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView$g;->t(Landroidx/recyclerview/widget/RecyclerView$i;)V

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method

.method public setAdapterWithProgress(Landroidx/recyclerview/widget/RecyclerView$g;)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    new-instance v0, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1}, Lcom/jude/easyrecyclerview/EasyRecyclerView$c;-><init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;Z)V

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView$g;->t(Landroidx/recyclerview/widget/RecyclerView$i;)V

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method

.method public setEmptyView(I)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    return-void
.end method

.method public setEmptyView(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->d:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method public setErrorView(I)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    return-void
.end method

.method public setErrorView(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->e:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method public setItemAnimator(Landroidx/recyclerview/widget/RecyclerView$l;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/RecyclerView;->setItemAnimator(Landroidx/recyclerview/widget/RecyclerView$l;)V

    return-void
.end method

.method public setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    return-void
.end method

.method public setOnScrollListener(Landroidx/recyclerview/widget/RecyclerView$t;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->q:Landroidx/recyclerview/widget/RecyclerView$t;

    return-void
.end method

.method public setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    return-void
.end method

.method public setProgressView(I)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    return-void
.end method

.method public setProgressView(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method public setRefreshListener(La/l/a/a;)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setEnabled(Z)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setOnRefreshListener(La/l/a/a;)V

    return-void
.end method

.method public setRefreshing(Z)V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    new-instance v1, Lcom/jude/easyrecyclerview/EasyRecyclerView$b;

    invoke-direct {v1, p0, p1}, Lcom/jude/easyrecyclerview/EasyRecyclerView$b;-><init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;Z)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
