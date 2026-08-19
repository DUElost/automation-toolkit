.class Lcom/ape/offlinescriptmanager/view/testpoint/a$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/jude/easyrecyclerview/d/d$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/testpoint/a;->r1(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/view/testpoint/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/testpoint/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$c;->a:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 3

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/testcase/b;->p1()Lcom/ape/offlinescriptmanager/view/testcase/b;

    move-result-object v0

    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$c;->a:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    iget-object v2, v2, Lcom/ape/offlinescriptmanager/view/testpoint/a;->e0:Ljava/util/ArrayList;

    invoke-virtual {v2, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/io/Serializable;

    const-string v2, "TEST_POINT"

    invoke-virtual {v1, v2, p1}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    invoke-virtual {v0, v1}, Landroidx/fragment/app/Fragment;->Z0(Landroid/os/Bundle;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testpoint/a$c;->a:Lcom/ape/offlinescriptmanager/view/testpoint/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->s()Landroidx/fragment/app/f;

    move-result-object p1

    invoke-virtual {p1}, Landroidx/fragment/app/f;->a()Landroidx/fragment/app/j;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroidx/fragment/app/j;->c(Ljava/lang/String;)Landroidx/fragment/app/j;

    const v1, 0x7f090194

    invoke-virtual {p1, v1, v0}, Landroidx/fragment/app/j;->h(ILandroidx/fragment/app/Fragment;)Landroidx/fragment/app/j;

    invoke-virtual {p1}, Landroidx/fragment/app/j;->e()I

    return-void
.end method
