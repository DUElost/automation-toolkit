.class Lb/a/a/f$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/a/a/f;->o()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lb/a/a/f;


# direct methods
.method constructor <init>(Lb/a/a/f;)V
    .locals 0

    iput-object p1, p0, Lb/a/a/f$b;->b:Lb/a/a/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p2

    iget-object p3, p0, Lb/a/a/f$b;->b:Lb/a/a/f;

    iget-object p4, p3, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p4, p4, Lb/a/a/f$d;->p0:Z

    const/4 v0, 0x0

    if-nez p4, :cond_1

    if-nez p2, :cond_0

    const/4 p4, 0x1

    move v0, p4

    :cond_0
    sget-object p4, Lb/a/a/b;->b:Lb/a/a/b;

    invoke-virtual {p3, p4}, Lb/a/a/f;->e(Lb/a/a/b;)Lcom/afollestad/materialdialogs/internal/MDButton;

    move-result-object p3

    xor-int/lit8 p4, v0, 0x1

    invoke-virtual {p3, p4}, Landroid/view/View;->setEnabled(Z)V

    :cond_1
    iget-object p3, p0, Lb/a/a/f$b;->b:Lb/a/a/f;

    invoke-virtual {p3, p2, v0}, Lb/a/a/f;->k(IZ)V

    iget-object p2, p0, Lb/a/a/f$b;->b:Lb/a/a/f;

    iget-object p3, p2, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p4, p3, Lb/a/a/f$d;->r0:Z

    if-eqz p4, :cond_2

    iget-object p3, p3, Lb/a/a/f$d;->o0:Lb/a/a/f$g;

    invoke-interface {p3, p2, p1}, Lb/a/a/f$g;->a(Lb/a/a/f;Ljava/lang/CharSequence;)V

    :cond_2
    return-void
.end method
