.class Lcom/jude/easyrecyclerview/EasyRecyclerView$a;
.super Landroidx/recyclerview/widget/RecyclerView$t;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/EasyRecyclerView;->e(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/jude/easyrecyclerview/EasyRecyclerView;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$a;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$t;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroidx/recyclerview/widget/RecyclerView;I)V
    .locals 1

    invoke-super {p0, p1, p2}, Landroidx/recyclerview/widget/RecyclerView$t;->a(Landroidx/recyclerview/widget/RecyclerView;I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$a;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iget-object v0, v0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->q:Landroidx/recyclerview/widget/RecyclerView$t;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Landroidx/recyclerview/widget/RecyclerView$t;->a(Landroidx/recyclerview/widget/RecyclerView;I)V

    :cond_0
    return-void
.end method

.method public b(Landroidx/recyclerview/widget/RecyclerView;II)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Landroidx/recyclerview/widget/RecyclerView$t;->b(Landroidx/recyclerview/widget/RecyclerView;II)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$a;->a:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iget-object v0, v0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->q:Landroidx/recyclerview/widget/RecyclerView$t;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Landroidx/recyclerview/widget/RecyclerView$t;->b(Landroidx/recyclerview/widget/RecyclerView;II)V

    :cond_0
    return-void
.end method
