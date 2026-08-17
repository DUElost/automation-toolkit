.class Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->d0()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;


# direct methods
.method constructor <init>(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    new-instance p1, Ljava/io/File;

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->L(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->M(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->L(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->R(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->P(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/util/List;)Ljava/util/List;

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->S(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/g/a;

    move-result-object p1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/f/a/g/a;->A(Ljava/util/List;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->S(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/g/a;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lb/f/a/g/a;->B(Z)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1, v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->T(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Z)Z

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-virtual {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->i0()V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;

    move-result-object p1

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    sget v2, Lb/f/a/f;->Selected:I

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->V(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView;->h1(I)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->L(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->W(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->clear()V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;

    move-result-object p1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;

    move-result-object p1

    invoke-virtual {p1, v2}, Landroid/widget/Button;->setText(I)V

    :goto_0
    return-void
.end method
