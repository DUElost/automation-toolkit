.class public Lb/f/a/g/a;
.super Landroidx/recyclerview/widget/RecyclerView$g;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/f/a/g/a$e;,
        Lb/f/a/g/a$d;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$g<",
        "Lb/f/a/g/a$e;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private d:Landroid/content/Context;

.field public e:Lb/f/a/g/a$d;

.field private f:Ljava/io/FileFilter;

.field private g:[Z

.field private h:Z

.field private i:I


# direct methods
.method public constructor <init>(Ljava/util/List;Landroid/content/Context;Ljava/io/FileFilter;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;",
            "Landroid/content/Context;",
            "Ljava/io/FileFilter;",
            "Z)V"
        }
    .end annotation

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$g;-><init>()V

    iput-object p1, p0, Lb/f/a/g/a;->c:Ljava/util/List;

    iput-object p2, p0, Lb/f/a/g/a;->d:Landroid/content/Context;

    iput-object p3, p0, Lb/f/a/g/a;->f:Ljava/io/FileFilter;

    iput-boolean p4, p0, Lb/f/a/g/a;->h:Z

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    new-array p1, p1, [Z

    iput-object p1, p0, Lb/f/a/g/a;->g:[Z

    return-void
.end method

.method private C(Landroid/widget/ImageView;)V
    .locals 2

    iget v0, p0, Lb/f/a/g/a;->i:I

    if-eqz v0, :cond_2

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    goto :goto_1

    :cond_0
    sget v0, Lb/f/a/e;->file_style_green:I

    goto :goto_0

    :cond_1
    sget v0, Lb/f/a/e;->file_style_blue:I

    goto :goto_0

    :cond_2
    sget v0, Lb/f/a/e;->file_style_yellow:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    :goto_1
    return-void
.end method

.method private D(Landroid/widget/ImageView;)V
    .locals 2

    iget v0, p0, Lb/f/a/g/a;->i:I

    if-eqz v0, :cond_2

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    goto :goto_1

    :cond_0
    sget v0, Lb/f/a/e;->folder_style_green:I

    goto :goto_0

    :cond_1
    sget v0, Lb/f/a/e;->folder_style_blue:I

    goto :goto_0

    :cond_2
    sget v0, Lb/f/a/e;->folder_style_yellow:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    :goto_1
    return-void
.end method

.method static synthetic v(Lb/f/a/g/a;)[Z
    .locals 0

    iget-object p0, p0, Lb/f/a/g/a;->g:[Z

    return-object p0
.end method


# virtual methods
.method public A(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lb/f/a/g/a;->c:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    new-array p1, p1, [Z

    iput-object p1, p0, Lb/f/a/g/a;->g:[Z

    return-void
.end method

.method public B(Z)V
    .locals 3

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lb/f/a/g/a;->g:[Z

    array-length v2, v1

    if-ge v0, v2, :cond_0

    aput-boolean p1, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    return-void
.end method

.method public c()I
    .locals 1

    iget-object v0, p0, Lb/f/a/g/a;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
    .locals 0

    check-cast p1, Lb/f/a/g/a$e;

    invoke-virtual {p0, p1, p2}, Lb/f/a/g/a;->w(Lb/f/a/g/a$e;I)V

    return-void
.end method

.method public bridge synthetic n(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$c0;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lb/f/a/g/a;->x(Landroid/view/ViewGroup;I)Lb/f/a/g/a$e;

    move-result-object p1

    return-object p1
.end method

.method public w(Lb/f/a/g/a$e;I)V
    .locals 7

    iget-object v0, p0, Lb/f/a/g/a;->c:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v1

    const/16 v2, 0x8

    const-string v3, " "

    if-eqz v1, :cond_0

    invoke-static {p1}, Lb/f/a/g/a$e;->M(Lb/f/a/g/a$e;)Landroid/widget/ImageView;

    move-result-object v1

    invoke-direct {p0, v1}, Lb/f/a/g/a;->C(Landroid/widget/ImageView;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->N(Lb/f/a/g/a$e;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->O(Lb/f/a/g/a$e;)Landroid/widget/TextView;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lb/f/a/g/a;->d:Landroid/content/Context;

    sget v6, Lb/f/a/f;->FileSize:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v5

    invoke-static {v5, v6}, Lb/f/a/j/c;->b(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v1

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/widget/CheckBox;->setVisibility(I)V

    goto :goto_1

    :cond_0
    invoke-static {p1}, Lb/f/a/g/a$e;->M(Lb/f/a/g/a$e;)Landroid/widget/ImageView;

    move-result-object v1

    invoke-direct {p0, v1}, Lb/f/a/g/a;->D(Landroid/widget/ImageView;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->N(Lb/f/a/g/a$e;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lb/f/a/g/a;->f:Ljava/io/FileFilter;

    invoke-virtual {v0, v1}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v1

    if-nez v1, :cond_1

    invoke-static {p1}, Lb/f/a/g/a$e;->O(Lb/f/a/g/a$e;)Landroid/widget/TextView;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "0 "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lb/f/a/g/a;->d:Landroid/content/Context;

    sget v5, Lb/f/a/f;->LItem:I

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    invoke-static {p1}, Lb/f/a/g/a$e;->O(Lb/f/a/g/a$e;)Landroid/widget/TextView;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    array-length v1, v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/f/a/g/a;->d:Landroid/content/Context;

    sget v3, Lb/f/a/f;->LItem:I

    invoke-virtual {v1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setVisibility(I)V

    :goto_1
    iget-boolean v1, p0, Lb/f/a/g/a;->h:Z

    if-nez v1, :cond_2

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setVisibility(I)V

    :cond_2
    invoke-static {p1}, Lb/f/a/g/a$e;->Q(Lb/f/a/g/a$e;)Landroid/widget/RelativeLayout;

    move-result-object v1

    new-instance v2, Lb/f/a/g/a$a;

    invoke-direct {v2, p0, v0, p1, p2}, Lb/f/a/g/a$a;-><init>(Lb/f/a/g/a;Ljava/io/File;Lb/f/a/g/a$e;I)V

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v0

    new-instance v1, Lb/f/a/g/a$b;

    invoke-direct {v1, p0, p2}, Lb/f/a/g/a$b;-><init>(Lb/f/a/g/a;I)V

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v0

    iget-object v1, p0, Lb/f/a/g/a;->g:[Z

    aget-boolean v1, v1, p2

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object p1

    new-instance v0, Lb/f/a/g/a$c;

    invoke-direct {v0, p0, p2}, Lb/f/a/g/a$c;-><init>(Lb/f/a/g/a;I)V

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    return-void
.end method

.method public x(Landroid/view/ViewGroup;I)Lb/f/a/g/a$e;
    .locals 1

    iget-object p1, p0, Lb/f/a/g/a;->d:Landroid/content/Context;

    sget p2, Lb/f/a/c;->listitem:I

    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lb/f/a/g/a$e;

    invoke-direct {p2, p0, p1}, Lb/f/a/g/a$e;-><init>(Lb/f/a/g/a;Landroid/view/View;)V

    return-object p2
.end method

.method public y(Lb/f/a/g/a$d;)V
    .locals 0

    iput-object p1, p0, Lb/f/a/g/a;->e:Lb/f/a/g/a$d;

    return-void
.end method

.method public z(I)V
    .locals 0

    iput p1, p0, Lb/f/a/g/a;->i:I

    return-void
.end method
