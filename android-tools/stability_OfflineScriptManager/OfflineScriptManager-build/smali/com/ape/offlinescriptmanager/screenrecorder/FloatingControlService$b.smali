.class Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/animation/Animator$AnimatorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->f()V
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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$b;->a:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 0

    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService$b;->a:Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;->a(Lcom/ape/offlinescriptmanager/screenrecorder/FloatingControlService;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public onAnimationRepeat(Landroid/animation/Animator;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 0

    return-void
.end method
