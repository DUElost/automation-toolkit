.class public Ljxl/biff/drawing/Chart;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/ByteData;
.implements Ljxl/biff/drawing/EscherStream;


# static fields
.field static synthetic class$jxl$biff$drawing$Chart:Ljava/lang/Class;

.field private static final logger:Ljxl/common/Logger;


# instance fields
.field private data:[B

.field private drawingData:Ljxl/biff/drawing/DrawingData;

.field private drawingNumber:I

.field private endpos:I

.field private file:Ljxl/read/biff/File;

.field private initialized:Z

.field private msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

.field private objRecord:Ljxl/biff/drawing/ObjRecord;

.field private startpos:I

.field private workbookSettings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/Chart;->class$jxl$biff$drawing$Chart:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.Chart"

    invoke-static {v0}, Ljxl/biff/drawing/Chart;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Chart;->class$jxl$biff$drawing$Chart:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Chart;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;IILjxl/read/biff/File;Ljxl/WorkbookSettings;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/drawing/Chart;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object p2, p0, Ljxl/biff/drawing/Chart;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput p4, p0, Ljxl/biff/drawing/Chart;->startpos:I

    iput p5, p0, Ljxl/biff/drawing/Chart;->endpos:I

    iput-object p6, p0, Ljxl/biff/drawing/Chart;->file:Ljxl/read/biff/File;

    iput-object p7, p0, Ljxl/biff/drawing/Chart;->workbookSettings:Ljxl/WorkbookSettings;

    const/4 p4, 0x1

    if-eqz p1, :cond_0

    iput-object p3, p0, Ljxl/biff/drawing/Chart;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p1}, Ljxl/biff/drawing/MsoDrawingRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object p5

    invoke-virtual {p5}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p5

    invoke-virtual {p3, p5}, Ljxl/biff/drawing/DrawingData;->addData([B)V

    iget-object p3, p0, Ljxl/biff/drawing/Chart;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p3}, Ljxl/biff/drawing/DrawingData;->getNumDrawings()I

    move-result p3

    sub-int/2addr p3, p4

    iput p3, p0, Ljxl/biff/drawing/Chart;->drawingNumber:I

    :cond_0
    const/4 p3, 0x0

    iput-boolean p3, p0, Ljxl/biff/drawing/Chart;->initialized:Z

    if-eqz p1, :cond_1

    if-nez p2, :cond_3

    :cond_1
    if-nez p1, :cond_2

    if-nez p2, :cond_2

    goto :goto_0

    :cond_2
    move p4, p3

    :cond_3
    :goto_0
    invoke-static {p4}, Ljxl/common/Assert;->verify(Z)V

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

