.class public final Ljxl/write/biff/File;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$File:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private arrayGrowSize:I

.field private data:Ljxl/write/biff/ExcelDataOutput;

.field private initialFileSize:I

.field private outputStream:Ljava/io/OutputStream;

.field private pos:I

.field readCompoundFile:Ljxl/read/biff/CompoundFile;

.field private workbookSettings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/File;->class$jxl$write$biff$File:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.File"

    invoke-static {v0}, Ljxl/write/biff/File;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/File;->class$jxl$write$biff$File:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/File;->logger:Ljxl/common/Logger;

    return-void
.end method

.method constructor <init>(Ljava/io/OutputStream;Ljxl/WorkbookSettings;Ljxl/read/biff/CompoundFile;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/File;->outputStream:Ljava/io/OutputStream;

    iput-object p2, p0, Ljxl/write/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    iput-object p3, p0, Ljxl/write/biff/File;->readCompoundFile:Ljxl/read/biff/CompoundFile;

    invoke-direct {p0}, Ljxl/write/biff/File;->createDataOutput()V

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

.method private createDataOutput()V
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getUseTemporaryFileDuringWrite()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljxl/write/biff/FileDataOutput;

    iget-object v1, p0, Ljxl/write/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getTemporaryFileDuringWriteDirectory()Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/write/biff/FileDataOutput;-><init>(Ljava/io/File;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getInitialFileSize()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/File;->initialFileSize:I

    iget-object v0, p0, Ljxl/write/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getArrayGrowSize()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/File;->arrayGrowSize:I

    new-instance v0, Ljxl/write/biff/MemoryDataOutput;

    iget v1, p0, Ljxl/write/biff/File;->initialFileSize:I

    iget v2, p0, Ljxl/write/biff/File;->arrayGrowSize:I

    invoke-direct {v0, v1, v2}, Ljxl/write/biff/MemoryDataOutput;-><init>(II)V

    :goto_0
    iput-object v0, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    return-void
.end method


# virtual methods
.method close(Z)V
    .locals 5

    new-instance v0, Ljxl/write/biff/CompoundFile;

    iget-object v1, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    invoke-interface {v1}, Ljxl/write/biff/ExcelDataOutput;->getPosition()I

    move-result v2

    iget-object v3, p0, Ljxl/write/biff/File;->outputStream:Ljava/io/OutputStream;

    iget-object v4, p0, Ljxl/write/biff/File;->readCompoundFile:Ljxl/read/biff/CompoundFile;

    invoke-direct {v0, v1, v2, v3, v4}, Ljxl/write/biff/CompoundFile;-><init>(Ljxl/write/biff/ExcelDataOutput;ILjava/io/OutputStream;Ljxl/read/biff/CompoundFile;)V

    invoke-virtual {v0}, Ljxl/write/biff/CompoundFile;->write()V

    iget-object v0, p0, Ljxl/write/biff/File;->outputStream:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    iget-object v0, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    invoke-interface {v0}, Ljxl/write/biff/ExcelDataOutput;->close()V

    if-eqz p1, :cond_0

    iget-object p1, p0, Ljxl/write/biff/File;->outputStream:Ljava/io/OutputStream;

    invoke-virtual {p1}, Ljava/io/OutputStream;->close()V

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    iget-object p1, p0, Ljxl/write/biff/File;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {p1}, Ljxl/WorkbookSettings;->getGCDisabled()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-static {}, Ljava/lang/System;->gc()V

    :cond_1
    return-void
.end method

.method getPos()I
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    invoke-interface {v0}, Ljxl/write/biff/ExcelDataOutput;->getPosition()I

    move-result v0

    return v0
.end method

.method setData([BI)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    invoke-interface {v0, p1, p2}, Ljxl/write/biff/ExcelDataOutput;->setData([BI)V

    return-void
.end method

.method public setOutputFile(Ljava/io/OutputStream;)V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    if-eqz v0, :cond_0

    sget-object v0, Ljxl/write/biff/File;->logger:Ljxl/common/Logger;

    const-string v1, "Rewriting a workbook with non-empty data"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_0
    iput-object p1, p0, Ljxl/write/biff/File;->outputStream:Ljava/io/OutputStream;

    invoke-direct {p0}, Ljxl/write/biff/File;->createDataOutput()V

    return-void
.end method

.method public write(Ljxl/biff/ByteData;)V
    .locals 1

    invoke-interface {p1}, Ljxl/biff/ByteData;->getBytes()[B

    move-result-object p1

    iget-object v0, p0, Ljxl/write/biff/File;->data:Ljxl/write/biff/ExcelDataOutput;

    invoke-interface {v0, p1}, Ljxl/write/biff/ExcelDataOutput;->write([B)V

    return-void
.end method
