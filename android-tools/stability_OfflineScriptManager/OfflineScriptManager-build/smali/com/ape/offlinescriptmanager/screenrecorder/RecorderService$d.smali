.class Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;
.super Landroid/media/projection/MediaProjection$Callback;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {p0}, Landroid/media/projection/MediaProjection$Callback;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V

    return-void
.end method


# virtual methods
.method public onStop()V
    .locals 2

    const-string v0, "SCREENRECORDER"

    const-string v1, "Recording Stopped"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService$d;->a:Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;->d(Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;)V

    return-void
.end method
