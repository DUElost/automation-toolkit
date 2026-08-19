.class Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;
.super Landroid/view/animation/Animation;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->G(ILandroid/view/animation/Animation$AnimationListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-direct {p0}, Landroid/view/animation/Animation;-><init>()V

    return-void
.end method


# virtual methods
.method public applyTransformation(FLandroid/view/animation/Transformation;)V
    .locals 1

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->g(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)F

    move-result p2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->g(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)F

    move-result v0

    neg-float v0, v0

    mul-float/2addr v0, p1

    add-float/2addr p2, v0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {v0, p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;F)V

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$h;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2, p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->f(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;F)V

    return-void
.end method
