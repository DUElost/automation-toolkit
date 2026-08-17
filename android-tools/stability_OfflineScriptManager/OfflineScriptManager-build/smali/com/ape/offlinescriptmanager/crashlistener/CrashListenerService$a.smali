.class Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/Notification$Action;

.field final synthetic b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;Landroid/app/Notification$Action;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;->a:Landroid/app/Notification$Action;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService$a;->a:Landroid/app/Notification$Action;

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->a(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "crash:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p1

    const/16 v1, 0x1b59

    invoke-static {v0, p1, v1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->b(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;Landroid/app/Notification;I)V

    return-void
.end method
