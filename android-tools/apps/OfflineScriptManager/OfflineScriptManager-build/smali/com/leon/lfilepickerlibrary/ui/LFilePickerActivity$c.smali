.class Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/f/a/g/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->d0()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;


# direct methods
.method constructor <init>(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 6

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/f/a/i/a;->k()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->O(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;I)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->S(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/g/a;

    move-result-object p1

    invoke-virtual {p1, v1}, Lb/f/a/g/a;->B(Z)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1, v1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->T(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Z)Z

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-virtual {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->i0()V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;

    move-result-object p1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    sget v1, Lb/f/a/f;->Selected:I

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_2

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v2}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v2}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v2}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_0
    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object p1

    const-string v0, " )"

    const-string v2, "( "

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;

    move-result-object p1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v4}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object v4

    invoke-virtual {v4}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;

    move-result-object p1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    sget v5, Lb/f/a/f;->Selected:I

    invoke-virtual {v4, v5}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v4

    :goto_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v2}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/f/a/i/a;->f()I

    move-result p1

    if-lez p1, :cond_6

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/f/a/i/a;->f()I

    move-result v0

    if-le p1, v0, :cond_6

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    sget v0, Lb/f/a/f;->OutSize:I

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_3
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->O(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;I)V

    return-void

    :cond_4
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object v0

    invoke-virtual {v0}, Lb/f/a/i/a;->j()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Q(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V

    goto :goto_2

    :cond_5
    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;->a:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    sget v0, Lb/f/a/f;->ChooseTip:I

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :cond_6
    :goto_2
    return-void
.end method
