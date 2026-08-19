.class public abstract Lorg/achartengine/f/e;
.super Lorg/achartengine/f/a;
.source ""


# instance fields
.field protected b:Lorg/achartengine/h/b;

.field protected c:I

.field protected d:I


# virtual methods
.method public e(Landroid/graphics/Canvas;Lorg/achartengine/h/c;FFILandroid/graphics/Paint;)V
    .locals 6

    const/high16 p2, 0x40a00000    # 5.0f

    sub-float v2, p4, p2

    const/high16 p5, 0x41200000    # 10.0f

    add-float v3, p3, p5

    add-float v4, p4, p2

    move-object v0, p1

    move v1, p3

    move-object v5, p6

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    return-void
.end method

.method public k(I)I
    .locals 0

    const/16 p1, 0xa

    return p1
.end method

.method public p()I
    .locals 1

    iget v0, p0, Lorg/achartengine/f/e;->c:I

    return v0
.end method

.method public q()I
    .locals 1

    iget v0, p0, Lorg/achartengine/f/e;->d:I

    return v0
.end method

.method public r()Lorg/achartengine/h/b;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/f/e;->b:Lorg/achartengine/h/b;

    return-object v0
.end method

.method public s(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/f/e;->c:I

    return-void
.end method

.method public t(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/f/e;->d:I

    return-void
.end method
