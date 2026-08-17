.class Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/ServiceConnection;


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
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0

    check-cast p2, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$e;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-virtual {p2}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$e;->a()Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->a(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->b(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Z)Z

    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->a(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->b(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Z)Z

    return-void
.end method
