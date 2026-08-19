.class public Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;
.super Landroid/widget/FrameLayout;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;,
        Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;,
        Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;
    }
.end annotation


# static fields
.field private static V:Ljava/lang/String; = "AHBottomNavigation"


# instance fields
.field private A:I

.field private B:I

.field private C:I

.field private D:I

.field private E:I

.field private F:F

.field private G:F

.field private H:I

.field private I:I

.field private J:F

.field private K:F

.field private L:Z

.field private M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

.field private N:I

.field private O:I

.field private P:Landroid/graphics/drawable/Drawable;

.field private Q:Landroid/graphics/Typeface;

.field private R:I

.field private S:I

.field private T:I

.field private U:I

.field private b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;

.field private c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;

.field private d:Landroid/content/Context;

.field private e:Landroid/content/res/Resources;

.field private f:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/aurelhubert/ahbottomnavigation/a;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior<",
            "Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;",
            ">;"
        }
    .end annotation
.end field

.field private i:Landroid/widget/LinearLayout;

.field private j:Landroid/view/View;

.field private k:Landroid/animation/Animator;

.field private l:Z

.field private m:Z

.field private n:Z

.field private o:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;",
            ">;"
        }
    .end annotation
.end field

.field private p:Z

.field private q:I

.field private r:I

.field private s:Z

.field private t:Z

.field private u:Z

.field private v:Z

.field private w:Landroid/graphics/Typeface;

.field private x:I

.field private y:I

