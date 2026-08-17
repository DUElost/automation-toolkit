.class Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroidx/viewpager/widget/ViewPager$j;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->Y(Landroidx/viewpager/widget/ViewPager;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$c;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public c(IFI)V
    .locals 0

    return-void
.end method

.method public f(I)V
    .locals 0

    return-void
.end method

.method public j(I)V
    .locals 1

    if-eqz p1, :cond_1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$c;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->O(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;->k()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$c;->b:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->O(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;->t()V

    :goto_0
    return-void
.end method
