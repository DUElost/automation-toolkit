.class Landroidx/fragment/app/g$b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/fragment/app/g$b;->onAnimationEnd(Landroid/view/animation/Animation;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Landroidx/fragment/app/g$b;


# direct methods
.method constructor <init>(Landroidx/fragment/app/g$b;)V
    .locals 0

    iput-object p1, p0, Landroidx/fragment/app/g$b$a;->b:Landroidx/fragment/app/g$b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Landroidx/fragment/app/g$b$a;->b:Landroidx/fragment/app/g$b;

    iget-object v0, v0, Landroidx/fragment/app/g$b;->c:Landroidx/fragment/app/Fragment;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->i()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroidx/fragment/app/g$b$a;->b:Landroidx/fragment/app/g$b;

    iget-object v0, v0, Landroidx/fragment/app/g$b;->c:Landroidx/fragment/app/Fragment;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroidx/fragment/app/Fragment;->X0(Landroid/view/View;)V

    iget-object v0, p0, Landroidx/fragment/app/g$b$a;->b:Landroidx/fragment/app/g$b;

    iget-object v1, v0, Landroidx/fragment/app/g$b;->d:Landroidx/fragment/app/g;

    iget-object v2, v0, Landroidx/fragment/app/g$b;->c:Landroidx/fragment/app/Fragment;

    invoke-virtual {v2}, Landroidx/fragment/app/Fragment;->C()I

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual/range {v1 .. v6}, Landroidx/fragment/app/g;->J0(Landroidx/fragment/app/Fragment;IIIZ)V

    :cond_0
    return-void
.end method
