.class Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->S()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->M(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lcom/ape/offlinescriptmanager/view/testcase/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/jude/easyrecyclerview/d/d;->C()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->M(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lcom/ape/offlinescriptmanager/view/testcase/a;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->L(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lb/b/a/a/d/g;

    move-result-object v1

    invoke-virtual {v1}, Lb/b/a/a/d/g;->e()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/jude/easyrecyclerview/d/d;->A(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$h;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->M(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lcom/ape/offlinescriptmanager/view/testcase/a;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method
