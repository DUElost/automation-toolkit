.class public Llife/knowledge4/videotrimmer/view/RangeSeekBarView;
.super Landroid/view/View;
.source ""


# instance fields
.field private b:I

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/view/a;",
            ">;"
        }
    .end annotation
.end field

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/g/b;",
            ">;"
        }
    .end annotation
.end field

.field private e:F

.field private f:F

.field private g:F

.field private h:I

.field private i:F

.field private j:F

.field private k:F

.field private l:Z

.field private final m:Landroid/graphics/Paint;

.field private final n:Landroid/graphics/Paint;

.field private o:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->m:Landroid/graphics/Paint;

    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n:Landroid/graphics/Paint;

    const/4 p1, 0x0

    iput p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->i()V

    return-void
.end method

.method private b(I)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result v1

    invoke-direct {p0, p1, v1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->p(IF)F

    move-result p1

    invoke-virtual {v0, p1}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    :cond_0
    return-void
.end method

.method private c(I)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v1

    invoke-direct {p0, p1, v1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o(IF)F

    move-result v1

    invoke-virtual {v0, v1}, Llife/knowledge4/videotrimmer/view/a;->o(F)V

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result v0

    invoke-direct {p0, p0, p1, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->l(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    :cond_0
    return-void
.end method

.method private d(Llife/knowledge4/videotrimmer/view/a;Llife/knowledge4/videotrimmer/view/a;FZ)V
    .locals 2

    const/4 v0, 0x0

    if-eqz p4, :cond_0

    cmpg-float v1, p3, v0

    if-gez v1, :cond_0

    invoke-virtual {p2}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p4

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v0

    add-float/2addr v0, p3

    sub-float/2addr p4, v0

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->e:F

    cmpl-float p4, p4, v0

    if-lez p4, :cond_1

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p1

    add-float/2addr p1, p3

    iget p3, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->e:F

    add-float/2addr p1, p3

    invoke-virtual {p2, p1}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    const/4 p1, 0x1

    invoke-virtual {p2}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p2

    invoke-direct {p0, p1, p2}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->q(IF)V

    goto :goto_0

    :cond_0
    if-nez p4, :cond_1

    cmpl-float p4, p3, v0

    if-lez p4, :cond_1

    invoke-virtual {p2}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p4

    add-float/2addr p4, p3

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v0

    sub-float/2addr p4, v0

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->e:F

    cmpl-float p4, p4, v0

    if-lez p4, :cond_1

    invoke-virtual {p2}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p2

    add-float/2addr p2, p3

    iget p3, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->e:F

    sub-float/2addr p2, p3

    invoke-virtual {p1, p2}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    const/4 p2, 0x0

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p1

    invoke-direct {p0, p2, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->q(IF)V

    :cond_1
    :goto_0
    return-void
.end method

.method private e(Landroid/graphics/Canvas;)V
    .locals 6

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->d()I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v1

    if-nez v2, :cond_1

    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    move-result v2

    int-to-float v2, v2

    add-float/2addr v1, v2

    iget v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->i:F

    cmpl-float v2, v1, v2

    if-lez v2, :cond_0

    new-instance v2, Landroid/graphics/Rect;

    iget v4, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    float-to-int v5, v4

    add-float/2addr v1, v4

    float-to-int v1, v1

    iget v4, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->b:I

    invoke-direct {v2, v5, v3, v1, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    :goto_1
    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->m:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    move-result v2

    int-to-float v2, v2

    sub-float/2addr v1, v2

    iget v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j:F

    cmpg-float v2, v1, v2

    if-gez v2, :cond_0

    new-instance v2, Landroid/graphics/Rect;

    float-to-int v1, v1

    iget v4, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->h:I

    int-to-float v4, v4

    iget v5, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    sub-float/2addr v4, v5

    float-to-int v4, v4

    iget v5, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->b:I

    invoke-direct {v2, v1, v3, v4, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method private f(Landroid/graphics/Canvas;)V
    .locals 6

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->d()I

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->a()Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v1

    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    move-result v4

    int-to-float v4, v4

    add-float/2addr v1, v4

    goto :goto_1

    :cond_0
    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->a()Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v1

    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    move-result v4

    int-to-float v4, v4

    sub-float/2addr v1, v4

    :goto_1
    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v4

    iget v5, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->b:I

    add-int/2addr v4, v5

    int-to-float v4, v4

    invoke-virtual {p1, v2, v1, v4, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private g(F)I
    .locals 4

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    const/4 v1, -0x1

    if-nez v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v2}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v2

    iget v3, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    add-float/2addr v2, v3

    iget-object v3, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v3}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v3

    cmpl-float v3, p1, v3

    if-ltz v3, :cond_0

    cmpg-float v2, p1, v2

    if-gtz v2, :cond_0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->d()I

    move-result v1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return v1
.end method

.method private h(I)F
    .locals 1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result p1

    return p1
.end method

.method private i()V
    .locals 3

    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-static {v0}, Llife/knowledge4/videotrimmer/view/a;->j(Landroid/content/res/Resources;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-static {v0}, Llife/knowledge4/videotrimmer/view/a;->i(Ljava/util/List;)I

    move-result v0

    int-to-float v0, v0

    iput v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-static {v0}, Llife/knowledge4/videotrimmer/view/a;->c(Ljava/util/List;)I

    move-result v0

    int-to-float v0, v0

    iput v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->g:F

    const/high16 v0, 0x42c80000    # 100.0f

    iput v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->k:F

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/b;->frames_video_height:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v0

    iput v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->b:I

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/view/View;->setFocusable(Z)V

    invoke-virtual {p0, v0}, Landroid/view/View;->setFocusableInTouchMode(Z)V

    iput-boolean v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->l:Z

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    sget v2, Llife/knowledge4/videotrimmer/a;->shadow_color:I

    invoke-static {v1, v2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v1

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->m:Landroid/graphics/Paint;

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->m:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->m:Landroid/graphics/Paint;

    const/16 v2, 0xb1

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    sget v2, Llife/knowledge4/videotrimmer/a;->line_color:I

    invoke-static {v1, v2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v1

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n:Landroid/graphics/Paint;

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n:Landroid/graphics/Paint;

    const/16 v1, 0xc8

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    return-void
.end method

.method private k(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/g/b;

    invoke-interface {v1, p1, p2, p3}, Llife/knowledge4/videotrimmer/g/b;->e(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private l(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/g/b;

    invoke-interface {v1, p1, p2, p3}, Llife/knowledge4/videotrimmer/g/b;->a(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private m(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/g/b;

    invoke-interface {v1, p1, p2, p3}, Llife/knowledge4/videotrimmer/g/b;->b(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private n(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/g/b;

    invoke-interface {v1, p1, p2, p3}, Llife/knowledge4/videotrimmer/g/b;->d(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private o(IF)F
    .locals 3

    const/high16 v0, 0x42c80000    # 100.0f

    mul-float/2addr p2, v0

    iget v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j:F

    div-float/2addr p2, v1

    if-nez p1, :cond_0

    iget p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    mul-float/2addr p1, p2

    div-float/2addr p1, v0

    mul-float/2addr p1, v0

    div-float/2addr p1, v1

    add-float/2addr p2, p1

    return p2

    :cond_0
    sub-float p1, v0, p2

    iget v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    mul-float/2addr p1, v2

    div-float/2addr p1, v0

    mul-float/2addr p1, v0

    div-float/2addr p1, v1

    sub-float/2addr p2, p1

    return p2
.end method

.method private p(IF)F
    .locals 2

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j:F

    mul-float/2addr v0, p2

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    if-nez p1, :cond_0

    iget p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    mul-float/2addr p2, p1

    div-float/2addr p2, v1

    sub-float/2addr v0, p2

    return v0

    :cond_0
    sub-float p1, v1, p2

    iget p2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    mul-float/2addr p1, p2

    div-float/2addr p1, v1

    add-float/2addr v0, p1

    return v0
.end method

.method private q(IF)V
    .locals 1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0, p2}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c(I)V

    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    return-void
.end method


# virtual methods
.method public a(Llife/knowledge4/videotrimmer/g/b;)V
    .locals 1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public getThumbs()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/view/a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    return-object v0
.end method

.method public j()V
    .locals 4

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v0

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    const/4 v3, 0x0

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v2}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v2

    sub-float/2addr v0, v2

    iput v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->e:F

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result v0

    invoke-direct {p0, p0, v3, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result v0

    invoke-direct {p0, p0, v1, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->e(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f(Landroid/graphics/Canvas;)V

    return-void
.end method

.method protected onMeasure(II)V
    .locals 3

    invoke-super {p0, p1, p2}, Landroid/view/View;->onMeasure(II)V

    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    move-result v1

    add-int/2addr v0, v1

    invoke-virtual {p0}, Landroid/view/View;->getSuggestedMinimumWidth()I

    move-result v1

    add-int/2addr v0, v1

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/view/View;->resolveSizeAndState(III)I

    move-result p1

    iput p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->h:I

    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result p1

    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v0

    add-int/2addr p1, v0

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->g:F

    float-to-int v0, v0

    add-int/2addr p1, v0

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->b:I

    add-int/2addr p1, v0

    invoke-static {p1, p2, v1}, Landroid/view/View;->resolveSizeAndState(III)I

    move-result p1

    iget p2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->h:I

    invoke-virtual {p0, p2, p1}, Landroid/view/View;->setMeasuredDimension(II)V

    const/4 p1, 0x0

    iput p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->i:F

    iget p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->h:I

    int-to-float p1, p1

    iget p2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->f:F

    sub-float/2addr p1, p2

    iput p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j:F

    iget-boolean p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->l:Z

    if-eqz p1, :cond_1

    const/4 p1, 0x0

    move p2, p1

    :goto_0
    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p2, v0, :cond_0

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    iget v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->k:F

    int-to-float v2, p2

    mul-float/2addr v1, v2

    invoke-virtual {v0, v1}, Llife/knowledge4/videotrimmer/view/a;->o(F)V

    iget v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j:F

    mul-float/2addr v1, v2

    invoke-virtual {v0, v1}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_0
    iget p2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    invoke-direct {p0, p2}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->h(I)F

    move-result v0

    invoke-direct {p0, p0, p2, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->k(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    iput-boolean p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->l:Z

    :cond_1
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz p1, :cond_9

    if-eq p1, v3, :cond_7

    const/4 v1, 0x2

    if-eq p1, v1, :cond_0

    return v2

    :cond_0
    iget-object p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    iget v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/view/a;

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    iget v4, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    if-nez v4, :cond_1

    move v4, v3

    goto :goto_0

    :cond_1
    move v4, v2

    :goto_0
    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->e()F

    move-result v4

    sub-float v4, v0, v4

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v5

    add-float/2addr v5, v4

    iget v6, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    if-nez v6, :cond_4

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->h()I

    move-result v2

    int-to-float v2, v2

    add-float/2addr v2, v5

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v6

    cmpl-float v2, v2, v6

    if-ltz v2, :cond_2

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v0

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->h()I

    move-result v1

    int-to-float v1, v1

    sub-float/2addr v0, v1

    goto :goto_1

    :cond_2
    iget v2, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->i:F

    cmpg-float v5, v5, v2

    if-gtz v5, :cond_3

    invoke-virtual {p1, v2}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    goto :goto_3

    :cond_3
    invoke-direct {p0, p1, v1, v4, v3}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d(Llife/knowledge4/videotrimmer/view/a;Llife/knowledge4/videotrimmer/view/a;FZ)V

    goto :goto_2

    :cond_4
    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v6

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->h()I

    move-result v7

    int-to-float v7, v7

    add-float/2addr v6, v7

    cmpg-float v6, v5, v6

    if-gtz v6, :cond_5

    invoke-virtual {v1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v0

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->h()I

    move-result v1

    int-to-float v1, v1

    add-float/2addr v0, v1

    :goto_1
    invoke-virtual {p1, v0}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    goto :goto_3

    :cond_5
    iget v6, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j:F

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_6

    invoke-virtual {p1, v6}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    goto :goto_3

    :cond_6
    invoke-direct {p0, v1, p1, v4, v2}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->d(Llife/knowledge4/videotrimmer/view/a;Llife/knowledge4/videotrimmer/view/a;FZ)V

    :goto_2
    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result v1

    add-float/2addr v1, v4

    invoke-virtual {p1, v1}, Llife/knowledge4/videotrimmer/view/a;->n(F)V

    invoke-virtual {p1, v0}, Llife/knowledge4/videotrimmer/view/a;->m(F)V

    :goto_3
    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->f()F

    move-result p1

    invoke-direct {p0, v0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->q(IF)V

    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    return v3

    :cond_7
    iget p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    if-ne p1, v1, :cond_8

    return v2

    :cond_8
    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/view/a;

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result p1

    invoke-direct {p0, p0, v0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->n(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    return v3

    :cond_9
    invoke-direct {p0, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->g(F)I

    move-result p1

    iput p1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    if-ne p1, v1, :cond_a

    return v2

    :cond_a
    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {p1, v0}, Llife/knowledge4/videotrimmer/view/a;->m(F)V

    iget v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->o:I

    invoke-virtual {p1}, Llife/knowledge4/videotrimmer/view/a;->g()F

    move-result p1

    invoke-direct {p0, p0, v0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->m(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V

    return v3
.end method

.method public r(IF)V
    .locals 1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0, p2}, Llife/knowledge4/videotrimmer/view/a;->o(F)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->b(I)V

    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    return-void
.end method
