.class public Lb/b/a/a/c/g;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static b:Lb/b/a/a/c/g;


# instance fields
.field private a:Lb/b/a/a/c/f;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lb/b/a/a/c/g;->a:Lb/b/a/a/c/f;

    return-void
.end method

.method public static declared-synchronized a()Lb/b/a/a/c/g;
    .locals 2

    const-class v0, Lb/b/a/a/c/g;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lb/b/a/a/c/g;->b:Lb/b/a/a/c/g;

    if-nez v1, :cond_0

    new-instance v1, Lb/b/a/a/c/g;

    invoke-direct {v1}, Lb/b/a/a/c/g;-><init>()V

    sput-object v1, Lb/b/a/a/c/g;->b:Lb/b/a/a/c/g;

    :cond_0
    sget-object v1, Lb/b/a/a/c/g;->b:Lb/b/a/a/c/g;
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
.method public b()Lb/b/a/a/c/f;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/c/g;->a:Lb/b/a/a/c/f;

    return-object v0
.end method

.method public c(Ljava/io/File;)Z
    .locals 3

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;-><init>()V

    :try_start_0
    new-instance v1, Ljava/io/BufferedInputStream;

    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/a;->c(Ljava/io/InputStream;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->r()Lb/b/a/a/c/f;

    move-result-object p1

    iput-object p1, p0, Lb/b/a/a/c/g;->a:Lb/b/a/a/c/f;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 p1, 0x0

    return p1
.end method

.method public d(Ljava/lang/String;)Z
    .locals 5

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0}, Lb/b/a/a/c/g;->c(Ljava/io/File;)Z

    move-result p1

    return p1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const-string v3, "have no xml file = %s"

    invoke-static {v3, v1}, Lcom/ape/offlinescriptmanager/utils/b;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    new-array v0, v0, [Ljava/lang/Object;

    aput-object p1, v0, v2

    invoke-static {v3, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "RunTaskManage"

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v2
.end method
