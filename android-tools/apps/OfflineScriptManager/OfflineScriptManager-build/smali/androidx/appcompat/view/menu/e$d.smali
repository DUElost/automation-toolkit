.class Landroidx/appcompat/view/menu/e$d;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/appcompat/view/menu/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "d"
.end annotation


# instance fields
.field public final a:Landroidx/appcompat/widget/g0;

.field public final b:Landroidx/appcompat/view/menu/h;

.field public final c:I


# direct methods
.method public constructor <init>(Landroidx/appcompat/widget/g0;Landroidx/appcompat/view/menu/h;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/appcompat/view/menu/e$d;->a:Landroidx/appcompat/widget/g0;

    iput-object p2, p0, Landroidx/appcompat/view/menu/e$d;->b:Landroidx/appcompat/view/menu/h;

    iput p3, p0, Landroidx/appcompat/view/menu/e$d;->c:I

    return-void
.end method


# virtual methods
.method public a()Landroid/widget/ListView;
    .locals 1

    iget-object v0, p0, Landroidx/appcompat/view/menu/e$d;->a:Landroidx/appcompat/widget/g0;

    invoke-virtual {v0}, Landroidx/appcompat/widget/e0;->g()Landroid/widget/ListView;

    move-result-object v0

    return-object v0
.end method
