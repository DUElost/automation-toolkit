.class public Llife/knowledge4/videotrimmer/view/ProgressBarView;
.super Landroid/view/View;
.source ""

# interfaces
.implements Llife/knowledge4/videotrimmer/g/b;
.implements Llife/knowledge4/videotrimmer/g/a;


# instance fields
.field private b:I

.field private c:I

.field private final d:Landroid/graphics/Paint;

.field private final e:Landroid/graphics/Paint;

.field private f:Landroid/graphics/Rect;

.field private g:Landroid/graphics/Rect;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Llife/knowledge4/videotrimmer/view/ProgressBarView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->d:Landroid/graphics/Paint;

    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->e:Landroid/graphics/Paint;

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->h()V

    return-void
.end method

.method private f(Landroid/graphics/Canvas;)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->d:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    :cond_0
    return-void
.end method

.method private g(Landroid/graphics/Canvas;)V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->g:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->e:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    :cond_0
    return-void
.end method

.method private h()V
    .locals 4

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/a;->progress_color:I

    invoke-static {v0, v1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    sget v2, Llife/knowledge4/videotrimmer/a;->background_progress_color:I

    invoke-static {v1, v2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Llife/knowledge4/videotrimmer/b;->progress_video_line_height:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v2

    iput v2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->b:I

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->d:Landroid/graphics/Paint;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->d:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->e:Landroid/graphics/Paint;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->e:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    return-void
.end method

.method private i(IF)V
    .locals 4

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Rect;

    iget v2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->c:I

    iget v3, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->b:I

    invoke-direct {v0, v1, v1, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    :cond_0
    iget v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->c:I

    int-to-float v0, v0

    mul-float/2addr v0, p2

    const/high16 p2, 0x42c80000    # 100.0f

    div-float/2addr v0, p2

    float-to-int p2, v0

    if-nez p1, :cond_1

    new-instance p1, Landroid/graphics/Rect;

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    iget v2, v0, Landroid/graphics/Rect;->top:I

    iget v3, v0, Landroid/graphics/Rect;->right:I

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    invoke-direct {p1, p2, v2, v3, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    goto :goto_0

    :cond_1
    new-instance p1, Landroid/graphics/Rect;

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    iget v2, v0, Landroid/graphics/Rect;->left:I

    iget v3, v0, Landroid/graphics/Rect;->top:I

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    invoke-direct {p1, v2, v3, p2, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    :goto_0
    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    const/4 p1, 0x0

    invoke-virtual {p0, v1, v1, p1}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->c(IIF)V

    return-void
.end method


# virtual methods
.method public a(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    invoke-direct {p0, p2, p3}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->i(IF)V

    return-void
.end method

.method public b(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    invoke-direct {p0, p2, p3}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->i(IF)V

    return-void
.end method

.method public c(IIF)V
    .locals 2

    const/4 p1, 0x0

    cmpl-float p1, p3, p1

    if-nez p1, :cond_0

    new-instance p1, Landroid/graphics/Rect;

    iget-object p2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    iget p3, p2, Landroid/graphics/Rect;->top:I

    iget p2, p2, Landroid/graphics/Rect;->bottom:I

    const/4 v0, 0x0

    invoke-direct {p1, v0, p3, v0, p2}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->g:Landroid/graphics/Rect;

    goto :goto_0

    :cond_0
    iget p1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->c:I

    int-to-float p1, p1

    mul-float/2addr p1, p3

    const/high16 p2, 0x42c80000    # 100.0f

    div-float/2addr p1, p2

    float-to-int p1, p1

    new-instance p2, Landroid/graphics/Rect;

    iget-object p3, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f:Landroid/graphics/Rect;

    iget v0, p3, Landroid/graphics/Rect;->left:I

    iget v1, p3, Landroid/graphics/Rect;->top:I

    iget p3, p3, Landroid/graphics/Rect;->bottom:I

    invoke-direct {p2, v0, v1, p1, p3}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object p2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->g:Landroid/graphics/Rect;

    :goto_0
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    return-void
.end method

.method public d(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    invoke-direct {p0, p2, p3}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->i(IF)V

    return-void
.end method

.method public e(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    invoke-direct {p0, p2, p3}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->i(IF)V

    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->f(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/ProgressBarView;->g(Landroid/graphics/Canvas;)V

    return-void
.end method

.method protected onMeasure(II)V
    .locals 2

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

    iput p1, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->c:I

    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result p1

    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v0

    add-int/2addr p1, v0

    iget v0, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->b:I

    add-int/2addr p1, v0

    invoke-static {p1, p2, v1}, Landroid/view/View;->resolveSizeAndState(III)I

    move-result p1

    iget p2, p0, Llife/knowledge4/videotrimmer/view/ProgressBarView;->c:I

    invoke-virtual {p0, p2, p1}, Landroid/view/View;->setMeasuredDimension(II)V

    return-void
.end method
