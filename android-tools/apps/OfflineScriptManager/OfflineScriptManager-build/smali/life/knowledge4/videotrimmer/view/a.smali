.class public Llife/knowledge4/videotrimmer/view/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:I

.field private b:F

.field private c:F

.field private d:Landroid/graphics/Bitmap;

.field private e:I

.field private f:I

.field private g:F


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Llife/knowledge4/videotrimmer/view/a;->b:F

    iput v0, p0, Llife/knowledge4/videotrimmer/view/a;->c:F

    return-void
.end method

.method private b()I
    .locals 1

    iget v0, p0, Llife/knowledge4/videotrimmer/view/a;->f:I

    return v0
.end method

.method public static c(Ljava/util/List;)I
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/view/a;",
            ">;)I"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Llife/knowledge4/videotrimmer/view/a;

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/view/a;->b()I

    move-result p0

    return p0
.end method

.method public static i(Ljava/util/List;)I
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/view/a;",
            ">;)I"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {p0}, Llife/knowledge4/videotrimmer/view/a;->h()I

    move-result p0

    return p0
.end method

.method public static j(Landroid/content/res/Resources;)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/res/Resources;",
            ")",
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/view/a;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x2

    if-ge v1, v2, :cond_1

    new-instance v2, Llife/knowledge4/videotrimmer/view/a;

    invoke-direct {v2}, Llife/knowledge4/videotrimmer/view/a;-><init>()V

    invoke-direct {v2, v1}, Llife/knowledge4/videotrimmer/view/a;->l(I)V

    if-nez v1, :cond_0

    sget v3, Llife/knowledge4/videotrimmer/c;->apptheme_text_select_handle_left:I

    goto :goto_1

    :cond_0
    sget v3, Llife/knowledge4/videotrimmer/c;->apptheme_text_select_handle_right:I

    :goto_1
    invoke-static {p0, v3}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-direct {v2, v3}, Llife/knowledge4/videotrimmer/view/a;->k(Landroid/graphics/Bitmap;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private k(Landroid/graphics/Bitmap;)V
    .locals 1

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/a;->d:Landroid/graphics/Bitmap;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iput v0, p0, Llife/knowledge4/videotrimmer/view/a;->e:I

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p1

    iput p1, p0, Llife/knowledge4/videotrimmer/view/a;->f:I

    return-void
.end method

.method private l(I)V
    .locals 0

    iput p1, p0, Llife/knowledge4/videotrimmer/view/a;->a:I

    return-void
.end method


# virtual methods
.method public a()Landroid/graphics/Bitmap;
    .locals 1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/a;->d:Landroid/graphics/Bitmap;

    return-object v0
.end method

.method public d()I
    .locals 1

    iget v0, p0, Llife/knowledge4/videotrimmer/view/a;->a:I

    return v0
.end method

.method public e()F
    .locals 1

    iget v0, p0, Llife/knowledge4/videotrimmer/view/a;->g:F

    return v0
.end method

.method public f()F
    .locals 1

    iget v0, p0, Llife/knowledge4/videotrimmer/view/a;->c:F

    return v0
.end method

.method public g()F
    .locals 1

    iget v0, p0, Llife/knowledge4/videotrimmer/view/a;->b:F

    return v0
.end method

.method public h()I
    .locals 1

    iget v0, p0, Llife/knowledge4/videotrimmer/view/a;->e:I

    return v0
.end method

.method public m(F)V
    .locals 0

    iput p1, p0, Llife/knowledge4/videotrimmer/view/a;->g:F

    return-void
.end method

.method public n(F)V
    .locals 0

    iput p1, p0, Llife/knowledge4/videotrimmer/view/a;->c:F

    return-void
.end method

.method public o(F)V
    .locals 0

    iput p1, p0, Llife/knowledge4/videotrimmer/view/a;->b:F

    return-void
.end method
