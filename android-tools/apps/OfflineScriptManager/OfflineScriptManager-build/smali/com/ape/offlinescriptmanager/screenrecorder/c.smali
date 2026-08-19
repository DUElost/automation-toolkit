.class public Lcom/ape/offlinescriptmanager/screenrecorder/c;
.super Landroid/preference/PreferenceFragment;
.source ""

# interfaces
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;
.implements Lcom/ape/offlinescriptmanager/screenrecorder/b;
.implements Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;
.implements Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$e;


# instance fields
.field b:Landroid/content/SharedPreferences;

.field private c:Landroid/preference/CheckBoxPreference;

.field private d:Landroid/preference/CheckBoxPreference;

.field private e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

.field private f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/preference/PreferenceFragment;-><init>()V

    return-void
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/screenrecorder/c;)Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    return-object p0
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/screenrecorder/c;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->n()V

    return-void
.end method

.method private e(F)F
    .locals 1

    const/high16 v0, 0x49800000    # 1048576.0f

    div-float/2addr p1, v0

    return p1
.end method

.method private g(Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    const-string v2, "window"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    const-string v1, "x"

    invoke-virtual {p1, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    iget v2, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    const/4 v3, 0x0

    aget-object v4, v1, v3

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    if-ge v2, v4, :cond_2

    const/4 v4, 0x1

    aget-object v1, v1, v4

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    if-ge v0, v1, :cond_2

    new-instance p1, Ljava/util/ArrayList;

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f030007

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object p1

    const v0, 0x7f0f023b

    new-array v2, v4, [Ljava/lang/Object;

    aput-object v1, v2, v3

    invoke-virtual {p0, v0, v2}, Landroid/preference/PreferenceFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-object v1

    :cond_1
    invoke-virtual {p1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    :cond_2
    return-object p1
.end method

.method private h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->b:Landroid/content/SharedPreferences;

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private j()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    if-eqz v0, :cond_0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-lt v1, v2, :cond_0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->U()V

    goto :goto_0

    :cond_0
    const-string v0, "SCREENRECORDER"

    const-string v1, "API is < 23"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method private k()V
    .locals 1

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    instance-of v0, v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-virtual {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->V(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$e;)V

    :cond_0
    return-void
.end method

.method private l()V
    .locals 1

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    instance-of v0, v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-virtual {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->W(Lcom/ape/offlinescriptmanager/screenrecorder/b;)V

    :cond_0
    return-void
.end method

.method private m()V
    .locals 3

    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f0043

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const v1, 0x7f0f0042

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/c$c;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/c;)V

    const v2, 0x1040013

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/c$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c$b;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/c;)V

    const v2, 0x1040009

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const v1, 0x1010355

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setIconAttribute(I)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return-void
.end method

.method private n()V
    .locals 3

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    const v1, 0x7f0900d3

    invoke-virtual {v0, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0f02a0

    const/4 v2, -0x2

    invoke-static {v0, v1, v2}, Lcom/google/android/material/snackbar/Snackbar;->w(Landroid/view/View;II)Lcom/google/android/material/snackbar/Snackbar;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/c$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/c;)V

    const v2, 0x7f0f029f

    invoke-virtual {v0, v2, v1}, Lcom/google/android/material/snackbar/Snackbar;->y(ILandroid/view/View$OnClickListener;)Lcom/google/android/material/snackbar/Snackbar;

    invoke-virtual {v0}, Lcom/google/android/material/snackbar/Snackbar;->s()V

    return-void
.end method

.method private o(Landroid/preference/ListPreference;)V
    .locals 2

    const v0, 0x7f0f0280

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "1440x2560"

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->g(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/ListPreference;->setValue(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    return-void
.end method


# virtual methods
.method public a(I[Ljava/lang/String;[I)V
    .locals 3

    const/4 p2, 0x1

    const-string v0, "SCREENRECORDER"

    const/4 v1, 0x0

    packed-switch p1, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    array-length v2, p3

    if-lez v2, :cond_0

    aget p3, p3, v1

    if-nez p3, :cond_0

    const-string p3, "System Windows permission granted"

    invoke-static {v0, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->d:Landroid/preference/CheckBoxPreference;

    invoke-virtual {p3, p2}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    goto :goto_2

    :cond_0
    const-string p2, "System Windows permission denied"

    invoke-static {v0, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->d:Landroid/preference/CheckBoxPreference;

    invoke-virtual {p2, v1}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    goto :goto_2

    :pswitch_1
    array-length p1, p3

    if-lez p1, :cond_1

    aget p1, p3, v1

    if-nez p1, :cond_1

    const-string p1, "Record audio permission granted."

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->c:Landroid/preference/CheckBoxPreference;

    invoke-virtual {p1, p2}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    goto :goto_0

    :cond_1
    const-string p1, "Record audio permission denied"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->c:Landroid/preference/CheckBoxPreference;

    invoke-virtual {p1, v1}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    :goto_0
    return-void

    :pswitch_2
    array-length p1, p3

    if-lez p1, :cond_2

    aget p1, p3, v1

    const/4 v2, -0x1

    if-ne p1, v2, :cond_2

    const-string p1, "Storage permission denied. Requesting again"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-virtual {p1, v1}, Landroid/preference/DialogPreference;->setEnabled(Z)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->m()V

    goto :goto_1

    :cond_2
    array-length p1, p3

    if-lez p1, :cond_3

    aget p1, p3, v1

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-virtual {p1, p2}, Landroid/preference/DialogPreference;->setEnabled(Z)V

    :cond_3
    :goto_1
    return-void

    :goto_2
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "Unknown permission request with request code: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :pswitch_data_0
    .packed-switch 0x3e8
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public b()V
    .locals 2

    const-string v0, "SCREENRECORDER"

    const-string v1, "In screen_recorder_settings fragment"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    instance-of v0, v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->R()V

    :cond_0
    return-void
.end method

.method public f()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->b:Landroid/content/SharedPreferences;

    const v1, 0x7f0f007d

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "yyyyMMdd_hhmmss"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->b:Landroid/content/SharedPreferences;

    const v2, 0x7f0f007e

    invoke-virtual {p0, v2}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "recording"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public i()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f:Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->S()V

    :cond_0
    return-void
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/preference/PreferenceFragment;->onActivityResult(IILandroid/content/Intent;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 11

    invoke-super {p0, p1}, Landroid/preference/PreferenceFragment;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f120002

    invoke-virtual {p0, p1}, Landroid/preference/PreferenceFragment;->addPreferencesFromResource(I)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->l()V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->k()V

    new-instance p1, Ljava/io/File;

    sget-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/a;->a:Ljava/lang/String;

    invoke-direct {p1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v0

    invoke-virtual {v0}, Landroid/preference/PreferenceScreen;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->b:Landroid/content/SharedPreferences;

    const v0, 0x7f0f0280

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    check-cast v0, Landroid/preference/ListPreference;

    const v1, 0x7f0f007f

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v2

    check-cast v2, Landroid/preference/ListPreference;

    const v3, 0x7f0f0054

    invoke-virtual {p0, v3}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v4

    check-cast v4, Landroid/preference/ListPreference;

    const v5, 0x7f0f004f

    invoke-virtual {p0, v5}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v5

    check-cast v5, Landroid/preference/CheckBoxPreference;

    iput-object v5, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->c:Landroid/preference/CheckBoxPreference;

    const v5, 0x7f0f007d

    invoke-virtual {p0, v5}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v5

    check-cast v5, Landroid/preference/ListPreference;

    const v6, 0x7f0f007e

    invoke-virtual {p0, v6}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v7

    check-cast v7, Landroid/preference/EditTextPreference;

    const v8, 0x7f0f0287

    invoke-virtual {p0, v8}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v9

    check-cast v9, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    iput-object v9, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    const v9, 0x7f0f026d

    invoke-virtual {p0, v9}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v9

    check-cast v9, Landroid/preference/CheckBoxPreference;

    iput-object v9, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->d:Landroid/preference/CheckBoxPreference;

    iget-object v9, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-virtual {p0, v8}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-direct {p0, v10, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->o(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->o(Landroid/preference/ListPreference;)V

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "30"

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, v3}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "7130317"

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    int-to-float v0, v0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e(F)F

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, " Mbps"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-virtual {p0, v8}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/preference/DialogPreference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v5, p1}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, v6}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object p1

    const-string v0, "recording"

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v7, p1}, Landroid/preference/EditTextPreference;->setSummary(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->c:Landroid/preference/CheckBoxPreference;

    invoke-virtual {p1}, Landroid/preference/CheckBoxPreference;->isChecked()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->i()V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->d:Landroid/preference/CheckBoxPreference;

    invoke-virtual {p1}, Landroid/preference/CheckBoxPreference;->isChecked()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->j()V

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-virtual {p1, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->p(Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;)V

    return-void
.end method

.method public onPause()V
    .locals 1

    invoke-super {p0}, Landroid/preference/PreferenceFragment;->onPause()V

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v0

    invoke-virtual {v0}, Landroid/preference/PreferenceScreen;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    return-void
.end method

.method public onResume()V
    .locals 1

    invoke-super {p0}, Landroid/preference/PreferenceFragment;->onResume()V

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v0

    invoke-virtual {v0}, Landroid/preference/PreferenceScreen;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    return-void
.end method

.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 1

    invoke-virtual {p0, p2}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/preference/Preference;->getTitleRes()I

    move-result p2

    sparse-switch p2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    check-cast p1, Landroid/preference/ListPreference;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->o(Landroid/preference/ListPreference;)V

    goto :goto_1

    :sswitch_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->j()V

    goto :goto_1

    :sswitch_2
    check-cast p1, Landroid/preference/EditTextPreference;

    invoke-virtual {p1}, Landroid/preference/EditTextPreference;->getText()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/preference/EditTextPreference;->setSummary(Ljava/lang/CharSequence;)V

    const p1, 0x7f0f007d

    invoke-virtual {p0, p1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    check-cast p1, Landroid/preference/ListPreference;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_1

    :sswitch_3
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->f()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :sswitch_4
    const p2, 0x7f0f0054

    invoke-virtual {p0, p2}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object p2

    const-string v0, "7130317"

    invoke-direct {p0, p2, v0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->h(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p2

    int-to-float p2, p2

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->e(F)F

    move-result p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string p2, " Mbps"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-virtual {p1, p2}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_1

    :sswitch_5
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/c;->i()V

    :goto_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0f0268 -> :sswitch_5
        0x7f0f026a -> :sswitch_4
        0x7f0f026b -> :sswitch_3
        0x7f0f026c -> :sswitch_2
        0x7f0f0272 -> :sswitch_1
        0x7f0f0277 -> :sswitch_0
    .end sparse-switch
.end method
