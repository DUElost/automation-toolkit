.class Ljxl/biff/drawing/BlipStoreEntry;
.super Ljxl/biff/drawing/EscherAtom;
.source ""


# static fields
.field private static final IMAGE_DATA_OFFSET:I = 0x3d

.field static synthetic class$jxl$biff$drawing$BlipStoreEntry:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private data:[B

.field private imageDataLength:I

.field private referenceCount:I

.field private type:Ljxl/biff/drawing/BlipType;

.field private write:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/BlipStoreEntry;->class$jxl$biff$drawing$BlipStoreEntry:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.BlipStoreEntry"

    invoke-static {v0}, Ljxl/biff/drawing/BlipStoreEntry;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/BlipStoreEntry;->class$jxl$biff$drawing$BlipStoreEntry:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/BlipStoreEntry;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/Drawing;)V
    .locals 5

    sget-object v0, Ljxl/biff/drawing/EscherRecordType;->BSE:Ljxl/biff/drawing/EscherRecordType;

    invoke-direct {p0, v0}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordType;)V

    sget-object v0, Ljxl/biff/drawing/BlipType;->PNG:Ljxl/biff/drawing/BlipType;

    iput-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->type:Ljxl/biff/drawing/BlipType;

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setVersion(I)V

    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->type:Ljxl/biff/drawing/BlipType;

    invoke-virtual {v0}, Ljxl/biff/drawing/BlipType;->getValue()I

    move-result v0

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setInstance(I)V

    invoke-virtual {p1}, Ljxl/biff/drawing/Drawing;->getImageBytes()[B

    move-result-object v0

    array-length v1, v0

    iput v1, p0, Ljxl/biff/drawing/BlipStoreEntry;->imageDataLength:I

    add-int/lit8 v2, v1, 0x3d

    new-array v2, v2, [B

    iput-object v2, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    const/4 v3, 0x0

    const/16 v4, 0x3d

    invoke-static {v0, v3, v2, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p1}, Ljxl/biff/drawing/Drawing;->getReferenceCount()I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/BlipStoreEntry;->referenceCount:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/drawing/BlipStoreEntry;->write:Z

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/EscherRecordData;)V
    .locals 4

    invoke-direct {p0, p1}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getInstance()I

    move-result p1

    invoke-static {p1}, Ljxl/biff/drawing/BlipType;->getType(I)Ljxl/biff/drawing/BlipType;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/drawing/BlipStoreEntry;->type:Ljxl/biff/drawing/BlipType;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/drawing/BlipStoreEntry;->write:Z

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object p1

    const/16 v0, 0x18

    aget-byte v0, p1, v0

    const/16 v1, 0x19

    aget-byte v1, p1, v1

    const/16 v2, 0x1a

    aget-byte v2, p1, v2

    const/16 v3, 0x1b

    aget-byte p1, p1, v3

    invoke-static {v0, v1, v2, p1}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/BlipStoreEntry;->referenceCount:I

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
.method dereference()V
    .locals 2

    iget v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->referenceCount:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    iput v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->referenceCount:I

    if-ltz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    return-void
.end method

.method public getBlipType()Ljxl/biff/drawing/BlipType;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->type:Ljxl/biff/drawing/BlipType;

    return-object v0
.end method

.method public getData()[B
    .locals 5

    iget-boolean v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->write:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    iget-object v1, p0, Ljxl/biff/drawing/BlipStoreEntry;->type:Ljxl/biff/drawing/BlipType;

    invoke-virtual {v1}, Ljxl/biff/drawing/BlipType;->getValue()I

    move-result v1

    int-to-byte v1, v1

    const/4 v2, 0x0

    aput-byte v1, v0, v2

    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    iget-object v1, p0, Ljxl/biff/drawing/BlipStoreEntry;->type:Ljxl/biff/drawing/BlipType;

    invoke-virtual {v1}, Ljxl/biff/drawing/BlipType;->getValue()I

    move-result v1

    int-to-byte v1, v1

    const/4 v3, 0x1

    aput-byte v1, v0, v3

    iget v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->imageDataLength:I

    add-int/lit8 v0, v0, 0x8

    add-int/lit8 v0, v0, 0x11

    iget-object v1, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    const/16 v4, 0x14

    invoke-static {v0, v1, v4}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->referenceCount:I

    iget-object v1, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    const/16 v4, 0x18

    invoke-static {v0, v1, v4}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    const/16 v1, 0x1c

    invoke-static {v2, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    const/16 v1, 0x20

    aput-byte v2, v0, v1

    const/16 v1, 0x21

    aput-byte v2, v0, v1

    const/16 v1, 0x22

    const/16 v4, 0x7e

    aput-byte v4, v0, v1

    const/16 v1, 0x23

    aput-byte v3, v0, v1

    const/16 v1, 0x24

    aput-byte v2, v0, v1

    const/16 v1, 0x25

    const/16 v2, 0x6e

    aput-byte v2, v0, v1

    const v1, 0xf01e

    const/16 v2, 0x26

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->imageDataLength:I

    add-int/lit8 v0, v0, 0x11

    iget-object v1, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    const/16 v2, 0x28

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    :goto_0
    iget-object v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->data:[B

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setHeaderData([B)[B

    move-result-object v0

    return-object v0
.end method

.method getImageData()[B
    .locals 5

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object v0

    array-length v1, v0

    const/16 v2, 0x3d

    sub-int/2addr v1, v2

    new-array v3, v1, [B

    const/4 v4, 0x0

    invoke-static {v0, v2, v3, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v3
.end method

.method getReferenceCount()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/BlipStoreEntry;->referenceCount:I

    return v0
.end method
