.class public Lcom/ape/offlinescriptmanager/view/b/c;
.super Lcom/jude/easyrecyclerview/d/d;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/jude/easyrecyclerview/d/d<",
        "Lb/b/a/a/d/f;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/d/d;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public w(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;
    .locals 2

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0c0051

    const/4 v1, 0x0

    invoke-virtual {p2, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/view/b/b;

    invoke-direct {p2, p1}, Lcom/ape/offlinescriptmanager/view/b/b;-><init>(Landroid/view/View;)V

    return-object p2
.end method
