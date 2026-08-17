.class public Ljxl/biff/ConditionalFormatRangeRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/biff/ConditionalFormatRangeRecord$Range;
    }
.end annotation


# static fields
.field static synthetic class$jxl$biff$ConditionalFormatRangeRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private data:[B

.field private enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

.field private initialized:Z

.field private modified:Z

.field private numRanges:I

.field private ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/ConditionalFormatRangeRecord;->class$jxl$biff$ConditionalFormatRangeRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.ConditionalFormatRangeRecord"

    invoke-static {v0}, Ljxl/biff/ConditionalFormatRangeRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/ConditionalFormatRangeRecord;->class$jxl$biff$ConditionalFormatRangeRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/ConditionalFormatRangeRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->initialized:Z

    iput-boolean p1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

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
    .locals 7

    new-instance v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;

    invoke-direct {v0}, Ljxl/biff/ConditionalFormatRangeRecord$Range;-><init>()V

    iput-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-object v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    const/4 v2, 0x4

    aget-byte v2, v1, v2

    const/4 v3, 0x5

    aget-byte v1, v1, v3

    invoke-static {v2, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iput v1, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-object v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    const/4 v2, 0x6

    aget-byte v2, v1, v2

    const/4 v3, 0x7

    aget-byte v1, v1, v3

    invoke-static {v2, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iput v1, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-object v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    const/16 v2, 0x8

    aget-byte v3, v1, v2

    const/16 v4, 0x9

    aget-byte v1, v1, v4

    invoke-static {v3, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iput v1, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-object v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    const/16 v3, 0xa

    aget-byte v3, v1, v3

    const/16 v4, 0xb

    aget-byte v1, v1, v4

    invoke-static {v3, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iput v1, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    const/16 v1, 0xc

    aget-byte v1, v0, v1

    const/16 v3, 0xd

    aget-byte v0, v0, v3

    invoke-static {v1, v0}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->numRanges:I

    new-array v0, v0, [Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iput-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    const/16 v0, 0xe

    const/4 v1, 0x0

    :goto_0
    iget v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->numRanges:I

    if-ge v1, v3, :cond_0

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    new-instance v4, Ljxl/biff/ConditionalFormatRangeRecord$Range;

    invoke-direct {v4}, Ljxl/biff/ConditionalFormatRangeRecord$Range;-><init>()V

    aput-object v4, v3, v1

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v1

    iget-object v4, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    aget-byte v5, v4, v0

    add-int/lit8 v6, v0, 0x1

    aget-byte v4, v4, v6

    invoke-static {v5, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    iput v4, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v1

    iget-object v4, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    add-int/lit8 v5, v0, 0x2

    aget-byte v5, v4, v5

    add-int/lit8 v6, v0, 0x3

    aget-byte v4, v4, v6

    invoke-static {v5, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    iput v4, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v1

    iget-object v4, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    add-int/lit8 v5, v0, 0x4

    aget-byte v5, v4, v5

    add-int/lit8 v6, v0, 0x5

    aget-byte v4, v4, v6

    invoke-static {v5, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    iput v4, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v1

    iget-object v4, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    add-int/lit8 v5, v0, 0x6

    aget-byte v5, v4, v5

    add-int/lit8 v6, v0, 0x7

    aget-byte v4, v4, v6

    invoke-static {v5, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    iput v4, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    add-int/2addr v0, v2

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->initialized:Z

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 6

    iget-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    return-object v0

    :cond_0
    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    array-length v0, v0

    const/16 v1, 0x8

    mul-int/2addr v0, v1

    const/16 v2, 0xe

    add-int/2addr v0, v2

    new-array v0, v0, [B

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->data:[B

    const/4 v4, 0x0

    const/4 v5, 0x4

    invoke-static {v3, v4, v0, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    const/4 v5, 0x6

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    invoke-static {v3, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    const/16 v5, 0xa

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->numRanges:I

    const/16 v5, 0xc

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    :goto_0
    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    array-length v5, v3

    if-ge v4, v5, :cond_1

    aget-object v3, v3, v4

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    invoke-static {v3, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v4

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    add-int/lit8 v5, v2, 0x2

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v4

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    add-int/lit8 v5, v2, 0x4

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v3, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v3, v3, v4

    iget v3, v3, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    add-int/lit8 v5, v2, 0x6

    invoke-static {v3, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/2addr v2, v1

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public insertColumn(I)V
    .locals 4

    iget-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/ConditionalFormatRangeRecord;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->insertColumn(I)V

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-boolean v0, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_1
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    array-length v3, v2

    if-ge v0, v3, :cond_3

    aget-object v2, v2, v0

    invoke-virtual {v2, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->insertColumn(I)V

    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    if-eqz v2, :cond_2

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method public insertRow(I)V
    .locals 4

    iget-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/ConditionalFormatRangeRecord;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->insertRow(I)V

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-boolean v0, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_1
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    array-length v3, v2

    if-ge v0, v3, :cond_3

    aget-object v2, v2, v0

    invoke-virtual {v2, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->insertRow(I)V

    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    if-eqz v2, :cond_2

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method public removeColumn(I)V
    .locals 4

    iget-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/ConditionalFormatRangeRecord;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->removeColumn(I)V

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-boolean v0, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_1
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    array-length v3, v2

    if-ge v0, v3, :cond_3

    aget-object v2, v2, v0

    invoke-virtual {v2, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->removeColumn(I)V

    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    if-eqz v2, :cond_2

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method public removeRow(I)V
    .locals 4

    iget-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/ConditionalFormatRangeRecord;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->removeRow(I)V

    iget-object v0, p0, Ljxl/biff/ConditionalFormatRangeRecord;->enclosingRange:Ljxl/biff/ConditionalFormatRangeRecord$Range;

    iget-boolean v0, v0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_1
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    array-length v3, v2

    if-ge v0, v3, :cond_3

    aget-object v2, v2, v0

    invoke-virtual {v2, p1}, Ljxl/biff/ConditionalFormatRangeRecord$Range;->removeRow(I)V

    iget-object v2, p0, Ljxl/biff/ConditionalFormatRangeRecord;->ranges:[Ljxl/biff/ConditionalFormatRangeRecord$Range;

    aget-object v2, v2, v0

    iget-boolean v2, v2, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    if-eqz v2, :cond_2

    iput-boolean v1, p0, Ljxl/biff/ConditionalFormatRangeRecord;->modified:Z

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method
