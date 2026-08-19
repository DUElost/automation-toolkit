.class public Lb/b/a/a/c/e;
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


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/c/e;->a:I

    const v0, 0xf731400

    iput v0, p0, Lb/b/a/a/c/e;->b:I

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/b/a/a/c/e;->a:I

    return v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/e;->f:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)Lb/b/a/a/b/b;
    .locals 2

    new-instance v0, Lb/b/a/a/b/e;

    iget-object v1, p0, Lb/b/a/a/c/e;->c:Ljava/lang/String;

    invoke-direct {v0, v1, p1}, Lb/b/a/a/b/e;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/e;->e:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->g(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/e;->f:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/e;->d:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->j(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/c/e;->g:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lb/b/a/a/b/e;->h(Ljava/lang/String;)V

    return-object v0
.end method

.method public d(Z)V
    .locals 0

    return-void
.end method

.method public e(Lb/b/a/a/b/b;)V
    .locals 4

    invoke-virtual {p0}, Lb/b/a/a/c/e;->i()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/utils/l/c;

    invoke-direct {v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;-><init>(Lb/b/a/a/b/b;)V

    :try_start_0
    const-string p1, "rum cmd %s"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {p1, v2}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget p1, p0, Lb/b/a/a/c/e;->b:I

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

    invoke-virtual {v1, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;->g(Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method public f()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public g()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method protected h()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lb/b/a/a/c/e;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/b/a/a/c/e;->f:Ljava/lang/String;

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

.method protected i()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    invoke-virtual {p0}, Lb/b/a/a/c/e;->h()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    iget-object v1, p0, Lb/b/a/a/c/e;->d:Ljava/lang/String;

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const-string v1, "am instrument %s -w %s/android.test.InstrumentationTestRunner"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/e;->c:Ljava/lang/String;

    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/e;->e:Ljava/lang/String;

    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public m(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/e;->g:Ljava/lang/String;

    return-void
.end method

.method public n(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/e;->f:Ljava/lang/String;

    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/c/e;->d:Ljava/lang/String;

    return-void
.end method

.method public p(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public q(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/e;->b:I

    return-void
.end method

.method public r(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/c/e;->a:I

    return-void
.end method
