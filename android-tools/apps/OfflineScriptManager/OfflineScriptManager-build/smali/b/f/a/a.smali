.class public Lb/f/a/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:Landroid/app/Activity;

.field private b:Landroid/app/Fragment;

.field private c:Landroidx/fragment/app/Fragment;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:I

.field private h:I

.field private i:Z

.field private j:Z

.field private k:Ljava/lang/String;

.field private l:I

.field private m:[Ljava/lang/String;

.field private n:Ljava/lang/String;

.field private o:I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/f/a/a;->i:Z

    iput-boolean v0, p0, Lb/f/a/a;->j:Z

    return-void
.end method

.method private a()Landroid/os/Bundle;
    .locals 3

    new-instance v0, Lb/f/a/i/a;

    invoke-direct {v0}, Lb/f/a/i/a;-><init>()V

    iget-object v1, p0, Lb/f/a/a;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->u(Ljava/lang/String;)V

    iget-object v1, p0, Lb/f/a/a;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->v(Ljava/lang/String;)V

    iget-object v1, p0, Lb/f/a/a;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->n(Ljava/lang/String;)V

    iget v1, p0, Lb/f/a/a;->g:I

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->m(I)V

    iget-boolean v1, p0, Lb/f/a/a;->i:Z

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->s(Z)V

    iget-object v1, p0, Lb/f/a/a;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->l(Ljava/lang/String;)V

    iget v1, p0, Lb/f/a/a;->l:I

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->q(I)V

    iget-object v1, p0, Lb/f/a/a;->m:[Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->p([Ljava/lang/String;)V

    iget-object v1, p0, Lb/f/a/a;->n:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->t(Ljava/lang/String;)V

    iget v1, p0, Lb/f/a/a;->o:I

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->r(I)V

    iget-boolean v1, p0, Lb/f/a/a;->j:Z

    invoke-virtual {v0, v1}, Lb/f/a/i/a;->o(Z)V

    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    const-string v2, "param"

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    return-object v1
.end method

.method private b()Landroid/content/Intent;
    .locals 3

    iget-object v0, p0, Lb/f/a/a;->a:Landroid/app/Activity;

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lb/f/a/a;->a:Landroid/app/Activity;

    const-class v2, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lb/f/a/a;->b:Landroid/app/Fragment;

    if-eqz v0, :cond_1

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lb/f/a/a;->b:Landroid/app/Fragment;

    invoke-virtual {v1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    const-class v2, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lb/f/a/a;->c:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v1

    const-class v2, Lcom/leon/lfilepickerlibrary/ui/LFilePickerActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :goto_0
    return-object v0
.end method


# virtual methods
.method public c()V
    .locals 3

    iget-object v0, p0, Lb/f/a/a;->a:Landroid/app/Activity;

    if-nez v0, :cond_1

    iget-object v0, p0, Lb/f/a/a;->b:Landroid/app/Fragment;

    if-nez v0, :cond_1

    iget-object v0, p0, Lb/f/a/a;->c:Landroidx/fragment/app/Fragment;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "You must pass Activity or Fragment by withActivity or withFragment or withSupportFragment method"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    :goto_0
    invoke-direct {p0}, Lb/f/a/a;->b()Landroid/content/Intent;

    move-result-object v0

    invoke-direct {p0}, Lb/f/a/a;->a()Landroid/os/Bundle;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    iget-object v1, p0, Lb/f/a/a;->a:Landroid/app/Activity;

    if-eqz v1, :cond_2

    iget v2, p0, Lb/f/a/a;->h:I

    invoke-virtual {v1, v0, v2}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_1

    :cond_2
    iget-object v1, p0, Lb/f/a/a;->b:Landroid/app/Fragment;

    if-eqz v1, :cond_3

    iget v2, p0, Lb/f/a/a;->h:I

    invoke-virtual {v1, v0, v2}, Landroid/app/Fragment;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lb/f/a/a;->c:Landroidx/fragment/app/Fragment;

    iget v2, p0, Lb/f/a/a;->h:I

    invoke-virtual {v1, v0, v2}, Landroidx/fragment/app/Fragment;->i1(Landroid/content/Intent;I)V

    :goto_1
    return-void
.end method

.method public d(Landroid/app/Activity;)Lb/f/a/a;
    .locals 0

    iput-object p1, p0, Lb/f/a/a;->a:Landroid/app/Activity;

    return-object p0
.end method

.method public e([Ljava/lang/String;)Lb/f/a/a;
    .locals 0

    iput-object p1, p0, Lb/f/a/a;->m:[Ljava/lang/String;

    return-object p0
.end method

.method public f(Z)Lb/f/a/a;
    .locals 0

    iput-boolean p1, p0, Lb/f/a/a;->i:Z

    return-object p0
.end method

.method public g(I)Lb/f/a/a;
    .locals 0

    iput p1, p0, Lb/f/a/a;->h:I

    return-object p0
.end method

.method public h(Ljava/lang/String;)Lb/f/a/a;
    .locals 0

    iput-object p1, p0, Lb/f/a/a;->d:Ljava/lang/String;

    return-object p0
.end method
