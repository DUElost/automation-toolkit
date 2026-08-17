.class Lcom/jude/easyrecyclerview/swipe/b$a;
.super Landroid/view/animation/Animation;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/swipe/b;->q()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/jude/easyrecyclerview/swipe/b$d;

.field final synthetic c:Lcom/jude/easyrecyclerview/swipe/b;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/swipe/b;Lcom/jude/easyrecyclerview/swipe/b$d;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->c:Lcom/jude/easyrecyclerview/swipe/b;

    iput-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-direct {p0}, Landroid/view/animation/Animation;-><init>()V

    return-void
.end method


# virtual methods
.method public applyTransformation(FLandroid/view/animation/Transformation;)V
    .locals 8

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->c:Lcom/jude/easyrecyclerview/swipe/b;

    iget-boolean v0, p2, Lcom/jude/easyrecyclerview/swipe/b;->l:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-static {p2, p1, v0}, Lcom/jude/easyrecyclerview/swipe/b;->a(Lcom/jude/easyrecyclerview/swipe/b;FLcom/jude/easyrecyclerview/swipe/b$d;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-static {p2, v0}, Lcom/jude/easyrecyclerview/swipe/b;->b(Lcom/jude/easyrecyclerview/swipe/b;Lcom/jude/easyrecyclerview/swipe/b$d;)F

    move-result p2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->j()F

    move-result v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->l()F

    move-result v1

    iget-object v2, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v2}, Lcom/jude/easyrecyclerview/swipe/b$d;->k()F

    move-result v2

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->c:Lcom/jude/easyrecyclerview/swipe/b;

    iget-object v4, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-static {v3, p1, v4}, Lcom/jude/easyrecyclerview/swipe/b;->c(Lcom/jude/easyrecyclerview/swipe/b;FLcom/jude/easyrecyclerview/swipe/b$d;)V

    const/high16 v3, 0x3f000000    # 0.5f

    cmpg-float v4, p1, v3

    const v5, 0x3f4ccccd    # 0.8f

    if-gtz v4, :cond_1

    div-float v4, p1, v3

    sub-float v6, v5, p2

    invoke-static {}, Lcom/jude/easyrecyclerview/swipe/b;->d()Landroid/view/animation/Interpolator;

    move-result-object v7

    invoke-interface {v7, v4}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result v4

    mul-float/2addr v6, v4

    add-float/2addr v1, v6

    iget-object v4, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v4, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->D(F)V

    :cond_1
    cmpl-float v1, p1, v3

    if-lez v1, :cond_2

    sub-float/2addr v5, p2

    sub-float p2, p1, v3

    div-float/2addr p2, v3

    invoke-static {}, Lcom/jude/easyrecyclerview/swipe/b;->d()Landroid/view/animation/Interpolator;

    move-result-object v1

    invoke-interface {v1, p2}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p2

    mul-float/2addr v5, p2

    add-float/2addr v0, v5

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {p2, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->z(F)V

    :cond_2
    const/high16 p2, 0x3e800000    # 0.25f

    mul-float/2addr p2, p1

    add-float/2addr v2, p2

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->b:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {p2, v2}, Lcom/jude/easyrecyclerview/swipe/b$d;->B(F)V

    const/high16 p2, 0x43580000    # 216.0f

    mul-float/2addr p1, p2

    const/high16 p2, 0x44870000    # 1080.0f

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->c:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-static {v0}, Lcom/jude/easyrecyclerview/swipe/b;->e(Lcom/jude/easyrecyclerview/swipe/b;)F

    move-result v0

    const/high16 v1, 0x40a00000    # 5.0f

    div-float/2addr v0, v1

    mul-float/2addr v0, p2

    add-float/2addr p1, v0

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$a;->c:Lcom/jude/easyrecyclerview/swipe/b;

    invoke-virtual {p2, p1}, Lcom/jude/easyrecyclerview/swipe/b;->n(F)V

    :goto_0
    return-void
.end method
