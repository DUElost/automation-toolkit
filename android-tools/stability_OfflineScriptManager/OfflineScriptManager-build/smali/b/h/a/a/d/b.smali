.class public Lb/h/a/a/d/b;
.super Landroid/widget/LinearLayout;
.source ""


# instance fields
.field private b:Landroid/widget/LinearLayout;

.field private c:Landroid/view/ViewGroup;

.field private final d:I


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput p2, p0, Lb/h/a/a/d/b;->d:I

    invoke-direct {p0}, Lb/h/a/a/d/b;->a()V

    return-void
.end method

.method private a()V
    .locals 7

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v1, Landroid/widget/RelativeLayout;

    invoke-virtual {p0}, Landroid/widget/LinearLayout;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lb/h/a/a/d/b;->c:Landroid/view/ViewGroup;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, p0, Lb/h/a/a/d/b;->c:Landroid/view/ViewGroup;

    sget v2, Lb/h/a/a/a;->node_header:I

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->setId(I)V

    new-instance v1, Landroid/view/ContextThemeWrapper;

    invoke-virtual {p0}, Landroid/widget/LinearLayout;->getContext()Landroid/content/Context;

    move-result-object v2

    iget v5, p0, Lb/h/a/a/d/b;->d:I

    invoke-direct {v1, v2, v5}, Landroid/view/ContextThemeWrapper;-><init>(Landroid/content/Context;I)V

    new-instance v2, Landroid/widget/LinearLayout;

    iget v5, p0, Lb/h/a/a/d/b;->d:I

    const/4 v6, 0x0

    invoke-direct {v2, v1, v6, v5}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object v2, p0, Lb/h/a/a/d/b;->b:Landroid/widget/LinearLayout;

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, p0, Lb/h/a/a/d/b;->b:Landroid/widget/LinearLayout;

    sget v2, Lb/h/a/a/a;->node_items:I

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setId(I)V

    iget-object v1, p0, Lb/h/a/a/d/b;->b:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    iget-object v0, p0, Lb/h/a/a/d/b;->b:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object v0, p0, Lb/h/a/a/d/b;->c:Landroid/view/ViewGroup;

    invoke-virtual {p0, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lb/h/a/a/d/b;->b:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void
.end method


# virtual methods
.method public b(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lb/h/a/a/d/b;->c:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method public getNodeContainer()Landroid/view/ViewGroup;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/d/b;->c:Landroid/view/ViewGroup;

    return-object v0
.end method