.method private initialize()V
    .locals 3

    iget-object v0, p0, Ljxl/biff/drawing/Chart;->file:Ljxl/read/biff/File;

    iget v1, p0, Ljxl/biff/drawing/Chart;->startpos:I

    iget v2, p0, Ljxl/biff/drawing/Chart;->endpos:I

    sub-int/2addr v2, v1

    invoke-virtual {v0, v1, v2}, Ljxl/read/biff/File;->read(II)[B

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/drawing/Chart;->data:[B

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/drawing/Chart;->initialized:Z

    return-void
.end method


# virtual methods
.method public getBytes()[B
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Chart;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Chart;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Chart;->data:[B

    return-object v0
.end method

.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Chart;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-virtual {v0}, Ljxl/biff/drawing/MsoDrawingRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v0

    return-object v0
.end method

.method getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Chart;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    return-object v0
.end method

.method getObjRecord()Ljxl/biff/drawing/ObjRecord;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Chart;->objRecord:Ljxl/biff/drawing/ObjRecord;

    return-object v0
.end method

.method getSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Chart;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget v1, p0, Ljxl/biff/drawing/Chart;->drawingNumber:I

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/DrawingData;->getSpContainer(I)Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    return-object v0
.end method

.method public rationalize(Ljxl/biff/IndexMapping;Ljxl/biff/IndexMapping;Ljxl/biff/IndexMapping;)V
    .locals 9

    iget-boolean p1, p0, Ljxl/biff/drawing/Chart;->initialized:Z

    if-nez p1, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Chart;->initialize()V

    :cond_0
    const/4 p1, 0x0

    move v0, p1

    :goto_0
    iget-object v1, p0, Ljxl/biff/drawing/Chart;->data:[B

    array-length v2, v1

    if-ge v0, v2, :cond_5

    aget-byte v2, v1, v0

    add-int/lit8 v3, v0, 0x1

    aget-byte v1, v1, v3

    invoke-static {v2, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iget-object v2, p0, Ljxl/biff/drawing/Chart;->data:[B

    add-int/lit8 v3, v0, 0x2

    aget-byte v3, v2, v3

    add-int/lit8 v4, v0, 0x3

    aget-byte v2, v2, v4

    invoke-static {v3, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    invoke-static {v1}, Ljxl/biff/Type;->getType(I)Ljxl/biff/Type;

    move-result-object v1

    sget-object v3, Ljxl/biff/Type;->FONTX:Ljxl/biff/Type;

    if-ne v1, v3, :cond_1

    iget-object v1, p0, Ljxl/biff/drawing/Chart;->data:[B

    add-int/lit8 v3, v0, 0x4

    aget-byte v4, v1, v3

    add-int/lit8 v5, v0, 0x5

    aget-byte v1, v1, v5

    invoke-static {v4, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    invoke-virtual {p2, v1}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v1

    iget-object v4, p0, Ljxl/biff/drawing/Chart;->data:[B

    invoke-static {v1, v4, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    goto :goto_2

    :cond_1
    sget-object v3, Ljxl/biff/Type;->FBI:Ljxl/biff/Type;

    if-ne v1, v3, :cond_2

    iget-object v1, p0, Ljxl/biff/drawing/Chart;->data:[B

    add-int/lit8 v3, v0, 0xc

    aget-byte v4, v1, v3

    add-int/lit8 v5, v0, 0xd

    aget-byte v1, v1, v5

    invoke-static {v4, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    invoke-virtual {p2, v1}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v1

    iget-object v4, p0, Ljxl/biff/drawing/Chart;->data:[B

    invoke-static {v1, v4, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    goto :goto_2

    :cond_2
    sget-object v3, Ljxl/biff/Type;->IFMT:Ljxl/biff/Type;

    if-ne v1, v3, :cond_3

    iget-object v1, p0, Ljxl/biff/drawing/Chart;->data:[B

    add-int/lit8 v3, v0, 0x4

    aget-byte v4, v1, v3

    add-int/lit8 v5, v0, 0x5

    aget-byte v1, v1, v5

    invoke-static {v4, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    invoke-virtual {p3, v1}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v1

    iget-object v4, p0, Ljxl/biff/drawing/Chart;->data:[B

    invoke-static {v1, v4, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    goto :goto_2

    :cond_3
    sget-object v3, Ljxl/biff/Type;->ALRUNS:Ljxl/biff/Type;

    if-ne v1, v3, :cond_4

    iget-object v1, p0, Ljxl/biff/drawing/Chart;->data:[B

    add-int/lit8 v3, v0, 0x4

    aget-byte v3, v1, v3

    add-int/lit8 v4, v0, 0x5

    aget-byte v1, v1, v4

    invoke-static {v3, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    add-int/lit8 v3, v0, 0x6

    move v4, p1

    :goto_1
    if-ge v4, v1, :cond_4

    iget-object v5, p0, Ljxl/biff/drawing/Chart;->data:[B

    add-int/lit8 v6, v3, 0x2

    aget-byte v7, v5, v6

    add-int/lit8 v8, v3, 0x3

    aget-byte v5, v5, v8

    invoke-static {v7, v5}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v5

    invoke-virtual {p2, v5}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v5

    iget-object v7, p0, Ljxl/biff/drawing/Chart;->data:[B

    invoke-static {v5, v7, v6}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v3, v3, 0x4

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_4
    :goto_2
    add-int/lit8 v2, v2, 0x4

    add-int/2addr v0, v2

    goto/16 :goto_0

    :cond_5
    return-void
.end method
