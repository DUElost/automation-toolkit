.class Lcom/jude/easyrecyclerview/swipe/b$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/jude/easyrecyclerview/swipe/b;->q()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/jude/easyrecyclerview/swipe/b$d;

.field final synthetic b:Lcom/jude/easyrecyclerview/swipe/b;


# direct methods
.method constructor <init>(Lcom/jude/easyrecyclerview/swipe/b;Lcom/jude/easyrecyclerview/swipe/b$d;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->b:Lcom/jude/easyrecyclerview/swipe/b;

    iput-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->a:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 4

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->a:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->F()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->a:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->n()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->a:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->e()F

    move-result v1

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->D(F)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->b:Lcom/jude/easyrecyclerview/swipe/b;

    iget-boolean v1, v0, Lcom/jude/easyrecyclerview/swipe/b;->l:Z

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/jude/easyrecyclerview/swipe/b;->l:Z

    const-wide/16 v2, 0x534

    invoke-virtual {p1, v2, v3}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->a:Lcom/jude/easyrecyclerview/swipe/b$d;

    invoke-virtual {p1, v1}, Lcom/jude/easyrecyclerview/swipe/b$d;->C(Z)V

    goto :goto_0

    :cond_0
    invoke-static {v0}, Lcom/jude/easyrecyclerview/swipe/b;->e(Lcom/jude/easyrecyclerview/swipe/b;)F

    move-result p1

    const/high16 v1, 0x3f800000    # 1.0f

    add-float/2addr p1, v1

    const/high16 v1, 0x40a00000    # 5.0f

    rem-float/2addr p1, v1

    invoke-static {v0, p1}, Lcom/jude/easyrecyclerview/swipe/b;->f(Lcom/jude/easyrecyclerview/swipe/b;F)F

    :goto_0
    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 1

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b$b;->b:Lcom/jude/easyrecyclerview/swipe/b;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/jude/easyrecyclerview/swipe/b;->f(Lcom/jude/easyrecyclerview/swipe/b;F)F

    return-void
.end method
