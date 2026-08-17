.class Lcom/ape/offlinescriptmanager/batterytool/g/b$a;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/batterytool/g/b;-><init>(Landroid/content/Context;Ljava/lang/String;ZZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/batterytool/g/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/g/b;Landroid/os/Looper;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 9

    iget p1, p1, Landroid/os/Message;->what:I

    const/4 v0, 0x4

    const/4 v1, 0x1

    if-eq p1, v0, :cond_2

    const/4 v0, 0x5

    if-eq p1, v0, :cond_0

    goto :goto_1

    :cond_0
    :try_start_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    iget-object v3, v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v4, v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    iget-object p1, v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->j(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, p1, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->g(Lcom/ape/offlinescriptmanager/batterytool/g/b;ILjava/lang/String;)Lorg/achartengine/h/d;

    move-result-object v5

    const-string v6, ""

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;

    move-result-object v7

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->j(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual/range {v2 .. v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->d(Ljava/util/List;Ljava/util/List;Lorg/achartengine/h/d;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {p1, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i(Lcom/ape/offlinescriptmanager/batterytool/g/b;Z)Z

    goto :goto_1

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i(Lcom/ape/offlinescriptmanager/batterytool/g/b;Z)Z

    throw p1

    :cond_2
    :try_start_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    iget-object v3, v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v4, v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    iget-object p1, v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->f(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, p1, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->g(Lcom/ape/offlinescriptmanager/batterytool/g/b;ILjava/lang/String;)Lorg/achartengine/h/d;

    move-result-object v5

    const-string v6, ""

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;

    move-result-object v7

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->f(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual/range {v2 .. v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->d(Ljava/util/List;Ljava/util/List;Lorg/achartengine/h/d;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :goto_1
    return-void

    :catchall_1
    move-exception p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;->a:Lcom/ape/offlinescriptmanager/batterytool/g/b;

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i(Lcom/ape/offlinescriptmanager/batterytool/g/b;Z)Z

    throw p1
.end method
