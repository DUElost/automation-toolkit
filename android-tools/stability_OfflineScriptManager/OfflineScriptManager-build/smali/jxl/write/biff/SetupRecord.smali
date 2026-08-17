.class Ljxl/write/biff/SetupRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$SetupRecord:Ljava/lang/Class;


# instance fields
.field private copies:I

.field private data:[B

.field private fitHeight:I

.field private fitWidth:I

.field private footerMargin:D

.field private headerMargin:D

.field private horizontalPrintResolution:I

.field private initialized:Z

.field logger:Ljxl/common/Logger;

.field private order:Ljxl/format/PageOrder;

.field private orientation:Ljxl/format/PageOrientation;

.field private pageStart:I

.field private paperSize:I

.field private scaleFactor:I

.field private verticalPrintResolution:I


# direct methods
.method public constructor <init>(Ljxl/SheetSettings;)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->SETUP:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    sget-object v0, Ljxl/write/biff/SetupRecord;->class$jxl$write$biff$SetupRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.SetupRecord"

    invoke-static {v0}, Ljxl/write/biff/SetupRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/SetupRecord;->class$jxl$write$biff$SetupRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/SetupRecord;->logger:Ljxl/common/Logger;

    invoke-virtual {p1}, Ljxl/SheetSettings;->getOrientation()Ljxl/format/PageOrientation;

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/SetupRecord;->orientation:Ljxl/format/PageOrientation;

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPageOrder()Ljxl/format/PageOrder;

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/SetupRecord;->order:Ljxl/format/PageOrder;

    invoke-virtual {p1}, Ljxl/SheetSettings;->getHeaderMargin()D

    move-result-wide v0

    iput-wide v0, p0, Ljxl/write/biff/SetupRecord;->headerMargin:D

    invoke-virtual {p1}, Ljxl/SheetSettings;->getFooterMargin()D

    move-result-wide v0

    iput-wide v0, p0, Ljxl/write/biff/SetupRecord;->footerMargin:D

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPaperSize()Ljxl/format/PaperSize;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/format/PaperSize;->getValue()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->paperSize:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getHorizontalPrintResolution()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->horizontalPrintResolution:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getVerticalPrintResolution()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->verticalPrintResolution:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getFitWidth()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->fitWidth:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getFitHeight()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->fitHeight:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPageStart()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->pageStart:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getScaleFactor()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SetupRecord;->scaleFactor:I

    invoke-virtual {p1}, Ljxl/SheetSettings;->getCopies()I

    move-result p1

    iput p1, p0, Ljxl/write/biff/SetupRecord;->copies:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/write/biff/SetupRecord;->initialized:Z

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
    .locals 4

    const/16 v0, 0x22

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/SetupRecord;->data:[B

    iget v1, p0, Ljxl/write/biff/SetupRecord;->paperSize:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->scaleFactor:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/4 v3, 0x2

    invoke-static {v0, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->pageStart:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/4 v3, 0x4

    invoke-static {v0, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->fitWidth:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/4 v3, 0x6

    invoke-static {v0, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->fitHeight:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v3, 0x8

    invoke-static {v0, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/SetupRecord;->order:Ljxl/format/PageOrder;

    sget-object v1, Ljxl/format/PageOrder;->RIGHT_THEN_DOWN:Ljxl/format/PageOrder;

    if-ne v0, v1, :cond_0

    const/4 v2, 0x1

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/SetupRecord;->orientation:Ljxl/format/PageOrientation;

    sget-object v1, Ljxl/format/PageOrientation;->PORTRAIT:Ljxl/format/PageOrientation;

    if-ne v0, v1, :cond_1

    or-int/lit8 v2, v2, 0x2

    :cond_1
    iget v0, p0, Ljxl/write/biff/SetupRecord;->pageStart:I

    if-eqz v0, :cond_2

    or-int/lit16 v2, v2, 0x80

    :cond_2
    iget-boolean v0, p0, Ljxl/write/biff/SetupRecord;->initialized:Z

    if-nez v0, :cond_3

    or-int/lit8 v2, v2, 0x4

    :cond_3
    iget-object v0, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v1, 0xa

    invoke-static {v2, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->horizontalPrintResolution:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v2, 0xc

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->verticalPrintResolution:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v2, 0xe

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-wide v0, p0, Ljxl/write/biff/SetupRecord;->headerMargin:D

    iget-object v2, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v3, 0x10

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/DoubleHelper;->getIEEEBytes(D[BI)V

    iget-wide v0, p0, Ljxl/write/biff/SetupRecord;->footerMargin:D

    iget-object v2, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v3, 0x18

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/DoubleHelper;->getIEEEBytes(D[BI)V

    iget v0, p0, Ljxl/write/biff/SetupRecord;->copies:I

    iget-object v1, p0, Ljxl/write/biff/SetupRecord;->data:[B

    const/16 v2, 0x20

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/SetupRecord;->data:[B

    return-object v0
.end method

.method public setMargins(DD)V
    .locals 0

    iput-wide p1, p0, Ljxl/write/biff/SetupRecord;->headerMargin:D

    iput-wide p3, p0, Ljxl/write/biff/SetupRecord;->footerMargin:D

    return-void
.end method

.method public setOrder(Ljxl/format/PageOrder;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SetupRecord;->order:Ljxl/format/PageOrder;

    return-void
.end method

.method public setOrientation(Ljxl/format/PageOrientation;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SetupRecord;->orientation:Ljxl/format/PageOrientation;

    return-void
.end method

.method public setPaperSize(Ljxl/format/PaperSize;)V
    .locals 0

    invoke-virtual {p1}, Ljxl/format/PaperSize;->getValue()I

    move-result p1

    iput p1, p0, Ljxl/write/biff/SetupRecord;->paperSize:I

    return-void
.end method
