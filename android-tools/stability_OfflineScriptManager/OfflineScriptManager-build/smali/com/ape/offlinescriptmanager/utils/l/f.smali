.class public Lcom/ape/offlinescriptmanager/utils/l/f;
.super Ljava/lang/Thread;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/utils/l/f$a;
    }
.end annotation


# instance fields
.field private b:Landroid/content/Context;

.field private c:Ljava/lang/String;

.field private volatile d:Z

.field private e:Lb/b/a/a/b/d;

.field private f:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/h;",
            ">;"
        }
    .end annotation
.end field

.field private g:Lb/b/a/a/c/f;

.field private h:Lcom/ape/offlinescriptmanager/utils/l/f$a;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/utils/l/f$a;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->c:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->e:Lb/b/a/a/b/d;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->f:Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    return-void
.end method

.method private a()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->e:Lb/b/a/a/b/d;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lb/b/a/a/b/d;->a()V

    :cond_0
    const-string v0, "close real result xml end"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    return-void
.end method

.method private b(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/h;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/h;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p2}, Ljava/util/ArrayList;->clear()V

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method private d(Lb/b/a/a/c/h;)Lb/b/a/a/b/h;
    .locals 3

    invoke-virtual {p1}, Lb/b/a/a/c/h;->f()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    new-instance v0, Lb/b/a/a/b/h;

    invoke-direct {v0}, Lb/b/a/a/b/h;-><init>()V

    invoke-virtual {p1}, Lb/b/a/a/c/h;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/b/a/a/b/h;->m(Ljava/lang/String;)V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->m()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lb/b/a/a/b/h;->n(J)V

    invoke-virtual {v0, v1, v2}, Lb/b/a/a/b/h;->l(J)V

    invoke-virtual {p1}, Lb/b/a/a/c/h;->d()I

    move-result p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    const-string v1, "regression"

    invoke-virtual {v0, v1, p1}, Lb/b/a/a/b/h;->a(Ljava/lang/String;Ljava/lang/String;)V

    sget-object p1, Lb/b/a/a/b/g;->g:Lb/b/a/a/b/g;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/h;->o(Lb/b/a/a/b/g;)V

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method private e(Lb/b/a/a/c/h;)V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {v0}, Lb/b/a/a/c/f;->g()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_2

    invoke-virtual {p1}, Lb/b/a/a/c/h;->d()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {p1, v2}, Lb/b/a/a/c/h;->i(I)V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/f;->m(Lb/b/a/a/c/h;)Lb/b/a/a/b/h;

    move-result-object v2

    iget-boolean v3, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-eqz v3, :cond_0

    return-void

    :cond_0
    invoke-virtual {v2}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v2

    sget-object v3, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    if-ne v2, v3, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method

