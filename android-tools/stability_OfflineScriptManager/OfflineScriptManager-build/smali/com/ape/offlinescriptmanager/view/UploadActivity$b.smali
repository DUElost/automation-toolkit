.class Lcom/ape/offlinescriptmanager/view/UploadActivity$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/UploadActivity;->P()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/UploadActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/UploadActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->N(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    const v1, 0x7f0f0259

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->L(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    const v1, 0x7f0f02b7

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->R(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    const v1, 0x7f0f02d6

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->S()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->L(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->O(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v1, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;-><init>()V

    invoke-virtual {v1, p1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->k(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->n(Ljava/io/File;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/view/RunTaskService;->d:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-virtual {v2}, Lcom/ape/offlinescriptmanager/utils/m/c;->n()Ljava/util/Map;

    move-result-object v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-virtual {v1, v2, p1, v3}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->l(Ljava/util/Map;Ljava/lang/String;Landroid/content/Context;)Ljava/util/Map;

    invoke-virtual {v1, v2}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->r(Ljava/util/Map;)Z

    :cond_3
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->M(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$b;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->L(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/EditText;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
