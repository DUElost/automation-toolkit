.class Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$c;
.super Landroid/view/animation/Animation;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->F(Landroid/view/animation/Animation$AnimationListener;)V
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

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$c;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-direct {p0}, Landroid/view/animation/Animation;-><init>()V

    return-void
.end method


# virtual methods
.method public applyTransformation(FLandroid/view/animation/Transformation;)V
    .locals 1

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$c;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/high16 v0, 0x3f800000    # 1.0f

    sub-float/2addr v0, p1

    invoke-static {p2, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->m(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;F)V

    return-void
.end method
