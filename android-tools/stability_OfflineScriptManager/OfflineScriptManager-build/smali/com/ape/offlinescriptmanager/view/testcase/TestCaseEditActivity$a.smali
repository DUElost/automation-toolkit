.class Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->Y()V
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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    new-instance p1, Lb/b/a/a/d/b;

    const-string v0, ""

    invoke-direct {p1, v0, v0}, Lb/b/a/a/d/b;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->L(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lb/b/a/a/d/g;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/a/d/g;->e()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->M(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lcom/ape/offlinescriptmanager/view/testcase/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/jude/easyrecyclerview/d/d;->z(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$a;->b:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->M(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Lcom/ape/offlinescriptmanager/view/testcase/a;

    move-result-object p1

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method
