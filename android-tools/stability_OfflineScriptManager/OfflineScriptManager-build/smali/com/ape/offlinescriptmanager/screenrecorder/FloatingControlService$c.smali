.class Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->l(II)Landroid/animation/ValueAnimator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$c;->a:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 1

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$c;->a:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->a(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$c;->a:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->a(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
