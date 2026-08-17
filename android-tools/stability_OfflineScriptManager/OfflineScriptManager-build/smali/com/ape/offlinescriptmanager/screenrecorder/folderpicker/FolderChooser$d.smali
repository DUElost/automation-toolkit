.class Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->q()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Landroid/widget/CheckBox;

.field final synthetic c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Landroid/widget/CheckBox;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;->b:Landroid/widget/CheckBox;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;->b:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->d(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const/4 p2, 0x1

    const-string v0, "ext_dir_warn_donot_show_again"

    invoke-interface {p1, v0, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_0
    return-void
.end method
