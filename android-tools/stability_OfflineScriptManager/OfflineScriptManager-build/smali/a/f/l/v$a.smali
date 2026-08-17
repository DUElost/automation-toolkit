.class La/f/l/v$a;
.super Landroid/animation/AnimatorListenerAdapter;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/f/l/v;->g(Landroid/view/View;La/f/l/w;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:La/f/l/w;

.field final synthetic b:Landroid/view/View;


# direct methods
.method constructor <init>(La/f/l/v;La/f/l/w;Landroid/view/View;)V
    .locals 0

    iput-object p2, p0, La/f/l/v$a;->a:La/f/l/w;

    iput-object p3, p0, La/f/l/v$a;->b:Landroid/view/View;

    invoke-direct {p0}, Landroid/animation/AnimatorListenerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/f/l/v$a;->a:La/f/l/w;

    iget-object v0, p0, La/f/l/v$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/f/l/w;->c(Landroid/view/View;)V

    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/f/l/v$a;->a:La/f/l/w;

    iget-object v0, p0, La/f/l/v$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/f/l/w;->a(Landroid/view/View;)V

    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/f/l/v$a;->a:La/f/l/w;

    iget-object v0, p0, La/f/l/v$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/f/l/w;->b(Landroid/view/View;)V

    return-void
.end method
