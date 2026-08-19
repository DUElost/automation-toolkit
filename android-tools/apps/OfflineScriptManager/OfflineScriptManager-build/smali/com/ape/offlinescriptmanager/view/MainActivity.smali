.class public Lcom/ape/offlinescriptmanager/view/MainActivity;
.super Landroidx/appcompat/app/c;
.source ""

# interfaces
.implements Landroidx/appcompat/widget/Toolbar$f;
.implements Lb/b/a/b/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/view/MainActivity$c;
    }
.end annotation


# static fields
.field private static final x:Ljava/lang/String;


# instance fields
.field private q:Landroidx/viewpager/widget/ViewPager;

.field private r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

.field private s:Landroidx/appcompat/widget/Toolbar;

.field private t:Landroidx/fragment/app/Fragment;

.field private u:Landroidx/fragment/app/Fragment;

.field private v:Ljava/lang/String;

.field private w:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/ape/offlinescriptmanager/view/MainActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/view/MainActivity;->x:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroidx/appcompat/app/c;-><init>()V

    const-string v0, "tab_task"

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->v:Ljava/lang/String;

    const-string v0, "tab_result"

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->w:Ljava/lang/String;

    return-void
.end method

.method static synthetic L()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/view/MainActivity;->x:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic M(Lcom/ape/offlinescriptmanager/view/MainActivity;)Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    return-object p0
.end method

.method static synthetic N(Lcom/ape/offlinescriptmanager/view/MainActivity;)Landroidx/viewpager/widget/ViewPager;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->q:Landroidx/viewpager/widget/ViewPager;

    return-object p0
.end method

.method private O(Landroid/os/Bundle;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Bundle;",
            ")",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    if-nez p1, :cond_0

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/b;->m1()Lcom/ape/offlinescriptmanager/view/c/b;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->t:Landroidx/fragment/app/Fragment;

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/b/a;->m1()Lcom/ape/offlinescriptmanager/view/b/a;

    move-result-object p1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->v:Ljava/lang/String;

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroidx/fragment/app/f;->d(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->t:Landroidx/fragment/app/Fragment;

    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->w:Ljava/lang/String;

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/fragment/app/f;->d(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->u:Landroidx/fragment/app/Fragment;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->t:Landroidx/fragment/app/Fragment;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->u:Landroidx/fragment/app/Fragment;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object v0
.end method

.method private P()V
    .locals 6

    const v0, 0x7f09010a

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Lcom/aurelhubert/ahbottomnavigation/a;

    const v2, 0x7f0f02df

    const v3, 0x7f080081

    const v4, 0x7f060018

    invoke-direct {v1, v2, v3, v4}, Lcom/aurelhubert/ahbottomnavigation/a;-><init>(III)V

    new-instance v2, Lcom/aurelhubert/ahbottomnavigation/a;

    const v3, 0x7f0f0281

    const v5, 0x7f08006c

    invoke-direct {v2, v3, v5, v4}, Lcom/aurelhubert/ahbottomnavigation/a;-><init>(III)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    invoke-virtual {v1, v0}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->f(Ljava/util/List;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    const v1, 0x7f0601b5

    invoke-static {p0, v1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->setDefaultBackgroundColor(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    invoke-static {p0, v4}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->setAccentColor(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    const v1, 0x7f06001b

    invoke-static {p0, v1}, Landroidx/core/content/a;->b(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->setInactiveColor(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->r:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;

    new-instance v1, Lcom/ape/offlinescriptmanager/view/MainActivity$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/view/MainActivity$b;-><init>(Lcom/ape/offlinescriptmanager/view/MainActivity;)V

    invoke-virtual {v0, v1}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;->setOnTabSelectedListener(Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$g;)V

    return-void
.end method

.method private Q(Landroid/os/Bundle;)V
    .locals 1

    const v0, 0x7f0c0022

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->setContentView(I)V

    const v0, 0x7f0901ba

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/Toolbar;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->s:Landroidx/appcompat/widget/Toolbar;

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->I(Landroidx/appcompat/widget/Toolbar;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->s:Landroidx/appcompat/widget/Toolbar;

    invoke-virtual {v0, p0}, Landroidx/appcompat/widget/Toolbar;->setOnMenuItemClickListener(Landroidx/appcompat/widget/Toolbar$f;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/view/MainActivity;->P()V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/MainActivity;->R(Landroid/os/Bundle;)V

    return-void
.end method

.method private R(Landroid/os/Bundle;)V
    .locals 2

    const v0, 0x7f09010c

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/viewpager/widget/ViewPager;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->q:Landroidx/viewpager/widget/ViewPager;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroidx/viewpager/widget/ViewPager;->setOffscreenPageLimit(I)V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/MainActivity;->O(Landroid/os/Bundle;)Ljava/util/List;

    move-result-object p1

    new-instance v0, Lcom/ape/offlinescriptmanager/view/MainActivity$c;

    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Lcom/ape/offlinescriptmanager/view/MainActivity$c;-><init>(Landroidx/fragment/app/f;Ljava/util/List;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->q:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {p1, v0}, Landroidx/viewpager/widget/ViewPager;->setAdapter(Landroidx/viewpager/widget/a;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->q:Landroidx/viewpager/widget/ViewPager;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/MainActivity$a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/MainActivity$a;-><init>(Lcom/ape/offlinescriptmanager/view/MainActivity;)V

    invoke-virtual {p1, v0}, Landroidx/viewpager/widget/ViewPager;->c(Landroidx/viewpager/widget/ViewPager$j;)V

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    invoke-static {p0}, Lxcrash/j;->b(Landroid/content/Context;)I

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onCreate(Landroid/os/Bundle;)V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/MainActivity;->Q(Landroid/os/Bundle;)V

    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    invoke-virtual {p0}, Landroidx/appcompat/app/c;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const v1, 0x7f0d0003

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    const/4 p1, 0x1

    return p1
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Landroidx/appcompat/app/c;->onDestroy()V

    return-void
.end method

.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 1

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    const v0, 0x7f09001b

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object p1

    const-string v0, "uiautomator"

    invoke-virtual {p1, v0}, Lcom/ape/offlinescriptmanager/utils/a;->f(Ljava/lang/String;)V

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/a;->c(Landroid/content/Context;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object p1

    const-class v0, Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-virtual {p1, v0}, Lcom/ape/offlinescriptmanager/utils/a;->d(Ljava/lang/Class;)Z

    move-result p1

    if-eqz p1, :cond_1

    sget-object p1, Lcom/ape/offlinescriptmanager/view/MainActivity;->x:Ljava/lang/String;

    const-string v0, "stop service"

    invoke-static {p1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    sget-object p1, Lcom/ape/offlinescriptmanager/view/MainActivity;->x:Ljava/lang/String;

    const-string v0, "start service"

    invoke-static {p1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->q(Landroid/app/Activity;)V

    :goto_0
    const/4 p1, 0x1

    return p1
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onSaveInstanceState(Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->v:Ljava/lang/String;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->t:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->E()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->w:Ljava/lang/String;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/MainActivity;->u:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->E()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
