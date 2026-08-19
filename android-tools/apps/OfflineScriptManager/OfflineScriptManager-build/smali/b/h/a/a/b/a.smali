.class public Lb/h/a/a/b/a;
.super Lb/h/a/a/c/a$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lb/h/a/a/c/a$a<",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# virtual methods
.method public c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;
    .locals 1

    new-instance p1, Landroid/widget/TextView;

    iget-object v0, p0, Lb/h/a/a/c/a$a;->e:Landroid/content/Context;

    invoke-direct {p1, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-object p1
.end method

.method public l(Z)V
    .locals 0

    return-void
.end method
