.class Lcom/jude/easyrecyclerview/EasyRecyclerView$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/EasyRecyclerView;->setRefreshing(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Z

.field final synthetic c:Lcom/jude/easyrecyclerview/EasyRecyclerView;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/EasyRecyclerView;Z)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$b;->c:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iput-boolean p2, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$b;->b:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$b;->c:Lcom/jude/easyrecyclerview/EasyRecyclerView;

    iget-object v0, v0, Lcom/jude/easyrecyclerview/EasyRecyclerView;->r:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    iget-boolean v1, p0, Lcom/jude/easyrecyclerview/EasyRecyclerView$b;->b:Z

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method
