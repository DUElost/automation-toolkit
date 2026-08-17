.class public Ljxl/biff/drawing/SheetDrawingWriter;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$biff$drawing$SheetDrawingWriter:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private charts:[Ljxl/biff/drawing/Chart;

.field private drawings:Ljava/util/ArrayList;

.field private drawingsModified:Z

.field private workbookSettings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/SheetDrawingWriter;->class$jxl$biff$drawing$SheetDrawingWriter:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.SheetDrawingWriter"

    invoke-static {v0}, Ljxl/biff/drawing/SheetDrawingWriter;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/SheetDrawingWriter;->class$jxl$biff$drawing$SheetDrawingWriter:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/SheetDrawingWriter;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/WorkbookSettings;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    new-array p1, p1, [Ljxl/biff/drawing/Chart;

    iput-object p1, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

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

.method private writeUnmodified(Ljxl/write/biff/File;)V
    .locals 14

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v0, v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v0, v0

    if-nez v0, :cond_3

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v1}, Ljxl/biff/drawing/DrawingGroupObject;->getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    invoke-interface {v1, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeAdditionalRecords(Ljxl/write/biff/File;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v1, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeTailRecords(Ljxl/write/biff/File;)V

    goto :goto_1

    :cond_2
    return-void

    :cond_3
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_7

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v0, v0

    if-eqz v0, :cond_7

    :goto_2
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v2, v0

    if-ge v1, v2, :cond_6

    aget-object v0, v0, v1

    invoke-virtual {v0}, Ljxl/biff/drawing/Chart;->getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;

    move-result-object v2

    if-eqz v2, :cond_4

    invoke-virtual {v0}, Ljxl/biff/drawing/Chart;->getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_4
    invoke-virtual {v0}, Ljxl/biff/drawing/Chart;->getObjRecord()Ljxl/biff/drawing/ObjRecord;

    move-result-object v2

    if-eqz v2, :cond_5

    invoke-virtual {v0}, Ljxl/biff/drawing/Chart;->getObjRecord()Ljxl/biff/drawing/ObjRecord;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_5
    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_6
    return-void

    :cond_7
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v2, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v3, v2

    add-int/2addr v3, v0

    new-array v4, v3, [Ljxl/biff/drawing/EscherContainer;

    array-length v2, v2

    add-int/2addr v2, v0

    new-array v2, v2, [Z

    move v5, v1

    move v6, v5

    :goto_3
    const/4 v7, 0x1

    if-ge v5, v0, :cond_a

    iget-object v8, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v8, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v8}, Ljxl/biff/drawing/DrawingGroupObject;->getSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v9

    aput-object v9, v4, v5

    if-lez v5, :cond_8

    aget-object v9, v4, v5

    invoke-virtual {v9}, Ljxl/biff/drawing/EscherRecord;->getLength()I

    move-result v9

    add-int/2addr v6, v9

    :cond_8
    invoke-interface {v8}, Ljxl/biff/drawing/DrawingGroupObject;->isFormObject()Z

    move-result v8

    if-eqz v8, :cond_9

    aput-boolean v7, v2, v5

    :cond_9
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    :cond_a
    move v5, v1

    :goto_4
    iget-object v8, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v9, v8

    if-ge v5, v9, :cond_b

    add-int v9, v5, v0

    aget-object v8, v8, v5

    invoke-virtual {v8}, Ljxl/biff/drawing/Chart;->getSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v8

    aput-object v8, v4, v9

    aget-object v8, v4, v9

    invoke-virtual {v8}, Ljxl/biff/drawing/EscherRecord;->getLength()I

    move-result v8

    add-int/2addr v6, v8

    add-int/lit8 v5, v5, 0x1

    goto :goto_4

    :cond_b
    new-instance v5, Ljxl/biff/drawing/DgContainer;

    invoke-direct {v5}, Ljxl/biff/drawing/DgContainer;-><init>()V

    new-instance v8, Ljxl/biff/drawing/Dg;

    iget-object v9, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v9, v9

    add-int/2addr v9, v0

    invoke-direct {v8, v9}, Ljxl/biff/drawing/Dg;-><init>(I)V

    invoke-virtual {v5, v8}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v8, Ljxl/biff/drawing/SpgrContainer;

    invoke-direct {v8}, Ljxl/biff/drawing/SpgrContainer;-><init>()V

    new-instance v9, Ljxl/biff/drawing/SpContainer;

    invoke-direct {v9}, Ljxl/biff/drawing/SpContainer;-><init>()V

    new-instance v10, Ljxl/biff/drawing/Spgr;

    invoke-direct {v10}, Ljxl/biff/drawing/Spgr;-><init>()V

    invoke-virtual {v9, v10}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v10, Ljxl/biff/drawing/Sp;

    sget-object v11, Ljxl/biff/drawing/ShapeType;->MIN:Ljxl/biff/drawing/ShapeType;

    const/16 v12, 0x400

    const/4 v13, 0x5

    invoke-direct {v10, v11, v12, v13}, Ljxl/biff/drawing/Sp;-><init>(Ljxl/biff/drawing/ShapeType;II)V

    invoke-virtual {v9, v10}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v8, v9}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    aget-object v9, v4, v1

    invoke-virtual {v8, v9}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v5, v8}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v5}, Ljxl/biff/drawing/EscherContainer;->getData()[B

    move-result-object v5

    const/4 v8, 0x4

    aget-byte v9, v5, v8

    aget-byte v10, v5, v13

    const/4 v11, 0x6

    aget-byte v11, v5, v11

    const/4 v12, 0x7

    aget-byte v12, v5, v12

    invoke-static {v9, v10, v11, v12}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v9

    add-int/2addr v9, v6

    invoke-static {v9, v5, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    const/16 v8, 0x1c

    aget-byte v9, v5, v8

    const/16 v10, 0x1d

    aget-byte v10, v5, v10

    const/16 v11, 0x1e

    aget-byte v11, v5, v11

    const/16 v12, 0x1f

    aget-byte v12, v5, v12

    invoke-static {v9, v10, v11, v12}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v9

    add-int/2addr v9, v6

    invoke-static {v9, v5, v8}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    aget-boolean v6, v2, v1

    if-ne v6, v7, :cond_c

    array-length v6, v5

    add-int/lit8 v6, v6, -0x8

    new-array v8, v6, [B

    invoke-static {v5, v1, v8, v1, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v5, v8

    :cond_c
    new-instance v6, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {v6, v5}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>([B)V

    invoke-virtual {p1, v6}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v5, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeAdditionalRecords(Ljxl/write/biff/File;)V

    move v5, v7

    :goto_5
    if-ge v5, v3, :cond_f

    aget-object v6, v4, v5

    invoke-virtual {v6}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object v6

    aget-object v8, v4, v5

    invoke-virtual {v8, v6}, Ljxl/biff/drawing/EscherRecord;->setHeaderData([B)[B

    move-result-object v6

    aget-boolean v8, v2, v5

    if-ne v8, v7, :cond_d

    array-length v8, v6

    add-int/lit8 v8, v8, -0x8

    new-array v9, v8, [B

    invoke-static {v6, v1, v9, v1, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v6, v9

    :cond_d
    new-instance v8, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {v8, v6}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>([B)V

    invoke-virtual {p1, v8}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    if-ge v5, v0, :cond_e

    iget-object v6, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v6, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeAdditionalRecords(Ljxl/write/biff/File;)V

    goto :goto_6

    :cond_e
    iget-object v6, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    sub-int v8, v5, v0

    aget-object v6, v6, v8

    invoke-virtual {v6}, Ljxl/biff/drawing/Chart;->getObjRecord()Ljxl/biff/drawing/ObjRecord;

    move-result-object v8

    invoke-virtual {p1, v8}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    invoke-virtual {p1, v6}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :goto_6
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    :cond_f
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_7
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_10

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v1, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeTailRecords(Ljxl/write/biff/File;)V

    goto :goto_7

    :cond_10
    return-void
.end method


# virtual methods
.method public getCharts()[Ljxl/biff/drawing/Chart;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    return-object v0
.end method

.method public setCharts([Ljxl/biff/drawing/Chart;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    return-void
.end method

.method public setDrawings(Ljava/util/ArrayList;Z)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    iput-boolean p2, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawingsModified:Z

    return-void
.end method

.method public write(Ljxl/write/biff/File;)V
    .locals 14

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v0, v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-boolean v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawingsModified:Z

    iget-object v1, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget-object v2, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/4 v4, 0x1

    if-eqz v3, :cond_2

    if-nez v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v3}, Ljxl/biff/drawing/DrawingGroupObject;->getOrigin()Ljxl/biff/drawing/Origin;

    move-result-object v3

    sget-object v5, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-eq v3, v5, :cond_1

    move v0, v4

    goto :goto_0

    :cond_2
    const/4 v2, 0x0

    if-lez v1, :cond_3

    if-nez v0, :cond_3

    iget-object v3, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v3}, Ljxl/biff/drawing/DrawingGroupObject;->isFirst()Z

    move-result v3

    if-nez v3, :cond_3

    move v0, v4

    :cond_3
    if-nez v1, :cond_4

    iget-object v3, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v5, v3

    if-ne v5, v4, :cond_4

    aget-object v3, v3, v2

    invoke-virtual {v3}, Ljxl/biff/drawing/Chart;->getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;

    move-result-object v3

    if-nez v3, :cond_4

    move v0, v2

    :cond_4
    if-nez v0, :cond_5

    invoke-direct {p0, p1}, Ljxl/biff/drawing/SheetDrawingWriter;->writeUnmodified(Ljxl/write/biff/File;)V

    return-void

    :cond_5
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v0, v0

    add-int/2addr v0, v1

    new-array v3, v0, [Ljava/lang/Object;

    const/4 v5, 0x0

    move v6, v2

    move v7, v6

    :goto_1
    if-ge v6, v1, :cond_8

    iget-object v8, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v8, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v8}, Ljxl/biff/drawing/DrawingGroupObject;->getSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v8

    if-eqz v8, :cond_7

    invoke-virtual {v8}, Ljxl/biff/drawing/EscherContainer;->getData()[B

    move-result-object v9

    aput-object v9, v3, v6

    if-nez v6, :cond_6

    move-object v5, v8

    goto :goto_2

    :cond_6
    array-length v8, v9

    add-int/2addr v7, v8

    :cond_7
    :goto_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    :cond_8
    move v6, v2

    :goto_3
    iget-object v8, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v9, v8

    if-ge v6, v9, :cond_a

    aget-object v8, v8, v6

    invoke-virtual {v8}, Ljxl/biff/drawing/Chart;->getSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v8

    invoke-virtual {v8}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object v9

    invoke-virtual {v8, v9}, Ljxl/biff/drawing/EscherRecord;->setHeaderData([B)[B

    move-result-object v9

    add-int v10, v6, v1

    aput-object v9, v3, v10

    if-nez v6, :cond_9

    if-nez v1, :cond_9

    move-object v5, v8

    goto :goto_4

    :cond_9
    array-length v8, v9

    add-int/2addr v7, v8

    :goto_4
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    :cond_a
    new-instance v6, Ljxl/biff/drawing/DgContainer;

    invoke-direct {v6}, Ljxl/biff/drawing/DgContainer;-><init>()V

    new-instance v8, Ljxl/biff/drawing/Dg;

    iget-object v9, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    array-length v9, v9

    add-int/2addr v9, v1

    invoke-direct {v8, v9}, Ljxl/biff/drawing/Dg;-><init>(I)V

    invoke-virtual {v6, v8}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v8, Ljxl/biff/drawing/SpgrContainer;

    invoke-direct {v8}, Ljxl/biff/drawing/SpgrContainer;-><init>()V

    new-instance v9, Ljxl/biff/drawing/SpContainer;

    invoke-direct {v9}, Ljxl/biff/drawing/SpContainer;-><init>()V

    new-instance v10, Ljxl/biff/drawing/Spgr;

    invoke-direct {v10}, Ljxl/biff/drawing/Spgr;-><init>()V

    invoke-virtual {v9, v10}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v10, Ljxl/biff/drawing/Sp;

    sget-object v11, Ljxl/biff/drawing/ShapeType;->MIN:Ljxl/biff/drawing/ShapeType;

    const/16 v12, 0x400

    const/4 v13, 0x5

    invoke-direct {v10, v11, v12, v13}, Ljxl/biff/drawing/Sp;-><init>(Ljxl/biff/drawing/ShapeType;II)V

    invoke-virtual {v9, v10}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v8, v9}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v8, v5}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v6, v8}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    invoke-virtual {v6}, Ljxl/biff/drawing/EscherContainer;->getData()[B

    move-result-object v5

    const/4 v6, 0x4

    aget-byte v8, v5, v6

    aget-byte v9, v5, v13

    const/4 v10, 0x6

    aget-byte v10, v5, v10

    const/4 v11, 0x7

    aget-byte v11, v5, v11

    invoke-static {v8, v9, v10, v11}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v8

    add-int/2addr v8, v7

    invoke-static {v8, v5, v6}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    const/16 v6, 0x1c

    aget-byte v8, v5, v6

    const/16 v9, 0x1d

    aget-byte v9, v5, v9

    const/16 v10, 0x1e

    aget-byte v10, v5, v10

    const/16 v11, 0x1f

    aget-byte v11, v5, v11

    invoke-static {v8, v9, v10, v11}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v8

    add-int/2addr v8, v7

    invoke-static {v8, v5, v6}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    if-lez v1, :cond_b

    iget-object v6, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v6, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v6}, Ljxl/biff/drawing/DrawingGroupObject;->isFormObject()Z

    move-result v6

    if-eqz v6, :cond_b

    array-length v6, v5

    add-int/lit8 v6, v6, -0x8

    new-array v7, v6, [B

    invoke-static {v5, v2, v7, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v5, v7

    :cond_b
    new-instance v6, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {v6, v5}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>([B)V

    invoke-virtual {p1, v6}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    if-lez v1, :cond_c

    iget-object v5, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v5, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeAdditionalRecords(Ljxl/write/biff/File;)V

    goto :goto_5

    :cond_c
    iget-object v5, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    aget-object v5, v5, v2

    invoke-virtual {v5}, Ljxl/biff/drawing/Chart;->getObjRecord()Ljxl/biff/drawing/ObjRecord;

    move-result-object v6

    invoke-virtual {p1, v6}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    invoke-virtual {p1, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :goto_5
    if-ge v4, v0, :cond_f

    aget-object v5, v3, v4

    check-cast v5, [B

    if-ge v4, v1, :cond_d

    iget-object v6, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v6, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v6}, Ljxl/biff/drawing/DrawingGroupObject;->isFormObject()Z

    move-result v6

    if-eqz v6, :cond_d

    array-length v6, v5

    add-int/lit8 v6, v6, -0x8

    new-array v7, v6, [B

    invoke-static {v5, v2, v7, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v5, v7

    :cond_d
    new-instance v6, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {v6, v5}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>([B)V

    invoke-virtual {p1, v6}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    if-ge v4, v1, :cond_e

    iget-object v5, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v5, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeAdditionalRecords(Ljxl/write/biff/File;)V

    goto :goto_6

    :cond_e
    iget-object v5, p0, Ljxl/biff/drawing/SheetDrawingWriter;->charts:[Ljxl/biff/drawing/Chart;

    sub-int v6, v4, v1

    aget-object v5, v5, v6

    invoke-virtual {v5}, Ljxl/biff/drawing/Chart;->getObjRecord()Ljxl/biff/drawing/ObjRecord;

    move-result-object v6

    invoke-virtual {p1, v6}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    invoke-virtual {p1, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :goto_6
    add-int/lit8 v4, v4, 0x1

    goto :goto_5

    :cond_f
    iget-object v0, p0, Ljxl/biff/drawing/SheetDrawingWriter;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_7
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_10

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/drawing/DrawingGroupObject;

    invoke-interface {v1, p1}, Ljxl/biff/drawing/DrawingGroupObject;->writeTailRecords(Ljxl/write/biff/File;)V

    goto :goto_7

    :cond_10
    return-void
.end method
