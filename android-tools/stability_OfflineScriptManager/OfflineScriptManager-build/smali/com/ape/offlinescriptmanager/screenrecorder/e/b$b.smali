.class Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

.field final synthetic c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "video position clicked: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Videos List"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".fileprovider"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->y(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Ljava/util/ArrayList;

    move-result-object v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-virtual {v3}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->b()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {p1, v0, v1}, Landroidx/core/content/FileProvider;->e(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "android.intent.action.VIEW"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v2, p1}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
