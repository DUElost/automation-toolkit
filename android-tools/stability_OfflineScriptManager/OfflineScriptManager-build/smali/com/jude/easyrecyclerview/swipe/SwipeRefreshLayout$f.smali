.class Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;
.super Landroid/view/animation/Animation;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;
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

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-direct {p0}, Landroid/view/animation/Animation;-><init>()V

    return-void
.end method


# virtual methods
.method public applyTransformation(FLandroid/view/animation/Transformation;)V
    .locals 2

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->d(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Z

    move-result p2

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->e(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)F

    move-result p2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    iget v0, v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->u:I

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    int-to-float v0, v0

    sub-float/2addr p2, v0

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->e(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)F

    move-result p2

    :goto_0
    float-to-int p2, p2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    iget v1, v0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->s:I

    sub-int/2addr p2, v1

    int-to-float p2, p2

    mul-float/2addr p2, p1

    float-to-int p2, p2

    add-int/2addr v1, p2

    invoke-static {v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->j(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/a;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/ImageView;->getTop()I

    move-result p2

    sub-int/2addr v1, p2

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    const/4 v0, 0x0

    invoke-static {p2, v1, v0}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->p(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;IZ)V

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout$f;->b:Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;

    invoke-static {p2}, Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;->b(Lcom/jude/easyrecyclerview/swipe/SwipeRefreshLayout;)Lcom/jude/easyrecyclerview/swipe/b;

    move-result-object p2

    const/high16 v0, 0x3f800000    # 1.0f

    sub-float/2addr v0, p1

    invoke-virtual {p2, v0}, Lcom/jude/easyrecyclerview/swipe/b;->j(F)V

    return-void
.end method
