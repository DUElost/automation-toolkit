.class Lcom/ape/offlinescriptmanager/view/a/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/a/a/f$m;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/a/a;->e()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/CheckBox;

.field final synthetic b:Landroid/widget/EditText;

.field final synthetic c:Landroid/widget/EditText;

.field final synthetic d:Lcom/ape/offlinescriptmanager/view/a/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/a/a;Landroid/widget/CheckBox;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->d:Lcom/ape/offlinescriptmanager/view/a/a;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->a:Landroid/widget/CheckBox;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->b:Landroid/widget/EditText;

    iput-object p4, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->c:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lb/a/a/f;Lb/a/a/b;)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->d:Lcom/ape/offlinescriptmanager/view/a/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/a/a;->a(Lcom/ape/offlinescriptmanager/view/a/a;)Lb/b/a/a/d/f;

    move-result-object p1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->a:Landroid/widget/CheckBox;

    invoke-virtual {p2}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p2

    invoke-virtual {p1, p2}, Lb/b/a/a/d/f;->n(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->d:Lcom/ape/offlinescriptmanager/view/a/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/a/a;->a(Lcom/ape/offlinescriptmanager/view/a/a;)Lb/b/a/a/d/f;

    move-result-object p1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->b:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lb/b/a/a/d/f;->o(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->d:Lcom/ape/offlinescriptmanager/view/a/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/a/a;->a(Lcom/ape/offlinescriptmanager/view/a/a;)Lb/b/a/a/d/f;

    move-result-object p1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->c:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    invoke-virtual {p1, p2}, Lb/b/a/a/d/f;->w(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/a/a$a;->d:Lcom/ape/offlinescriptmanager/view/a/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/a/a;->a(Lcom/ape/offlinescriptmanager/view/a/a;)Lb/b/a/a/d/f;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/view/a/a;->b(Lcom/ape/offlinescriptmanager/view/a/a;Lb/b/a/a/d/f;)V

    return-void
.end method
