.class public Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;
.super Landroidx/appcompat/app/c;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$e;,
        Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;
    }
.end annotation


# instance fields
.field private q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

.field private r:Landroid/media/projection/MediaProjection;

.field private s:Landroid/media/projection/MediaProjectionManager;

.field private t:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

.field private u:Lcom/google/android/material/tabs/TabLayout;

.field private v:Landroidx/viewpager/widget/ViewPager;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/appcompat/app/c;-><init>()V

    return-void
.end method

.method static synthetic L(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Landroid/media/projection/MediaProjection;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->r:Landroid/media/projection/MediaProjection;

    return-object p0
.end method

.method static synthetic M(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;Ljava/lang/Class;)Z
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->Q(Ljava/lang/Class;)Z

    move-result p0

    return p0
.end method

.method static synthetic N(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Landroid/media/projection/MediaProjectionManager;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->s:Landroid/media/projection/MediaProjectionManager;

    return-object p0
.end method

.method static synthetic O(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)Lcom/google/android/material/floatingactionbutton/FloatingActionButton;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->t:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    return-object p0
.end method

.method public static P()V
    .locals 3

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/a;->a:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v1

    const-string v2, "mounted"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :cond_0
    return-void
.end method

.method private Q(Ljava/lang/Class;)Z
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

.method private X()V
    .locals 6
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x1

    const-string v2, "System Windows Permission"

    const/16 v3, 0x3ea

    const/4 v4, 0x0

    const/16 v5, 0x17

    if-lt v0, v5, :cond_1

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    filled-new-array {v2}, [Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [I

    aput v4, v1, v4

    invoke-interface {v0, v3, v2, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/b;->a(I[Ljava/lang/String;[I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    filled-new-array {v2}, [Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [I

    const/4 v5, -0x1

    aput v5, v1, v4

    invoke-interface {v0, v3, v2, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/b;->a(I[Ljava/lang/String;[I)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    filled-new-array {v2}, [Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [I

    aput v4, v1, v4

    invoke-interface {v0, v3, v2, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/b;->a(I[Ljava/lang/String;[I)V

    :goto_0
    return-void
.end method

.method private Y(Landroidx/viewpager/widget/ViewPager;)V
    .locals 3

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;

    invoke-virtual {p0}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;Landroid/app/FragmentManager;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/c;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/c;-><init>()V

    const v2, 0x7f0f02dd

    invoke-virtual {p0, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->q(Landroid/app/Fragment;Ljava/lang/String;)V

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/d;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/d;-><init>()V

    const v2, 0x7f0f02de

    invoke-virtual {p0, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->q(Landroid/app/Fragment;Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Landroidx/viewpager/widget/ViewPager;->setAdapter(Landroidx/viewpager/widget/a;)V

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$c;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)V

    invoke-virtual {p1, v0}, Landroidx/viewpager/widget/ViewPager;->c(Landroidx/viewpager/widget/ViewPager$j;)V

    return-void
.end method


# virtual methods
.method public R()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->v:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {v0}, Landroidx/viewpager/widget/ViewPager;->getAdapter()Landroidx/viewpager/widget/a;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->p(I)Landroid/app/Fragment;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/d;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/d;->k()V

    const-string v0, "SCREENRECORDER"

    const-string v1, "reached main act"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public S()V
    .locals 2

    const-string v0, "android.permission.RECORD_AUDIO"

    invoke-static {p0, v0}, Landroidx/core/content/a;->a(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x3e9

    invoke-static {p0, v0, v1}, Landroidx/core/app/a;->j(Landroid/app/Activity;[Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method public T()Z
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

    new-instance v2, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$d;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$d;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)V

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

.method public U()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "package:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const-string v2, "android.settings.action.MANAGE_OVERLAY_PERMISSION"

    invoke-direct {v0, v2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const/16 v1, 0x3ea

    invoke-virtual {p0, v0, v1}, Landroidx/fragment/app/b;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_0
    return-void
.end method

.method public V(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$e;)V
    .locals 0

    return-void
.end method

.method public W(Lcom/ape/offlinescriptmanager/screenrecorder/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    const/16 v0, 0x3ea

    if-ne p1, v0, :cond_0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->X()V

    return-void

    :cond_0
    if-nez p2, :cond_1

    const/16 v0, 0x3eb

    if-ne p1, v0, :cond_1

    const p1, 0x7f0f028d

    invoke-virtual {p0, p1}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void

    :cond_1
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "com.ape.offlinescriptmanager.screenrecorder.services.action.startrecording"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v0, "recorder_intent_data"

    invoke-virtual {p1, v0, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const-string p3, "recorder_intent_result"

    invoke-virtual {p1, p3, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p3, 0x1a

    if-lt p2, p3, :cond_2

    invoke-virtual {p0, p1}, Landroid/app/Activity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :cond_2
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Landroidx/appcompat/app/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0c0024

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->setContentView(I)V

    const p1, 0x7f0901e2

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroidx/viewpager/widget/ViewPager;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->v:Landroidx/viewpager/widget/ViewPager;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->Y(Landroidx/viewpager/widget/ViewPager;)V

    const p1, 0x7f090190

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/google/android/material/tabs/TabLayout;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->u:Lcom/google/android/material/tabs/TabLayout;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->v:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {p1, v0}, Lcom/google/android/material/tabs/TabLayout;->setupWithViewPager(Landroidx/viewpager/widget/ViewPager;)V

    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->T()Z

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f004a

    invoke-virtual {p0, v0}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->s:Landroid/media/projection/MediaProjectionManager;

    invoke-virtual {p1}, Landroid/media/projection/MediaProjectionManager;->createScreenCaptureIntent()Landroid/content/Intent;

    move-result-object p1

    const/16 v0, 0x3eb

    invoke-virtual {p0, p1, v0}, Landroidx/fragment/app/b;->startActivityForResult(Landroid/content/Intent;I)V

    return-void

    :cond_0
    const p1, 0x7f0900d3

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->t:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    const-class p1, Lcom/ape/offlinescriptmanager/screenrecorder/RecorderService;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->Q(Ljava/lang/Class;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p1, "SCREENRECORDER"

    const-string v0, "service is running"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->t:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->t:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$b;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$b;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    invoke-virtual {p0}, Landroidx/appcompat/app/c;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const/high16 v1, 0x7f0d0000

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    const/4 p1, 0x1

    return p1
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 3

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x7f090006

    const/4 v2, 0x1

    if-eq v0, v1, :cond_1

    const v1, 0x7f090151

    if-eq v0, v1, :cond_0

    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1

    :cond_0
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/ape/offlinescriptmanager/screenrecorder/PrivacyPolicy;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :goto_0
    invoke-virtual {p0, p1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return v2

    :cond_1
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/ape/offlinescriptmanager/screenrecorder/AboutActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 3

    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/b;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/16 v0, 0x3e8

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    array-length v0, p3

    const-string v1, "SCREENRECORDER"

    if-lez v0, :cond_1

    const/4 v0, 0x0

    aget v2, p3, v0

    if-eqz v2, :cond_1

    const-string v2, "write storage Permission Denied"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->t:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    invoke-virtual {v1, v0}, Landroid/widget/ImageButton;->setEnabled(Z)V

    goto :goto_0

    :cond_1
    const-string v0, "write storage Permission granted"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->P()V

    :goto_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;->q:Lcom/ape/offlinescriptmanager/screenrecorder/b;

    if-eqz v0, :cond_2

    invoke-interface {v0, p1, p2, p3}, Lcom/ape/offlinescriptmanager/screenrecorder/b;->a(I[Ljava/lang/String;[I)V

    :cond_2
    return-void
.end method

.method protected onStart()V
    .locals 0

    invoke-super {p0}, Landroidx/appcompat/app/c;->onStart()V

    return-void
.end method

.method protected onStop()V
    .locals 0

    invoke-super {p0}, Landroidx/appcompat/app/c;->onStop()V

    return-void
.end method
