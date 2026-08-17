.class Lcom/ape/offlinescriptmanager/view/testcase/a$b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testcase/a$b;->R(Lb/b/a/a/d/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->x:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/a;->U(Lcom/ape/offlinescriptmanager/view/testcase/a;)Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/view/testcase/a$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->O(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/ImageButton;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/ImageButton;->getTag()Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    invoke-interface {v0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/a$a;->l(I)V

    :cond_0
    return-void
.end method
