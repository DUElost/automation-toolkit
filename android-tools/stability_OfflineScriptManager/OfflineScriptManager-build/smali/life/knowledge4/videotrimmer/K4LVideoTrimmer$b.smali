.class Llife/knowledge4/videotrimmer/K4LVideoTrimmer$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llife/knowledge4/videotrimmer/K4LVideoTrimmer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;


# direct methods
.method constructor <init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$b;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 0

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$b;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->q(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/view/GestureDetector;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    const/4 p1, 0x1

    return p1
.end method
