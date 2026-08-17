.class public Lcom/ape/offlinescriptmanager/utils/b;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static a:Ljava/io/OutputStream;

.field private static b:Ljava/io/OutputStreamWriter;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static declared-synchronized a()V
    .locals 3

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v1, :cond_0

    const/4 v2, 0x0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/OutputStreamWriter;->flush()V

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;

    invoke-virtual {v1}, Ljava/io/OutputStreamWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    sput-object v2, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    :goto_0
    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_2

    :catchall_0
    move-exception v1

    goto :goto_1

    :catch_0
    move-exception v1

    :try_start_3
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    sput-object v2, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    goto :goto_0

    :goto_1
    sput-object v2, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;

    sget-object v2, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :cond_0
    :goto_2
    monitor-exit v0

    return-void

    :catchall_1
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized b()V
    .locals 4

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    const-string v1, "log.txt"

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->q()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/f;->a()Lcom/ape/offlinescriptmanager/utils/f;

    move-result-object v3

    invoke-virtual {v3, v2}, Lcom/ape/offlinescriptmanager/utils/f;->f(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v2, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sput-object v1, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    new-instance v1, Ljava/io/OutputStreamWriter;

    sget-object v2, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    const-string v3, "utf-8"

    invoke-direct {v1, v2, v3}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    sput-object v1, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v1

    goto :goto_2

    :catch_0
    move-exception v1

    :try_start_1
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    :goto_0
    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->d(Ljava/io/OutputStream;)V

    goto :goto_1

    :catch_1
    move-exception v1

    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;

    goto :goto_0

    :catch_2
    move-exception v1

    invoke-virtual {v1}, Ljava/io/FileNotFoundException;->printStackTrace()V

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->a:Ljava/io/OutputStream;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :goto_1
    monitor-exit v0

    return-void

    :goto_2
    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized c(Ljava/lang/String;)V
    .locals 3

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    const-string v1, "e"

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/b;->f()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, p0}, Lcom/ape/offlinescriptmanager/utils/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/b;->g(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static varargs declared-synchronized d(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 3

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    const-string v1, "e"

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/b;->f()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, v2, p0}, Lcom/ape/offlinescriptmanager/utils/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/b;->g(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "MM-dd HH:mm:ss.SSS"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/Object;

    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    aput-object v0, v1, v2

    const/4 v0, 0x1

    aput-object p0, v1, v0

    const/4 p0, 0x2

    aput-object p1, v1, p0

    const/4 p0, 0x3

    aput-object p2, v1, p0

    const-string p0, "%s %s %s: %s\n"

    invoke-static {p0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static f()Ljava/lang/String;
    .locals 6

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v1, Ljava/lang/Throwable;

    invoke-direct {v1}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v1

    array-length v2, v1

    const-string v3, ""

    if-nez v2, :cond_0

    return-object v3

    :cond_0
    array-length v2, v1

    const/4 v4, 0x1

    if-le v2, v4, :cond_1

    const/4 v2, 0x2

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    aget-object v4, v1, v2

    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_2

    const-string v5, ".java"

    invoke-virtual {v4, v5, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_2
    const-string v3, "Unknown Source"

    :goto_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v3, " : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    aget-object v1, v1, v2

    invoke-virtual {v1}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static declared-synchronized g(Ljava/lang/String;)V
    .locals 2

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;

    if-eqz v1, :cond_0

    invoke-virtual {v1, p0}, Ljava/io/OutputStreamWriter;->write(Ljava/lang/String;)V

    sget-object p0, Lcom/ape/offlinescriptmanager/utils/b;->b:Ljava/io/OutputStreamWriter;

    invoke-virtual {p0}, Ljava/io/OutputStreamWriter;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    goto :goto_1

    :catch_0
    move-exception p0

    :try_start_1
    invoke-virtual {p0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_0
    :goto_0
    monitor-exit v0

    return-void

    :goto_1
    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized h(Ljava/lang/String;)V
    .locals 3

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    const-string v1, "v"

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/b;->f()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, p0}, Lcom/ape/offlinescriptmanager/utils/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/b;->g(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static varargs declared-synchronized i(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 3

    const-class v0, Lcom/ape/offlinescriptmanager/utils/b;

    monitor-enter v0

    :try_start_0
    const-string v1, "v"

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/b;->f()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, v2, p0}, Lcom/ape/offlinescriptmanager/utils/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/b;->g(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method
