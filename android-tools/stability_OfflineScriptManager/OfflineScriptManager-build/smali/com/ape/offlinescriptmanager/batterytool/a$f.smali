.class final Lcom/ape/offlinescriptmanager/batterytool/a$f;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/batterytool/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "f"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/batterytool/a;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/a;Landroid/os/Looper;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$f;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1

    iget p1, p1, Landroid/os/Message;->what:I

    const/4 v0, 0x1

    if-eq p1, v0, :cond_1

    const/4 v0, 0x3

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$f;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/batterytool/a;->v1()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$f;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/a;->l1(Lcom/ape/offlinescriptmanager/batterytool/a;)V

    :goto_0
    return-void
.end method
