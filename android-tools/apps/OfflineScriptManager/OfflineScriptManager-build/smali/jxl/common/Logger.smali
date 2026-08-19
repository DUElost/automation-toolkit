.class public abstract Ljxl/common/Logger;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static logger:Ljxl/common/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method protected constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final getLogger(Ljava/lang/Class;)Ljxl/common/Logger;
    .locals 1

    sget-object v0, Ljxl/common/Logger;->logger:Ljxl/common/Logger;

    if-nez v0, :cond_0

    invoke-static {}, Ljxl/common/Logger;->initializeLogger()V

    :cond_0
    sget-object v0, Ljxl/common/Logger;->logger:Ljxl/common/Logger;

    invoke-virtual {v0, p0}, Ljxl/common/Logger;->getLoggerImpl(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object p0

    return-object p0
.end method

.method private static declared-synchronized initializeLogger()V
    .locals 5

    const-class v0, Ljxl/common/Logger;

    monitor-enter v0

    :try_start_0
    sget-object v1, Ljxl/common/Logger;->logger:Ljxl/common/Logger;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    :try_start_1
    sget-object v1, Ljxl/common/log/LoggerName;->NAME:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    const-string v2, "logger"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_1

    goto :goto_0

    :cond_1
    move-object v1, v2

    :goto_0
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/common/Logger;

    sput-object v2, Ljxl/common/Logger;->logger:Ljxl/common/Logger;
    :try_end_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/InstantiationException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/security/AccessControlException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_2

    :catch_0
    :try_start_3
    new-instance v2, Ljxl/common/log/SimpleLogger;

    invoke-direct {v2}, Ljxl/common/log/SimpleLogger;-><init>()V

    sput-object v2, Ljxl/common/Logger;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Could not instantiate logger "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " using default"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v2, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :catch_1
    new-instance v2, Ljxl/common/log/SimpleLogger;

    invoke-direct {v2}, Ljxl/common/log/SimpleLogger;-><init>()V

    sput-object v2, Ljxl/common/Logger;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Could not instantiate logger "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " using default"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :catch_2
    new-instance v2, Ljxl/common/log/SimpleLogger;

    invoke-direct {v2}, Ljxl/common/log/SimpleLogger;-><init>()V

    sput-object v2, Ljxl/common/Logger;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Could not instantiate logger "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " using default"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :catch_3
    new-instance v2, Ljxl/common/log/SimpleLogger;

    invoke-direct {v2}, Ljxl/common/log/SimpleLogger;-><init>()V

    sput-object v2, Ljxl/common/Logger;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Could not instantiate logger "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " using default"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    :goto_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public abstract debug(Ljava/lang/Object;)V
.end method

.method public abstract debug(Ljava/lang/Object;Ljava/lang/Throwable;)V
.end method

.method public abstract error(Ljava/lang/Object;)V
.end method

.method public abstract error(Ljava/lang/Object;Ljava/lang/Throwable;)V
.end method

.method public abstract fatal(Ljava/lang/Object;)V
.end method

.method public abstract fatal(Ljava/lang/Object;Ljava/lang/Throwable;)V
.end method

.method protected abstract getLoggerImpl(Ljava/lang/Class;)Ljxl/common/Logger;
.end method

.method public abstract info(Ljava/lang/Object;)V
.end method

.method public abstract info(Ljava/lang/Object;Ljava/lang/Throwable;)V
.end method

.method public setSuppressWarnings(Z)V
    .locals 0

    return-void
.end method

.method public abstract warn(Ljava/lang/Object;)V
.end method

.method public abstract warn(Ljava/lang/Object;Ljava/lang/Throwable;)V
.end method
