.class Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/media/MediaScannerConnection$OnScanCompletedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->N(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$b;->a:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScanCompleted(Ljava/lang/String;Landroid/net/Uri;)V
    .locals 1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "SCAN COMPLETED: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "SCREENRECORDER"

    invoke-static {p2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$b;->a:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;->L(Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;)Landroid/app/ProgressDialog;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->cancel()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$b;->a:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    const/16 p2, 0x3ed

    invoke-virtual {p1, p2}, Landroid/app/Activity;->setResult(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity$b;->a:Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-virtual {p1}, Landroid/app/Activity;->finish()V

    return-void
.end method
