.class Lcom/ape/offlinescriptmanager/view/UploadActivity$a;
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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$a;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$a;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->L(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/EditText;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$a;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/UploadActivity;->M(Lcom/ape/offlinescriptmanager/view/UploadActivity;)Landroid/widget/TextView;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    new-instance p1, Lb/f/a/a;

    invoke-direct {p1}, Lb/f/a/a;-><init>()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/UploadActivity$a;->b:Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-virtual {p1, v0}, Lb/f/a/a;->d(Landroid/app/Activity;)Lb/f/a/a;

    const/16 v0, 0x3e9

    invoke-virtual {p1, v0}, Lb/f/a/a;->g(I)Lb/f/a/a;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lb/f/a/a;->f(Z)Lb/f/a/a;

    const-string v0, "\u6587\u4ef6\u9009\u62e9"

    invoke-virtual {p1, v0}, Lb/f/a/a;->h(Ljava/lang/String;)Lb/f/a/a;

    const-string v0, ".xml"

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/f/a/a;->e([Ljava/lang/String;)Lb/f/a/a;

    invoke-virtual {p1}, Lb/f/a/a;->c()V

    return-void
.end method
