.class public Lcom/ape/offlinescriptmanager/view/c/e/a;
.super Lb/h/a/a/c/a$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lb/h/a/a/c/a$a<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private final f:Landroid/view/View;

.field private g:Landroid/widget/CheckBox;

.field private h:Landroid/widget/TextView;

.field private i:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    invoke-direct {p0, p1}, Lb/h/a/a/c/a$a;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    const v0, 0x7f0c004c

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->f:Landroid/view/View;

    const v0, 0x7f090133

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->g:Landroid/widget/CheckBox;

    const v0, 0x7f090135

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->h:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public bridge synthetic c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;
    .locals 0

    check-cast p2, Ljava/lang/String;

    invoke-virtual {p0, p1, p2}, Lcom/ape/offlinescriptmanager/view/c/e/a;->n(Lb/h/a/a/c/a;Ljava/lang/String;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public m(Z)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->g:Landroid/widget/CheckBox;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/4 p1, 0x4

    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->g:Landroid/widget/CheckBox;

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->o()Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setChecked(Z)V

    return-void
.end method

.method public n(Lb/h/a/a/c/a;Ljava/lang/String;)Landroid/view/View;
    .locals 1

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->i:Ljava/lang/String;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->g:Landroid/widget/CheckBox;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/c/e/a$a;

    invoke-direct {v0, p0, p1}, Lcom/ape/offlinescriptmanager/view/c/e/a$a;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/a;Lb/h/a/a/c/a;)V

    invoke-virtual {p2, v0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    invoke-virtual {p1}, Lb/h/a/a/c/a;->l()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->f:Landroid/view/View;

    const p2, 0x7f090036

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x4

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->h:Landroid/widget/TextView;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->i:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a;->f:Landroid/view/View;

    return-object p1
.end method

.method public o(Z)V
    .locals 1

    iget-object v0, p0, Lb/h/a/a/c/a$a;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->h()Lb/h/a/a/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/h/a/a/c/a;->j()Lb/h/a/a/c/a$a;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/view/c/e/b;

    invoke-virtual {v0, p1}, Lcom/ape/offlinescriptmanager/view/c/e/b;->L(Z)V

    return-void
.end method
