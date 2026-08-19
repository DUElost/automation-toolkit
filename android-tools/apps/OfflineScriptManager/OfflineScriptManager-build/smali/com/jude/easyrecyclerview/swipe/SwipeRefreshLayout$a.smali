.class Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 2

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->a(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z

    move-result p1

    const/16 v0, 0xff

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/b;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/jude/easyrecyclerview/swipe/b;->setAlpha(I)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/b;

    move-result-object p1

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b;->start()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->h(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->i(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)La/l/a/a;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->i(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)La/l/a/a;

    move-result-object p1

    invoke-interface {p1}, La/l/a/a;->a()V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/b;

    move-result-object p1

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/swipe/b;->stop()V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->j(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/a;

    move-result-object p1

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->k(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;I)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;F)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    iget v0, p1, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->n(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)I

    move-result v1

    sub-int/2addr v0, v1

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->p(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;IZ)V

    :cond_2
    :goto_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$a;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->j(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/a;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/ImageView;->getTop()I

    move-result v0

    invoke-static {p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->o(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;I)I

    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method
