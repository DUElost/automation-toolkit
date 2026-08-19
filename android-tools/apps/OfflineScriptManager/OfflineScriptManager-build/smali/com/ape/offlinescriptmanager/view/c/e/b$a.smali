.class Lcom/ape/offlinescriptmanager/view/c/e/b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/e/b;->x(Lb/h/a/a/c/a;Lb/b/a/a/d/f$a;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lb/h/a/a/c/a;

.field final synthetic b:Lcom/ape/offlinescriptmanager/view/c/e/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/b;Lb/h/a/a/c/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b$a;->b:Lcom/ape/offlinescriptmanager/view/c/e/b;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/b$a;->a:Lb/h/a/a/c/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b$a;->b:Lcom/ape/offlinescriptmanager/view/c/e/b;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/view/c/e/b;->K(Lcom/ape/offlinescriptmanager/view/c/e/b;Z)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b$a;->a:Lb/h/a/a/c/a;

    invoke-virtual {p1, p2}, Lb/h/a/a/c/a;->t(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b$a;->a:Lb/h/a/a/c/a;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->d()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/h/a/a/c/a;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/view/c/e/b$a;->b:Lcom/ape/offlinescriptmanager/view/c/e/b;

    invoke-virtual {v1}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Lb/h/a/a/d/a;->s(Lb/h/a/a/c/a;Z)V

    goto :goto_0

    :cond_0
    return-void
.end method
