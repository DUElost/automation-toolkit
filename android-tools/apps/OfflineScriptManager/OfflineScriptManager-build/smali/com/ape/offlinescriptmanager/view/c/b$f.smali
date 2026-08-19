.class Lcom/ape/offlinescriptmanager/view/c/b$f;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/b;->n1()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/c/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/b$f;->b:Lcom/ape/offlinescriptmanager/view/c/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    invoke-static {}, Lb/b/a/b/b/b;->d()Lb/b/a/b/b/b;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/b/b/b;->f()Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/b$f;->b:Lcom/ape/offlinescriptmanager/view/c/b;

    iget-object v1, v1, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {v1}, Lcom/jude/easyrecyclerview/d/d;->C()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/b$f;->b:Lcom/ape/offlinescriptmanager/view/c/b;

    iget-object v1, v1, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {v1, v0}, Lcom/jude/easyrecyclerview/d/d;->A(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/b$f;->b:Lcom/ape/offlinescriptmanager/view/c/b;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/c/b;->a0:Lcom/ape/offlinescriptmanager/view/c/d;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method
