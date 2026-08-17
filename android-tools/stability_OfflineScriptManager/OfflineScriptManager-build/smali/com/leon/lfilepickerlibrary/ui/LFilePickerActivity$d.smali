.class Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;
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

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/f/a/i/a;->j()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    const/4 v0, 0x1

    if-ge p1, v0, :cond_1

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;

    move-result-object p1

    invoke-virtual {p1}, Lb/f/a/i/a;->g()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    sget v0, Lb/f/a/f;->NotFoundBooks:I

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    :goto_0
    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;->b:Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-static {p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Q(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V

    :goto_1
    return-void
.end method
