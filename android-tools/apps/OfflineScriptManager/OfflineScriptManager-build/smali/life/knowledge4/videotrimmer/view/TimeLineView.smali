.class public Llife/knowledge4/videotrimmer/view/TimeLineView;
.super Landroid/view/View;
.source ""


# instance fields
.field private b:Landroid/net/Uri;

.field private c:I

.field private d:Landroid/util/LongSparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/LongSparseArray<",
            "Landroid/graphics/Bitmap;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Llife/knowledge4/videotrimmer/view/TimeLineView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->d:Landroid/util/LongSparseArray;

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/view/TimeLineView;->f()V

    return-void
.end method

.method static synthetic a(Llife/knowledge4/videotrimmer/view/TimeLineView;)Landroid/net/Uri;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->b:Landroid/net/Uri;

    return-object p0
.end method

.method static synthetic b(Llife/knowledge4/videotrimmer/view/TimeLineView;)I
    .locals 0

    iget p0, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->c:I

    return p0
.end method

.method static synthetic c(Llife/knowledge4/videotrimmer/view/TimeLineView;Landroid/util/LongSparseArray;)V
    .locals 0

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/TimeLineView;->g(Landroid/util/LongSparseArray;)V

    return-void
.end method

.method static synthetic d(Llife/knowledge4/videotrimmer/view/TimeLineView;Landroid/util/LongSparseArray;)Landroid/util/LongSparseArray;
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->d:Landroid/util/LongSparseArray;

    return-object p1
.end method

.method private e(I)V
    .locals 8

    new-instance v7, Llife/knowledge4/videotrimmer/view/TimeLineView$a;

    const-string v2, ""

    const-wide/16 v3, 0x0

    const-string v5, ""

    move-object v0, v7

    move-object v1, p0

    move v6, p1

    invoke-direct/range {v0 .. v6}, Llife/knowledge4/videotrimmer/view/TimeLineView$a;-><init>(Llife/knowledge4/videotrimmer/view/TimeLineView;Ljava/lang/String;JLjava/lang/String;I)V

    invoke-static {v7}, Llife/knowledge4/videotrimmer/h/a;->e(Llife/knowledge4/videotrimmer/h/a$a;)V

    return-void
.end method

.method private f()V
    .locals 2

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/b;->frames_video_height:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v0

    iput v0, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->c:I

    return-void
.end method

.method private g(Landroid/util/LongSparseArray;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/LongSparseArray<",
            "Landroid/graphics/Bitmap;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Llife/knowledge4/videotrimmer/view/TimeLineView$b;

    invoke-direct {v0, p0, p1}, Llife/knowledge4/videotrimmer/view/TimeLineView$b;-><init>(Llife/knowledge4/videotrimmer/view/TimeLineView;Landroid/util/LongSparseArray;)V

    const-string p1, ""

    const-wide/16 v1, 0x0

    invoke-static {p1, v0, v1, v2}, Llife/knowledge4/videotrimmer/h/c;->d(Ljava/lang/String;Ljava/lang/Runnable;J)V

    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 6

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->d:Landroid/util/LongSparseArray;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->d:Landroid/util/LongSparseArray;

    invoke-virtual {v2}, Landroid/util/LongSparseArray;->size()I

    move-result v2

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->d:Landroid/util/LongSparseArray;

    int-to-long v3, v0

    invoke-virtual {v2, v3, v4}, Landroid/util/LongSparseArray;->get(J)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/graphics/Bitmap;

    if-eqz v2, :cond_0

    int-to-float v3, v1

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {p1, v2, v3, v4, v5}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    add-int/2addr v1, v2

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method protected onMeasure(II)V
    .locals 3

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

    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v2

    add-int/2addr v0, v2

    iget v2, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->c:I

    add-int/2addr v0, v2

    invoke-static {v0, p2, v1}, Landroid/view/View;->resolveSizeAndState(III)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Landroid/view/View;->setMeasuredDimension(II)V

    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    if-eq p1, p3, :cond_0

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/view/TimeLineView;->e(I)V

    :cond_0
    return-void
.end method

.method public setVideo(Landroid/net/Uri;)V
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/TimeLineView;->b:Landroid/net/Uri;

    return-void
.end method
