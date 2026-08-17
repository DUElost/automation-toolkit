.class Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$e;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/FileFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "e"
.end annotation


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$e;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)V

    return-void
.end method


# virtual methods
.method public accept(Ljava/io/File;)Z
    .locals 1

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->isHidden()Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
