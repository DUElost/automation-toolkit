.class public Ljxl/read/biff/SetupRecord;
.super Ljxl/biff/RecordData;
.source ""


# static fields
.field static synthetic class$jxl$read$biff$SetupRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private copies:I

.field private data:[B

.field private fitHeight:I

.field private fitWidth:I

.field private footerMargin:D

.field private headerMargin:D

.field private horizontalPrintResolution:I

.field private initialized:Z

.field private pageOrder:Z

.field private pageStart:I

.field private paperSize:I

.field private portraitOrientation:Z

.field private scaleFactor:I

.field private verticalPrintResolution:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/read/biff/SetupRecord;->class$jxl$read$biff$SetupRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.SetupRecord"

    invoke-static {v0}, Ljxl/read/biff/SetupRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/SetupRecord;->class$jxl$read$biff$SetupRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/SetupRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method constructor <init>(Ljxl/read/biff/Record;)V
    .locals 5

    sget-object v0, Ljxl/biff/Type;->SETUP:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/RecordData;-><init>(Ljxl/biff/Type;)V

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    iput-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/4 v0, 0x0

    aget-byte v1, p1, v0

    const/4 v2, 0x1

    aget-byte p1, p1, v2

    invoke-static {v1, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->paperSize:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/4 v1, 0x2

    aget-byte v1, p1, v1

    const/4 v3, 0x3

    aget-byte p1, p1, v3

    invoke-static {v1, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->scaleFactor:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/4 v1, 0x4

    aget-byte v3, p1, v1

    const/4 v4, 0x5

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->pageStart:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/4 v3, 0x6

    aget-byte v3, p1, v3

    const/4 v4, 0x7

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->fitWidth:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0x8

    aget-byte v3, p1, v3

    const/16 v4, 0x9

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->fitHeight:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0xc

    aget-byte v3, p1, v3

    const/16 v4, 0xd

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->horizontalPrintResolution:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0xe

    aget-byte v3, p1, v3

    const/16 v4, 0xf

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->verticalPrintResolution:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0x20

    aget-byte v3, p1, v3

    const/16 v4, 0x21

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SetupRecord;->copies:I

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0x10

    invoke-static {p1, v3}, Ljxl/biff/DoubleHelper;->getIEEEDouble([BI)D

    move-result-wide v3

    iput-wide v3, p0, Ljxl/read/biff/SetupRecord;->headerMargin:D

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0x18

    invoke-static {p1, v3}, Ljxl/biff/DoubleHelper;->getIEEEDouble([BI)D

    move-result-wide v3

    iput-wide v3, p0, Ljxl/read/biff/SetupRecord;->footerMargin:D

    iget-object p1, p0, Ljxl/read/biff/SetupRecord;->data:[B

    const/16 v3, 0xa

    aget-byte v3, p1, v3

    const/16 v4, 0xb

    aget-byte p1, p1, v4

    invoke-static {v3, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    and-int/lit8 v3, p1, 0x1

    if-eqz v3, :cond_0

    move v3, v2

    goto :goto_0

    :cond_0
    move v3, v0

    :goto_0
    iput-boolean v3, p0, Ljxl/read/biff/SetupRecord;->pageOrder:Z

    and-int/lit8 v3, p1, 0x2

    if-eqz v3, :cond_1

    move v3, v2

    goto :goto_1

    :cond_1
    move v3, v0

    :goto_1
    iput-boolean v3, p0, Ljxl/read/biff/SetupRecord;->portraitOrientation:Z

    and-int/2addr p1, v1

    if-nez p1, :cond_2

    move v0, v2

    :cond_2
    iput-boolean v0, p0, Ljxl/read/biff/SetupRecord;->initialized:Z

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
.method public getCopies()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->copies:I

    return v0
.end method

.method public getFitHeight()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->fitHeight:I

    return v0
.end method

.method public getFitWidth()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->fitWidth:I

    return v0
.end method

.method public getFooterMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/read/biff/SetupRecord;->footerMargin:D

    return-wide v0
.end method

.method public getHeaderMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/read/biff/SetupRecord;->headerMargin:D

    return-wide v0
.end method

.method public getHorizontalPrintResolution()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->horizontalPrintResolution:I

    return v0
.end method

.method public getInitialized()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/read/biff/SetupRecord;->initialized:Z

    return v0
.end method

.method public getPageStart()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->pageStart:I

    return v0
.end method

.method public getPaperSize()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->paperSize:I

    return v0
.end method

.method public getScaleFactor()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->scaleFactor:I

    return v0
.end method

.method public getVerticalPrintResolution()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SetupRecord;->verticalPrintResolution:I

    return v0
.end method

.method public isPortrait()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/read/biff/SetupRecord;->portraitOrientation:Z

    return v0
.end method

.method public isRightDown()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/read/biff/SetupRecord;->pageOrder:Z

    return v0
.end method
