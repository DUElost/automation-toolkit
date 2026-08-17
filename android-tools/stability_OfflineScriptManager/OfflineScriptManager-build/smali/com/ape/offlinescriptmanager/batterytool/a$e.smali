.class Lcom/ape/offlinescriptmanager/batterytool/a$e;
.super Landroid/database/ContentObserver;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/batterytool/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "e"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/batterytool/a;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/a;Landroid/os/Handler;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$e;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    return-void
.end method


# virtual methods
.method public onChange(Z)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$e;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/a;->n1(Lcom/ape/offlinescriptmanager/batterytool/a;)Lcom/ape/offlinescriptmanager/batterytool/a$f;

    move-result-object p1

    invoke-virtual {p1}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object p1

    const/4 v0, 0x3

    iput v0, p1, Landroid/os/Message;->what:I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a$e;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/batterytool/a;->n1(Lcom/ape/offlinescriptmanager/batterytool/a;)Lcom/ape/offlinescriptmanager/batterytool/a$f;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method
