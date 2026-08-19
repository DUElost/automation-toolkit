.class public Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;
.super Landroidx/appcompat/app/c;
.source ""


# instance fields
.field q:Ljava/lang/String;

.field private r:Lcom/ape/offlinescriptmanager/view/testpoint/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/appcompat/app/c;-><init>()V

    return-void
.end method

.method private L(Landroid/os/Bundle;)V
    .locals 3

    const p1, 0x7f0c0026

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->setContentView(I)V

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/testpoint/a;->n1()Lcom/ape/offlinescriptmanager/view/testpoint/a;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->r:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->q:Ljava/lang/String;

    const-string v1, "TASK"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->r:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    invoke-virtual {v0, p1}, Landroidx/fragment/app/Fragment;->Z0(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object p1

    invoke-virtual {p1}, Landroidx/fragment/app/f;->a()Landroidx/fragment/app/j;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->r:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    const v1, 0x7f090194

    const-string v2, "TaskFragment"

    invoke-virtual {p1, v1, v0, v2}, Landroidx/fragment/app/j;->i(ILandroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/j;

    invoke-virtual {p1}, Landroidx/fragment/app/j;->e()I

    return-void
.end method

.method public static M(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "intent_key_task"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 1

    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/fragment/app/f;->e()I

    move-result v0

    if-gtz v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/fragment/app/f;->h()V

    :goto_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "intent_key_task"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->q:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->L(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Landroidx/appcompat/app/c;->onDestroy()V

    return-void
.end method
