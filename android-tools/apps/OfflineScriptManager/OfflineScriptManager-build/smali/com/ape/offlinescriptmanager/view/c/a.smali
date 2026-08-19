.class public Lcom/ape/offlinescriptmanager/view/c/a;
.super Landroidx/fragment/app/Fragment;
.source ""


# instance fields
.field Z:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

.field a0:Landroid/widget/EditText;

.field b0:Ljava/lang/String;

.field c0:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/c/h;",
            ">;"
        }
    .end annotation
.end field

.field private d0:Landroid/content/SharedPreferences;

.field private e0:Landroid/content/SharedPreferences$Editor;

.field private f0:Landroid/widget/RelativeLayout;

.field private g0:I

.field private h0:Lb/h/a/a/d/a;

.field private i0:Lb/b/a/a/c/f;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    return-void
.end method

.method static synthetic l1(Lcom/ape/offlinescriptmanager/view/c/a;)Lb/h/a/a/d/a;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->h0:Lb/h/a/a/d/a;

    return-object p0
.end method

.method static synthetic m1(Lcom/ape/offlinescriptmanager/view/c/a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/a;->t1()V

    return-void
.end method

.method static synthetic n1(Lcom/ape/offlinescriptmanager/view/c/a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/c/a;->s1()V

    return-void
.end method

.method public static o1()Lcom/ape/offlinescriptmanager/view/c/a;
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/view/c/a;-><init>()V

    return-object v0
.end method

.method private q1(Ljava/lang/String;)Lb/b/a/a/c/f;
    .locals 1

    invoke-static {}, Lb/b/a/a/c/g;->a()Lb/b/a/a/c/g;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/g;->d(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/e/c;->z()Lb/b/a/a/c/f;

    move-result-object p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {}, Lb/b/a/a/c/g;->a()Lb/b/a/a/c/g;

    move-result-object p1

    invoke-virtual {p1}, Lb/b/a/a/c/g;->b()Lb/b/a/a/c/f;

    move-result-object p1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    return-object p1
.end method

.method private r1(Landroid/view/View;)V
    .locals 1

    const v0, 0x7f09019d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->a0:Landroid/widget/EditText;

    const v0, 0x7f090105

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    const v0, 0x7f09015e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->f0:Landroid/widget/RelativeLayout;

    const v0, 0x7f0900d3

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a;->Z:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/a$a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/c/a$a;-><init>(Lcom/ape/offlinescriptmanager/view/c/a;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private s1()V
    .locals 4

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    const-string v1, "task service starting"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->q(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->e0:Landroid/content/SharedPreferences$Editor;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/a;->a0:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v3, "task_creator"

    invoke-interface {v0, v3, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->e0:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    const-string v1, "Task started"

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private t1()V
    .locals 3

    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f02c0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x7f0f0258

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/c/a$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/c/a$b;-><init>(Lcom/ape/offlinescriptmanager/view/c/a;)V

    const v2, 0x104000a

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    const/high16 v1, 0x1040000

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return-void
.end method


# virtual methods
.method public V(Landroid/content/Context;)V
    .locals 0

    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->V(Landroid/content/Context;)V

    return-void
.end method

.method public c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object p3

    const-string v0, "test_task_data"

    const/4 v1, 0x0

    invoke-virtual {p3, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p3

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/c/a;->d0:Landroid/content/SharedPreferences;

    invoke-interface {p3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/c/a;->e0:Landroid/content/SharedPreferences$Editor;

    const p3, 0x7f0c0048

    invoke-virtual {p1, p3, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->l()Landroid/os/Bundle;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->l()Landroid/os/Bundle;

    move-result-object p2

    const-string p3, "TASK"

    invoke-virtual {p2, p3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/a;->b0:Ljava/lang/String;

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/view/c/a;->q1(Ljava/lang/String;)Lb/b/a/a/c/f;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/a;->i0:Lb/b/a/a/c/f;

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lb/b/a/a/c/f;->h()Ljava/util/ArrayList;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/a;->c0:Ljava/util/List;

    :cond_0
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/c/a;->r1(Landroid/view/View;)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/view/c/a;->p1()V

    return-object p1
.end method

.method public d0()V
    .locals 0

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->d0()V

    return-void
.end method

.method public p1()V
    .locals 11

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->g0:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->f0:Landroid/widget/RelativeLayout;

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->getGravity()I

    move-result v0

    iput v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->g0:I

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->f0:Landroid/widget/RelativeLayout;

    iget v1, p0, Lcom/ape/offlinescriptmanager/view/c/a;->g0:I

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setGravity(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->c0:Ljava/util/List;

    if-nez v0, :cond_2

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0c0056

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/a;->f0:Landroid/widget/RelativeLayout;

    invoke-virtual {v1, v0}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->f0:Landroid/widget/RelativeLayout;

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setGravity(I)V

    return-void

    :cond_2
    invoke-static {}, Lb/h/a/a/c/a;->p()Lb/h/a/a/c/a;

    move-result-object v0

    new-instance v1, Lb/h/a/a/d/a;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lb/h/a/a/d/a;-><init>(Landroid/content/Context;Lb/h/a/a/c/a;)V

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/a;->h0:Lb/h/a/a/d/a;

    new-instance v1, Lb/h/a/a/c/a;

    new-instance v2, Lb/b/a/a/d/f$a;

    const v3, 0x7f0f016c

    const/4 v4, 0x1

    new-array v5, v4, [Ljava/lang/Object;

    iget-object v6, p0, Lcom/ape/offlinescriptmanager/view/c/a;->i0:Lb/b/a/a/c/f;

    invoke-virtual {v6}, Lb/b/a/a/c/f;->a()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/4 v7, 0x0

    aput-object v6, v5, v7

    const-string v6, "Task * %s"

    invoke-static {v6, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v3, v5}, Lb/b/a/a/d/f$a;-><init>(ILjava/lang/String;)V

    invoke-direct {v1, v2}, Lb/h/a/a/c/a;-><init>(Ljava/lang/Object;)V

    new-instance v2, Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/ape/offlinescriptmanager/view/c/e/c;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Lb/h/a/a/c/a;->u(Lb/h/a/a/c/a$a;)Lb/h/a/a/c/a;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/c/a;->c0:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/b/a/a/c/h;

    new-instance v5, Lb/h/a/a/c/a;

    new-instance v6, Lb/b/a/a/d/f$a;

    const v8, 0x7f0f015e

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    invoke-virtual {v3}, Lb/b/a/a/c/h;->getName()Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v7

    invoke-virtual {v3}, Lb/b/a/a/c/h;->a()I

    move-result v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v9, v4

    const-string v10, "%s * %s"

    invoke-static {v10, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v6, v8, v9}, Lb/b/a/a/d/f$a;-><init>(ILjava/lang/String;)V

    invoke-direct {v5, v6}, Lb/h/a/a/c/a;-><init>(Ljava/lang/Object;)V

    new-instance v6, Lcom/ape/offlinescriptmanager/view/c/e/b;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v8

    invoke-direct {v6, v8}, Lcom/ape/offlinescriptmanager/view/c/e/b;-><init>(Landroid/content/Context;)V

    invoke-virtual {v5, v6}, Lb/h/a/a/c/a;->u(Lb/h/a/a/c/a$a;)Lb/h/a/a/c/a;

    invoke-virtual {v3}, Lb/b/a/a/c/h;->e()Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/b/a/a/c/c;

    check-cast v6, Lb/b/a/a/c/i;

    new-instance v8, Lb/h/a/a/c/a;

    invoke-virtual {v6}, Lb/b/a/a/c/i;->l()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v8, v6}, Lb/h/a/a/c/a;-><init>(Ljava/lang/Object;)V

    new-instance v6, Lcom/ape/offlinescriptmanager/view/c/e/a;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v9

    invoke-direct {v6, v9}, Lcom/ape/offlinescriptmanager/view/c/e/a;-><init>(Landroid/content/Context;)V

    invoke-virtual {v8, v6}, Lb/h/a/a/c/a;->u(Lb/h/a/a/c/a$a;)Lb/h/a/a/c/a;

    invoke-virtual {v5, v8}, Lb/h/a/a/c/a;->a(Lb/h/a/a/c/a;)Lb/h/a/a/c/a;

    goto :goto_1

    :cond_3
    invoke-virtual {v1, v5}, Lb/h/a/a/c/a;->a(Lb/h/a/a/c/a;)Lb/h/a/a/c/a;

    goto :goto_0

    :cond_4
    new-array v2, v4, [Lb/h/a/a/c/a;

    aput-object v1, v2, v7

    invoke-virtual {v0, v2}, Lb/h/a/a/c/a;->b([Lb/h/a/a/c/a;)Lb/h/a/a/c/a;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/a;->f0:Landroid/widget/RelativeLayout;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/a;->h0:Lb/h/a/a/d/a;

    invoke-virtual {v1}, Lb/h/a/a/d/a;->m()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    return-void
.end method
