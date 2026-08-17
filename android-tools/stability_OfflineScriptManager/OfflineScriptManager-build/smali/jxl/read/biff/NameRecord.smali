.class public Ljxl/read/biff/NameRecord;
.super Ljxl/biff/RecordData;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/read/biff/NameRecord$NameRange;,
        Ljxl/read/biff/NameRecord$Biff7;
    }
.end annotation


# static fields
.field private static final areaReference:I = 0x3b

.field public static biff7:Ljxl/read/biff/NameRecord$Biff7; = null

.field private static final builtIn:I = 0x20

.field private static final cellReference:I = 0x3a

.field static synthetic class$jxl$read$biff$NameRecord:Ljava/lang/Class; = null

.field private static final commandMacro:I = 0xc

.field private static logger:Ljxl/common/Logger; = null

.field private static final subExpression:I = 0x29

.field private static final union:I = 0x10


# instance fields
.field private builtInName:Ljxl/biff/BuiltInName;

.field private index:I

.field private isbiff8:Z

.field private name:Ljava/lang/String;

.field private ranges:Ljava/util/ArrayList;

.field private sheetRef:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Ljxl/read/biff/NameRecord;->class$jxl$read$biff$NameRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.NameRecord"

    invoke-static {v0}, Ljxl/read/biff/NameRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/NameRecord;->class$jxl$read$biff$NameRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/NameRecord;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/read/biff/NameRecord$Biff7;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljxl/read/biff/NameRecord$Biff7;-><init>(Ljxl/read/biff/NameRecord$1;)V

    sput-object v0, Ljxl/read/biff/NameRecord;->biff7:Ljxl/read/biff/NameRecord$Biff7;

    return-void
.end method

