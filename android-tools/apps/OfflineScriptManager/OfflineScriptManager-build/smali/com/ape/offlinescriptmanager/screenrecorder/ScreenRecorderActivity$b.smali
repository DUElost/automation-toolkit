.class Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnLongClickListener;


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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$b;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLongClick(Landroid/view/View;)Z
    .locals 2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$b;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    const v0, 0x7f0f0079

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    const/4 p1, 0x1

    return p1
.end method
