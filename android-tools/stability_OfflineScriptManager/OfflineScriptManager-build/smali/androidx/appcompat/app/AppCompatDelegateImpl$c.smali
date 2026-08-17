.class Landroidx/appcompat/app/AppCompatDelegateImpl$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements La/f/l/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/appcompat/app/AppCompatDelegateImpl;->F()Landroid/view/ViewGroup;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroidx/appcompat/app/AppCompatDelegateImpl;


# direct methods
.method constructor <init>(Landroidx/appcompat/app/AppCompatDelegateImpl;)V
    .locals 0

    iput-object p1, p0, Landroidx/appcompat/app/AppCompatDelegateImpl$c;->a:Landroidx/appcompat/app/AppCompatDelegateImpl;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;La/f/l/z;)La/f/l/z;
    .locals 4

    invoke-virtual {p2}, La/f/l/z;->d()I

    move-result v0

    iget-object v1, p0, Landroidx/appcompat/app/AppCompatDelegateImpl$c;->a:Landroidx/appcompat/app/AppCompatDelegateImpl;

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatDelegateImpl;->w0(I)I

    move-result v1

    if-eq v0, v1, :cond_0

    invoke-virtual {p2}, La/f/l/z;->b()I

    move-result v0

    invoke-virtual {p2}, La/f/l/z;->c()I

    move-result v2

    invoke-virtual {p2}, La/f/l/z;->a()I

    move-result v3

    invoke-virtual {p2, v0, v1, v2, v3}, La/f/l/z;->f(IIII)La/f/l/z;

    move-result-object p2

    :cond_0
    invoke-static {p1, p2}, La/f/l/r;->J(Landroid/view/View;La/f/l/z;)La/f/l/z;

    move-result-object p1

    return-object p1
.end method
