.class Lcom/ape/offlinescriptmanager/crashlistener/a$b;
.super Landroidx/recyclerview/widget/GridLayoutManager$c;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/a;->l(Ljava/util/ArrayList;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

.field final synthetic d:Landroidx/recyclerview/widget/GridLayoutManager;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/a;Lcom/ape/offlinescriptmanager/crashlistener/d/b;Landroidx/recyclerview/widget/GridLayoutManager;)V
    .locals 0

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$b;->d:Landroidx/recyclerview/widget/GridLayoutManager;

    invoke-direct {p0}, Landroidx/recyclerview/widget/GridLayoutManager$c;-><init>()V

    return-void
.end method


# virtual methods
.method public e(I)I
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$b;->c:Lcom/ape/offlinescriptmanager/crashlistener/d/b;

    invoke-virtual {v0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/d/b;->v(I)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$b;->d:Landroidx/recyclerview/widget/GridLayoutManager;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/GridLayoutManager;->O2()I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x1

    :goto_0
    return p1
.end method
