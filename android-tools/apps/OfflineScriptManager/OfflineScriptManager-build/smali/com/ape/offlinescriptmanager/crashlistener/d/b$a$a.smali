.class Lcom/ape/offlinescriptmanager/crashlistener/d/b$a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/PopupMenu$OnMenuItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a$a;->a:Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 1

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    const v0, 0x7f090096

    if-eq p1, v0, :cond_1

    const v0, 0x7f090178

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a$a;->a:Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->x(Lcom/ape/offlinescriptmanager/crashlistener/d/b;I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a$a;->a:Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/crashlistener/d/b$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->y(Lcom/ape/offlinescriptmanager/crashlistener/d/b;I)V

    :goto_0
    const/4 p1, 0x1

    return p1
.end method
