.class public Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;
.source ""


# instance fields
.field private a:Landroid/content/SharedPreferences;

.field private b:Landroid/content/SharedPreferences$Editor;

.field private c:I

.field private d:I

.field private e:Ljava/lang/String;

.field private f:F

.field private g:J

.field private h:I

.field private i:D

.field private j:Landroid/content/Context;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private a(J)Ljava/lang/String;
    .locals 6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-wide/16 v1, 0x3c

    rem-long v3, p1, v1

    long-to-int v3, v3

    div-long v4, p1, v1

    rem-long/2addr v4, v1

    long-to-int v1, v4

    const-wide/16 v4, 0xe10

    div-long/2addr p1, v4

    long-to-int p1, p1

    if-eqz p1, :cond_0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "h"

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    if-nez p1, :cond_1

    if-eqz v1, :cond_2

    :cond_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, "m"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, "s"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private b(JJ)Ljava/lang/String;
    .locals 1

    sub-long/2addr p3, p1

    const-wide/16 p1, 0x3e8

    div-long/2addr p3, p1

    sget-object p1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "viking flag -----------------"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-direct {p0, p3, p4}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    invoke-direct {p0, p3, p4}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a(J)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private c(JJ)Ljava/lang/String;
    .locals 0

    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/utils/g;->n(J)Ljava/lang/String;

    move-result-object p1

    invoke-static {p3, p4}, Lcom/ape/offlinescriptmanager/utils/g;->n(J)Ljava/lang/String;

    move-result-object p2

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "~"

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private e(ILjava/lang/String;Ljava/lang/String;IJ)V
    .locals 6

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, p2, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "%~"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "%"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-wide/16 v2, 0x0

    invoke-interface {v1, p3, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    invoke-direct {p0, v4, v5, p5, p6}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b(JJ)Ljava/lang/String;

    move-result-object v1

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    invoke-interface {v4, p3, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    invoke-direct {p0, v2, v3, p5, p6}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->c(JJ)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v3, p2, p4}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    invoke-interface {p2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    invoke-interface {p2, p3, p5, p6}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    invoke-interface {p2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "recording usedtime : percentRange: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " , timeSpend : "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    const/4 p2, 0x1

    if-eq p1, p2, :cond_2

    const/4 p2, 0x2

    if-eq p1, p2, :cond_1

    const/16 p2, 0xa

    if-eq p1, p2, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0, v1, v2}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0, v0, v1, v2}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    invoke-virtual {p0, v0, v1, v2}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "recording hop data is : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " , "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    const v3, 0x7f0f0086

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "hop_time"

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    const v2, 0x7f0f0085

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "hop_range"

    invoke-virtual {v0, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/database/b;->a:Landroid/net/Uri;

    invoke-virtual {p1, p2, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    return-void
.end method


# virtual methods
.method public d(II)Z
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-string v1, "used_percent"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    sub-int v1, v0, p1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    if-ge v1, p2, :cond_2

    if-nez p1, :cond_0

    if-nez v0, :cond_2

    :cond_0
    const/16 p2, 0x64

    if-ne p1, p2, :cond_1

    if-eq v0, p2, :cond_1

    goto :goto_0

    :cond_1
    return v2

    :cond_2
    :goto_0
    const/4 p1, 0x1

    return p1
.end method

.method public g(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    const-string v1, "range"

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "used_time"

    invoke-virtual {v0, p1, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "time_range"

    invoke-virtual {v0, p1, p3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/database/e;->a:Landroid/net/Uri;

    invoke-virtual {p1, p2, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    return-void
.end method

.method public h(JID)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "recording percentage is : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const-string p2, "time"

    invoke-virtual {v0, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string p2, "percentage"

    invoke-virtual {v0, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    invoke-static {p4, p5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    const-string p2, "temperature"

    invoke-virtual {v0, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Double;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/database/c;->a:Landroid/net/Uri;

    invoke-virtual {p1, p2, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    const-string v1, "range"

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "used_time"

    invoke-virtual {v0, p1, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "time_range"

    invoke-virtual {v0, p1, p3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/database/g;->a:Landroid/net/Uri;

    invoke-virtual {p1, p2, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    return-void
.end method

.method public j(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "recording usedtime is : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    const-string v1, "range"

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "used_time"

    invoke-virtual {v0, p1, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "time_range"

    invoke-virtual {v0, p1, p3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/database/f;->a:Landroid/net/Uri;

    invoke-virtual {p1, p2, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    return-void
.end method

.method public k(JLjava/lang/String;D)V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "recording voltage is : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const-string p2, "time"

    invoke-virtual {v0, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    const-string p1, "voltage"

    invoke-virtual {v0, p1, p3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {p4, p5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    const-string p2, "temperature"

    invoke-virtual {v0, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Double;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object p2, Lcom/ape/offlinescriptmanager/database/h;->a:Landroid/net/Uri;

    invoke-virtual {p1, p2, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 14

    move-object v7, p0

    move-object v0, p1

    move-object/from16 v1, p2

    iput-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    const-string v2, "update_data"

    const/4 v8, 0x0

    invoke-virtual {p1, v2, v8}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    iput-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    sget-object v0, Ljava/util/Locale;->CHINA:Ljava/util/Locale;

    invoke-static {v0}, Ljava/util/Locale;->setDefault(Ljava/util/Locale;)V

    new-instance v0, Ljava/text/DecimalFormat;

    const-string v2, "#0.00"

    invoke-direct {v0, v2}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/text/DecimalFormat;

    const-string v3, "#0.0"

    invoke-direct {v2, v3}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    iget-object v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-string v4, "isUpdating"

    invoke-interface {v3, v4, v8}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_6

    const-string v3, "level"

    const/4 v4, -0x1

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    iput v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->c:I

    const-string v3, "scale"

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    iput v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->d:I

    const-string v9, "voltage"

    invoke-virtual {v1, v9, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    int-to-float v3, v3

    const/high16 v4, 0x447a0000    # 1000.0f

    div-float/2addr v3, v4

    iput v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->f:F

    float-to-double v3, v3

    invoke-virtual {v0, v3, v4}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->e:Ljava/lang/String;

    iget v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->c:I

    mul-int/lit8 v0, v0, 0x64

    iget v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->d:I

    div-int/2addr v0, v3

    iput v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    const-string v10, "temperature"

    invoke-virtual {v1, v10, v8}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    int-to-double v0, v0

    const-wide v3, 0x3fb999999999999aL    # 0.1

    mul-double/2addr v0, v3

    invoke-virtual {v2, v0, v1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Double;->valueOf(Ljava/lang/String;)Ljava/lang/Double;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    iput-wide v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-string v1, "isFirst"

    const/4 v11, 0x1

    invoke-interface {v0, v1, v11}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    const-string v6, "oneUsedTime"

    const-string v12, "onePercentage"

    if-eqz v0, :cond_0

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, v1, v8}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    invoke-interface {v0, v12, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    invoke-interface {v0, v6, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    const-string v2, "used_percent"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    const-string v3, "used_time"

    invoke-interface {v0, v3, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    double-to-float v1, v1

    invoke-interface {v0, v10, v1}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    iget v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    iget-wide v4, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h(JID)V

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    iget-object v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->e:Ljava/lang/String;

    iget-wide v4, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    invoke-virtual/range {v0 .. v5}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->k(JLjava/lang/String;D)V

    :cond_0
    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-string v13, "percentage"

    invoke-interface {v0, v13, v8}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    if-eq v0, v1, :cond_5

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    invoke-interface {v0, v12, v8}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    sub-int/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-ne v0, v11, :cond_1

    const/4 v1, 0x1

    iget v4, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    iget-wide v5, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    const-string v2, "onePercentage"

    const-string v3, "oneUsedTime"

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->e(ILjava/lang/String;Ljava/lang/String;IJ)V

    goto :goto_0

    :cond_1
    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    invoke-interface {v0, v12, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    invoke-interface {v0, v6, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    :goto_0
    iget v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    const/16 v1, 0xa

    invoke-virtual {p0, v0, v1}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->d(II)Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 v1, 0xa

    iget v4, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    iget-wide v5, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    const-string v2, "used_percent"

    const-string v3, "used_time"

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->e(ILjava/lang/String;Ljava/lang/String;IJ)V

    :cond_2
    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    invoke-interface {v0, v13, v8}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    sub-int/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    const-string v1, "last_time"

    if-le v0, v11, :cond_4

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-string v2, "hop_first"

    invoke-interface {v0, v2, v8}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    invoke-interface {v0, v13, v8}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    iget-object v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const-wide/16 v4, 0x0

    invoke-interface {v3, v1, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-direct {p0, v3, v4, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->c(JJ)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "%~"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "%"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v3, v0}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->j:Landroid/content/Context;

    const v3, 0x7f0f0084

    invoke-static {v0, v3, v8}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    :cond_3
    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, v2, v11}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    :cond_4
    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget v2, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    invoke-interface {v0, v13, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget-wide v2, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    double-to-float v1, v1

    invoke-interface {v0, v10, v1}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    iget v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h:I

    iget-wide v4, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->h(JID)V

    :cond_5
    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->a:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, v9, v1}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v0

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->f:F

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x3d4ccccd    # 0.05f

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_6

    iget-object v0, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->b:Landroid/content/SharedPreferences$Editor;

    iget v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->f:F

    invoke-interface {v0, v9, v1}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    iget-wide v1, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->g:J

    iget-object v3, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->e:Ljava/lang/String;

    iget-wide v4, v7, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->i:D

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/ape/offlinescriptmanager/batterytool/BatteryChangeBroadcastReceiver;->k(JLjava/lang/String;D)V

    :cond_6
    return-void
.end method
