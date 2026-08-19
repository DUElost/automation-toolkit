.class Lxcrash/NativeHandler;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "StaticFieldLeak"
    }
.end annotation


# static fields
.field private static final g:Lxcrash/NativeHandler;


# instance fields
.field private a:J

.field private b:Landroid/content/Context;

.field private c:Lxcrash/d;

.field private d:Lxcrash/d;

.field private e:Z

.field private f:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lxcrash/NativeHandler;

    invoke-direct {v0}, Lxcrash/NativeHandler;-><init>()V

    sput-object v0, Lxcrash/NativeHandler;->g:Lxcrash/NativeHandler;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x3a98

    iput-wide v0, p0, Lxcrash/NativeHandler;->a:J

    const/4 v0, 0x0

    iput-object v0, p0, Lxcrash/NativeHandler;->c:Lxcrash/d;

    iput-object v0, p0, Lxcrash/NativeHandler;->d:Lxcrash/d;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lxcrash/NativeHandler;->e:Z

    iput-boolean v0, p0, Lxcrash/NativeHandler;->f:Z

    return-void
.end method

.method static a()Lxcrash/NativeHandler;
    .locals 1

    sget-object v0, Lxcrash/NativeHandler;->g:Lxcrash/NativeHandler;

    return-object v0
.end method

.method private static b(ZLjava/lang/String;)Ljava/lang/String;
    .locals 5

    :try_start_0
    invoke-static {}, Ljava/lang/Thread;->getAllStackTraces()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Thread;

    if-eqz p0, :cond_1

    invoke-virtual {v2}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "main"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    :cond_1
    if-nez p0, :cond_0

    invoke-virtual {v2}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    :cond_2
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/StackTraceElement;

    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_3

    aget-object v2, p1, v1

    const-string v3, "    at "

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n"

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object p1

    const-string v0, "xcrash"

    const-string v1, "NativeHandler getStacktraceByThreadName failed"

    invoke-interface {p1, v0, v1, p0}, Lxcrash/f;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_4
    const/4 p0, 0x0

    return-object p0
.end method

