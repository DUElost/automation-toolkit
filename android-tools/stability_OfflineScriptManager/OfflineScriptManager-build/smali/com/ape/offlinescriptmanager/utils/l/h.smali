.class public Lcom/ape/offlinescriptmanager/utils/l/h;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static c:Z = true


# instance fields
.field private a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private b:Lc/c/a/d;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/h;->a:Ljava/util/Map;

    new-instance p1, Lc/c/a/d;

    invoke-direct {p1}, Lc/c/a/d;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/h;->b:Lc/c/a/d;

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/utils/l/h;)Lc/c/a/d;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/l/h;->b:Lc/c/a/d;

    return-object p0
.end method

.method static synthetic b(Z)Z
    .locals 0

    sput-boolean p0, Lcom/ape/offlinescriptmanager/utils/l/h;->c:Z

    return p0
.end method


# virtual methods
.method public c()Ljava/lang/String;
    .locals 4

    const-string v0, "getprop"

    const-string v1, "ro.serialno"

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, ""

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, ":"

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    const-string v2, "["

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "]"

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    :cond_0
    return-object v1
.end method

.method public d()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->q()Ljava/lang/String;

    move-result-object v1

    const-string v2, "dt"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "lvl"

    const-string v2, "OFFLINE_RESULT"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/h;->a:Ljava/util/Map;

    const-string v2, "msg"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/l/h;->c()Ljava/lang/String;

    move-result-object v1

    const-string v2, "serial"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/h;->b:Lc/c/a/d;

    invoke-virtual {v2, v0}, Lc/c/a/d;->a(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    return-object v0
.end method

.method public e()Z
    .locals 2

    const-string v0, "upload result xml file start"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    const-string v1, "UploadTestResult"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/ape/offlinescriptmanager/utils/l/h$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/utils/l/h$a;-><init>(Lcom/ape/offlinescriptmanager/utils/l/h;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    sget-boolean v0, Lcom/ape/offlinescriptmanager/utils/l/h;->c:Z

    return v0
.end method
