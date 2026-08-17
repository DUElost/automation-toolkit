.class public Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;
.super Landroidx/appcompat/app/c;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;
    }
.end annotation


# static fields
.field public static final u:Ljava/lang/String;


# instance fields
.field private q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

.field private r:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

.field private s:Lcom/google/android/material/tabs/TabLayout;

.field private t:Landroidx/viewpager/widget/ViewPager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->u:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/appcompat/app/c;-><init>()V

    return-void
.end method

.method static synthetic L(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;Ljava/lang/Class;)Z
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->O(Ljava/lang/Class;)Z

    move-result p0

    return p0
.end method

.method static synthetic M(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;)Lcom/google/android/material/floatingactionbutton/FloatingActionButton;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->r:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    return-object p0
.end method

.method public static N(Landroid/content/Context;Landroid/content/SharedPreferences;)V
    .locals 2

    new-instance v0, Ljava/io/File;

    const v1, 0x7f0f0066

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->t()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, p0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object p0

    const-string p1, "mounted"

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result p0

    if-nez p0, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :cond_0
    return-void
.end method

.method private O(Ljava/lang/Class;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)Z"
        }
    .end annotation

    const-string v0, "activity"

    invoke-virtual {p0, v0}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    const v1, 0x7fffffff

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager$RunningServiceInfo;

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    iget-object v1, v1, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v1}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method private T(Landroidx/viewpager/widget/ViewPager;)V
    .locals 3

    new-instance v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;

    invoke-virtual {p0}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;Landroid/app/FragmentManager;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/c;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/crashlistener/c;-><init>()V

    const v2, 0x7f0f02dd

    invoke-virtual {p0, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;->q(Landroid/app/Fragment;Ljava/lang/String;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/crashlistener/a;-><init>()V

    const v2, 0x7f0f02dc

    invoke-virtual {p0, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;->q(Landroid/app/Fragment;Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Landroidx/viewpager/widget/ViewPager;->setAdapter(Landroidx/viewpager/widget/a;)V

    new-instance v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$c;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;)V

    invoke-virtual {p1, v0}, Landroidx/viewpager/widget/ViewPager;->c(Landroidx/viewpager/widget/ViewPager$j;)V

    return-void
.end method


# virtual methods
.method public P()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->t:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {v0}, Landroidx/viewpager/widget/ViewPager;->getAdapter()Landroidx/viewpager/widget/a;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$e;->p(I)Landroid/app/Fragment;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/crashlistener/a;->k()V

    const-string v0, "SCREENRECORDER"

    const-string v1, "reached main act"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public Q()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-ge v0, v1, :cond_0

    return-void

    :cond_0
    const-string v0, "android.permission.RECORD_AUDIO"

    invoke-static {p0, v0}, Landroidx/core/content/a;->a(Landroid/content/Context;Ljava/lang/String;)I

    const-string v0, "media_projection"

    invoke-virtual {p0, v0}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/projection/MediaProjectionManager;

    invoke-virtual {v0}, Landroid/media/projection/MediaProjectionManager;->createScreenCaptureIntent()Landroid/content/Intent;

    move-result-object v0

    const/16 v1, 0x2b5c

    invoke-virtual {p0, v0, v1}, Landroidx/fragment/app/b;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method public R()Z
    .locals 3

    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {p0, v0}, Landroidx/core/content/a;->a(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f02a4

    invoke-virtual {p0, v1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const v1, 0x7f0f02a3

    invoke-virtual {p0, v1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const v1, 0x7f0f025c

    invoke-virtual {p0, v1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$d;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$d;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return v1

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public S(Lcom/ape/offlinescriptmanager/screenrecorder/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p2, p3}, Landroid/app/Activity;->onActivityReenter(ILandroid/content/Intent;)V

    if-nez p2, :cond_0

    const/16 p2, 0x2b5c

    if-ne p1, p2, :cond_0

    const p1, 0x7f0f028d

    invoke-virtual {p0, p1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_0
    invoke-static {p3}, Lcom/ape/offlinescriptmanager/crashlistener/b;->j(Landroid/content/Intent;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onCreate(Landroid/os/Bundle;)V

    sget-object p1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->u:Ljava/lang/String;

    const-string v0, "onCreate"

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/utils/j;->b(Ljava/lang/String;Ljava/lang/String;)V

    const p1, 0x7f0c0024

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->setContentView(I)V

    const p1, 0x7f0901e2

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroidx/viewpager/widget/ViewPager;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->t:Landroidx/viewpager/widget/ViewPager;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->T(Landroidx/viewpager/widget/ViewPager;)V

    const p1, 0x7f090190

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/google/android/material/tabs/TabLayout;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->s:Lcom/google/android/material/tabs/TabLayout;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->t:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {p1, v0}, Lcom/google/android/material/tabs/TabLayout;->setupWithViewPager(Landroidx/viewpager/widget/ViewPager;)V

    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->R()Z

    const p1, 0x7f0900d3

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->r:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    const-class p1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->O(Ljava/lang/Class;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "SCREENRECORDER"

    const-string v0, "service is running"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->r:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    new-instance v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->r:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    new-instance v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$b;-><init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 3

    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/b;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/16 v0, 0x2af8

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    array-length v0, p3

    if-lez v0, :cond_1

    const/4 v0, 0x0

    aget v1, p3, v0

    if-eqz v1, :cond_1

    sget-object v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->u:Ljava/lang/String;

    const-string v2, "write storage Permission Denied"

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/j;->a(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->r:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    invoke-virtual {v1, v0}, Landroid/widget/ImageButton;->setEnabled(Z)V

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->u:Ljava/lang/String;

    const-string v1, "write storage Permission granted"

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/j;->a(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    if-eqz v0, :cond_2

    invoke-interface {v0, p1, p2, p3}, Lcom/ape/offlinescriptmanager/screenrecorder/b;->a(I[Ljava/lang/String;[I)V

    :cond_2
    return-void
.end method
