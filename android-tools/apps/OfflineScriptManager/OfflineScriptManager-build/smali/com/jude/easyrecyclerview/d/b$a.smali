.class Lcom/jude/easyrecyclerview/d/b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/jude/easyrecyclerview/d/d$c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/jude/easyrecyclerview/d/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field private a:Landroid/widget/FrameLayout;

.field private b:Landroid/view/View;

.field private c:Landroid/view/View;

.field private d:Landroid/view/View;

.field private e:I

.field final synthetic f:Lcom/jude/easyrecyclerview/d/b;


# direct methods
.method public constructor <init>(Lcom/jude/easyrecyclerview/d/b;Landroid/content/Context;)V
    .locals 2

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->f:Lcom/jude/easyrecyclerview/d/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->e:I

    new-instance p1, Landroid/widget/FrameLayout;

    invoke-direct {p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    new-instance p2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-direct {p2, v0, v1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p1, p2}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method private j(Landroid/view/View;)V
    .locals 4

    const/16 v0, 0x8

    if-eqz p1, :cond_3

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {v1}, Landroid/widget/FrameLayout;->getVisibility()I

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setVisibility(I)V

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {v1, p1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    :cond_1
    move v1, v2

    :goto_0
    iget-object v3, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {v3}, Landroid/widget/FrameLayout;->getChildCount()I

    move-result v3

    if-ge v1, v3, :cond_4

    iget-object v3, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {v3, v1}, Landroid/widget/FrameLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    if-ne v3, p1, :cond_2

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_2
    iget-object v3, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {v3, v1}, Landroid/widget/FrameLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    :cond_4
    return-void
.end method


# virtual methods
.method public a(Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 1

    const-string p1, "recycler"

    const-string v0, "onCreateView"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    return-object p1
.end method

.method public b(Landroid/view/View;)V
    .locals 1

    const-string p1, "recycler"

    const-string v0, "onBindView"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->e:I

    const/4 v0, 0x1

    if-eq p1, v0, :cond_1

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->f:Lcom/jude/easyrecyclerview/d/b;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/d/b;->g()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->f:Lcom/jude/easyrecyclerview/d/b;

    invoke-virtual {p1}, Lcom/jude/easyrecyclerview/d/b;->h()V

    :goto_0
    return-void
.end method

.method public c()V
    .locals 2

    const/4 v0, 0x0

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->e:I

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->a:Landroid/widget/FrameLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    return-void
.end method

.method public d(Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->d:Landroid/view/View;

    return-void
.end method

.method public e(Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->b:Landroid/view/View;

    return-void
.end method

.method public f(Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/jude/easyrecyclerview/d/b$a;->c:Landroid/view/View;

    return-void
.end method

.method public g()V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->d:Landroid/view/View;

    invoke-direct {p0, v0}, Lcom/jude/easyrecyclerview/d/b$a;->j(Landroid/view/View;)V

    const/4 v0, 0x2

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->e:I

    return-void
.end method

.method public h()V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->b:Landroid/view/View;

    invoke-direct {p0, v0}, Lcom/jude/easyrecyclerview/d/b$a;->j(Landroid/view/View;)V

    const/4 v0, 0x1

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->e:I

    return-void
.end method

.method public i()V
    .locals 1

    iget-object v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->c:Landroid/view/View;

    invoke-direct {p0, v0}, Lcom/jude/easyrecyclerview/d/b$a;->j(Landroid/view/View;)V

    const/4 v0, 0x3

    iput v0, p0, Lcom/jude/easyrecyclerview/d/b$a;->e:I

    return-void
.end method
