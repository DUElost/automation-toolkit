.class public abstract Landroidx/fragment/app/e;
.super Landroidx/fragment/app/c;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<E:",
        "Ljava/lang/Object;",
        ">",
        "Landroidx/fragment/app/c;"
    }
.end annotation


# instance fields
.field private final a:Landroid/app/Activity;

.field private final b:Landroid/content/Context;

.field private final c:Landroid/os/Handler;

.field final d:Landroidx/fragment/app/g;


# direct methods
.method constructor <init>(Landroid/app/Activity;Landroid/content/Context;Landroid/os/Handler;I)V
    .locals 0

    invoke-direct {p0}, Landroidx/fragment/app/c;-><init>()V

    new-instance p4, Landroidx/fragment/app/g;

    invoke-direct {p4}, Landroidx/fragment/app/g;-><init>()V

    iput-object p4, p0, Landroidx/fragment/app/e;->d:Landroidx/fragment/app/g;

    iput-object p1, p0, Landroidx/fragment/app/e;->a:Landroid/app/Activity;

    const-string p1, "context == null"

    invoke-static {p2, p1}, La/f/k/g;->c(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    check-cast p2, Landroid/content/Context;

    iput-object p2, p0, Landroidx/fragment/app/e;->b:Landroid/content/Context;

    const-string p1, "handler == null"

    invoke-static {p3, p1}, La/f/k/g;->c(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    check-cast p3, Landroid/os/Handler;

    iput-object p3, p0, Landroidx/fragment/app/e;->c:Landroid/os/Handler;

    return-void
.end method

.method constructor <init>(Landroidx/fragment/app/b;)V
    .locals 2

    iget-object v0, p1, Landroidx/fragment/app/b;->c:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-direct {p0, p1, p1, v0, v1}, Landroidx/fragment/app/e;-><init>(Landroid/app/Activity;Landroid/content/Context;Landroid/os/Handler;I)V

    return-void
.end method


# virtual methods
.method d()Landroid/app/Activity;
    .locals 1

    iget-object v0, p0, Landroidx/fragment/app/e;->a:Landroid/app/Activity;

    return-object v0
.end method

.method e()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Landroidx/fragment/app/e;->b:Landroid/content/Context;

    return-object v0
.end method

.method f()Landroidx/fragment/app/g;
    .locals 1

    iget-object v0, p0, Landroidx/fragment/app/e;->d:Landroidx/fragment/app/g;

    return-object v0
.end method

.method g()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Landroidx/fragment/app/e;->c:Landroid/os/Handler;

    return-object v0
.end method

.method abstract h(Landroidx/fragment/app/Fragment;)V
.end method

.method public abstract i(Ljava/lang/String;Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
.end method

.method public abstract j()Landroid/view/LayoutInflater;
.end method

.method public abstract k()I
.end method

.method public abstract l()Z
.end method

.method public abstract m(Landroidx/fragment/app/Fragment;)Z
.end method

.method public abstract n(Landroidx/fragment/app/Fragment;Landroid/content/Intent;ILandroid/os/Bundle;)V
.end method

.method public abstract o()V
.end method
