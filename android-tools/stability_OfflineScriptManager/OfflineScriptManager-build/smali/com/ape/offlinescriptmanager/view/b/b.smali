.class public Lcom/ape/offlinescriptmanager/view/b/b;
.super Lcom/jude/easyrecyclerview/d/a;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/jude/easyrecyclerview/d/a<",
        "Lb/b/a/a/d/f;",
        ">;",
        "Landroid/view/View$OnClickListener;"
    }
.end annotation


# instance fields
.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/d/a;-><init>(Landroid/view/View;)V

    const v0, 0x7f090195

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/b/b;->u:Landroid/widget/TextView;

    const v0, 0x7f090196

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/b/b;->v:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public bridge synthetic N(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lb/b/a/a/d/f;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/b/b;->O(Lb/b/a/a/d/f;)V

    return-void
.end method

.method public O(Lb/b/a/a/d/f;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/jude/easyrecyclerview/d/a;->N(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/b/b;->u:Landroid/widget/TextView;

    invoke-virtual {p1}, Lb/b/a/a/d/f;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/b/b;->v:Landroid/widget/TextView;

    invoke-virtual {p1}, Lb/b/a/a/d/f;->l()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 0

    return-void
.end method
