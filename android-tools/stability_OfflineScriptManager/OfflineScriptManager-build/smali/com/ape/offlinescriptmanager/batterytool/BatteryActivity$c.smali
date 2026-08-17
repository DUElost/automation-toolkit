.class Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;->onBackPressed()V
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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$c;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity$c;->b:Lcom/ape/offlinescriptmanager/batterytool/BatteryActivity;

    invoke-virtual {p1}, Landroid/app/Activity;->finish()V

    return-void
.end method
