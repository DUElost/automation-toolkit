.class public abstract Landroidx/fragment/app/i;
.super Landroidx/viewpager/widget/a;
.source ""


# instance fields
.field private final b:Landroidx/fragment/app/f;

.field private c:Landroidx/fragment/app/j;

.field private d:Landroidx/fragment/app/Fragment;


# direct methods
.method public constructor <init>(Landroidx/fragment/app/f;)V
    .locals 1

    invoke-direct {p0}, Landroidx/viewpager/widget/a;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    iput-object v0, p0, Landroidx/fragment/app/i;->d:Landroidx/fragment/app/Fragment;

    iput-object p1, p0, Landroidx/fragment/app/i;->b:Landroidx/fragment/app/f;

    return-void
.end method

.method private static r(IJ)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "android:switcher:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, ":"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public a(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 0

    iget-object p1, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    if-nez p1, :cond_0

    iget-object p1, p0, Landroidx/fragment/app/i;->b:Landroidx/fragment/app/f;

    invoke-virtual {p1}, Landroidx/fragment/app/f;->a()Landroidx/fragment/app/j;

    move-result-object p1

    iput-object p1, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    :cond_0
    iget-object p1, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    check-cast p3, Landroidx/fragment/app/Fragment;

    invoke-virtual {p1, p3}, Landroidx/fragment/app/j;->g(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/j;

    return-void
.end method

.method public b(Landroid/view/ViewGroup;)V
    .locals 0

    iget-object p1, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroidx/fragment/app/j;->f()V

    const/4 p1, 0x0

    iput-object p1, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    :cond_0
    return-void
.end method

.method public g(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 4

    iget-object v0, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    if-nez v0, :cond_0

    iget-object v0, p0, Landroidx/fragment/app/i;->b:Landroidx/fragment/app/f;

    invoke-virtual {v0}, Landroidx/fragment/app/f;->a()Landroidx/fragment/app/j;

    move-result-object v0

    iput-object v0, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    :cond_0
    invoke-virtual {p0, p2}, Landroidx/fragment/app/i;->q(I)J

    move-result-wide v0

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getId()I

    move-result v2

    invoke-static {v2, v0, v1}, Landroidx/fragment/app/i;->r(IJ)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Landroidx/fragment/app/i;->b:Landroidx/fragment/app/f;

    invoke-virtual {v3, v2}, Landroidx/fragment/app/f;->d(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object p1, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    invoke-virtual {p1, v2}, Landroidx/fragment/app/j;->d(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/j;

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p2}, Landroidx/fragment/app/i;->p(I)Landroidx/fragment/app/Fragment;

    move-result-object v2

    iget-object p2, p0, Landroidx/fragment/app/i;->c:Landroidx/fragment/app/j;

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getId()I

    move-result v3

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getId()I

    move-result p1

    invoke-static {p1, v0, v1}, Landroidx/fragment/app/i;->r(IJ)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, v3, v2, p1}, Landroidx/fragment/app/j;->b(ILandroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/j;

    :goto_0
    iget-object p1, p0, Landroidx/fragment/app/i;->d:Landroidx/fragment/app/Fragment;

    if-eq v2, p1, :cond_2

    const/4 p1, 0x0

    invoke-virtual {v2, p1}, Landroidx/fragment/app/Fragment;->c1(Z)V

    invoke-virtual {v2, p1}, Landroidx/fragment/app/Fragment;->h1(Z)V

    :cond_2
    return-object v2
.end method

.method public h(Landroid/view/View;Ljava/lang/Object;)Z
    .locals 0

    check-cast p2, Landroidx/fragment/app/Fragment;

    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->F()Landroid/view/View;

    move-result-object p2

    if-ne p2, p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method public j(Landroid/os/Parcelable;Ljava/lang/ClassLoader;)V
    .locals 0

    return-void
.end method

.method public k()Landroid/os/Parcelable;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public l(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 0

    check-cast p3, Landroidx/fragment/app/Fragment;

    iget-object p1, p0, Landroidx/fragment/app/i;->d:Landroidx/fragment/app/Fragment;

    if-eq p3, p1, :cond_1

    if-eqz p1, :cond_0

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroidx/fragment/app/Fragment;->c1(Z)V

    iget-object p1, p0, Landroidx/fragment/app/i;->d:Landroidx/fragment/app/Fragment;

    invoke-virtual {p1, p2}, Landroidx/fragment/app/Fragment;->h1(Z)V

    :cond_0
    const/4 p1, 0x1

    invoke-virtual {p3, p1}, Landroidx/fragment/app/Fragment;->c1(Z)V

    invoke-virtual {p3, p1}, Landroidx/fragment/app/Fragment;->h1(Z)V

    iput-object p3, p0, Landroidx/fragment/app/i;->d:Landroidx/fragment/app/Fragment;

    :cond_1
    return-void
.end method

.method public n(Landroid/view/ViewGroup;)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getId()I

    move-result p1

    const/4 v0, -0x1

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ViewPager with adapter "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, " requires a view id"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public abstract p(I)Landroidx/fragment/app/Fragment;
.end method

.method public q(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method