.method private f(Lb/b/a/a/b/h;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/f;->p(Lb/b/a/a/b/h;)V

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    sget-object v1, Lb/b/a/a/b/g;->e:Lb/b/a/a/b/g;

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v0

    sget-object v1, Lb/b/a/a/b/g;->d:Lb/b/a/a/b/g;

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object p1

    sget-object v0, Lb/b/a/a/b/g;->h:Lb/b/a/a/b/g;

    invoke-virtual {p1, v0}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {p1}, Lb/b/a/a/c/f;->e()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->o()V

    :cond_2
    return-void
.end method

.method private g()V
    .locals 1

    sget-object v0, Landroid/os/Build;->SERIAL:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->c:Ljava/lang/String;

    return-void
.end method

.method private h()V
    .locals 2

    const-string v0, "load task xml file start"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    invoke-static {}, Lb/b/a/a/c/g;->a()Lb/b/a/a/c/g;

    move-result-object v0

    const-string v1, "/sdcard/runtask.xml"

    invoke-virtual {v0, v1}, Lb/b/a/a/c/g;->d(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "load task xml file fail"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->c(Ljava/lang/String;)V

    :cond_0
    const-string v0, "load task xml file end"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    return-void
.end method

.method private i(Lb/b/a/a/c/h;Lb/b/a/a/b/h;)V
    .locals 1

    if-nez p2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p2}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object p2

    sget-object v0, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    if-eq p2, v0, :cond_2

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {p2}, Lb/b/a/a/c/f;->f()I

    move-result p2

    const/4 v0, 0x1

    if-ne p2, v0, :cond_2

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {p2}, Lb/b/a/a/c/f;->d()I

    move-result p2

    if-ne p2, v0, :cond_1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/f;->e(Lb/b/a/a/c/h;)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {p2}, Lb/b/a/a/c/f;->d()I

    move-result p2

    if-nez p2, :cond_2

    invoke-virtual {p1}, Lb/b/a/a/c/h;->d()I

    move-result p2

    add-int/2addr p2, v0

    invoke-virtual {p1, p2}, Lb/b/a/a/c/h;->i(I)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->f:Ljava/util/ArrayList;

    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_2
    :goto_0
    return-void
.end method

.method private j()V
    .locals 7

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {v0}, Lb/b/a/a/c/f;->f()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {v0}, Lb/b/a/a/c/f;->d()I

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {v0}, Lb/b/a/a/c/f;->g()I

    move-result v0

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v4, v0, :cond_2

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->f:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-gtz v5, :cond_0

    goto :goto_1

    :cond_0
    iget-object v5, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->f:Ljava/util/ArrayList;

    invoke-direct {p0, v5, v2}, Lcom/ape/offlinescriptmanager/utils/l/f;->b(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->f:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->clear()V

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v3

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v1

    const-string v6, "failure have %d, regression test %d times start"

    invoke-static {v6, v5}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/l/f;->n(Ljava/util/List;)V

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v3

    const-string v6, "failure regression test %d times end"

    invoke-static {v6, v5}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-boolean v5, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-eqz v5, :cond_1

    return-void

    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    :cond_3
    return-void
.end method

.method private k()V
    .locals 2

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/e/c;->z()Lb/b/a/a/c/f;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    if-nez v0, :cond_0

    invoke-static {}, Lb/b/a/a/c/g;->a()Lb/b/a/a/c/g;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/a/c/g;->b()Lb/b/a/a/c/f;

    move-result-object v0

    :cond_0
    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->o()V

    const-string v0, "Task is null. return"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    invoke-interface {v1, v0}, Lcom/ape/offlinescriptmanager/utils/l/f$a;->c(Lb/b/a/a/c/f;)V

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {v1}, Lb/b/a/a/c/f;->a()I

    move-result v1

    if-ge v0, v1, :cond_2

    iget-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-virtual {v1}, Lb/b/a/a/c/f;->h()Ljava/util/ArrayList;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/ape/offlinescriptmanager/utils/l/f;->n(Ljava/util/List;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->j()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method private l(Lb/b/a/a/c/c;Lb/b/a/a/b/h;)V
    .locals 6

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-interface {p1}, Lb/b/a/a/c/c;->a()I

    move-result v2

    if-ge v1, v2, :cond_2

    iget-boolean v2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-eqz v2, :cond_0

    goto :goto_1

    :cond_0
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->c:Ljava/lang/String;

    invoke-interface {p1, v2}, Lb/b/a/a/c/c;->c(Ljava/lang/String;)Lb/b/a/a/b/b;

    move-result-object v2

    invoke-interface {v2, p2}, Lb/b/a/a/b/b;->a(Lb/b/a/a/b/h;)V

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    invoke-interface {v3, p1}, Lcom/ape/offlinescriptmanager/utils/l/f$a;->a(Lb/b/a/a/c/c;)V

    invoke-interface {p1}, Lb/b/a/a/c/c;->g()Z

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->b:Landroid/content/Context;

    if-eqz v3, :cond_1

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v0

    const/4 v5, 0x0

    invoke-static {v3, v4, v5, v5}, Landroid/media/MediaScannerConnection;->scanFile(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;Landroid/media/MediaScannerConnection$OnScanCompletedListener;)V

    :cond_1
    invoke-interface {p1, v2}, Lb/b/a/a/c/c;->e(Lb/b/a/a/b/b;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method

.method private m(Lb/b/a/a/c/h;)Lb/b/a/a/b/h;
    .locals 4

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->P()V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/f;->d(Lb/b/a/a/c/h;)Lb/b/a/a/b/h;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    invoke-interface {v1, v0}, Lcom/ape/offlinescriptmanager/utils/l/f$a;->b(Lb/b/a/a/b/h;)Lb/b/a/a/b/h;

    invoke-virtual {p1}, Lb/b/a/a/c/h;->f()Ljava/util/List;

    move-result-object p1

    const/4 v1, 0x0

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    iget-boolean v2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-eqz v2, :cond_0

    goto :goto_2

    :cond_0
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/c/c;

    :try_start_0
    invoke-direct {p0, v2, v0}, Lcom/ape/offlinescriptmanager/utils/l/f;->l(Lb/b/a/a/c/c;Lb/b/a/a/b/h;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v2

    sget-object v3, Lb/b/a/a/b/g;->h:Lb/b/a/a/b/g;

    invoke-virtual {v0, v3}, Lb/b/a/a/b/h;->o(Lb/b/a/a/b/g;)V

    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    :goto_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    invoke-interface {p1, v0}, Lcom/ape/offlinescriptmanager/utils/l/f$a;->d(Lb/b/a/a/b/h;)Lb/b/a/a/b/h;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/f;->f(Lb/b/a/a/b/h;)V

    return-object v0
.end method

.method private n(Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lb/b/a/a/c/h;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_4

    const/4 v2, 0x0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/b/a/a/c/h;

    invoke-virtual {v3}, Lb/b/a/a/c/h;->g()Z

    move-result v4

    if-nez v4, :cond_0

    goto :goto_3

    :cond_0
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v3}, Lb/b/a/a/c/h;->getName()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v0

    const-string v5, "runTestPoints: -------------------- %s "

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "TaskSuitRun"

    invoke-static {v5, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move v4, v0

    :goto_1
    invoke-virtual {v3}, Lb/b/a/a/c/h;->a()I

    move-result v5

    if-ge v4, v5, :cond_2

    iget-boolean v5, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-eqz v5, :cond_1

    goto :goto_2

    :cond_1
    invoke-direct {p0, v3}, Lcom/ape/offlinescriptmanager/utils/l/f;->m(Lb/b/a/a/c/h;)Lb/b/a/a/b/h;

    move-result-object v2

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_2
    :goto_2
    iget-boolean v4, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    if-eqz v4, :cond_3

    goto :goto_4

    :cond_3
    invoke-direct {p0, v3, v2}, Lcom/ape/offlinescriptmanager/utils/l/f;->i(Lb/b/a/a/c/h;Lb/b/a/a/b/h;)V

    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    :goto_4
    return-void
.end method

.method private p(Lb/b/a/a/b/h;)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->e:Lb/b/a/a/b/d;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lb/b/a/a/b/d;->g(Lb/b/a/a/b/h;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public c(Ljava/lang/String;Lb/b/a/a/c/f;)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->e:Lb/b/a/a/b/d;

    if-nez v0, :cond_0

    new-instance v0, Lb/b/a/a/b/d;

    invoke-direct {v0}, Lb/b/a/a/b/d;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->e:Lb/b/a/a/b/d;

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->e:Lb/b/a/a/b/d;

    invoke-virtual {v0, p1, p2}, Lb/b/a/a/b/d;->c(Ljava/lang/String;Lb/b/a/a/c/f;)Ljava/io/File;

    return-void
.end method

.method public o()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    const-string v0, "TaskSuitRun"

    const-string v1, "setStop"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public run()V
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->g()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/h;->b()Lcom/ape/offlinescriptmanager/utils/h;

    move-result-object v0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/h;->c()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->h()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->k()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/f;->a()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_0
    move-exception v0

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-interface {v0, v1}, Lcom/ape/offlinescriptmanager/utils/l/f$a;->e(Lb/b/a/a/c/f;)V

    return-void

    :goto_1
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->d:Z

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->h:Lcom/ape/offlinescriptmanager/utils/l/f$a;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/f;->g:Lb/b/a/a/c/f;

    invoke-interface {v1, v2}, Lcom/ape/offlinescriptmanager/utils/l/f$a;->e(Lb/b/a/a/c/f;)V

    throw v0
.end method
