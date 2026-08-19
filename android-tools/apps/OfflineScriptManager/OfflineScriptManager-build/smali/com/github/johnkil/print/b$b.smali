.class public Lcom/github/johnkil/print/b$b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/github/johnkil/print/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "b"
.end annotation


# instance fields
.field private final a:Landroid/content/Context;

.field private b:Ljava/lang/CharSequence;

.field private c:Landroid/content/res/ColorStateList;

.field private d:Landroid/graphics/Typeface;

.field private e:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/github/johnkil/print/b$b;->a:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public a()Lcom/github/johnkil/print/b;
    .locals 9

    iget-object v0, p0, Lcom/github/johnkil/print/b$b;->d:Landroid/graphics/Typeface;

    if-nez v0, :cond_1

    invoke-static {}, Lcom/github/johnkil/print/a;->a()Lcom/github/johnkil/print/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/johnkil/print/a;->c()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Lcom/github/johnkil/print/a;->b()Landroid/graphics/Typeface;

    move-result-object v0

    iput-object v0, p0, Lcom/github/johnkil/print/b$b;->d:Landroid/graphics/Typeface;

    goto :goto_0

    :cond_0
    const-string v0, "Print"

    const-string v1, "The iconic font is not set."

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    new-instance v0, Lcom/github/johnkil/print/b;

    iget-object v3, p0, Lcom/github/johnkil/print/b$b;->a:Landroid/content/Context;

    iget-object v4, p0, Lcom/github/johnkil/print/b$b;->b:Ljava/lang/CharSequence;

    iget-object v5, p0, Lcom/github/johnkil/print/b$b;->c:Landroid/content/res/ColorStateList;

    iget-object v6, p0, Lcom/github/johnkil/print/b$b;->d:Landroid/graphics/Typeface;

    iget v7, p0, Lcom/github/johnkil/print/b$b;->e:I

    const/4 v8, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v8}, Lcom/github/johnkil/print/b;-><init>(Landroid/content/Context;Ljava/lang/CharSequence;Landroid/content/res/ColorStateList;Landroid/graphics/Typeface;ILcom/github/johnkil/print/b$a;)V

    return-object v0
.end method

.method public b(Landroid/content/res/ColorStateList;)Lcom/github/johnkil/print/b$b;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/github/johnkil/print/b$b;->c:Landroid/content/res/ColorStateList;

    return-object p0

    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Color must not be null."

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public c(Landroid/graphics/Typeface;)Lcom/github/johnkil/print/b$b;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/github/johnkil/print/b$b;->d:Landroid/graphics/Typeface;

    return-object p0

    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Font must not be null."

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public d(IF)Lcom/github/johnkil/print/b$b;
    .locals 1

    iget-object v0, p0, Lcom/github/johnkil/print/b$b;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    invoke-static {p1, p2, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/github/johnkil/print/b$b;->e:I

    return-object p0
.end method

.method public e(Ljava/lang/CharSequence;)Lcom/github/johnkil/print/b$b;
    .locals 0

    iput-object p1, p0, Lcom/github/johnkil/print/b$b;->b:Ljava/lang/CharSequence;

    return-object p0
.end method
