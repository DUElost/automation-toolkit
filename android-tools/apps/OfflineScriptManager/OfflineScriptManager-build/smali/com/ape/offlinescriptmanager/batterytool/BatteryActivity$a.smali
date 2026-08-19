.class Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$a;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$a;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->C(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)Lcom/ape/offlinescriptmanager/utils/a;

    move-result-object p1

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/utils/a;->a()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$a;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->D(Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;)Landroid/content/Context;

    move-result-object p1

    const p2, 0x7f0f005d

    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method
