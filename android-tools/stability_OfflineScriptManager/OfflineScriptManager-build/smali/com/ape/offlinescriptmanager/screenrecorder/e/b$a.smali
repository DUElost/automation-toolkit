.class Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

.field final synthetic c:I

.field final synthetic d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;I)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    iput p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->c:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    new-instance v0, Landroid/widget/PopupMenu;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;->d:Lcom/ape/offlinescriptmanager/screenrecorder/e/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Landroid/widget/PopupMenu;-><init>(Landroid/content/Context;Landroid/view/View;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;

    invoke-direct {p1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;)V

    invoke-virtual {v0, p1}, Landroid/widget/PopupMenu;->setOnMenuItemClickListener(Landroid/widget/PopupMenu$OnMenuItemClickListener;)V

    const p1, 0x7f0d0005

    invoke-virtual {v0, p1}, Landroid/widget/PopupMenu;->inflate(I)V

    invoke-virtual {v0}, Landroid/widget/PopupMenu;->show()V

    return-void
.end method
