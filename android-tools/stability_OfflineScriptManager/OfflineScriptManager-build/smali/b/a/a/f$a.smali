.class Lb/a/a/f$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/a/a/f;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lb/a/a/f;


# direct methods
.method constructor <init>(Lb/a/a/f;)V
    .locals 0

    iput-object p1, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onGlobalLayout()V
    .locals 4

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x10

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v0, v0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeGlobalOnLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v0, v0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    :goto_0
    iget-object v0, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v1, v0, Lb/a/a/f;->t:Lb/a/a/f$l;

    sget-object v2, Lb/a/a/f$l;->c:Lb/a/a/f$l;

    if-eq v1, v2, :cond_1

    sget-object v3, Lb/a/a/f$l;->d:Lb/a/a/f$l;

    if-ne v1, v3, :cond_5

    :cond_1
    if-ne v1, v2, :cond_2

    iget-object v0, v0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v0, v0, Lb/a/a/f$d;->O:I

    if-gez v0, :cond_4

    return-void

    :cond_2
    iget-object v0, v0, Lb/a/a/f;->u:Ljava/util/List;

    if-eqz v0, :cond_5

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_3

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v0, v0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    iget-object v0, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v0, v0, Lb/a/a/f;->u:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :cond_4
    iget-object v1, p0, Lb/a/a/f$a;->b:Lb/a/a/f;

    iget-object v1, v1, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v2, Lb/a/a/f$a$a;

    invoke-direct {v2, p0, v0}, Lb/a/a/f$a$a;-><init>(Lb/a/a/f$a;I)V

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->post(Ljava/lang/Runnable;)Z

    :cond_5
    :goto_1
    return-void
.end method
