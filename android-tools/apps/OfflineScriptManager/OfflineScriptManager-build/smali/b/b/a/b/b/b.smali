.class public Lb/b/a/b/b/b;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static b:Lb/b/a/b/b/b;


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/d/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/b/b/b;->a:Ljava/util/List;

    invoke-virtual {p0}, Lb/b/a/b/b/b;->b()Z

    return-void
.end method

.method private a(Ljava/io/File;)Z
    .locals 2

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;-><init>()V

    :try_start_0
    invoke-direct {p0, p1}, Lb/b/a/b/b/b;->c(Ljava/io/File;)Ljava/io/InputStream;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/a;->c(Ljava/io/InputStream;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->B()Lb/b/a/a/d/f;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lb/b/a/a/d/f;->p(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/b/b/b;->a:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
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

.method private c(Ljava/io/File;)Ljava/io/InputStream;
    .locals 2

    new-instance v0, Ljava/io/BufferedInputStream;

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    return-object v0
.end method

.method public static declared-synchronized d()Lb/b/a/b/b/b;
    .locals 2

    const-class v0, Lb/b/a/b/b/b;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lb/b/a/b/b/b;->b:Lb/b/a/b/b/b;

    if-nez v1, :cond_0

    new-instance v1, Lb/b/a/b/b/b;

    invoke-direct {v1}, Lb/b/a/b/b/b;-><init>()V

    sput-object v1, Lb/b/a/b/b/b;->b:Lb/b/a/b/b/b;

    :cond_0
    sget-object v1, Lb/b/a/b/b/b;->b:Lb/b/a/b/b/b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private g()[Ljava/io/File;
    .locals 1

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/f;->a()Lcom/ape/offlinescriptmanager/utils/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/f;->j()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->z(Ljava/lang/String;)[Ljava/io/File;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public b()Z
    .locals 4

    invoke-direct {p0}, Lb/b/a/b/b/b;->g()[Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, v0, v2

    invoke-direct {p0, v3}, Lb/b/a/b/b/b;->a(Ljava/io/File;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v3, "MM yyyy"

    invoke-direct {v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3, v0, v1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    const-string v0, "Load Task Xml Finish!"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0
.end method

.method public e(Ljava/io/File;)Lb/b/a/a/d/f;
    .locals 3

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;-><init>()V

    const/4 v1, 0x0

    :try_start_0
    invoke-direct {p0, p1}, Lb/b/a/b/b/b;->c(Ljava/io/File;)Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/ape/offlinescriptmanager/utils/m/a;->c(Ljava/io/InputStream;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->B()Lb/b/a/a/d/f;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lb/b/a/a/d/f;->p(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    :goto_0
    return-object v1
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/b/a/a/d/f;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/b/b/b;->a:Ljava/util/List;

    return-object v0
.end method