.field private z:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    iput-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    const/4 v1, 0x5

    invoke-static {v1}, Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;->a(I)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o:Ljava/util/List;

    iput-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->p:Z

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->s:Z

    iput-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->t:Z

    iput-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->u:Z

    iput-boolean v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->v:Z

    const/4 v1, -0x1

    iput v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->I:I

    iput-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    sget-object v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    iput-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    invoke-direct {p0, p1, p2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method static synthetic a(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;IZ)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->n(IZ)V

    return-void
.end method

.method static synthetic b(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;IZ)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->p(IZ)V

    return-void
.end method

.method static synthetic c(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic d(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic e(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    return-object p0
.end method

.method private g(I)I
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .annotation build Landroid/annotation/TargetApi;
        value = 0x15
    .end annotation

    iget-boolean v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->n:Z

    if-nez v0, :cond_0

    return p1

    :cond_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "navigation_bar_height"

    const-string v2, "dimen"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_1

    iget-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->I:I

    :cond_1
    const/4 v0, 0x2

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources$Theme;->obtainStyledAttributes([I)Landroid/content/res/TypedArray;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    const/4 v1, 0x1

    invoke-virtual {v0, v1, v1}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    invoke-virtual {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k()Z

    move-result v2

    if-eqz v2, :cond_2

    if-eqz v1, :cond_2

    iget v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->I:I

    add-int/2addr p1, v1

    :cond_2
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    return p1

    nop

    :array_0
    .array-data 4
        0x10100dd
        0x10103f0
    .end array-data
.end method

.method private h(Landroid/widget/LinearLayout;)V
    .locals 18

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    const-string v2, "layout_inflater"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/LayoutInflater;

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v3, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_height:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v4, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_min_width:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v3

    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_max_width:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v4

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v6, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    const/4 v7, 0x3

    if-ne v5, v6, :cond_0

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-le v5, v7, :cond_0

    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v4, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_inactive_min_width:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v3

    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_inactive_max_width:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v4

    :cond_0
    invoke-virtual/range {p0 .. p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v5

    if-eqz v5, :cond_13

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    if-nez v8, :cond_1

    goto/16 :goto_b

    :cond_1
    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    div-int/2addr v5, v8

    int-to-float v5, v5

    cmpg-float v8, v5, v3

    if-gez v8, :cond_2

    goto :goto_0

    :cond_2
    cmpl-float v3, v5, v4

    if-lez v3, :cond_3

    move v3, v4

    goto :goto_0

    :cond_3
    move v3, v5

    :goto_0
    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_active:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v4

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v8, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_inactive:I

    invoke-virtual {v5, v8}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v9, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_margin_top_active:I

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v8

    float-to-int v8, v8

    iget v9, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->F:F

    const/4 v10, 0x0

    cmpl-float v11, v9, v10

    if-eqz v11, :cond_4

    iget v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->G:F

    cmpl-float v10, v11, v10

    if-eqz v10, :cond_4

    move v4, v9

    move v5, v11

    goto :goto_1

    :cond_4
    iget-object v9, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-ne v9, v6, :cond_5

    iget-object v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-le v6, v7, :cond_5

    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_forced_active:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v4

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v6, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_forced_inactive:I

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    :cond_5
    :goto_1
    const/4 v6, 0x0

    move v9, v6

    :goto_2
    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-ge v9, v10, :cond_12

    iget v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v10, v9, :cond_6

    const/4 v10, 0x1

    goto :goto_3

    :cond_6
    move v10, v6

    :goto_3
    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v12, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/aurelhubert/ahbottomnavigation/a;

    sget v13, Lcom/aurelhubert/ahbottomnavigation/g;->bottom_navigation_item:I

    invoke-virtual {v1, v13, v0, v6}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v13

    sget v14, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_container:I

    invoke-virtual {v13, v14}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v14

    check-cast v14, Landroid/widget/FrameLayout;

    sget v15, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_item_icon:I

    invoke-virtual {v13, v15}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v15

    check-cast v15, Landroid/widget/ImageView;

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_item_title:I

    invoke-virtual {v13, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/TextView;

    sget v6, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v13, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/TextView;

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v12, v7}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v15, v7}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v12, v7}, Lcom/aurelhubert/ahbottomnavigation/a;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v11, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->w:Landroid/graphics/Typeface;

    if-eqz v7, :cond_7

    invoke-virtual {v11, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    :cond_7
    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    move-object/from16 v16, v1

    sget-object v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-ne v7, v1, :cond_8

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v7, 0x3

    if-le v1, v7, :cond_8

    invoke-virtual {v14}, Landroid/widget/FrameLayout;->getPaddingTop()I

    move-result v1

    invoke-virtual {v14}, Landroid/widget/FrameLayout;->getPaddingBottom()I

    move-result v7

    move/from16 v17, v4

    const/4 v4, 0x0

    invoke-virtual {v14, v4, v1, v4, v7}, Landroid/widget/FrameLayout;->setPadding(IIII)V

    goto :goto_4

    :cond_8
    move/from16 v17, v4

    :goto_4
    if-eqz v10, :cond_a

    iget-boolean v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    if-eqz v1, :cond_9

    const/4 v1, 0x1

    invoke-virtual {v13, v1}, Landroid/view/View;->setSelected(Z)V

    goto :goto_5

    :cond_9
    const/4 v1, 0x1

    :goto_5
    invoke-virtual {v15, v1}, Landroid/widget/ImageView;->setSelected(Z)V

    invoke-virtual {v13}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    instance-of v1, v1, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v1, :cond_b

    invoke-virtual {v15}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v4, v1, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    iget v7, v1, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v14, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    invoke-virtual {v1, v4, v8, v7, v14}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v6}, Landroid/widget/TextView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    iget v6, v1, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iget v7, v1, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v14, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    invoke-virtual {v1, v4, v6, v7, v14}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v13}, Landroid/view/View;->requestLayout()V

    goto :goto_6

    :cond_a
    const/4 v1, 0x0

    invoke-virtual {v15, v1}, Landroid/widget/ImageView;->setSelected(Z)V

    invoke-virtual {v6}, Landroid/widget/TextView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    iget v6, v1, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iget v7, v1, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v14, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    invoke-virtual {v1, v4, v6, v7, v14}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    :cond_b
    :goto_6
    iget-boolean v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz v1, :cond_c

    if-eqz v10, :cond_e

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v12, v1}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v12, v1}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v1

    iput v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    goto :goto_7

    :cond_c
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    if-eqz v1, :cond_d

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundResource(I)V

    goto :goto_7

    :cond_d
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    :cond_e
    :goto_7
    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v1, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v1, v4}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v10, :cond_f

    iget v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    goto :goto_8

    :cond_f
    iget v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    :goto_8
    iget-boolean v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    invoke-static {v1, v4, v6}, Lcom/aurelhubert/ahbottomnavigation/b;->a(Landroid/graphics/drawable/Drawable;IZ)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v15, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    if-eqz v10, :cond_10

    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    goto :goto_9

    :cond_10
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    :goto_9
    invoke-virtual {v11, v1}, Landroid/widget/TextView;->setTextColor(I)V

    if-eqz v10, :cond_11

    move/from16 v1, v17

    goto :goto_a

    :cond_11
    move v1, v5

    :goto_a
    const/4 v4, 0x0

    invoke-virtual {v11, v4, v1}, Landroid/widget/TextView;->setTextSize(IF)V

    new-instance v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$b;

    invoke-direct {v1, v0, v9}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$b;-><init>(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;I)V

    invoke-virtual {v13, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-boolean v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->v:Z

    invoke-virtual {v13, v1}, Landroid/view/View;->setSoundEffectsEnabled(Z)V

    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    float-to-int v6, v3

    float-to-int v7, v2

    invoke-direct {v1, v6, v7}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    move-object/from16 v6, p1

    invoke-virtual {v6, v13, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v1, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v9, v9, 0x1

    move v6, v4

    move-object/from16 v1, v16

    move/from16 v4, v17

    const/4 v7, 0x3

    goto/16 :goto_2

    :cond_12
    const/4 v1, -0x1

    const/4 v2, 0x1

    invoke-direct {v0, v2, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    :cond_13
    :goto_b
    return-void
.end method

.method private i()V
    .locals 5

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x3

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->V:Ljava/lang/String;

    const-string v2, "The items list should have at least 3 items"

    :goto_0
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v2, 0x5

    if-le v0, v2, :cond_1

    sget-object v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->V:Ljava/lang/String;

    const-string v2, "The items list should not have more than 5 items"

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v2, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_height:I

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v0

    float-to-int v0, v0

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    new-instance v2, Landroid/view/View;

    iget-object v3, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x15

    const/4 v4, -0x1

    if-lt v2, v3, :cond_2

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {p0, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g(I)I

    move-result v3

    invoke-direct {v2, v4, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    iget-object v3, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {p0, v3, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->H:I

    :cond_2
    new-instance v2, Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i:Landroid/widget/LinearLayout;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    iget-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i:Landroid/widget/LinearLayout;

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v2, v4, v0}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v2, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-eq v0, v2, :cond_4

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-eq v0, v1, :cond_3

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-ne v0, v1, :cond_4

    :cond_3
    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h(Landroid/widget/LinearLayout;)V

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j(Landroid/widget/LinearLayout;)V

    :goto_2
    new-instance v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$a;

    invoke-direct {v0, p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$a;-><init>(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;)V

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private j(Landroid/widget/LinearLayout;)V
    .locals 17

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    const-string v2, "layout_inflater"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/LayoutInflater;

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v3, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_height:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v4, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_inactive_min_width:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v3

    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_inactive_max_width:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v4

    invoke-virtual/range {p0 .. p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v5

    if-eqz v5, :cond_12

    iget-object v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-nez v6, :cond_0

    goto/16 :goto_8

    :cond_0
    iget-object v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    div-int/2addr v5, v6

    int-to-float v5, v5

    cmpg-float v6, v5, v3

    if-gez v6, :cond_1

    goto :goto_0

    :cond_1
    cmpl-float v3, v5, v4

    if-lez v3, :cond_2

    move v3, v4

    goto :goto_0

    :cond_2
    move v3, v5

    :goto_0
    iget-object v4, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_margin_top_active:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v4

    float-to-int v4, v4

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v6, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_selected_width_difference:I

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    iget-object v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    int-to-float v6, v6

    mul-float/2addr v6, v5

    add-float/2addr v6, v3

    iput v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->J:F

    sub-float/2addr v3, v5

    iput v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->K:F

    const/4 v5, 0x0

    move v6, v5

    :goto_1
    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    const/4 v8, 0x1

    if-ge v6, v7, :cond_11

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/aurelhubert/ahbottomnavigation/a;

    sget v9, Lcom/aurelhubert/ahbottomnavigation/g;->bottom_navigation_small_item:I

    invoke-virtual {v1, v9, v0, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v9

    sget v10, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_item_icon:I

    invoke-virtual {v9, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/ImageView;

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_item_title:I

    invoke-virtual {v9, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/TextView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v9, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    check-cast v12, Landroid/widget/TextView;

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v7, v13}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v13

    invoke-virtual {v10, v13}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v14, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-eq v13, v14, :cond_3

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v7, v13}, Lcom/aurelhubert/ahbottomnavigation/a;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v11, v13}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_3
    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->F:F

    const/4 v15, 0x0

    cmpl-float v16, v13, v15

    if-eqz v16, :cond_4

    invoke-virtual {v11, v5, v13}, Landroid/widget/TextView;->setTextSize(IF)V

    :cond_4
    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->w:Landroid/graphics/Typeface;

    if-eqz v13, :cond_5

    invoke-virtual {v11, v13}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    :cond_5
    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v6, v13, :cond_7

    iget-boolean v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    if-eqz v13, :cond_6

    invoke-virtual {v9, v8}, Landroid/view/View;->setSelected(Z)V

    :cond_6
    invoke-virtual {v10, v8}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-eq v8, v14, :cond_8

    invoke-virtual {v9}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v8

    instance-of v8, v8, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v8, :cond_8

    invoke-virtual {v10}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v8

    check-cast v8, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v13, v8, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    iget v15, v8, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v5, v8, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    invoke-virtual {v8, v13, v4, v15, v5}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v12}, Landroid/widget/TextView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->T:I

    iget v13, v5, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v15, v5, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    invoke-virtual {v5, v8, v12, v13, v15}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v9}, Landroid/view/View;->requestLayout()V

    goto :goto_2

    :cond_7
    invoke-virtual {v10, v5}, Landroid/widget/ImageView;->setSelected(Z)V

    invoke-virtual {v12}, Landroid/widget/TextView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v8

    check-cast v8, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->U:I

    iget v15, v8, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v5, v8, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    invoke-virtual {v8, v12, v13, v15, v5}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    :cond_8
    :goto_2
    iget-boolean v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz v5, :cond_9

    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v6, v5, :cond_b

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v7, v5}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v5

    invoke-virtual {v0, v5}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v7, v5}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v5

    iput v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    goto :goto_3

    :cond_9
    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    if-eqz v5, :cond_a

    invoke-virtual {v0, v5}, Landroid/widget/FrameLayout;->setBackgroundResource(I)V

    goto :goto_3

    :cond_a
    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-virtual {v0, v5}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    :cond_b
    :goto_3
    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v5, v7}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v7, v6, :cond_c

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    goto :goto_4

    :cond_c
    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    :goto_4
    iget-boolean v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    invoke-static {v5, v7, v8}, Lcom/aurelhubert/ahbottomnavigation/b;->a(Landroid/graphics/drawable/Drawable;IZ)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v10, v5}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v5, v6, :cond_d

    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    goto :goto_5

    :cond_d
    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    :goto_5
    invoke-virtual {v11, v5}, Landroid/widget/TextView;->setTextColor(I)V

    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v5, v6, :cond_e

    const/high16 v15, 0x3f800000    # 1.0f

    goto :goto_6

    :cond_e
    const/4 v15, 0x0

    :goto_6
    invoke-virtual {v11, v15}, Landroid/widget/TextView;->setAlpha(F)V

    new-instance v5, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$c;

    invoke-direct {v5, v0, v6}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$c;-><init>(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;I)V

    invoke-virtual {v9, v5}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-boolean v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->v:Z

    invoke-virtual {v9, v5}, Landroid/view/View;->setSoundEffectsEnabled(Z)V

    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v6, v5, :cond_f

    iget v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->J:F

    float-to-int v5, v5

    goto :goto_7

    :cond_f
    float-to-int v5, v3

    :goto_7
    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-ne v7, v14, :cond_10

    float-to-double v7, v3

    const-wide v10, 0x3ff28f5c28f5c28fL    # 1.16

    mul-double/2addr v7, v10

    double-to-int v5, v7

    :cond_10
    new-instance v7, Landroid/widget/FrameLayout$LayoutParams;

    float-to-int v8, v2

    invoke-direct {v7, v5, v8}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    move-object/from16 v5, p1

    invoke-virtual {v5, v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v7, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v6, v6, 0x1

    const/4 v5, 0x0

    goto/16 :goto_1

    :cond_11
    const/4 v1, -0x1

    invoke-direct {v0, v8, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    :cond_12
    :goto_8
    return-void
.end method

.method private l(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    sget-object v1, Lcom/aurelhubert/ahbottomnavigation/h;->AHBottomNavigationBehavior_Params:[I

    invoke-virtual {p1, p2, v1, v0, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object p2

    :try_start_0
    sget v1, Lcom/aurelhubert/ahbottomnavigation/h;->AHBottomNavigationBehavior_Params_selectedBackgroundVisible:I

    invoke-virtual {p2, v1, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    iput-boolean v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    sget v1, Lcom/aurelhubert/ahbottomnavigation/h;->AHBottomNavigationBehavior_Params_translucentNavigationEnabled:I

    invoke-virtual {p2, v1, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    iput-boolean v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->n:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    throw p1

    :cond_0
    :goto_0
    const p2, 0x106000b

    invoke-static {p1, p2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p2

    iput p2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->N:I

    iget-object p2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v1, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_height:I

    invoke-virtual {p2, v1}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p2

    float-to-int p2, p2

    iput p2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->H:I

    sget p2, Lcom/aurelhubert/ahbottomnavigation/c;->colorBottomNavigationAccent:I

    invoke-static {p1, p2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p2

    iput p2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->B:I

    sget p2, Lcom/aurelhubert/ahbottomnavigation/c;->colorBottomNavigationInactive:I

    invoke-static {p1, p2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p2

    iput p2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->C:I

    sget p2, Lcom/aurelhubert/ahbottomnavigation/c;->colorBottomNavigationActiveColored:I

    invoke-static {p1, p2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p2

    iput p2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->D:I

    sget p2, Lcom/aurelhubert/ahbottomnavigation/c;->colorBottomNavigationInactiveColored:I

    invoke-static {p1, p2}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->E:I

    iget p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->B:I

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->C:I

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget p2, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_notification_margin_left_active:I

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget p2, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_notification_margin_left:I

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget p2, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_notification_margin_top_active:I

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->T:I

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget p2, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_notification_margin_top:I

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->U:I

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget p2, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_elevation:I

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    invoke-static {p0, p1}, La/f/l/r;->V(Landroid/view/View;F)V

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->setClipToPadding(Z)V

    new-instance p1, Landroid/view/ViewGroup$LayoutParams;

    const/4 p2, -0x1

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->H:I

    invoke-direct {p1, p2, v0}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p0, p1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method private n(IZ)V
    .locals 19

    move-object/from16 v0, p0

    move/from16 v1, p1

    iget v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    const/4 v3, 0x1

    if-ne v2, v1, :cond_1

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;

    if-eqz v2, :cond_0

    if-eqz p2, :cond_0

    invoke-interface {v2, v1, v3}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;->a(IZ)Z

    :cond_0
    return-void

    :cond_1
    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;

    const/4 v4, 0x0

    if-eqz v2, :cond_2

    if-eqz p2, :cond_2

    invoke-interface {v2, v1, v4}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;->a(IZ)Z

    move-result v2

    if-nez v2, :cond_2

    return-void

    :cond_2
    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_margin_top_active:I

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    float-to-int v2, v2

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v6, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_margin_top_inactive:I

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    float-to-int v5, v5

    iget-object v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v7, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_active:I

    invoke-virtual {v6, v7}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v6

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v8, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_inactive:I

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v7

    iget v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->F:F

    const/4 v9, 0x0

    cmpl-float v10, v8, v9

    if-eqz v10, :cond_3

    iget v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->G:F

    cmpl-float v11, v10, v9

    if-eqz v11, :cond_3

    move v6, v8

    move v7, v10

    goto :goto_0

    :cond_3
    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v10, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-ne v8, v10, :cond_4

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    const/4 v10, 0x3

    if-le v8, v10, :cond_4

    iget-object v6, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v7, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_forced_active:I

    invoke-virtual {v6, v7}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v6

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v8, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_text_size_forced_inactive:I

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v7

    :cond_4
    :goto_0
    move v8, v4

    :goto_1
    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-ge v8, v10, :cond_d

    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v10, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/view/View;

    iget-boolean v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    if-eqz v11, :cond_6

    if-ne v8, v1, :cond_5

    move v11, v3

    goto :goto_2

    :cond_5
    move v11, v4

    :goto_2
    invoke-virtual {v10, v11}, Landroid/view/View;->setSelected(Z)V

    :cond_6
    if-ne v8, v1, :cond_b

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_item_title:I

    invoke-virtual {v10, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/TextView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_item_icon:I

    invoke-virtual {v10, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    move-object v15, v12

    check-cast v15, Landroid/widget/ImageView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v10, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    check-cast v12, Landroid/widget/TextView;

    invoke-virtual {v15, v3}, Landroid/widget/ImageView;->setSelected(Z)V

    invoke-static {v15, v5, v2}, Lcom/aurelhubert/ahbottomnavigation/b;->g(Landroid/view/View;II)V

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    iget v14, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    invoke-static {v12, v13, v14}, Lcom/aurelhubert/ahbottomnavigation/b;->d(Landroid/view/View;II)V

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    invoke-static {v11, v12, v13}, Lcom/aurelhubert/ahbottomnavigation/b;->e(Landroid/widget/TextView;II)V

    invoke-static {v11, v7, v6}, Lcom/aurelhubert/ahbottomnavigation/b;->f(Landroid/widget/TextView;FF)V

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v11, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v11, v12}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v14

    iget v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget-boolean v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    move/from16 v16, v11

    move/from16 v17, v12

    move/from16 v18, v3

    invoke-static/range {v13 .. v18}, Lcom/aurelhubert/ahbottomnavigation/b;->c(Landroid/content/Context;Landroid/graphics/drawable/Drawable;Landroid/widget/ImageView;IIZ)V

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v11, 0x15

    if-lt v3, v11, :cond_8

    iget-boolean v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz v3, :cond_8

    invoke-virtual/range {p0 .. p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v3

    invoke-virtual/range {p0 .. p0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v11

    invoke-static {v3, v11}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v10}, Landroid/view/View;->getX()F

    move-result v11

    float-to-int v11, v11

    invoke-virtual {v10}, Landroid/view/View;->getWidth()I

    move-result v12

    div-int/lit8 v12, v12, 0x2

    add-int/2addr v11, v12

    invoke-virtual {v10}, Landroid/view/View;->getHeight()I

    move-result v10

    div-int/lit8 v10, v10, 0x2

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    if-eqz v12, :cond_7

    invoke-virtual {v12}, Landroid/animation/Animator;->isRunning()Z

    move-result v12

    if-eqz v12, :cond_7

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    invoke-virtual {v12}, Landroid/animation/Animator;->cancel()V

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v12, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v12, v13}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v12

    invoke-virtual {v0, v12}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {v12, v4}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_7
    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    int-to-float v3, v3

    invoke-static {v12, v11, v10, v9, v3}, Landroid/view/ViewAnimationUtils;->createCircularReveal(Landroid/view/View;IIFF)Landroid/animation/Animator;

    move-result-object v3

    iput-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    const-wide/16 v10, 0x5

    invoke-virtual {v3, v10, v11}, Landroid/animation/Animator;->setStartDelay(J)V

    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    new-instance v10, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$d;

    invoke-direct {v10, v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$d;-><init>(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;I)V

    invoke-virtual {v3, v10}, Landroid/animation/Animator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    invoke-virtual {v3}, Landroid/animation/Animator;->start()V

    goto/16 :goto_4

    :cond_8
    iget-boolean v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz v3, :cond_9

    iget v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v10, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v10, v11}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v10

    invoke-static {v0, v3, v10}, Lcom/aurelhubert/ahbottomnavigation/b;->h(Landroid/view/View;II)V

    goto :goto_4

    :cond_9
    iget v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    if-eqz v3, :cond_a

    invoke-virtual {v0, v3}, Landroid/widget/FrameLayout;->setBackgroundResource(I)V

    goto :goto_3

    :cond_a
    iget v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-virtual {v0, v3}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    :goto_3
    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {v3, v4}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_4

    :cond_b
    iget v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v8, v3, :cond_c

    sget v3, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_item_title:I

    invoke-virtual {v10, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_item_icon:I

    invoke-virtual {v10, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    move-object v14, v11

    check-cast v14, Landroid/widget/ImageView;

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v10, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/TextView;

    invoke-virtual {v14, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    invoke-static {v14, v2, v5}, Lcom/aurelhubert/ahbottomnavigation/b;->g(Landroid/view/View;II)V

    iget v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    invoke-static {v10, v11, v12}, Lcom/aurelhubert/ahbottomnavigation/b;->d(Landroid/view/View;II)V

    iget v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    invoke-static {v3, v10, v11}, Lcom/aurelhubert/ahbottomnavigation/b;->e(Landroid/widget/TextView;II)V

    invoke-static {v3, v6, v7}, Lcom/aurelhubert/ahbottomnavigation/b;->f(Landroid/widget/TextView;FF)V

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    iget-object v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    iget v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    invoke-virtual {v3, v10}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v3, v10}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v13

    iget v15, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget v3, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget-boolean v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    move/from16 v16, v3

    move/from16 v17, v10

    invoke-static/range {v12 .. v17}, Lcom/aurelhubert/ahbottomnavigation/b;->c(Landroid/content/Context;Landroid/graphics/drawable/Drawable;Landroid/widget/ImageView;IIZ)V

    :cond_c
    :goto_4
    add-int/lit8 v8, v8, 0x1

    const/4 v3, 0x1

    goto/16 :goto_1

    :cond_d
    iput v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-lez v1, :cond_e

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_e

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    iget v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v1

    iput v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    goto :goto_6

    :cond_e
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    const/4 v2, -0x1

    if-ne v1, v2, :cond_10

    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    if-eqz v1, :cond_f

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundResource(I)V

    goto :goto_5

    :cond_f
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    :goto_5
    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {v1, v4}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_10
    :goto_6
    return-void
.end method

.method private o(ZI)V
    .locals 8

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_8

    const/4 v1, -0x1

    if-eq p2, v1, :cond_0

    if-eq p2, v0, :cond_0

    goto/16 :goto_6

    :cond_0
    iget-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;

    iget v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->N:I

    invoke-static {v1, v2}, Lcom/aurelhubert/ahbottomnavigation/notification/a;->b(Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;I)I

    move-result v2

    iget v3, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->O:I

    invoke-static {v1, v3}, Lcom/aurelhubert/ahbottomnavigation/notification/a;->a(Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;I)I

    move-result v3

    iget-object v4, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/View;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v4, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1}, Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;->c()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    const/4 v6, 0x1

    xor-int/2addr v5, v6

    if-eqz p1, :cond_5

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->Q:Landroid/graphics/Typeface;

    if-eqz v2, :cond_1

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    invoke-virtual {v4, v2, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    :goto_1
    iget-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->P:Landroid/graphics/drawable/Drawable;

    const/16 v6, 0x10

    if-eqz v2, :cond_3

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v6, :cond_2

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    :goto_2
    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_4

    :cond_2
    :goto_3
    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_4

    :cond_3
    if-eqz v3, :cond_5

    iget-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    sget v7, Lcom/aurelhubert/ahbottomnavigation/e;->notification_background:I

    invoke-static {v2, v7}, Landroidx/core/content/a;->d(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v7, v6, :cond_4

    iget-boolean v6, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    invoke-static {v2, v3, v6}, Lcom/aurelhubert/ahbottomnavigation/b;->a(Landroid/graphics/drawable/Drawable;IZ)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    goto :goto_2

    :cond_4
    iget-boolean v6, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    invoke-static {v2, v3, v6}, Lcom/aurelhubert/ahbottomnavigation/b;->a(Landroid/graphics/drawable/Drawable;IZ)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    goto :goto_3

    :cond_5
    :goto_4
    invoke-virtual {v1}, Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;->e()Z

    move-result v2

    const-wide/16 v6, 0x96

    const/4 v3, 0x0

    if-eqz v2, :cond_6

    invoke-virtual {v4}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_6

    const-string v1, ""

    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    if-eqz v5, :cond_7

    invoke-virtual {v4}, Landroid/widget/TextView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v3}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v3}, Landroid/view/ViewPropertyAnimator;->scaleY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v3}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    new-instance v2, Landroid/view/animation/AccelerateInterpolator;

    invoke-direct {v2}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    goto :goto_5

    :cond_6
    invoke-virtual {v1}, Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;->e()Z

    move-result v2

    if-nez v2, :cond_7

    invoke-virtual {v1}, Lcom/aurelhubert/ahbottomnavigation/notification/AHNotification;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    if-eqz v5, :cond_7

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setScaleX(F)V

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setScaleY(F)V

    invoke-virtual {v4}, Landroid/widget/TextView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->scaleY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    new-instance v2, Landroid/view/animation/OvershootInterpolator;

    invoke-direct {v2}, Landroid/view/animation/OvershootInterpolator;-><init>()V

    :goto_5
    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v6, v7}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/ViewPropertyAnimator;->start()V

    :cond_7
    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    :cond_8
    return-void
.end method

.method private p(IZ)V
    .locals 19

    move-object/from16 v0, p0

    move/from16 v1, p1

    iget v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    const/4 v3, 0x1

    if-ne v2, v1, :cond_1

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;

    if-eqz v2, :cond_0

    if-eqz p2, :cond_0

    invoke-interface {v2, v1, v3}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;->a(IZ)Z

    :cond_0
    return-void

    :cond_1
    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;

    const/4 v4, 0x0

    if-eqz v2, :cond_2

    if-eqz p2, :cond_2

    invoke-interface {v2, v1, v4}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;->a(IZ)Z

    move-result v2

    if-nez v2, :cond_2

    return-void

    :cond_2
    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v5, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_margin_top_active:I

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    float-to-int v2, v2

    iget-object v5, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v6, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_small_margin_top:I

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    float-to-int v5, v5

    move v6, v4

    :goto_0
    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-ge v6, v7, :cond_d

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/view/View;

    iget-boolean v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    if-eqz v8, :cond_4

    if-ne v6, v1, :cond_3

    move v8, v3

    goto :goto_1

    :cond_3
    move v8, v4

    :goto_1
    invoke-virtual {v7, v8}, Landroid/view/View;->setSelected(Z)V

    :cond_4
    const/high16 v8, 0x3f800000    # 1.0f

    const/4 v9, 0x0

    if-ne v6, v1, :cond_a

    sget v10, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_container:I

    invoke-virtual {v7, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/FrameLayout;

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_item_title:I

    invoke-virtual {v7, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/TextView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_item_icon:I

    invoke-virtual {v7, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    move-object v15, v12

    check-cast v15, Landroid/widget/ImageView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v7, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/TextView;

    invoke-virtual {v15, v3}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v13, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-eq v12, v13, :cond_5

    invoke-static {v15, v5, v2}, Lcom/aurelhubert/ahbottomnavigation/b;->g(Landroid/view/View;II)V

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    invoke-static {v7, v12, v13}, Lcom/aurelhubert/ahbottomnavigation/b;->d(Landroid/view/View;II)V

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->U:I

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->T:I

    invoke-static {v7, v12, v13}, Lcom/aurelhubert/ahbottomnavigation/b;->g(Landroid/view/View;II)V

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    invoke-static {v11, v7, v12}, Lcom/aurelhubert/ahbottomnavigation/b;->e(Landroid/widget/TextView;II)V

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->K:F

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->J:F

    invoke-static {v10, v7, v12}, Lcom/aurelhubert/ahbottomnavigation/b;->i(Landroid/view/View;FF)V

    :cond_5
    invoke-static {v11, v9, v8}, Lcom/aurelhubert/ahbottomnavigation/b;->b(Landroid/view/View;FF)V

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v7, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v7, v8}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v14

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget-boolean v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    move/from16 v16, v7

    move/from16 v17, v8

    move/from16 v18, v10

    invoke-static/range {v13 .. v18}, Lcom/aurelhubert/ahbottomnavigation/b;->c(Landroid/content/Context;Landroid/graphics/drawable/Drawable;Landroid/widget/ImageView;IIZ)V

    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v8, 0x15

    if-lt v7, v8, :cond_7

    iget-boolean v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz v7, :cond_7

    invoke-virtual/range {p0 .. p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v7

    invoke-virtual/range {p0 .. p0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v8

    invoke-static {v7, v8}, Ljava/lang/Math;->max(II)I

    move-result v7

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/view/View;

    invoke-virtual {v8}, Landroid/view/View;->getX()F

    move-result v8

    float-to-int v8, v8

    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v10, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/view/View;

    invoke-virtual {v10}, Landroid/view/View;->getWidth()I

    move-result v10

    div-int/lit8 v10, v10, 0x2

    add-int/2addr v8, v10

    iget-object v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->g:Ljava/util/ArrayList;

    invoke-virtual {v10, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/view/View;

    invoke-virtual {v10}, Landroid/view/View;->getHeight()I

    move-result v10

    div-int/lit8 v10, v10, 0x2

    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    if-eqz v11, :cond_6

    invoke-virtual {v11}, Landroid/animation/Animator;->isRunning()Z

    move-result v11

    if-eqz v11, :cond_6

    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    invoke-virtual {v11}, Landroid/animation/Animator;->cancel()V

    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v11, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v11, v12}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v11

    invoke-virtual {v0, v11}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {v11, v4}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_6
    iget-object v11, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    int-to-float v7, v7

    invoke-static {v11, v8, v10, v9, v7}, Landroid/view/ViewAnimationUtils;->createCircularReveal(Landroid/view/View;IIFF)Landroid/animation/Animator;

    move-result-object v7

    iput-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    const-wide/16 v8, 0x5

    invoke-virtual {v7, v8, v9}, Landroid/animation/Animator;->setStartDelay(J)V

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    new-instance v8, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$e;

    invoke-direct {v8, v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$e;-><init>(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;I)V

    invoke-virtual {v7, v8}, Landroid/animation/Animator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->k:Landroid/animation/Animator;

    invoke-virtual {v7}, Landroid/animation/Animator;->start()V

    goto/16 :goto_3

    :cond_7
    iget-boolean v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz v7, :cond_8

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v9, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v8, v9}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v8

    invoke-static {v0, v7, v8}, Lcom/aurelhubert/ahbottomnavigation/b;->h(Landroid/view/View;II)V

    goto/16 :goto_3

    :cond_8
    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    if-eqz v7, :cond_9

    invoke-virtual {v0, v7}, Landroid/widget/FrameLayout;->setBackgroundResource(I)V

    goto :goto_2

    :cond_9
    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-virtual {v0, v7}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    :goto_2
    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {v7, v4}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_3

    :cond_a
    iget v10, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-ne v6, v10, :cond_c

    sget v10, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_container:I

    invoke-virtual {v7, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    sget v11, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_item_title:I

    invoke-virtual {v7, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/TextView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_small_item_icon:I

    invoke-virtual {v7, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    move-object v15, v12

    check-cast v15, Landroid/widget/ImageView;

    sget v12, Lcom/aurelhubert/ahbottomnavigation/f;->bottom_navigation_notification:I

    invoke-virtual {v7, v12}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/TextView;

    invoke-virtual {v15, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v13, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-eq v12, v13, :cond_b

    invoke-static {v15, v2, v5}, Lcom/aurelhubert/ahbottomnavigation/b;->g(Landroid/view/View;II)V

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->R:I

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->S:I

    invoke-static {v7, v12, v13}, Lcom/aurelhubert/ahbottomnavigation/b;->d(Landroid/view/View;II)V

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->T:I

    iget v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->U:I

    invoke-static {v7, v12, v13}, Lcom/aurelhubert/ahbottomnavigation/b;->g(Landroid/view/View;II)V

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    invoke-static {v11, v7, v12}, Lcom/aurelhubert/ahbottomnavigation/b;->e(Landroid/widget/TextView;II)V

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->J:F

    iget v12, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->K:F

    invoke-static {v10, v7, v12}, Lcom/aurelhubert/ahbottomnavigation/b;->i(Landroid/view/View;FF)V

    :cond_b
    invoke-static {v11, v8, v9}, Lcom/aurelhubert/ahbottomnavigation/b;->b(Landroid/view/View;FF)V

    iget-object v13, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    iget-object v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    iget v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    invoke-virtual {v7, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v7, v8}, Lcom/aurelhubert/ahbottomnavigation/a;->b(Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v14

    iget v7, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    iget v8, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    iget-boolean v9, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    move/from16 v16, v7

    move/from16 v17, v8

    move/from16 v18, v9

    invoke-static/range {v13 .. v18}, Lcom/aurelhubert/ahbottomnavigation/b;->c(Landroid/content/Context;Landroid/graphics/drawable/Drawable;Landroid/widget/ImageView;IIZ)V

    :cond_c
    :goto_3
    add-int/lit8 v6, v6, 0x1

    goto/16 :goto_0

    :cond_d
    iput v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    if-lez v1, :cond_e

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_e

    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    iget v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aurelhubert/ahbottomnavigation/a;

    iget-object v2, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/aurelhubert/ahbottomnavigation/a;->a(Landroid/content/Context;)I

    move-result v1

    iput v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->r:I

    goto :goto_5

    :cond_e
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    const/4 v2, -0x1

    if-ne v1, v2, :cond_10

    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    if-eqz v1, :cond_f

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundResource(I)V

    goto :goto_4

    :cond_f
    iget v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    :goto_4
    iget-object v1, v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->j:Landroid/view/View;

    invoke-virtual {v1, v4}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_10
    :goto_5
    return-void
.end method


# virtual methods
.method public f(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aurelhubert/ahbottomnavigation/a;",
            ">;)V"
        }
    .end annotation

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x5

    if-gt v0, v1, :cond_0

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    add-int/2addr v0, v2

    if-le v0, v1, :cond_1

    :cond_0
    sget-object v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->V:Ljava/lang/String;

    const-string v1, "The items list should not have more than 5 items"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public getAccentColor()I
    .locals 1

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    return v0
.end method

.method public getCurrentItem()I
    .locals 1

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    return v0
.end method

.method public getDefaultBackgroundColor()I
    .locals 1

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    return v0
.end method

.method public getInactiveColor()I
    .locals 1

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    return v0
.end method

.method public getItemsCount()I
    .locals 1

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getTitleState()Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;
    .locals 1

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    return-object v0
.end method

.method public k()Z
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .annotation build Landroid/annotation/TargetApi;
        value = 0x15
    .end annotation

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    iget v2, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    iget v1, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    new-instance v3, Landroid/util/DisplayMetrics;

    invoke-direct {v3}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {v0, v3}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget v0, v3, Landroid/util/DisplayMetrics;->heightPixels:I

    iget v3, v3, Landroid/util/DisplayMetrics;->widthPixels:I

    if-gt v1, v3, :cond_1

    if-le v2, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public m(IZ)V
    .locals 2

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_0

    sget-object p1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->V:Ljava/lang/String;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "The position is out of bounds of the items ("

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " elements)"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-eq v0, v1, :cond_2

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x3

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    sget-object v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    if-ne v0, v1, :cond_2

    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->n(IZ)V

    goto :goto_0

    :cond_2
    invoke-direct {p0, p1, p2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->p(IZ)V

    :goto_0
    return-void
.end method

.method protected onMeasure(II)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->onMeasure(II)V

    iget-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->p:Z

    if-nez p1, :cond_0

    iget-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->s:Z

    invoke-virtual {p0, p1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->setBehaviorTranslationEnabled(Z)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->p:Z

    :cond_0
    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 1

    instance-of v0, p1, Landroid/os/Bundle;

    if-eqz v0, :cond_0

    check-cast p1, Landroid/os/Bundle;

    const-string v0, "current_item"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    const-string v0, "notifications"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelableArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o:Ljava/util/List;

    const-string v0, "superState"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    return-void
.end method

.method protected onSaveInstanceState()Landroid/os/Parcelable;
    .locals 3

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    invoke-super {p0}, Landroid/widget/FrameLayout;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v1

    const-string v2, "superState"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->q:I

    const-string v2, "current_item"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o:Ljava/util/List;

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    const-string v2, "notifications"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putParcelableArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    return-object v0
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/FrameLayout;->onSizeChanged(IIII)V

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setAccentColor(I)V
    .locals 0

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->B:I

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setBehaviorTranslationEnabled(Z)V
    .locals 3

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->s:Z

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    instance-of v0, v0, Landroidx/coordinatorlayout/widget/CoordinatorLayout;

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    if-nez v1, :cond_0

    new-instance v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    iget v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->I:I

    invoke-direct {v1, p1, v2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;-><init>(ZI)V

    iput-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    goto :goto_0

    :cond_0
    iget v2, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->I:I

    invoke-virtual {v1, p1, v2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;->R(ZI)V

    :goto_0
    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;

    if-eqz p1, :cond_1

    iget-object v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    invoke-virtual {v1, p1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;->S(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;)V

    :cond_1
    check-cast v0, Landroidx/coordinatorlayout/widget/CoordinatorLayout$f;

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    invoke-virtual {v0, p1}, Landroidx/coordinatorlayout/widget/CoordinatorLayout$f;->o(Landroidx/coordinatorlayout/widget/CoordinatorLayout$c;)V

    iget-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->t:Z

    if-eqz p1, :cond_2

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->t:Z

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->H:I

    iget-boolean v1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->u:Z

    invoke-virtual {p1, p0, v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;->Q(Landroid/view/View;IZ)V

    :cond_2
    return-void
.end method

.method public setColored(Z)V
    .locals 1

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->l:Z

    if-eqz p1, :cond_0

    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->D:I

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->B:I

    :goto_0
    iput v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->z:I

    if-eqz p1, :cond_1

    iget p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->E:I

    goto :goto_1

    :cond_1
    iget p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->C:I

    :goto_1
    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setCurrentItem(I)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m(IZ)V

    return-void
.end method

.method public setDefaultBackgroundColor(I)V
    .locals 0

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->x:I

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setDefaultBackgroundResource(I)V
    .locals 0

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->y:I

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setForceTint(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->L:Z

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setInactiveColor(I)V
    .locals 0

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->C:I

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->A:I

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setNotificationBackground(Landroid/graphics/drawable/Drawable;)V
    .locals 1

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->P:Landroid/graphics/drawable/Drawable;

    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    return-void
.end method

.method public setNotificationBackgroundColor(I)V
    .locals 1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->O:I

    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    return-void
.end method

.method public setNotificationBackgroundColorResource(I)V
    .locals 1

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-static {v0, p1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->O:I

    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    return-void
.end method

.method public setNotificationTextColor(I)V
    .locals 1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->N:I

    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    return-void
.end method

.method public setNotificationTextColorResource(I)V
    .locals 1

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->d:Landroid/content/Context;

    invoke-static {v0, p1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p1

    iput p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->N:I

    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    return-void
.end method

.method public setNotificationTypeface(Landroid/graphics/Typeface;)V
    .locals 1

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->Q:Landroid/graphics/Typeface;

    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->o(ZI)V

    return-void
.end method

.method public setOnNavigationPositionListener(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;)V
    .locals 1

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;

    iget-object v0, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->h:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigationBehavior;->S(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$f;)V

    :cond_0
    return-void
.end method

.method public setOnTabSelectedListener(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;)V
    .locals 0

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;

    return-void
.end method

.method public setSelectedBackgroundVisible(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m:Z

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setSoundEffectsEnabled(Z)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->setSoundEffectsEnabled(Z)V

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->v:Z

    return-void
.end method

.method public setTitleState(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;)V
    .locals 0

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->M:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setTitleTypeface(Landroid/graphics/Typeface;)V
    .locals 0

    iput-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->w:Landroid/graphics/Typeface;

    invoke-direct {p0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->i()V

    return-void
.end method

.method public setTranslucentNavigationEnabled(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->n:Z

    return-void
.end method

.method public setUseElevation(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->e:Landroid/content/res/Resources;

    sget v0, Lcom/aurelhubert/ahbottomnavigation/d;->bottom_navigation_elevation:I

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    invoke-static {p0, p1}, La/f/l/r;->V(Landroid/view/View;F)V

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Landroid/widget/FrameLayout;->setClipToPadding(Z)V

    return-void
.end method
