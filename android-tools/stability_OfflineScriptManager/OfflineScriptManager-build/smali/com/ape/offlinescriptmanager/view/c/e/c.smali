.class public Lcom/ape/offlinescriptmanager/view/c/e/c;
.super Lb/h/a/a/c/a$a;
.source ""

# interfaces
.implements Lcom/ape/offlinescriptmanager/view/c/e/d;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/view/c/e/c$h;,
        Lcom/ape/offlinescriptmanager/view/c/e/c$g;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lb/h/a/a/c/a$a<",
        "Lb/b/a/a/d/f$a;",
        ">;",
        "Lcom/ape/offlinescriptmanager/view/c/e/d;"
    }
.end annotation


# static fields
.field private static k:Z

.field private static l:Lb/b/a/a/c/f;

.field private static m:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/c/h;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected f:Ljava/lang/String;

.field protected g:Landroid/widget/LinearLayout;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/TextView;

.field private final j:Lcom/ape/offlinescriptmanager/view/c/e/c$h;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lb/h/a/a/c/a$a;-><init>(Landroid/content/Context;)V

    const-string p1, ""

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->f:Ljava/lang/String;

    new-instance p1, Lcom/ape/offlinescriptmanager/view/c/e/c$h;

    invoke-direct {p1, p0}, Lcom/ape/offlinescriptmanager/view/c/e/c$h;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->j:Lcom/ape/offlinescriptmanager/view/c/e/c$h;

    invoke-static {}, Lb/b/a/a/c/g;->a()Lb/b/a/a/c/g;

    move-result-object p1

    invoke-virtual {p1}, Lb/b/a/a/c/g;->b()Lb/b/a/a/c/f;

    move-result-object p1

    sput-object p1, Lcom/ape/offlinescriptmanager/view/c/e/c;->l:Lb/b/a/a/c/f;

    invoke-virtual {p1}, Lb/b/a/a/c/f;->h()Ljava/util/ArrayList;

    move-result-object p1

    sput-object p1, Lcom/ape/offlinescriptmanager/view/c/e/c;->m:Ljava/util/List;

    return-void
.end method

.method public static A()Z
    .locals 1

    sget-boolean v0, Lcom/ape/offlinescriptmanager/view/c/e/c;->k:Z

    return v0
.end method

.method private B()V
    .locals 3

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->g:Landroid/widget/LinearLayout;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lb/h/a/a/d/a;->u(Z)V

    invoke-virtual {v0}, Lb/h/a/a/d/a;->f()V

    iget-object v1, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0, v1}, Lb/h/a/a/d/a;->k(Lb/h/a/a/c/a;)V

    return-void
.end method

