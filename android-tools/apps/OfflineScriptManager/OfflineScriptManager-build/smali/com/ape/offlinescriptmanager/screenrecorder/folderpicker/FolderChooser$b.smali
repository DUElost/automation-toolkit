.class Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->n(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Landroid/widget/EditText;

.field final synthetic c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;->b:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;->b:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p2

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-static {p2, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->c(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Ljava/lang/String;)Z

    :cond_0
    return-void
.end method
