.class public Lorg/achartengine/b;
.super Landroid/view/View;
.source ""


# static fields
.field private static final s:I


# instance fields
.field private b:Lorg/achartengine/f/a;

.field private c:Lorg/achartengine/h/b;

.field private d:Landroid/graphics/Rect;

.field private e:Landroid/os/Handler;

.field private f:Landroid/graphics/RectF;

.field private g:Landroid/graphics/Bitmap;

.field private h:Landroid/graphics/Bitmap;

.field private i:Landroid/graphics/Bitmap;

.field private j:I

.field private k:Lorg/achartengine/i/e;

.field private l:Lorg/achartengine/i/e;

.field private m:Lorg/achartengine/i/b;

.field private n:Landroid/graphics/Paint;

.field private o:Lorg/achartengine/c;

.field private p:F

.field private q:F

.field private r:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/16 v0, 0xaf

    const/16 v1, 0x96

    invoke-static {v0, v1, v1, v1}, Landroid/graphics/Color;->argb(IIII)I

    move-result v0

    sput v0, Lorg/achartengine/b;->s:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lorg/achartengine/f/a;)V
    .locals 2

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1}, Landroid/graphics/Rect;-><init>()V

    iput-object p1, p0, Lorg/achartengine/b;->d:Landroid/graphics/Rect;

    new-instance p1, Landroid/graphics/RectF;

    invoke-direct {p1}, Landroid/graphics/RectF;-><init>()V

    iput-object p1, p0, Lorg/achartengine/b;->f:Landroid/graphics/RectF;

    const/16 p1, 0x32

    iput p1, p0, Lorg/achartengine/b;->j:I

    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Lorg/achartengine/b;->n:Landroid/graphics/Paint;

    iput-object p2, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lorg/achartengine/b;->e:Landroid/os/Handler;

    iget-object p1, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    instance-of p2, p1, Lorg/achartengine/f/i;

    if-eqz p2, :cond_0

    check-cast p1, Lorg/achartengine/f/i;

    invoke-virtual {p1}, Lorg/achartengine/f/i;->B()Lorg/achartengine/h/d;

    move-result-object p1

    goto :goto_0

    :cond_0
    check-cast p1, Lorg/achartengine/f/e;

    invoke-virtual {p1}, Lorg/achartengine/f/e;->r()Lorg/achartengine/h/b;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    iget-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {p1}, Lorg/achartengine/h/b;->J()Z

    move-result p1

    if-eqz p1, :cond_1

    const-class p1, Lorg/achartengine/b;

    const-string p2, "image/zoom_in.png"

    invoke-virtual {p1, p2}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lorg/achartengine/b;->g:Landroid/graphics/Bitmap;

    const-class p1, Lorg/achartengine/b;

    const-string p2, "image/zoom_out.png"

    invoke-virtual {p1, p2}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lorg/achartengine/b;->h:Landroid/graphics/Bitmap;

    const-class p1, Lorg/achartengine/b;

    const-string p2, "image/zoom-1.png"

    invoke-virtual {p1, p2}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lorg/achartengine/b;->i:Landroid/graphics/Bitmap;

    :cond_1
    iget-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    instance-of p2, p1, Lorg/achartengine/h/d;

    if-eqz p2, :cond_2

    check-cast p1, Lorg/achartengine/h/d;

    invoke-virtual {p1}, Lorg/achartengine/h/d;->i0()I

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    check-cast p1, Lorg/achartengine/h/d;

    iget-object p2, p0, Lorg/achartengine/b;->n:Landroid/graphics/Paint;

    invoke-virtual {p2}, Landroid/graphics/Paint;->getColor()I

    move-result p2

    invoke-virtual {p1, p2}, Lorg/achartengine/h/d;->d1(I)V

    :cond_2
    iget-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {p1}, Lorg/achartengine/h/b;->K()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {p1}, Lorg/achartengine/h/b;->J()Z

    move-result p1

    if-nez p1, :cond_4

    :cond_3
    iget-object p1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {p1}, Lorg/achartengine/h/b;->x()Z

    move-result p1

    if-eqz p1, :cond_5

    :cond_4
    new-instance p1, Lorg/achartengine/i/e;

    iget-object p2, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    const/4 v0, 0x1

    iget-object v1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->t()F

    move-result v1

    invoke-direct {p1, p2, v0, v1}, Lorg/achartengine/i/e;-><init>(Lorg/achartengine/f/a;ZF)V

    iput-object p1, p0, Lorg/achartengine/b;->k:Lorg/achartengine/i/e;

    new-instance p1, Lorg/achartengine/i/e;

    iget-object p2, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    const/4 v0, 0x0

    iget-object v1, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {v1}, Lorg/achartengine/h/b;->t()F

    move-result v1

    invoke-direct {p1, p2, v0, v1}, Lorg/achartengine/i/e;-><init>(Lorg/achartengine/f/a;ZF)V

    iput-object p1, p0, Lorg/achartengine/b;->l:Lorg/achartengine/i/e;

    new-instance p1, Lorg/achartengine/i/b;

    iget-object p2, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    invoke-direct {p1, p2}, Lorg/achartengine/i/b;-><init>(Lorg/achartengine/f/a;)V

    iput-object p1, p0, Lorg/achartengine/b;->m:Lorg/achartengine/i/b;

    :cond_5
    const/4 p1, 0x7

    :try_start_0
    sget-object p2, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move p2, p1

    :goto_1
    if-ge p2, p1, :cond_6

    new-instance p1, Lorg/achartengine/e;

    iget-object p2, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    invoke-direct {p1, p0, p2}, Lorg/achartengine/e;-><init>(Lorg/achartengine/b;Lorg/achartengine/f/a;)V

    goto :goto_2

    :cond_6
    new-instance p1, Lorg/achartengine/d;

    iget-object p2, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    invoke-direct {p1, p0, p2}, Lorg/achartengine/d;-><init>(Lorg/achartengine/b;Lorg/achartengine/f/a;)V

    :goto_2
    iput-object p1, p0, Lorg/achartengine/b;->o:Lorg/achartengine/c;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lorg/achartengine/b;->e:Landroid/os/Handler;

    new-instance v1, Lorg/achartengine/b$a;

    invoke-direct {v1, p0}, Lorg/achartengine/b$a;-><init>(Lorg/achartengine/b;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public b()V
    .locals 2

    iget-object v0, p0, Lorg/achartengine/b;->k:Lorg/achartengine/i/e;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/achartengine/i/e;->e(I)V

    invoke-virtual {p0}, Lorg/achartengine/b;->a()V

    :cond_0
    return-void
.end method

.method public c()V
    .locals 2

    iget-object v0, p0, Lorg/achartengine/b;->l:Lorg/achartengine/i/e;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/achartengine/i/e;->e(I)V

    invoke-virtual {p0}, Lorg/achartengine/b;->a()V

    :cond_0
    return-void
.end method

.method public d()V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/b;->m:Lorg/achartengine/i/b;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/achartengine/i/b;->e()V

    iget-object v0, p0, Lorg/achartengine/b;->k:Lorg/achartengine/i/e;

    invoke-virtual {v0}, Lorg/achartengine/i/e;->g()V

    invoke-virtual {p0}, Lorg/achartengine/b;->a()V

    :cond_0
    return-void
.end method

.method public getChart()Lorg/achartengine/f/a;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    return-object v0
.end method

.method public getCurrentSeriesAndPoint()Lorg/achartengine/g/b;
    .locals 4

    iget-object v0, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    new-instance v1, Lorg/achartengine/g/a;

    iget v2, p0, Lorg/achartengine/b;->p:F

    iget v3, p0, Lorg/achartengine/b;->q:F

    invoke-direct {v1, v2, v3}, Lorg/achartengine/g/a;-><init>(FF)V

    invoke-virtual {v0, v1}, Lorg/achartengine/f/a;->m(Lorg/achartengine/g/a;)Lorg/achartengine/g/b;

    move-result-object v0

    return-object v0
.end method

.method protected getZoomRectangle()Landroid/graphics/RectF;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/b;->f:Landroid/graphics/RectF;

    return-object v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 13

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lorg/achartengine/b;->d:Landroid/graphics/Rect;

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->getClipBounds(Landroid/graphics/Rect;)Z

    iget-object v0, p0, Lorg/achartengine/b;->d:Landroid/graphics/Rect;

    iget v1, v0, Landroid/graphics/Rect;->top:I

    iget v2, v0, Landroid/graphics/Rect;->left:I

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    iget-object v3, p0, Lorg/achartengine/b;->d:Landroid/graphics/Rect;

    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v3

    iget-object v4, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {v4}, Lorg/achartengine/h/b;->z()Z

    move-result v4

    const/4 v5, 0x0

    if-eqz v4, :cond_0

    invoke-virtual {p0}, Landroid/view/View;->getMeasuredWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v3

    move v1, v5

    move v2, v1

    :cond_0
    iget-object v6, p0, Lorg/achartengine/b;->b:Lorg/achartengine/f/a;

    iget-object v12, p0, Lorg/achartengine/b;->n:Landroid/graphics/Paint;

    move-object v7, p1

    move v8, v2

    move v9, v1

    move v10, v0

    move v11, v3

    invoke-virtual/range {v6 .. v12}, Lorg/achartengine/f/a;->b(Landroid/graphics/Canvas;IIIILandroid/graphics/Paint;)V

    iget-object v4, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Lorg/achartengine/h/b;->K()Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {v4}, Lorg/achartengine/h/b;->J()Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lorg/achartengine/b;->n:Landroid/graphics/Paint;

    sget v5, Lorg/achartengine/b;->s:I

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setColor(I)V

    iget v4, p0, Lorg/achartengine/b;->j:I

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v5

    div-int/lit8 v5, v5, 0x7

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    iput v4, p0, Lorg/achartengine/b;->j:I

    iget-object v5, p0, Lorg/achartengine/b;->f:Landroid/graphics/RectF;

    add-int/2addr v2, v0

    mul-int/lit8 v0, v4, 0x3

    sub-int v0, v2, v0

    int-to-float v0, v0

    add-int/2addr v1, v3

    int-to-float v1, v1

    int-to-float v3, v4

    const v4, 0x3f466666    # 0.775f

    mul-float/2addr v3, v4

    sub-float v3, v1, v3

    int-to-float v2, v2

    invoke-virtual {v5, v0, v3, v2, v1}, Landroid/graphics/RectF;->set(FFFF)V

    iget-object v0, p0, Lorg/achartengine/b;->f:Landroid/graphics/RectF;

    iget v3, p0, Lorg/achartengine/b;->j:I

    div-int/lit8 v4, v3, 0x3

    int-to-float v4, v4

    div-int/lit8 v3, v3, 0x3

    int-to-float v3, v3

    iget-object v5, p0, Lorg/achartengine/b;->n:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v4, v3, v5}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    iget v0, p0, Lorg/achartengine/b;->j:I

    int-to-float v3, v0

    const/high16 v4, 0x3f200000    # 0.625f

    mul-float/2addr v3, v4

    sub-float/2addr v1, v3

    iget-object v3, p0, Lorg/achartengine/b;->g:Landroid/graphics/Bitmap;

    int-to-float v0, v0

    const/high16 v4, 0x40300000    # 2.75f

    mul-float/2addr v0, v4

    sub-float v0, v2, v0

    const/4 v4, 0x0

    invoke-virtual {p1, v3, v0, v1, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    iget-object v0, p0, Lorg/achartengine/b;->h:Landroid/graphics/Bitmap;

    iget v3, p0, Lorg/achartengine/b;->j:I

    int-to-float v3, v3

    const/high16 v5, 0x3fe00000    # 1.75f

    mul-float/2addr v3, v5

    sub-float v3, v2, v3

    invoke-virtual {p1, v0, v3, v1, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    iget-object v0, p0, Lorg/achartengine/b;->i:Landroid/graphics/Bitmap;

    iget v3, p0, Lorg/achartengine/b;->j:I

    int-to-float v3, v3

    const/high16 v5, 0x3f400000    # 0.75f

    mul-float/2addr v3, v5

    sub-float/2addr v2, v3

    invoke-virtual {p1, v0, v2, v1, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    :cond_1
    const/4 p1, 0x1

    iput-boolean p1, p0, Lorg/achartengine/b;->r:Z

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iput v0, p0, Lorg/achartengine/b;->p:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    iput v0, p0, Lorg/achartengine/b;->q:F

    :cond_0
    iget-object v0, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    if-eqz v0, :cond_2

    iget-boolean v1, p0, Lorg/achartengine/b;->r:Z

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Lorg/achartengine/h/b;->A()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lorg/achartengine/b;->c:Lorg/achartengine/h/b;

    invoke-virtual {v0}, Lorg/achartengine/h/b;->K()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    iget-object v0, p0, Lorg/achartengine/b;->o:Lorg/achartengine/c;

    invoke-interface {v0, p1}, Lorg/achartengine/c;->a(Landroid/view/MotionEvent;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 p1, 0x1

    return p1

    :cond_2
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public setZoomRate(F)V
    .locals 2

    iget-object v0, p0, Lorg/achartengine/b;->k:Lorg/achartengine/i/e;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lorg/achartengine/b;->l:Lorg/achartengine/i/e;

    if-eqz v1, :cond_0

    invoke-virtual {v0, p1}, Lorg/achartengine/i/e;->h(F)V

    iget-object v0, p0, Lorg/achartengine/b;->l:Lorg/achartengine/i/e;

    invoke-virtual {v0, p1}, Lorg/achartengine/i/e;->h(F)V

    :cond_0
    return-void
.end method
