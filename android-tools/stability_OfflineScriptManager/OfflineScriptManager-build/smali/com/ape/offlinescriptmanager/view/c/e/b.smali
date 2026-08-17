.class public Lcom/ape/offlinescriptmanager/view/c/e/b;
.super Lcom/ape/offlinescriptmanager/view/c/e/c;
.source ""


# instance fields
.field private n:Landroid/widget/TextView;

.field private o:Lcom/github/johnkil/print/PrintView;

.field private p:Landroid/widget/CheckBox;

.field private q:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic K(Lcom/ape/offlinescriptmanager/view/c/e/b;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->q:Z

    return p1
.end method


# virtual methods
.method public L(Z)V
    .locals 1

    iget-object p1, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->h()Lb/h/a/a/c/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/h/a/a/c/a;->j()Lb/h/a/a/c/a$a;

    move-result-object p1

    check-cast p1, Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->y()Lcom/ape/offlinescriptmanager/view/c/e/c$h;

    move-result-object p1

    const/16 v0, 0x3e9

    invoke-virtual {p1, v0}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->n:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->n:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public bridge synthetic c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;
    .locals 0
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    check-cast p2, Lb/b/a/a/d/f$a;

    invoke-virtual {p0, p1, p2}, Lcom/ape/offlinescriptmanager/view/c/e/b;->x(Lb/h/a/a/c/a;Lb/b/a/a/d/f$a;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public l(Z)V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->o:Lcom/github/johnkil/print/PrintView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    if-eqz p1, :cond_1

    const v2, 0x7f0f014c

    goto :goto_0

    :cond_1
    const v2, 0x7f0f014e

    :goto_0
    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/github/johnkil/print/PrintView;->setIconText(Ljava/lang/CharSequence;)V

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/h/a/a/d/a;->p()Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->j()Lb/h/a/a/c/a$a;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/view/c/e/a;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/view/c/e/a;->m(Z)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method public m(Z)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->p:Landroid/widget/CheckBox;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->p:Landroid/widget/CheckBox;

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->o()Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setChecked(Z)V

    return-void
.end method

.method public x(Lb/h/a/a/c/a;Lb/b/a/a/d/f$a;)Landroid/view/View;
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    iget-object v0, p2, Lb/b/a/a/d/f$a;->b:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->f:Ljava/lang/String;

    iget-object v0, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0c004d

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f090133

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->p:Landroid/widget/CheckBox;

    new-instance v2, Lcom/ape/offlinescriptmanager/view/c/e/b$a;

    invoke-direct {v2, p0, p1}, Lcom/ape/offlinescriptmanager/view/c/e/b$a;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/b;Lb/h/a/a/c/a;)V

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->p:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->o()Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    const v1, 0x7f09002d

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/github/johnkil/print/PrintView;

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->o:Lcom/github/johnkil/print/PrintView;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->m()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->o:Lcom/github/johnkil/print/PrintView;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    :cond_0
    const v1, 0x7f0900e4

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/github/johnkil/print/PrintView;

    iget-object v2, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    iget p2, p2, Lb/b/a/a/d/f$a;->a:I

    invoke-virtual {v2, p2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Lcom/github/johnkil/print/PrintView;->setIconText(Ljava/lang/CharSequence;)V

    const p2, 0x7f09013b

    invoke-virtual {v0, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->f()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v1, v3

    const-string p1, "%02d."

    invoke-static {p1, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const p1, 0x7f090134

    invoke-virtual {v0, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b;->n:Landroid/widget/TextView;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c;->f:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-object v0
.end method
