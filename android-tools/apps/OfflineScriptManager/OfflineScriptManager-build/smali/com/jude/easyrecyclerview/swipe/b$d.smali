.class Lcom/jude/easyrecyclerview/swipe/b$d;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/jude/easyrecyclerview/swipe/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "d"
.end annotation


# instance fields
.field private final a:Landroid/graphics/RectF;

.field private final b:Landroid/graphics/Paint;

.field private final c:Landroid/graphics/Paint;

.field private final d:Landroid/graphics/drawable/Drawable$Callback;

.field private e:F

.field private f:F

.field private g:F

.field private h:F

.field private i:F

.field private j:[I

.field private k:I

.field private l:F

.field private m:F

.field private n:F

.field private o:Z

.field private p:Landroid/graphics/Path;

.field private q:F

.field private r:D

.field private s:I

.field private t:I

.field private u:I

.field private final v:Landroid/graphics/Paint;

.field private w:I

.field private x:I


# direct methods
.method public constructor <init>(Landroid/graphics/drawable/Drawable$Callback;)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->a:Landroid/graphics/RectF;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->b:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->c:Landroid/graphics/Paint;

    const/4 v2, 0x0

    iput v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->e:F

    iput v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->f:F

    iput v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->g:F

    const/high16 v2, 0x40a00000    # 5.0f

    iput v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->h:F

    const/high16 v2, 0x40200000    # 2.5f

    iput v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->i:F

    new-instance v2, Landroid/graphics/Paint;

    const/4 v3, 0x1

    invoke-direct {v2, v3}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->v:Landroid/graphics/Paint;

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->d:Landroid/graphics/drawable/Drawable$Callback;

    sget-object p1, Landroid/graphics/Paint$Cap;->SQUARE:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    sget-object p1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    sget-object p1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, p1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    return-void
.end method

.method private b(Landroid/graphics/Canvas;FFLandroid/graphics/Rect;)V
    .locals 7

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->o:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    sget-object v1, Landroid/graphics/Path$FillType;->EVEN_ODD:Landroid/graphics/Path$FillType;

    invoke-virtual {v0, v1}, Landroid/graphics/Path;->setFillType(Landroid/graphics/Path$FillType;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    :goto_0
    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->i:F

    float-to-int v0, v0

    div-int/lit8 v0, v0, 0x2

    int-to-float v0, v0

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->q:F

    mul-float/2addr v0, v1

    iget-wide v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->r:D

    const-wide/16 v3, 0x0

    invoke-static {v3, v4}, Ljava/lang/Math;->cos(D)D

    move-result-wide v5

    mul-double/2addr v1, v5

    invoke-virtual {p4}, Landroid/graphics/Rect;->exactCenterX()F

    move-result v5

    float-to-double v5, v5

    add-double/2addr v1, v5

    double-to-float v1, v1

    iget-wide v5, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->r:D

    invoke-static {v3, v4}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    mul-double/2addr v5, v2

    invoke-virtual {p4}, Landroid/graphics/Rect;->exactCenterY()F

    move-result v2

    float-to-double v2, v2

    add-double/2addr v5, v2

    double-to-float v2, v5

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    const/4 v4, 0x0

    invoke-virtual {v3, v4, v4}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    iget v5, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->s:I

    int-to-float v5, v5

    iget v6, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->q:F

    mul-float/2addr v5, v6

    invoke-virtual {v3, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    iget v4, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->s:I

    int-to-float v4, v4

    iget v5, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->q:F

    mul-float/2addr v4, v5

    const/high16 v6, 0x40000000    # 2.0f

    div-float/2addr v4, v6

    iget v6, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->t:I

    int-to-float v6, v6

    mul-float/2addr v6, v5

    invoke-virtual {v3, v4, v6}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    sub-float/2addr v1, v0

    invoke-virtual {v3, v1, v2}, Landroid/graphics/Path;->offset(FF)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->close()V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->c:Landroid/graphics/Paint;

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->x:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    add-float/2addr p2, p3

    const/high16 p3, 0x40a00000    # 5.0f

    sub-float/2addr p2, p3

    invoke-virtual {p4}, Landroid/graphics/Rect;->exactCenterX()F

    move-result p3

    invoke-virtual {p4}, Landroid/graphics/Rect;->exactCenterY()F

    move-result p4

    invoke-virtual {p1, p2, p3, p4}, Landroid/graphics/Canvas;->rotate(FFF)V

    iget-object p2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->p:Landroid/graphics/Path;

    iget-object p3, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    :cond_1
    return-void
.end method

.method private g()I
    .locals 2

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->k:I

    add-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->j:[I

    array-length v1, v1

    rem-int/2addr v0, v1

    return v0
.end method

.method private o()V
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->d:Landroid/graphics/drawable/Drawable$Callback;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/graphics/drawable/Drawable$Callback;->invalidateDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method


# virtual methods
.method public A(II)V
    .locals 4

    invoke-static {p1, p2}, Ljava/lang/Math;->min(II)I

    move-result p1

    int-to-float p1, p1

    iget-wide v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->r:D

    const-wide/16 v2, 0x0

    cmpg-double p2, v0, v2

    const/high16 v2, 0x40000000    # 2.0f

    if-lez p2, :cond_1

    const/4 p2, 0x0

    cmpg-float p2, p1, p2

    if-gez p2, :cond_0

    goto :goto_0

    :cond_0
    div-float/2addr p1, v2

    float-to-double p1, p1

    sub-double/2addr p1, v0

    goto :goto_1

    :cond_1
    :goto_0
    iget p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->h:F

    div-float/2addr p1, v2

    float-to-double p1, p1

    invoke-static {p1, p2}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p1

    :goto_1
    double-to-float p1, p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->i:F

    return-void
.end method

.method public B(F)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->g:F

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    return-void
.end method

.method public C(Z)V
    .locals 1

    iget-boolean v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->o:Z

    if-eq v0, p1, :cond_0

    iput-boolean p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->o:Z

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    :cond_0
    return-void
.end method

.method public D(F)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->e:F

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    return-void
.end method

.method public E(F)V
    .locals 1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->h:F

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->b:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    return-void
.end method

.method public F()V
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->e:F

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->l:F

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->f:F

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->m:F

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->g:F

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->n:F

    return-void
.end method

.method public a(Landroid/graphics/Canvas;Landroid/graphics/Rect;)V
    .locals 8

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->a:Landroid/graphics/RectF;

    invoke-virtual {v1, p2}, Landroid/graphics/RectF;->set(Landroid/graphics/Rect;)V

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->i:F

    invoke-virtual {v1, v0, v0}, Landroid/graphics/RectF;->inset(FF)V

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->e:F

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->g:F

    add-float/2addr v0, v2

    const/high16 v3, 0x43b40000    # 360.0f

    mul-float v6, v0, v3

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->f:F

    add-float/2addr v0, v2

    mul-float/2addr v0, v3

    sub-float v7, v0, v6

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->b:Landroid/graphics/Paint;

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->x:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v5, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->b:Landroid/graphics/Paint;

    const/4 v4, 0x0

    move-object v0, p1

    move v2, v6

    move v3, v7

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    invoke-direct {p0, p1, v6, v7, p2}, Lcom/jude/easyrecyclerview/swipe/b$d;->b(Landroid/graphics/Canvas;FFLandroid/graphics/Rect;)V

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->u:I

    const/16 v1, 0xff

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->v:Landroid/graphics/Paint;

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->w:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->v:Landroid/graphics/Paint;

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->u:I

    sub-int/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-virtual {p2}, Landroid/graphics/Rect;->exactCenterX()F

    move-result v0

    invoke-virtual {p2}, Landroid/graphics/Rect;->exactCenterY()F

    move-result v1

    invoke-virtual {p2}, Landroid/graphics/Rect;->width()I

    move-result p2

    div-int/lit8 p2, p2, 0x2

    int-to-float p2, p2

    iget-object v2, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->v:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, p2, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    :cond_0
    return-void
.end method

.method public c()I
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->u:I

    return v0
.end method

.method public d()D
    .locals 2

    iget-wide v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->r:D

    return-wide v0
.end method

.method public e()F
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->f:F

    return v0
.end method

.method public f()I
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->j:[I

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->g()I

    move-result v1

    aget v0, v0, v1

    return v0
.end method

.method public h()F
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->e:F

    return v0
.end method

.method public i()I
    .locals 2

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->j:[I

    iget v1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->k:I

    aget v0, v0, v1

    return v0
.end method

.method public j()F
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->m:F

    return v0
.end method

.method public k()F
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->n:F

    return v0
.end method

.method public l()F
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->l:F

    return v0
.end method

.method public m()F
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->h:F

    return v0
.end method

.method public n()V
    .locals 1

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->g()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->x(I)V

    return-void
.end method

.method public p()V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->l:F

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->m:F

    iput v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->n:F

    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->D(F)V

    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->z(F)V

    invoke-virtual {p0, v0}, Lcom/jude/easyrecyclerview/swipe/b$d;->B(F)V

    return-void
.end method

.method public q(I)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->u:I

    return-void
.end method

.method public r(FF)V
    .locals 0

    float-to-int p1, p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->s:I

    float-to-int p1, p2

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->t:I

    return-void
.end method

.method public s(F)V
    .locals 1

    iget v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->q:F

    cmpl-float v0, p1, v0

    if-eqz v0, :cond_0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->q:F

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    :cond_0
    return-void
.end method

.method public t(I)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->w:I

    return-void
.end method

.method public u(D)V
    .locals 0

    iput-wide p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->r:D

    return-void
.end method

.method public v(I)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->x:I

    return-void
.end method

.method public w(Landroid/graphics/ColorFilter;)V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->b:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    return-void
.end method

.method public x(I)V
    .locals 1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->k:I

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->j:[I

    aget p1, v0, p1

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->x:I

    return-void
.end method

.method public y([I)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->j:[I

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lcom/jude/easyrecyclerview/swipe/b$d;->x(I)V

    return-void
.end method

.method public z(F)V
    .locals 0

    iput p1, p0, Lcom/jude/easyrecyclerview/swipe/b$d;->f:F

    invoke-direct {p0}, Lcom/jude/easyrecyclerview/swipe/b$d;->o()V

    return-void
.end method
