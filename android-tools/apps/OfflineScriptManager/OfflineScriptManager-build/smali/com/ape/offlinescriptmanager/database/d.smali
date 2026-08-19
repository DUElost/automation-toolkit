.class public final Lcom/ape/offlinescriptmanager/database/d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/provider/BaseColumns;


# static fields
.field public static final a:Landroid/net/Uri;

.field public static final b:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    const-string v0, "content://com.ape.offlinescriptmanager.database/test_point_result"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/database/d;->a:Landroid/net/Uri;

    const-string v1, "_id"

    const-string v2, "name"

    const-string v3, "status"

    const-string v4, "start_time"

    const-string v5, "stop_time"

    const-string v6, "stop_battery_percentage"

    const-string v7, "start_battery_percentage"

    const-string v8, "regression"

    filled-new-array/range {v1 .. v8}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/database/d;->b:[Ljava/lang/String;

    return-void
.end method
