.class Lcom/ape/offlinescriptmanager/view/c/a$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/a;->t1()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/c/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$b;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$b;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/view/c/a;->a0:Landroid/widget/EditText;

    const-string p2, "empty"

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/a$b;->b:Lcom/ape/offlinescriptmanager/view/c/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/a;->n1(Lcom/ape/offlinescriptmanager/view/c/a;)V

    return-void
.end method
