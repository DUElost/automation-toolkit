.class Lcom/ape/offlinescriptmanager/view/c/b$d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/jude/easyrecyclerview/d/d$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/b;->p1(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/view/c/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b$d;->a:Lcom/ape/offlinescriptmanager/view/c/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b$d;->a:Lcom/ape/offlinescriptmanager/view/c/b;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/b$d;->a:Lcom/ape/offlinescriptmanager/view/c/b;

    iget-object v1, v1, Lcom/ape/offlinescriptmanager/view/c/b;->c0:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lb/b/a/a/d/f;

    invoke-virtual {p1}, Lb/b/a/a/d/f;->e()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/view/testpoint/TaskDetailActivity;->M(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method
