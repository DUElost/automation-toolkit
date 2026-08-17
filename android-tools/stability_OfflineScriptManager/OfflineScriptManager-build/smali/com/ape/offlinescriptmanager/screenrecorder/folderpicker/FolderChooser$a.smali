.class Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->n(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)Landroid/app/AlertDialog;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)Landroid/app/AlertDialog;

    move-result-object v0

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    :cond_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
