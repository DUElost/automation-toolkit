.class Lcom/ape/offlinescriptmanager/view/c/e/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/e/a;->n(Lb/h/a/a/c/a;Ljava/lang/String;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lb/h/a/a/c/a;

.field final synthetic b:Lcom/ape/offlinescriptmanager/view/c/e/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/a;Lb/h/a/a/c/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/e/a;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/a$a;->a:Lb/h/a/a/c/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a$a;->a:Lb/h/a/a/c/a;

    invoke-virtual {p1, p2}, Lb/h/a/a/c/a;->t(Z)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/a$a;->b:Lcom/ape/offlinescriptmanager/view/c/e/a;

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Lcom/ape/offlinescriptmanager/view/c/e/a;->o(Z)V

    return-void
.end method
