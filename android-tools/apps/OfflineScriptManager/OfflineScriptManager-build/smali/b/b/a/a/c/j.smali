.class public Lb/b/a/a/c/j;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/b/a/a/c/c;


# instance fields
.field private a:I

.field private b:I

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/c/j;->a:I

    const v0, 0xf731400

    iput v0, p0, Lb/b/a/a/c/j;->b:I

    const-string v0, "android.support.test.runner.AndroidJUnitRunner"

    iput-object v0, p0, Lb/b/a/a/c/j;->f:Ljava/lang/String;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/a/c/j;->h:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/j;->a:I

    return v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/j;->e:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)Lb/b/a/a/b/b;
    .locals 2

    new-instance v0, Lb/b/a/a/b/j;

    iget-object v1, p0, Lb/b/a/a/c/j;->c:Ljava/lang/String;

    invoke-direct {v0, v1, p1}, Lb/b/a/a/b/j;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/j;->d:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/j;->g(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/j;->e:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/j;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/j;->g:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/j;->h(Ljava/lang/String;)V

    return-object v0
.end method

.method public d(Z)V
    .locals 0

    return-void
.end method

.method public e(Lb/b/a/a/b/b;)V
    .locals 4

    invoke-virtual {p0}, Lb/b/a/a/c/j;->m()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/utils/l/g;

    invoke-direct {v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;-><init>(Lb/b/a/a/b/b;)V

    :try_start_0
    const-string p1, "rum cmd %s"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {p1, v2}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget p1, p0, Lb/b/a/a/c/j;->b:I

    invoke-static {v0, v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/d;->a(Ljava/lang/String;Lcom/ape/offlinescriptmanager/utils/l/a;I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/TimeoutException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    goto :goto_0

    :catch_1
    move-exception p1

    :goto_0
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    invoke-virtual {p1}, Ljava/lang/Exception;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;->i(Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method public f()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public g()Z
    .locals 5

    iget-object v0, p0, Lb/b/a/a/c/j;->h:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->E(Ljava/util/ArrayList;)Z

    invoke-virtual {p0}, Lb/b/a/a/c/j;->k()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lb/b/a/a/c/j;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lb/b/a/a/c/j;->l()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lb/b/a/a/c/j;->n()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lb/b/a/a/c/j;->h:Ljava/util/ArrayList;

    invoke-static {v0, v1, v2, v3, v4}, Lcom/ape/offlinescriptmanager/utils/g;->O(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)Z

    const/4 v0, 0x1

    return v0
.end method

.method public h(Lb/b/a/a/c/a;)V
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/j;->h:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method protected i()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lb/b/a/a/c/j;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/b/a/a/c/j;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "class"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    aput-object v0, v1, v2

    const-string v0, " -e %1$s %2$s"

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/j;->d:Ljava/lang/String;

    return-object v0
.end method

.method public k()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/j;->c:Ljava/lang/String;

    return-object v0
.end method

.method public l()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/j;->e:Ljava/lang/String;

    return-object v0
.end method

.method protected m()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    const-string v2, "/system/bin/uiautomator"

    aput-object v2, v0, v1

    iget-object v1, p0, Lb/b/a/a/c/j;->c:Ljava/lang/String;

    const/4 v2, 0x1

    aput-object v1, v0, v2

    invoke-virtual {p0}, Lb/b/a/a/c/j;->i()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    const-string v1, "%s runtest %s %s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public n()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/j;->f:Ljava/lang/String;

    return-object v0
.end method

.method public o(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/j;->d:Ljava/lang/String;

    return-void
.end method

.method public p(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/j;->g:Ljava/lang/String;

    return-void
.end method

.method public q(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/j;->c:Ljava/lang/String;

    return-void
.end method

.method public r(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/j;->e:Ljava/lang/String;

    return-void
.end method

.method public s(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/j;->f:Ljava/lang/String;

    return-void
.end method

.method public t(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/j;->b:I

    return-void
.end method

.method public u(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/j;->a:I

    return-void
.end method
