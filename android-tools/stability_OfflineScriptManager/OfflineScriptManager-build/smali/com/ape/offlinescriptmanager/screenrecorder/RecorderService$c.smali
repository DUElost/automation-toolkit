.class Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$c;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Landroid/os/Looper;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$c;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$c;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    const v0, 0x7f0f0290

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$c;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->c(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V

    return-void
.end method
