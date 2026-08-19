.class public Lcom/ape/offlinescriptmanager/batterytool/d/b;
.super Lcom/ape/offlinescriptmanager/batterytool/d/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/batterytool/d/b$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/ape/offlinescriptmanager/batterytool/d/a<",
        "Lcom/ape/offlinescriptmanager/batterytool/f/c;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/f/c;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/batterytool/d/a;-><init>(Ljava/util/List;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/d/b;->c:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/d/a;->getCount()I

    move-result p3

    const/4 v0, 0x0

    if-eqz p3, :cond_2

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/d/a;->getCount()I

    move-result p3

    if-lt p1, p3, :cond_0

    goto/16 :goto_1

    :cond_0
    if-nez p2, :cond_1

    new-instance p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;

    invoke-direct {p2, p0}, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/d/b;)V

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/d/b;->c:Landroid/content/Context;

    invoke-static {p3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p3

    const v1, 0x7f0c005d

    invoke-virtual {p3, v1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p3

    const v0, 0x7f090101

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;->a:Landroid/widget/TextView;

    const v0, 0x7f090103

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;->b:Landroid/widget/TextView;

    const v0, 0x7f090104

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;->c:Landroid/widget/TextView;

    invoke-virtual {p3, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;

    move-object v4, p3

    move-object p3, p2

    move-object p2, v4

    :goto_0
    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/batterytool/d/a;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/batterytool/f/c;

    iget-object v1, p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;->a:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    add-int/lit8 p1, p1, 0x1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;->b:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/d/b;->c:Landroid/content/Context;

    const v3, 0x7f0f02e5

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p2, Lcom/ape/offlinescriptmanager/batterytool/d/b$a;->c:Landroid/widget/TextView;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/d/b;->c:Landroid/content/Context;

    const v2, 0x7f0f02e7

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-object p3

    :cond_2
    :goto_1
    return-object v0
.end method
