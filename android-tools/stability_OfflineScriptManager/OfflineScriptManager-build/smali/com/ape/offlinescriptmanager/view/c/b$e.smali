.class Lcom/ape/offlinescriptmanager/view/c/b$e;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/jude/easyrecyclerview/d/d$e;


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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b$e;->a:Lcom/ape/offlinescriptmanager/view/c/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)Z
    .locals 3

    new-instance v0, Lcom/ape/offlinescriptmanager/view/a/a;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/b$e;->a:Lcom/ape/offlinescriptmanager/view/c/b;

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/c/b$e;->a:Lcom/ape/offlinescriptmanager/view/c/b;

    iget-object v2, v2, Lcom/ape/offlinescriptmanager/view/c/b;->c0:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lb/b/a/a/d/f;

    invoke-direct {v0, v1, p1}, Lcom/ape/offlinescriptmanager/view/a/a;-><init>(Landroid/content/Context;Lb/b/a/a/d/f;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/view/a/a;->e()V

    const/4 p1, 0x0

    return p1
.end method
