.class public Lb/d/a/a/m/b;
.super Landroid/widget/FrameLayout;
.source ""

# interfaces
.implements Lb/d/a/a/m/d;


# instance fields
.field private final b:Lb/d/a/a/m/c;


# virtual methods
.method public a()V
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0}, Lb/d/a/a/m/c;->a()V

    return-void
.end method

.method public b()V
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0}, Lb/d/a/a/m/c;->b()V

    return-void
.end method

.method public draw(Landroid/graphics/Canvas;)V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "MissingSuperCall"
        }
    .end annotation

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lb/d/a/a/m/c;->c(Landroid/graphics/Canvas;)V

    goto :goto_0

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->draw(Landroid/graphics/Canvas;)V

    :goto_0
    return-void
.end method

.method public getCircularRevealOverlayDrawable()Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0}, Lb/d/a/a/m/c;->d()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public getCircularRevealScrimColor()I
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0}, Lb/d/a/a/m/c;->e()I

    move-result v0

    return v0
.end method

.method public getRevealInfo()Lb/d/a/a/m/d$e;
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0}, Lb/d/a/a/m/c;->f()Lb/d/a/a/m/d$e;

    move-result-object v0

    return-object v0
.end method

.method public isOpaque()Z
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lb/d/a/a/m/c;->g()Z

    move-result v0

    return v0

    :cond_0
    invoke-super {p0}, Landroid/widget/FrameLayout;->isOpaque()Z

    move-result v0

    return v0
.end method

.method public setCircularRevealOverlayDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0, p1}, Lb/d/a/a/m/c;->h(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public setCircularRevealScrimColor(I)V
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0, p1}, Lb/d/a/a/m/c;->i(I)V

    return-void
.end method

.method public setRevealInfo(Lb/d/a/a/m/d$e;)V
    .locals 1

    iget-object v0, p0, Lb/d/a/a/m/b;->b:Lb/d/a/a/m/c;

    invoke-virtual {v0, p1}, Lb/d/a/a/m/c;->j(Lb/d/a/a/m/d$e;)V

    return-void
.end method