.method constructor <init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;I)V
    .locals 18

    move-object/from16 v7, p0

    invoke-direct/range {p0 .. p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    const/4 v8, 0x0

    iput v8, v7, Ljxl/read/biff/NameRecord;->sheetRef:I

    move/from16 v0, p3

    iput v0, v7, Ljxl/read/biff/NameRecord;->index:I

    const/4 v9, 0x1

    iput-boolean v9, v7, Ljxl/read/biff/NameRecord;->isbiff8:Z

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v7, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual/range {p0 .. p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v10

    aget-byte v0, v10, v8

    aget-byte v1, v10, v9

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    const/4 v1, 0x3

    aget-byte v1, v10, v1

    const/16 v2, 0x8

    aget-byte v2, v10, v2

    const/16 v3, 0x9

    aget-byte v3, v10, v3

    invoke-static {v2, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    iput v2, v7, Ljxl/read/biff/NameRecord;->sheetRef:I

    and-int/lit8 v2, v0, 0x20

    const/16 v3, 0xf

    if-eqz v2, :cond_0

    aget-byte v2, v10, v3

    invoke-static {v2}, Ljxl/biff/BuiltInName;->getBuiltInName(I)Ljxl/biff/BuiltInName;

    move-result-object v2

    iput-object v2, v7, Ljxl/read/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    goto :goto_0

    :cond_0
    move-object/from16 v2, p2

    invoke-static {v10, v1, v3, v2}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v7, Ljxl/read/biff/NameRecord;->name:Ljava/lang/String;

    :goto_0
    and-int/lit8 v0, v0, 0xc

    if-eqz v0, :cond_1

    return-void

    :cond_1
    add-int/2addr v1, v3

    aget-byte v0, v10, v1

    const/16 v11, 0x3a

    const/high16 v12, 0xc0000

    if-ne v0, v11, :cond_3

    add-int/lit8 v0, v1, 0x1

    aget-byte v0, v10, v0

    add-int/lit8 v2, v1, 0x2

    aget-byte v2, v10, v2

    invoke-static {v0, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    add-int/lit8 v0, v1, 0x3

    aget-byte v0, v10, v0

    add-int/lit8 v3, v1, 0x4

    aget-byte v3, v10, v3

    invoke-static {v0, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v6

    add-int/lit8 v0, v1, 0x5

    aget-byte v0, v10, v0

    add-int/lit8 v1, v1, 0x6

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v5, v0, 0xff

    and-int/2addr v0, v12

    if-nez v0, :cond_2

    move v8, v9

    :cond_2
    invoke-static {v8}, Ljxl/common/Assert;->verify(Z)V

    new-instance v8, Ljxl/read/biff/NameRecord$NameRange;

    move-object v0, v8

    move-object/from16 v1, p0

    move v3, v5

    move v4, v6

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V

    :goto_1
    iget-object v0, v7, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_b

    :cond_3
    aget-byte v0, v10, v1

    const/16 v13, 0x3b

    if-ne v0, v13, :cond_6

    move v11, v1

    :goto_2
    array-length v0, v10

    if-ge v11, v0, :cond_f

    add-int/lit8 v0, v11, 0x1

    aget-byte v0, v10, v0

    add-int/lit8 v1, v11, 0x2

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    add-int/lit8 v0, v11, 0x3

    aget-byte v0, v10, v0

    add-int/lit8 v1, v11, 0x4

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    add-int/lit8 v0, v11, 0x5

    aget-byte v0, v10, v0

    add-int/lit8 v1, v11, 0x6

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v6

    add-int/lit8 v0, v11, 0x7

    aget-byte v0, v10, v0

    add-int/lit8 v1, v11, 0x8

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v3, v0, 0xff

    and-int/2addr v0, v12

    if-nez v0, :cond_4

    move v0, v9

    goto :goto_3

    :cond_4
    move v0, v8

    :goto_3
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    add-int/lit8 v0, v11, 0x9

    aget-byte v0, v10, v0

    add-int/lit8 v1, v11, 0xa

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v5, v0, 0xff

    and-int/2addr v0, v12

    if-nez v0, :cond_5

    move v0, v9

    goto :goto_4

    :cond_5
    move v0, v8

    :goto_4
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    new-instance v13, Ljxl/read/biff/NameRecord$NameRange;

    move-object v0, v13

    move-object/from16 v1, p0

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V

    iget-object v0, v7, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v11, v11, 0xb

    goto :goto_2

    :cond_6
    aget-byte v0, v10, v1

    const/16 v14, 0x29

    if-ne v0, v14, :cond_d

    array-length v0, v10

    const/16 v15, 0x10

    if-ge v1, v0, :cond_8

    aget-byte v0, v10, v1

    if-eq v0, v11, :cond_8

    aget-byte v0, v10, v1

    if-eq v0, v13, :cond_8

    aget-byte v0, v10, v1

    if-ne v0, v14, :cond_7

    add-int/lit8 v1, v1, 0x3

    goto :goto_5

    :cond_7
    aget-byte v0, v10, v1

    if-ne v0, v15, :cond_8

    add-int/lit8 v1, v1, 0x1

    :cond_8
    :goto_5
    move v6, v1

    :goto_6
    array-length v0, v10

    if-ge v6, v0, :cond_f

    add-int/lit8 v0, v6, 0x1

    aget-byte v0, v10, v0

    add-int/lit8 v1, v6, 0x2

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    add-int/lit8 v0, v6, 0x3

    aget-byte v0, v10, v0

    add-int/lit8 v1, v6, 0x4

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    add-int/lit8 v0, v6, 0x5

    aget-byte v0, v10, v0

    add-int/lit8 v1, v6, 0x6

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v16

    add-int/lit8 v0, v6, 0x7

    aget-byte v0, v10, v0

    add-int/lit8 v1, v6, 0x8

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v3, v0, 0xff

    and-int/2addr v0, v12

    if-nez v0, :cond_9

    move v0, v9

    goto :goto_7

    :cond_9
    move v0, v8

    :goto_7
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    add-int/lit8 v0, v6, 0x9

    aget-byte v0, v10, v0

    add-int/lit8 v1, v6, 0xa

    aget-byte v1, v10, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v5, v0, 0xff

    and-int/2addr v0, v12

    if-nez v0, :cond_a

    move v0, v9

    goto :goto_8

    :cond_a
    move v0, v8

    :goto_8
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    new-instance v1, Ljxl/read/biff/NameRecord$NameRange;

    move-object v0, v1

    move-object v8, v1

    move-object/from16 v1, p0

    move/from16 v17, v6

    move/from16 v6, v16

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V

    iget-object v0, v7, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v6, v17, 0xb

    array-length v0, v10

    if-ge v6, v0, :cond_c

    aget-byte v0, v10, v6

    if-eq v0, v11, :cond_c

    aget-byte v0, v10, v6

    if-eq v0, v13, :cond_c

    aget-byte v0, v10, v6

    if-ne v0, v14, :cond_b

    add-int/lit8 v6, v6, 0x3

    goto :goto_9

    :cond_b
    aget-byte v0, v10, v6

    if-ne v0, v15, :cond_c

    add-int/lit8 v6, v6, 0x1

    :cond_c
    :goto_9
    const/4 v8, 0x0

    goto/16 :goto_6

    :cond_d
    iget-object v0, v7, Ljxl/read/biff/NameRecord;->name:Ljava/lang/String;

    if-eqz v0, :cond_e

    goto :goto_a

    :cond_e
    iget-object v0, v7, Ljxl/read/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    invoke-virtual {v0}, Ljxl/biff/BuiltInName;->getName()Ljava/lang/String;

    move-result-object v0

    :goto_a
    sget-object v1, Ljxl/read/biff/NameRecord;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Cannot read name ranges for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v0, " - setting to empty"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    new-instance v8, Ljxl/read/biff/NameRecord$NameRange;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, v8

    move-object/from16 v1, p0

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_1

    :catchall_0
    sget-object v0, Ljxl/read/biff/NameRecord;->logger:Ljxl/common/Logger;

    const-string v1, "Cannot read name"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const-string v0, "ERROR"

    iput-object v0, v7, Ljxl/read/biff/NameRecord;->name:Ljava/lang/String;

    :cond_f
    :goto_b
    return-void
.end method

.method constructor <init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;ILjxl/read/biff/NameRecord$Biff7;)V
    .locals 11

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    const/4 p1, 0x0

    iput p1, p0, Ljxl/read/biff/NameRecord;->sheetRef:I

    iput p3, p0, Ljxl/read/biff/NameRecord;->index:I

    iput-boolean p1, p0, Ljxl/read/biff/NameRecord;->isbiff8:Z

    :try_start_0
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 p3, 0x3

    aget-byte p3, p1, p3

    const/16 p4, 0x8

    aget-byte p4, p1, p4

    const/16 v0, 0x9

    aget-byte v0, p1, v0

    invoke-static {p4, v0}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p4

    iput p4, p0, Ljxl/read/biff/NameRecord;->sheetRef:I

    const/16 p4, 0xe

    invoke-static {p1, p3, p4, p2}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Ljxl/read/biff/NameRecord;->name:Ljava/lang/String;

    add-int/2addr p3, p4

    array-length p2, p1

    if-lt p3, p2, :cond_0

    return-void

    :cond_0
    aget-byte p2, p1, p3

    const/16 p4, 0x3a

    if-ne p2, p4, :cond_1

    add-int/lit8 p2, p3, 0xb

    aget-byte p2, p1, p2

    add-int/lit8 p4, p3, 0xc

    aget-byte p4, p1, p4

    invoke-static {p2, p4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    add-int/lit8 p2, p3, 0xf

    aget-byte p2, p1, p2

    add-int/lit8 p4, p3, 0x10

    aget-byte p4, p1, p4

    invoke-static {p2, p4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v6

    add-int/lit8 p3, p3, 0x11

    aget-byte v5, p1, p3

    new-instance p1, Ljxl/read/biff/NameRecord$NameRange;

    move-object v0, p1

    move-object v1, p0

    move v3, v5

    move v4, v6

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V

    iget-object p2, p0, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_4

    :cond_1
    aget-byte p2, p1, p3

    const/16 v0, 0x3b

    if-ne p2, v0, :cond_2

    :goto_0
    array-length p2, p1

    if-ge p3, p2, :cond_6

    add-int/lit8 p2, p3, 0xb

    aget-byte p2, p1, p2

    add-int/lit8 p4, p3, 0xc

    aget-byte p4, p1, p4

    invoke-static {p2, p4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    add-int/lit8 p2, p3, 0xf

    aget-byte p2, p1, p2

    add-int/lit8 p4, p3, 0x10

    aget-byte p4, p1, p4

    invoke-static {p2, p4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v4

    add-int/lit8 p2, p3, 0x11

    aget-byte p2, p1, p2

    add-int/lit8 p4, p3, 0x12

    aget-byte p4, p1, p4

    invoke-static {p2, p4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v6

    add-int/lit8 p2, p3, 0x13

    aget-byte v3, p1, p2

    add-int/lit8 p2, p3, 0x14

    aget-byte v5, p1, p2

    new-instance p2, Ljxl/read/biff/NameRecord$NameRange;

    move-object v0, p2

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V

    iget-object p4, p0, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {p4, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x15

    goto :goto_0

    :cond_2
    aget-byte p2, p1, p3

    const/16 v1, 0x29

    if-ne p2, v1, :cond_6

    array-length p2, p1

    const/16 v2, 0x10

    if-ge p3, p2, :cond_4

    aget-byte p2, p1, p3

    if-eq p2, p4, :cond_4

    aget-byte p2, p1, p3

    if-eq p2, v0, :cond_4

    aget-byte p2, p1, p3

    if-ne p2, v1, :cond_3

    :goto_1
    add-int/lit8 p3, p3, 0x3

    goto :goto_3

    :cond_3
    aget-byte p2, p1, p3

    if-ne p2, v2, :cond_4

    :goto_2
    add-int/lit8 p3, p3, 0x1

    :cond_4
    :goto_3
    array-length p2, p1

    if-ge p3, p2, :cond_6

    add-int/lit8 p2, p3, 0xb

    aget-byte p2, p1, p2

    add-int/lit8 v3, p3, 0xc

    aget-byte v3, p1, v3

    invoke-static {p2, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v6

    add-int/lit8 p2, p3, 0xf

    aget-byte p2, p1, p2

    add-int/lit8 v3, p3, 0x10

    aget-byte v3, p1, v3

    invoke-static {p2, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v8

    add-int/lit8 p2, p3, 0x11

    aget-byte p2, p1, p2

    add-int/lit8 v3, p3, 0x12

    aget-byte v3, p1, v3

    invoke-static {p2, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v10

    add-int/lit8 p2, p3, 0x13

    aget-byte v7, p1, p2

    add-int/lit8 p2, p3, 0x14

    aget-byte v9, p1, p2

    new-instance p2, Ljxl/read/biff/NameRecord$NameRange;

    move-object v4, p2

    move-object v5, p0

    invoke-direct/range {v4 .. v10}, Ljxl/read/biff/NameRecord$NameRange;-><init>(Ljxl/read/biff/NameRecord;IIIII)V

    iget-object v3, p0, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v3, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x15

    array-length p2, p1

    if-ge p3, p2, :cond_4

    aget-byte p2, p1, p3

    if-eq p2, p4, :cond_4

    aget-byte p2, p1, p3

    if-eq p2, v0, :cond_4

    aget-byte p2, p1, p3

    if-ne p2, v1, :cond_5

    goto :goto_1

    :cond_5
    aget-byte p2, p1, p3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne p2, v2, :cond_4

    goto :goto_2

    :catchall_0
    sget-object p1, Ljxl/read/biff/NameRecord;->logger:Ljxl/common/Logger;

    const-string p2, "Cannot read name."

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const-string p1, "ERROR"

    iput-object p1, p0, Ljxl/read/biff/NameRecord;->name:Ljava/lang/String;

    :cond_6
    :goto_4
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
.method public getBuiltInName()Ljxl/biff/BuiltInName;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/NameRecord;->builtInName:Ljxl/biff/BuiltInName;

    return-object v0
.end method

.method public getData()[B
    .locals 1

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v0

    return-object v0
.end method

.method getIndex()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/NameRecord;->index:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/NameRecord;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getRanges()[Ljxl/read/biff/NameRecord$NameRange;
    .locals 2

    iget-object v0, p0, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljxl/read/biff/NameRecord$NameRange;

    iget-object v1, p0, Ljxl/read/biff/NameRecord;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljxl/read/biff/NameRecord$NameRange;

    return-object v0
.end method

.method public getSheetRef()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/NameRecord;->sheetRef:I

    return v0
.end method

.method public isBiff8()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/read/biff/NameRecord;->isbiff8:Z

    return v0
.end method

.method public isGlobal()Z
    .locals 1

    iget v0, p0, Ljxl/read/biff/NameRecord;->sheetRef:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public setSheetRef(I)V
    .locals 0

    iput p1, p0, Ljxl/read/biff/NameRecord;->sheetRef:I

    return-void
.end method
