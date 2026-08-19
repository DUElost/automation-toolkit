.class La/m/i0$a;
.super Landroid/animation/AnimatorListenerAdapter;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/m/i0;->g0(Landroid/view/ViewGroup;La/m/s;ILa/m/s;I)Landroid/animation/Animator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:La/m/w;

.field final synthetic b:Landroid/view/View;


# direct methods
.method constructor <init>(La/m/i0;La/m/w;Landroid/view/View;)V
    .locals 0

    iput-object p2, p0, La/m/i0$a;->a:La/m/w;

    iput-object p3, p0, La/m/i0$a;->b:Landroid/view/View;

    invoke-direct {p0}, Landroid/animation/AnimatorListenerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/m/i0$a;->a:La/m/w;

    iget-object v0, p0, La/m/i0$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/m/w;->c(Landroid/view/View;)V

    return-void
.end method
