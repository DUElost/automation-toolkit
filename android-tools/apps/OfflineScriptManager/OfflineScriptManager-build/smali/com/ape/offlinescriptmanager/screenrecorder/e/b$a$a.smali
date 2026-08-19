.class Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/PopupMenu$OnMenuItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 2

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    const v0, 0x7f090096

    if-eq p1, v0, :cond_2

    const v0, 0x7f0900c6

    if-eq p1, v0, :cond_1

    const v0, 0x7f090178

    if-eq p1, v0, :cond_0

    goto/16 :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->w(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Edit video for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object v1, v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object v0

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/EditVideoActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->y(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget v1, v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->c:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->b()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "edit_video"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->z(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Lcom/ape/offlinescriptmanager/screenrecorder/d;

    move-result-object v0

    const/16 v1, 0x3ec

    invoke-virtual {v0, p1, v1}, Landroid/app/Fragment;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;->a:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->x(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;I)V

    :goto_0
    const/4 p1, 0x1

    return p1
.end method
