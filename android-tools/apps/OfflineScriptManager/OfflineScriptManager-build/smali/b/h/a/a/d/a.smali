.class public Lb/h/a/a/d/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field protected a:Lb/h/a/a/c/a;

.field private b:Landroid/content/Context;

.field private c:Z

.field private d:I

.field private e:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "+",
            "Lb/h/a/a/c/a$a;",
            ">;"
        }
    .end annotation
.end field

.field private f:Lb/h/a/a/c/a$b;

.field private g:Lb/h/a/a/c/a$c;

.field private h:Z

.field private i:Z

.field private j:Z

.field private k:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Lb/h/a/a/c/a;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/h/a/a/d/a;->d:I

    const-class v1, Lb/h/a/a/b/a;

    iput-object v1, p0, Lb/h/a/a/d/a;->e:Ljava/lang/Class;

    iput-boolean v0, p0, Lb/h/a/a/d/a;->i:Z

    iput-boolean v0, p0, Lb/h/a/a/d/a;->j:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/h/a/a/d/a;->k:Z

    iput-object p2, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    iput-object p1, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    return-void
.end method

.method static synthetic a(Lb/h/a/a/d/a;)Lb/h/a/a/c/a$b;
    .locals 0

    iget-object p0, p0, Lb/h/a/a/d/a;->f:Lb/h/a/a/c/a$b;

    return-object p0
.end method

.method static synthetic b(Lb/h/a/a/d/a;)Z
    .locals 0

    iget-boolean p0, p0, Lb/h/a/a/d/a;->k:Z

    return p0
.end method

.method static synthetic c(Lb/h/a/a/d/a;)Lb/h/a/a/c/a$c;
    .locals 0

    iget-object p0, p0, Lb/h/a/a/d/a;->g:Lb/h/a/a/c/a$c;

    return-object p0
.end method

