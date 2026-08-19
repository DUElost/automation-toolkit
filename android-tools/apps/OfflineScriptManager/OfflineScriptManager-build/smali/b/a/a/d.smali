.class Lb/a/a/d;
.super Ljava/lang/Object;
.source ""


# direct methods
.method private static a(Landroid/widget/ProgressBar;)V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-ge v0, v1, :cond_0

    invoke-virtual {p0}, Landroid/widget/ProgressBar;->isHardwareAccelerated()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/widget/ProgressBar;->getLayerType()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0, v1, v0}, Landroid/widget/ProgressBar;->setLayerType(ILandroid/graphics/Paint;)V

    :cond_0
    return-void
.end method

.method static b(Lb/a/a/f$d;)I
    .locals 2

    iget-object v0, p0, Lb/a/a/f$d;->s:Landroid/view/View;

    if-eqz v0, :cond_0

    sget p0, Lb/a/a/l;->md_dialog_custom:I

    return p0

    :cond_0
    iget-object v0, p0, Lb/a/a/f$d;->l:Ljava/util/ArrayList;

    if-nez v0, :cond_8

    iget-object v0, p0, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    iget v0, p0, Lb/a/a/f$d;->k0:I

    const/4 v1, -0x2

    if-le v0, v1, :cond_2

    sget p0, Lb/a/a/l;->md_dialog_progress:I

    return p0

    :cond_2
    iget-boolean v0, p0, Lb/a/a/f$d;->i0:Z

    if-eqz v0, :cond_4

    iget-boolean p0, p0, Lb/a/a/f$d;->B0:Z

    if-eqz p0, :cond_3

    sget p0, Lb/a/a/l;->md_dialog_progress_indeterminate_horizontal:I

    return p0

    :cond_3
    sget p0, Lb/a/a/l;->md_dialog_progress_indeterminate:I

    return p0

    :cond_4
    iget-object v0, p0, Lb/a/a/f$d;->o0:Lb/a/a/f$g;

    iget-object p0, p0, Lb/a/a/f$d;->w0:Ljava/lang/CharSequence;

    if-eqz v0, :cond_6

    if-eqz p0, :cond_5

    sget p0, Lb/a/a/l;->md_dialog_input_check:I

    return p0

    :cond_5
    sget p0, Lb/a/a/l;->md_dialog_input:I

    return p0

    :cond_6
    if-eqz p0, :cond_7

    sget p0, Lb/a/a/l;->md_dialog_basic_check:I

    return p0

    :cond_7
    sget p0, Lb/a/a/l;->md_dialog_basic:I

    return p0

    :cond_8
    :goto_0
    iget-object p0, p0, Lb/a/a/f$d;->w0:Ljava/lang/CharSequence;

    if-eqz p0, :cond_9

    sget p0, Lb/a/a/l;->md_dialog_list_check:I

    return p0

    :cond_9
    sget p0, Lb/a/a/l;->md_dialog_list:I

    return p0
.end method

.method static c(Lb/a/a/f$d;)I
    .locals 4

    iget-object v0, p0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v1, Lb/a/a/g;->md_dark_theme:I

    iget-object v2, p0, Lb/a/a/f$d;->K:Lb/a/a/p;

    sget-object v3, Lb/a/a/p;->c:Lb/a/a/p;

    if-ne v2, v3, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-static {v0, v1, v2}, Lb/a/a/q/a;->k(Landroid/content/Context;IZ)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_1

    :cond_1
    sget-object v3, Lb/a/a/p;->b:Lb/a/a/p;

    :goto_1
    iput-object v3, p0, Lb/a/a/f$d;->K:Lb/a/a/p;

    if-eqz v0, :cond_2

    sget p0, Lb/a/a/m;->MD_Dark:I

    goto :goto_2

    :cond_2
    sget p0, Lb/a/a/m;->MD_Light:I

    :goto_2
    return p0
.end method

