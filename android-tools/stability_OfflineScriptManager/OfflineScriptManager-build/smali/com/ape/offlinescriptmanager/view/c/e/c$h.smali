.class Lcom/ape/offlinescriptmanager/view/c/e/c$h;
.super Landroid/os/Handler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/view/c/e/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "h"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/view/c/e/c;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$h;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3

    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    iget p1, p1, Landroid/os/Message;->what:I

    const v0, 0x7f090046

    const/4 v1, 0x0

    if-eqz p1, :cond_2

    const/16 v2, 0x3e9

    if-eq p1, v2, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$h;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/c/e/c;->g:Landroid/widget/LinearLayout;

    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$h;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/c/e/c;->g:Landroid/widget/LinearLayout;

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    const/4 p1, 0x1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->s(Z)Z

    goto :goto_0

    :cond_2
    invoke-static {v1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->s(Z)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$h;->a:Lcom/ape/offlinescriptmanager/view/c/e/c;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/c/e/c;->g:Landroid/widget/LinearLayout;

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    return-void
.end method
