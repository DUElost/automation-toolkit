.class Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->Y()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Landroid/widget/ArrayAdapter;

.field final synthetic c:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;Landroid/widget/ArrayAdapter;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->c:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->b:Landroid/widget/ArrayAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemSelected(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    check-cast p1, Landroid/widget/Spinner;

    invoke-virtual {p1, p3}, Landroid/widget/Spinner;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->c:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->O(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;)Landroid/widget/Spinner;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/Spinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->b:Landroid/widget/ArrayAdapter;

    invoke-virtual {p3}, Landroid/widget/ArrayAdapter;->clear()V

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->b:Landroid/widget/ArrayAdapter;

    iget-object p4, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->c:Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;

    invoke-static {p4, p2, p1}, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;->P(Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    invoke-virtual {p3, p1}, Landroid/widget/ArrayAdapter;->addAll(Ljava/util/Collection;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/TestCaseEditActivity$c;->b:Landroid/widget/ArrayAdapter;

    invoke-virtual {p1}, Landroid/widget/ArrayAdapter;->notifyDataSetChanged()V

    return-void
.end method

.method public onNothingSelected(Landroid/widget/AdapterView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;)V"
        }
    .end annotation

    return-void
.end method