.method private static crashCallback(Ljava/lang/String;Ljava/lang/String;ZZLjava/lang/String;)V
    .locals 1

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    if-eqz p2, :cond_0

    invoke-static {p3, p4}, Lxcrash/NativeHandler;->b(ZLjava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p3

    if-nez p3, :cond_0

    const-string p3, "java stacktrace"

    invoke-static {p0, p3, p2}, Lxcrash/h;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_0
    invoke-static {}, Lxcrash/i;->k()Ljava/lang/String;

    move-result-object p2

    const-string p3, "memory info"

    invoke-static {p0, p3, p2}, Lxcrash/h;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_1
    invoke-static {}, Lxcrash/NativeHandler;->a()Lxcrash/NativeHandler;

    move-result-object p2

    iget-object p2, p2, Lxcrash/NativeHandler;->c:Lxcrash/d;

    if-eqz p2, :cond_2

    :try_start_0
    invoke-interface {p2, p0, p1}, Lxcrash/d;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object p1

    const-string p2, "xcrash"

    const-string p3, "NativeHandler native crash callback.onCrash failed"

    invoke-interface {p1, p2, p3, p0}, Lxcrash/f;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private static native nativeInit(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZIIIZZZZI[Ljava/lang/String;ZZIIIZ)I
.end method

.method private static native nativeNotifyJavaCrashed()V
.end method

.method private static native nativeTestCrash(I)V
.end method

.method private static traceCallback(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lxcrash/i;->k()Ljava/lang/String;

    move-result-object v0

    const-string v1, "memory info"

    invoke-static {p0, v1, v0}, Lxcrash/h;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    invoke-static {}, Lxcrash/NativeHandler;->a()Lxcrash/NativeHandler;

    move-result-object v0

    iget-object v0, v0, Lxcrash/NativeHandler;->b:Landroid/content/Context;

    invoke-static {}, Lxcrash/NativeHandler;->a()Lxcrash/NativeHandler;

    move-result-object v1

    iget-wide v1, v1, Lxcrash/NativeHandler;->a:J

    invoke-static {v0, v1, v2}, Lxcrash/i;->b(Landroid/content/Context;J)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lxcrash/c;->l()Lxcrash/c;

    move-result-object p1

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lxcrash/c;->q(Ljava/io/File;)Z

    return-void

    :cond_1
    invoke-static {}, Lxcrash/c;->l()Lxcrash/c;

    move-result-object v0

    invoke-virtual {v0}, Lxcrash/c;->p()Z

    move-result v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0xd

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".anr.xcrash"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance p0, Ljava/io/File;

    invoke-direct {p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result p0

    if-nez p0, :cond_3

    invoke-static {}, Lxcrash/c;->l()Lxcrash/c;

    move-result-object p0

    invoke-virtual {p0, v1}, Lxcrash/c;->q(Ljava/io/File;)Z

    return-void

    :cond_3
    invoke-static {}, Lxcrash/NativeHandler;->a()Lxcrash/NativeHandler;

    move-result-object p0

    iget-object p0, p0, Lxcrash/NativeHandler;->d:Lxcrash/d;

    if-eqz p0, :cond_4

    :try_start_0
    invoke-interface {p0, v0, p1}, Lxcrash/d;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object p1

    const-string v0, "xcrash"

    const-string v1, "NativeHandler ANR callback.onCrash failed"

    invoke-interface {p1, v0, v1, p0}, Lxcrash/f;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_4
    :goto_0
    return-void
.end method


# virtual methods
.method c(Landroid/content/Context;Lxcrash/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZIIIZZZZI[Ljava/lang/String;Lxcrash/d;ZZIIIZLxcrash/d;)I
    .locals 34

    move-object/from16 v1, p0

    move-object/from16 v0, p2

    const-string v2, "NativeHandler init failed"

    const/4 v3, -0x2

    const-string v4, "xcrash"

    if-nez v0, :cond_0

    :try_start_0
    invoke-static {v4}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    move-object v2, v0

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object v0

    const-string v5, "NativeHandler System.loadLibrary failed"

    :goto_0
    invoke-interface {v0, v4, v5, v2}, Lxcrash/f;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return v3

    :cond_0
    :try_start_1
    invoke-interface {v0, v4}, Lxcrash/e;->a(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    :goto_1
    move-object/from16 v0, p1

    iput-object v0, v1, Lxcrash/NativeHandler;->b:Landroid/content/Context;

    move-object/from16 v3, p17

    iput-object v3, v1, Lxcrash/NativeHandler;->c:Lxcrash/d;

    move-object/from16 v3, p24

    iput-object v3, v1, Lxcrash/NativeHandler;->d:Lxcrash/d;

    move/from16 v3, p18

    iput-boolean v3, v1, Lxcrash/NativeHandler;->f:Z

    if-eqz p19, :cond_1

    const-wide/16 v5, 0x3a98

    goto :goto_2

    :cond_1
    const-wide/16 v5, 0x7530

    :goto_2
    iput-wide v5, v1, Lxcrash/NativeHandler;->a:J

    const/16 v33, -0x3

    :try_start_2
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    sget-object v6, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-static {}, Lxcrash/i;->c()Ljava/lang/String;

    move-result-object v7

    sget-object v8, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    sget-object v9, Landroid/os/Build;->BRAND:Ljava/lang/String;

    sget-object v10, Landroid/os/Build;->MODEL:Ljava/lang/String;

    sget-object v11, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v14, v0, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    move-object/from16 v12, p3

    move-object/from16 v13, p4

    move-object/from16 v15, p5

    move/from16 v16, p6

    move/from16 v17, p7

    move/from16 v18, p8

    move/from16 v19, p9

    move/from16 v20, p10

    move/from16 v21, p11

    move/from16 v22, p12

    move/from16 v23, p13

    move/from16 v24, p14

    move/from16 v25, p15

    move-object/from16 v26, p16

    move/from16 v27, p18

    move/from16 v28, p19

    move/from16 v29, p20

    move/from16 v30, p21

    move/from16 v31, p22

    move/from16 v32, p23

    invoke-static/range {v5 .. v32}, Lxcrash/NativeHandler;->nativeInit(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZIIIZZZZI[Ljava/lang/String;ZZIIIZ)I

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object v0

    invoke-interface {v0, v4, v2}, Lxcrash/f;->b(Ljava/lang/String;Ljava/lang/String;)V

    return v33

    :cond_2
    const/4 v0, 0x1

    iput-boolean v0, v1, Lxcrash/NativeHandler;->e:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    const/4 v0, 0x0

    return v0

    :catchall_1
    move-exception v0

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object v3

    invoke-interface {v3, v4, v2, v0}, Lxcrash/f;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return v33

    :catchall_2
    move-exception v0

    move-object v2, v0

    invoke-static {}, Lxcrash/j;->a()Lxcrash/f;

    move-result-object v0

    const-string v5, "NativeHandler ILibLoader.loadLibrary failed"

    goto/16 :goto_0
.end method

.method d()V
    .locals 1

    iget-boolean v0, p0, Lxcrash/NativeHandler;->e:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lxcrash/NativeHandler;->f:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lxcrash/NativeHandler;->nativeNotifyJavaCrashed()V

    :cond_0
    return-void
.end method
