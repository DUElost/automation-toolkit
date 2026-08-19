.class public final Ljxl/read/biff/CompoundFile;
.super Ljxl/biff/BaseCompoundFile;
.source ""


# static fields
.field static synthetic class$jxl$read$biff$CompoundFile:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private bigBlockChain:[I

.field private bigBlockDepotBlocks:[I

.field private data:[B

.field private extensionBlock:I

.field private numBigBlockDepotBlocks:I

.field private numExtensionBlocks:I

.field private propertySets:Ljava/util/ArrayList;

.field private rootEntry:[B

.field private rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

.field private rootStartBlock:I

.field private sbdStartBlock:I

.field private settings:Ljxl/WorkbookSettings;

.field private smallBlockChain:[I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/read/biff/CompoundFile;->class$jxl$read$biff$CompoundFile:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.CompoundFile"

    invoke-static {v0}, Ljxl/read/biff/CompoundFile;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/CompoundFile;->class$jxl$read$biff$CompoundFile:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>([BLjxl/WorkbookSettings;)V
    .locals 9

    invoke-direct {p0}, Ljxl/biff/BaseCompoundFile;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/CompoundFile;->data:[B

    iput-object p2, p0, Ljxl/read/biff/CompoundFile;->settings:Ljxl/WorkbookSettings;

    const/4 p2, 0x0

    move v0, p2

    :goto_0
    sget-object v1, Ljxl/biff/BaseCompoundFile;->IDENTIFIER:[B

    array-length v2, v1

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Ljxl/read/biff/CompoundFile;->data:[B

    aget-byte v2, v2, v0

    aget-byte v1, v1, v0

    if-ne v2, v1, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    new-instance p1, Ljxl/read/biff/BiffException;

    sget-object p2, Ljxl/read/biff/BiffException;->unrecognizedOLEFile:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {p1, p2}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw p1

    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ljxl/read/biff/CompoundFile;->propertySets:Ljava/util/ArrayList;

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->data:[B

    const/16 v1, 0x2c

    aget-byte v1, v0, v1

    const/16 v2, 0x2d

    aget-byte v2, v0, v2

    const/16 v3, 0x2e

    aget-byte v3, v0, v3

    const/16 v4, 0x2f

    aget-byte v0, v0, v4

    invoke-static {v1, v2, v3, v0}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/CompoundFile;->numBigBlockDepotBlocks:I

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->data:[B

    const/16 v1, 0x3c

    aget-byte v1, v0, v1

    const/16 v2, 0x3d

    aget-byte v2, v0, v2

    const/16 v3, 0x3e

    aget-byte v3, v0, v3

    const/16 v4, 0x3f

    aget-byte v0, v0, v4

    invoke-static {v1, v2, v3, v0}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/CompoundFile;->sbdStartBlock:I

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->data:[B

    const/16 v1, 0x30

    aget-byte v1, v0, v1

    const/16 v2, 0x31

    aget-byte v2, v0, v2

    const/16 v3, 0x32

    aget-byte v3, v0, v3

    const/16 v4, 0x33

    aget-byte v0, v0, v4

    invoke-static {v1, v2, v3, v0}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/CompoundFile;->rootStartBlock:I

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->data:[B

    const/16 v1, 0x44

    aget-byte v1, v0, v1

    const/16 v2, 0x45

    aget-byte v2, v0, v2

    const/16 v3, 0x46

    aget-byte v3, v0, v3

    const/16 v4, 0x47

    aget-byte v0, v0, v4

    invoke-static {v1, v2, v3, v0}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/CompoundFile;->extensionBlock:I

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->data:[B

    const/16 v1, 0x48

    aget-byte v1, v0, v1

    const/16 v2, 0x49

    aget-byte v2, v0, v2

    const/16 v3, 0x4a

    aget-byte v3, v0, v3

    const/16 v4, 0x4b

    aget-byte v0, v0, v4

    invoke-static {v1, v2, v3, v0}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/CompoundFile;->numExtensionBlocks:I

    iget v1, p0, Ljxl/read/biff/CompoundFile;->numBigBlockDepotBlocks:I

    new-array v2, v1, [I

    iput-object v2, p0, Ljxl/read/biff/CompoundFile;->bigBlockDepotBlocks:[I

    const/16 v2, 0x4c

    if-eqz v0, :cond_2

    const/16 v1, 0x6d

    :cond_2
    move v0, p2

    :goto_1
    if-ge v0, v1, :cond_3

    iget-object v3, p0, Ljxl/read/biff/CompoundFile;->bigBlockDepotBlocks:[I

    aget-byte v4, p1, v2

    add-int/lit8 v5, v2, 0x1

    aget-byte v5, p1, v5

    add-int/lit8 v6, v2, 0x2

    aget-byte v6, p1, v6

    add-int/lit8 v7, v2, 0x3

    aget-byte v7, p1, v7

    invoke-static {v4, v5, v6, v7}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v4

    aput v4, v3, v0

    add-int/lit8 v2, v2, 0x4

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    :goto_2
    iget v0, p0, Ljxl/read/biff/CompoundFile;->numExtensionBlocks:I

    if-ge p2, v0, :cond_6

    iget v0, p0, Ljxl/read/biff/CompoundFile;->extensionBlock:I

    add-int/lit8 v0, v0, 0x1

    mul-int/lit16 v0, v0, 0x200

    iget v2, p0, Ljxl/read/biff/CompoundFile;->numBigBlockDepotBlocks:I

    sub-int/2addr v2, v1

    const/16 v3, 0x7f

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    move v3, v1

    :goto_3
    add-int v4, v1, v2

    if-ge v3, v4, :cond_4

    iget-object v4, p0, Ljxl/read/biff/CompoundFile;->bigBlockDepotBlocks:[I

    aget-byte v5, p1, v0

    add-int/lit8 v6, v0, 0x1

    aget-byte v6, p1, v6

    add-int/lit8 v7, v0, 0x2

    aget-byte v7, p1, v7

    add-int/lit8 v8, v0, 0x3

    aget-byte v8, p1, v8

    invoke-static {v5, v6, v7, v8}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v5

    aput v5, v4, v3

    add-int/lit8 v0, v0, 0x4

    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    :cond_4
    iget v1, p0, Ljxl/read/biff/CompoundFile;->numBigBlockDepotBlocks:I

    if-ge v4, v1, :cond_5

    aget-byte v1, p1, v0

    add-int/lit8 v2, v0, 0x1

    aget-byte v2, p1, v2

    add-int/lit8 v3, v0, 0x2

    aget-byte v3, p1, v3

    add-int/lit8 v0, v0, 0x3

    aget-byte v0, p1, v0

    invoke-static {v1, v2, v3, v0}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/CompoundFile;->extensionBlock:I

    :cond_5
    add-int/lit8 p2, p2, 0x1

    move v1, v4

    goto :goto_2

    :cond_6
    invoke-direct {p0}, Ljxl/read/biff/CompoundFile;->readBigBlockDepot()V

    invoke-direct {p0}, Ljxl/read/biff/CompoundFile;->readSmallBlockDepot()V

    iget p1, p0, Ljxl/read/biff/CompoundFile;->rootStartBlock:I

    invoke-direct {p0, p1}, Ljxl/read/biff/CompoundFile;->readData(I)[B

    move-result-object p1

    iput-object p1, p0, Ljxl/read/biff/CompoundFile;->rootEntry:[B

    invoke-direct {p0}, Ljxl/read/biff/CompoundFile;->readPropertySets()V

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

.method private findPropertyStorage(Ljava/lang/String;Ljxl/biff/BaseCompoundFile$PropertyStorage;)Ljxl/biff/BaseCompoundFile$PropertyStorage;
    .locals 3

    iget p2, p2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->child:I

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-direct {p0, p2}, Ljxl/read/biff/CompoundFile;->getPropertyStorage(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object p2

    iget-object v1, p2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    return-object p2

    :cond_1
    move-object v1, p2

    :cond_2
    iget v1, v1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->previous:I

    if-eq v1, v0, :cond_3

    invoke-direct {p0, v1}, Ljxl/read/biff/CompoundFile;->getPropertyStorage(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object v1

    iget-object v2, v1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    return-object v1

    :cond_3
    move-object v1, p2

    :cond_4
    iget v1, v1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->next:I

    if-eq v1, v0, :cond_5

    invoke-direct {p0, v1}, Ljxl/read/biff/CompoundFile;->getPropertyStorage(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object v1

    iget-object v2, v1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    return-object v1

    :cond_5
    invoke-direct {p0, p1, p2}, Ljxl/read/biff/CompoundFile;->findPropertyStorage(Ljava/lang/String;Ljxl/biff/BaseCompoundFile$PropertyStorage;)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object p1

    return-object p1
.end method

.method private getBigBlockStream(Ljxl/biff/BaseCompoundFile$PropertyStorage;)[B
    .locals 7

    iget v0, p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    div-int/lit16 v1, v0, 0x200

    const/16 v2, 0x200

    rem-int/2addr v0, v2

    if-eqz v0, :cond_0

    add-int/lit8 v1, v1, 0x1

    :cond_0
    mul-int/lit16 v0, v1, 0x200

    new-array v0, v0, [B

    iget p1, p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->startBlock:I

    const/4 v3, 0x0

    :goto_0
    const/4 v4, -0x2

    if-eq p1, v4, :cond_1

    if-ge v3, v1, :cond_1

    add-int/lit8 v4, p1, 0x1

    mul-int/2addr v4, v2

    iget-object v5, p0, Ljxl/read/biff/CompoundFile;->data:[B

    mul-int/lit16 v6, v3, 0x200

    invoke-static {v5, v4, v0, v6, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v3, v3, 0x1

    iget-object v4, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    aget p1, v4, p1

    goto :goto_0

    :cond_1
    if-eq p1, v4, :cond_2

    if-ne v3, v1, :cond_2

    sget-object p1, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    const-string v1, "Property storage size inconsistent with block chain."

    invoke-virtual {p1, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_2
    return-object v0
.end method

.method private getPropertyStorage(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->propertySets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    return-object p1
.end method

.method private getPropertyStorage(Ljava/lang/String;)Ljxl/biff/BaseCompoundFile$PropertyStorage;
    .locals 8

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->propertySets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    move v3, v1

    move v4, v3

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget-object v6, v5, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {v6, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    const/4 v7, 0x1

    if-eqz v6, :cond_0

    if-ne v4, v7, :cond_1

    move v3, v7

    goto :goto_1

    :cond_1
    move v3, v1

    :goto_1
    move-object v2, v5

    move v4, v7

    goto :goto_0

    :cond_2
    if-eqz v3, :cond_3

    sget-object v0, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "found multiple copies of property set "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_3
    if-eqz v4, :cond_4

    return-object v2

    :cond_4
    new-instance p1, Ljxl/read/biff/BiffException;

    sget-object v0, Ljxl/read/biff/BiffException;->streamNotFound:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {p1, v0}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw p1
.end method

.method private getSmallBlockStream(Ljxl/biff/BaseCompoundFile$PropertyStorage;)[B
    .locals 9

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v0, v0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->startBlock:I

    invoke-direct {p0, v0}, Ljxl/read/biff/CompoundFile;->readData(I)[B

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [B

    iget v3, p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->startBlock:I

    move v4, v1

    :goto_0
    iget-object v5, p0, Ljxl/read/biff/CompoundFile;->smallBlockChain:[I

    array-length v6, v5

    if-gt v4, v6, :cond_1

    const/4 v6, -0x2

    if-eq v3, v6, :cond_1

    array-length v5, v2

    const/16 v7, 0x40

    add-int/2addr v5, v7

    new-array v5, v5, [B

    array-length v8, v2

    invoke-static {v2, v1, v5, v1, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    mul-int/lit8 v8, v3, 0x40

    array-length v2, v2

    invoke-static {v0, v8, v5, v2, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v2, p0, Ljxl/read/biff/CompoundFile;->smallBlockChain:[I

    aget v2, v2, v3

    const/4 v3, -0x1

    if-ne v2, v3, :cond_0

    sget-object v2, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v7, "Incorrect terminator for small block stream "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v7, p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {v3, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    move v3, v6

    goto :goto_1

    :cond_0
    move v3, v2

    :goto_1
    add-int/lit8 v4, v4, 0x1

    move-object v2, v5

    goto :goto_0

    :cond_1
    array-length p1, v5

    if-gt v4, p1, :cond_2

    return-object v2

    :cond_2
    new-instance p1, Ljxl/read/biff/BiffException;

    sget-object v0, Ljxl/read/biff/BiffException;->corruptFileFormat:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {p1, v0}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw p1
.end method

.method private readBigBlockDepot()V
    .locals 11

    iget v0, p0, Ljxl/read/biff/CompoundFile;->numBigBlockDepotBlocks:I

    mul-int/lit16 v0, v0, 0x200

    div-int/lit8 v0, v0, 0x4

    new-array v0, v0, [I

    iput-object v0, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    const/4 v0, 0x0

    move v1, v0

    move v2, v1

    :goto_0
    iget v3, p0, Ljxl/read/biff/CompoundFile;->numBigBlockDepotBlocks:I

    if-ge v1, v3, :cond_1

    iget-object v3, p0, Ljxl/read/biff/CompoundFile;->bigBlockDepotBlocks:[I

    aget v3, v3, v1

    add-int/lit8 v3, v3, 0x1

    mul-int/lit16 v3, v3, 0x200

    move v4, v0

    :goto_1
    const/16 v5, 0x80

    if-ge v4, v5, :cond_0

    iget-object v5, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    iget-object v6, p0, Ljxl/read/biff/CompoundFile;->data:[B

    aget-byte v7, v6, v3

    add-int/lit8 v8, v3, 0x1

    aget-byte v8, v6, v8

    add-int/lit8 v9, v3, 0x2

    aget-byte v9, v6, v9

    add-int/lit8 v10, v3, 0x3

    aget-byte v6, v6, v10

    invoke-static {v7, v8, v9, v6}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v6

    aput v6, v5, v2

    add-int/lit8 v3, v3, 0x4

    add-int/lit8 v2, v2, 0x1

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method private readData(I)[B
    .locals 7

    const/4 v0, 0x0

    new-array v1, v0, [B

    move v2, v0

    :goto_0
    iget-object v3, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    array-length v4, v3

    if-gt v2, v4, :cond_1

    const/4 v4, -0x2

    if-eq p1, v4, :cond_1

    array-length v3, v1

    const/16 v4, 0x200

    add-int/2addr v3, v4

    new-array v3, v3, [B

    array-length v5, v1

    invoke-static {v1, v0, v3, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v5, p1, 0x1

    mul-int/2addr v5, v4

    iget-object v6, p0, Ljxl/read/biff/CompoundFile;->data:[B

    array-length v1, v1

    invoke-static {v6, v5, v3, v1, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v1, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    aget v4, v1, p1

    if-eq v4, p1, :cond_0

    aget p1, v1, p1

    add-int/lit8 v2, v2, 0x1

    move-object v1, v3

    goto :goto_0

    :cond_0
    new-instance p1, Ljxl/read/biff/BiffException;

    sget-object v0, Ljxl/read/biff/BiffException;->corruptFileFormat:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {p1, v0}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw p1

    :cond_1
    array-length p1, v3

    if-gt v2, p1, :cond_2

    return-object v1

    :cond_2
    new-instance p1, Ljxl/read/biff/BiffException;

    sget-object v0, Ljxl/read/biff/BiffException;->corruptFileFormat:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {p1, v0}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw p1
.end method

.method private readPropertySets()V
    .locals 7

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p0, Ljxl/read/biff/CompoundFile;->rootEntry:[B

    array-length v3, v2

    if-ge v1, v3, :cond_4

    const/16 v3, 0x80

    new-array v4, v3, [B

    invoke-static {v2, v1, v4, v0, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    invoke-direct {v2, p0, v4}, Ljxl/biff/BaseCompoundFile$PropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile;[B)V

    iget-object v3, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    const-string v4, "Root Entry"

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_2

    :cond_0
    iget v3, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    const/4 v5, 0x5

    if-ne v3, v5, :cond_1

    iput-object v4, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    sget-object v3, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    const-string v6, "Property storage name for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v6, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v6, " is empty - setting to "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :goto_1
    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :cond_1
    iget v3, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    if-eqz v3, :cond_2

    sget-object v3, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    const-string v6, "Property storage type "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v6, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v6, " is non-empty and has no associated name"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_1

    :cond_2
    :goto_2
    iget-object v3, p0, Ljxl/read/biff/CompoundFile;->propertySets:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v3, v2, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    iput-object v2, p0, Ljxl/read/biff/CompoundFile;->rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    :cond_3
    add-int/lit16 v1, v1, 0x80

    goto :goto_0

    :cond_4
    iget-object v1, p0, Ljxl/read/biff/CompoundFile;->rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    if-nez v1, :cond_5

    iget-object v1, p0, Ljxl/read/biff/CompoundFile;->propertySets:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iput-object v0, p0, Ljxl/read/biff/CompoundFile;->rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    :cond_5
    return-void
.end method

.method private readSmallBlockDepot()V
    .locals 13

    iget v0, p0, Ljxl/read/biff/CompoundFile;->sbdStartBlock:I

    const/4 v1, 0x0

    new-array v2, v1, [I

    iput-object v2, p0, Ljxl/read/biff/CompoundFile;->smallBlockChain:[I

    const/4 v2, -0x1

    if-ne v0, v2, :cond_0

    sget-object v0, Ljxl/read/biff/CompoundFile;->logger:Ljxl/common/Logger;

    const-string v1, "invalid small block depot number"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return-void

    :cond_0
    move v2, v1

    move v3, v2

    :goto_0
    iget-object v4, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    array-length v5, v4

    if-gt v2, v5, :cond_2

    const/4 v5, -0x2

    if-eq v0, v5, :cond_2

    iget-object v4, p0, Ljxl/read/biff/CompoundFile;->smallBlockChain:[I

    array-length v5, v4

    const/16 v6, 0x80

    add-int/2addr v5, v6

    new-array v5, v5, [I

    iput-object v5, p0, Ljxl/read/biff/CompoundFile;->smallBlockChain:[I

    array-length v7, v4

    invoke-static {v4, v1, v5, v1, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v4, v0, 0x1

    mul-int/lit16 v4, v4, 0x200

    move v5, v1

    :goto_1
    if-ge v5, v6, :cond_1

    iget-object v7, p0, Ljxl/read/biff/CompoundFile;->smallBlockChain:[I

    iget-object v8, p0, Ljxl/read/biff/CompoundFile;->data:[B

    aget-byte v9, v8, v4

    add-int/lit8 v10, v4, 0x1

    aget-byte v10, v8, v10

    add-int/lit8 v11, v4, 0x2

    aget-byte v11, v8, v11

    add-int/lit8 v12, v4, 0x3

    aget-byte v8, v8, v12

    invoke-static {v9, v10, v11, v8}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v8

    aput v8, v7, v3

    add-int/lit8 v4, v4, 0x4

    add-int/lit8 v3, v3, 0x1

    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_1
    iget-object v4, p0, Ljxl/read/biff/CompoundFile;->bigBlockChain:[I

    aget v0, v4, v0

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    array-length v0, v4

    if-gt v2, v0, :cond_3

    return-void

    :cond_3
    new-instance v0, Ljxl/read/biff/BiffException;

    sget-object v1, Ljxl/read/biff/BiffException;->corruptFileFormat:Ljxl/read/biff/BiffException$BiffMessage;

    invoke-direct {v0, v1}, Ljxl/read/biff/BiffException;-><init>(Ljxl/read/biff/BiffException$BiffMessage;)V

    throw v0
.end method


# virtual methods
.method public findPropertyStorage(Ljava/lang/String;)Ljxl/biff/BaseCompoundFile$PropertyStorage;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    invoke-direct {p0, p1, v0}, Ljxl/read/biff/CompoundFile;->findPropertyStorage(Ljava/lang/String;Ljxl/biff/BaseCompoundFile$PropertyStorage;)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object p1

    return-object p1
.end method

.method public getNumberOfPropertySets()I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->propertySets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getPropertySet(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;
    .locals 0

    invoke-direct {p0, p1}, Ljxl/read/biff/CompoundFile;->getPropertyStorage(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object p1

    return-object p1
.end method

.method public getStream(I)[B
    .locals 2

    invoke-direct {p0, p1}, Ljxl/read/biff/CompoundFile;->getPropertyStorage(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object p1

    iget v0, p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    const/16 v1, 0x1000

    if-ge v0, v1, :cond_1

    iget-object v0, p1, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    const-string v1, "Root Entry"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1}, Ljxl/read/biff/CompoundFile;->getSmallBlockStream(Ljxl/biff/BaseCompoundFile$PropertyStorage;)[B

    move-result-object p1

    return-object p1

    :cond_1
    :goto_0
    invoke-direct {p0, p1}, Ljxl/read/biff/CompoundFile;->getBigBlockStream(Ljxl/biff/BaseCompoundFile$PropertyStorage;)[B

    move-result-object p1

    return-object p1
.end method

.method public getStream(Ljava/lang/String;)[B
    .locals 3

    iget-object v0, p0, Ljxl/read/biff/CompoundFile;->rootEntryPropertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    invoke-direct {p0, p1, v0}, Ljxl/read/biff/CompoundFile;->findPropertyStorage(Ljava/lang/String;Ljxl/biff/BaseCompoundFile$PropertyStorage;)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-direct {p0, p1}, Ljxl/read/biff/CompoundFile;->getPropertyStorage(Ljava/lang/String;)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object v0

    :cond_0
    iget v1, v0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    const/16 v2, 0x1000

    if-ge v1, v2, :cond_2

    const-string v1, "Root Entry"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    invoke-direct {p0, v0}, Ljxl/read/biff/CompoundFile;->getSmallBlockStream(Ljxl/biff/BaseCompoundFile$PropertyStorage;)[B

    move-result-object p1

    return-object p1

    :cond_2
    :goto_0
    invoke-direct {p0, v0}, Ljxl/read/biff/CompoundFile;->getBigBlockStream(Ljxl/biff/BaseCompoundFile$PropertyStorage;)[B

    move-result-object p1

    return-object p1
.end method
