.class public La/a/m/f;
.super Landroid/view/ActionMode;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        La/a/m/f$a;
    }
.end annotation


# instance fields
.field final a:Landroid/content/Context;

.field final b:La/a/m/b;


# direct methods
.method public constructor <init>(Landroid/content/Context;La/a/m/b;)V
    .locals 0

    invoke-direct {p0}, Landroid/view/ActionMode;-><init>()V

    iput-object p1, p0, La/a/m/f;->a:Landroid/content/Context;

    iput-object p2, p0, La/a/m/f;->b:La/a/m/b;

    return-void
.end method


# virtual methods
.method public finish()V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->c()V

    return-void
.end method

.method public getCustomView()Landroid/view/View;
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->d()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getMenu()Landroid/view/Menu;
    .locals 2

    iget-object v0, p0, La/a/m/f;->a:Landroid/content/Context;

    iget-object v1, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v1}, La/a/m/b;->e()Landroid/view/Menu;

    move-result-object v1

    check-cast v1, La/f/f/a/a;

    invoke-static {v0, v1}, Landroidx/appcompat/view/menu/q;->a(Landroid/content/Context;La/f/f/a/a;)Landroid/view/Menu;

    move-result-object v0

    return-object v0
.end method

.method public getMenuInflater()Landroid/view/MenuInflater;
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->f()Landroid/view/MenuInflater;

    move-result-object v0

    return-object v0
.end method

.method public getSubtitle()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->g()Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method public getTag()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->h()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getTitle()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->i()Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method public getTitleOptionalHint()Z
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->j()Z

    move-result v0

    return v0
.end method

.method public invalidate()V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->k()V

    return-void
.end method

.method public isTitleOptional()Z
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0}, La/a/m/b;->l()Z

    move-result v0

    return v0
.end method

.method public setCustomView(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->m(Landroid/view/View;)V

    return-void
.end method

.method public setSubtitle(I)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->n(I)V

    return-void
.end method

.method public setSubtitle(Ljava/lang/CharSequence;)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->o(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setTag(Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->p(Ljava/lang/Object;)V

    return-void
.end method

.method public setTitle(I)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->q(I)V

    return-void
.end method

.method public setTitle(Ljava/lang/CharSequence;)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->r(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setTitleOptionalHint(Z)V
    .locals 1

    iget-object v0, p0, La/a/m/f;->b:La/a/m/b;

    invoke-virtual {v0, p1}, La/a/m/b;->s(Z)V

    return-void
.end method
