.class public Lcom/ape/offlinescriptmanager/view/testcase/a;
.super Lcom/jude/easyrecyclerview/d/d;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/view/testcase/a$b;,
        Lcom/ape/offlinescriptmanager/view/testcase/a$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/jude/easyrecyclerview/d/d<",
        "Lb/b/a/a/d/b;",
        ">;"
    }
.end annotation


# instance fields
.field private l:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/jude/easyrecyclerview/d/d;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a;->l:Landroid/content/Context;

    return-void
.end method

.method static synthetic U(Lcom/ape/offlinescriptmanager/view/testcase/a;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a;->l:Landroid/content/Context;

    return-object p0
.end method


# virtual methods
.method public w(Landroid/view/ViewGroup;I)Lcom/jude/easyrecyclerview/d/a;
    .locals 2

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0c0050

    const/4 v1, 0x0

    invoke-virtual {p2, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/view/testcase/a$b;

    invoke-direct {p2, p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/a$b;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/a;Landroid/view/View;)V

    return-object p2
.end method
