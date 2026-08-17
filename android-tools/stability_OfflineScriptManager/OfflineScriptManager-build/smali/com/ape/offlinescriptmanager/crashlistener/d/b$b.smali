.class Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/d/b;->l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;

.field final synthetic c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/d/b;Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->w(Lcom/ape/offlinescriptmanager/crashlistener/d/b;)Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->z(Lcom/ape/offlinescriptmanager/crashlistener/d/b;)Ljava/util/ArrayList;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;

    invoke-virtual {v2}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/crashlistener/d/a;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;->c()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const-string v1, "com.ape.offlinescriptmanager.fileprovider"

    invoke-static {p1, v1, v0}, Landroidx/core/content/FileProvider;->e(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->w(Lcom/ape/offlinescriptmanager/crashlistener/d/b;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v2, p1}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->w(Lcom/ape/offlinescriptmanager/crashlistener/d/b;)Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
