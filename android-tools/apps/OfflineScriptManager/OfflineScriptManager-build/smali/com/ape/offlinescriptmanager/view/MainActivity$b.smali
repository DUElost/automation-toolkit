.class Lcom/ape/offlinescriptmanager/view/MainActivity$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/MainActivity;->P()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/view/MainActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/MainActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity$b;->a:Lcom/ape/offlinescriptmanager/view/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(IZ)Z
    .locals 3

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/MainActivity;->L()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onTabSelected = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " wasSelected = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/MainActivity$b;->a:Lcom/ape/offlinescriptmanager/view/MainActivity;

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/view/MainActivity;->N(Lcom/ape/offlinescriptmanager/view/MainActivity;)Landroidx/viewpager/widget/ViewPager;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroidx/viewpager/widget/ViewPager;->setCurrentItem(I)V

    :cond_0
    const/4 p1, 0x1

    return p1
.end method
