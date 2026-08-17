.class public Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;
.super Landroidx/recyclerview/widget/RecyclerView;
.source ""


# instance fields
.field private K0:Landroid/view/View;

.field L0:Landroidx/recyclerview/widget/RecyclerView$i;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroidx/recyclerview/widget/RecyclerView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p1, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView$a;

    invoke-direct {p1, p0}, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView$a;-><init>(Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;)V

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->L0:Landroidx/recyclerview/widget/RecyclerView$i;

    return-void
.end method

.method static synthetic u1(Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;)V
    .locals 0

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->v1()V

    return-void
.end method

.method private v1()V
    .locals 2

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->K0:Landroid/view/View;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v0

    if-eqz v0, :cond_2

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->K0:Landroid/view/View;

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView$g;->c()I

    move-result v1

    if-lez v1, :cond_1

    const/16 v1, 0x8

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method


# virtual methods
.method public setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V
    .locals 2

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$g;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->L0:Landroidx/recyclerview/widget/RecyclerView$i;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView$g;->u(Landroidx/recyclerview/widget/RecyclerView$i;)V

    :cond_0
    invoke-super {p0, p1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->L0:Landroidx/recyclerview/widget/RecyclerView$i;

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView$g;->t(Landroidx/recyclerview/widget/RecyclerView$i;)V

    :cond_1
    return-void
.end method

.method public setmEmptyView(Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->K0:Landroid/view/View;

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->v1()V

    return-void
.end method
