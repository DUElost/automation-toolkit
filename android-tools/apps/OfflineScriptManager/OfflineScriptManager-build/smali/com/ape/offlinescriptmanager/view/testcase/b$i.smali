.class Lcom/ape/offlinescriptmanager/view/testcase/b$i;
.super Lb/a/a/f$e;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testcase/b;->y1(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/Spinner;

.field final synthetic b:Landroid/widget/EditText;

.field final synthetic c:Landroid/widget/CheckBox;

.field final synthetic d:Landroid/widget/Spinner;

.field final synthetic e:Landroid/widget/Spinner;

.field final synthetic f:Landroid/widget/Spinner;

.field final synthetic g:Landroid/widget/EditText;

.field final synthetic h:I

.field final synthetic i:Lcom/ape/offlinescriptmanager/view/testcase/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/b;Landroid/widget/Spinner;Landroid/widget/EditText;Landroid/widget/CheckBox;Landroid/widget/Spinner;Landroid/widget/Spinner;Landroid/widget/Spinner;Landroid/widget/EditText;I)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->i:Lcom/ape/offlinescriptmanager/view/testcase/b;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->a:Landroid/widget/Spinner;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->b:Landroid/widget/EditText;

    iput-object p4, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->c:Landroid/widget/CheckBox;

    iput-object p5, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->d:Landroid/widget/Spinner;

    iput-object p6, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->e:Landroid/widget/Spinner;

    iput-object p7, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->f:Landroid/widget/Spinner;

    iput-object p8, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->g:Landroid/widget/EditText;

    iput p9, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->h:I

    invoke-direct {p0}, Lb/a/a/f$e;-><init>()V

    return-void
.end method


# virtual methods
.method public b(Lb/a/a/f;)V
    .locals 0

    invoke-super {p0, p1}, Lb/a/a/f$e;->b(Lb/a/a/f;)V

    return-void
.end method

.method public d(Lb/a/a/f;)V
    .locals 7

    invoke-super {p0, p1}, Lb/a/a/f$e;->d(Lb/a/a/f;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->a:Landroid/widget/Spinner;

    invoke-virtual {p1}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->c:Landroid/widget/CheckBox;

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->d:Landroid/widget/Spinner;

    invoke-virtual {v2}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->e:Landroid/widget/Spinner;

    invoke-virtual {v3}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->f:Landroid/widget/Spinner;

    invoke-virtual {v4}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->g:Landroid/widget/EditText;

    invoke-virtual {v5}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "uiautomator2"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    new-instance p1, Lb/b/a/a/d/i;

    invoke-direct {p1}, Lb/b/a/a/d/i;-><init>()V

    :goto_0
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/g;->m(I)V

    invoke-virtual {p1, v1}, Lb/b/a/a/d/g;->l(Z)V

    invoke-virtual {p1, v2}, Lb/b/a/a/d/e;->p(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->i:Lcom/ape/offlinescriptmanager/view/testcase/b;

    invoke-static {v0, v2}, Lcom/ape/offlinescriptmanager/view/testcase/b;->o1(Lcom/ape/offlinescriptmanager/view/testcase/b;Ljava/lang/String;)Lb/b/a/a/a/a;

    move-result-object v0

    iget-object v0, v0, Lb/b/a/a/a/a;->e:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lb/b/a/a/d/e;->r(Ljava/lang/String;)V

    invoke-virtual {p1, v3}, Lb/b/a/a/d/e;->q(Ljava/lang/String;)V

    invoke-virtual {p1, v4}, Lb/b/a/a/d/e;->s(Ljava/lang/String;)V

    :goto_1
    invoke-virtual {p1, v5}, Lb/b/a/a/d/g;->g(Ljava/lang/String;)V

    goto :goto_2

    :cond_0
    const-string v6, "uiautomator"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    new-instance p1, Lb/b/a/a/d/j;

    invoke-direct {p1}, Lb/b/a/a/d/j;-><init>()V

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/g;->m(I)V

    invoke-virtual {p1, v1}, Lb/b/a/a/d/g;->l(Z)V

    invoke-virtual {p1, v2}, Lb/b/a/a/d/j;->p(Ljava/lang/String;)V

    invoke-virtual {p1, v3}, Lb/b/a/a/d/j;->o(Ljava/lang/String;)V

    invoke-virtual {p1, v4}, Lb/b/a/a/d/j;->q(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    const-string v6, "robotium"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    new-instance p1, Lb/b/a/a/d/e;

    invoke-direct {p1}, Lb/b/a/a/d/e;-><init>()V

    goto :goto_0

    :cond_2
    const/4 p1, 0x0

    :goto_2
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->i:Lcom/ape/offlinescriptmanager/view/testcase/b;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/testcase/b;->d0:Ljava/util/List;

    iget v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->h:I

    invoke-interface {v0, v1, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->i:Lcom/ape/offlinescriptmanager/view/testcase/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/testcase/b;->d0:Ljava/util/List;

    iget v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->h:I

    add-int/lit8 v0, v0, 0x1

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$i;->i:Lcom/ape/offlinescriptmanager/view/testcase/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/testcase/b;->d0:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    return-void
.end method
