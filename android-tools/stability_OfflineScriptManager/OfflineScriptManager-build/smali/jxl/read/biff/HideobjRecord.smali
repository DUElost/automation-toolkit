.class Ljxl/read/biff/HideobjRecord;
.super Ljxl/biff/RecordData;
.source ""


# static fields
.field static synthetic class$jxl$read$biff$HideobjRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private hidemode:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/read/biff/HideobjRecord;->class$jxl$read$biff$HideobjRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.HideobjRecord"

    invoke-static {v0}, Ljxl/read/biff/HideobjRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/HideobjRecord;->class$jxl$read$biff$HideobjRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/HideobjRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 2

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte v0, p1, v0

    const/4 v1, 0x1

    aget-byte p1, p1, v1

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/HideobjRecord;->hidemode:I

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
.method public getHideMode()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/HideobjRecord;->hidemode:I

    return v0
.end method
