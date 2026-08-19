.class Lcom/ape/offlinescriptmanager/view/c/e/c$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/h/a/a/c/a$c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/e/c;->x(Lb/h/a/a/c/a;Lb/b/a/a/d/f$a;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/view/c/e/c;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$b;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lb/h/a/a/c/a;Ljava/lang/Object;)Z
    .locals 3

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$b;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-virtual {p2}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onLongClick: node id = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->f()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "HolderTask"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p2}, Lb/h/a/a/d/a;->p()Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    invoke-virtual {p2, v1}, Lb/h/a/a/d/a;->u(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$b;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->o(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$b;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/e/c;->p()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1}, Lb/h/a/a/c/a;->f()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/c/b;

    invoke-virtual {p2, p1, v0}, Lcom/ape/offlinescriptmanager/view/c/e/c;->H(Lb/h/a/a/c/a;Lb/b/a/a/c/b;)V

    :goto_0
    return v1
.end method
