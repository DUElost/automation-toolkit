.class Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->x(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

.field final synthetic c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Item clicked: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->v(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "SCREENRECORDER"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->w()Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;->v(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$b;

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView$c0;->j()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-interface {p1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;->a(Ljava/io/File;)V

    return-void
.end method
