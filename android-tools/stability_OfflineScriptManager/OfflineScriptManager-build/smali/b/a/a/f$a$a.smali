.class Lb/a/a/f$a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/a/a/f$a;->onGlobalLayout()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:I

.field final synthetic c:Lb/a/a/f$a;


# direct methods
.method constructor <init>(Lb/a/a/f$a;I)V
    .locals 0

    iput-object p1, p0, Lb/a/a/f$a$a;->c:Lb/a/a/f$a;

    iput p2, p0, Lb/a/a/f$a$a;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lb/a/a/f$a$a;->c:Lb/a/a/f$a;

    iget-object v0, v0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v0, v0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->requestFocus()Z

    iget-object v0, p0, Lb/a/a/f$a$a;->c:Lb/a/a/f$a;

    iget-object v0, v0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v0, v0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, v0, Lb/a/a/f$d;->Y:Landroidx/recyclerview/widget/RecyclerView$o;

    iget v1, p0, Lb/a/a/f$a$a;->b:I

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView$o;->u1(I)V

    return-void
.end method
