.class public Lcom/github/johnkil/print/PrintButton;
.super Landroid/widget/ImageButton;
.source ""


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0, p1, p2}, Lcom/github/johnkil/print/PrintButton;->a(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method private a(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    invoke-virtual {p0}, Landroid/widget/ImageButton;->isInEditMode()Z

    move-result v0

    invoke-static {p1, p2, v0}, Lcom/github/johnkil/print/c;->a(Landroid/content/Context;Landroid/util/AttributeSet;Z)Lcom/github/johnkil/print/b;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/widget/ImageButton;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method


# virtual methods
.method public getIcon()Lcom/github/johnkil/print/b;
    .locals 1

    invoke-virtual {p0}, Landroid/widget/ImageButton;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    check-cast v0, Lcom/github/johnkil/print/b;

    return-object v0
.end method

.method public final getIconColor()Landroid/content/res/ColorStateList;
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/johnkil/print/b;->a()Landroid/content/res/ColorStateList;

    move-result-object v0

    return-object v0
.end method

.method public getIconFont()Landroid/graphics/Typeface;
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/johnkil/print/b;->b()Landroid/graphics/Typeface;

    move-result-object v0

    return-object v0
.end method

.method public getIconSize()I
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/johnkil/print/b;->c()I

    move-result v0

    return v0
.end method

.method public getIconText()Ljava/lang/CharSequence;
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/johnkil/print/b;->d()Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method public setIconColor(I)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->f(I)V

    return-void
.end method

.method public setIconColor(Landroid/content/res/ColorStateList;)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->g(Landroid/content/res/ColorStateList;)V

    return-void
.end method

.method public setIconFont(Landroid/graphics/Typeface;)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->h(Landroid/graphics/Typeface;)V

    return-void
.end method

.method public setIconFont(Ljava/lang/String;)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->i(Ljava/lang/String;)V

    return-void
.end method

.method public setIconSize(I)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->j(I)V

    invoke-virtual {p0}, Landroid/widget/ImageButton;->isSelected()Z

    move-result p1

    invoke-virtual {p0, p1}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void
.end method

.method public setIconText(I)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->l(I)V

    return-void
.end method

.method public setIconText(Ljava/lang/CharSequence;)V
    .locals 1

    invoke-virtual {p0}, Lcom/github/johnkil/print/PrintButton;->getIcon()Lcom/github/johnkil/print/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/github/johnkil/print/b;->m(Ljava/lang/CharSequence;)V

    return-void
.end method
