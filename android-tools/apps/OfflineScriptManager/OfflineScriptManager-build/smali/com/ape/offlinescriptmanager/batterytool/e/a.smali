.class public abstract Lcom/ape/offlinescriptmanager/batterytool/e/a;
.super Landroidx/fragment/app/b;
.source ""

# interfaces
.implements Landroidx/viewpager/widget/ViewPager$j;
.implements Landroid/widget/TabHost$OnTabChangeListener;


# instance fields
.field public n:Landroid/widget/Toolbar;

.field public o:Landroidx/fragment/app/FragmentTabHost;

.field public p:Landroidx/viewpager/widget/ViewPager;

.field public q:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;"
        }
    .end annotation
.end field

.field private r:Landroid/widget/HorizontalScrollView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroidx/fragment/app/b;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->q:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public abstract B()V
.end method

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

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    invoke-virtual {v0, p1}, Landroid/widget/TabHost;->setCurrentTab(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    invoke-virtual {v0}, Landroid/widget/TabHost;->getTabWidget()Landroid/widget/TabWidget;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/TabWidget;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->r:Landroid/widget/HorizontalScrollView;

    invoke-virtual {p1}, Landroid/view/View;->getX()F

    move-result v1

    float-to-int v1, v1

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    sub-int/2addr v1, v2

    invoke-virtual {p1}, Landroid/view/View;->getY()F

    move-result p1

    float-to-int p1, p1

    invoke-virtual {v0, v1, p1}, Landroid/widget/HorizontalScrollView;->scrollTo(II)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroidx/fragment/app/b;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0c0020

    invoke-virtual {p0, p1}, Landroid/app/Activity;->setContentView(I)V

    const p1, 0x7f0901ba

    invoke-virtual {p0, p1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Toolbar;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->n:Landroid/widget/Toolbar;

    const v0, 0x7f0f0049

    invoke-virtual {p1, v0}, Landroid/widget/Toolbar;->setTitle(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->n:Landroid/widget/Toolbar;

    invoke-virtual {p0, p1}, Landroid/app/Activity;->setActionBar(Landroid/widget/Toolbar;)V

    const p1, 0x7f0900e2

    invoke-virtual {p0, p1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/HorizontalScrollView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->r:Landroid/widget/HorizontalScrollView;

    const p1, 0x7f090141

    invoke-virtual {p0, p1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroidx/viewpager/widget/ViewPager;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->p:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {p1, p0}, Landroidx/viewpager/widget/ViewPager;->c(Landroidx/viewpager/widget/ViewPager$j;)V

    const p1, 0x1020012

    invoke-virtual {p0, p1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroidx/fragment/app/FragmentTabHost;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v0

    const v1, 0x1020011

    invoke-virtual {p1, p0, v0, v1}, Landroidx/fragment/app/FragmentTabHost;->g(Landroid/content/Context;Landroidx/fragment/app/f;I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    invoke-virtual {p1, p0}, Landroidx/fragment/app/FragmentTabHost;->setOnTabChangedListener(Landroid/widget/TabHost$OnTabChangeListener;)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/e/a;->B()V

    return-void
.end method

.method public onTabChanged(Ljava/lang/String;)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    invoke-virtual {p1}, Landroid/widget/TabHost;->getCurrentTab()I

    move-result p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->p:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {v0, p1}, Landroidx/viewpager/widget/ViewPager;->setCurrentItem(I)V

    return-void
.end method
