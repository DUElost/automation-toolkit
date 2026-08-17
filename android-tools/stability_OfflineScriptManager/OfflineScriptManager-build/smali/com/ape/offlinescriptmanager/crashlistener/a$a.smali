.class Lcom/ape/offlinescriptmanager/crashlistener/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/MenuItem$OnMenuItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/a;->onCreateOptionsMenu(Landroid/view/Menu;Landroid/view/MenuInflater;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/crashlistener/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$a;->a:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$a;->a:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->b(Lcom/ape/offlinescriptmanager/crashlistener/a;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->clear()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$a;->a:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->c(Lcom/ape/offlinescriptmanager/crashlistener/a;)V

    const/4 p1, 0x0

    return p1
.end method
