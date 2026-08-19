.class public Lorg/achartengine/GraphicalActivity;
.super Landroid/app/Activity;
.source ""


# instance fields
.field private b:Lorg/achartengine/b;

.field private c:Lorg/achartengine/f/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "chart"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getSerializable(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object v0

    check-cast v0, Lorg/achartengine/f/a;

    iput-object v0, p0, Lorg/achartengine/GraphicalActivity;->c:Lorg/achartengine/f/a;

    new-instance v0, Lorg/achartengine/b;

    iget-object v1, p0, Lorg/achartengine/GraphicalActivity;->c:Lorg/achartengine/f/a;

    invoke-direct {v0, p0, v1}, Lorg/achartengine/b;-><init>(Landroid/content/Context;Lorg/achartengine/f/a;)V

    iput-object v0, p0, Lorg/achartengine/GraphicalActivity;->b:Lorg/achartengine/b;

    const-string v0, "title"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Landroid/app/Activity;->requestWindowFeature(I)Z

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    invoke-virtual {p0, p1}, Landroid/app/Activity;->setTitle(Ljava/lang/CharSequence;)V

    :cond_1
    :goto_0
    iget-object p1, p0, Lorg/achartengine/GraphicalActivity;->b:Lorg/achartengine/b;

    invoke-virtual {p0, p1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    return-void
.end method
