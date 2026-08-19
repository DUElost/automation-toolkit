.class public Lcom/ape/offlinescriptmanager/view/a/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:Landroid/content/Context;

.field private b:Lb/b/a/a/d/f;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lb/b/a/a/d/f;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a;->a:Landroid/content/Context;

    if-nez p2, :cond_0

    new-instance p1, Lb/b/a/a/d/f;

    invoke-direct {p1}, Lb/b/a/a/d/f;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    goto :goto_0

    :cond_0
    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    :goto_0
    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/view/a/a;)Lb/b/a/a/d/f;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    return-object p0
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/view/a/a;Lb/b/a/a/d/f;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/a/a;->c(Lb/b/a/a/d/f;)V

    return-void
.end method

.method private c(Lb/b/a/a/d/f;)V
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/g;

    invoke-direct {v0, p1}, Lcom/ape/offlinescriptmanager/utils/m/g;-><init>(Lb/b/a/a/d/f;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/m/g;->k()Z

    return-void
.end method

.method public static d(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;Lb/a/a/f$m;Lb/a/a/f$m;)Lb/a/a/f;
    .locals 1

    new-instance v0, Lb/a/a/f$d;

    invoke-direct {v0, p0}, Lb/a/a/f$d;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Lb/a/a/f$d;->m(Ljava/lang/CharSequence;)Lb/a/a/f$d;

    const/4 p1, 0x1

    invoke-virtual {v0, p2, p1}, Lb/a/a/f$d;->d(Landroid/view/View;Z)Lb/a/a/f$d;

    const p1, 0x7f0f006f

    invoke-virtual {v0, p1}, Lb/a/a/f$d;->j(I)Lb/a/a/f$d;

    const p1, 0x7f0f006e

    invoke-virtual {v0, p1}, Lb/a/a/f$d;->f(I)Lb/a/a/f$d;

    invoke-virtual {v0, p3}, Lb/a/a/f$d;->i(Lb/a/a/f$m;)Lb/a/a/f$d;

    invoke-virtual {v0, p4}, Lb/a/a/f$d;->h(Lb/a/a/f$m;)Lb/a/a/f$d;

    sget-object p1, Lb/a/a/p;->b:Lb/a/a/p;

    invoke-virtual {v0, p1}, Lb/a/a/f$d;->l(Lb/a/a/p;)Lb/a/a/f$d;

    const p1, 0x7f06007e

    invoke-static {p0, p1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result p0

    invoke-virtual {v0, p0}, Lb/a/a/f$d;->n(I)Lb/a/a/f$d;

    invoke-virtual {v0}, Lb/a/a/f$d;->a()Lb/a/a/f;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public e()V
    .locals 7

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/a/a;->a:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0c0041

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0900b8

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    const v2, 0x7f0900b6

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/EditText;

    const v3, 0x7f0900b9

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/EditText;

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    invoke-virtual {v4}, Lb/b/a/a/d/f;->d()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    invoke-virtual {v4}, Lb/b/a/a/d/f;->d()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    invoke-virtual {v4}, Lb/b/a/a/d/f;->c()Z

    move-result v4

    invoke-virtual {v1, v4}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/a/a;->b:Lb/b/a/a/d/f;

    invoke-virtual {v4}, Lb/b/a/a/d/f;->l()I

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/a/a;->a:Landroid/content/Context;

    const v5, 0x7f0f0071

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/ape/offlinescriptmanager/view/a/a$a;

    invoke-direct {v6, p0, v1, v2, v3}, Lcom/ape/offlinescriptmanager/view/a/a$a;-><init>(Lcom/ape/offlinescriptmanager/view/a/a;Landroid/widget/CheckBox;Landroid/widget/EditText;Landroid/widget/EditText;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/view/a/a$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/a/a$b;-><init>(Lcom/ape/offlinescriptmanager/view/a/a;)V

    invoke-static {v4, v5, v0, v6, v1}, Lcom/ape/offlinescriptmanager/view/a/a;->d(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;Lb/a/a/f$m;Lb/a/a/f$m;)Lb/a/a/f;

    move-result-object v0

    invoke-virtual {v0}, Lb/a/a/f;->show()V

    return-void
.end method
