.class public Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;
.super Landroidx/appcompat/app/c;
.source ""


# instance fields
.field private A:Lb/f/a/i/a;

.field private B:Lb/f/a/h/a;

.field private C:Z

.field private D:Landroid/view/Menu;

.field private q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

.field private r:Landroid/view/View;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/TextView;

.field private u:Landroid/widget/Button;

.field private v:Ljava/lang/String;

.field private w:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private x:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private y:Lb/f/a/g/a;

.field private z:Landroidx/appcompat/widget/Toolbar;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroidx/appcompat/app/c;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->C:Z

    return-void
.end method

.method static synthetic L(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->v:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic M(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->v:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic N(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->w:Ljava/util/List;

    return-object p0
.end method

.method static synthetic O(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->a0(I)V

    return-void
.end method

.method static synthetic P(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->w:Ljava/util/List;

    return-object p1
.end method

.method static synthetic Q(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->b0()V

    return-void
.end method

.method static synthetic R(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/lang/String;)Ljava/util/List;
    .locals 0

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->c0(Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method static synthetic S(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/g/a;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    return-object p0
.end method

.method static synthetic T(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->C:Z

    return p1
.end method

.method static synthetic U(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Landroid/widget/Button;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    return-object p0
.end method

.method static synthetic V(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    return-object p0
.end method

.method static synthetic W(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->g0(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic X(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic Y(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)Lb/f/a/i/a;
    .locals 0

    iget-object p0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    return-object p0
.end method

.method private Z()Z
    .locals 2

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    const-string v1, "mounted"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method private a0(I)V
    .locals 1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->w:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->v:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->g0(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->v:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->c0(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->w:Ljava/util/List;

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    invoke-virtual {v0, p1}, Lb/f/a/g/a;->A(Ljava/util/List;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$g;->g()V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroidx/recyclerview/widget/RecyclerView;->h1(I)V

    return-void
.end method

.method private b0()V
    .locals 3

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->j()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->f()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v1}, Lb/f/a/i/a;->f()I

    move-result v1

    if-le v0, v1, :cond_0

    sget v0, Lb/f/a/f;->OutSize:I

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void

    :cond_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    const-string v2, "paths"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putStringArrayListExtra(Ljava/lang/String;Ljava/util/ArrayList;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->s:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, "path"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 v1, -0x1

    invoke-virtual {p0, v1, v0}, Landroid/app/Activity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void
.end method

.method private c0(Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->B:Lb/f/a/h/a;

    invoke-static {p1, v0}, Lb/f/a/j/c;->a(Ljava/lang/String;Ljava/io/FileFilter;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method private d0()V
    .locals 2

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->t:Landroid/widget/TextView;

    new-instance v1, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;

    invoke-direct {v1, p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$b;-><init>(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    new-instance v1, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;

    invoke-direct {v1, p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$c;-><init>(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V

    invoke-virtual {v0, v1}, Lb/f/a/g/a;->y(Lb/f/a/g/a$d;)V

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    new-instance v1, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;

    invoke-direct {v1, p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$d;-><init>(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private e0()V
    .locals 2

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->h()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v1}, Lb/f/a/i/a;->h()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/Toolbar;->setTitle(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->i()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v1}, Lb/f/a/i/a;->i()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/Toolbar;->setTitleTextColor(I)V

    :cond_1
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->c()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v1}, Lb/f/a/i/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setBackgroundColor(I)V

    :cond_2
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->b()I

    move-result v0

    if-eqz v0, :cond_4

    const/4 v1, 0x1

    if-eq v0, v1, :cond_3

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    sget v1, Lb/f/a/e;->backincostyletwo:I

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    sget v1, Lb/f/a/e;->backincostyleone:I

    :goto_0
    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/Toolbar;->setNavigationIcon(I)V

    :goto_1
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    new-instance v1, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$a;

    invoke-direct {v1, p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity$a;-><init>(Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/Toolbar;->setNavigationOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private f0()V
    .locals 2

    sget v0, Lb/f/a/b;->recylerview:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    sget v0, Lb/f/a/b;->tv_path:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->s:Landroid/widget/TextView;

    sget v0, Lb/f/a/b;->tv_back:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->t:Landroid/widget/TextView;

    sget v0, Lb/f/a/b;->btn_addbook:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    sget v0, Lb/f/a/b;->empty_view:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->r:Landroid/view/View;

    sget v0, Lb/f/a/b;->toolbar:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/Toolbar;

    iput-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    iget-object v1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v1}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method private g0(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->s:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private h0()V
    .locals 3

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->k()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->j()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    sget v2, Lb/f/a/f;->OK:I

    invoke-virtual {p0, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->s(Z)V

    :cond_1
    return-void
.end method

.method private j0(Landroid/view/Menu;)V
    .locals 1

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->D:Landroid/view/Menu;

    sget v0, Lb/f/a/b;->action_selecteall_cancel:I

    invoke-interface {p1, v0}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object p1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->k()Z

    move-result v0

    invoke-interface {p1, v0}, Landroid/view/MenuItem;->setVisible(Z)Landroid/view/MenuItem;

    return-void
.end method


# virtual methods
.method public i0()V
    .locals 2

    iget-boolean v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->C:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->D:Landroid/view/Menu;

    invoke-interface {v0, v1}, Landroid/view/Menu;->getItem(I)Landroid/view/MenuItem;

    move-result-object v0

    sget v1, Lb/f/a/f;->Cancel:I

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->D:Landroid/view/Menu;

    invoke-interface {v0, v1}, Landroid/view/Menu;->getItem(I)Landroid/view/MenuItem;

    move-result-object v0

    sget v1, Lb/f/a/f;->SelectAll:I

    :goto_0
    invoke-virtual {p0, v1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/view/MenuItem;->setTitle(Ljava/lang/CharSequence;)Landroid/view/MenuItem;

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onCreate(Landroid/os/Bundle;)V

    sget p1, Lb/f/a/c;->activity_lfile_picker:I

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->setContentView(I)V

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "param"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getSerializable(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p1

    check-cast p1, Lb/f/a/i/a;

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->f0()V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->z:Landroidx/appcompat/widget/Toolbar;

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->I(Landroidx/appcompat/widget/Toolbar;)V

    invoke-virtual {p0}, Landroidx/appcompat/app/c;->C()Landroidx/appcompat/app/a;

    move-result-object p1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/a;->t(Z)V

    invoke-virtual {p0}, Landroidx/appcompat/app/c;->C()Landroidx/appcompat/app/a;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/a;->s(Z)V

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->e0()V

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->h0()V

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->Z()Z

    move-result p1

    const/4 v1, 0x0

    if-nez p1, :cond_0

    sget p1, Lb/f/a/f;->NotFoundPath:I

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_0
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->v:Ljava/lang/String;

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->s:Landroid/widget/TextView;

    invoke-virtual {v2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance p1, Lb/f/a/h/a;

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v2}, Lb/f/a/i/a;->d()[Ljava/lang/String;

    move-result-object v2

    invoke-direct {p1, v2}, Lb/f/a/h/a;-><init>([Ljava/lang/String;)V

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->B:Lb/f/a/h/a;

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->v:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->c0(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->w:Ljava/util/List;

    new-instance v2, Lb/f/a/g/a;

    iget-object v3, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->B:Lb/f/a/h/a;

    iget-object v4, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v4}, Lb/f/a/i/a;->k()Z

    move-result v4

    invoke-direct {v2, p1, p0, v3, v4}, Lb/f/a/g/a;-><init>(Ljava/util/List;Landroid/content/Context;Ljava/io/FileFilter;Z)V

    iput-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    new-instance v2, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-direct {v2, p0, v0, v1}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {p1, v2}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->e()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/f/a/g/a;->z(I)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    invoke-virtual {p1, v0}, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->q:Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->r:Landroid/view/View;

    invoke-virtual {p1, v0}, Lcom/leon/lfilepickerlibrary/widget/EmptyRecyclerView;->setmEmptyView(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->d0()V

    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    invoke-virtual {p0}, Landroidx/appcompat/app/c;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    sget v1, Lb/f/a/d;->menu_main_toolbar:I

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    iput-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->D:Landroid/view/Menu;

    invoke-direct {p0, p1}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->j0(Landroid/view/Menu;)V

    const/4 p1, 0x1

    return p1
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 6

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    sget v0, Lb/f/a/b;->action_selecteall_cancel:I

    const/4 v1, 0x1

    if-ne p1, v0, :cond_4

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->y:Lb/f/a/g/a;

    iget-boolean v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->C:Z

    xor-int/2addr v0, v1

    invoke-virtual {p1, v0}, Lb/f/a/g/a;->B(Z)V

    iget-boolean p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->C:Z

    xor-int/2addr p1, v1

    iput-boolean p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->C:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->w:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v0}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object v0

    const-string v2, " )"

    const-string v3, "( "

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->A:Lb/f/a/i/a;

    invoke-virtual {v5}, Lb/f/a/i/a;->a()Ljava/lang/String;

    move-result-object v5

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget v5, Lb/f/a/f;->Selected:I

    invoke-virtual {p0, v5}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v5

    :goto_1
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->x:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->clear()V

    iget-object p1, p0, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->u:Landroid/widget/Button;

    sget v0, Lb/f/a/f;->Selected:I

    invoke-virtual {p0, v0}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    :cond_3
    invoke-virtual {p0}, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;->i0()V

    :cond_4
    return v1
.end method
