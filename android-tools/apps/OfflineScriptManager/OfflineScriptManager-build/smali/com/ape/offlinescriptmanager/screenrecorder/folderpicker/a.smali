.class Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;
.super Landroidx/recyclerview/widget/RecyclerView$g;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;,
        Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$g<",
        "Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;",
        ">;"
    }
.end annotation


# static fields
.field private static d:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;


# instance fields
.field private c:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;",
            "Ljava/util/ArrayList<",
            "Ljava/io/File;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$g;-><init>()V

    sput-object p2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->c:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic v(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->c:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic w()Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;

    return-object v0
.end method


# virtual methods
.method public c()I
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->c:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
    .locals 0

    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

    invoke-virtual {p0, p1, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->x(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;I)V

    return-void
.end method

.method public bridge synthetic n(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$c0;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->y(Landroid/view/ViewGroup;I)Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

    move-result-object p1

    return-object p1
.end method

.method public x(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;I)V
    .locals 2

    iget-object v0, p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;->u:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->c:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;->u:Landroid/widget/TextView;

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;

    invoke-direct {v0, p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;)V

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public y(Landroid/view/ViewGroup;I)Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;
    .locals 2

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0c002f

    const/4 v1, 0x0

    invoke-virtual {p2, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

    invoke-direct {p2, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;-><init>(Landroid/view/View;)V

    return-object p2
.end method
