.class Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llife/knowledge4/videotrimmer/K4LVideoTrimmer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "f"
.end annotation


# instance fields
.field private final a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Llife/knowledge4/videotrimmer/K4LVideoTrimmer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V
    .locals 1

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;->a:Ljava/lang/ref/WeakReference;

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    if-eqz p1, :cond_1

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    invoke-static {p1, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->k(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Z)V

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/VideoView;->isPlaying()Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x0

    const-wide/16 v0, 0xa

    invoke-virtual {p0, p1, v0, v1}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z

    :cond_1
    :goto_0
    return-void
.end method