.method public static d(Lb/a/a/f;)V
    .locals 11

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean v1, v0, Lb/a/a/f$d;->L:Z

    invoke-virtual {p0, v1}, Landroid/app/Dialog;->setCancelable(Z)V

    iget-boolean v1, v0, Lb/a/a/f$d;->M:Z

    invoke-virtual {p0, v1}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V

    iget v1, v0, Lb/a/a/f$d;->g0:I

    if-nez v1, :cond_0

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v2, Lb/a/a/g;->md_background_color:I

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v3

    sget v4, Lb/a/a/g;->colorBackgroundFloating:I

    invoke-static {v3, v4}, Lb/a/a/q/a;->l(Landroid/content/Context;I)I

    move-result v3

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->m(Landroid/content/Context;II)I

    move-result v1

    iput v1, v0, Lb/a/a/f$d;->g0:I

    :cond_0
    iget v1, v0, Lb/a/a/f$d;->g0:I

    if-eqz v1, :cond_1

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    iget-object v2, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lb/a/a/i;->md_bg_corner_radius:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    iget v2, v0, Lb/a/a/f$d;->g0:I

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {p0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_1
    iget-boolean v1, v0, Lb/a/a/f$d;->F0:Z

    if-nez v1, :cond_2

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v2, Lb/a/a/g;->md_positive_color:I

    iget-object v3, v0, Lb/a/a/f$d;->v:Landroid/content/res/ColorStateList;

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->i(Landroid/content/Context;ILandroid/content/res/ColorStateList;)Landroid/content/res/ColorStateList;

    move-result-object v1

    iput-object v1, v0, Lb/a/a/f$d;->v:Landroid/content/res/ColorStateList;

    :cond_2
    iget-boolean v1, v0, Lb/a/a/f$d;->G0:Z

    if-nez v1, :cond_3

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v2, Lb/a/a/g;->md_neutral_color:I

    iget-object v3, v0, Lb/a/a/f$d;->x:Landroid/content/res/ColorStateList;

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->i(Landroid/content/Context;ILandroid/content/res/ColorStateList;)Landroid/content/res/ColorStateList;

    move-result-object v1

    iput-object v1, v0, Lb/a/a/f$d;->x:Landroid/content/res/ColorStateList;

    :cond_3
    iget-boolean v1, v0, Lb/a/a/f$d;->H0:Z

    if-nez v1, :cond_4

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v2, Lb/a/a/g;->md_negative_color:I

    iget-object v3, v0, Lb/a/a/f$d;->w:Landroid/content/res/ColorStateList;

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->i(Landroid/content/Context;ILandroid/content/res/ColorStateList;)Landroid/content/res/ColorStateList;

    move-result-object v1

    iput-object v1, v0, Lb/a/a/f$d;->w:Landroid/content/res/ColorStateList;

    :cond_4
    iget-boolean v1, v0, Lb/a/a/f$d;->I0:Z

    if-nez v1, :cond_5

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v2, Lb/a/a/g;->md_widget_color:I

    iget v3, v0, Lb/a/a/f$d;->t:I

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->m(Landroid/content/Context;II)I

    move-result v1

    iput v1, v0, Lb/a/a/f$d;->t:I

    :cond_5
    iget-boolean v1, v0, Lb/a/a/f$d;->C0:Z

    const v2, 0x1010036

    if-nez v1, :cond_6

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v2}, Lb/a/a/q/a;->l(Landroid/content/Context;I)I

    move-result v1

    iget-object v3, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v4, Lb/a/a/g;->md_title_color:I

    invoke-static {v3, v4, v1}, Lb/a/a/q/a;->m(Landroid/content/Context;II)I

    move-result v1

    iput v1, v0, Lb/a/a/f$d;->i:I

    :cond_6
    iget-boolean v1, v0, Lb/a/a/f$d;->D0:Z

    if-nez v1, :cond_7

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v1

    const v3, 0x1010038

    invoke-static {v1, v3}, Lb/a/a/q/a;->l(Landroid/content/Context;I)I

    move-result v1

    iget-object v3, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v4, Lb/a/a/g;->md_content_color:I

    invoke-static {v3, v4, v1}, Lb/a/a/q/a;->m(Landroid/content/Context;II)I

    move-result v1

    iput v1, v0, Lb/a/a/f$d;->j:I

    :cond_7
    iget-boolean v1, v0, Lb/a/a/f$d;->E0:Z

    if-nez v1, :cond_8

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v3, Lb/a/a/g;->md_item_color:I

    iget v4, v0, Lb/a/a/f$d;->j:I

    invoke-static {v1, v3, v4}, Lb/a/a/q/a;->m(Landroid/content/Context;II)I

    move-result v1

    iput v1, v0, Lb/a/a/f$d;->h0:I

    :cond_8
    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_title:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_icon:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_titleFrame:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lb/a/a/f;->j:Landroid/view/View;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_content:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_contentRecyclerView:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    iput-object v1, p0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_promptCheckbox:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/CheckBox;

    iput-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_buttonDefaultPositive:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/afollestad/materialdialogs/internal/MDButton;

    iput-object v1, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_buttonDefaultNeutral:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/afollestad/materialdialogs/internal/MDButton;

    iput-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_buttonDefaultNegative:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/afollestad/materialdialogs/internal/MDButton;

    iput-object v1, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v1, v0, Lb/a/a/f$d;->o0:Lb/a/a/f$g;

    if-eqz v1, :cond_9

    iget-object v1, v0, Lb/a/a/f$d;->m:Ljava/lang/CharSequence;

    if-nez v1, :cond_9

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    const v3, 0x104000a

    invoke-virtual {v1, v3}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    iput-object v1, v0, Lb/a/a/f$d;->m:Ljava/lang/CharSequence;

    :cond_9
    iget-object v1, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v3, v0, Lb/a/a/f$d;->m:Ljava/lang/CharSequence;

    const/16 v4, 0x8

    const/4 v5, 0x0

    if-eqz v3, :cond_a

    move v3, v5

    goto :goto_0

    :cond_a
    move v3, v4

    :goto_0
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v3, v0, Lb/a/a/f$d;->n:Ljava/lang/CharSequence;

    if-eqz v3, :cond_b

    move v3, v5

    goto :goto_1

    :cond_b
    move v3, v4

    :goto_1
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v3, v0, Lb/a/a/f$d;->o:Ljava/lang/CharSequence;

    if-eqz v3, :cond_c

    move v3, v5

    goto :goto_2

    :cond_c
    move v3, v4

    :goto_2
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setFocusable(Z)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setFocusable(Z)V

    iget-object v1, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setFocusable(Z)V

    iget-boolean v1, v0, Lb/a/a/f$d;->p:Z

    if-eqz v1, :cond_d

    iget-object v1, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1}, Landroid/widget/TextView;->requestFocus()Z

    :cond_d
    iget-boolean v1, v0, Lb/a/a/f$d;->q:Z

    if-eqz v1, :cond_e

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1}, Landroid/widget/TextView;->requestFocus()Z

    :cond_e
    iget-boolean v1, v0, Lb/a/a/f$d;->r:Z

    if-eqz v1, :cond_f

    iget-object v1, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1}, Landroid/widget/TextView;->requestFocus()Z

    :cond_f
    iget-object v1, v0, Lb/a/a/f$d;->U:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_10

    iget-object v1, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v1, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    iget-object v6, v0, Lb/a/a/f$d;->U:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v6}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_3

    :cond_10
    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v6, Lb/a/a/g;->md_icon:I

    invoke-static {v1, v6}, Lb/a/a/q/a;->p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :cond_11

    iget-object v6, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v6, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v6, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v6, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_3

    :cond_11
    iget-object v1, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    :goto_3
    iget v1, v0, Lb/a/a/f$d;->W:I

    const/4 v6, -0x1

    if-ne v1, v6, :cond_12

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v7, Lb/a/a/g;->md_icon_max_size:I

    invoke-static {v1, v7}, Lb/a/a/q/a;->n(Landroid/content/Context;I)I

    move-result v1

    :cond_12
    iget-boolean v7, v0, Lb/a/a/f$d;->V:Z

    if-nez v7, :cond_13

    iget-object v7, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v8, Lb/a/a/g;->md_icon_limit_icon_to_default_size:I

    invoke-static {v7, v8}, Lb/a/a/q/a;->j(Landroid/content/Context;I)Z

    move-result v7

    if-eqz v7, :cond_14

    :cond_13
    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget v7, Lb/a/a/i;->md_icon_max_size:I

    invoke-virtual {v1, v7}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    :cond_14
    if-le v1, v6, :cond_15

    iget-object v7, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v7, v3}, Landroid/widget/ImageView;->setAdjustViewBounds(Z)V

    iget-object v7, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v7, v1}, Landroid/widget/ImageView;->setMaxHeight(I)V

    iget-object v7, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v7, v1}, Landroid/widget/ImageView;->setMaxWidth(I)V

    iget-object v1, p0, Lb/a/a/f;->e:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->requestLayout()V

    :cond_15
    iget-boolean v1, v0, Lb/a/a/f$d;->J0:Z

    if-nez v1, :cond_16

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v1

    sget v7, Lb/a/a/g;->md_divider:I

    invoke-static {v1, v7}, Lb/a/a/q/a;->l(Landroid/content/Context;I)I

    move-result v1

    iget-object v7, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v8, Lb/a/a/g;->md_divider_color:I

    invoke-static {v7, v8, v1}, Lb/a/a/q/a;->m(Landroid/content/Context;II)I

    move-result v1

    iput v1, v0, Lb/a/a/f$d;->f0:I

    :cond_16
    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    iget v7, v0, Lb/a/a/f$d;->f0:I

    invoke-virtual {v1, v7}, Lcom/afollestad/materialdialogs/internal/MDRootLayout;->setDividerColor(I)V

    iget-object v1, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    const/16 v7, 0x11

    if-eqz v1, :cond_19

    iget-object v8, v0, Lb/a/a/f$d;->T:Landroid/graphics/Typeface;

    invoke-virtual {p0, v1, v8}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    iget-object v1, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    iget v8, v0, Lb/a/a/f$d;->i:I

    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    iget-object v8, v0, Lb/a/a/f$d;->c:Lb/a/a/e;

    invoke-virtual {v8}, Lb/a/a/e;->a()I

    move-result v8

    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setGravity(I)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v7, :cond_17

    iget-object v1, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    iget-object v8, v0, Lb/a/a/f$d;->c:Lb/a/a/e;

    invoke-virtual {v8}, Lb/a/a/e;->b()I

    move-result v8

    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setTextAlignment(I)V

    :cond_17
    iget-object v1, v0, Lb/a/a/f$d;->b:Ljava/lang/CharSequence;

    if-nez v1, :cond_18

    iget-object v1, p0, Lb/a/a/f;->j:Landroid/view/View;

    invoke-virtual {v1, v4}, Landroid/view/View;->setVisibility(I)V

    goto :goto_4

    :cond_18
    iget-object v8, p0, Lb/a/a/f;->f:Landroid/widget/TextView;

    invoke-virtual {v8, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lb/a/a/f;->j:Landroid/view/View;

    invoke-virtual {v1, v5}, Landroid/view/View;->setVisibility(I)V

    :cond_19
    :goto_4
    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    if-eqz v1, :cond_1d

    new-instance v8, Landroid/text/method/LinkMovementMethod;

    invoke-direct {v8}, Landroid/text/method/LinkMovementMethod;-><init>()V

    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    iget-object v8, v0, Lb/a/a/f$d;->S:Landroid/graphics/Typeface;

    invoke-virtual {p0, v1, v8}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    const/4 v8, 0x0

    iget v9, v0, Lb/a/a/f$d;->N:F

    invoke-virtual {v1, v8, v9}, Landroid/widget/TextView;->setLineSpacing(FF)V

    iget-object v1, v0, Lb/a/a/f$d;->y:Landroid/content/res/ColorStateList;

    if-nez v1, :cond_1a

    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-static {v8, v2}, Lb/a/a/q/a;->l(Landroid/content/Context;I)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setLinkTextColor(I)V

    goto :goto_5

    :cond_1a
    iget-object v2, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setLinkTextColor(Landroid/content/res/ColorStateList;)V

    :goto_5
    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    iget v2, v0, Lb/a/a/f$d;->j:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    iget-object v2, v0, Lb/a/a/f$d;->d:Lb/a/a/e;

    invoke-virtual {v2}, Lb/a/a/e;->a()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v7, :cond_1b

    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    iget-object v2, v0, Lb/a/a/f$d;->d:Lb/a/a/e;

    invoke-virtual {v2}, Lb/a/a/e;->b()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextAlignment(I)V

    :cond_1b
    iget-object v1, v0, Lb/a/a/f$d;->k:Ljava/lang/CharSequence;

    if-eqz v1, :cond_1c

    iget-object v2, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_6

    :cond_1c
    iget-object v1, p0, Lb/a/a/f;->g:Landroid/widget/TextView;

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_1d
    :goto_6
    iget-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    if-eqz v1, :cond_1e

    iget-object v2, v0, Lb/a/a/f$d;->w0:Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    iget-boolean v2, v0, Lb/a/a/f$d;->x0:Z

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    iget-object v2, v0, Lb/a/a/f$d;->y0:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    iget-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    iget-object v2, v0, Lb/a/a/f$d;->S:Landroid/graphics/Typeface;

    invoke-virtual {p0, v1, v2}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    iget-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    iget v2, v0, Lb/a/a/f$d;->j:I

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->p:Landroid/widget/CheckBox;

    iget v2, v0, Lb/a/a/f$d;->t:I

    invoke-static {v1, v2}, Lcom/afollestad/materialdialogs/internal/c;->c(Landroid/widget/CheckBox;I)V

    :cond_1e
    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    iget-object v2, v0, Lb/a/a/f$d;->g:Lb/a/a/e;

    invoke-virtual {v1, v2}, Lcom/afollestad/materialdialogs/internal/MDRootLayout;->setButtonGravity(Lb/a/a/e;)V

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    iget-object v2, v0, Lb/a/a/f$d;->e:Lb/a/a/e;

    invoke-virtual {v1, v2}, Lcom/afollestad/materialdialogs/internal/MDRootLayout;->setButtonStackedGravity(Lb/a/a/e;)V

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    iget-object v2, v0, Lb/a/a/f$d;->d0:Lb/a/a/o;

    invoke-virtual {v1, v2}, Lcom/afollestad/materialdialogs/internal/MDRootLayout;->setStackingBehavior(Lb/a/a/o;)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0xe

    if-lt v1, v2, :cond_1f

    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    const v2, 0x101038c

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->k(Landroid/content/Context;IZ)Z

    move-result v1

    if-eqz v1, :cond_20

    :cond_1f
    iget-object v1, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    sget v2, Lb/a/a/g;->textAllCaps:I

    invoke-static {v1, v2, v3}, Lb/a/a/q/a;->k(Landroid/content/Context;IZ)Z

    move-result v1

    :cond_20
    iget-object v2, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v4, v0, Lb/a/a/f$d;->T:Landroid/graphics/Typeface;

    invoke-virtual {p0, v2, v4}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    invoke-virtual {v2, v1}, Lcom/afollestad/materialdialogs/internal/MDButton;->setAllCapsCompat(Z)V

    iget-object v4, v0, Lb/a/a/f$d;->m:Ljava/lang/CharSequence;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, v0, Lb/a/a/f$d;->v:Landroid/content/res/ColorStateList;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    iget-object v2, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    sget-object v4, Lb/a/a/b;->b:Lb/a/a/b;

    invoke-virtual {p0, v4, v3}, Lb/a/a/f;->g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v2, v7}, Lcom/afollestad/materialdialogs/internal/MDButton;->setStackedSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v2, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {p0, v4, v5}, Lb/a/a/f;->g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v2, v7}, Lcom/afollestad/materialdialogs/internal/MDButton;->setDefaultSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v2, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lb/a/a/f;->q:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v4, v0, Lb/a/a/f$d;->T:Landroid/graphics/Typeface;

    invoke-virtual {p0, v2, v4}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    invoke-virtual {v2, v1}, Lcom/afollestad/materialdialogs/internal/MDButton;->setAllCapsCompat(Z)V

    iget-object v4, v0, Lb/a/a/f$d;->o:Ljava/lang/CharSequence;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, v0, Lb/a/a/f$d;->w:Landroid/content/res/ColorStateList;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    iget-object v2, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    sget-object v4, Lb/a/a/b;->d:Lb/a/a/b;

    invoke-virtual {p0, v4, v3}, Lb/a/a/f;->g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v2, v7}, Lcom/afollestad/materialdialogs/internal/MDButton;->setStackedSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v2, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {p0, v4, v5}, Lb/a/a/f;->g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v2, v7}, Lcom/afollestad/materialdialogs/internal/MDButton;->setDefaultSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v2, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lb/a/a/f;->s:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    iget-object v4, v0, Lb/a/a/f$d;->T:Landroid/graphics/Typeface;

    invoke-virtual {p0, v2, v4}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    invoke-virtual {v2, v1}, Lcom/afollestad/materialdialogs/internal/MDButton;->setAllCapsCompat(Z)V

    iget-object v1, v0, Lb/a/a/f$d;->n:Ljava/lang/CharSequence;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lb/a/a/f$d;->x:Landroid/content/res/ColorStateList;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    sget-object v2, Lb/a/a/b;->c:Lb/a/a/b;

    invoke-virtual {p0, v2, v3}, Lb/a/a/f;->g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/afollestad/materialdialogs/internal/MDButton;->setStackedSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {p0, v2, v5}, Lb/a/a/f;->g(Lb/a/a/b;Z)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/afollestad/materialdialogs/internal/MDButton;->setDefaultSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lb/a/a/f;->r:Lcom/afollestad/materialdialogs/internal/MDButton;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, v0, Lb/a/a/f$d;->H:Lb/a/a/f$i;

    if-eqz v1, :cond_21

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lb/a/a/f;->u:Ljava/util/List;

    :cond_21
    iget-object v1, p0, Lb/a/a/f;->i:Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v1, :cond_26

    iget-object v1, v0, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    if-nez v1, :cond_25

    iget-object v1, v0, Lb/a/a/f$d;->G:Lb/a/a/f$j;

    if-eqz v1, :cond_22

    sget-object v1, Lb/a/a/f$l;->c:Lb/a/a/f$l;

    :goto_7
    iput-object v1, p0, Lb/a/a/f;->t:Lb/a/a/f$l;

    goto :goto_8

    :cond_22
    iget-object v1, v0, Lb/a/a/f$d;->H:Lb/a/a/f$i;

    if-eqz v1, :cond_23

    sget-object v1, Lb/a/a/f$l;->d:Lb/a/a/f$l;

    iput-object v1, p0, Lb/a/a/f;->t:Lb/a/a/f$l;

    iget-object v1, v0, Lb/a/a/f$d;->P:[Ljava/lang/Integer;

    if-eqz v1, :cond_24

    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, v0, Lb/a/a/f$d;->P:[Ljava/lang/Integer;

    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v1, p0, Lb/a/a/f;->u:Ljava/util/List;

    const/4 v1, 0x0

    iput-object v1, v0, Lb/a/a/f$d;->P:[Ljava/lang/Integer;

    goto :goto_8

    :cond_23
    sget-object v1, Lb/a/a/f$l;->b:Lb/a/a/f$l;

    goto :goto_7

    :cond_24
    :goto_8
    new-instance v1, Lb/a/a/a;

    iget-object v2, p0, Lb/a/a/f;->t:Lb/a/a/f$l;

    invoke-static {v2}, Lb/a/a/f$l;->a(Lb/a/a/f$l;)I

    move-result v2

    invoke-direct {v1, p0, v2}, Lb/a/a/a;-><init>(Lb/a/a/f;I)V

    iput-object v1, v0, Lb/a/a/f$d;->X:Landroidx/recyclerview/widget/RecyclerView$g;

    goto :goto_9

    :cond_25
    instance-of v2, v1, Lcom/afollestad/materialdialogs/internal/b;

    if-eqz v2, :cond_26

    check-cast v1, Lcom/afollestad/materialdialogs/internal/b;

    invoke-interface {v1, p0}, Lcom/afollestad/materialdialogs/internal/b;->a(Lb/a/a/f;)V

    :cond_26
    :goto_9
    invoke-static {p0}, Lb/a/a/d;->f(Lb/a/a/f;)V

    invoke-static {p0}, Lb/a/a/d;->e(Lb/a/a/f;)V

    iget-object v1, v0, Lb/a/a/f$d;->s:Landroid/view/View;

    if-eqz v1, :cond_2a

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v2, Lb/a/a/k;->md_root:I

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    invoke-virtual {v1}, Lcom/afollestad/materialdialogs/internal/MDRootLayout;->t()V

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v2, Lb/a/a/k;->md_customViewFrame:I

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lb/a/a/f;->k:Landroid/widget/FrameLayout;

    iget-object v2, v0, Lb/a/a/f$d;->s:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    if-eqz v3, :cond_27

    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    check-cast v3, Landroid/view/ViewGroup;

    invoke-virtual {v3, v2}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :cond_27
    iget-boolean v3, v0, Lb/a/a/f$d;->e0:Z

    const/4 v4, -0x2

    if-eqz v3, :cond_29

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v7, Lb/a/a/i;->md_dialog_frame_margin:I

    invoke-virtual {v3, v7}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    new-instance v8, Landroid/widget/ScrollView;

    invoke-virtual {p0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v9

    invoke-direct {v8, v9}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    sget v9, Lb/a/a/i;->md_content_padding_top:I

    invoke-virtual {v3, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v9

    sget v10, Lb/a/a/i;->md_content_padding_bottom:I

    invoke-virtual {v3, v10}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    invoke-virtual {v8, v5}, Landroid/widget/ScrollView;->setClipToPadding(Z)V

    instance-of v10, v2, Landroid/widget/EditText;

    if-eqz v10, :cond_28

    invoke-virtual {v8, v7, v9, v7, v3}, Landroid/widget/ScrollView;->setPadding(IIII)V

    goto :goto_a

    :cond_28
    invoke-virtual {v8, v5, v9, v5, v3}, Landroid/widget/ScrollView;->setPadding(IIII)V

    invoke-virtual {v2, v7, v5, v7, v5}, Landroid/view/View;->setPadding(IIII)V

    :goto_a
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v3, v6, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v8, v2, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    move-object v2, v8

    :cond_29
    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v3, v6, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :cond_2a
    iget-object v1, v0, Lb/a/a/f$d;->c0:Landroid/content/DialogInterface$OnShowListener;

    if-eqz v1, :cond_2b

    invoke-virtual {p0, v1}, Lb/a/a/c;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    :cond_2b
    iget-object v1, v0, Lb/a/a/f$d;->a0:Landroid/content/DialogInterface$OnCancelListener;

    if-eqz v1, :cond_2c

    invoke-virtual {p0, v1}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    :cond_2c
    iget-object v1, v0, Lb/a/a/f$d;->Z:Landroid/content/DialogInterface$OnDismissListener;

    if-eqz v1, :cond_2d

    invoke-virtual {p0, v1}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    :cond_2d
    iget-object v1, v0, Lb/a/a/f$d;->b0:Landroid/content/DialogInterface$OnKeyListener;

    if-eqz v1, :cond_2e

    invoke-virtual {p0, v1}, Landroid/app/Dialog;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)V

    :cond_2e
    invoke-virtual {p0}, Lb/a/a/c;->b()V

    invoke-virtual {p0}, Lb/a/a/f;->l()V

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    invoke-virtual {p0, v1}, Lb/a/a/c;->c(Landroid/view/View;)V

    invoke-virtual {p0}, Lb/a/a/f;->d()V

    invoke-virtual {p0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    new-instance v2, Landroid/graphics/Point;

    invoke-direct {v2}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v1, v2}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v1, v2, Landroid/graphics/Point;->x:I

    iget v2, v2, Landroid/graphics/Point;->y:I

    iget-object v3, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lb/a/a/i;->md_dialog_vertical_margin:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    iget-object v4, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v5, Lb/a/a/i;->md_dialog_horizontal_margin:I

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    iget-object v0, v0, Lb/a/a/f$d;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v5, Lb/a/a/i;->md_dialog_max_width:I

    invoke-virtual {v0, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    mul-int/lit8 v4, v4, 0x2

    sub-int/2addr v1, v4

    iget-object v4, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    mul-int/lit8 v3, v3, 0x2

    sub-int/2addr v2, v3

    invoke-virtual {v4, v2}, Lcom/afollestad/materialdialogs/internal/MDRootLayout;->setMaxHeight(I)V

    new-instance v2, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v2}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    invoke-virtual {p0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-virtual {p0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object p0

    invoke-virtual {p0, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    return-void
.end method

.method private static e(Lb/a/a/f;)V
    .locals 4

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    const v2, 0x1020009

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    iput-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    if-nez v1, :cond_0

    return-void

    :cond_0
    iget-object v2, v0, Lb/a/a/f$d;->S:Landroid/graphics/Typeface;

    invoke-virtual {p0, v1, v2}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    iget-object v1, v0, Lb/a/a/f$d;->m0:Ljava/lang/CharSequence;

    if-eqz v1, :cond_1

    iget-object v2, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-virtual {v2, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    invoke-virtual {p0}, Lb/a/a/f;->o()V

    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    iget-object v2, v0, Lb/a/a/f$d;->n0:Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->setSingleLine()V

    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    iget v2, v0, Lb/a/a/f$d;->j:I

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    iget v2, v0, Lb/a/a/f$d;->j:I

    const v3, 0x3e99999a    # 0.3f

    invoke-static {v2, v3}, Lb/a/a/q/a;->a(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setHintTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    iget-object v2, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget v2, v2, Lb/a/a/f$d;->t:I

    invoke-static {v1, v2}, Lcom/afollestad/materialdialogs/internal/c;->e(Landroid/widget/EditText;I)V

    iget v1, v0, Lb/a/a/f$d;->q0:I

    const/4 v2, -0x1

    if-eq v1, v2, :cond_2

    iget-object v3, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-virtual {v3, v1}, Landroid/widget/EditText;->setInputType(I)V

    iget v1, v0, Lb/a/a/f$d;->q0:I

    const/16 v3, 0x90

    if-eq v1, v3, :cond_2

    const/16 v3, 0x80

    and-int/2addr v1, v3

    if-ne v1, v3, :cond_2

    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-static {}, Landroid/text/method/PasswordTransformationMethod;->getInstance()Landroid/text/method/PasswordTransformationMethod;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/EditText;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    :cond_2
    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v3, Lb/a/a/k;->md_minMax:I

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lb/a/a/f;->o:Landroid/widget/TextView;

    iget v3, v0, Lb/a/a/f$d;->s0:I

    if-gtz v3, :cond_4

    iget v3, v0, Lb/a/a/f$d;->t0:I

    if-le v3, v2, :cond_3

    goto :goto_0

    :cond_3
    const/16 v0, 0x8

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    const/4 v0, 0x0

    iput-object v0, p0, Lb/a/a/f;->o:Landroid/widget/TextView;

    goto :goto_1

    :cond_4
    :goto_0
    iget-object v1, p0, Lb/a/a/f;->h:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    iget-boolean v0, v0, Lb/a/a/f$d;->p0:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p0, v1, v0}, Lb/a/a/f;->k(IZ)V

    :goto_1
    return-void
.end method

.method private static f(Lb/a/a/f;)V
    .locals 7

    iget-object v0, p0, Lb/a/a/f;->d:Lb/a/a/f$d;

    iget-boolean v1, v0, Lb/a/a/f$d;->i0:Z

    if-nez v1, :cond_0

    iget v1, v0, Lb/a/a/f$d;->k0:I

    const/4 v2, -0x2

    if-le v1, v2, :cond_a

    :cond_0
    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    const v2, 0x102000d

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ProgressBar;

    iput-object v1, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    if-nez v1, :cond_1

    return-void

    :cond_1
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xe

    if-lt v2, v3, :cond_4

    iget-boolean v1, v0, Lb/a/a/f$d;->i0:Z

    if-eqz v1, :cond_3

    iget-boolean v1, v0, Lb/a/a/f$d;->B0:Z

    if-eqz v1, :cond_2

    new-instance v1, Lme/zhanghai/android/materialprogressbar/IndeterminateHorizontalProgressDrawable;

    invoke-virtual {v0}, Lb/a/a/f$d;->e()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lme/zhanghai/android/materialprogressbar/IndeterminateHorizontalProgressDrawable;-><init>(Landroid/content/Context;)V

    iget v2, v0, Lb/a/a/f$d;->t:I

    invoke-virtual {v1, v2}, Lme/zhanghai/android/materialprogressbar/IndeterminateHorizontalProgressDrawable;->setTint(I)V

    goto :goto_0

    :cond_2
    new-instance v1, Lme/zhanghai/android/materialprogressbar/IndeterminateCircularProgressDrawable;

    invoke-virtual {v0}, Lb/a/a/f$d;->e()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lme/zhanghai/android/materialprogressbar/IndeterminateCircularProgressDrawable;-><init>(Landroid/content/Context;)V

    iget v2, v0, Lb/a/a/f$d;->t:I

    invoke-virtual {v1, v2}, Lme/zhanghai/android/materialprogressbar/IndeterminateCircularProgressDrawable;->setTint(I)V

    goto :goto_0

    :cond_3
    new-instance v1, Lme/zhanghai/android/materialprogressbar/HorizontalProgressDrawable;

    invoke-virtual {v0}, Lb/a/a/f$d;->e()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lme/zhanghai/android/materialprogressbar/HorizontalProgressDrawable;-><init>(Landroid/content/Context;)V

    iget v2, v0, Lb/a/a/f$d;->t:I

    invoke-virtual {v1, v2}, Lme/zhanghai/android/materialprogressbar/HorizontalProgressDrawable;->setTint(I)V

    :goto_0
    iget-object v2, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    invoke-virtual {v2, v1}, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v2, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    invoke-virtual {v2, v1}, Landroid/widget/ProgressBar;->setIndeterminateDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    :cond_4
    iget v2, v0, Lb/a/a/f$d;->t:I

    invoke-static {v1, v2}, Lcom/afollestad/materialdialogs/internal/c;->f(Landroid/widget/ProgressBar;I)V

    :goto_1
    iget-boolean v1, v0, Lb/a/a/f$d;->i0:Z

    if-eqz v1, :cond_5

    iget-boolean v2, v0, Lb/a/a/f$d;->B0:Z

    if-eqz v2, :cond_a

    :cond_5
    iget-object v2, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v1, :cond_6

    iget-boolean v1, v0, Lb/a/a/f$d;->B0:Z

    if-eqz v1, :cond_6

    move v1, v3

    goto :goto_2

    :cond_6
    move v1, v4

    :goto_2
    invoke-virtual {v2, v1}, Landroid/widget/ProgressBar;->setIndeterminate(Z)V

    iget-object v1, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    invoke-virtual {v1, v4}, Landroid/widget/ProgressBar;->setProgress(I)V

    iget-object v1, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    iget v2, v0, Lb/a/a/f$d;->l0:I

    invoke-virtual {v1, v2}, Landroid/widget/ProgressBar;->setMax(I)V

    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v2, Lb/a/a/k;->md_label:I

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lb/a/a/f;->m:Landroid/widget/TextView;

    if-eqz v1, :cond_7

    iget v2, v0, Lb/a/a/f$d;->j:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->m:Landroid/widget/TextView;

    iget-object v2, v0, Lb/a/a/f$d;->T:Landroid/graphics/Typeface;

    invoke-virtual {p0, v1, v2}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    iget-object v1, p0, Lb/a/a/f;->m:Landroid/widget/TextView;

    iget-object v2, v0, Lb/a/a/f$d;->A0:Ljava/text/NumberFormat;

    const-wide/16 v5, 0x0

    invoke-virtual {v2, v5, v6}, Ljava/text/NumberFormat;->format(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_7
    iget-object v1, p0, Lb/a/a/c;->b:Lcom/afollestad/materialdialogs/internal/MDRootLayout;

    sget v2, Lb/a/a/k;->md_minMax:I

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lb/a/a/f;->n:Landroid/widget/TextView;

    if-eqz v1, :cond_9

    iget v2, v0, Lb/a/a/f$d;->j:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lb/a/a/f;->n:Landroid/widget/TextView;

    iget-object v2, v0, Lb/a/a/f$d;->S:Landroid/graphics/Typeface;

    invoke-virtual {p0, v1, v2}, Lb/a/a/f;->p(Landroid/widget/TextView;Landroid/graphics/Typeface;)V

    iget-boolean v1, v0, Lb/a/a/f$d;->j0:Z

    if-eqz v1, :cond_8

    iget-object v1, p0, Lb/a/a/f;->n:Landroid/widget/TextView;

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lb/a/a/f;->n:Landroid/widget/TextView;

    iget-object v2, v0, Lb/a/a/f$d;->z0:Ljava/lang/String;

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v4

    iget v0, v0, Lb/a/a/f$d;->l0:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v5, v3

    invoke-static {v2, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    invoke-virtual {v0}, Landroid/widget/ProgressBar;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup$MarginLayoutParams;

    iput v4, v0, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    iput v4, v0, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    goto :goto_3

    :cond_8
    iget-object v0, p0, Lb/a/a/f;->n:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_3

    :cond_9
    iput-boolean v4, v0, Lb/a/a/f$d;->j0:Z

    :cond_a
    :goto_3
    iget-object p0, p0, Lb/a/a/f;->l:Landroid/widget/ProgressBar;

    if-eqz p0, :cond_b

    invoke-static {p0}, Lb/a/a/d;->a(Landroid/widget/ProgressBar;)V

    :cond_b
    return-void
.end method
