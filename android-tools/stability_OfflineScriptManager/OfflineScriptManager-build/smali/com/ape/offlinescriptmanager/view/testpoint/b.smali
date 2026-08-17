.class public Lcom/ape/offlinescriptmanager/view/testpoint/b;
.super Lcom/jude/easyrecyclerview/d/a;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/jude/easyrecyclerview/d/a<",
        "Lb/b/a/a/d/h;",
        ">;",
        "Landroid/view/View$OnClickListener;"
    }
.end annotation


# instance fields
.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/d/a;-><init>(Landroid/view/View;)V

    const v0, 0x7f09019e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/b;->u:Landroid/widget/TextView;

    const v0, 0x7f09019f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/b;->v:Landroid/widget/TextView;

    const v0, 0x7f09019a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/b;->w:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public bridge synthetic N(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lb/b/a/a/d/h;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/testpoint/b;->O(Lb/b/a/a/d/h;)V

    return-void
.end method

.method public O(Lb/b/a/a/d/h;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/jude/easyrecyclerview/d/a;->N(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/b;->u:Landroid/widget/TextView;

    invoke-virtual {p1}, Lb/b/a/a/d/h;->m()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/b;->v:Landroid/widget/TextView;

    invoke-virtual {p1}, Lb/b/a/a/d/h;->a()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/b;->w:Landroid/widget/TextView;

    invoke-virtual {p1}, Lb/b/a/a/d/h;->n()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lb/b/a/a/d/h;->j()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/a;->M()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f060109

    goto :goto_0

    :cond_0
    iget-object p1, p0, Landroidx/recyclerview/widget/RecyclerView$c0;->b:Landroid/view/View;

    invoke-virtual {p0}, Lcom/jude/easyrecyclerview/d/a;->M()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f060092

    :goto_0
    invoke-static {v0, v1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundColor(I)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 0

    return-void
.end method
