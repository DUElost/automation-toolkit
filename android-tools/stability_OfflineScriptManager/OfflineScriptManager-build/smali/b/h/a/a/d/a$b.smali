.class Lb/h/a/a/d/a$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/h/a/a/d/a;->d(Landroid/view/ViewGroup;Lb/h/a/a/c/a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lb/h/a/a/c/a;

.field final synthetic c:Lb/h/a/a/d/a;


# direct methods
.method constructor <init>(Lb/h/a/a/d/a;Lb/h/a/a/c/a;)V
    .locals 0

    iput-object p1, p0, Lb/h/a/a/d/a$b;->c:Lb/h/a/a/d/a;

    iput-object p2, p0, Lb/h/a/a/d/a$b;->b:Lb/h/a/a/c/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lb/h/a/a/d/a$b;->b:Lb/h/a/a/c/a;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->e()Lb/h/a/a/c/a$b;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lb/h/a/a/d/a$b;->b:Lb/h/a/a/c/a;

    invoke-virtual {p1}, Lb/h/a/a/c/a;->e()Lb/h/a/a/c/a$b;

    move-result-object p1

    :goto_0
    iget-object v0, p0, Lb/h/a/a/d/a$b;->b:Lb/h/a/a/c/a;

    invoke-virtual {v0}, Lb/h/a/a/c/a;->i()Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Lb/h/a/a/c/a$b;->a(Lb/h/a/a/c/a;Ljava/lang/Object;)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lb/h/a/a/d/a$b;->c:Lb/h/a/a/d/a;

    invoke-static {p1}, Lb/h/a/a/d/a;->a(Lb/h/a/a/d/a;)Lb/h/a/a/c/a$b;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lb/h/a/a/d/a$b;->c:Lb/h/a/a/d/a;

    invoke-static {p1}, Lb/h/a/a/d/a;->a(Lb/h/a/a/d/a;)Lb/h/a/a/c/a$b;

    move-result-object p1

    goto :goto_0

    :cond_1
    :goto_1
    iget-object p1, p0, Lb/h/a/a/d/a$b;->c:Lb/h/a/a/d/a;

    invoke-static {p1}, Lb/h/a/a/d/a;->b(Lb/h/a/a/d/a;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lb/h/a/a/d/a$b;->c:Lb/h/a/a/d/a;

    iget-object v0, p0, Lb/h/a/a/d/a$b;->b:Lb/h/a/a/c/a;

    invoke-virtual {p1, v0}, Lb/h/a/a/d/a;->v(Lb/h/a/a/c/a;)V

    :cond_2
    return-void
.end method
