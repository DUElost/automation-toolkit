.class public Lcom/ape/offlinescriptmanager/crashlistener/a;
.super Landroid/app/Fragment;
.source ""

# interfaces
.implements Lcom/ape/offlinescriptmanager/screenrecorder/b;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/crashlistener/a$c;
    }
.end annotation


# instance fields
.field private b:Landroidx/recyclerview/widget/RecyclerView;

.field private c:Landroid/widget/TextView;

.field private d:Landroid/content/SharedPreferences;

.field private e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/ape/offlinescriptmanager/crashlistener/a;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Fragment;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->e:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/crashlistener/a;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->e:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/crashlistener/a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/a;->h()V

    return-void
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/crashlistener/a;Ljava/lang/String;)Z
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->j(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic e(Lcom/ape/offlinescriptmanager/crashlistener/a;)Landroidx/recyclerview/widget/RecyclerView;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->b:Landroidx/recyclerview/widget/RecyclerView;

    return-object p0
.end method

.method static synthetic f(Lcom/ape/offlinescriptmanager/crashlistener/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->c:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic g(Lcom/ape/offlinescriptmanager/crashlistener/a;Ljava/util/ArrayList;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->l(Ljava/util/ArrayList;)V

    return-void
.end method

.method private h()V
    .locals 5

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    const-string v1, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-static {v0, v1}, Landroidx/core/content/a;->a(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    instance-of v0, v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {v0, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->S(Lcom/ape/offlinescriptmanager/screenrecorder/b;)V

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->R()Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->d:Landroid/content/SharedPreferences;

    const v2, 0x7f0f0066

    invoke-virtual {p0, v2}, Landroid/app/Fragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->t()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->d:Landroid/content/SharedPreferences;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->N(Landroid/content/Context;Landroid/content/SharedPreferences;)V

    :cond_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/crashlistener/a;->i([Ljava/io/File;)[Ljava/io/File;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    :cond_2
    new-instance v0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/a;)V

    const/4 v2, 0x1

    new-array v2, v2, [[Ljava/io/File;

    const/4 v3, 0x0

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v4

    new-array v4, v4, [Ljava/io/File;

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/io/File;

    aput-object v1, v2, v3

    invoke-virtual {v0, v2}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    :cond_3
    :goto_0
    return-void
.end method

.method private i([Ljava/io/File;)[Ljava/io/File;
    .locals 5

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p1, v2

    invoke-virtual {v3}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/ape/offlinescriptmanager/crashlistener/a;->j(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p1

    new-array p1, p1, [Ljava/io/File;

    invoke-interface {v0, p1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/io/File;

    return-object p1
.end method

.method private j(Ljava/lang/String;)Z
    .locals 1

    invoke-static {p1}, Ljava/net/URLConnection;->guessContentTypeFromName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string v0, "image"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private l(Ljava/util/ArrayList;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->b:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setHasFixedSize(Z)V

    new-instance v0, Landroidx/recyclerview/widget/GridLayoutManager;

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Landroidx/recyclerview/widget/GridLayoutManager;-><init>(Landroid/content/Context;I)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-direct {v1, v2, p1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;-><init>(Landroid/content/Context;Ljava/util/ArrayList;Lcom/ape/offlinescriptmanager/crashlistener/a;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {p1, v1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/crashlistener/a$b;

    invoke-direct {p1, p0, v1, v0}, Lcom/ape/offlinescriptmanager/crashlistener/a$b;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/a;Lcom/ape/offlinescriptmanager/crashlistener/d/b;Landroidx/recyclerview/widget/GridLayoutManager;)V

    invoke-virtual {v0, p1}, Landroidx/recyclerview/widget/GridLayoutManager;->W2(Landroidx/recyclerview/widget/GridLayoutManager$c;)V

    return-void
.end method


# virtual methods
.method public a(I[Ljava/lang/String;[I)V
    .locals 0

    const/16 p2, 0x2af8

    if-eq p1, p2, :cond_0

    goto :goto_0

    :cond_0
    array-length p1, p3

    if-lez p1, :cond_1

    const/4 p1, 0x0

    aget p1, p3, p1

    if-nez p1, :cond_1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/a;->h()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->b:Landroidx/recyclerview/widget/RecyclerView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->c:Landroid/widget/TextView;

    const p2, 0x7f0f02f0

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    return-void
.end method

.method public k()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Landroid/app/Fragment;->setHasOptionsMenu(Z)V

    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;Landroid/view/MenuInflater;)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroid/app/Fragment;->onCreateOptionsMenu(Landroid/view/Menu;Landroid/view/MenuInflater;)V

    const-string p2, "Refresh"

    invoke-interface {p1, p2}, Landroid/view/Menu;->add(Ljava/lang/CharSequence;)Landroid/view/MenuItem;

    move-result-object p1

    const p2, 0x7f080080

    invoke-interface {p1, p2}, Landroid/view/MenuItem;->setIcon(I)Landroid/view/MenuItem;

    const/4 p2, 0x2

    invoke-interface {p1, p2}, Landroid/view/MenuItem;->setShowAsActionFlags(I)Landroid/view/MenuItem;

    new-instance p2, Lcom/ape/offlinescriptmanager/crashlistener/a$a;

    invoke-direct {p2, p0}, Lcom/ape/offlinescriptmanager/crashlistener/a$a;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/a;)V

    invoke-interface {p1, p2}, Landroid/view/MenuItem;->setOnMenuItemClickListener(Landroid/view/MenuItem$OnMenuItemClickListener;)Landroid/view/MenuItem;

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0c0046

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090149

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroidx/recyclerview/widget/RecyclerView;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->b:Landroidx/recyclerview/widget/RecyclerView;

    const p2, 0x7f090120

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->c:Landroid/widget/TextView;

    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object p2

    invoke-static {p2}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a;->d:Landroid/content/SharedPreferences;

    return-object p1
.end method

.method public setUserVisibleHint(Z)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Fragment;->setUserVisibleHint(Z)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/a;->h()V

    :cond_0
    return-void
.end method
