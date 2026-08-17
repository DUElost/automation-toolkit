.class Ljxl/write/biff/MemoryDataOutput;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/write/biff/ExcelDataOutput;


# static fields
.field static synthetic class$jxl$write$biff$MemoryDataOutput:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private data:[B

.field private growSize:I

.field private pos:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/MemoryDataOutput;->class$jxl$write$biff$MemoryDataOutput:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.MemoryDataOutput"

    invoke-static {v0}, Ljxl/write/biff/MemoryDataOutput;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/MemoryDataOutput;->class$jxl$write$biff$MemoryDataOutput:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/MemoryDataOutput;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-array p1, p1, [B

    iput-object p1, p0, Ljxl/write/biff/MemoryDataOutput;->data:[B

    iput p2, p0, Ljxl/write/biff/MemoryDataOutput;->growSize:I

    const/4 p1, 0x0

    iput p1, p0, Ljxl/write/biff/MemoryDataOutput;->pos:I

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
    .locals 0

    return-void
.end method

.method public getPosition()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/MemoryDataOutput;->pos:I

    return v0
.end method

.method public setData([BI)V
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/MemoryDataOutput;->data:[B

    array-length v1, p1

    const/4 v2, 0x0

    invoke-static {p1, v2, v0, p2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-void
.end method

.method public write([B)V
    .locals 5

    :goto_0
    iget v0, p0, Ljxl/write/biff/MemoryDataOutput;->pos:I

    array-length v1, p1

    add-int/2addr v1, v0

    iget-object v2, p0, Ljxl/write/biff/MemoryDataOutput;->data:[B

    array-length v3, v2

    const/4 v4, 0x0

    if-le v1, v3, :cond_0

    array-length v1, v2

    iget v3, p0, Ljxl/write/biff/MemoryDataOutput;->growSize:I

    add-int/2addr v1, v3

    new-array v1, v1, [B

    invoke-static {v2, v4, v1, v4, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iput-object v1, p0, Ljxl/write/biff/MemoryDataOutput;->data:[B

    goto :goto_0

    :cond_0
    array-length v1, p1

    invoke-static {p1, v4, v2, v0, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v0, p0, Ljxl/write/biff/MemoryDataOutput;->pos:I

    array-length p1, p1

    add-int/2addr v0, p1

    iput v0, p0, Ljxl/write/biff/MemoryDataOutput;->pos:I

    return-void
.end method

.method public writeData(Ljava/io/OutputStream;)V
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/MemoryDataOutput;->data:[B

    iget v1, p0, Ljxl/write/biff/MemoryDataOutput;->pos:I

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    return-void
.end method
