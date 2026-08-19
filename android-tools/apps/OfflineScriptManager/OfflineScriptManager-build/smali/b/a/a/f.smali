.class public Lb/a/a/f;
.super Lb/a/a/c;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lb/a/a/a$c;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/a/a/f$e;,
        Lb/a/a/f$d;,
        Lb/a/a/f$f;,
        Lb/a/a/f$g;,
        Lb/a/a/f$m;,
        Lb/a/a/f$i;,
        Lb/a/a/f$j;,
        Lb/a/a/f$k;,
        Lb/a/a/f$h;,
        Lb/a/a/f$l;
    }
.end annotation


# instance fields
.field protected final d:Lb/a/a/f$d;

.field protected e:Landroid/widget/ImageView;

.field protected f:Landroid/widget/TextView;

.field protected g:Landroid/widget/TextView;

.field h:Landroid/widget/EditText;

.field i:Landroidx/recyclerview/widget/RecyclerView;

.field j:Landroid/view/View;

.field k:Landroid/widget/FrameLayout;

.field l:Landroid/widget/ProgressBar;

.field m:Landroid/widget/TextView;

.field n:Landroid/widget/TextView;

.field o:Landroid/widget/TextView;

.field p:Landroid/widget/CheckBox;

.field q:Lcom/afollestad/materialdialogs/internal/MDButton;

.field r:Lcom/afollestad/materialdialogs/internal/MDButton;

.field s:Lcom/afollestad/materialdialogs/internal/MDButton;

.field t:Lb/a/a/f$l;

.field u:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method protected constructor <init>(Lb/a/a/f$d;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InflateParams"
        }
    .end annotation

    iget-object v0, p1, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-static {p1}, Lb/a/a/d;->c(Lb/a/a/f$d;)I

    move-result v1

    invoke-direct {p0, v0, v1}, Lb/a/a/c;-><init>(Landroid/content/Context;I)V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, p1, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {p1}, Lb/a/a/d;->b(Lb/a/a/f$d;)I

    move-result p1

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    iput-object p1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    invoke-static {p0}, Lb/a/a/d;->d(Lb/a/a/f;)V

    return-void
.end method

