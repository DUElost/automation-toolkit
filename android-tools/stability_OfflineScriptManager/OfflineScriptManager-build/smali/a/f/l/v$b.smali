.class La/f/l/v$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/f/l/v;->i(La/f/l/y;)La/f/l/v;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:La/f/l/y;

.field final synthetic b:Landroid/view/View;


# direct methods
.method constructor <init>(La/f/l/v;La/f/l/y;Landroid/view/View;)V
    .locals 0

    iput-object p2, p0, La/f/l/v$b;->a:La/f/l/y;

    iput-object p3, p0, La/f/l/v$b;->b:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 1

    iget-object p1, p0, La/f/l/v$b;->a:La/f/l/y;

    iget-object v0, p0, La/f/l/v$b;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/f/l/y;->a(Landroid/view/View;)V

    return-void
.end method
