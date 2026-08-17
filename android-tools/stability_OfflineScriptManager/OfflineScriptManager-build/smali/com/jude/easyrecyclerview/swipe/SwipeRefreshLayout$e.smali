.class Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$e;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->onTouchEvent(Landroid/view/MotionEvent;)Z
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

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$e;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$e;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->l(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$e;->a:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->c(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;Landroid/view/animation/Animation$AnimationListener;)V

    :cond_0
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
