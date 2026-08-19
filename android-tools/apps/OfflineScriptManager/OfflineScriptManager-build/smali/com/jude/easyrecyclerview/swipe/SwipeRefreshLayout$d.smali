.class Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;
.super Landroid/view/animation/Animation;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->C(II)Landroid/view/animation/Animation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:I

.field final synthetic c:I

.field final synthetic d:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;II)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;->d:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    iput p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;->b:I

    iput p3, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;->c:I

    invoke-direct {p0}, Landroid/view/animation/Animation;-><init>()V

    return-void
.end method


# virtual methods
.method public applyTransformation(FLandroid/view/animation/Transformation;)V
    .locals 3

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;->d:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/b;

    move-result-object p2

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;->b:I

    int-to-float v1, v0

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$d;->c:I

    sub-int/2addr v2, v0

    int-to-float v0, v2

    mul-float/2addr v0, p1

    add-float/2addr v1, v0

    float-to-int p1, v1

    invoke-virtual {p2, p1}, Lcom/jude/easyrecyclerview/swipe/b;->setAlpha(I)V

    return-void
.end method
