.class Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->m(Landroid/net/Uri;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    new-instance v1, Landroid/app/ProgressDialog;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-direct {v1, v2}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->M(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->L(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    const-string v1, "Please wait while the video is being saved"

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->L(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    const-string v1, "Please wait"

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->L(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setIndeterminate(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->L(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    return-void
.end method
