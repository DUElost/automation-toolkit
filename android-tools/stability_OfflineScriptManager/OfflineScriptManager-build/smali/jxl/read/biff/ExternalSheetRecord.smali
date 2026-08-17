.class public Ljxl/read/biff/ExternalSheetRecord;
.super Ljxl/biff/RecordData;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/read/biff/ExternalSheetRecord$XTI;,
        Ljxl/read/biff/ExternalSheetRecord$Biff7;
    }
.end annotation


# static fields
.field public static biff7:Ljxl/read/biff/ExternalSheetRecord$Biff7;

.field static synthetic class$jxl$read$biff$ExternalSheetRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Ljxl/read/biff/ExternalSheetRecord;->class$jxl$read$biff$ExternalSheetRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.ExternalSheetRecord"

    invoke-static {v0}, Ljxl/read/biff/ExternalSheetRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/ExternalSheetRecord;->class$jxl$read$biff$ExternalSheetRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/ExternalSheetRecord;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/read/biff/ExternalSheetRecord$Biff7;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljxl/read/biff/ExternalSheetRecord$Biff7;-><init>(Ljxl/read/biff/ExternalSheetRecord$1;)V

    sput-object v0, Ljxl/read/biff/ExternalSheetRecord;->biff7:Ljxl/read/biff/ExternalSheetRecord$Biff7;

    return-void
.end method

.method constructor <init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;)V
    .locals 7

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 p2, 0x0

    aget-byte v0, p1, p2

    const/4 v1, 0x1

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    array-length v1, p1

    mul-int/lit8 v2, v0, 0x6

    const/4 v3, 0x2

    add-int/2addr v2, v3

    if-ge v1, v2, :cond_0

    new-array p1, p2, [Ljxl/read/biff/ExternalSheetRecord$XTI;

    iput-object p1, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    sget-object p1, Ljxl/read/biff/ExternalSheetRecord;->logger:Ljxl/common/Logger;

    const-string p2, "Could not process external sheets.  Formulas may be compromised."

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return-void

    :cond_0
    new-array v1, v0, [Ljxl/read/biff/ExternalSheetRecord$XTI;

    iput-object v1, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    :goto_0
    if-ge p2, v0, :cond_1

    aget-byte v1, p1, v3

    add-int/lit8 v2, v3, 0x1

    aget-byte v2, p1, v2

    invoke-static {v1, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    add-int/lit8 v2, v3, 0x2

    aget-byte v2, p1, v2

    add-int/lit8 v4, v3, 0x3

    aget-byte v4, p1, v4

    invoke-static {v2, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    add-int/lit8 v4, v3, 0x4

    aget-byte v4, p1, v4

    add-int/lit8 v5, v3, 0x5

    aget-byte v5, p1, v5

    invoke-static {v4, v5}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    iget-object v5, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    new-instance v6, Ljxl/read/biff/ExternalSheetRecord$XTI;

    invoke-direct {v6, v1, v2, v4}, Ljxl/read/biff/ExternalSheetRecord$XTI;-><init>(III)V

    aput-object v6, v5, p2

    add-int/lit8 v3, v3, 0x6

    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method constructor <init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;Ljxl/read/biff/ExternalSheetRecord$Biff7;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    sget-object p1, Ljxl/read/biff/ExternalSheetRecord;->logger:Ljxl/common/Logger;

    const-string p2, "External sheet record for Biff 7 not supported"

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

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

.method public getFirstTabIndex(I)I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    aget-object p1, v0, p1

    iget p1, p1, Ljxl/read/biff/ExternalSheetRecord$XTI;->firstTab:I

    return p1
.end method

.method public getLastTabIndex(I)I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    aget-object p1, v0, p1

    iget p1, p1, Ljxl/read/biff/ExternalSheetRecord$XTI;->lastTab:I

    return p1
.end method

.method public getNumRecords()I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    if-eqz v0, :cond_0

    array-length v0, v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public getSupbookIndex(I)I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/ExternalSheetRecord;->xtiArray:[Ljxl/read/biff/ExternalSheetRecord$XTI;

    aget-object p1, v0, p1

    iget p1, p1, Ljxl/read/biff/ExternalSheetRecord$XTI;->supbookIndex:I

    return p1
.end method
