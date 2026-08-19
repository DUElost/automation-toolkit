.class Lcom/ape/offlinescriptmanager/view/testpoint/a$f;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testpoint/a;->o1()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/testpoint/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$f;->b:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$f;->b:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->C()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$f;->b:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object v1, v0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->c0:Lb/b/a/a/d/f;

    invoke-virtual {v0}, Lb/b/a/a/d/f;->i()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/jude/easyrecyclerview/d/d;->A(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$f;->b:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/view/testpoint/a;->a0:Lcom/ape/offlinescriptmanager/view/testpoint/c;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method
