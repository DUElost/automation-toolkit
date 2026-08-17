.class public final Lcom/ape/offlinescriptmanager/utils/l/d;
.super Ljava/lang/Object;
.source ""


# direct methods
.method public static a(Ljava/lang/String;Lcom/ape/offlinescriptmanager/utils/l/a;I)V
    .locals 12

    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x0

    if-lez p2, :cond_0

    const-string v3, "Time unit must not be null for non-zero max."

    invoke-static {v0, v3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    int-to-long v3, p2

    invoke-virtual {v0, v3, v4}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v3

    goto :goto_0

    :cond_0
    move-wide v3, v1

    :goto_0
    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0}, Lcom/ape/offlinescriptmanager/utils/g;->i(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object p0

    new-instance v5, Lcom/ape/offlinescriptmanager/utils/l/e;

    new-instance v6, Lcom/ape/offlinescriptmanager/utils/l/d$a;

    invoke-direct {v6, p0}, Lcom/ape/offlinescriptmanager/utils/l/d$a;-><init>(Ljava/lang/Process;)V

    invoke-direct {v5, v6}, Lcom/ape/offlinescriptmanager/utils/l/e;-><init>(Lcom/ape/offlinescriptmanager/utils/l/e$a;)V

    invoke-virtual {v5, p2}, Lcom/ape/offlinescriptmanager/utils/l/e;->c(I)V

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Lcom/ape/offlinescriptmanager/utils/l/e;->a(Z)V

    invoke-virtual {v5}, Lcom/ape/offlinescriptmanager/utils/l/e;->d()V

    new-instance v5, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object p0

    invoke-static {}, Ljava/nio/charset/Charset;->defaultCharset()Ljava/nio/charset/Charset;

    move-result-object v8

    invoke-direct {v7, p0, v8}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v5, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-wide v7, v1

    :cond_1
    :goto_1
    :try_start_1
    invoke-virtual {v5}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_5

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    const/4 v9, 0x0

    if-eqz v0, :cond_4

    const/16 v0, 0x19

    int-to-long v10, v0

    add-long/2addr v7, v10

    cmp-long v0, v3, v1

    if-lez v0, :cond_3

    cmp-long v0, v7, v3

    if-gtz v0, :cond_2

    goto :goto_2

    :cond_2
    const-string p0, "RunCaseTestTimeOut: %s"

    new-array p1, v6, [Ljava/lang/Object;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    aput-object p2, p1, v9

    invoke-static {p0, p1}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance p0, Ljava/util/concurrent/TimeoutException;

    invoke-direct {p0}, Ljava/util/concurrent/TimeoutException;-><init>()V

    throw p0

    :cond_3
    :goto_2
    invoke-static {v10, v11}, Lcom/ape/offlinescriptmanager/utils/g;->L(J)V

    goto :goto_3

    :cond_4
    const-string v0, "cmdReviceer: %s"

    new-array v7, v6, [Ljava/lang/Object;

    aput-object p0, v7, v9

    invoke-static {v0, v7}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "\r\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    move-wide v7, v1

    :goto_3
    if-eqz p1, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    array-length p0, p0

    invoke-interface {p1, v0, v9, p0}, Lcom/ape/offlinescriptmanager/utils/l/a;->b([BII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :cond_5
    invoke-static {v5}, Lcom/ape/offlinescriptmanager/utils/g;->e(Ljava/io/Reader;)V

    invoke-interface {p1}, Lcom/ape/offlinescriptmanager/utils/l/a;->flush()V

    return-void

    :catchall_0
    move-exception p0

    move-object v0, v5

    goto :goto_4

    :catchall_1
    move-exception p0

    :goto_4
    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->e(Ljava/io/Reader;)V

    throw p0
.end method
