.class Lcom/ape/offlinescriptmanager/view/testcase/b$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/jude/easyrecyclerview/d/d$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testcase/b;->w1(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/view/testcase/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$c;->a:Lcom/ape/offlinescriptmanager/view/testcase/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$c;->a:Lcom/ape/offlinescriptmanager/view/testcase/b;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->n()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/b$c;->a:Lcom/ape/offlinescriptmanager/view/testcase/b;

    iget-object v1, v1, Lcom/ape/offlinescriptmanager/view/testcase/b;->d0:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lb/b/a/a/d/g;

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->a0(Landroid/content/Context;Lb/b/a/a/d/g;)V

    return-void
.end method
