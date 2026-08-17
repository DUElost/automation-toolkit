.class Lcom/ape/offlinescriptmanager/view/MainActivity$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroidx/viewpager/widget/ViewPager$j;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/MainActivity;->R(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/MainActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/MainActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity$a;->b:Lcom/ape/offlinescriptmanager/view/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public c(IFI)V
    .locals 0

    return-void
.end method

.method public f(I)V
    .locals 0

    return-void
.end method

.method public j(I)V
    .locals 3

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/MainActivity;->L()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onPageSelected = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity$a;->b:Lcom/ape/offlinescriptmanager/view/MainActivity;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/MainActivity;->M(Lcom/ape/offlinescriptmanager/view/MainActivity;)Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->m(IZ)V

    return-void
.end method
