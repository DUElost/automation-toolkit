.class Lcom/jude/easyrecyclerview/swipe/a$a;
.super Landroid/graphics/drawable/shapes/OvalShape;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/jude/easyrecyclerview/swipe/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field private b:Landroid/graphics/RadialGradient;

.field private c:Landroid/graphics/Paint;

.field private d:I

.field final synthetic e:Lcom/jude/easyrecyclerview/swipe/a;


# direct methods
.method public constructor <init>(Lcom/jude/easyrecyclerview/swipe/a;II)V
    .locals 8

    iput-object p1, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->e:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-direct {p0}, Landroid/graphics/drawable/shapes/OvalShape;-><init>()V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->c:Landroid/graphics/Paint;

    invoke-static {p1, p2}, Lcom/jude/easyrecyclerview/swipe/a;->b(Lcom/jude/easyrecyclerview/swipe/a;I)I

    iput p3, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->d:I

    new-instance p2, Landroid/graphics/RadialGradient;

    iget p3, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->d:I

    div-int/lit8 v0, p3, 0x2

    int-to-float v2, v0

    const/4 v0, 0x2

    div-int/2addr p3, v0

    int-to-float v3, p3

    invoke-static {p1}, Lcom/jude/easyrecyclerview/swipe/a;->a(Lcom/jude/easyrecyclerview/swipe/a;)I

    move-result p1

    int-to-float v4, p1

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v6, 0x0

    move-object v1, p2

    invoke-direct/range {v1 .. v7}, Landroid/graphics/RadialGradient;-><init>(FFF[I[FLandroid/graphics/Shader$TileMode;)V

    iput-object p2, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->b:Landroid/graphics/RadialGradient;

    iget-object p1, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    return-void

    :array_0
    .array-data 4
        0x3d000000    # 0.03125f
        0x0
    .end array-data
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;Landroid/graphics/Paint;)V
    .locals 4

    iget-object v0, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->e:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->e:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getHeight()I

    move-result v1

    div-int/lit8 v0, v0, 0x2

    int-to-float v0, v0

    div-int/lit8 v1, v1, 0x2

    int-to-float v1, v1

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->d:I

    div-int/lit8 v2, v2, 0x2

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->e:Lcom/jude/easyrecyclerview/swipe/a;

    invoke-static {v3}, Lcom/jude/easyrecyclerview/swipe/a;->a(Lcom/jude/easyrecyclerview/swipe/a;)I

    move-result v3

    add-int/2addr v2, v3

    int-to-float v2, v2

    iget-object v3, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    iget v2, p0, Lcom/jude/easyrecyclerview/swipe/a$a;->d:I

    div-int/lit8 v2, v2, 0x2

    int-to-float v2, v2

    invoke-virtual {p1, v0, v1, v2, p2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method
