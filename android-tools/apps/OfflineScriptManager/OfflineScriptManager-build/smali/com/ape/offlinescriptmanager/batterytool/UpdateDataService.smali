.class public Lcom/ape/offlinescriptmanager/batterytool/UpdateDataService;
.super Landroid/app/Service;
.source ""


# instance fields
.field private b:Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 0

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    return-void
.end method

.method public onDestroy()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/UpdateDataService;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;

    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Landroid/app/Service;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    new-instance p1, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;

    invoke-direct {p1}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/UpdateDataService;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;

    new-instance p1, Landroid/content/IntentFilter;

    invoke-direct {p1}, Landroid/content/IntentFilter;-><init>()V

    const-string p2, "android.intent.action.BATTERY_CHANGED"

    invoke-virtual {p1, p2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/UpdateDataService;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;

    invoke-virtual {p0, p2, p1}, Landroid/app/Service;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    const/4 p1, 0x1

    return p1
.end method
