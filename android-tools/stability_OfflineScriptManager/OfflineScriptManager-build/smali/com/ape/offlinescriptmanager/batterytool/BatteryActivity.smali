.class public Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;
.super Lcom/ape/offlinescriptmanager/batterytool/e/a;
.source ""


# instance fields
.field private s:Landroid/content/SharedPreferences;

.field private t:Lcom/ape/offlinescriptmanager/utils/a;

.field private u:Landroid/content/Context;

.field private v:[I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/batterytool/e/a;-><init>()V

    const/4 v0, 0x4

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->v:[I

    return-void

    :array_0
    .array-data 4
        0x7f0f0080
        0x7f0f0265
        0x7f0f02f2
        0x7f0f02e3
    .end array-data
.end method

.method static synthetic C(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)Lcom/ape/offlinescriptmanager/utils/a;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->t:Lcom/ape/offlinescriptmanager/utils/a;

    return-object p0
.end method

.method static synthetic D(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->u:Landroid/content/Context;

    return-object p0
.end method


# virtual methods
.method public B()V
    .locals 6

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->v:[I

    array-length v3, v2

    const/4 v4, 0x0

    if-ge v1, v3, :cond_0

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    aget v2, v2, v1

    invoke-virtual {p0, v2}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/TabHost;->newTabSpec(Ljava/lang/String;)Landroid/widget/TabHost$TabSpec;

    move-result-object v2

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->v:[I

    aget v5, v5, v1

    invoke-virtual {p0, v5}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/widget/TabHost$TabSpec;->setIndicator(Ljava/lang/CharSequence;)Landroid/widget/TabHost$TabSpec;

    move-result-object v2

    const-class v5, Landroidx/fragment/app/Fragment;

    invoke-virtual {v3, v2, v5, v4}, Landroidx/fragment/app/FragmentTabHost;->a(Landroid/widget/TabHost$TabSpec;Ljava/lang/Class;Landroid/os/Bundle;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    :goto_1
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->v:[I

    array-length v2, v1

    if-ge v0, v2, :cond_1

    aget v1, v1, v0

    sparse-switch v1, :sswitch_data_0

    move-object v1, v4

    goto :goto_2

    :sswitch_0
    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/c;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/batterytool/c;-><init>()V

    goto :goto_2

    :sswitch_1
    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/b;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/batterytool/b;-><init>()V

    goto :goto_2

    :sswitch_2
    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-direct {v1}, Lcom/ape/offlinescriptmanager/batterytool/a;-><init>()V

    goto :goto_2

    :sswitch_3
    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/a;->o1()Lcom/ape/offlinescriptmanager/view/c/a;

    move-result-object v1

    new-instance v2, Landroid/os/Bundle;

    invoke-direct {v2}, Landroid/os/Bundle;-><init>()V

    const-string v3, "TASK"

    const-string v5, "/sdcard/runtask.xml"

    invoke-virtual {v2, v3, v5}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroidx/fragment/app/Fragment;->Z0(Landroid/os/Bundle;)V

    :goto_2
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->q:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->p:Landroidx/viewpager/widget/ViewPager;

    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/e/b;

    invoke-virtual {p0}, Landroidx/fragment/app/b;->s()Landroidx/fragment/app/f;

    move-result-object v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->q:Ljava/util/List;

    invoke-direct {v1, v2, v3}, Lcom/ape/offlinescriptmanager/batterytool/e/b;-><init>(Landroidx/fragment/app/f;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Landroidx/viewpager/widget/ViewPager;->setAdapter(Landroidx/viewpager/widget/a;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->v:[I

    array-length v0, v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/e/a;->o:Landroidx/fragment/app/FragmentTabHost;

    invoke-virtual {v0}, Landroid/widget/TabHost;->getTabWidget()Landroid/widget/TabWidget;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TabWidget;->setVisibility(I)V

    :cond_2
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0f0080 -> :sswitch_3
        0x7f0f0265 -> :sswitch_2
        0x7f0f02e3 -> :sswitch_1
        0x7f0f02f2 -> :sswitch_0
    .end sparse-switch
.end method

.method public onBackPressed()V
    .locals 3

    const-string v0, "xuhang_data"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "isRunning"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f02c0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x7f0f02bf

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    const v1, 0x104000a

    new-instance v2, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$c;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$c;-><init>(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    const/high16 v1, 0x1040000

    new-instance v2, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$d;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$d;-><init>(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    goto :goto_0

    :cond_0
    invoke-super {p0}, Landroidx/fragment/app/b;->onBackPressed()V

    :goto_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/ape/offlinescriptmanager/batterytool/e/a;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->u:Landroid/content/Context;

    new-instance p1, Lcom/ape/offlinescriptmanager/utils/a;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->u:Landroid/content/Context;

    invoke-direct {p1, v0}, Lcom/ape/offlinescriptmanager/utils/a;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->t:Lcom/ape/offlinescriptmanager/utils/a;

    const-string p1, "update_data"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->s:Landroid/content/SharedPreferences;

    const-string v1, "isUpdating"

    invoke-interface {p1, v1, v0}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->u:Landroid/content/Context;

    const v1, 0x7f0f029e

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :cond_0
    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    invoke-virtual {p0}, Landroid/app/Activity;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const v1, 0x7f0d0001

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreateOptionsMenu(Landroid/view/Menu;)Z

    move-result p1

    return p1
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 9

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x7f090006

    if-eq v0, v1, :cond_4

    const v1, 0x7f090159

    if-eq v0, v1, :cond_3

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_2

    :pswitch_0
    new-instance v0, Landroid/content/CursorLoader;

    sget-object v4, Lcom/ape/offlinescriptmanager/database/b;->a:Landroid/net/Uri;

    sget-object v5, Lcom/ape/offlinescriptmanager/database/b;->b:[Ljava/lang/String;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const-string v8, "_id ASC"

    move-object v2, v0

    move-object v3, p0

    invoke-direct/range {v2 .. v8}, Landroid/content/CursorLoader;-><init>(Landroid/content/Context;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/content/CursorLoader;->loadInBackground()Landroid/database/Cursor;

    move-result-object v2

    if-eqz v2, :cond_0

    :try_start_0
    invoke-interface {v2}, Landroid/database/Cursor;->getCount()I

    move-result v3

    if-lez v3, :cond_0

    new-instance v1, Landroid/content/Intent;

    const-class v3, Lcom/ape/offlinescriptmanager/batterytool/HopDataShowActivity;

    invoke-direct {v1, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    :cond_0
    const v3, 0x7f0f0083

    invoke-static {p0, v3, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    invoke-virtual {v0}, Landroid/content/CursorLoader;->cancelLoad()Z

    if-eqz v2, :cond_5

    invoke-interface {v2}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_5

    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    goto :goto_2

    :catchall_0
    move-exception p1

    invoke-virtual {v0}, Landroid/content/CursorLoader;->cancelLoad()Z

    if-eqz v2, :cond_1

    invoke-interface {v2}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    :cond_1
    throw p1

    :pswitch_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->t:Lcom/ape/offlinescriptmanager/utils/a;

    const-wide/16 v2, 0x2

    invoke-virtual {v0, v2, v3}, Lcom/ape/offlinescriptmanager/utils/a;->e(J)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->t:Lcom/ape/offlinescriptmanager/utils/a;

    const-string v2, "com.ape.offlinescriptmanager.pref"

    const-string v3, "export_data_no_empty"

    invoke-virtual {v0, v2, v3, v1}, Lcom/ape/offlinescriptmanager/utils/a;->h(Ljava/lang/String;Ljava/lang/String;Z)V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->x()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/ape/offlinescriptmanager/batterytool/g/b;

    const/4 v3, 0x1

    invoke-direct {v2, p0, v0, v3, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/b;-><init>(Landroid/content/Context;Ljava/lang/String;ZZ)V

    new-array v0, v1, [Ljava/lang/Void;

    invoke-virtual {v2, v0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->t:Lcom/ape/offlinescriptmanager/utils/a;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->u:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/utils/a;->j(Landroid/content/Context;)V

    goto :goto_2

    :pswitch_2
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_1

    :pswitch_3
    const v0, 0x7f0f0040

    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)V

    new-instance v2, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$b;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$b;-><init>(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)V

    invoke-static {p0, v0, v1, v2}, Lcom/ape/offlinescriptmanager/utils/g;->I(Landroid/content/Context;ILandroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnClickListener;)V

    goto :goto_2

    :cond_3
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/view/UploadActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_1

    :cond_4
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ape/offlinescriptmanager/view/AboutActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :goto_1
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    :cond_5
    :goto_2
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1

    :pswitch_data_0
    .packed-switch 0x7f090030
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onResume()V
    .locals 2

    invoke-super {p0}, Landroidx/fragment/app/b;->onResume()V

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/k;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/utils/k;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/k;->b()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/MyApplication;->a()Lcom/ape/offlinescriptmanager/utils/MyApplication;

    move-result-object v0

    const-string v1, "\u957f\u6309\u53ef\u4fee\u6539Task\u53c2\u6570"

    invoke-virtual {v0, v1}, Lcom/ape/offlinescriptmanager/utils/MyApplication;->b(Ljava/lang/String;)V

    return-void
.end method
