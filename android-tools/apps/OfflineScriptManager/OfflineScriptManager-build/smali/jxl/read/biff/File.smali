.class public Ljxl/read/biff/File;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$read$biff$File:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private arrayGrowSize:I

.field private compoundFile:Ljxl/read/biff/CompoundFile;

.field private data:[B

.field private filePos:I

.field private initialFileSize:I

.field private oldPos:I

.field private workbookSettings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/read/biff/File;->class$jxl$read$biff$File:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.File"

    invoke-static {v0}, Ljxl/read/biff/File;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/File;->class$jxl$read$biff$File:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/File;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;Ljxl/WorkbookSettings;)V
    .locals 5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Ljxl/read/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {p2}, Ljxl/WorkbookSettings;->getInitialFileSize()I

    move-result v0

    iput v0, p0, Ljxl/read/biff/File;->initialFileSize:I

    iget-object v0, p0, Ljxl/read/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getArrayGrowSize()I

    move-result v0

    iput v0, p0, Ljxl/read/biff/File;->arrayGrowSize:I

    iget v0, p0, Ljxl/read/biff/File;->initialFileSize:I

    new-array v0, v0, [B

    invoke-virtual {p1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v2

    if-nez v2, :cond_6

    move v2, v1

    :goto_0
    const/4 v3, -0x1

    if-eq v1, v3, :cond_2

    array-length v1, v0

    if-lt v2, v1, :cond_0

    array-length v1, v0

    iget v3, p0, Ljxl/read/biff/File;->arrayGrowSize:I

    add-int/2addr v1, v3

    new-array v1, v1, [B

    array-length v3, v0

    const/4 v4, 0x0

    invoke-static {v0, v4, v1, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v0, v1

    :cond_0
    array-length v1, v0

    sub-int/2addr v1, v2

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    add-int/2addr v2, v1

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v3

    if-nez v3, :cond_1

    goto :goto_0

    :cond_1
    new-instance p1, Ljava/io/InterruptedIOException;

    invoke-direct {p1}, Ljava/io/InterruptedIOException;-><init>()V

    throw p1

    :cond_2
    add-int/lit8 v2, v2, 0x1

    if-eqz v2, :cond_5

    new-instance p1, Ljxl/read/biff/CompoundFile;

    invoke-direct {p1, v0, p2}, Ljxl/read/biff/CompoundFile;-><init>([BLjxl/WorkbookSettings;)V

    :try_start_0
    const-string p2, "workbook"

    invoke-virtual {p1, p2}, Ljxl/read/biff/CompoundFile;->getStream(Ljava/lang/String;)[B

    move-result-object p2

    iput-object p2, p0, Ljxl/read/biff/File;->data:[B
    :try_end_0
    .catch Ljxl/read/biff/BiffException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    const-string p2, "book"

    invoke-virtual {p1, p2}, Ljxl/read/biff/CompoundFile;->getStream(Ljava/lang/String;)[B

    move-result-object p2

    iput-object p2, p0, Ljxl/read/biff/File;->data:[B

    :goto_1
    iget-object p2, p0, Ljxl/read/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {p2}, Ljxl/WorkbookSettings;->getPropertySetsDisabled()Z

    move-result p2

    if-nez p2, :cond_3

    invoke-virtual {p1}, Ljxl/read/biff/CompoundFile;->getNumberOfPropertySets()I

    move-result p2

    sget-object v0, Ljxl/biff/BaseCompoundFile;->STANDARD_PROPERTY_SETS:[Ljava/lang/String;

    array-length v0, v0

    if-le p2, v0, :cond_3

    iput-object p1, p0, Ljxl/read/biff/File;->compoundFile:Ljxl/read/biff/CompoundFile;

    :cond_3
    iget-object p1, p0, Ljxl/read/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {p1}, Ljxl/WorkbookSettings;->getGCDisabled()Z

    move-result p1

    if-nez p1, :cond_4

    invoke-static {}, Ljava/lang/System;->gc()V

    :cond_4
    return-void

    :cond_5
    new-instance p1, Ljxl/read/biff/BiffException;

    sget-object p2, Ljxl/read/biff/BiffException;->excelFileNotFound:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {p1, p2}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw p1

    :cond_6
    new-instance p1, Ljava/io/InterruptedIOException;

    invoke-direct {p1}, Ljava/io/InterruptedIOException;-><init>()V

    throw p1
.end method

.method public constructor <init>([B)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/File;->data:[B

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

.method private moveToFirstBof()V
    .locals 5

    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    iget-object v1, p0, Ljxl/read/biff/File;->data:[B

    iget v2, p0, Ljxl/read/biff/File;->filePos:I

    aget-byte v3, v1, v2

    const/4 v4, 0x1

    add-int/2addr v2, v4

    aget-byte v1, v1, v2

    invoke-static {v3, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    sget-object v2, Ljxl/biff/Type;->BOF:Ljxl/biff/Type;

    iget v2, v2, Ljxl/biff/Type;->value:I

    if-ne v1, v2, :cond_0

    move v0, v4

    goto :goto_0

    :cond_0
    const/16 v1, 0x80

    invoke-virtual {p0, v1}, Ljxl/read/biff/File;->skip(I)V

    goto :goto_0

    :cond_1
    return-void
.end method


# virtual methods
.method public clear()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Ljxl/read/biff/File;->data:[B

    return-void
.end method

.method public close()V
    .locals 0

    return-void
.end method

.method getCompoundFile()Ljxl/read/biff/CompoundFile;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/File;->compoundFile:Ljxl/read/biff/CompoundFile;

    return-object v0
.end method

.method public getPos()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/File;->filePos:I

    return v0
.end method

.method public hasNext()Z
    .locals 2

    iget v0, p0, Ljxl/read/biff/File;->filePos:I

    iget-object v1, p0, Ljxl/read/biff/File;->data:[B

    array-length v1, v1

    add-int/lit8 v1, v1, -0x4

    if-ge v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method next()Ljxl/read/biff/Record;
    .locals 3

    new-instance v0, Ljxl/read/biff/Record;

    iget-object v1, p0, Ljxl/read/biff/File;->data:[B

    iget v2, p0, Ljxl/read/biff/File;->filePos:I

    invoke-direct {v0, v1, v2, p0}, Ljxl/read/biff/Record;-><init>([BILjxl/read/biff/File;)V

    return-object v0
.end method

.method peek()Ljxl/read/biff/Record;
    .locals 4

    iget v0, p0, Ljxl/read/biff/File;->filePos:I

    new-instance v1, Ljxl/read/biff/Record;

    iget-object v2, p0, Ljxl/read/biff/File;->data:[B

    iget v3, p0, Ljxl/read/biff/File;->filePos:I

    invoke-direct {v1, v2, v3, p0}, Ljxl/read/biff/Record;-><init>([BILjxl/read/biff/File;)V

    iput v0, p0, Ljxl/read/biff/File;->filePos:I

    return-object v1
.end method

.method public read(II)[B
    .locals 4

    new-array v0, p2, [B

    :try_start_0
    iget-object v1, p0, Ljxl/read/biff/File;->data:[B

    const/4 v2, 0x0

    invoke-static {v1, p1, v0, v2, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    sget-object v1, Ljxl/read/biff/File;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Array index out of bounds at position "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string p1, " record length "

    invoke-virtual {v2, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljxl/common/Logger;->error(Ljava/lang/Object;)V

    throw v0
.end method

.method public restorePos()V
    .locals 1

    iget v0, p0, Ljxl/read/biff/File;->oldPos:I

    iput v0, p0, Ljxl/read/biff/File;->filePos:I

    return-void
.end method

.method public setPos(I)V
    .locals 1

    iget v0, p0, Ljxl/read/biff/File;->filePos:I

    iput v0, p0, Ljxl/read/biff/File;->oldPos:I

    iput p1, p0, Ljxl/read/biff/File;->filePos:I

    return-void
.end method

.method public skip(I)V
    .locals 1

    iget v0, p0, Ljxl/read/biff/File;->filePos:I

    add-int/2addr v0, p1

    iput v0, p0, Ljxl/read/biff/File;->filePos:I

    return-void
.end method