.method private C(Landroid/view/View;)V
    .locals 3

    const v0, 0x7f090047

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/c/e/c$g;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/ape/offlinescriptmanager/view/c/e/c$g;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Lcom/ape/offlinescriptmanager/view/c/e/c$a;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090048

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/c/e/c$g;

    invoke-direct {v1, p0, v2}, Lcom/ape/offlinescriptmanager/view/c/e/c$g;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Lcom/ape/offlinescriptmanager/view/c/e/c$a;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090043

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/view/c/e/c$g;

    invoke-direct {v1, p0, v2}, Lcom/ape/offlinescriptmanager/view/c/e/c$g;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Lcom/ape/offlinescriptmanager/view/c/e/c$a;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090046

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;

    invoke-direct {v0, p0, v2}, Lcom/ape/offlinescriptmanager/view/c/e/c$g;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Lcom/ape/offlinescriptmanager/view/c/e/c$a;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private E()V
    .locals 6

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/h/a/a/c/a;

    invoke-virtual {v1}, Lb/h/a/a/c/a;->f()I

    move-result v2

    sget-object v3, Lcom/ape/offlinescriptmanager/view/c/e/c;->m:Ljava/util/List;

    add-int/lit8 v2, v2, -0x1

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/b/a/a/c/h;

    invoke-virtual {v1}, Lb/h/a/a/c/a;->o()Z

    move-result v4

    invoke-virtual {v3, v4}, Lb/b/a/a/c/h;->j(Z)V

    invoke-virtual {v1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/h/a/a/c/a;

    invoke-virtual {v3}, Lb/h/a/a/c/a;->f()I

    move-result v4

    sget-object v5, Lcom/ape/offlinescriptmanager/view/c/e/c;->m:Ljava/util/List;

    invoke-interface {v5, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/b/a/a/c/h;

    invoke-virtual {v5}, Lb/b/a/a/c/h;->e()Ljava/util/ArrayList;

    move-result-object v5

    add-int/lit8 v4, v4, -0x1

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lb/b/a/a/c/c;

    invoke-virtual {v3}, Lb/h/a/a/c/a;->o()Z

    move-result v3

    invoke-interface {v4, v3}, Lb/b/a/a/c/c;->d(Z)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->D()V

    return-void
.end method

.method private F()V
    .locals 2

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/h/a/a/d/a;->h()V

    invoke-virtual {v0}, Lb/h/a/a/d/a;->f()V

    iget-object v1, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0, v1}, Lb/h/a/a/d/a;->k(Lb/h/a/a/c/a;)V

    return-void
.end method

.method private G()V
    .locals 2

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/h/a/a/d/a;->j()V

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->J()V

    :cond_0
    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/h/a/a/d/a;->f()V

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v0

    iget-object v1, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0, v1}, Lb/h/a/a/d/a;->k(Lb/h/a/a/c/a;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->g:Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->D()V

    return-void
.end method

.method private I(IILandroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnClickListener;)V
    .locals 2

    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string p2, "Yes"

    invoke-virtual {p1, p2, p3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string p2, "No"

    invoke-virtual {p1, p2, p4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog;->show()V

    return-void
.end method

.method private J()V
    .locals 5

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/h/a/a/c/a;

    sget-object v2, Lcom/ape/offlinescriptmanager/view/c/e/c;->m:Ljava/util/List;

    invoke-virtual {v1}, Lb/h/a/a/c/a;->f()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/c/h;

    invoke-virtual {v2}, Lb/b/a/a/c/h;->g()Z

    move-result v3

    invoke-virtual {v1, v3}, Lb/h/a/a/c/a;->t(Z)V

    invoke-virtual {v1}, Lb/h/a/a/c/a;->j()Lb/h/a/a/c/a$a;

    move-result-object v4

    invoke-virtual {v4, v3}, Lb/h/a/a/c/a$a;->m(Z)V

    invoke-virtual {v1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v2}, Lb/b/a/a/c/h;->e()Ljava/util/ArrayList;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/h/a/a/c/a;

    invoke-virtual {v3}, Lb/h/a/a/c/a;->f()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lb/b/a/a/c/c;

    invoke-interface {v4}, Lb/b/a/a/c/c;->f()Z

    move-result v4

    invoke-virtual {v3, v4}, Lb/h/a/a/c/a;->t(Z)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method static synthetic n()Lb/b/a/a/c/f;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/view/c/e/c;->l:Lb/b/a/a/c/f;

    return-object v0
.end method

.method static synthetic o(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->G()V

    return-void
.end method

.method static synthetic p()Ljava/util/List;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/view/c/e/c;->m:Ljava/util/List;

    return-object v0
.end method

.method static synthetic q(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->F()V

    return-void
.end method

.method static synthetic r()Z
    .locals 1

    sget-boolean v0, Lcom/ape/offlinescriptmanager/view/c/e/c;->k:Z

    return v0
.end method

.method static synthetic s(Z)Z
    .locals 0

    sput-boolean p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->k:Z

    return p0
.end method

.method static synthetic t(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->B()V

    return-void
.end method

.method static synthetic u(Lcom/ape/offlinescriptmanager/view/c/e/c;IILandroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnClickListener;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/ape/offlinescriptmanager/view/c/e/c;->I(IILandroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnClickListener;)V

    return-void
.end method

.method static synthetic v(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->E()V

    return-void
.end method

.method static synthetic w(Lcom/ape/offlinescriptmanager/view/c/e/c;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    return-object p0
.end method

.method public static z()Lb/b/a/a/c/f;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/view/c/e/c;->l:Lb/b/a/a/c/f;

    return-object v0
.end method


# virtual methods
.method public D()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->j:Lcom/ape/offlinescriptmanager/view/c/e/c$h;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public H(Lb/h/a/a/c/a;Lb/b/a/a/c/b;)V
    .locals 5

    iget-object v0, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0c0040

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0901c7

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    invoke-interface {p2}, Lb/b/a/a/c/b;->getName()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-interface {p2}, Lb/b/a/a/c/b;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    const v1, 0x7f0900b9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    invoke-interface {p2}, Lb/b/a/a/c/b;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    const v2, 0x7f090147

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    new-instance v3, Lcom/ape/offlinescriptmanager/view/c/e/c$c;

    invoke-direct {v3, p0, v1}, Lcom/ape/offlinescriptmanager/view/c/e/c$c;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Landroid/widget/EditText;)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090146

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    new-instance v3, Lcom/ape/offlinescriptmanager/view/c/e/c$d;

    invoke-direct {v3, p0, v1}, Lcom/ape/offlinescriptmanager/view/c/e/c$d;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Landroid/widget/EditText;)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    const v3, 0x7f0f0073

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/ape/offlinescriptmanager/view/c/e/c$e;

    invoke-direct {v4, p0, v1, p2, p1}, Lcom/ape/offlinescriptmanager/view/c/e/c$e;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Landroid/widget/EditText;Lb/b/a/a/c/b;Lb/h/a/a/c/a;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/view/c/e/c$f;

    invoke-direct {p1, p0}, Lcom/ape/offlinescriptmanager/view/c/e/c$f;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    invoke-static {v2, v3, v0, v4, p1}, Lcom/ape/offlinescriptmanager/view/a/a;->d(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;Lb/a/a/f$m;Lb/a/a/f$m;)Lb/a/a/f;

    move-result-object p1

    invoke-virtual {p1}, Lb/a/a/f;->show()V

    return-void
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->i:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->i:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public bridge synthetic c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;
    .locals 0

    check-cast p2, Lb/b/a/a/d/f$a;

    invoke-virtual {p0, p1, p2}, Lcom/ape/offlinescriptmanager/view/c/e/c;->x(Lb/h/a/a/c/a;Lb/b/a/a/d/f$a;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public x(Lb/h/a/a/c/a;Lb/b/a/a/d/f$a;)Landroid/view/View;
    .locals 4

    iget-object v0, p2, Lb/b/a/a/d/f$a;->b:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->f:Ljava/lang/String;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lb/h/a/a/c/a;->q(Z)Lb/h/a/a/c/a;

    iget-object v0, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0c004e

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->h:Landroid/view/View;

    const v1, 0x7f0900e4

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/github/johnkil/print/PrintView;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->h:Landroid/view/View;

    const v2, 0x7f090134

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->i:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->h:Landroid/view/View;

    const v2, 0x7f090105

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->g:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iget v2, p2, Lb/b/a/a/d/f$a;->a:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/github/johnkil/print/PrintView;->setIconText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->i:Landroid/widget/TextView;

    iget-object p2, p2, Lb/b/a/a/d/f$a;->b:Ljava/lang/String;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->h:Landroid/view/View;

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/view/c/e/c;->C(Landroid/view/View;)V

    new-instance p2, Lcom/ape/offlinescriptmanager/view/c/e/c$a;

    invoke-direct {p2, p0}, Lcom/ape/offlinescriptmanager/view/c/e/c$a;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    invoke-virtual {p1, p2}, Lb/h/a/a/c/a;->r(Lb/h/a/a/c/a$c;)Lb/h/a/a/c/a;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lb/h/a/a/c/a;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/e/c$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/c/e/c$b;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    invoke-virtual {p2, v0}, Lb/h/a/a/c/a;->r(Lb/h/a/a/c/a$c;)Lb/h/a/a/c/a;

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->h:Landroid/view/View;

    return-object p1
.end method

.method public y()Lcom/ape/offlinescriptmanager/view/c/e/c$h;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->j:Lcom/ape/offlinescriptmanager/view/c/e/c$h;

    return-object v0
.end method
