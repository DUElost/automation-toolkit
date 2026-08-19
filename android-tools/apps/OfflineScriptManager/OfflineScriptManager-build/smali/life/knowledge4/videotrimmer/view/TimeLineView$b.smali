.class Llife/knowledge4/videotrimmer/view/TimeLineView$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llife/knowledge4/videotrimmer/view/TimeLineView;->g(Landroid/util/LongSparseArray;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Landroid/util/LongSparseArray;

.field final synthetic c:Llife/knowledge4/videotrimmer/view/TimeLineView;


# direct methods
.method constructor <init>(Llife/knowledge4/videotrimmer/view/TimeLineView;Landroid/util/LongSparseArray;)V
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/view/TimeLineView$b;->c:Llife/knowledge4/videotrimmer/view/TimeLineView;

    iput-object p2, p0, Llife/knowledge4/videotrimmer/view/TimeLineView$b;->b:Landroid/util/LongSparseArray;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/TimeLineView$b;->c:Llife/knowledge4/videotrimmer/view/TimeLineView;

    iget-object v1, p0, Llife/knowledge4/videotrimmer/view/TimeLineView$b;->b:Landroid/util/LongSparseArray;

    invoke-static {v0, v1}, Llife/knowledge4/videotrimmer/view/TimeLineView;->d(Llife/knowledge4/videotrimmer/view/TimeLineView;Landroid/util/LongSparseArray;)Landroid/util/LongSparseArray;

    iget-object v0, p0, Llife/knowledge4/videotrimmer/view/TimeLineView$b;->c:Llife/knowledge4/videotrimmer/view/TimeLineView;

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    return-void
.end method
