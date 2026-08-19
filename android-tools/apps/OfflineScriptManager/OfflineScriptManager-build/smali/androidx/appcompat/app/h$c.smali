.class final Landroidx/appcompat/app/h$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroidx/appcompat/view/menu/o$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/appcompat/app/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "c"
.end annotation


# instance fields
.field private b:Z

.field final synthetic c:Landroidx/appcompat/app/h;


# direct methods
.method constructor <init>(Landroidx/appcompat/app/h;)V
    .locals 0

    iput-object p1, p0, Landroidx/appcompat/app/h$c;->c:Landroidx/appcompat/app/h;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b(Landroidx/appcompat/view/menu/h;Z)V
    .locals 1

    iget-boolean p2, p0, Landroidx/appcompat/app/h$c;->b:Z

    if-eqz p2, :cond_0

    return-void

    :cond_0
    const/4 p2, 0x1

    iput-boolean p2, p0, Landroidx/appcompat/app/h$c;->b:Z

    iget-object p2, p0, Landroidx/appcompat/app/h$c;->c:Landroidx/appcompat/app/h;

    iget-object p2, p2, Landroidx/appcompat/app/h;->a:Landroidx/appcompat/widget/y;

    invoke-interface {p2}, Landroidx/appcompat/widget/y;->h()V

    iget-object p2, p0, Landroidx/appcompat/app/h$c;->c:Landroidx/appcompat/app/h;

    iget-object p2, p2, Landroidx/appcompat/app/h;->c:Landroid/view/Window$Callback;

    if-eqz p2, :cond_1

    const/16 v0, 0x6c

    invoke-interface {p2, v0, p1}, Landroid/view/Window$Callback;->onPanelClosed(ILandroid/view/Menu;)V

    :cond_1
    const/4 p1, 0x0

    iput-boolean p1, p0, Landroidx/appcompat/app/h$c;->b:Z

    return-void
.end method

.method public c(Landroidx/appcompat/view/menu/h;)Z
    .locals 2

    iget-object v0, p0, Landroidx/appcompat/app/h$c;->c:Landroidx/appcompat/app/h;

    iget-object v0, v0, Landroidx/appcompat/app/h;->c:Landroid/view/Window$Callback;

    if-eqz v0, :cond_0

    const/16 v1, 0x6c

    invoke-interface {v0, v1, p1}, Landroid/view/Window$Callback;->onMenuOpened(ILandroid/view/Menu;)Z

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
