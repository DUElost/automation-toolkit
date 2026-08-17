.class final Lcom/ape/offlinescriptmanager/crashlistener/d/b$d;
.super Landroidx/recyclerview/widget/RecyclerView$c0;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/crashlistener/d/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "d"
.end annotation


# instance fields
.field private u:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/d/b;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p2}, Landroidx/recyclerview/widget/RecyclerView$c0;-><init>(Landroid/view/View;)V

    const p1, 0x7f090173

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$d;->u:Landroid/widget/TextView;

    return-void
.end method

.method static synthetic M(Lcom/ape/offlinescriptmanager/crashlistener/d/b$d;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$d;->u:Landroid/widget/TextView;

    return-object p0
.end method
