.class final Lcom/ape/offlinescriptmanager/batterytool/b$c;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/batterytool/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "c"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/batterytool/b;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/b;Landroid/os/Looper;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/b$c;->a:Lcom/ape/offlinescriptmanager/batterytool/b;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Thread Tag handleMessage:---"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getId()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/b$c;->a:Lcom/ape/offlinescriptmanager/batterytool/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/b;->l1(Lcom/ape/offlinescriptmanager/batterytool/b;)V

    return-void
.end method
