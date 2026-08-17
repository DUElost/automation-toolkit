.class Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->onStartCommand(Landroid/content/Intent;II)I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private b:Landroid/view/WindowManager$LayoutParams;

.field private c:I

.field private d:I

.field private e:F

.field private f:F

.field g:Z

.field final synthetic h:Landroid/view/WindowManager$LayoutParams;

.field final synthetic i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;Landroid/view/WindowManager$LayoutParams;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->h:Landroid/view/WindowManager$LayoutParams;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->b:Landroid/view/WindowManager$LayoutParams;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->g:Z

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 4

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_5

    const/4 v1, 0x1

    if-eq p1, v1, :cond_3

    const/4 v2, 0x2

    if-eq p1, v2, :cond_0

    goto/16 :goto_0

    :cond_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result p1

    iget v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->e:F

    sub-float/2addr p1, v2

    float-to-int p1, p1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result p2

    iget v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->f:F

    sub-float/2addr p2, v2

    float-to-int p2, p2

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->b:Landroid/view/WindowManager$LayoutParams;

    iget v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->c:I

    add-int/2addr v3, p1

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    iget v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->d:I

    add-int/2addr v3, p2

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-static {p1}, Ljava/lang/Math;->abs(I)I

    move-result p1

    const/16 v2, 0xa

    if-gt p1, v2, :cond_1

    invoke-static {p2}, Ljava/lang/Math;->abs(I)I

    move-result p1

    if-le p1, v2, :cond_2

    :cond_1
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->g:Z

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->e(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/WindowManager;

    move-result-object p1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->d(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/widget/LinearLayout;

    move-result-object p2

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {p1, p2, v1}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    :cond_3
    iget-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->g:Z

    if-nez p1, :cond_6

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->a(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    const/4 p2, 0x4

    if-ne p1, p2, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->b(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V

    goto :goto_0

    :cond_4
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->i:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->c(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V

    goto :goto_0

    :cond_5
    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->g:Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->c:I

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->d:I

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result p1

    iput p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->e:F

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result p1

    iput p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$a;->f:F

    :cond_6
    :goto_0
    return v0
.end method
