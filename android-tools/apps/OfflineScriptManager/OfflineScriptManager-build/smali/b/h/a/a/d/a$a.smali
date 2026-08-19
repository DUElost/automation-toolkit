.class Lb/h/a/a/d/a$a;
.super Lb/h/a/a/c/a$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/h/a/a/d/a;->n(I)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic f:Landroid/widget/LinearLayout;


# direct methods
.method constructor <init>(Lb/h/a/a/d/a;Landroid/content/Context;Landroid/widget/LinearLayout;)V
    .locals 0

    iput-object p3, p0, Lb/h/a/a/d/a$a;->f:Landroid/widget/LinearLayout;

    invoke-direct {p0, p2}, Lb/h/a/a/c/a$a;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public c(Lb/h/a/a/c/a;Ljava/lang/Object;)Landroid/view/View;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public e()Landroid/view/ViewGroup;
    .locals 1

    iget-object v0, p0, Lb/h/a/a/d/a$a;->f:Landroid/widget/LinearLayout;

    return-object v0
.end method
