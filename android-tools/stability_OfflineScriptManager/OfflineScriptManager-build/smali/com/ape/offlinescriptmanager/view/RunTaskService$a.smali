.class Lcom/ape/offlinescriptmanager/view/RunTaskService$a;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/RunTaskService;->o()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/NotificationManager;

.field final synthetic b:Lcom/ape/offlinescriptmanager/view/RunTaskService;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/RunTaskService;Landroid/os/Looper;Landroid/app/NotificationManager;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->a:Landroid/app/NotificationManager;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 5

    iget-object p1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "Pass"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/16 v1, 0x271a

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    :goto_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->a:Landroid/app/NotificationManager;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    goto :goto_1

    :cond_0
    const-string v0, "Finished"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->a:Landroid/app/NotificationManager;

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->g(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->a:Landroid/app/NotificationManager;

    const/16 v0, 0x271b

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->g(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    goto :goto_1

    :cond_1
    const-string v0, "Current"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, ":"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x0

    aget-object v4, p1, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v0, 0x1

    aget-object v4, p1, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/view/RunTaskService$a;->b:Lcom/ape/offlinescriptmanager/view/RunTaskService;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/view/RunTaskService;->f(Lcom/ape/offlinescriptmanager/view/RunTaskService;)Landroid/app/Notification$Builder;

    move-result-object v2

    aget-object p1, p1, v0

    invoke-virtual {v2, p1}, Landroid/app/Notification$Builder;->setSubText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method