.method private d(Landroid/view/ViewGroup;Lb/h/a/a/c/a;)V
    .locals 2

    invoke-direct {p0, p2}, Lb/h/a/a/d/a;->o(Lb/h/a/a/c/a;)Lb/h/a/a/c/a$a;

    move-result-object v0

    invoke-virtual {v0}, Lb/h/a/a/c/a$a;->h()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    iget-boolean p1, p0, Lb/h/a/a/d/a;->h:Z

    if-eqz p1, :cond_0

    invoke-virtual {v0, p1}, Lb/h/a/a/c/a$a;->m(Z)V

    :cond_0
    new-instance p1, Lb/h/a/a/d/a$b;

    invoke-direct {p1, p0, p2}, Lb/h/a/a/d/a$b;-><init>(Lb/h/a/a/d/a;Lb/h/a/a/c/a;)V

    invoke-virtual {v1, p1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p1, Lb/h/a/a/d/a$c;

    invoke-direct {p1, p0, p2}, Lb/h/a/a/d/a$c;-><init>(Lb/h/a/a/d/a;Lb/h/a/a/c/a;)V

    invoke-virtual {v1, p1}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method

.method private static e(Landroid/view/View;)V
    .locals 4

    invoke-virtual {p0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v0

    new-instance v1, Lb/h/a/a/d/a$e;

    invoke-direct {v1, p0, v0}, Lb/h/a/a/d/a$e;-><init>(Landroid/view/View;I)V

    int-to-float v0, v0

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v0, v2

    float-to-int v0, v0

    int-to-long v2, v0

    invoke-virtual {v1, v2, v3}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method private g(Lb/h/a/a/c/a;Z)V
    .locals 4

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lb/h/a/a/c/a;->q(Z)Lb/h/a/a/c/a;

    invoke-direct {p0, p1}, Lb/h/a/a/d/a;->o(Lb/h/a/a/c/a;)Lb/h/a/a/c/a$a;

    move-result-object v1

    iget-boolean v2, p0, Lb/h/a/a/d/a;->i:Z

    if-eqz v2, :cond_0

    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->e()Landroid/view/ViewGroup;

    move-result-object v2

    invoke-static {v2}, Lb/h/a/a/d/a;->e(Landroid/view/View;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->e()Landroid/view/ViewGroup;

    move-result-object v2

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->setVisibility(I)V

    :goto_0
    invoke-virtual {v1, v0}, Lb/h/a/a/c/a$a;->l(Z)V

    if-eqz p2, :cond_1

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    invoke-direct {p0, v0, p2}, Lb/h/a/a/d/a;->g(Lb/h/a/a/c/a;Z)V

    goto :goto_1

    :cond_1
    return-void
.end method

.method private static i(Landroid/view/View;)V
    .locals 4

    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-virtual {p0, v0, v1}, Landroid/view/View;->measure(II)V

    invoke-virtual {p0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    const/4 v2, 0x0

    iput v2, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {p0, v2}, Landroid/view/View;->setVisibility(I)V

    new-instance v1, Lb/h/a/a/d/a$d;

    invoke-direct {v1, p0, v0}, Lb/h/a/a/d/a$d;-><init>(Landroid/view/View;I)V

    int-to-float v0, v0

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v0, v2

    float-to-int v0, v0

    int-to-long v2, v0

    invoke-virtual {v1, v2, v3}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method private l(Lb/h/a/a/c/a;Z)V
    .locals 3

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lb/h/a/a/c/a;->q(Z)Lb/h/a/a/c/a;

    invoke-direct {p0, p1}, Lb/h/a/a/d/a;->o(Lb/h/a/a/c/a;)Lb/h/a/a/c/a$a;

    move-result-object v1

    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->e()Landroid/view/ViewGroup;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewGroup;->removeAllViews()V

    invoke-virtual {v1, v0}, Lb/h/a/a/c/a$a;->l(Z)V

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->e()Landroid/view/ViewGroup;

    move-result-object v2

    invoke-direct {p0, v2, v0}, Lb/h/a/a/d/a;->d(Landroid/view/ViewGroup;Lb/h/a/a/c/a;)V

    invoke-virtual {v0}, Lb/h/a/a/c/a;->k()Z

    move-result v2

    if-nez v2, :cond_1

    if-eqz p2, :cond_0

    :cond_1
    invoke-direct {p0, v0, p2}, Lb/h/a/a/d/a;->l(Lb/h/a/a/c/a;Z)V

    goto :goto_0

    :cond_2
    iget-boolean p1, p0, Lb/h/a/a/d/a;->i:Z

    if-eqz p1, :cond_3

    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->e()Landroid/view/ViewGroup;

    move-result-object p1

    invoke-static {p1}, Lb/h/a/a/d/a;->i(Landroid/view/View;)V

    goto :goto_1

    :cond_3
    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->e()Landroid/view/ViewGroup;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/ViewGroup;->setVisibility(I)V

    :goto_1
    return-void
.end method

.method private o(Lb/h/a/a/c/a;)Lb/h/a/a/c/a$a;
    .locals 5

    invoke-virtual {p1}, Lb/h/a/a/c/a;->j()Lb/h/a/a/c/a$a;

    move-result-object v0

    if-nez v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lb/h/a/a/d/a;->e:Ljava/lang/Class;

    const/4 v1, 0x1

    new-array v2, v1, [Ljava/lang/Class;

    const-class v3, Landroid/content/Context;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-virtual {v0, v2}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    new-array v1, v1, [Ljava/lang/Object;

    iget-object v2, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    aput-object v2, v1, v4

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a$a;

    invoke-virtual {p1, v0}, Lb/h/a/a/c/a;->u(Lb/h/a/a/c/a$a;)Lb/h/a/a/c/a;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    new-instance p1, Ljava/lang/RuntimeException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Could not instantiate class "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/h/a/a/d/a;->e:Ljava/lang/Class;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    :goto_0
    invoke-virtual {v0}, Lb/h/a/a/c/a$a;->d()I

    move-result p1

    if-gtz p1, :cond_1

    iget p1, p0, Lb/h/a/a/d/a;->d:I

    invoke-virtual {v0, p1}, Lb/h/a/a/c/a$a;->j(I)V

    :cond_1
    invoke-virtual {v0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object p1

    if-nez p1, :cond_2

    invoke-virtual {v0, p0}, Lb/h/a/a/c/a$a;->k(Lb/h/a/a/d/a;)V

    :cond_2
    return-object v0
.end method

.method private q(ZZ)V
    .locals 2

    iget-boolean v0, p0, Lb/h/a/a/d/a;->h:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/h/a/a/c/a;

    invoke-direct {p0, v1, p1, p2}, Lb/h/a/a/d/a;->t(Lb/h/a/a/c/a;ZZ)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private t(Lb/h/a/a/c/a;ZZ)V
    .locals 1

    invoke-virtual {p1, p2}, Lb/h/a/a/c/a;->t(Z)V

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lb/h/a/a/d/a;->x(Lb/h/a/a/c/a;Z)V

    if-eqz p3, :cond_0

    invoke-virtual {p1}, Lb/h/a/a/c/a;->k()Z

    move-result v0

    :cond_0
    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    invoke-direct {p0, v0, p2, p3}, Lb/h/a/a/d/a;->t(Lb/h/a/a/c/a;ZZ)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private w(Lb/h/a/a/c/a;Z)V
    .locals 1

    invoke-direct {p0, p1, p2}, Lb/h/a/a/d/a;->x(Lb/h/a/a/c/a;Z)V

    invoke-virtual {p1}, Lb/h/a/a/c/a;->k()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    invoke-direct {p0, v0, p2}, Lb/h/a/a/d/a;->w(Lb/h/a/a/c/a;Z)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private x(Lb/h/a/a/c/a;Z)V
    .locals 1

    invoke-direct {p0, p1}, Lb/h/a/a/d/a;->o(Lb/h/a/a/c/a;)Lb/h/a/a/c/a$a;

    move-result-object v0

    invoke-virtual {v0}, Lb/h/a/a/c/a$a;->i()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lb/h/a/a/d/a;->o(Lb/h/a/a/c/a;)Lb/h/a/a/c/a$a;

    move-result-object p1

    invoke-virtual {p1, p2}, Lb/h/a/a/c/a$a;->m(Z)V

    :cond_0
    return-void
.end method


# virtual methods
.method public f()V
    .locals 3

    iget-object v0, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/h/a/a/c/a;

    const/4 v2, 0x1

    invoke-direct {p0, v1, v2}, Lb/h/a/a/d/a;->g(Lb/h/a/a/c/a;Z)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public h()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Lb/h/a/a/d/a;->q(ZZ)V

    return-void
.end method

.method public j()V
    .locals 2

    iget-object v0, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lb/h/a/a/d/a;->l(Lb/h/a/a/c/a;Z)V

    return-void
.end method

.method public k(Lb/h/a/a/c/a;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lb/h/a/a/d/a;->l(Lb/h/a/a/c/a;Z)V

    return-void
.end method

.method public m()Landroid/view/View;
    .locals 1

    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Lb/h/a/a/d/a;->n(I)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public n(I)Landroid/view/View;
    .locals 4

    if-lez p1, :cond_1

    new-instance v0, Landroid/view/ContextThemeWrapper;

    iget-object v1, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, Landroid/view/ContextThemeWrapper;-><init>(Landroid/content/Context;I)V

    iget-boolean p1, p0, Lb/h/a/a/d/a;->j:Z

    if-eqz p1, :cond_0

    new-instance p1, Lb/h/a/a/d/c;

    invoke-direct {p1, v0}, Lb/h/a/a/d/c;-><init>(Landroid/content/Context;)V

    goto :goto_0

    :cond_0
    new-instance p1, Landroid/widget/ScrollView;

    invoke-direct {p1, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    goto :goto_0

    :cond_1
    iget-boolean p1, p0, Lb/h/a/a/d/a;->j:Z

    if-eqz p1, :cond_2

    new-instance p1, Lb/h/a/a/d/c;

    iget-object v0, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    invoke-direct {p1, v0}, Lb/h/a/a/d/c;-><init>(Landroid/content/Context;)V

    goto :goto_0

    :cond_2
    new-instance p1, Landroid/widget/ScrollView;

    iget-object v0, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    invoke-direct {p1, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    :goto_0
    iget-object v0, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    iget v1, p0, Lb/h/a/a/d/a;->d:I

    if-eqz v1, :cond_3

    iget-boolean v1, p0, Lb/h/a/a/d/a;->c:Z

    if-eqz v1, :cond_3

    new-instance v0, Landroid/view/ContextThemeWrapper;

    iget-object v1, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    iget v2, p0, Lb/h/a/a/d/a;->d:I

    invoke-direct {v0, v1, v2}, Landroid/view/ContextThemeWrapper;-><init>(Landroid/content/Context;I)V

    :cond_3
    new-instance v1, Landroid/widget/LinearLayout;

    const/4 v2, 0x0

    iget v3, p0, Lb/h/a/a/d/a;->d:I

    invoke-direct {v1, v0, v2, v3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    sget v0, Lb/h/a/a/a;->tree_items:I

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setId(I)V

    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    new-instance v2, Lb/h/a/a/d/a$a;

    iget-object v3, p0, Lb/h/a/a/d/a;->b:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1}, Lb/h/a/a/d/a$a;-><init>(Lb/h/a/a/d/a;Landroid/content/Context;Landroid/widget/LinearLayout;)V

    invoke-virtual {v0, v2}, Lb/h/a/a/c/a;->u(Lb/h/a/a/c/a$a;)Lb/h/a/a/c/a;

    iget-object v0, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lb/h/a/a/d/a;->l(Lb/h/a/a/c/a;Z)V

    return-object p1
.end method

.method public p()Z
    .locals 1

    iget-boolean v0, p0, Lb/h/a/a/d/a;->h:Z

    return v0
.end method

.method public r(Z)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lb/h/a/a/d/a;->q(ZZ)V

    return-void
.end method

.method public s(Lb/h/a/a/c/a;Z)V
    .locals 1

    iget-boolean v0, p0, Lb/h/a/a/d/a;->h:Z

    if-eqz v0, :cond_0

    invoke-virtual {p1, p2}, Lb/h/a/a/c/a;->t(Z)V

    const/4 p2, 0x1

    invoke-direct {p0, p1, p2}, Lb/h/a/a/d/a;->x(Lb/h/a/a/c/a;Z)V

    :cond_0
    return-void
.end method

.method public u(Z)V
    .locals 2

    if-nez p1, :cond_0

    invoke-virtual {p0}, Lb/h/a/a/d/a;->h()V

    :cond_0
    iput-boolean p1, p0, Lb/h/a/a/d/a;->h:Z

    iget-object v0, p0, Lb/h/a/a/d/a;->a:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/h/a/a/c/a;

    invoke-direct {p0, v1, p1}, Lb/h/a/a/d/a;->w(Lb/h/a/a/c/a;Z)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public v(Lb/h/a/a/c/a;)V
    .locals 2

    invoke-virtual {p1}, Lb/h/a/a/c/a;->k()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, v1}, Lb/h/a/a/d/a;->g(Lb/h/a/a/c/a;Z)V

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1, v1}, Lb/h/a/a/d/a;->l(Lb/h/a/a/c/a;Z)V

    :goto_0
    return-void
.end method
