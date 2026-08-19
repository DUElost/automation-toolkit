.class Lcom/ape/offlinescriptmanager/batterytool/c$b;
.super Landroid/database/ContentObserver;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/batterytool/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/batterytool/c;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/c;Landroid/os/Handler;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/c$b;->a:Lcom/ape/offlinescriptmanager/batterytool/c;

    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    return-void
.end method


# virtual methods
.method public onChange(Z)V
    .locals 2

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Thread Tag onChange:--------------"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getId()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/c$b;->a:Lcom/ape/offlinescriptmanager/batterytool/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/c;->m1(Lcom/ape/offlinescriptmanager/batterytool/c;)Lcom/ape/offlinescriptmanager/batterytool/c$c;

    move-result-object p1

    invoke-virtual {p1}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object p1

    const/4 v0, 0x2

    iput v0, p1, Landroid/os/Message;->what:I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/c$b;->a:Lcom/ape/offlinescriptmanager/batterytool/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/batterytool/c;->m1(Lcom/ape/offlinescriptmanager/batterytool/c;)Lcom/ape/offlinescriptmanager/batterytool/c$c;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method
