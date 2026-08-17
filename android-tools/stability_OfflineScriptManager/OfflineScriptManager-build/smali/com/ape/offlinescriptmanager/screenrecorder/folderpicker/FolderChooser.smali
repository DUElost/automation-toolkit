.class public Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;
.super Landroid/preference/DialogPreference;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$f;,
        Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$e;
    }
.end annotation


# static fields
.field private static m:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;


# instance fields
.field private b:Landroidx/recyclerview/widget/RecyclerView;

.field private c:Landroid/widget/TextView;

.field private d:Landroid/widget/TextView;

.field private e:Ljava/io/File;

.field private f:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private g:Landroid/app/AlertDialog;

.field private h:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

.field private i:Landroid/widget/Spinner;

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;",
            ">;"
        }
    .end annotation
.end field

.field private k:Z

.field private l:Landroid/content/SharedPreferences;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/preference/DialogPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->k:Z

    const-string p1, "SCREENRECORDER"

    const-string p2, "Constructor called"

    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->l()V

    return-void
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)Landroid/app/AlertDialog;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g:Landroid/app/AlertDialog;

    return-object p0
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Ljava/lang/String;)Z
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)Landroid/content/SharedPreferences;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->l:Landroid/content/SharedPreferences;

    return-object p0
.end method

.method private e(Ljava/io/File;)V
    .locals 2

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Changed dir is: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "SCREENRECORDER"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->h()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->m()Z

    move-result p1

    if-nez p1, :cond_0

    new-instance p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->f:Ljava/util/ArrayList;

    invoke-direct {p1, v0, p0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;-><init>(Landroid/content/Context;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;Ljava/util/ArrayList;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->h:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroidx/recyclerview/widget/RecyclerView;->s1(Landroidx/recyclerview/widget/RecyclerView$g;Z)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->c:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private f(Ljava/io/File;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;->a()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->i(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->canWrite()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e(Ljava/io/File;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->canWrite()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object p1

    const v0, 0x7f0f0078

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :cond_1
    :goto_0
    return-void
.end method

.method private g(Ljava/lang/String;)Z
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "No directory selected"

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return v1

    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->canWrite()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "No permission to write to directory"

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return v1

    :cond_1
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/io/File;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-direct {v0, v2, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    :goto_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v2, "Directory already exists"

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    new-instance v0, Ljava/io/File;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-direct {v0, v2, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e(Ljava/io/File;)V

    return v1

    :cond_3
    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    move-result v2

    if-nez v2, :cond_4

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object p1

    const-string v2, "Error creating directory"

    invoke-static {p1, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    const-string v0, "SCREENRECORDER"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    :cond_4
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e(Ljava/io/File;)V

    const/4 p1, 0x1

    return p1
.end method

.method private h()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$e;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$e;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;)V

    invoke-virtual {v0, v1}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/util/ArrayList;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->f:Ljava/util/ArrayList;

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$f;

    invoke-direct {v0, p0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$f;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;)V

    invoke-static {v1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Directory size "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SCREENRECORDER"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private i(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    const-string v0, "Android"

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Short code is: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "SCREENRECORDER"

    invoke-static {v3, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "External Base Dir "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-object p1
.end method

.method private j()V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setHasFixedSize(Z)V

    new-instance v0, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v0, v2, v1, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    new-instance v1, Landroidx/recyclerview/widget/d;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v0}, Landroidx/recyclerview/widget/LinearLayoutManager;->j2()I

    move-result v0

    invoke-direct {v1, v2, v0}, Landroidx/recyclerview/widget/d;-><init>(Landroid/content/Context;I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->i(Landroidx/recyclerview/widget/RecyclerView$n;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->m()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->f:Ljava/util/ArrayList;

    invoke-direct {v0, v1, p0, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;-><init>(Landroid/content/Context;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a$c;Ljava/util/ArrayList;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->h:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/a;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->c:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private k(Landroid/view/View;)V
    .locals 3

    const v0, 0x7f09012e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    const v1, 0x7f090091

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    const v2, 0x7f0901cb

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->c:Landroid/widget/TextView;

    const v2, 0x7f09015f

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/recyclerview/widget/RecyclerView;

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    const v2, 0x7f0901c8

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->d:Landroid/widget/TextView;

    const v2, 0x7f09018a

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Spinner;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->i:Landroid/widget/Spinner;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v1, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;->b()Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    move-result-object v1

    sget-object v2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    if-ne v1, v2, :cond_0

    const-string v1, "Internal Storage"

    goto :goto_1

    :cond_0
    const-string v1, "Removable Storage"

    :goto_1
    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x1090008

    invoke-direct {v0, v1, v2, p1}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    const p1, 0x1090009

    invoke-virtual {v0, p1}, Landroid/widget/ArrayAdapter;->setDropDownViewResource(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->i:Landroid/widget/Spinner;

    invoke-virtual {p1, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->i:Landroid/widget/Spinner;

    invoke-virtual {p1, p0}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    return-void
.end method

.method private l()V
    .locals 6

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/preference/DialogPreference;->setPersistent(Z)V

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/preference/DialogPreference;->setDialogTitle(Ljava/lang/CharSequence;)V

    const v2, 0x7f0c0043

    invoke-virtual {p0, v2}, Landroid/preference/DialogPreference;->setDialogLayoutResource(I)V

    const v2, 0x104000a

    invoke-virtual {p0, v2}, Landroid/preference/DialogPreference;->setPositiveButtonText(I)V

    const/high16 v2, 0x1040000

    invoke-virtual {p0, v2}, Landroid/preference/DialogPreference;->setNegativeButtonText(I)V

    new-instance v2, Ljava/io/File;

    sget-object v3, Lcom/ape/offlinescriptmanager/screenrecorder/a;->a:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/preference/DialogPreference;->getPersistedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/preference/DialogPreference;->setSummary(Ljava/lang/CharSequence;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Persisted String is: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Landroid/preference/DialogPreference;->getPersistedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "SCREENRECORDER"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v1}, Landroidx/core/content/a;->f(Landroid/content/Context;Ljava/lang/String;)[Ljava/io/File;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    new-instance v3, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    invoke-direct {v3, v4, v5}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;-><init>(Ljava/lang/String;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;)V

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    iput-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->l:Landroid/content/SharedPreferences;

    array-length v2, v1

    if-le v2, v0, :cond_0

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    new-instance v3, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    aget-object v0, v1, v0

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    invoke-direct {v3, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;-><init>(Ljava/lang/String;Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;)V

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method private m()Z
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    const/4 v0, 0x1

    return v0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->b:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return v2
.end method

.method private n(Landroid/os/Bundle;)V
    .locals 4

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "layout_inflater"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    const v1, 0x7f0c0044

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0900cf

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    new-instance v2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)V

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v3, 0x7f0f0044

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const v3, 0x7f0f0041

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$c;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;)V

    const/high16 v3, 0x1040000

    invoke-virtual {v0, v3, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;

    invoke-direct {v2, p0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$b;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Landroid/widget/EditText;)V

    const v3, 0x104000a

    invoke-virtual {v0, v3, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g:Landroid/app/AlertDialog;

    if-eqz p1, :cond_0

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->onRestoreInstanceState(Landroid/os/Bundle;)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g:Landroid/app/AlertDialog;

    invoke-virtual {p1}, Landroid/app/AlertDialog;->show()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g:Landroid/app/AlertDialog;

    const/4 v0, -0x1

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    return-void
.end method

.method private q()V
    .locals 4

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0c002b

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0900c2

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v3, 0x7f0f003e

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const v3, 0x7f0f003d

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;

    invoke-direct {v2, p0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser$d;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;Landroid/widget/CheckBox;)V

    const v1, 0x104000a

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return-void
.end method


# virtual methods
.method public a(Ljava/io/File;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e(Ljava/io/File;)V

    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    const-string v1, "SCREENRECORDER"

    if-eqz p1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result p1

    if-eqz p1, :cond_0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    const-string p1, "Directory set"

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g(Ljava/lang/String;)Z

    const-string p1, "Directory created"

    :goto_0
    invoke-static {v1, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected onBindDialogView(Landroid/view/View;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/preference/DialogPreference;->onBindDialogView(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->h()V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->k(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090091

    if-eq p1, v0, :cond_3

    const v0, 0x7f09012e

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    new-instance p1, Ljava/io/File;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SCREENRECORDER"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->k:Z

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e(Ljava/io/File;)V

    goto :goto_0

    :cond_1
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->f(Ljava/io/File;)V

    :cond_2
    :goto_0
    return-void

    :cond_3
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->n(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onDialogClosed(Z)V
    .locals 2

    invoke-super {p0, p1}, Landroid/preference/DialogPreference;->onDialogClosed(Z)V

    if-eqz p1, :cond_1

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Directory choosed! "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "SCREENRECORDER"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->canWrite()Z

    move-result p1

    if-nez p1, :cond_0

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object p1

    const/4 v0, 0x0

    const-string v1, "Cannot write to selected directory. Path will not be saved."

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/preference/DialogPreference;->persistString(Ljava/lang/String;)Z

    sget-object p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->m:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;

    invoke-interface {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;->b()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/preference/DialogPreference;->setSummary(Ljava/lang/CharSequence;)V

    :cond_1
    return-void
.end method

.method public onItemSelected(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Selected storage is: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    invoke-interface {p2, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "SCREENRECORDER"

    invoke-static {p2, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;->b()Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    const/4 p4, 0x0

    if-ne p1, p2, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    move p1, p4

    :goto_0
    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->k:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->l:Landroid/content/SharedPreferences;

    const-string p2, "ext_dir_warn_donot_show_again"

    invoke-interface {p1, p2, p4}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->q()V

    :cond_1
    new-instance p1, Ljava/io/File;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->j:Ljava/util/List;

    invoke-interface {p2, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;

    invoke-virtual {p2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;->a()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e(Ljava/io/File;)V

    return-void
.end method

.method public onNothingSelected(Landroid/widget/AdapterView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;)V"
        }
    .end annotation

    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 2

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;

    invoke-virtual {p1}, Landroid/preference/Preference$BaseSavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/preference/DialogPreference;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->o(Ljava/lang/String;)V

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->c:Landroid/os/Bundle;

    if-eqz p1, :cond_1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->n(Landroid/os/Bundle;)V

    :cond_1
    return-void

    :cond_2
    :goto_0
    invoke-super {p0, p1}, Landroid/preference/DialogPreference;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    return-void
.end method

.method protected onSaveInstanceState()Landroid/os/Parcelable;
    .locals 4

    invoke-super {p0}, Landroid/preference/DialogPreference;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->g:Landroid/app/AlertDialog;

    if-nez v1, :cond_1

    const/4 v1, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {v1}, Landroid/app/AlertDialog;->onSaveInstanceState()Landroid/os/Bundle;

    move-result-object v1

    :goto_0
    new-instance v2, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->e:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v0, v3, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;-><init>(Landroid/os/Parcelable;Ljava/lang/String;Landroid/os/Bundle;)V

    return-object v2
.end method

.method public p(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;)V
    .locals 0

    sput-object p1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->m:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;

    return-void
.end method
