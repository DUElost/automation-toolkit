.class Ljxl/write/biff/FileDataOutput;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/write/biff/ExcelDataOutput;


# static fields
.field static synthetic class$jxl$write$biff$FileDataOutput:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private data:Ljava/io/RandomAccessFile;

.field private temporaryFile:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/FileDataOutput;->class$jxl$write$biff$FileDataOutput:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.FileDataOutput"

    invoke-static {v0}, Ljxl/write/biff/FileDataOutput;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/FileDataOutput;->class$jxl$write$biff$FileDataOutput:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/FileDataOutput;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljava/io/File;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "jxl"

    const-string v1, ".tmp"

    invoke-static {v0, v1, p1}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/FileDataOutput;->temporaryFile:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->deleteOnExit()V

    new-instance p1, Ljava/io/RandomAccessFile;

    iget-object v0, p0, Ljxl/write/biff/FileDataOutput;->temporaryFile:Ljava/io/File;

    const-string v1, "rw"

    invoke-direct {p1, v0, v1}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object p1, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

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
.method public close()V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->close()V

    iget-object v0, p0, Ljxl/write/biff/FileDataOutput;->temporaryFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    return-void
.end method

.method public getPosition()I
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v0

    long-to-int v0, v0

    return v0
.end method

.method public setData([BI)V
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v0

    iget-object v2, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    int-to-long v3, p2

    invoke-virtual {v2, v3, v4}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p2, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {p2, p1}, Ljava/io/RandomAccessFile;->write([B)V

    iget-object p1, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {p1, v0, v1}, Ljava/io/RandomAccessFile;->seek(J)V

    return-void
.end method

.method public write([B)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {v0, p1}, Ljava/io/RandomAccessFile;->write([B)V

    return-void
.end method

.method public writeData(Ljava/io/OutputStream;)V
    .locals 4

    const/16 v0, 0x400

    new-array v0, v0, [B

    iget-object v1, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    const-wide/16 v2, 0x0

    invoke-virtual {v1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    :goto_0
    iget-object v1, p0, Ljxl/write/biff/FileDataOutput;->data:Ljava/io/RandomAccessFile;

    invoke-virtual {v1, v0}, Ljava/io/RandomAccessFile;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    :cond_0
    return-void
.end method
