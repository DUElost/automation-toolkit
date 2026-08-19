.class public Lb/b/a/a/c/i;
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

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/c/a;",
            ">;"
        }
    .end annotation
.end field

.field private k:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/c/i;->a:I

    const v0, 0xf731400

    iput v0, p0, Lb/b/a/a/c/i;->b:I

    const-string v0, "android.support.test.runner.AndroidJUnitRunner"

    iput-object v0, p0, Lb/b/a/a/c/i;->h:Ljava/lang/String;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/a/c/i;->j:Ljava/util/ArrayList;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/b/a/a/c/i;->k:Z

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/i;->a:I

    return v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/i;->g:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)Lb/b/a/a/b/b;
    .locals 2

    new-instance v0, Lb/b/a/a/b/i;

    iget-object v1, p0, Lb/b/a/a/c/i;->c:Ljava/lang/String;

    invoke-direct {v0, v1, p1}, Lb/b/a/a/b/i;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/i;->f:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->g(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/i;->g:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/i;->d:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->j(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/i;->i:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->h(Ljava/lang/String;)V

    return-object v0
.end method

.method public d(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/b/a/a/c/i;->k:Z

    return-void
.end method

.method public e(Lb/b/a/a/b/b;)V
    .locals 5

    invoke-virtual {p0}, Lb/b/a/a/c/i;->m()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/utils/l/c;

    invoke-direct {v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;-><init>(Lb/b/a/a/b/b;)V

    :try_start_0
    const-string p1, "STEVEN_LOG"

    invoke-static {p1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const-string p1, "run cmd %s"

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    invoke-static {p1, v3}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    const-string p1, "UiAuto2.mTestTimeOut: %s"

    new-array v2, v2, [Ljava/lang/Object;

    iget v3, p0, Lb/b/a/a/c/i;->b:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {p1, v2}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget p1, p0, Lb/b/a/a/c/i;->b:I

    invoke-static {v0, v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/d;->a(Ljava/lang/String;Lcom/ape/offlinescriptmanager/utils/l/a;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    invoke-virtual {p1}, Ljava/lang/Exception;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object p1

    invoke-static {p1}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;->g(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public f()Z
    .locals 1

    iget-boolean v0, p0, Lb/b/a/a/c/i;->k:Z

    return v0
.end method

.method public g()Z
    .locals 5

    iget-object v0, p0, Lb/b/a/a/c/i;->j:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->E(Ljava/util/ArrayList;)Z

    invoke-virtual {p0}, Lb/b/a/a/c/i;->k()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lb/b/a/a/c/i;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lb/b/a/a/c/i;->l()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lb/b/a/a/c/i;->n()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lb/b/a/a/c/i;->j:Ljava/util/ArrayList;

    invoke-static {v0, v1, v2, v3, v4}, Lcom/ape/offlinescriptmanager/utils/g;->O(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)Z

    const/4 v0, 0x1

    return v0
.end method

.method public h(Lb/b/a/a/c/a;)V
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/i;->j:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method protected i()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lb/b/a/a/c/i;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/b/a/a/c/i;->g:Ljava/lang/String;

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

    iget-object v0, p0, Lb/b/a/a/c/i;->f:Ljava/lang/String;

    return-object v0
.end method

.method public k()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/i;->e:Ljava/lang/String;

    return-object v0
.end method

.method public l()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/i;->g:Ljava/lang/String;

    return-object v0
.end method

.method protected m()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    invoke-virtual {p0}, Lb/b/a/a/c/i;->i()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    iget-object v1, p0, Lb/b/a/a/c/i;->d:Ljava/lang/String;

    const/4 v2, 0x1

    aput-object v1, v0, v2

    iget-object v1, p0, Lb/b/a/a/c/i;->h:Ljava/lang/String;

    const/4 v2, 0x2

    aput-object v1, v0, v2

    const-string v1, "am instrument -w %s %s/%s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public n()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/i;->h:Ljava/lang/String;

    return-object v0
.end method

.method public o(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->c:Ljava/lang/String;

    return-void
.end method

.method public p(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->f:Ljava/lang/String;

    return-void
.end method

.method public q(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->e:Ljava/lang/String;

    return-void
.end method

.method public r(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->i:Ljava/lang/String;

    return-void
.end method

.method public s(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->g:Ljava/lang/String;

    return-void
.end method

.method public t(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->d:Ljava/lang/String;

    return-void
.end method

.method public u(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/i;->h:Ljava/lang/String;

    return-void
.end method

.method public v(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/i;->b:I

    return-void
.end method

.method public w(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/i;->a:I

    return-void
.end method
