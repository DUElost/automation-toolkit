.class Lcom/ape/offlinescriptmanager/utils/k$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/utils/k;->g()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/utils/k;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/utils/k;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/k$a;->b:Lcom/ape/offlinescriptmanager/utils/k;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/k$a;->b:Lcom/ape/offlinescriptmanager/utils/k;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/k;->a(Lcom/ape/offlinescriptmanager/utils/k;)Landroid/content/Context;

    move-result-object p1

    check-cast p1, Landroid/app/Activity;

    invoke-virtual {p1}, Landroid/app/Activity;->finish()V

    return-void
.end method
