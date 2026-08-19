.class Ljxl/write/biff/NameRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/write/biff/NameRecord$NameRange;
    }
.end annotation


# static fields
.field private static final EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

.field private static final areaReference:I = 0x3b

.field private static final cellReference:I = 0x3a

.field static synthetic class$jxl$write$biff$NameRecord:Ljava/lang/Class; = null

.field private static logger:Ljxl/common/Logger; = null

.field private static final subExpression:I = 0x29

.field private static final union:I = 0x10


# instance fields
.field private builtInName:Ljxl/biff/BuiltInName;

.field private data:[B

.field private index:I

.field private modified:Z

.field private name:Ljava/lang/String;

.field private ranges:[Ljxl/write/biff/NameRecord$NameRange;

.field private sheetRef:I


# direct methods
.method static constructor <clinit>()V
    .locals 7

    sget-object v0, Ljxl/write/biff/NameRecord;->class$jxl$write$biff$NameRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.NameRecord"

    invoke-static {v0}, Ljxl/write/biff/NameRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/NameRecord;->class$jxl$write$biff$NameRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/NameRecord;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/write/biff/NameRecord$NameRange;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v6}, Ljxl/write/biff/NameRecord$NameRange;-><init>(IIIII)V

    sput-object v0, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;IIIIIIZ)V
    .locals 7

    sget-object v0, Ljxl/biff/Type;->NAME:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/4 v0, 0x0

    iput v0, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    iput-object p1, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    iput p2, p0, Ljxl/write/biff/NameRecord;->index:I

    const/4 p1, 0x1

    if-eqz p8, :cond_0

    move p2, v0

    goto :goto_0

    :cond_0
    add-int/2addr p2, p1

    :goto_0
    iput p2, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    new-array p2, p1, [Ljxl/write/biff/NameRecord$NameRange;

    iput-object p2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    new-instance p8, Ljxl/write/biff/NameRecord$NameRange;

    move-object v1, p8

    move v2, p3

    move v3, p4

    move v4, p5

    move v5, p6

    move v6, p7

    invoke-direct/range {v1 .. v6}, Ljxl/write/biff/NameRecord$NameRange;-><init>(IIIII)V

    aput-object p8, p2, v0

    iput-boolean p1, p0, Ljxl/write/biff/NameRecord;->modified:Z

    return-void
.end method

.method constructor <init>(Ljxl/biff/BuiltInName;IIIIIIIIIIZ)V
    .locals 11

    move-object v0, p0

    move v1, p2

    sget-object v2, Ljxl/biff/Type;->NAME:Ljxl/biff/Type;

    invoke-direct {p0, v2}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/4 v2, 0x0

    iput v2, v0, Ljxl/write/biff/NameRecord;->sheetRef:I

    move-object v3, p1

    iput-object v3, v0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    iput v1, v0, Ljxl/write/biff/NameRecord;->index:I

    const/4 v3, 0x1

    if-eqz p12, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    add-int/2addr v1, v3

    :goto_0
    iput v1, v0, Ljxl/write/biff/NameRecord;->sheetRef:I

    const/4 v1, 0x2

    new-array v1, v1, [Ljxl/write/biff/NameRecord$NameRange;

    iput-object v1, v0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    new-instance v10, Ljxl/write/biff/NameRecord$NameRange;

    move-object v4, v10

    move v5, p3

    move v6, p4

    move/from16 v7, p5

    move/from16 v8, p6

    move/from16 v9, p7

    invoke-direct/range {v4 .. v9}, Ljxl/write/biff/NameRecord$NameRange;-><init>(IIIII)V

    aput-object v10, v1, v2

    iget-object v1, v0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    new-instance v2, Ljxl/write/biff/NameRecord$NameRange;

    move-object v4, v2

    move/from16 v6, p8

    move/from16 v7, p9

    move/from16 v8, p10

    move/from16 v9, p11

    invoke-direct/range {v4 .. v9}, Ljxl/write/biff/NameRecord$NameRange;-><init>(IIIII)V

    aput-object v2, v1, v3

    return-void
.end method

.method constructor <init>(Ljxl/biff/BuiltInName;IIIIIIZ)V
    .locals 7

    sget-object v0, Ljxl/biff/Type;->NAME:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/4 v0, 0x0

    iput v0, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    iput-object p1, p0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    iput p2, p0, Ljxl/write/biff/NameRecord;->index:I

    const/4 p1, 0x1

    if-eqz p8, :cond_0

    move p2, v0

    goto :goto_0

    :cond_0
    add-int/2addr p2, p1

    :goto_0
    iput p2, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    new-array p1, p1, [Ljxl/write/biff/NameRecord$NameRange;

    iput-object p1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    new-instance p2, Ljxl/write/biff/NameRecord$NameRange;

    move-object v1, p2

    move v2, p3

    move v3, p4

    move v4, p5

    move v5, p6

    move v6, p7

    invoke-direct/range {v1 .. v6}, Ljxl/write/biff/NameRecord$NameRange;-><init>(IIIII)V

    aput-object p2, p1, v0

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/NameRecord;I)V
    .locals 3

    sget-object v0, Ljxl/biff/Type;->NAME:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/4 v0, 0x0

    iput v0, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    invoke-virtual {p1}, Ljxl/read/biff/NameRecord;->getData()[B

    move-result-object v1

    iput-object v1, p0, Ljxl/write/biff/NameRecord;->data:[B

    invoke-virtual {p1}, Ljxl/read/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    invoke-virtual {p1}, Ljxl/read/biff/NameRecord;->getSheetRef()I

    move-result v1

    iput v1, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    iput p2, p0, Ljxl/write/biff/NameRecord;->index:I

    iput-boolean v0, p0, Ljxl/write/biff/NameRecord;->modified:Z

    invoke-virtual {p1}, Ljxl/read/biff/NameRecord;->getRanges()[Ljxl/read/biff/NameRecord$NameRange;

    move-result-object p1

    array-length p2, p1

    new-array p2, p2, [Ljxl/write/biff/NameRecord$NameRange;

    iput-object p2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    :goto_0
    iget-object p2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v1, p2

    if-ge v0, v1, :cond_0

    new-instance v1, Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, p1, v0

    invoke-direct {v1, v2}, Ljxl/write/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord$NameRange;)V

    aput-object v1, p2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

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


# virtual methods
.method columnInserted(II)V
    .locals 3

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge v0, v2, :cond_3

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v1

    if-eq p1, v1, :cond_0

    goto :goto_1

    :cond_0
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getFirstColumn()I

    move-result v1

    const/4 v2, 0x1

    if-gt p2, v1, :cond_1

    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->incrementFirstColumn()V

    iput-boolean v2, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_1
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getLastColumn()I

    move-result v1

    if-gt p2, v1, :cond_2

    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->incrementLastColumn()V

    iput-boolean v2, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_2
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method columnRemoved(II)Z
    .locals 5

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v3, v2

    const/4 v4, 0x1

    if-ge v1, v3, :cond_4

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v2

    if-eq p1, v2, :cond_0

    goto :goto_1

    :cond_0
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getFirstColumn()I

    move-result v2

    if-ne p2, v2, :cond_1

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getLastColumn()I

    move-result v2

    if-ne p2, v2, :cond_1

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    sget-object v3, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    aput-object v3, v2, v1

    :cond_1
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getFirstColumn()I

    move-result v2

    if-ge p2, v2, :cond_2

    if-lez p2, :cond_2

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->decrementFirstColumn()V

    iput-boolean v4, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_2
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getLastColumn()I

    move-result v2

    if-gt p2, v2, :cond_3

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->decrementLastColumn()V

    iput-boolean v4, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    move p1, v0

    move p2, p1

    :goto_2
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge p1, v2, :cond_6

    aget-object v1, v1, p1

    sget-object v2, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    if-ne v1, v2, :cond_5

    add-int/lit8 p2, p2, 0x1

    :cond_5
    add-int/lit8 p1, p1, 0x1

    goto :goto_2

    :cond_6
    array-length p1, v1

    if-ne p2, p1, :cond_7

    return v4

    :cond_7
    array-length p1, v1

    sub-int/2addr p1, p2

    new-array p1, p1, [Ljxl/write/biff/NameRecord$NameRange;

    move p2, v0

    :goto_3
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge p2, v2, :cond_9

    aget-object v2, v1, p2

    sget-object v3, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    if-eq v2, v3, :cond_8

    aget-object v1, v1, p2

    aput-object v1, p1, p2

    :cond_8
    add-int/lit8 p2, p2, 0x1

    goto :goto_3

    :cond_9
    iput-object p1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    return v0
.end method

.method public getData()[B
    .locals 10

    iget-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    if-eqz v0, :cond_0

    iget-boolean v1, p0, Ljxl/write/biff/NameRecord;->modified:Z

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v1, v0

    const/4 v2, 0x4

    const/16 v3, 0xb

    const/4 v4, 0x1

    if-le v1, v4, :cond_1

    array-length v0, v0

    mul-int/2addr v0, v3

    add-int/lit8 v3, v0, 0x4

    :cond_1
    add-int/lit8 v0, v3, 0xf

    iget-object v1, p0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    if-eqz v1, :cond_2

    move v1, v4

    goto :goto_0

    :cond_2
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    :goto_0
    add-int/2addr v0, v1

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    iget-object v1, p0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    const/4 v5, 0x0

    if-eqz v1, :cond_3

    const/16 v1, 0x20

    goto :goto_1

    :cond_3
    move v1, v5

    :goto_1
    invoke-static {v1, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    const/4 v1, 0x2

    aput-byte v5, v0, v1

    iget-object v6, p0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    const/4 v7, 0x3

    if-eqz v6, :cond_4

    aput-byte v4, v0, v7

    goto :goto_2

    :cond_4
    iget-object v6, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    int-to-byte v6, v6

    aput-byte v6, v0, v7

    :goto_2
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    invoke-static {v3, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->data:[B

    const/4 v6, 0x6

    invoke-static {v0, v2, v6}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->data:[B

    const/16 v6, 0x8

    invoke-static {v0, v2, v6}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    const/16 v2, 0xf

    if-eqz v0, :cond_5

    iget-object v6, p0, Ljxl/write/biff/NameRecord;->data:[B

    invoke-virtual {v0}, Ljxl/biff/BuiltInName;->getValue()I

    move-result v0

    int-to-byte v0, v0

    aput-byte v0, v6, v2

    goto :goto_3

    :cond_5
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    iget-object v6, p0, Ljxl/write/biff/NameRecord;->data:[B

    invoke-static {v0, v6, v2}, Ljxl/biff/StringHelper;->getBytes(Ljava/lang/String;[BI)V

    :goto_3
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    const/16 v6, 0x10

    if-eqz v0, :cond_6

    move v0, v6

    goto :goto_4

    :cond_6
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v2

    :goto_4
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v8, v2

    const/16 v9, 0x3b

    if-le v8, v4, :cond_8

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->data:[B

    add-int/lit8 v4, v0, 0x1

    const/16 v8, 0x29

    aput-byte v8, v2, v0

    sub-int/2addr v3, v7

    invoke-static {v3, v2, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/2addr v4, v1

    move v0, v5

    :goto_5
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge v0, v2, :cond_7

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->data:[B

    add-int/lit8 v3, v4, 0x1

    aput-byte v9, v2, v4

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getData()[B

    move-result-object v1

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->data:[B

    array-length v4, v1

    invoke-static {v1, v5, v2, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v1, v1

    add-int v4, v3, v1

    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    :cond_7
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    aput-byte v6, v0, v4

    goto :goto_6

    :cond_8
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->data:[B

    aput-byte v9, v1, v0

    aget-object v1, v2, v5

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getData()[B

    move-result-object v1

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->data:[B

    add-int/2addr v0, v4

    array-length v3, v1

    invoke-static {v1, v5, v2, v0, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :goto_6
    iget-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    return-object v0
.end method

.method public getIndex()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/NameRecord;->index:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/NameRecord;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getRanges()[Ljxl/write/biff/NameRecord$NameRange;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    return-object v0
.end method

.method public getSheetRef()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    return v0
.end method

.method rowInserted(II)V
    .locals 3

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge v0, v2, :cond_3

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v1

    if-eq p1, v1, :cond_0

    goto :goto_1

    :cond_0
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getFirstRow()I

    move-result v1

    const/4 v2, 0x1

    if-gt p2, v1, :cond_1

    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->incrementFirstRow()V

    iput-boolean v2, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_1
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getLastRow()I

    move-result v1

    if-gt p2, v1, :cond_2

    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->incrementLastRow()V

    iput-boolean v2, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_2
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method rowRemoved(II)Z
    .locals 5

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v3, v2

    const/4 v4, 0x1

    if-ge v1, v3, :cond_4

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v2

    if-eq p1, v2, :cond_0

    goto :goto_1

    :cond_0
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getFirstRow()I

    move-result v2

    if-ne p2, v2, :cond_1

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getLastRow()I

    move-result v2

    if-ne p2, v2, :cond_1

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    sget-object v3, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    aput-object v3, v2, v1

    :cond_1
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getFirstRow()I

    move-result v2

    if-ge p2, v2, :cond_2

    if-lez p2, :cond_2

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->decrementFirstRow()V

    iput-boolean v4, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_2
    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getLastRow()I

    move-result v2

    if-gt p2, v2, :cond_3

    iget-object v2, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->decrementLastRow()V

    iput-boolean v4, p0, Ljxl/write/biff/NameRecord;->modified:Z

    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    move p1, v0

    move p2, p1

    :goto_2
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge p1, v2, :cond_6

    aget-object v1, v1, p1

    sget-object v2, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    if-ne v1, v2, :cond_5

    add-int/lit8 p2, p2, 0x1

    :cond_5
    add-int/lit8 p1, p1, 0x1

    goto :goto_2

    :cond_6
    array-length p1, v1

    if-ne p2, p1, :cond_7

    return v4

    :cond_7
    array-length p1, v1

    sub-int/2addr p1, p2

    new-array p1, p1, [Ljxl/write/biff/NameRecord$NameRange;

    move p2, v0

    :goto_3
    iget-object v1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    array-length v2, v1

    if-ge p2, v2, :cond_9

    aget-object v2, v1, p2

    sget-object v3, Ljxl/write/biff/NameRecord;->EMPTY_RANGE:Ljxl/write/biff/NameRecord$NameRange;

    if-eq v2, v3, :cond_8

    aget-object v1, v1, p2

    aput-object v1, p1, p2

    :cond_8
    add-int/lit8 p2, p2, 0x1

    goto :goto_3

    :cond_9
    iput-object p1, p0, Ljxl/write/biff/NameRecord;->ranges:[Ljxl/write/biff/NameRecord$NameRange;

    return v0
.end method

.method public setSheetRef(I)V
    .locals 2

    iput p1, p0, Ljxl/write/biff/NameRecord;->sheetRef:I

    iget-object v0, p0, Ljxl/write/biff/NameRecord;->data:[B

    const/16 v1, 0x8

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-void
.end method
