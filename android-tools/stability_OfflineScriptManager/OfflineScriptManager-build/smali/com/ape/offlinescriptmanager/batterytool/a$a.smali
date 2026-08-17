.class Lcom/ape/offlinescriptmanager/batterytool/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/batterytool/a;->t1()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/batterytool/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2

    const-string p1, "isUpdating"

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/batterytool/a;->m1(Lcom/ape/offlinescriptmanager/batterytool/a;)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    const/4 v1, 0x1

    invoke-interface {p2, p1, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    new-instance p1, Landroid/content/Intent;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p2

    const-class v1, Lcom/ape/offlinescriptmanager/batterytool/UpdateDataService;

    invoke-direct {p1, p2, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/app/Activity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    const p2, 0x7f0f02db

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/batterytool/a;->m1(Lcom/ape/offlinescriptmanager/batterytool/a;)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    invoke-interface {p2, p1, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    new-instance p1, Landroid/content/Intent;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p2

    const-class v1, Lcom/ape/offlinescriptmanager/batterytool/UpdateDataService;

    invoke-direct {p1, p2, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/app/Activity;->stopService(Landroid/content/Intent;)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$a;->a:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    const p2, 0x7f0f02da

    :goto_0
    invoke-static {p1, p2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method
