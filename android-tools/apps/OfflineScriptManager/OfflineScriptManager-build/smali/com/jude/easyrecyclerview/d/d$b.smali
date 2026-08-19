.class Lcom/jude/easyrecyclerview/d/d$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/d/d;->L(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/jude/easyrecyclerview/d/a;

.field final synthetic c:Lcom/jude/easyrecyclerview/d/d;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/d/d;Lcom/jude/easyrecyclerview/d/a;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/d$b;->c:Lcom/jude/easyrecyclerview/d/d;

    iput-object p2, p0, Lcom/jude/easyrecyclerview/d/d$b;->b:Lcom/jude/easyrecyclerview/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLongClick(Landroid/view/View;)Z
    .locals 2

    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/d$b;->c:Lcom/jude/easyrecyclerview/d/d;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/d/d;->y(Lcom/jude/easyrecyclerview/d/d;)Lcom/jude/easyrecyclerview/d/d$e;

    move-result-object p1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/d$b;->b:Lcom/jude/easyrecyclerview/d/a;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/d$b;->c:Lcom/jude/easyrecyclerview/d/d;

    iget-object v1, v1, Lcom/jude/easyrecyclerview/d/d;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-interface {p1, v0}, Lcom/jude/easyrecyclerview/d/d$e;->a(I)Z

    move-result p1

    return p1
.end method
