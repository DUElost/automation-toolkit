.class public Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;
.super Landroid/preference/DialogPreference;
.source ""

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# instance fields
.field private b:Landroid/widget/SeekBar;

.field private c:Landroid/widget/TextView;

.field private d:Landroid/widget/ImageView;

.field private e:Ljava/lang/String;

.field private f:I

.field private g:I

.field private h:I

.field private i:I

.field private j:Landroid/view/ViewGroup$LayoutParams;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Landroid/preference/DialogPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Landroid/preference/DialogPreference;->setPersistent(Z)V

    const p1, 0x7f0c0054

    invoke-virtual {p0, p1}, Landroid/preference/DialogPreference;->setDialogLayoutResource(I)V

    const-string p1, "http://schemas.android.com/apk/res/android"

    const-string v0, "text"

    invoke-interface {p2, p1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->e:Ljava/lang/String;

    const-string v0, "defaultValue"

    const/16 v1, 0x64

    invoke-interface {p2, p1, v0, v1}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->f:I

    const-string v0, "max"

    const/16 v1, 0xc8

    invoke-interface {p2, p1, v0, v1}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result p1

    iput p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->g:I

    return-void
.end method

.method private a(I)I
    .locals 2

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    int-to-float p1, p1

    iget v0, v0, Landroid/util/DisplayMetrics;->xdpi:F

    const/high16 v1, 0x43200000    # 160.0f

    div-float/2addr v0, v1

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private b(I)Landroid/view/ViewGroup$LayoutParams;
    .locals 1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->a(I)I

    move-result p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->j:Landroid/view/ViewGroup$LayoutParams;

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    return-object v0
.end method

.method private c()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b:Landroid/widget/SeekBar;

    invoke-virtual {v0, p0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->d:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->j:Landroid/view/ViewGroup$LayoutParams;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->d:Landroid/widget/ImageView;

    iget v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    invoke-direct {p0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b(I)Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->c:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->e:Ljava/lang/String;

    if-nez v1, :cond_0

    iget v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    iget v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->e:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Max: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->g:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "     ,Progress: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SCREENRECORDER"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method protected onBindDialogView(Landroid/view/View;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/preference/DialogPreference;->onBindDialogView(Landroid/view/View;)V

    iget v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->f:I

    invoke-virtual {p0, v0}, Landroid/preference/DialogPreference;->getPersistedInt(I)I

    move-result v0

    iput v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "size is: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SCREENRECORDER"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const v0, 0x7f090174

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/SeekBar;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b:Landroid/widget/SeekBar;

    const v0, 0x7f0901cc

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->c:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getTextColors()Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/ColorStateList;->getDefaultColor()I

    move-result v0

    iput v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->i:I

    const v0, 0x7f0900f0

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->d:Landroid/widget/ImageView;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b:Landroid/widget/SeekBar;

    iget v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->g:I

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setMax(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b:Landroid/widget/SeekBar;

    iget v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->c()V

    return-void
.end method

.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1

    const/16 p1, 0x46

    if-ge p2, p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->c:Landroid/widget/TextView;

    const/high16 p3, -0x10000

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->c:Landroid/widget/TextView;

    iget p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->i:I

    :goto_0
    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setTextColor(I)V

    const/16 p1, 0x19

    if-ge p2, p1, :cond_1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b:Landroid/widget/SeekBar;

    invoke-virtual {p2, p1}, Landroid/widget/SeekBar;->setProgress(I)V

    return-void

    :cond_1
    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->c:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->e:Ljava/lang/String;

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {p1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    :goto_1
    invoke-virtual {p3, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->d:Landroid/widget/ImageView;

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->b(I)Landroid/view/ViewGroup$LayoutParams;

    move-result-object p3

    invoke-virtual {p1, p3}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->shouldPersist()Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-virtual {p0, p2}, Landroid/preference/DialogPreference;->persistInt(I)Z

    :cond_3
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/preference/DialogPreference;->callChangeListener(Ljava/lang/Object;)Z

    return-void
.end method

.method protected onSetInitialValue(ZLjava/lang/Object;)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroid/preference/DialogPreference;->onSetInitialValue(ZLjava/lang/Object;)V

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Landroid/preference/DialogPreference;->shouldPersist()Z

    move-result p1

    if-eqz p1, :cond_0

    iget p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->f:I

    invoke-virtual {p0, p1}, Landroid/preference/DialogPreference;->getPersistedInt(I)I

    move-result p1

    goto :goto_0

    :cond_0
    const/16 p1, 0x64

    goto :goto_0

    :cond_1
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    :goto_0
    iput p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/SeekBarPreference;->h:I

    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method
