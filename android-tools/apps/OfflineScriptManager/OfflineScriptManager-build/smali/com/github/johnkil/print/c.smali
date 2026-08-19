.class Lcom/github/johnkil/print/c;
.super Ljava/lang/Object;
.source ""


# direct methods
.method static a(Landroid/content/Context;Landroid/util/AttributeSet;Z)Lcom/github/johnkil/print/b;
    .locals 3

    new-instance v0, Lcom/github/johnkil/print/b$b;

    invoke-direct {v0, p0}, Lcom/github/johnkil/print/b$b;-><init>(Landroid/content/Context;)V

    if-eqz p1, :cond_3

    sget-object v1, Lcom/github/johnkil/print/d;->PrintView:[I

    invoke-virtual {p0, p1, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object p1

    sget v1, Lcom/github/johnkil/print/d;->PrintView_iconText:I

    invoke-virtual {p1, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p1, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/github/johnkil/print/b$b;->e(Ljava/lang/CharSequence;)Lcom/github/johnkil/print/b$b;

    :cond_0
    if-nez p2, :cond_1

    sget p2, Lcom/github/johnkil/print/d;->PrintView_iconFont:I

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    invoke-static {p0, p2}, Lcom/github/johnkil/print/e;->a(Landroid/content/res/AssetManager;Ljava/lang/String;)Landroid/graphics/Typeface;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/github/johnkil/print/b$b;->c(Landroid/graphics/Typeface;)Lcom/github/johnkil/print/b$b;

    :cond_1
    sget p0, Lcom/github/johnkil/print/d;->PrintView_iconColor:I

    invoke-virtual {p1, p0}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_2

    invoke-virtual {p1, p0}, Landroid/content/res/TypedArray;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/github/johnkil/print/b$b;->b(Landroid/content/res/ColorStateList;)Lcom/github/johnkil/print/b$b;

    :cond_2
    sget p0, Lcom/github/johnkil/print/d;->PrintView_iconSize:I

    const/4 p2, 0x0

    invoke-virtual {p1, p0, p2}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result p0

    int-to-float p0, p0

    invoke-virtual {v0, p2, p0}, Lcom/github/johnkil/print/b$b;->d(IF)Lcom/github/johnkil/print/b$b;

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    :cond_3
    invoke-virtual {v0}, Lcom/github/johnkil/print/b$b;->a()Lcom/github/johnkil/print/b;

    move-result-object p0

    return-object p0
.end method
