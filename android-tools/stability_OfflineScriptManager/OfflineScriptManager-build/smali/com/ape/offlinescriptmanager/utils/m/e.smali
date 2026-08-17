.class public Lcom/ape/offlinescriptmanager/utils/m/e;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final c:Ljava/lang/String;


# instance fields
.field private a:Lb/b/a/a/e/e;

.field private b:Ljava/io/OutputStream;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Lb/b/a/a/e/e;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->a:Lb/b/a/a/e/e;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->a:Lb/b/a/a/e/e;

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

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/e;->a(Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

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

.method private d(Lc/a/a/a;Lb/b/a/a/e/b;)V
    .locals 4

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    const-string v1, "TestData"

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/b;->a()Ljava/lang/String;

    move-result-object v2

    const-string v3, "name"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/b;->b()Ljava/lang/String;

    move-result-object p2

    const-string v2, "value"

    invoke-virtual {p1, v0, v2, p2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    return-void
.end method

.method private e(Lc/a/a/a;)V
    .locals 5

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->a:Lb/b/a/a/e/e;

    invoke-virtual {v0}, Lb/b/a/a/e/e;->d()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    sget-object v2, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    const-string v3, "SIM"

    invoke-virtual {p1, v2, v3}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {p1, v2, v4, v1}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p1, v2, v3}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    goto :goto_0

    :cond_1
    return-void
.end method

.method private f(Lc/a/a/a;Lb/b/a/a/e/a;)V
    .locals 4

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    const-string v1, "TestCase"

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/a;->b()Ljava/lang/String;

    move-result-object v2

    const-string v3, "name"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/a;->c()Ljava/util/Map;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/e/c;

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/utils/m/e;->h(Lc/a/a/a;Lb/b/a/a/e/c;)V

    goto :goto_0

    :cond_0
    sget-object p2, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    invoke-virtual {p1, p2, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    return-void
.end method

.method private g(Lc/a/a/a;)Z
    .locals 4

    const-string v0, "TestSet"

    :try_start_0
    sget-object v1, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    invoke-virtual {p1, v1, v0}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "name"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->a:Lb/b/a/a/e/e;

    invoke-virtual {v3}, Lb/b/a/a/e/e;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    const-string v2, "TakeScreenshot"

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->a:Lb/b/a/a/e/e;

    invoke-virtual {v3}, Lb/b/a/a/e/e;->e()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v1, v2, v3}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/e;->e(Lc/a/a/a;)V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/e;->j(Lc/a/a/a;)V

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

.method private h(Lc/a/a/a;Lb/b/a/a/e/c;)V
    .locals 4

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    const-string v1, "TestMethod"

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/c;->b()Ljava/lang/String;

    move-result-object v2

    const-string v3, "name"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/c;->c()Ljava/util/Map;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/e/b;

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/utils/m/e;->d(Lc/a/a/a;Lb/b/a/a/e/b;)V

    goto :goto_0

    :cond_0
    sget-object p2, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    invoke-virtual {p1, p2, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    return-void
.end method

.method private i(Lc/a/a/a;Lb/b/a/a/e/d;)V
    .locals 4

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    const-string v1, "TestPackage"

    invoke-virtual {p1, v0, v1}, Lc/a/a/a;->n(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/d;->b()Ljava/lang/String;

    move-result-object v2

    const-string v3, "appPackageName"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/d;->c()Ljava/lang/String;

    move-result-object v2

    const-string v3, "runner"

    invoke-virtual {p1, v0, v3, v2}, Lc/a/a/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    invoke-virtual {p2}, Lb/b/a/a/e/d;->d()Ljava/util/Map;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/e/a;

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/utils/m/e;->f(Lc/a/a/a;Lb/b/a/a/e/a;)V

    goto :goto_0

    :cond_0
    sget-object p2, Lcom/ape/offlinescriptmanager/utils/m/e;->c:Ljava/lang/String;

    invoke-virtual {p1, p2, v1}, Lc/a/a/a;->d(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/b;

    return-void
.end method

.method private j(Lc/a/a/a;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->a:Lb/b/a/a/e/e;

    invoke-virtual {v0}, Lb/b/a/a/e/e;->f()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/e/d;

    invoke-direct {p0, p1, v1}, Lcom/ape/offlinescriptmanager/utils/m/e;->i(Lc/a/a/a;Lb/b/a/a/e/d;)V

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method public k()Z
    .locals 5

    const/4 v0, 0x1

    :try_start_0
    const-string v1, "/sdcard/UiAutomatorTestData.xml"

    invoke-direct {p0, v1}, Lcom/ape/offlinescriptmanager/utils/m/e;->b(Ljava/lang/String;)Lc/a/a/a;

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

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_0
    return v3

    :cond_1
    :try_start_1
    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/m/e;->g(Lc/a/a/a;)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/m/e;->c(Lc/a/a/a;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_2
    return v3

    :cond_3
    :try_start_2
    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/m/e;->c(Lc/a/a/a;)V

    const-string v2, "save %s success"

    new-array v4, v0, [Ljava/lang/Object;

    aput-object v1, v4, v3

    invoke-static {v2, v4}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

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

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

    if-eqz v1, :cond_4

    :goto_0
    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_4
    return v0

    :goto_1
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/e;->b:Ljava/io/OutputStream;

    if-eqz v1, :cond_5

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    :cond_5
    throw v0
.end method
