.class Lcom/ape/offlinescriptmanager/view/testpoint/a$g;
.super Lb/a/a/f$e;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testpoint/a;->u1(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lb/b/a/a/d/h;

.field final synthetic b:Landroid/widget/EditText;

.field final synthetic c:Landroid/widget/EditText;

.field final synthetic d:Landroid/widget/CheckBox;

.field final synthetic e:I

.field final synthetic f:Lcom/ape/offlinescriptmanager/view/testpoint/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;Lb/b/a/a/d/h;Landroid/widget/EditText;Landroid/widget/EditText;Landroid/widget/CheckBox;I)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->f:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->a:Lb/b/a/a/d/h;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->b:Landroid/widget/EditText;

    iput-object p4, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->c:Landroid/widget/EditText;

    iput-object p5, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->d:Landroid/widget/CheckBox;

    iput p6, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->e:I

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
    .locals 2

    invoke-super {p0, p1}, Lb/a/a/f$e;->d(Lb/a/a/f;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->a:Lb/b/a/a/d/h;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/h;->p(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->a:Lb/b/a/a/d/h;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->c:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/h;->q(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->a:Lb/b/a/a/d/h;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->d:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/h;->o(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->f:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/testpoint/a;->e0:Ljava/util/ArrayList;

    iget v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->e:I

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->a:Lb/b/a/a/d/h;

    invoke-virtual {p1, v0, v1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->f:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/testpoint/a;->e0:Ljava/util/ArrayList;

    iget v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->e:I

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->f:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/testpoint/a;->e0:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Lb/b/a/a/d/f;->t(Ljava/util/ArrayList;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$g;->f:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->m1(Lcom/ape/offlinescriptmanager/view/testpoint/a;Lb/b/a/a/d/f;)V

    return-void
.end method
