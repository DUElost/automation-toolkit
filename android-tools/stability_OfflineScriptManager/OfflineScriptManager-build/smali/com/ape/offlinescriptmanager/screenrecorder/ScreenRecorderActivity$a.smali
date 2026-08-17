.class Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->L(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Landroid/media/projection/MediaProjection;

    move-result-object p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    const-class v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->M(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;Ljava/lang/Class;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->N(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Landroid/media/projection/MediaProjectionManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/media/projection/MediaProjectionManager;->createScreenCaptureIntent()Landroid/content/Intent;

    move-result-object v0

    const/16 v1, 0x3eb

    invoke-virtual {p1, v0, v1}, Landroidx/fragment/app/b;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    const-class v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->M(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;Ljava/lang/Class;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    const/4 v0, 0x0

    const-string v1, "Screen already recording"

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :cond_1
    :goto_0
    return-void
.end method
