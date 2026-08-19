.class public Lcom/ape/offlinescriptmanager/utils/m/g;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final c:Ljava/lang/String;


# instance fields
.field private a:Lb/b/a/a/d/f;

.field private b:Ljava/io/OutputStream;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Lb/b/a/a/d/f;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    return-void
.end method

.method private a(Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 1

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance p1, Ljava/io/FileOutputStream;

    invoke-direct {p1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    return-object p1
.end method

.method private b(Ljava/lang/String;)Lc/a/a/a;
    .locals 4

    const-string v0, "UTF-8"

    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Lc/a/a/a;

    invoke-direct {v2}, Lc/a/a/a;-><init>()V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/g;->a(Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    invoke-virtual {v2, p1, v0}, Lc/a/a/a;->j(Ljava/io/OutputStream;Ljava/lang/String;)V

    const-string p1, "http://xmlpull.org/v1/doc/features.html#indent-output"

    const/4 v3, 0x1

    invoke-virtual {v2, p1, v3}, Lc/a/a/a;->i(Ljava/lang/String;Z)V

    invoke-virtual {v2, v0, v1}, Lc/a/a/a;->m(Ljava/lang/String;Ljava/lang/Boolean;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    return-object v1
.end method

.method private c(Lc/a/a/a;)V
    .locals 0

    :try_start_0
    invoke-virtual {p1}, Lc/a/a/a;->c()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    :goto_0
    return-void
.end method

.method private d(Lc/a/a/a;Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lc/a/a/a;",
            "Ljava/util/List<",
            "Lb/b/a/a/d/b;",
            ">;)V"
        }
    .end annotation

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    const-string v1, "attribute"

    if-lez v0, :cond_0

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    :cond_0
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/d/b;

    sget-object v3, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    const-string v4, "arg"

    invoke-virtual {p1, v3, v4}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    iget-object v5, v2, Lb/b/a/a/d/b;->b:Ljava/lang/String;

    const-string v6, "name"

    invoke-virtual {p1, v3, v6, v5}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    iget-object v2, v2, Lb/b/a/a/d/b;->c:Ljava/lang/String;

    const-string v5, "value"

    invoke-virtual {p1, v3, v5, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v3, v4}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    goto :goto_0

    :cond_1
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_2

    sget-object p2, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    invoke-virtual {p1, p2, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    :cond_2
    return-void
.end method

.method private e(Lc/a/a/a;Ljava/lang/String;)V
    .locals 3

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    const-string v1, "description"

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "content"

    invoke-virtual {p1, v0, v2, p2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    return-void
.end method

.method private f(Lc/a/a/a;)Z
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v0}, Lb/b/a/a/d/f;->f()Lb/b/a/a/d/h;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v0}, Lb/b/a/a/d/f;->f()Lb/b/a/a/d/h;

    move-result-object v0

    invoke-direct {p0, p1, v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/g;->i(Lc/a/a/a;Lb/b/a/a/d/h;Z)V

    :cond_0
    return v1
.end method

.method private g(Lc/a/a/a;)Z
    .locals 4

    const-string v0, "task"

    :try_start_0
    sget-object v1, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    invoke-virtual {p1, v1, v0}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "name"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "times"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->l()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "testTimeOut"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->k()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "false"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->g()Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v2, "true"

    :cond_0
    const-string v3, "takeScreenshot"

    invoke-virtual {p1, v1, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "taskRegressionType"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->h()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "caseRegressionType"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->b()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "testpointRegressionTimes"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v3}, Lb/b/a/a/d/f;->j()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/g;->f(Lc/a/a/a;)Z

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/g;->j(Lc/a/a/a;)Z

    invoke-virtual {p1, v1, v0}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    const/4 p1, 0x0

    return p1
.end method

.method private h(Lc/a/a/a;Lb/b/a/a/d/c;)V
    .locals 7

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    const-string v1, "testcase"

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->getType()Ljava/lang/String;

    move-result-object v2

    const-string v3, "type"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "times"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "device"

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->d()Ljava/lang/String;

    move-result-object v3

    const-string v4, "name"

    invoke-virtual {p1, v0, v4, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    instance-of v2, p2, Lb/b/a/a/d/j;

    const-string v3, "method"

    const-string v5, "class"

    if-eqz v2, :cond_0

    const-string v2, "jar"

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v6

    :goto_0
    invoke-virtual {p1, v0, v4, v6}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v5}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->k()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v0, v4, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v5}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v3}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v0, v4, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v3}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    goto :goto_3

    :cond_0
    instance-of v2, p2, Lb/b/a/a/d/i;

    if-nez v2, :cond_3

    instance-of v2, p2, Lb/b/a/a/d/e;

    if-eqz v2, :cond_1

    goto :goto_2

    :cond_1
    instance-of v2, p2, Lb/b/a/a/d/a;

    if-eqz v2, :cond_2

    const-string v2, "cmd"

    :goto_1
    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v0, v4, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    goto :goto_3

    :cond_2
    instance-of v2, p2, Lb/b/a/a/d/d;

    if-eqz v2, :cond_4

    const-string v2, "command"

    goto :goto_1

    :cond_3
    :goto_2
    const-string v2, "apk"

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {p2}, Lb/b/a/a/d/c;->h()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v0, v4, v6}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "package"

    invoke-virtual {p1, v0, v2}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    move-object v6, p2

    check-cast v6, Lb/b/a/a/d/e;

    invoke-virtual {v6}, Lb/b/a/a/d/e;->o()Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    :cond_4
    :goto_3
    invoke-interface {p2}, Lb/b/a/a/d/c;->i()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, p1, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->e(Lc/a/a/a;Ljava/lang/String;)V

    invoke-interface {p2}, Lb/b/a/a/d/c;->e()Ljava/util/List;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lcom/ape/offlinescriptmanager/utils/m/g;->d(Lc/a/a/a;Ljava/util/List;)V

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    return-void
.end method

.method private i(Lc/a/a/a;Lb/b/a/a/d/h;Z)V
    .locals 5

    const-string v0, "proviouspoint"

    const-string v1, "testpoint"

    sget-object v2, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    if-eqz p3, :cond_0

    invoke-virtual {p1, v2, v0}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    goto :goto_0

    :cond_0
    invoke-virtual {p1, v2, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    :goto_0
    sget-object v2, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    invoke-virtual {p2}, Lb/b/a/a/d/h;->m()Ljava/lang/String;

    move-result-object v3

    const-string v4, "name"

    invoke-virtual {p1, v2, v4, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/d/h;->a()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, "times"

    invoke-virtual {p1, v2, v4, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/d/h;->i()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-direct {p0, p1, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->e(Lc/a/a/a;Ljava/lang/String;)V

    :cond_1
    invoke-virtual {p2}, Lb/b/a/a/d/h;->n()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/d/c;

    invoke-direct {p0, p1, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->h(Lc/a/a/a;Lb/b/a/a/d/c;)V

    goto :goto_1

    :cond_2
    sget-object p2, Lcom/ape/offlinescriptmanager/utils/m/g;->c:Ljava/lang/String;

    if-eqz p3, :cond_3

    invoke-virtual {p1, p2, v0}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    goto :goto_2

    :cond_3
    invoke-virtual {p1, p2, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    :goto_2
    return-void
.end method

.method private j(Lc/a/a/a;)Z
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v0}, Lb/b/a/a/d/f;->i()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/d/h;

    const/4 v2, 0x0

    invoke-direct {p0, p1, v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->i(Lc/a/a/a;Lb/b/a/a/d/h;Z)V

    goto :goto_0

    :cond_0
    const/4 p1, 0x1

    return p1
.end method


# virtual methods
.method public k()Z
    .locals 5

    const/4 v0, 0x1

    :try_start_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->a:Lb/b/a/a/d/f;

    invoke-virtual {v1}, Lb/b/a/a/d/f;->e()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/ape/offlinescriptmanager/utils/m/g;->b(Ljava/lang/String;)Lc/a/a/a;

    move-result-object v2

    const/4 v3, 0x0

    if-nez v2, :cond_1

    const-string v2, "create %s fail"

    new-array v4, v0, [Ljava/lang/Object;

    aput-object v1, v4, v3

    invoke-static {v2, v4}, Lcom/ape/offlinescriptmanager/utils/b;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_0
    return v3

    :cond_1
    :try_start_1
    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->g(Lc/a/a/a;)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->c(Lc/a/a/a;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_2
    return v3

    :cond_3
    :try_start_2
    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/m/g;->c(Lc/a/a/a;)V

    const-string v2, "save %s success"

    new-array v4, v0, [Ljava/lang/Object;

    aput-object v1, v4, v3

    invoke-static {v2, v4}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    if-eqz v1, :cond_4

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_0
    move-exception v1

    :try_start_3
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    if-eqz v1, :cond_4

    :goto_0
    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_4
    return v0

    :goto_1
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/g;->b:Ljava/io/OutputStream;

    if-eqz v1, :cond_5

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_5
    throw v0
.end method
