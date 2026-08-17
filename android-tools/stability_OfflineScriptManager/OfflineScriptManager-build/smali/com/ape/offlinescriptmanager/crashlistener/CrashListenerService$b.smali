.class Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->j()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :goto_0
    sget-boolean v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->h:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->b:Landroid/app/ActivityManager;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/app/ActivityManager;->getProcessesInErrorState()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    iget v1, v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->c:I

    if-eq v0, v1, :cond_0

    const-string v1, "crash"

    const-string v2, "takeScreenShot"

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/j;->b(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->m()V

    :cond_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    iput v0, v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->c:I

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    const/4 v1, 0x0

    iput v1, v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->c:I

    :cond_2
    :goto_1
    :try_start_0
    const-string v0, "offlinescriptmanager"

    const-string v1, "crash listener is running"

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/j;->b(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->c(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-virtual {v0}, Landroid/app/Service;->stopSelf()V

    return-void
.end method
