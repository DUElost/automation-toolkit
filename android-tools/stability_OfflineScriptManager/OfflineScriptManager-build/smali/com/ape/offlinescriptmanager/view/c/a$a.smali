.class Lcom/ape/offlinescriptmanager/view/c/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/a;->r1(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/c/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object p1

    const-class v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-virtual {p1, v0}, Lcom/ape/offlinescriptmanager/utils/a;->d(Ljava/lang/Class;)Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    const-string v1, "task service already running"

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    :goto_0
    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_0
    invoke-static {}, Lb/b/a/a/c/g;->a()Lb/b/a/a/c/g;

    move-result-object p1

    const-string v1, "/sdcard/runtask.xml"

    invoke-virtual {p1, v1}, Lb/b/a/a/c/g;->d(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    const v1, 0x7f0f0256

    :goto_1
    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/g;->B(Landroid/content/Context;)Z

    move-result p1

    const/4 v0, 0x1

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    const v1, 0x7f0f0067

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/a;->l1(Lcom/ape/offlinescriptmanager/view/c/a;)Lb/h/a/a/d/a;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/e/c;->A()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    const v1, 0x7f0f0058

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/c/a;->a0:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/a;->m1(Lcom/ape/offlinescriptmanager/view/c/a;)V

    goto :goto_2

    :cond_4
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/a;->n1(Lcom/ape/offlinescriptmanager/view/c/a;)V

    :goto_2
    return-void
.end method
