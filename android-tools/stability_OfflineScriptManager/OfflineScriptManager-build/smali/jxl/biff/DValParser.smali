.class public Ljxl/biff/DValParser;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static PROMPT_BOX_AT_CELL_MASK:I

.field private static PROMPT_BOX_VISIBLE_MASK:I

.field private static VALIDITY_DATA_CACHED_MASK:I

.field static synthetic class$jxl$biff$DValParser:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private numDVRecords:I

.field private objectId:I

.field private promptBoxAtCell:Z

.field private promptBoxVisible:Z

.field private validityDataCached:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/DValParser;->class$jxl$biff$DValParser:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.DValParser"

    invoke-static {v0}, Ljxl/biff/DValParser;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/DValParser;->class$jxl$biff$DValParser:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/DValParser;->logger:Ljxl/common/Logger;

    const/4 v0, 0x1

    sput v0, Ljxl/biff/DValParser;->PROMPT_BOX_VISIBLE_MASK:I

    const/4 v0, 0x2

    sput v0, Ljxl/biff/DValParser;->PROMPT_BOX_AT_CELL_MASK:I

    const/4 v0, 0x4

    sput v0, Ljxl/biff/DValParser;->VALIDITY_DATA_CACHED_MASK:I

    return-void
.end method

.method public constructor <init>(II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/DValParser;->objectId:I

    iput p2, p0, Ljxl/biff/DValParser;->numDVRecords:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/DValParser;->validityDataCached:Z

    return-void
.end method

.method public constructor <init>([B)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    aget-byte v1, p1, v0

    const/4 v2, 0x1

    aget-byte v3, p1, v2

    invoke-static {v1, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    sget v3, Ljxl/biff/DValParser;->PROMPT_BOX_VISIBLE_MASK:I

    and-int/2addr v3, v1

    if-eqz v3, :cond_0

    move v3, v2

    goto :goto_0

    :cond_0
    move v3, v0

    :goto_0
    iput-boolean v3, p0, Ljxl/biff/DValParser;->promptBoxVisible:Z

    sget v3, Ljxl/biff/DValParser;->PROMPT_BOX_AT_CELL_MASK:I

    and-int/2addr v3, v1

    if-eqz v3, :cond_1

    move v3, v2

    goto :goto_1

    :cond_1
    move v3, v0

    :goto_1
    iput-boolean v3, p0, Ljxl/biff/DValParser;->promptBoxAtCell:Z

    sget v3, Ljxl/biff/DValParser;->VALIDITY_DATA_CACHED_MASK:I

    and-int/2addr v1, v3

    if-eqz v1, :cond_2

    move v0, v2

    :cond_2
    iput-boolean v0, p0, Ljxl/biff/DValParser;->validityDataCached:Z

    const/16 v0, 0xa

    aget-byte v0, p1, v0

    const/16 v1, 0xb

    aget-byte v1, p1, v1

    const/16 v2, 0xc

    aget-byte v2, p1, v2

    const/16 v3, 0xd

    aget-byte v3, p1, v3

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/biff/DValParser;->objectId:I

    const/16 v0, 0xe

    aget-byte v0, p1, v0

    const/16 v1, 0xf

    aget-byte v1, p1, v1

    const/16 v2, 0x10

    aget-byte v2, p1, v2

    const/16 v3, 0x11

    aget-byte p1, p1, v3

    invoke-static {v0, v1, v2, p1}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/biff/DValParser;->numDVRecords:I

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
.method public dvAdded()V
    .locals 1

    iget v0, p0, Ljxl/biff/DValParser;->numDVRecords:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/biff/DValParser;->numDVRecords:I

    return-void
.end method

.method public dvRemoved()V
    .locals 1

    iget v0, p0, Ljxl/biff/DValParser;->numDVRecords:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/biff/DValParser;->numDVRecords:I

    return-void
.end method

.method public getData()[B
    .locals 4

    const/16 v0, 0x12

    new-array v0, v0, [B

    iget-boolean v1, p0, Ljxl/biff/DValParser;->promptBoxVisible:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    sget v1, Ljxl/biff/DValParser;->PROMPT_BOX_VISIBLE_MASK:I

    or-int/2addr v1, v2

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    iget-boolean v3, p0, Ljxl/biff/DValParser;->promptBoxAtCell:Z

    if-eqz v3, :cond_1

    sget v3, Ljxl/biff/DValParser;->PROMPT_BOX_AT_CELL_MASK:I

    or-int/2addr v1, v3

    :cond_1
    iget-boolean v3, p0, Ljxl/biff/DValParser;->validityDataCached:Z

    if-eqz v3, :cond_2

    sget v3, Ljxl/biff/DValParser;->VALIDITY_DATA_CACHED_MASK:I

    or-int/2addr v1, v3

    :cond_2
    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/DValParser;->objectId:I

    const/16 v2, 0xa

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v1, p0, Ljxl/biff/DValParser;->numDVRecords:I

    const/16 v2, 0xe

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-object v0
.end method

.method public getNumberOfDVRecords()I
    .locals 1

    iget v0, p0, Ljxl/biff/DValParser;->numDVRecords:I

    return v0
.end method

.method public getObjectId()I
    .locals 1

    iget v0, p0, Ljxl/biff/DValParser;->objectId:I

    return v0
.end method
