.class final Ljxl/write/biff/CompoundFile;
.super Ljxl/biff/BaseCompoundFile;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/write/biff/CompoundFile$ReadPropertyStorage;
    }
.end annotation


# static fields
.field static synthetic class$jxl$write$biff$CompoundFile:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private additionalPropertyBlocks:I

.field private additionalPropertySets:Ljava/util/ArrayList;

.field private bbdPos:I

.field private bbdStartBlock:I

.field private bigBlockDepot:[B

.field private excelData:Ljxl/write/biff/ExcelDataOutput;

.field private excelDataBlocks:I

.field private excelDataStartBlock:I

.field private extensionBlock:I

.field private numBigBlockDepotBlocks:I

.field private numExtensionBlocks:I

.field private numPropertySets:I

.field private numRootEntryBlocks:I

.field private numSmallBlockDepotBlocks:I

.field private numSmallBlockDepotChainBlocks:I

.field private numSmallBlocks:I

.field private out:Ljava/io/OutputStream;

.field private requiredSize:I

.field private rootStartBlock:I

.field private sbdStartBlock:I

.field private sbdStartBlockChain:I

.field private size:I

.field private standardPropertySets:Ljava/util/HashMap;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/CompoundFile;->class$jxl$write$biff$CompoundFile:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.CompoundFile"

    invoke-static {v0}, Ljxl/write/biff/CompoundFile;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/CompoundFile;->class$jxl$write$biff$CompoundFile:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/CompoundFile;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/write/biff/ExcelDataOutput;ILjava/io/OutputStream;Ljxl/read/biff/CompoundFile;)V
    .locals 7

    invoke-direct {p0}, Ljxl/biff/BaseCompoundFile;-><init>()V

    iput p2, p0, Ljxl/write/biff/CompoundFile;->size:I

    iput-object p1, p0, Ljxl/write/biff/CompoundFile;->excelData:Ljxl/write/biff/ExcelDataOutput;

    invoke-direct {p0, p4}, Ljxl/write/biff/CompoundFile;->readAdditionalPropertySets(Ljxl/read/biff/CompoundFile;)V

    const/4 p1, 0x1

    iput p1, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    iget-object p4, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    const/4 v0, 0x0

    if-eqz p4, :cond_0

    invoke-virtual {p4}, Ljava/util/ArrayList;->size()I

    move-result p4

    goto :goto_0

    :cond_0
    move p4, v0

    :goto_0
    add-int/lit8 p4, p4, 0x4

    iput p4, p0, Ljxl/write/biff/CompoundFile;->numPropertySets:I

    iget-object p4, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-eqz p4, :cond_1

    iget p4, p0, Ljxl/write/biff/CompoundFile;->numSmallBlocks:I

    mul-int/lit8 p4, p4, 0x4

    invoke-direct {p0, p4}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result p4

    iput p4, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotChainBlocks:I

    iget p4, p0, Ljxl/write/biff/CompoundFile;->numSmallBlocks:I

    mul-int/lit8 p4, p4, 0x40

    invoke-direct {p0, p4}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result p4

    iput p4, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotBlocks:I

    iget p4, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    mul-int/lit16 v1, v1, 0x80

    invoke-direct {p0, v1}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v1

    add-int/2addr p4, v1

    iput p4, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    :cond_1
    invoke-direct {p0, p2}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result p4

    const/16 v1, 0x1000

    if-ge p2, v1, :cond_2

    iput v1, p0, Ljxl/write/biff/CompoundFile;->requiredSize:I

    goto :goto_1

    :cond_2
    mul-int/lit16 p4, p4, 0x200

    iput p4, p0, Ljxl/write/biff/CompoundFile;->requiredSize:I

    :goto_1
    iput-object p3, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    iget p2, p0, Ljxl/write/biff/CompoundFile;->requiredSize:I

    div-int/lit16 p2, p2, 0x200

    iput p2, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    iput p1, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    add-int/lit8 p2, p2, 0x8

    add-int/lit8 p2, p2, 0x8

    iget p3, p0, Ljxl/write/biff/CompoundFile;->additionalPropertyBlocks:I

    add-int/2addr p2, p3

    iget p3, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotBlocks:I

    add-int/2addr p2, p3

    iget p3, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotChainBlocks:I

    add-int/2addr p2, p3

    iget p3, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    add-int/2addr p2, p3

    add-int/lit8 p3, p2, 0x1

    int-to-double p3, p3

    const-wide/high16 v1, 0x4060000000000000L    # 128.0

    div-double/2addr p3, v1

    invoke-static {p3, p4}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p3

    double-to-int p3, p3

    iput p3, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    add-int/2addr p3, p2

    int-to-double p3, p3

    div-double/2addr p3, v1

    invoke-static {p3, p4}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p3

    double-to-int p3, p3

    iput p3, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    add-int p4, p2, p3

    const/16 v3, 0x6c

    const/4 v4, -0x2

    if-le p3, v3, :cond_3

    iput v0, p0, Ljxl/write/biff/CompoundFile;->extensionBlock:I

    add-int/lit8 p3, p3, -0x6d

    add-int/2addr p3, p1

    int-to-double p3, p3

    const-wide v5, 0x405fc00000000000L    # 127.0

    div-double/2addr p3, v5

    invoke-static {p3, p4}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p3

    double-to-int p1, p3

    iput p1, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    add-int/2addr p1, p2

    iget p3, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    add-int/2addr p1, p3

    int-to-double p3, p1

    div-double/2addr p3, v1

    invoke-static {p3, p4}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p3

    double-to-int p1, p3

    iput p1, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    iget p3, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    add-int/2addr p2, p3

    add-int p4, p2, p1

    goto :goto_2

    :cond_3
    iput v4, p0, Ljxl/write/biff/CompoundFile;->extensionBlock:I

    iput v0, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    :goto_2
    iget p1, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    iput p1, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iput v4, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlock:I

    iget-object p2, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-eqz p2, :cond_4

    iget p2, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotBlocks:I

    if-eqz p2, :cond_4

    iget p2, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr p2, p1

    iget p3, p0, Ljxl/write/biff/CompoundFile;->additionalPropertyBlocks:I

    add-int/2addr p2, p3

    add-int/lit8 p2, p2, 0x10

    iput p2, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlock:I

    :cond_4
    iput v4, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlockChain:I

    iget p2, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlock:I

    if-eq p2, v4, :cond_5

    iget p3, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotBlocks:I

    add-int/2addr p2, p3

    iput p2, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlockChain:I

    :cond_5
    iget p2, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlockChain:I

    if-eq p2, v4, :cond_6

    iget p1, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotChainBlocks:I

    add-int/2addr p2, p1

    iput p2, p0, Ljxl/write/biff/CompoundFile;->bbdStartBlock:I

    goto :goto_3

    :cond_6
    iget p2, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr p1, p2

    iget p2, p0, Ljxl/write/biff/CompoundFile;->additionalPropertyBlocks:I

    add-int/2addr p1, p2

    add-int/lit8 p1, p1, 0x10

    iput p1, p0, Ljxl/write/biff/CompoundFile;->bbdStartBlock:I

    :goto_3
    iget p1, p0, Ljxl/write/biff/CompoundFile;->bbdStartBlock:I

    iget p2, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    add-int/2addr p1, p2

    iput p1, p0, Ljxl/write/biff/CompoundFile;->rootStartBlock:I

    iget p2, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    add-int/2addr p1, p2

    if-eq p4, p1, :cond_7

    sget-object p1, Ljxl/write/biff/CompoundFile;->logger:Ljxl/common/Logger;

    const-string p2, "Root start block and total blocks are inconsistent  generated file may be corrupt"

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    sget-object p1, Ljxl/write/biff/CompoundFile;->logger:Ljxl/common/Logger;

    new-instance p2, Ljava/lang/StringBuffer;

    invoke-direct {p2}, Ljava/lang/StringBuffer;-><init>()V

    const-string p3, "RootStartBlock "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget p3, p0, Ljxl/write/biff/CompoundFile;->rootStartBlock:I

    invoke-virtual {p2, p3}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string p3, " totalBlocks "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p2, p4}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {p2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_7
    return-void
.end method

.method private checkBbdPos()V
    .locals 3

    iget v0, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    const/16 v1, 0x200

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    invoke-virtual {v0, v2}, Ljava/io/OutputStream;->write([B)V

    new-array v0, v1, [B

    iput-object v0, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    const/4 v0, 0x0

    iput v0, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    :cond_0
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

.method private getBigBlocksRequired(I)I
    .locals 1

    div-int/lit16 v0, p1, 0x200

    rem-int/lit16 p1, p1, 0x200

    if-lez p1, :cond_0

    add-int/lit8 v0, v0, 0x1

    :cond_0
    return v0
.end method

.method private getSmallBlocksRequired(I)I
    .locals 1

    div-int/lit8 v0, p1, 0x40

    rem-int/lit8 p1, p1, 0x40

    if-lez p1, :cond_0

    add-int/lit8 v0, v0, 0x1

    :cond_0
    return v0
.end method

.method private readAdditionalPropertySets(Ljxl/read/biff/CompoundFile;)V
    .locals 12

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    invoke-virtual {p1}, Ljxl/read/biff/CompoundFile;->getNumberOfPropertySets()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    move v3, v2

    :goto_0
    if-ge v2, v0, :cond_8

    invoke-virtual {p1, v2}, Ljxl/read/biff/CompoundFile;->getPropertySet(I)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object v4

    iget-object v5, v4, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    const-string v6, "Root Entry"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-eqz v5, :cond_1

    new-instance v5, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    invoke-direct {v5, v4, v7, v2}, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile$PropertyStorage;[BI)V

    iget-object v9, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    invoke-virtual {v9, v6, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move v5, v8

    goto :goto_1

    :cond_1
    move v5, v1

    :goto_1
    move v6, v1

    :goto_2
    sget-object v9, Ljxl/biff/BaseCompoundFile;->STANDARD_PROPERTY_SETS:[Ljava/lang/String;

    array-length v10, v9

    if-ge v6, v10, :cond_4

    if-nez v5, :cond_4

    iget-object v10, v4, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    aget-object v11, v9, v6

    invoke-virtual {v10, v11}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3

    iget-object v10, v4, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-virtual {p1, v10}, Ljxl/read/biff/CompoundFile;->findPropertyStorage(Ljava/lang/String;)Ljxl/biff/BaseCompoundFile$PropertyStorage;

    move-result-object v10

    if-eqz v10, :cond_2

    move v11, v8

    goto :goto_3

    :cond_2
    move v11, v1

    :goto_3
    invoke-static {v11}, Ljxl/common/Assert;->verify(Z)V

    if-ne v10, v4, :cond_3

    new-instance v5, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    invoke-direct {v5, v4, v7, v2}, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile$PropertyStorage;[BI)V

    iget-object v10, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    aget-object v9, v9, v6

    invoke-virtual {v10, v9, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move v5, v8

    :cond_3
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    :cond_4
    if-nez v5, :cond_7

    :try_start_0
    iget v5, v4, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    if-lez v5, :cond_5

    invoke-virtual {p1, v2}, Ljxl/read/biff/CompoundFile;->getStream(I)[B

    move-result-object v5

    goto :goto_4

    :cond_5
    new-array v5, v1, [B

    :goto_4
    new-instance v6, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    invoke-direct {v6, v4, v5, v2}, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile$PropertyStorage;[BI)V

    iget-object v4, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    array-length v4, v5

    const/16 v6, 0x1000

    if-le v4, v6, :cond_6

    array-length v4, v5

    invoke-direct {p0, v4}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v4

    add-int/2addr v3, v4

    goto :goto_5

    :cond_6
    array-length v4, v5

    invoke-direct {p0, v4}, Ljxl/write/biff/CompoundFile;->getSmallBlocksRequired(I)I

    move-result v4

    iget v5, p0, Ljxl/write/biff/CompoundFile;->numSmallBlocks:I

    add-int/2addr v5, v4

    iput v5, p0, Ljxl/write/biff/CompoundFile;->numSmallBlocks:I
    :try_end_0
    .catch Ljxl/read/biff/BiffException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_5

    :catch_0
    move-exception p1

    sget-object v0, Ljxl/write/biff/CompoundFile;->logger:Ljxl/common/Logger;

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->error(Ljava/lang/Object;)V

    new-instance p1, Ljxl/write/biff/CopyAdditionalPropertySetsException;

    invoke-direct {p1}, Ljxl/write/biff/CopyAdditionalPropertySetsException;-><init>()V

    throw p1

    :cond_7
    :goto_5
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    :cond_8
    iput v3, p0, Ljxl/write/biff/CompoundFile;->additionalPropertyBlocks:I

    return-void
.end method

.method private writeAdditionalPropertySetBlockChains()V
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iget v2, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x10

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v2, v2, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v3, v2

    const/16 v4, 0x1000

    if-le v3, v4, :cond_1

    array-length v2, v2

    invoke-direct {p0, v2}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v2

    invoke-direct {p0, v1, v2}, Ljxl/write/biff/CompoundFile;->writeBlockChain(II)V

    add-int/2addr v1, v2

    goto :goto_0

    :cond_2
    return-void
.end method

.method private writeAdditionalPropertySets()V
    .locals 6

    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v1, v1, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v2, v1

    const/16 v3, 0x1000

    if-le v2, v3, :cond_1

    array-length v2, v1

    invoke-direct {p0, v2}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v2

    mul-int/lit16 v2, v2, 0x200

    iget-object v3, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    array-length v4, v1

    const/4 v5, 0x0

    invoke-virtual {v3, v1, v5, v4}, Ljava/io/OutputStream;->write([BII)V

    array-length v1, v1

    sub-int/2addr v2, v1

    new-array v1, v2, [B

    iget-object v3, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v3, v1, v5, v2}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method private writeBigBlockDepot()V
    .locals 8

    const/16 v0, 0x200

    new-array v1, v0, [B

    iput-object v1, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    const/4 v1, 0x0

    iput v1, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    move v2, v1

    :goto_0
    iget v3, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    const/4 v4, -0x3

    if-ge v2, v3, :cond_0

    iget-object v3, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v5, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {v4, v3, v5}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v3, v3, 0x4

    iput v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iget v2, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iget v3, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    invoke-direct {p0, v2, v3}, Ljxl/write/biff/CompoundFile;->writeBlockChain(II)V

    iget v2, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iget v3, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr v2, v3

    iget v3, p0, Ljxl/write/biff/CompoundFile;->additionalPropertyBlocks:I

    add-int/2addr v2, v3

    move v3, v2

    :goto_1
    add-int/lit8 v5, v2, 0x7

    if-ge v3, v5, :cond_1

    add-int/lit8 v3, v3, 0x1

    iget-object v5, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v6, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {v3, v5, v6}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v5, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v5, v5, 0x4

    iput v5, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    goto :goto_1

    :cond_1
    iget-object v3, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v5, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    const/4 v6, -0x2

    invoke-static {v6, v3, v5}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v3, v3, 0x4

    iput v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    add-int/lit8 v3, v2, 0x8

    :goto_2
    add-int/lit8 v5, v2, 0xf

    if-ge v3, v5, :cond_2

    add-int/lit8 v3, v3, 0x1

    iget-object v5, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v7, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {v3, v5, v7}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v5, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v5, v5, 0x4

    iput v5, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    goto :goto_2

    :cond_2
    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {v6, v2, v3}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v2, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v2, v2, 0x4

    iput v2, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeAdditionalPropertySetBlockChains()V

    iget v2, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlock:I

    if-eq v2, v6, :cond_3

    iget v3, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotBlocks:I

    invoke-direct {p0, v2, v3}, Ljxl/write/biff/CompoundFile;->writeBlockChain(II)V

    iget v2, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlockChain:I

    iget v3, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotChainBlocks:I

    invoke-direct {p0, v2, v3}, Ljxl/write/biff/CompoundFile;->writeBlockChain(II)V

    :cond_3
    :goto_3
    iget v2, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    if-ge v1, v2, :cond_4

    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {v4, v2, v3}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v2, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v2, v2, 0x4

    iput v2, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_4
    iget v1, p0, Ljxl/write/biff/CompoundFile;->rootStartBlock:I

    iget v2, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    invoke-direct {p0, v1, v2}, Ljxl/write/biff/CompoundFile;->writeBlockChain(II)V

    iget v1, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    if-eqz v1, :cond_6

    :goto_4
    if-ge v1, v0, :cond_5

    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    const/4 v3, -0x1

    aput-byte v3, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_5
    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    :cond_6
    return-void
.end method

.method private writeBlockChain(II)V
    .locals 4

    add-int/lit8 p2, p2, -0x1

    add-int/lit8 p1, p1, 0x1

    :goto_0
    if-lez p2, :cond_1

    iget v0, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    rsub-int v0, v0, 0x200

    div-int/lit8 v0, v0, 0x4

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    :goto_1
    if-ge v1, v0, :cond_0

    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v3, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {p1, v2, v3}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v2, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 v2, v2, 0x4

    iput v2, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 p1, p1, 0x1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_0
    sub-int/2addr p2, v0

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    goto :goto_0

    :cond_1
    const/4 p1, -0x2

    iget-object p2, p0, Ljxl/write/biff/CompoundFile;->bigBlockDepot:[B

    iget v0, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-static {p1, p2, v0}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget p1, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    add-int/lit8 p1, p1, 0x4

    iput p1, p0, Ljxl/write/biff/CompoundFile;->bbdPos:I

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->checkBbdPos()V

    return-void
.end method

.method private writeDocumentSummaryData()V
    .locals 2

    const/16 v0, 0x1000

    new-array v0, v0, [B

    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method private writeExcelData()V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->excelData:Ljxl/write/biff/ExcelDataOutput;

    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-interface {v0, v1}, Ljxl/write/biff/ExcelDataOutput;->writeData(Ljava/io/OutputStream;)V

    iget v0, p0, Ljxl/write/biff/CompoundFile;->requiredSize:I

    iget v1, p0, Ljxl/write/biff/CompoundFile;->size:I

    sub-int/2addr v0, v1

    new-array v0, v0, [B

    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method private writeHeader()V
    .locals 12

    const/16 v0, 0x200

    new-array v1, v0, [B

    iget v2, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    mul-int/2addr v2, v0

    new-array v3, v2, [B

    sget-object v4, Ljxl/biff/BaseCompoundFile;->IDENTIFIER:[B

    array-length v5, v4

    const/4 v6, 0x0

    invoke-static {v4, v6, v1, v6, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/16 v4, 0x18

    const/16 v5, 0x3e

    aput-byte v5, v1, v4

    const/16 v4, 0x1a

    const/4 v5, 0x3

    aput-byte v5, v1, v4

    const/16 v4, 0x1c

    const/4 v5, -0x2

    aput-byte v5, v1, v4

    const/16 v4, 0x1d

    const/4 v7, -0x1

    aput-byte v7, v1, v4

    const/16 v4, 0x1e

    const/16 v8, 0x9

    aput-byte v8, v1, v4

    const/16 v4, 0x20

    const/4 v8, 0x6

    aput-byte v8, v1, v4

    const/16 v4, 0x39

    const/16 v8, 0x10

    aput-byte v8, v1, v4

    iget v4, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    const/16 v8, 0x2c

    invoke-static {v4, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v4, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlockChain:I

    const/16 v8, 0x3c

    invoke-static {v4, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v4, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotChainBlocks:I

    const/16 v8, 0x40

    invoke-static {v4, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v4, p0, Ljxl/write/biff/CompoundFile;->extensionBlock:I

    const/16 v8, 0x44

    invoke-static {v4, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v4, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    const/16 v8, 0x48

    invoke-static {v4, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v4, p0, Ljxl/write/biff/CompoundFile;->rootStartBlock:I

    const/16 v8, 0x30

    invoke-static {v4, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v4, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    const/16 v8, 0x6d

    invoke-static {v4, v8}, Ljava/lang/Math;->min(II)I

    move-result v4

    const/16 v8, 0x4c

    move v9, v6

    move v10, v9

    :goto_0
    if-ge v9, v4, :cond_0

    iget v11, p0, Ljxl/write/biff/CompoundFile;->bbdStartBlock:I

    add-int/2addr v11, v9

    invoke-static {v11, v1, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 v8, v8, 0x4

    add-int/lit8 v10, v10, 0x1

    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    :cond_0
    :goto_1
    if-ge v8, v0, :cond_1

    aput-byte v7, v1, v8

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    move v0, v6

    move v1, v0

    :goto_2
    iget v4, p0, Ljxl/write/biff/CompoundFile;->numExtensionBlocks:I

    if-ge v0, v4, :cond_4

    iget v4, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    sub-int/2addr v4, v10

    const/16 v8, 0x7f

    invoke-static {v4, v8}, Ljava/lang/Math;->min(II)I

    move-result v4

    move v8, v6

    :goto_3
    if-ge v8, v4, :cond_2

    iget v9, p0, Ljxl/write/biff/CompoundFile;->bbdStartBlock:I

    add-int/2addr v9, v10

    add-int/2addr v9, v8

    invoke-static {v9, v3, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 v1, v1, 0x4

    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    :cond_2
    add-int/2addr v10, v4

    iget v4, p0, Ljxl/write/biff/CompoundFile;->numBigBlockDepotBlocks:I

    if-ne v10, v4, :cond_3

    move v4, v5

    goto :goto_4

    :cond_3
    add-int/lit8 v4, v0, 0x1

    :goto_4
    invoke-static {v4, v3, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 v1, v1, 0x4

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_4
    if-lez v4, :cond_6

    :goto_5
    if-ge v1, v2, :cond_5

    aput-byte v7, v3, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    :cond_5
    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, v3}, Ljava/io/OutputStream;->write([B)V

    :cond_6
    return-void
.end method

.method private writePropertySets()V
    .locals 15

    iget v0, p0, Ljxl/write/biff/CompoundFile;->numRootEntryBlocks:I

    const/16 v1, 0x200

    mul-int/2addr v0, v1

    new-array v0, v0, [B

    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_2

    iget v2, p0, Ljxl/write/biff/CompoundFile;->numPropertySets:I

    new-array v2, v2, [I

    move v5, v4

    :goto_0
    sget-object v6, Ljxl/biff/BaseCompoundFile;->STANDARD_PROPERTY_SETS:[Ljava/lang/String;

    array-length v7, v6

    if-ge v5, v7, :cond_1

    iget-object v7, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    aget-object v8, v6, v5

    invoke-virtual {v7, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    if-eqz v7, :cond_0

    iget v6, v7, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->number:I

    aput v5, v2, v6

    goto :goto_1

    :cond_0
    sget-object v7, Ljxl/write/biff/CompoundFile;->logger:Ljxl/common/Logger;

    new-instance v8, Ljava/lang/StringBuffer;

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    const-string v9, "Standard property set "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    aget-object v6, v6, v5

    invoke-virtual {v8, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v6, " not present in source file"

    invoke-virtual {v8, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v8}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v7, v6}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_1
    array-length v5, v6

    iget-object v6, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_2
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget v7, v7, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->number:I

    aput v5, v2, v7

    add-int/2addr v5, v3

    goto :goto_2

    :cond_2
    const/4 v2, 0x0

    :cond_3
    iget-object v5, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    const/16 v6, 0x1000

    if-eqz v5, :cond_6

    iget v5, p0, Ljxl/write/biff/CompoundFile;->requiredSize:I

    invoke-direct {p0, v5}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v5

    mul-int/2addr v5, v1

    add-int/2addr v5, v4

    invoke-direct {p0, v6}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v7

    mul-int/2addr v7, v1

    add-int/2addr v5, v7

    invoke-direct {p0, v6}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v7

    mul-int/2addr v7, v1

    add-int/2addr v5, v7

    iget-object v7, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_4
    :goto_3
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_7

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v8, v8, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v9, v8, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    if-eq v9, v3, :cond_4

    iget v8, v8, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    if-lt v8, v6, :cond_5

    invoke-direct {p0, v8}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v8

    mul-int/2addr v8, v1

    goto :goto_4

    :cond_5
    invoke-direct {p0, v8}, Ljxl/write/biff/CompoundFile;->getSmallBlocksRequired(I)I

    move-result v8

    mul-int/lit8 v8, v8, 0x40

    :goto_4
    add-int/2addr v5, v8

    goto :goto_3

    :cond_6
    move v5, v4

    :cond_7
    new-instance v7, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    const-string v8, "Root Entry"

    invoke-direct {v7, p0, v8}, Ljxl/biff/BaseCompoundFile$PropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile;Ljava/lang/String;)V

    const/4 v9, 0x5

    invoke-virtual {v7, v9}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setType(I)V

    iget v9, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlock:I

    invoke-virtual {v7, v9}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setStartBlock(I)V

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setSize(I)V

    const/4 v5, -0x1

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setPrevious(I)V

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setNext(I)V

    invoke-virtual {v7, v4}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setColour(I)V

    iget-object v9, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-eqz v9, :cond_8

    iget-object v9, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    invoke-virtual {v9, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v8, v8, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v8, v8, Ljxl/biff/BaseCompoundFile$PropertyStorage;->child:I

    aget v8, v2, v8

    goto :goto_5

    :cond_8
    move v8, v3

    :goto_5
    invoke-virtual {v7, v8}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setChild(I)V

    iget-object v7, v7, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v8, 0x80

    invoke-static {v7, v4, v0, v4, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance v7, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    const-string v9, "Workbook"

    invoke-direct {v7, p0, v9}, Ljxl/biff/BaseCompoundFile$PropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile;Ljava/lang/String;)V

    const/4 v10, 0x2

    invoke-virtual {v7, v10}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setType(I)V

    iget v11, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    invoke-virtual {v7, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setStartBlock(I)V

    iget v11, p0, Ljxl/write/biff/CompoundFile;->requiredSize:I

    invoke-virtual {v7, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setSize(I)V

    iget-object v11, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    const/4 v12, 0x3

    if-eqz v11, :cond_b

    iget-object v11, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    invoke-virtual {v11, v9}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v9, v9, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v11, v9, Ljxl/biff/BaseCompoundFile$PropertyStorage;->previous:I

    if-eq v11, v5, :cond_9

    aget v11, v2, v11

    goto :goto_6

    :cond_9
    move v11, v5

    :goto_6
    iget v9, v9, Ljxl/biff/BaseCompoundFile$PropertyStorage;->next:I

    if-eq v9, v5, :cond_a

    aget v9, v2, v9

    goto :goto_7

    :cond_a
    move v9, v5

    goto :goto_7

    :cond_b
    move v9, v5

    move v11, v12

    :goto_7
    invoke-virtual {v7, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setPrevious(I)V

    invoke-virtual {v7, v9}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setNext(I)V

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setChild(I)V

    iget-object v7, v7, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    invoke-static {v7, v4, v0, v8, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/16 v7, 0x100

    new-instance v9, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    const-string v11, "\u0005SummaryInformation"

    invoke-direct {v9, p0, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile;Ljava/lang/String;)V

    invoke-virtual {v9, v10}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setType(I)V

    iget v13, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iget v14, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr v13, v14

    invoke-virtual {v9, v13}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setStartBlock(I)V

    invoke-virtual {v9, v6}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setSize(I)V

    iget-object v13, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-eqz v13, :cond_e

    iget-object v13, p0, Ljxl/write/biff/CompoundFile;->standardPropertySets:Ljava/util/HashMap;

    invoke-virtual {v13, v11}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    if-eqz v11, :cond_e

    iget-object v3, v11, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v11, v3, Ljxl/biff/BaseCompoundFile$PropertyStorage;->previous:I

    if-eq v11, v5, :cond_c

    aget v11, v2, v11

    goto :goto_8

    :cond_c
    move v11, v5

    :goto_8
    iget v3, v3, Ljxl/biff/BaseCompoundFile$PropertyStorage;->next:I

    if-eq v3, v5, :cond_d

    aget v3, v2, v3

    move v12, v3

    goto :goto_9

    :cond_d
    move v12, v5

    :goto_9
    move v3, v11

    :cond_e
    invoke-virtual {v9, v3}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setPrevious(I)V

    invoke-virtual {v9, v12}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setNext(I)V

    invoke-virtual {v9, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setChild(I)V

    iget-object v3, v9, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    invoke-static {v3, v4, v0, v7, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/16 v3, 0x180

    new-instance v7, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    const-string v9, "\u0005DocumentSummaryInformation"

    invoke-direct {v7, p0, v9}, Ljxl/biff/BaseCompoundFile$PropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile;Ljava/lang/String;)V

    invoke-virtual {v7, v10}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setType(I)V

    iget v9, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iget v10, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr v9, v10

    add-int/lit8 v9, v9, 0x8

    invoke-virtual {v7, v9}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setStartBlock(I)V

    invoke-virtual {v7, v6}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setSize(I)V

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setPrevious(I)V

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setNext(I)V

    invoke-virtual {v7, v5}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setChild(I)V

    iget-object v7, v7, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    invoke-static {v7, v4, v0, v3, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v3, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-nez v3, :cond_10

    :cond_f
    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void

    :cond_10
    iget v7, p0, Ljxl/write/biff/CompoundFile;->excelDataStartBlock:I

    iget v9, p0, Ljxl/write/biff/CompoundFile;->excelDataBlocks:I

    add-int/2addr v7, v9

    add-int/lit8 v7, v7, 0x10

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    move v9, v4

    :goto_a
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_f

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v11, v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v11, v11

    if-le v11, v6, :cond_11

    move v11, v7

    goto :goto_b

    :cond_11
    move v11, v9

    :goto_b
    new-instance v12, Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget-object v13, v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget-object v13, v13, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    invoke-direct {v12, p0, v13}, Ljxl/biff/BaseCompoundFile$PropertyStorage;-><init>(Ljxl/biff/BaseCompoundFile;Ljava/lang/String;)V

    iget-object v13, v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v13, v13, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    invoke-virtual {v12, v13}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setType(I)V

    invoke-virtual {v12, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setStartBlock(I)V

    iget-object v11, v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v11, v11, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    invoke-virtual {v12, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setSize(I)V

    iget-object v11, v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->propertyStorage:Ljxl/biff/BaseCompoundFile$PropertyStorage;

    iget v13, v11, Ljxl/biff/BaseCompoundFile$PropertyStorage;->previous:I

    if-eq v13, v5, :cond_12

    aget v13, v2, v13

    goto :goto_c

    :cond_12
    move v13, v5

    :goto_c
    iget v14, v11, Ljxl/biff/BaseCompoundFile$PropertyStorage;->next:I

    if-eq v14, v5, :cond_13

    aget v14, v2, v14

    goto :goto_d

    :cond_13
    move v14, v5

    :goto_d
    iget v11, v11, Ljxl/biff/BaseCompoundFile$PropertyStorage;->child:I

    if-eq v11, v5, :cond_14

    aget v11, v2, v11

    goto :goto_e

    :cond_14
    move v11, v5

    :goto_e
    invoke-virtual {v12, v13}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setPrevious(I)V

    invoke-virtual {v12, v14}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setNext(I)V

    invoke-virtual {v12, v11}, Ljxl/biff/BaseCompoundFile$PropertyStorage;->setChild(I)V

    iget-object v11, v12, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    invoke-static {v11, v4, v0, v1, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr v1, v8

    iget-object v10, v10, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v11, v10

    array-length v10, v10

    if-le v11, v6, :cond_15

    invoke-direct {p0, v10}, Ljxl/write/biff/CompoundFile;->getBigBlocksRequired(I)I

    move-result v10

    add-int/2addr v7, v10

    goto :goto_a

    :cond_15
    invoke-direct {p0, v10}, Ljxl/write/biff/CompoundFile;->getSmallBlocksRequired(I)I

    move-result v10

    add-int/2addr v9, v10

    goto :goto_a
.end method

.method private writeSmallBlockDepot()V
    .locals 8

    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotBlocks:I

    mul-int/lit16 v1, v1, 0x200

    new-array v1, v1, [B

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v2, 0x0

    move v3, v2

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v5, v4, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v6, v5

    const/16 v7, 0x1000

    if-gt v6, v7, :cond_1

    array-length v5, v5

    invoke-direct {p0, v5}, Ljxl/write/biff/CompoundFile;->getSmallBlocksRequired(I)I

    move-result v5

    mul-int/lit8 v5, v5, 0x40

    iget-object v4, v4, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v6, v4

    invoke-static {v4, v2, v1, v3, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr v3, v5

    goto :goto_0

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method private writeSmallBlockDepotChain()V
    .locals 10

    iget v0, p0, Ljxl/write/biff/CompoundFile;->sbdStartBlockChain:I

    const/4 v1, -0x2

    if-ne v0, v1, :cond_0

    return-void

    :cond_0
    iget v0, p0, Ljxl/write/biff/CompoundFile;->numSmallBlockDepotChainBlocks:I

    mul-int/lit16 v0, v0, 0x200

    new-array v0, v0, [B

    iget-object v2, p0, Ljxl/write/biff/CompoundFile;->additionalPropertySets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x1

    move v5, v3

    move v6, v4

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;

    iget-object v7, v7, Ljxl/write/biff/CompoundFile$ReadPropertyStorage;->data:[B

    array-length v8, v7

    const/16 v9, 0x1000

    if-gt v8, v9, :cond_1

    array-length v8, v7

    if-eqz v8, :cond_1

    array-length v7, v7

    invoke-direct {p0, v7}, Ljxl/write/biff/CompoundFile;->getSmallBlocksRequired(I)I

    move-result v7

    move v8, v3

    :goto_1
    add-int/lit8 v9, v7, -0x1

    if-ge v8, v9, :cond_2

    invoke-static {v6, v0, v5}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 v5, v5, 0x4

    add-int/lit8 v6, v6, 0x1

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    :cond_2
    invoke-static {v1, v0, v5}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 v5, v5, 0x4

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_3
    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method private writeSummaryData()V
    .locals 2

    const/16 v0, 0x1000

    new-array v0, v0, [B

    iget-object v1, p0, Ljxl/write/biff/CompoundFile;->out:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method


# virtual methods
.method public write()V
    .locals 0

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeHeader()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeExcelData()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeDocumentSummaryData()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeSummaryData()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeAdditionalPropertySets()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeSmallBlockDepot()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeSmallBlockDepotChain()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writeBigBlockDepot()V

    invoke-direct {p0}, Ljxl/write/biff/CompoundFile;->writePropertySets()V

    return-void
.end method
