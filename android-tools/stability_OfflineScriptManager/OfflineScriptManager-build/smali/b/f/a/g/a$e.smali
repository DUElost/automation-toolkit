.class Lb/f/a/g/a$e;
.super Landroidx/recyclerview/widget/RecyclerView$c0;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/f/a/g/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "e"
.end annotation


# instance fields
.field private u:Landroid/widget/RelativeLayout;

.field private v:Landroid/widget/ImageView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/widget/CheckBox;


# direct methods
.method public constructor <init>(Lb/f/a/g/a;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p2}, Landroidx/recyclerview/widget/RecyclerView$c0;-><init>(Landroid/view/View;)V

    sget p1, Lb/f/a/b;->iv_type:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lb/f/a/g/a$e;->v:Landroid/widget/ImageView;

    sget p1, Lb/f/a/b;->layout_item_root:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/RelativeLayout;

    iput-object p1, p0, Lb/f/a/g/a$e;->u:Landroid/widget/RelativeLayout;

    sget p1, Lb/f/a/b;->tv_name:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lb/f/a/g/a$e;->w:Landroid/widget/TextView;

    sget p1, Lb/f/a/b;->tv_detail:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lb/f/a/g/a$e;->x:Landroid/widget/TextView;

    sget p1, Lb/f/a/b;->cb_choose:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/CheckBox;

    iput-object p1, p0, Lb/f/a/g/a$e;->y:Landroid/widget/CheckBox;

    return-void
.end method

.method static synthetic M(Lb/f/a/g/a$e;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lb/f/a/g/a$e;->v:Landroid/widget/ImageView;

    return-object p0
.end method

.method static synthetic N(Lb/f/a/g/a$e;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lb/f/a/g/a$e;->w:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic O(Lb/f/a/g/a$e;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lb/f/a/g/a$e;->x:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;
    .locals 0

    iget-object p0, p0, Lb/f/a/g/a$e;->y:Landroid/widget/CheckBox;

    return-object p0
.end method

.method static synthetic Q(Lb/f/a/g/a$e;)Landroid/widget/RelativeLayout;
    .locals 0

    iget-object p0, p0, Lb/f/a/g/a$e;->u:Landroid/widget/RelativeLayout;

    return-object p0
.end method
