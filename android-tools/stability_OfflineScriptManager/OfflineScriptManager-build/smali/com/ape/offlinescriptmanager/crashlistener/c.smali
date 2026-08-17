.class public Lcom/ape/offlinescriptmanager/crashlistener/c;
.super Landroid/preference/PreferenceFragment;
.source ""

# interfaces
.implements Lcom/ape/offlinescriptmanager/screenrecorder/b;
.implements Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/b;
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;


# instance fields
.field b:Landroid/content/SharedPreferences;

.field private c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

.field d:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/preference/PreferenceFragment;-><init>()V

    return-void
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/crashlistener/c;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/c;->g()V

    return-void
.end method

.method private e()V
    .locals 1

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    instance-of v0, v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->d:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {v0, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->S(Lcom/ape/offlinescriptmanager/screenrecorder/b;)V

    :cond_0
    return-void
.end method

.method private f()V
    .locals 3

    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->d:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f0043

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const v1, 0x7f0f0042

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/c$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/c$b;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/c;)V

    const v2, 0x1040013

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/c$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/c$a;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/c;)V

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

.method private g()V
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

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/c$c;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/crashlistener/c$c;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/c;)V

    const v2, 0x7f0f029f

    invoke-virtual {v0, v2, v1}, Lcom/google/android/material/snackbar/Snackbar;->y(ILandroid/view/View$OnClickListener;)Lcom/google/android/material/snackbar/Snackbar;

    invoke-virtual {v0}, Lcom/google/android/material/snackbar/Snackbar;->s()V

    return-void
.end method


# virtual methods
.method public a(I[Ljava/lang/String;[I)V
    .locals 1

    const/16 p2, 0x2af8

    if-eq p1, p2, :cond_0

    return-void

    :cond_0
    array-length p1, p3

    const/4 p2, 0x0

    if-lez p1, :cond_1

    aget p1, p3, p2

    const/4 v0, -0x1

    if-ne p1, v0, :cond_1

    const-string p1, "SCREENRECORDER"

    const-string p3, "Storage permission denied. Requesting again"

    invoke-static {p1, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    invoke-virtual {p1, p2}, Landroid/preference/DialogPreference;->setEnabled(Z)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/c;->f()V

    goto :goto_0

    :cond_1
    array-length p1, p3

    if-lez p1, :cond_2

    aget p1, p3, p2

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Landroid/preference/DialogPreference;->setEnabled(Z)V

    :cond_2
    :goto_0
    return-void
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

    instance-of v0, v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->P()V

    :cond_0
    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    const v1, 0x7f0f005f

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "yyyyMMdd_hhmmss"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    const v2, 0x7f0f0060

    invoke-virtual {p0, v2}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f0f0065

    invoke-virtual {p0, v3}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v3

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

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/preference/PreferenceFragment;->onActivityResult(IILandroid/content/Intent;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 7

    invoke-super {p0, p1}, Landroid/preference/PreferenceFragment;->onCreate(Landroid/os/Bundle;)V

    const/high16 p1, 0x7f120000

    invoke-virtual {p0, p1}, Landroid/preference/PreferenceFragment;->addPreferencesFromResource(I)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/crashlistener/c;->e()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->t()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Landroid/preference/PreferenceFragment;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v0

    invoke-virtual {v0}, Landroid/preference/PreferenceScreen;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    const v0, 0x7f0f0063

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    check-cast v1, Landroid/preference/EditTextPreference;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v3, "200"

    invoke-interface {v2, v0, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/EditTextPreference;->setSummary(Ljava/lang/CharSequence;)V

    const v0, 0x7f0f005f

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    check-cast v0, Landroid/preference/ListPreference;

    const v1, 0x7f0f0060

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v2

    check-cast v2, Landroid/preference/EditTextPreference;

    const v3, 0x7f0f0066

    invoke-virtual {p0, v3}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v4

    check-cast v4, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    iput-object v4, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    invoke-virtual {p0, v3}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-interface {v5, v6, p1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;->o(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    invoke-virtual {p0, v3}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v5, v3, p1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Landroid/preference/DialogPreference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/c;->d()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->b:Landroid/content/SharedPreferences;

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0065

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Landroid/preference/EditTextPreference;->setSummary(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/FolderChooser;

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
    .locals 4

    invoke-virtual {p0, p2}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/preference/Preference;->getTitleRes()I

    move-result p2

    sparse-switch p2, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    check-cast p1, Landroid/preference/EditTextPreference;

    invoke-virtual {p1}, Landroid/preference/EditTextPreference;->getText()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p2, v0, v2

    if-gtz p2, :cond_1

    invoke-virtual {p1}, Landroid/preference/EditTextPreference;->getContext()Landroid/content/Context;

    move-result-object p1

    const/4 p2, 0x0

    const-string v0, "input interval must more then 0"

    invoke-static {p1, v0, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/preference/EditTextPreference;->getText()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/preference/EditTextPreference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    :sswitch_1
    check-cast p1, Landroid/preference/EditTextPreference;

    invoke-virtual {p1}, Landroid/preference/EditTextPreference;->getText()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/preference/EditTextPreference;->setSummary(Ljava/lang/CharSequence;)V

    const p1, 0x7f0f005f

    invoke-virtual {p0, p1}, Landroid/preference/PreferenceFragment;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/preference/PreferenceFragment;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    check-cast p1, Landroid/preference/ListPreference;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/c;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    :sswitch_2
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/c;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    :goto_0
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f0f026b -> :sswitch_2
        0x7f0f026c -> :sswitch_1
        0x7f0f0275 -> :sswitch_0
    .end sparse-switch
.end method
