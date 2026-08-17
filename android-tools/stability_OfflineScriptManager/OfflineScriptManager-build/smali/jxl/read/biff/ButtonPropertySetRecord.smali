.class public Ljxl/read/biff/ButtonPropertySetRecord;
.super Ljxl/biff/RecordData;
.source ""


# static fields
.field static synthetic class$jxl$read$biff$ButtonPropertySetRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/read/biff/ButtonPropertySetRecord;->class$jxl$read$biff$ButtonPropertySetRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.ButtonPropertySetRecord"

    invoke-static {v0}, Ljxl/read/biff/ButtonPropertySetRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/ButtonPropertySetRecord;->class$jxl$read$biff$ButtonPropertySetRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/ButtonPropertySetRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method constructor <init>(Ljxl/read/biff/Record;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 1

    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/NoClassDefFoundError;

    invoke-virtual {p0}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public getData()[B
    .locals 1

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v0

    return-object v0
.end method
