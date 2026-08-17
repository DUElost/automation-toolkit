.class final Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;
.super Landroidx/recyclerview/widget/RecyclerView$c0;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/crashlistener/d/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "c"
.end annotation


# instance fields
.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/ImageView;

.field private w:Landroid/widget/RelativeLayout;

.field private x:Landroid/widget/ImageButton;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/d/b;Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p2}, Landroidx/recyclerview/widget/RecyclerView$c0;-><init>(Landroid/view/View;)V

    const p1, 0x7f0900d4

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->u:Landroid/widget/TextView;

    const p1, 0x7f0901ae

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->v:Landroid/widget/ImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const p1, 0x7f0901d9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/RelativeLayout;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->w:Landroid/widget/RelativeLayout;

    const p1, 0x7f0900e3

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageButton;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->x:Landroid/widget/ImageButton;

    return-void
.end method

.method static synthetic M(Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->u:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic N(Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->v:Landroid/widget/ImageView;

    return-object p0
.end method

.method static synthetic O(Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;)Landroid/widget/ImageButton;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->x:Landroid/widget/ImageButton;

    return-object p0
.end method

.method static synthetic P(Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;)Landroid/widget/RelativeLayout;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/d/b$c;->w:Landroid/widget/RelativeLayout;

    return-object p0
.end method
