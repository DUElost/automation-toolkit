.class public Lb/b/a/b/b/c;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static b:Lb/b/a/b/b/c;


# instance fields
.field private a:Lb/b/a/a/e/e;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    invoke-virtual {p0}, Lb/b/a/b/b/c;->e()V

    return-void
.end method

.method private a(Ljava/io/File;)Z
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;-><init>()V

    :try_start_0
    invoke-direct {p0, p1}, Lb/b/a/b/b/c;->b(Ljava/io/File;)Ljava/io/InputStream;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/ape/offlinescriptmanager/utils/m/a;->c(Ljava/io/InputStream;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->y()Lb/b/a/a/e/e;

    move-result-object p1

    iput-object p1, p0, Lb/b/a/b/b/c;->a:Lb/b/a/a/e/e;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lb/b/a/a/e/e;->f()Ljava/util/Map;

    iget-object p1, p0, Lb/b/a/b/b/c;->a:Lb/b/a/a/e/e;

    invoke-virtual {p1}, Lb/b/a/a/e/e;->e()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    :goto_0
    const/4 p1, 0x1

    return p1
.end method

.method private b(Ljava/io/File;)Ljava/io/InputStream;
    .locals 2

    new-instance v0, Ljava/io/BufferedInputStream;

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    return-object v0
.end method

.method public static declared-synchronized c()Lb/b/a/b/b/c;
    .locals 2

    const-class v0, Lb/b/a/b/b/c;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lb/b/a/b/b/c;->b:Lb/b/a/b/b/c;

    if-nez v1, :cond_0

    new-instance v1, Lb/b/a/b/b/c;

    invoke-direct {v1}, Lb/b/a/b/b/c;-><init>()V

    sput-object v1, Lb/b/a/b/b/c;->b:Lb/b/a/b/b/c;

    :cond_0
    sget-object v1, Lb/b/a/b/b/c;->b:Lb/b/a/b/b/c;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public d()Lb/b/a/a/e/e;
    .locals 1

    iget-object v0, p0, Lb/b/a/b/b/c;->a:Lb/b/a/a/e/e;

    return-object v0
.end method

.method public e()V
    .locals 2

    new-instance v0, Ljava/io/File;

    const-string v1, "/sdcard/UiAutomatorTestData.xml"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0, v0}, Lb/b/a/b/b/c;->a(Ljava/io/File;)Z

    :cond_0
    return-void
.end method
