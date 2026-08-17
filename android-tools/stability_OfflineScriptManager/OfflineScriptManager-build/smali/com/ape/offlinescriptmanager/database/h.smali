.class public final Lcom/ape/offlinescriptmanager/database/h;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/provider/BaseColumns;


# static fields
.field public static final a:Landroid/net/Uri;

.field public static final b:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    const-string v0, "content://com.ape.offlinescriptmanager.database/voltages"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/database/h;->a:Landroid/net/Uri;

    const-string v0, "_id"

    const-string v1, "time"

    const-string v2, "voltage"

    const-string v3, "temperature"

    filled-new-array {v0, v1, v2, v3}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/ape/offlinescriptmanager/database/h;->b:[Ljava/lang/String;

    return-void
.end method
