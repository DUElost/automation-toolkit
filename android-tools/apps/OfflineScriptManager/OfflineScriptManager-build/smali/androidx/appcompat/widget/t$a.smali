.class Landroidx/appcompat/widget/t$a;
.super Landroidx/appcompat/widget/c0;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/appcompat/widget/t;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;IILandroid/content/res/Resources$Theme;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic k:Landroidx/appcompat/widget/t$c;

.field final synthetic l:Landroidx/appcompat/widget/t;


# direct methods
.method constructor <init>(Landroidx/appcompat/widget/t;Landroid/view/View;Landroidx/appcompat/widget/t$c;)V
    .locals 0

    iput-object p1, p0, Landroidx/appcompat/widget/t$a;->l:Landroidx/appcompat/widget/t;

    iput-object p3, p0, Landroidx/appcompat/widget/t$a;->k:Landroidx/appcompat/widget/t$c;

    invoke-direct {p0, p2}, Landroidx/appcompat/widget/c0;-><init>(Landroid/view/View;)V

    return-void
.end method


# virtual methods
.method public b()Landroidx/appcompat/view/menu/s;
    .locals 1

    iget-object v0, p0, Landroidx/appcompat/widget/t$a;->k:Landroidx/appcompat/widget/t$c;

    return-object v0
.end method

.method public c()Z
    .locals 1

    iget-object v0, p0, Landroidx/appcompat/widget/t$a;->l:Landroidx/appcompat/widget/t;

    iget-object v0, v0, Landroidx/appcompat/widget/t;->g:Landroidx/appcompat/widget/t$c;

    invoke-virtual {v0}, Landroidx/appcompat/widget/e0;->f()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Landroidx/appcompat/widget/t$a;->l:Landroidx/appcompat/widget/t;

    iget-object v0, v0, Landroidx/appcompat/widget/t;->g:Landroidx/appcompat/widget/t$c;

    invoke-virtual {v0}, Landroidx/appcompat/widget/t$c;->a()V

    :cond_0
    const/4 v0, 0x1

    return v0
.end method
