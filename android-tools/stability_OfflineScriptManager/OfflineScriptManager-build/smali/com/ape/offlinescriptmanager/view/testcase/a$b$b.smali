.class Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/view/testcase/a$b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "b"
.end annotation


# instance fields
.field private b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

.field final synthetic c:Lcom/ape/offlinescriptmanager/view/testcase/a$b;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/a$b;Lcom/ape/offlinescriptmanager/view/testcase/a$b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;->c:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;->c:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->x:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/a;->U(Lcom/ape/offlinescriptmanager/view/testcase/a;)Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/view/testcase/a$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->P(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getTag()Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->P(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->Q(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/EditText;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, p1, v1, v2}, Lcom/ape/offlinescriptmanager/view/testcase/a$a;->e(ILjava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
