.class public Lcom/ape/offlinescriptmanager/view/testcase/c;
.super Lcom/jude/easyrecyclerview/d/a;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/jude/easyrecyclerview/d/a<",
        "Lb/b/a/a/d/c;",
        ">;",
        "Landroid/view/View$OnClickListener;"
    }
.end annotation


# instance fields
.field private A:Landroid/widget/TextView;

.field private B:Landroid/widget/CheckBox;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/widget/TextView;

.field private z:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/d/a;-><init>(Landroid/view/View;)V

    const v0, 0x7f0901d0

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->u:Landroid/widget/TextView;

    const v0, 0x7f09019b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->v:Landroid/widget/TextView;

    const v0, 0x7f090028

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->w:Landroid/widget/TextView;

    const v0, 0x7f09014c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->x:Landroid/widget/TextView;

    const v0, 0x7f090082

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->y:Landroid/widget/TextView;

    const v0, 0x7f090123

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->z:Landroid/widget/TextView;

    const v0, 0x7f090099

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->A:Landroid/widget/TextView;

    const v0, 0x7f090199

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/CheckBox;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->B:Landroid/widget/CheckBox;

    return-void
.end method


# virtual methods
.method public bridge synthetic N(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lb/b/a/a/d/c;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/c;->O(Lb/b/a/a/d/c;)V

    return-void
.end method

.method public O(Lb/b/a/a/d/c;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/jude/easyrecyclerview/d/a;->N(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->u:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->v:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->a()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->w:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->x:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->k()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->y:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->k()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->z:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->A:Landroid/widget/TextView;

    invoke-interface {p1}, Lb/b/a/a/d/c;->i()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->B:Landroid/widget/CheckBox;

    invoke-interface {p1}, Lb/b/a/a/d/c;->j()Z

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/c;->B:Landroid/widget/CheckBox;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setClickable(Z)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 0

    return-void
.end method
