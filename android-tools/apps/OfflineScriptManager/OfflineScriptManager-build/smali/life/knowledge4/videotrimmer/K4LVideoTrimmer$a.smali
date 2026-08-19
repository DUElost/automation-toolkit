.class Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llife/knowledge4/videotrimmer/K4LVideoTrimmer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;


# direct methods
.method constructor <init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .locals 3

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/VideoView;->isPlaying()Z

    move-result p1

    const/4 v0, 0x2

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->g(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/ImageView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeMessages(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/VideoView;->pause()V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->g(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/ImageView;

    move-result-object p1

    const/16 v2, 0x8

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->m(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1, v1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->n(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Z)Z

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object p1

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/widget/VideoView;->seekTo(I)V

    :cond_1
    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;->a:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/VideoView;->start()V

    :goto_0
    const/4 p1, 0x1

    return p1
.end method
