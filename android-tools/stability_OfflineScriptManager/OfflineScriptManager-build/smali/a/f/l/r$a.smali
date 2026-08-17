.class final La/f/l/r$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/f/l/r;->b0(Landroid/view/View;La/f/l/o;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:La/f/l/o;


# direct methods
.method constructor <init>(La/f/l/o;)V
    .locals 0

    iput-object p1, p0, La/f/l/r$a;->a:La/f/l/o;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 1

    invoke-static {p2}, La/f/l/z;->h(Ljava/lang/Object;)La/f/l/z;

    move-result-object p2

    iget-object v0, p0, La/f/l/r$a;->a:La/f/l/o;

    invoke-interface {v0, p1, p2}, La/f/l/o;->a(Landroid/view/View;La/f/l/z;)La/f/l/z;

    move-result-object p1

    invoke-static {p1}, La/f/l/z;->g(La/f/l/z;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/WindowInsets;

    return-object p1
.end method
