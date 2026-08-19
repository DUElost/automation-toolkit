.class Landroidx/fragment/app/b$a;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/fragment/app/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroidx/fragment/app/b;


# direct methods
.method constructor <init>(Landroidx/fragment/app/b;)V
    .locals 0

    iput-object p1, p0, Landroidx/fragment/app/b$a;->a:Landroidx/fragment/app/b;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Landroidx/fragment/app/b$a;->a:Landroidx/fragment/app/b;

    invoke-virtual {p1}, Landroidx/fragment/app/b;->x()V

    iget-object p1, p0, Landroidx/fragment/app/b$a;->a:Landroidx/fragment/app/b;

    iget-object p1, p1, Landroidx/fragment/app/b;->d:Landroidx/fragment/app/d;

    invoke-virtual {p1}, Landroidx/fragment/app/d;->s()Z

    :goto_0
    return-void
.end method
