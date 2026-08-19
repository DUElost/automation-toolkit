.class Lcom/ape/offlinescriptmanager/screenrecorder/c$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/c;->m()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/c;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c$c;->b:Lcom/ape/offlinescriptmanager/screenrecorder/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c$c;->b:Lcom/ape/offlinescriptmanager/screenrecorder/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->c(Lcom/ape/offlinescriptmanager/screenrecorder/c;)Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c$c;->b:Lcom/ape/offlinescriptmanager/screenrecorder/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->c(Lcom/ape/offlinescriptmanager/screenrecorder/c;)Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    move-result-object p1

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->T()Z

    :cond_0
    return-void
.end method