.method private m()Z
    .locals 5

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, v0, Lb/a/a/f$d;->H:Lb/a/a/f$i;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-ltz v3, :cond_1

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    iget-object v4, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v4, v4, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    if-le v3, v4, :cond_2

    goto :goto_0

    :cond_2
    iget-object v3, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v3, v3, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v1, Lb/a/a/f$d;->H:Lb/a/a/f$i;

    iget-object v2, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    new-array v3, v3, [Ljava/lang/Integer;

    invoke-interface {v2, v3}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/Integer;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    new-array v3, v3, [Ljava/lang/CharSequence;

    invoke-interface {v0, v3}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/CharSequence;

    invoke-interface {v1, p0, v2, v0}, Lb/a/a/f$i;->a(Lb/a/a/f;[Ljava/lang/Integer;[Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method private n(Landroid/view/View;)Z
    .locals 3

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v0, Lb/a/a/f$d;->G:Lb/a/a/f$j;

    if-nez v1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const/4 v1, 0x0

    iget v2, v0, Lb/a/a/f$d;->O:I

    if-ltz v2, :cond_1

    iget-object v0, v0, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_1

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v0, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    iget v0, v0, Lb/a/a/f$d;->O:I

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    :cond_1
    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v2, v0, Lb/a/a/f$d;->G:Lb/a/a/f$j;

    iget v0, v0, Lb/a/a/f$d;->O:I

    invoke-interface {v2, p0, p1, v0, v1}, Lb/a/a/f$j;->a(Lb/a/a/f;Landroid/view/View;ILjava/lang/CharSequence;)Z

    move-result p1

    return p1
.end method


# virtual methods
.method public a(Lb/a/a/f;Landroid/view/View;ILjava/lang/CharSequence;Z)Z
    .locals 3

    invoke-virtual {p2}, Landroid/view/View;->isEnabled()Z

    move-result p1

    const/4 p4, 0x0

    if-nez p1, :cond_0

    return p4

    :cond_0
    iget-object p1, p0, Lb/a/a/f;->t:Lb/a/a/f$l;

    const/4 v0, 0x1

    if-eqz p1, :cond_c

    sget-object v1, Lb/a/a/f$l;->b:Lb/a/a/f$l;

    if-ne p1, v1, :cond_1

    goto/16 :goto_3

    :cond_1
    sget-object p5, Lb/a/a/f$l;->d:Lb/a/a/f$l;

    if-ne p1, p5, :cond_8

    sget p1, Lb/a/a/k;->md_control:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isEnabled()Z

    move-result p2

    if-nez p2, :cond_2

    return p4

    :cond_2
    iget-object p2, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p5

    invoke-interface {p2, p5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p2

    xor-int/2addr p2, v0

    if-eqz p2, :cond_5

    iget-object p2, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    invoke-interface {p2, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p2, p2, Lb/a/a/f$d;->I:Z

    if-eqz p2, :cond_4

    invoke-direct {p0}, Lb/a/a/f;->m()Z

    move-result p2

    if-eqz p2, :cond_3

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-interface {p1, p2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    goto/16 :goto_4

    :cond_4
    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto/16 :goto_4

    :cond_5
    iget-object p2, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p5

    invoke-interface {p2, p5}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p2, p2, Lb/a/a/f$d;->I:Z

    if-eqz p2, :cond_7

    invoke-direct {p0}, Lb/a/a/f;->m()Z

    move-result p2

    if-eqz p2, :cond_6

    goto :goto_1

    :cond_6
    iget-object p1, p0, Lb/a/a/f;->u:Ljava/util/List;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_4

    :cond_7
    :goto_1
    invoke-virtual {p1, p4}, Landroid/widget/CheckBox;->setChecked(Z)V

    goto/16 :goto_4

    :cond_8
    sget-object p5, Lb/a/a/f$l;->c:Lb/a/a/f$l;

    if-ne p1, p5, :cond_f

    sget p1, Lb/a/a/k;->md_control:I

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/RadioButton;

    invoke-virtual {p1}, Landroid/widget/RadioButton;->isEnabled()Z

    move-result p5

    if-nez p5, :cond_9

    return p4

    :cond_9
    iget-object p5, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v1, p5, Lb/a/a/f$d;->O:I

    iget-boolean v2, p5, Lb/a/a/f$d;->R:Z

    if-eqz v2, :cond_a

    iget-object v2, p5, Lb/a/a/f$d;->m:Ljava/lang/CharSequence;

    if-nez v2, :cond_a

    invoke-virtual {p0}, Lb/a/a/f;->dismiss()V

    iget-object p5, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iput p3, p5, Lb/a/a/f$d;->O:I

    invoke-direct {p0, p2}, Lb/a/a/f;->n(Landroid/view/View;)Z

    goto :goto_2

    :cond_a
    iget-boolean p4, p5, Lb/a/a/f$d;->J:Z

    if-eqz p4, :cond_b

    iput p3, p5, Lb/a/a/f$d;->O:I

    invoke-direct {p0, p2}, Lb/a/a/f;->n(Landroid/view/View;)Z

    move-result p4

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iput v1, p2, Lb/a/a/f$d;->O:I

    goto :goto_2

    :cond_b
    move p4, v0

    :goto_2
    if-eqz p4, :cond_f

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iput p3, p2, Lb/a/a/f$d;->O:I

    invoke-virtual {p1, v0}, Landroid/widget/RadioButton;->setChecked(Z)V

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    invoke-virtual {p1, v1}, Landroidx/recyclerview/widget/RecyclerView$g;->h(I)V

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    invoke-virtual {p1, p3}, Landroidx/recyclerview/widget/RecyclerView$g;->h(I)V

    goto :goto_4

    :cond_c
    :goto_3
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p1, p1, Lb/a/a/f$d;->R:Z

    if-eqz p1, :cond_d

    invoke-virtual {p0}, Lb/a/a/f;->dismiss()V

    :cond_d
    if-nez p5, :cond_e

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p4, p1, Lb/a/a/f$d;->E:Lb/a/a/f$h;

    if-eqz p4, :cond_e

    iget-object p1, p1, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/CharSequence;

    invoke-interface {p4, p0, p2, p3, p1}, Lb/a/a/f$h;->a(Lb/a/a/f;Landroid/view/View;ILjava/lang/CharSequence;)V

    :cond_e
    if-eqz p5, :cond_f

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p4, p1, Lb/a/a/f$d;->F:Lb/a/a/f$k;

    if-eqz p4, :cond_f

    iget-object p1, p1, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/CharSequence;

    invoke-interface {p4, p0, p2, p3, p1}, Lb/a/a/f$k;->a(Lb/a/a/f;Landroid/view/View;ILjava/lang/CharSequence;)Z

    move-result p1

    return p1

    :cond_f
    :goto_4
    return v0
.end method

.method final d()V
    .locals 2

    iget-object v0, p0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    new-instance v1, Lb/a/a/f$a;

    invoke-direct {v1, p0}, Lb/a/a/f$a;-><init>(Lb/a/a/f;)V

    invoke-virtual {v0, v1}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    return-void
.end method

.method public dismiss()V
    .locals 1

    iget-object v0, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    invoke-static {p0, v0}, Lb/a/a/q/a;->f(Landroid/content/DialogInterface;Lb/a/a/f$d;)V

    :cond_0
    invoke-super {p0}, Landroid/app/Dialog;->dismiss()V

    return-void
.end method

.method public final e(Lb/a/a/b;)Lcom/afollestad/materialdialogs/internal/MDButton;
    .locals 1

    sget-object v0, Lb/a/a/f$c;->a:[I

    invoke-virtual {p1}, Ljava/lang/Enum;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_1

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    return-object p1

    :cond_0
    iget-object p1, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    return-object p1

    :cond_1
    iget-object p1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    return-object p1
.end method

.method public final f()Lb/a/a/f$d;
    .locals 1

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    return-object v0
.end method

.method g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;
    .locals 2

    const/4 v0, 0x0

    if-eqz p2, :cond_2

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p1, Lb/a/a/f$d;->L0:I

    iget-object p1, p1, Lb/a/a/f$d;->a:Landroid/content/Context;

    if-eqz p2, :cond_0

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->L0:I

    invoke-static {p1, p2, v0}, Landroidx/core/content/c/f;->a(Landroid/content/res/Resources;ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    return-object p1

    :cond_0
    sget p2, Lb/a/a/g;->md_btn_stacked_selector:I

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_1

    return-object p1

    :cond_1
    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    return-object p1

    :cond_2
    sget-object p2, Lb/a/a/f$c;->a:[I

    invoke-virtual {p1}, Ljava/lang/Enum;->ordinal()I

    move-result p1

    aget p1, p2, p1

    const/4 p2, 0x1

    const/16 v1, 0x15

    if-eq p1, p2, :cond_a

    const/4 p2, 0x2

    if-eq p1, p2, :cond_6

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p1, Lb/a/a/f$d;->M0:I

    iget-object p1, p1, Lb/a/a/f$d;->a:Landroid/content/Context;

    if-eqz p2, :cond_3

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->M0:I

    invoke-static {p1, p2, v0}, Landroidx/core/content/c/f;->a(Landroid/content/res/Resources;ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    return-object p1

    :cond_3
    sget p2, Lb/a/a/g;->md_btn_positive_selector:I

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_4

    return-object p1

    :cond_4
    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p2, v1, :cond_5

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->h:I

    invoke-static {p1, p2}, Lb/a/a/q/b;->a(Landroid/graphics/drawable/Drawable;I)V

    :cond_5
    return-object p1

    :cond_6
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p1, Lb/a/a/f$d;->O0:I

    iget-object p1, p1, Lb/a/a/f$d;->a:Landroid/content/Context;

    if-eqz p2, :cond_7

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->O0:I

    invoke-static {p1, p2, v0}, Landroidx/core/content/c/f;->a(Landroid/content/res/Resources;ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    return-object p1

    :cond_7
    sget p2, Lb/a/a/g;->md_btn_negative_selector:I

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_8

    return-object p1

    :cond_8
    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p2, v1, :cond_9

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->h:I

    invoke-static {p1, p2}, Lb/a/a/q/b;->a(Landroid/graphics/drawable/Drawable;I)V

    :cond_9
    return-object p1

    :cond_a
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p1, Lb/a/a/f$d;->N0:I

    iget-object p1, p1, Lb/a/a/f$d;->a:Landroid/content/Context;

    if-eqz p2, :cond_b

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->N0:I

    invoke-static {p1, p2, v0}, Landroidx/core/content/c/f;->a(Landroid/content/res/Resources;ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    return-object p1

    :cond_b
    sget p2, Lb/a/a/g;->md_btn_neutral_selector:I

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_c

    return-object p1

    :cond_c
    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, p2}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p2, v1, :cond_d

    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget p2, p2, Lb/a/a/f$d;->h:I

    invoke-static {p1, p2}, Lb/a/a/q/b;->a(Landroid/graphics/drawable/Drawable;I)V

    :cond_d
    return-object p1
.end method

.method public final h()Landroid/widget/EditText;
    .locals 1

    iget-object v0, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    return-object v0
.end method

.method final i()Landroid/graphics/drawable/Drawable;
    .locals 3

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v1, v0, Lb/a/a/f$d;->K0:I

    iget-object v0, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v1, v1, Lb/a/a/f$d;->K0:I

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroidx/core/content/c/f;->a(Landroid/content/res/Resources;ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0

    :cond_0
    sget v1, Lb/a/a/g;->md_list_selector:I

    invoke-static {v0, v1}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_1

    return-object v0

    :cond_1
    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, v1}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public final j()Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    return-object v0
.end method

.method k(IZ)V
    .locals 6

    iget-object v0, p0, Lb/a/a/f;->o:Landroid/widget/TextView;

    if-eqz v0, :cond_8

    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v1, v1, Lb/a/a/f$d;->t0:I

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-lez v1, :cond_0

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v3

    iget-object v5, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v5, v5, Lb/a/a/f$d;->t0:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v2

    const-string v5, "%d/%d"

    invoke-static {v1, v5, v4}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lb/a/a/f;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    if-eqz p2, :cond_1

    if-eqz p1, :cond_3

    :cond_1
    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v0, p2, Lb/a/a/f$d;->t0:I

    if-lez v0, :cond_2

    if-gt p1, v0, :cond_3

    :cond_2
    iget p2, p2, Lb/a/a/f$d;->s0:I

    if-ge p1, p2, :cond_4

    :cond_3
    move v3, v2

    :cond_4
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    if-eqz v3, :cond_5

    iget p1, p1, Lb/a/a/f$d;->u0:I

    goto :goto_1

    :cond_5
    iget p1, p1, Lb/a/a/f$d;->j:I

    :goto_1
    iget-object p2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    if-eqz v3, :cond_6

    iget p2, p2, Lb/a/a/f$d;->u0:I

    goto :goto_2

    :cond_6
    iget p2, p2, Lb/a/a/f$d;->t:I

    :goto_2
    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v0, v0, Lb/a/a/f$d;->t0:I

    if-lez v0, :cond_7

    iget-object v0, p0, Lb/a/a/f;->o:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_7
    iget-object p1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-static {p1, p2}, Lcom/afollestad/materialdialogs/internal/c;->e(Landroid/widget/EditText;I)V

    sget-object p1, Lb/a/a/b;->b:Lb/a/a/b;

    invoke-virtual {p0, p1}, Lb/a/a/f;->e(Lb/a/a/b;)Lcom/afollestad/materialdialogs/internal/MDButton;

    move-result-object p1

    xor-int/lit8 p2, v3, 0x1

    invoke-virtual {p1, p2}, Landroid/view/View;->setEnabled(Z)V

    :cond_8
    return-void
.end method

.method final l()V
    .locals 3

    iget-object v0, p0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, v0, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, v0, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    if-nez v0, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v0, Lb/a/a/f$d;->Y:Landroidx/recyclerview/widget/RecyclerView$o;

    if-nez v1, :cond_3

    new-instance v1, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lb/a/a/f$d;->Y:Landroidx/recyclerview/widget/RecyclerView$o;

    :cond_3
    iget-object v0, p0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v1, Lb/a/a/f$d;->Y:Landroidx/recyclerview/widget/RecyclerView$o;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$o;)V

    iget-object v0, p0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v1, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$g;)V

    iget-object v0, p0, Lb/a/a/f;->t:Lb/a/a/f$l;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, v0, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    check-cast v0, Lb/a/a/a;

    invoke-virtual {v0, p0}, Lb/a/a/a;->A(Lb/a/a/a$c;)V

    :cond_4
    return-void
.end method

.method o()V
    .locals 2

    iget-object v0, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v1, Lb/a/a/f$b;

    invoke-direct {v1, p0}, Lb/a/a/f$b;-><init>(Lb/a/a/f;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    return-void
.end method

.method public final onClick(Landroid/view/View;)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/a/a/b;

    sget-object v1, Lb/a/a/f$c;->a:[I

    invoke-virtual {v0}, Ljava/lang/Enum;->ordinal()I

    move-result v2

    aget v1, v1, v2

    const/4 v2, 0x1

    if-eq v1, v2, :cond_9

    const/4 v2, 0x2

    if-eq v1, v2, :cond_6

    const/4 v2, 0x3

    if-eq v1, v2, :cond_0

    goto/16 :goto_1

    :cond_0
    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v1, Lb/a/a/f$d;->z:Lb/a/a/f$e;

    if-eqz v1, :cond_1

    invoke-virtual {v1, p0}, Lb/a/a/f$e;->a(Lb/a/a/f;)V

    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v1, Lb/a/a/f$d;->z:Lb/a/a/f$e;

    invoke-virtual {v1, p0}, Lb/a/a/f$e;->d(Lb/a/a/f;)V

    :cond_1
    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, v1, Lb/a/a/f$d;->A:Lb/a/a/f$m;

    if-eqz v1, :cond_2

    invoke-interface {v1, p0, v0}, Lb/a/a/f$m;->a(Lb/a/a/f;Lb/a/a/b;)V

    :cond_2
    iget-object v1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean v1, v1, Lb/a/a/f$d;->J:Z

    if-nez v1, :cond_3

    invoke-direct {p0, p1}, Lb/a/a/f;->n(Landroid/view/View;)Z

    :cond_3
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p1, p1, Lb/a/a/f$d;->I:Z

    if-nez p1, :cond_4

    invoke-direct {p0}, Lb/a/a/f;->m()Z

    :cond_4
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, p1, Lb/a/a/f$d;->o0:Lb/a/a/f$g;

    if-eqz v1, :cond_5

    iget-object v2, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    if-eqz v2, :cond_5

    iget-boolean p1, p1, Lb/a/a/f$d;->r0:Z

    if-nez p1, :cond_5

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-interface {v1, p0, p1}, Lb/a/a/f$g;->a(Lb/a/a/f;Ljava/lang/CharSequence;)V

    :cond_5
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p1, p1, Lb/a/a/f$d;->R:Z

    if-eqz p1, :cond_c

    goto :goto_0

    :cond_6
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->z:Lb/a/a/f$e;

    if-eqz p1, :cond_7

    invoke-virtual {p1, p0}, Lb/a/a/f$e;->a(Lb/a/a/f;)V

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->z:Lb/a/a/f$e;

    invoke-virtual {p1, p0}, Lb/a/a/f$e;->b(Lb/a/a/f;)V

    :cond_7
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->B:Lb/a/a/f$m;

    if-eqz p1, :cond_8

    invoke-interface {p1, p0, v0}, Lb/a/a/f$m;->a(Lb/a/a/f;Lb/a/a/b;)V

    :cond_8
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p1, p1, Lb/a/a/f$d;->R:Z

    if-eqz p1, :cond_c

    invoke-virtual {p0}, Landroid/app/Dialog;->cancel()V

    goto :goto_1

    :cond_9
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->z:Lb/a/a/f$e;

    if-eqz p1, :cond_a

    invoke-virtual {p1, p0}, Lb/a/a/f$e;->a(Lb/a/a/f;)V

    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->z:Lb/a/a/f$e;

    invoke-virtual {p1, p0}, Lb/a/a/f$e;->c(Lb/a/a/f;)V

    :cond_a
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->C:Lb/a/a/f$m;

    if-eqz p1, :cond_b

    invoke-interface {p1, p0, v0}, Lb/a/a/f$m;->a(Lb/a/a/f;Lb/a/a/b;)V

    :cond_b
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean p1, p1, Lb/a/a/f$d;->R:Z

    if-eqz p1, :cond_c

    :goto_0
    invoke-virtual {p0}, Lb/a/a/f;->dismiss()V

    :cond_c
    :goto_1
    iget-object p1, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object p1, p1, Lb/a/a/f$d;->D:Lb/a/a/f$m;

    if-eqz p1, :cond_d

    invoke-interface {p1, p0, v0}, Lb/a/a/f$m;->a(Lb/a/a/f;Lb/a/a/b;)V

    :cond_d
    return-void
.end method

.method public final onShow(Landroid/content/DialogInterface;)V
    .locals 2

    iget-object v0, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    invoke-static {p0, v0}, Lb/a/a/q/a;->u(Landroid/content/DialogInterface;Lb/a/a/f$d;)V

    iget-object v0, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    :cond_0
    invoke-super {p0, p1}, Lb/a/a/c;->onShow(Landroid/content/DialogInterface;)V

    return-void
.end method

.method public final p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V
    .locals 1

    if-nez p2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/widget/TextView;->getPaintFlags()I

    move-result v0

    or-int/lit16 v0, v0, 0x80

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setPaintFlags(I)V

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    return-void
.end method

.method public final setTitle(I)V
    .locals 1

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v0, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-virtual {v0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lb/a/a/f;->setTitle(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public final setTitle(Ljava/lang/CharSequence;)V
    .locals 1

    iget-object v0, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public show()V
    .locals 2

    :try_start_0
    invoke-super {p0}, Landroid/app/Dialog;->show()V
    :try_end_0
    .catch Landroid/view/WindowManager$BadTokenException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    new-instance v0, Lb/a/a/f$f;

    const-string v1, "Bad window token, you cannot show a dialog before an Activity is created or after it\'s hidden."

    invoke-direct {v0, v1}, Lb/a/a/f$f;-><init>(Ljava/lang/String;)V

    throw v0
.end method
