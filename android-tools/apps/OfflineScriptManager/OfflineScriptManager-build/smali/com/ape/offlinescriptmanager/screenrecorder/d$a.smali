.class Lcom/ape/offlinescriptmanager/screenrecorder/d$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/MenuItem$OnMenuItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/d;->onCreateOptionsMenu(Landroid/view/Menu;Landroid/view/MenuInflater;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/screenrecorder/d;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/d;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/d$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/d$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/d;->b(Lcom/ape/offlinescriptmanager/screenrecorder/d;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->clear()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/d$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/d;->c(Lcom/ape/offlinescriptmanager/screenrecorder/d;)V

    const-string p1, "SCREENRECORDER"

    const-string v0, "Refreshing"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x0

    return p1
.end method
