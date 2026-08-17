.class Ljxl/read/biff/SSTRecord;
.super Ljxl/biff/RecordData;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/read/biff/SSTRecord$BooleanHolder;,
        Ljxl/read/biff/SSTRecord$ByteArrayHolder;
    }
.end annotation


# instance fields
.field private continuationBreaks:[I

.field private strings:[Ljava/lang/String;

.field private totalStrings:I

.field private uniqueStrings:I


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;[Ljxl/read/biff/Record;Ljxl/WorkbookSettings;)V
    .locals 6

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    const/4 p1, 0x0

    move v0, p1

    move v1, v0

    :goto_0
    array-length v2, p2

    if-ge v0, v2, :cond_0

    aget-object v2, p2, v0

    invoke-virtual {v2}, Ljxl/read/biff/Record;->getLength()I

    move-result v2

    add-int/2addr v1, v2

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getLength()I

    move-result v0

    add-int/2addr v1, v0

    new-array v0, v1, [B

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v1

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v2

    invoke-virtual {v2}, Ljxl/read/biff/Record;->getLength()I

    move-result v2

    invoke-static {v1, p1, v0, p1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/Record;->getLength()I

    move-result v1

    add-int/2addr v1, p1

    array-length v2, p2

    new-array v2, v2, [I

    iput-object v2, p0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    move v2, p1

    :goto_1
    array-length v3, p2

    if-ge v2, v3, :cond_1

    aget-object v3, p2, v2

    invoke-virtual {v3}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v4

    invoke-virtual {v3}, Ljxl/read/biff/Record;->getLength()I

    move-result v5

    invoke-static {v4, p1, v0, v1, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v4, p0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    aput v1, v4, v2

    invoke-virtual {v3}, Ljxl/read/biff/Record;->getLength()I

    move-result v3

    add-int/2addr v1, v3

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    aget-byte p1, v0, p1

    const/4 p2, 0x1

    aget-byte p2, v0, p2

    const/4 v1, 0x2

    aget-byte v1, v0, v1

    const/4 v2, 0x3

    aget-byte v2, v0, v2

    invoke-static {p1, p2, v1, v2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SSTRecord;->totalStrings:I

    const/4 p1, 0x4

    aget-byte p1, v0, p1

    const/4 p2, 0x5

    aget-byte p2, v0, p2

    const/4 v1, 0x6

    aget-byte v1, v0, v1

    const/4 v2, 0x7

    aget-byte v2, v0, v2

    invoke-static {p1, p2, v1, v2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/SSTRecord;->uniqueStrings:I

    new-array p1, p1, [Ljava/lang/String;

    iput-object p1, p0, Ljxl/read/biff/SSTRecord;->strings:[Ljava/lang/String;

    const/16 p1, 0x8

    invoke-direct {p0, v0, p1, p3}, Ljxl/read/biff/SSTRecord;->readStrings([BILjxl/WorkbookSettings;)V

    return-void
.end method

.method private getChars([BLjxl/read/biff/SSTRecord$ByteArrayHolder;ILjxl/read/biff/SSTRecord$BooleanHolder;I)I
    .locals 9

    iget-boolean v0, p4, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    if-eqz v0, :cond_0

    new-array v0, p5, [B

    iput-object v0, p2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    goto :goto_0

    :cond_0
    mul-int/lit8 v0, p5, 0x2

    new-array v0, v0, [B

    iput-object v0, p2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    :goto_0
    const/4 v0, 0x0

    move v1, v0

    move v5, v1

    :cond_1
    :goto_1
    iget-object v2, p0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v3, v2

    if-ge v5, v3, :cond_3

    if-nez v1, :cond_3

    aget v1, v2, v5

    if-gt p3, v1, :cond_2

    iget-object v1, p2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    array-length v1, v1

    add-int/2addr v1, p3

    aget v2, v2, v5

    if-le v1, v2, :cond_2

    const/4 v1, 0x1

    goto :goto_2

    :cond_2
    move v1, v0

    :goto_2
    if-nez v1, :cond_1

    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_3
    if-nez v1, :cond_4

    iget-object p4, p2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    array-length p5, p4

    invoke-static {p1, p3, p4, v0, p5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object p1, p2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    array-length p1, p1

    return p1

    :cond_4
    aget v1, v2, v5

    iget-object v2, p2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    sub-int v8, v1, p3

    invoke-static {p1, p3, v2, v0, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-boolean p3, p4, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    if-eqz p3, :cond_5

    move p3, v8

    goto :goto_3

    :cond_5
    div-int/lit8 p3, v8, 0x2

    :goto_3
    sub-int v7, p5, p3

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, v8

    move-object v6, p4

    invoke-direct/range {v1 .. v7}, Ljxl/read/biff/SSTRecord;->getContinuedString([BLjxl/read/biff/SSTRecord$ByteArrayHolder;IILjxl/read/biff/SSTRecord$BooleanHolder;I)I

    move-result p1

    add-int/2addr v8, p1

    return v8
.end method

.method private getContinuedString([BLjxl/read/biff/SSTRecord$ByteArrayHolder;IILjxl/read/biff/SSTRecord$BooleanHolder;I)I
    .locals 18

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p5

    iget-object v4, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    aget v4, v4, p4

    const/4 v5, 0x0

    move/from16 v6, p4

    move/from16 v7, p6

    move v8, v4

    move v9, v5

    move/from16 v4, p3

    :cond_0
    :goto_0
    if-lez v7, :cond_b

    iget-object v10, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v10, v10

    const/4 v11, 0x1

    if-ge v6, v10, :cond_1

    move v10, v11

    goto :goto_1

    :cond_1
    move v10, v5

    :goto_1
    const-string v12, "continuation break index"

    invoke-static {v10, v12}, Ljxl/common/Assert;->verify(ZLjava/lang/String;)V

    iget-boolean v10, v3, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    if-eqz v10, :cond_3

    aget-byte v12, v1, v8

    if-nez v12, :cond_3

    iget-object v10, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v12, v10

    sub-int/2addr v12, v11

    if-ne v6, v12, :cond_2

    move v10, v7

    goto :goto_2

    :cond_2
    add-int/lit8 v12, v6, 0x1

    aget v10, v10, v12

    sub-int/2addr v10, v8

    sub-int/2addr v10, v11

    invoke-static {v7, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    :goto_2
    add-int/lit8 v12, v8, 0x1

    iget-object v13, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    invoke-static {v1, v12, v13, v4, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr v4, v10

    add-int/lit8 v12, v10, 0x1

    add-int/2addr v9, v12

    sub-int/2addr v7, v10

    iput-boolean v11, v3, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    goto/16 :goto_9

    :cond_3
    if-nez v10, :cond_5

    aget-byte v12, v1, v8

    if-eqz v12, :cond_5

    iget-object v10, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v12, v10

    sub-int/2addr v12, v11

    if-ne v6, v12, :cond_4

    mul-int/lit8 v10, v7, 0x2

    goto :goto_3

    :cond_4
    mul-int/lit8 v12, v7, 0x2

    add-int/lit8 v13, v6, 0x1

    aget v10, v10, v13

    sub-int/2addr v10, v8

    sub-int/2addr v10, v11

    invoke-static {v12, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    :goto_3
    add-int/lit8 v11, v8, 0x1

    iget-object v12, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    invoke-static {v1, v11, v12, v4, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr v4, v10

    add-int/lit8 v11, v10, 0x1

    add-int/2addr v9, v11

    div-int/lit8 v10, v10, 0x2

    :goto_4
    sub-int/2addr v7, v10

    iput-boolean v5, v3, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    goto/16 :goto_9

    :cond_5
    if-nez v10, :cond_8

    aget-byte v10, v1, v8

    if-nez v10, :cond_8

    iget-object v10, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v12, v10

    sub-int/2addr v12, v11

    if-ne v6, v12, :cond_6

    move v10, v7

    goto :goto_5

    :cond_6
    add-int/lit8 v12, v6, 0x1

    aget v10, v10, v12

    sub-int/2addr v10, v8

    sub-int/2addr v10, v11

    invoke-static {v7, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    :goto_5
    move v12, v5

    :goto_6
    if-ge v12, v10, :cond_7

    iget-object v13, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    add-int v14, v8, v12

    add-int/2addr v14, v11

    aget-byte v14, v1, v14

    aput-byte v14, v13, v4

    add-int/lit8 v4, v4, 0x2

    add-int/lit8 v12, v12, 0x1

    goto :goto_6

    :cond_7
    add-int/lit8 v11, v10, 0x1

    add-int/2addr v9, v11

    goto :goto_4

    :cond_8
    iget-object v10, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    mul-int/lit8 v12, v4, 0x2

    mul-int/lit8 v13, v7, 0x2

    add-int v14, v12, v13

    new-array v14, v14, [B

    iput-object v14, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    move v14, v5

    :goto_7
    if-ge v14, v4, :cond_9

    iget-object v15, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    mul-int/lit8 v16, v14, 0x2

    aget-byte v17, v10, v14

    aput-byte v17, v15, v16

    add-int/lit8 v14, v14, 0x1

    goto :goto_7

    :cond_9
    iget-object v4, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v10, v4

    sub-int/2addr v10, v11

    if-ne v6, v10, :cond_a

    goto :goto_8

    :cond_a
    add-int/lit8 v10, v6, 0x1

    aget v4, v4, v10

    sub-int/2addr v4, v8

    sub-int/2addr v4, v11

    invoke-static {v13, v4}, Ljava/lang/Math;->min(II)I

    move-result v13

    :goto_8
    add-int/lit8 v4, v8, 0x1

    iget-object v10, v2, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    invoke-static {v1, v4, v10, v12, v13}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr v12, v13

    add-int/lit8 v4, v13, 0x1

    add-int/2addr v9, v4

    div-int/lit8 v13, v13, 0x2

    sub-int/2addr v7, v13

    iput-boolean v5, v3, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    move v4, v12

    :goto_9
    add-int/lit8 v6, v6, 0x1

    iget-object v10, v0, Ljxl/read/biff/SSTRecord;->continuationBreaks:[I

    array-length v11, v10

    if-ge v6, v11, :cond_0

    aget v8, v10, v6

    goto/16 :goto_0

    :cond_b
    return v9
.end method

.method private readStrings([BILjxl/WorkbookSettings;)V
    .locals 16

    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move/from16 v0, p2

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v9, 0x0

    :goto_0
    iget v3, v6, Ljxl/read/biff/SSTRecord;->uniqueStrings:I

    if-ge v9, v3, :cond_9

    aget-byte v3, v7, v0

    add-int/lit8 v4, v0, 0x1

    aget-byte v4, v7, v4

    invoke-static {v3, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v10

    add-int/lit8 v0, v0, 0x2

    aget-byte v3, v7, v0

    const/4 v4, 0x1

    add-int/2addr v0, v4

    and-int/lit8 v5, v3, 0x4

    if-eqz v5, :cond_0

    move v11, v4

    goto :goto_1

    :cond_0
    const/4 v11, 0x0

    :goto_1
    and-int/lit8 v5, v3, 0x8

    if-eqz v5, :cond_1

    move v12, v4

    goto :goto_2

    :cond_1
    const/4 v12, 0x0

    :goto_2
    if-eqz v12, :cond_2

    aget-byte v1, v7, v0

    add-int/lit8 v5, v0, 0x1

    aget-byte v5, v7, v5

    invoke-static {v1, v5}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    add-int/lit8 v0, v0, 0x2

    :cond_2
    move v13, v1

    if-eqz v11, :cond_3

    aget-byte v1, v7, v0

    add-int/lit8 v2, v0, 0x1

    aget-byte v2, v7, v2

    add-int/lit8 v5, v0, 0x2

    aget-byte v5, v7, v5

    add-int/lit8 v14, v0, 0x3

    aget-byte v14, v7, v14

    invoke-static {v1, v2, v5, v14}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v2

    add-int/lit8 v0, v0, 0x4

    :cond_3
    move v14, v0

    move v15, v2

    and-int/lit8 v0, v3, 0x1

    if-nez v0, :cond_4

    goto :goto_3

    :cond_4
    const/4 v4, 0x0

    :goto_3
    new-instance v5, Ljxl/read/biff/SSTRecord$ByteArrayHolder;

    const/4 v0, 0x0

    invoke-direct {v5, v0}, Ljxl/read/biff/SSTRecord$ByteArrayHolder;-><init>(Ljxl/read/biff/SSTRecord$1;)V

    new-instance v3, Ljxl/read/biff/SSTRecord$BooleanHolder;

    invoke-direct {v3, v0}, Ljxl/read/biff/SSTRecord$BooleanHolder;-><init>(Ljxl/read/biff/SSTRecord$1;)V

    iput-boolean v4, v3, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v2, v5

    move-object v4, v3

    move v3, v14

    move-object/from16 p2, v4

    move-object v8, v5

    move v5, v10

    invoke-direct/range {v0 .. v5}, Ljxl/read/biff/SSTRecord;->getChars([BLjxl/read/biff/SSTRecord$ByteArrayHolder;ILjxl/read/biff/SSTRecord$BooleanHolder;I)I

    move-result v0

    add-int/2addr v14, v0

    move-object/from16 v0, p2

    iget-boolean v0, v0, Ljxl/read/biff/SSTRecord$BooleanHolder;->value:Z

    if-eqz v0, :cond_5

    iget-object v0, v8, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    move-object/from16 v1, p3

    const/4 v2, 0x0

    invoke-static {v0, v10, v2, v1}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_5
    move-object/from16 v1, p3

    const/4 v2, 0x0

    iget-object v0, v8, Ljxl/read/biff/SSTRecord$ByteArrayHolder;->bytes:[B

    invoke-static {v0, v10, v2}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object v0

    :goto_4
    iget-object v2, v6, Ljxl/read/biff/SSTRecord;->strings:[Ljava/lang/String;

    aput-object v0, v2, v9

    if-eqz v12, :cond_6

    mul-int/lit8 v0, v13, 0x4

    add-int/2addr v14, v0

    :cond_6
    if-eqz v11, :cond_7

    add-int/2addr v14, v15

    :cond_7
    move v0, v14

    array-length v2, v7

    if-le v0, v2, :cond_8

    const-string v2, "pos exceeds record length"

    const/4 v3, 0x0

    invoke-static {v3, v2}, Ljxl/common/Assert;->verify(ZLjava/lang/String;)V

    goto :goto_5

    :cond_8
    const/4 v3, 0x0

    :goto_5
    add-int/lit8 v9, v9, 0x1

    move v1, v13

    move v2, v15

    goto/16 :goto_0

    :cond_9
    return-void
.end method


# virtual methods
.method public getString(I)Ljava/lang/String;
    .locals 1

    iget v0, p0, Ljxl/read/biff/SSTRecord;->uniqueStrings:I

    if-ge p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/read/biff/SSTRecord;->strings:[Ljava/lang/String;

    aget-object p1, v0, p1

    return-object p1
.end method
