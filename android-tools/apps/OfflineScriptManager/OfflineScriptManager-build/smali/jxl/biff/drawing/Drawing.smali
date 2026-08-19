.class public Ljxl/biff/drawing/Drawing;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/drawing/DrawingGroupObject;
.implements Ljxl/Image;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/biff/drawing/Drawing$ImageAnchorProperties;
    }
.end annotation


# static fields
.field private static final DEFAULT_FONT_SIZE:D = 10.0

.field public static MOVE_AND_SIZE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

.field public static MOVE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

.field public static NO_MOVE_OR_SIZE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

.field static synthetic class$jxl$biff$drawing$Drawing:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private blipId:I

.field private drawingData:Ljxl/biff/drawing/DrawingData;

.field private drawingGroup:Ljxl/biff/drawing/DrawingGroup;

.field private drawingNumber:I

.field private escherData:Ljxl/biff/drawing/EscherContainer;

.field private height:D

.field private imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

.field private imageData:[B

.field private imageFile:Ljava/io/File;

.field private initialized:Z

.field private msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

.field private objRecord:Ljxl/biff/drawing/ObjRecord;

.field private objectId:I

.field private origin:Ljxl/biff/drawing/Origin;

.field private pngReader:Ljxl/biff/drawing/PNGReader;

.field private readSpContainer:Ljxl/biff/drawing/EscherContainer;

.field private referenceCount:I

.field private shapeId:I

.field private sheet:Ljxl/Sheet;

.field private type:Ljxl/biff/drawing/ShapeType;

.field private width:D

.field private x:D

.field private y:D


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Ljxl/biff/drawing/Drawing;->class$jxl$biff$drawing$Drawing:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.Drawing"

    invoke-static {v0}, Ljxl/biff/drawing/Drawing;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Drawing;->class$jxl$biff$drawing$Drawing:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;-><init>(I)V

    sput-object v0, Ljxl/biff/drawing/Drawing;->MOVE_AND_SIZE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    new-instance v0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;-><init>(I)V

    sput-object v0, Ljxl/biff/drawing/Drawing;->MOVE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    new-instance v0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;-><init>(I)V

    sput-object v0, Ljxl/biff/drawing/Drawing;->NO_MOVE_OR_SIZE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    return-void
.end method

.method public constructor <init>(DDDDLjava/io/File;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    iput-object p9, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    const/4 p9, 0x1

    iput-boolean p9, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    sget-object v0, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    iput-wide p1, p0, Ljxl/biff/drawing/Drawing;->x:D

    iput-wide p3, p0, Ljxl/biff/drawing/Drawing;->y:D

    iput-wide p5, p0, Ljxl/biff/drawing/Drawing;->width:D

    iput-wide p7, p0, Ljxl/biff/drawing/Drawing;->height:D

    iput p9, p0, Ljxl/biff/drawing/Drawing;->referenceCount:I

    sget-object p1, Ljxl/biff/drawing/Drawing;->MOVE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    sget-object p1, Ljxl/biff/drawing/ShapeType;->PICTURE_FRAME:Ljxl/biff/drawing/ShapeType;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    return-void
.end method

.method public constructor <init>(DDDD[B)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    iput-object p9, p0, Ljxl/biff/drawing/Drawing;->imageData:[B

    const/4 p9, 0x1

    iput-boolean p9, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    sget-object v0, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    iput-wide p1, p0, Ljxl/biff/drawing/Drawing;->x:D

    iput-wide p3, p0, Ljxl/biff/drawing/Drawing;->y:D

    iput-wide p5, p0, Ljxl/biff/drawing/Drawing;->width:D

    iput-wide p7, p0, Ljxl/biff/drawing/Drawing;->height:D

    iput p9, p0, Ljxl/biff/drawing/Drawing;->referenceCount:I

    sget-object p1, Ljxl/biff/drawing/Drawing;->MOVE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    sget-object p1, Ljxl/biff/drawing/ShapeType;->PICTURE_FRAME:Ljxl/biff/drawing/ShapeType;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    check-cast p1, Ljxl/biff/drawing/Drawing;

    iget-object v1, p1, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p1, Ljxl/biff/drawing/Drawing;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object v1, p0, Ljxl/biff/drawing/Drawing;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iget-object v1, p1, Ljxl/biff/drawing/Drawing;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-object v1, p0, Ljxl/biff/drawing/Drawing;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    iput-object v2, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    iget-object v0, p1, Ljxl/biff/drawing/Drawing;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/Drawing;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget p1, p1, Ljxl/biff/drawing/Drawing;->drawingNumber:I

    iput p1, p0, Ljxl/biff/drawing/Drawing;->drawingNumber:I

    invoke-virtual {p2, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/Sheet;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    iput-object p4, p0, Ljxl/biff/drawing/Drawing;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object p3, p0, Ljxl/biff/drawing/Drawing;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/Drawing;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-object p5, p0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    sget-object p4, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    iput-object p4, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    invoke-virtual {p1}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object p4

    invoke-virtual {p3, p4}, Ljxl/biff/drawing/DrawingData;->addData([B)V

    iget-object p3, p0, Ljxl/biff/drawing/Drawing;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p3}, Ljxl/biff/drawing/DrawingData;->getNumDrawings()I

    move-result p3

    const/4 p4, 0x1

    sub-int/2addr p3, p4

    iput p3, p0, Ljxl/biff/drawing/Drawing;->drawingNumber:I

    iget-object p3, p0, Ljxl/biff/drawing/Drawing;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {p3, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    move v0, p4

    :cond_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

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

.method private getHeightInPoints()D
    .locals 10

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    const-wide/16 v1, 0x0

    if-nez v0, :cond_0

    sget-object v0, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v3, "calculating image height:  sheet is null"

    invoke-virtual {v0, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return-wide v1

    :cond_0
    iget-wide v3, p0, Ljxl/biff/drawing/Drawing;->y:D

    double-to-int v0, v3

    iget-wide v5, p0, Ljxl/biff/drawing/Drawing;->height:D

    add-double/2addr v3, v5

    invoke-static {v3, v4}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v3

    double-to-int v3, v3

    add-int/lit8 v3, v3, -0x1

    iget-object v4, p0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    invoke-interface {v4, v0}, Ljxl/Sheet;->getRowView(I)Ljxl/CellView;

    move-result-object v4

    invoke-virtual {v4}, Ljxl/CellView;->getSize()I

    move-result v4

    int-to-double v4, v4

    const/4 v6, 0x0

    if-eq v3, v0, :cond_1

    iget-object v7, p0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    invoke-interface {v7, v3}, Ljxl/Sheet;->getRowView(I)Ljxl/CellView;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/CellView;->getSize()I

    move-result v7

    goto :goto_0

    :cond_1
    move v7, v6

    :goto_0
    sub-int v8, v3, v0

    add-int/lit8 v8, v8, -0x1

    if-ge v6, v8, :cond_2

    iget-object v8, p0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    add-int/lit8 v9, v0, 0x1

    add-int/2addr v9, v6

    invoke-interface {v8, v9}, Ljxl/Sheet;->getRowView(I)Ljxl/CellView;

    move-result-object v8

    invoke-virtual {v8}, Ljxl/CellView;->getSize()I

    move-result v8

    int-to-double v8, v8

    add-double/2addr v1, v8

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_2
    add-double/2addr v1, v4

    int-to-double v3, v7

    add-double/2addr v1, v3

    const-wide/high16 v3, 0x4034000000000000L    # 20.0

    div-double/2addr v1, v3

    return-wide v1
.end method

.method private getPngReader()Ljxl/biff/drawing/PNGReader;
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->pngReader:Ljxl/biff/drawing/PNGReader;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-eq v0, v1, :cond_2

    sget-object v1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    goto :goto_0

    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing;->getImageBytes()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    sget-object v0, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v1, "Could not read image file"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const/4 v0, 0x0

    new-array v0, v0, [B

    goto :goto_1

    :cond_2
    :goto_0
    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing;->getImageData()[B

    move-result-object v0

    :goto_1
    new-instance v1, Ljxl/biff/drawing/PNGReader;

    invoke-direct {v1, v0}, Ljxl/biff/drawing/PNGReader;-><init>([B)V

    iput-object v1, p0, Ljxl/biff/drawing/Drawing;->pngReader:Ljxl/biff/drawing/PNGReader;

    invoke-virtual {v1}, Ljxl/biff/drawing/PNGReader;->read()V

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->pngReader:Ljxl/biff/drawing/PNGReader;

    return-object v0
.end method

.method private getReadSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    return-object v0
.end method

.method private getWidthInPoints()D
    .locals 17

    move-object/from16 v0, p0

    iget-object v1, v0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    const-wide/16 v2, 0x0

    if-nez v1, :cond_0

    sget-object v1, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v4, "calculating image width:  sheet is null"

    invoke-virtual {v1, v4}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return-wide v2

    :cond_0
    iget-wide v4, v0, Ljxl/biff/drawing/Drawing;->x:D

    double-to-int v1, v4

    iget-wide v6, v0, Ljxl/biff/drawing/Drawing;->width:D

    add-double/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v4

    double-to-int v4, v4

    add-int/lit8 v4, v4, -0x1

    iget-object v5, v0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    invoke-interface {v5, v1}, Ljxl/Sheet;->getColumnView(I)Ljxl/CellView;

    move-result-object v5

    invoke-virtual {v5}, Ljxl/CellView;->getSize()I

    move-result v6

    const-wide/high16 v7, 0x3ff0000000000000L    # 1.0

    iget-wide v9, v0, Ljxl/biff/drawing/Drawing;->x:D

    int-to-double v11, v1

    sub-double/2addr v9, v11

    sub-double/2addr v7, v9

    int-to-double v9, v6

    mul-double/2addr v7, v9

    invoke-virtual {v5}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v6

    if-eqz v6, :cond_1

    invoke-virtual {v5}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v5

    invoke-interface {v5}, Ljxl/format/CellFormat;->getFont()Ljxl/format/Font;

    move-result-object v5

    invoke-interface {v5}, Ljxl/format/Font;->getPointSize()I

    move-result v5

    int-to-double v5, v5

    goto :goto_0

    :cond_1
    const-wide/high16 v5, 0x4024000000000000L    # 10.0

    :goto_0
    const-wide v11, 0x3fe2e147ae147ae1L    # 0.59

    mul-double/2addr v7, v11

    mul-double/2addr v7, v5

    const-wide/high16 v5, 0x4070000000000000L    # 256.0

    div-double/2addr v7, v5

    if-eq v4, v1, :cond_3

    iget-object v13, v0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    invoke-interface {v13, v4}, Ljxl/Sheet;->getColumnView(I)Ljxl/CellView;

    move-result-object v13

    invoke-virtual {v13}, Ljxl/CellView;->getSize()I

    move-result v14

    iget-wide v2, v0, Ljxl/biff/drawing/Drawing;->x:D

    iget-wide v9, v0, Ljxl/biff/drawing/Drawing;->width:D

    add-double/2addr v2, v9

    int-to-double v9, v4

    sub-double/2addr v2, v9

    int-to-double v9, v14

    mul-double/2addr v2, v9

    invoke-virtual {v13}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v9

    if-eqz v9, :cond_2

    invoke-virtual {v13}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v9

    invoke-interface {v9}, Ljxl/format/CellFormat;->getFont()Ljxl/format/Font;

    move-result-object v9

    invoke-interface {v9}, Ljxl/format/Font;->getPointSize()I

    move-result v9

    int-to-double v9, v9

    goto :goto_1

    :cond_2
    const-wide/high16 v9, 0x4024000000000000L    # 10.0

    :goto_1
    mul-double/2addr v2, v11

    mul-double/2addr v2, v9

    div-double/2addr v2, v5

    goto :goto_2

    :cond_3
    const-wide/16 v2, 0x0

    :goto_2
    const/4 v9, 0x0

    const-wide/16 v15, 0x0

    :goto_3
    sub-int v10, v4, v1

    add-int/lit8 v10, v10, -0x1

    if-ge v9, v10, :cond_5

    iget-object v10, v0, Ljxl/biff/drawing/Drawing;->sheet:Ljxl/Sheet;

    add-int/lit8 v13, v1, 0x1

    add-int/2addr v13, v9

    invoke-interface {v10, v13}, Ljxl/Sheet;->getColumnView(I)Ljxl/CellView;

    move-result-object v10

    invoke-virtual {v10}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v13

    if-eqz v13, :cond_4

    invoke-virtual {v10}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v13

    invoke-interface {v13}, Ljxl/format/CellFormat;->getFont()Ljxl/format/Font;

    move-result-object v13

    invoke-interface {v13}, Ljxl/format/Font;->getPointSize()I

    move-result v13

    int-to-double v13, v13

    goto :goto_4

    :cond_4
    const-wide/high16 v13, 0x4024000000000000L    # 10.0

    :goto_4
    invoke-virtual {v10}, Ljxl/CellView;->getSize()I

    move-result v10

    int-to-double v5, v10

    mul-double/2addr v5, v11

    mul-double/2addr v5, v13

    const-wide/high16 v13, 0x4070000000000000L    # 256.0

    div-double/2addr v5, v13

    add-double/2addr v15, v5

    add-int/lit8 v9, v9, 0x1

    move-wide v5, v13

    goto :goto_3

    :cond_5
    add-double/2addr v15, v7

    add-double/2addr v15, v2

    return-wide v15
.end method

.method private initialize()V
    .locals 6

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget v1, p0, Ljxl/biff/drawing/Drawing;->drawingNumber:I

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/DrawingData;->getSpContainer(I)Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v0}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v0

    iget-object v3, p0, Ljxl/biff/drawing/Drawing;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v3}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v3

    aget-object v3, v3, v1

    check-cast v3, Ljxl/biff/drawing/Sp;

    invoke-virtual {v3}, Ljxl/biff/drawing/Sp;->getShapeId()I

    move-result v4

    iput v4, p0, Ljxl/biff/drawing/Drawing;->shapeId:I

    iget-object v4, p0, Ljxl/biff/drawing/Drawing;->objRecord:Ljxl/biff/drawing/ObjRecord;

    invoke-virtual {v4}, Ljxl/biff/drawing/ObjRecord;->getObjectId()I

    move-result v4

    iput v4, p0, Ljxl/biff/drawing/Drawing;->objectId:I

    invoke-virtual {v3}, Ljxl/biff/drawing/Sp;->getShapeType()I

    move-result v3

    invoke-static {v3}, Ljxl/biff/drawing/ShapeType;->getType(I)Ljxl/biff/drawing/ShapeType;

    move-result-object v3

    iput-object v3, p0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    sget-object v4, Ljxl/biff/drawing/ShapeType;->UNKNOWN:Ljxl/biff/drawing/ShapeType;

    if-ne v3, v4, :cond_1

    sget-object v3, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v4, "Unknown shape type"

    invoke-virtual {v3, v4}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_1
    iget-object v3, p0, Ljxl/biff/drawing/Drawing;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v3}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v3

    aget-object v3, v3, v2

    check-cast v3, Ljxl/biff/drawing/Opt;

    const/16 v4, 0x104

    invoke-virtual {v3, v4}, Ljxl/biff/drawing/Opt;->getProperty(I)Ljxl/biff/drawing/Opt$Property;

    move-result-object v5

    if-eqz v5, :cond_2

    invoke-virtual {v3, v4}, Ljxl/biff/drawing/Opt;->getProperty(I)Ljxl/biff/drawing/Opt$Property;

    move-result-object v4

    iget v4, v4, Ljxl/biff/drawing/Opt$Property;->value:I

    iput v4, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    :cond_2
    const/16 v4, 0x105

    invoke-virtual {v3, v4}, Ljxl/biff/drawing/Opt;->getProperty(I)Ljxl/biff/drawing/Opt$Property;

    move-result-object v5

    if-eqz v5, :cond_3

    new-instance v5, Ljava/io/File;

    invoke-virtual {v3, v4}, Ljxl/biff/drawing/Opt;->getProperty(I)Ljxl/biff/drawing/Opt$Property;

    move-result-object v3

    iget-object v3, v3, Ljxl/biff/drawing/Opt$Property;->stringValue:Ljava/lang/String;

    invoke-direct {v5, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v5, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    goto :goto_1

    :cond_3
    iget-object v3, p0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    sget-object v4, Ljxl/biff/drawing/ShapeType;->PICTURE_FRAME:Ljxl/biff/drawing/ShapeType;

    if-ne v3, v4, :cond_4

    sget-object v3, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v4, "no filename property for drawing"

    invoke-virtual {v3, v4}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    new-instance v3, Ljava/io/File;

    iget v4, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v3, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    :cond_4
    :goto_1
    const/4 v3, 0x0

    :goto_2
    array-length v4, v0

    if-ge v1, v4, :cond_6

    if-nez v3, :cond_6

    aget-object v4, v0, v1

    invoke-virtual {v4}, Ljxl/biff/drawing/EscherRecord;->getType()Ljxl/biff/drawing/EscherRecordType;

    move-result-object v4

    sget-object v5, Ljxl/biff/drawing/EscherRecordType;->CLIENT_ANCHOR:Ljxl/biff/drawing/EscherRecordType;

    if-ne v4, v5, :cond_5

    aget-object v3, v0, v1

    check-cast v3, Ljxl/biff/drawing/ClientAnchor;

    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_6
    if-nez v3, :cond_7

    sget-object v0, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v1, "client anchor not found"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_3

    :cond_7
    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getX1()D

    move-result-wide v0

    iput-wide v0, p0, Ljxl/biff/drawing/Drawing;->x:D

    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getY1()D

    move-result-wide v0

    iput-wide v0, p0, Ljxl/biff/drawing/Drawing;->y:D

    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getX2()D

    move-result-wide v0

    iget-wide v4, p0, Ljxl/biff/drawing/Drawing;->x:D

    sub-double/2addr v0, v4

    iput-wide v0, p0, Ljxl/biff/drawing/Drawing;->width:D

    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getY2()D

    move-result-wide v0

    iget-wide v4, p0, Ljxl/biff/drawing/Drawing;->y:D

    sub-double/2addr v0, v4

    iput-wide v0, p0, Ljxl/biff/drawing/Drawing;->height:D

    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getProperties()I

    move-result v0

    invoke-static {v0}, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->getImageAnchorProperties(I)Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    :goto_3
    iget v0, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    if-nez v0, :cond_8

    sget-object v0, Ljxl/biff/drawing/Drawing;->logger:Ljxl/common/Logger;

    const-string v1, "linked drawings are not supported"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_8
    iput-boolean v2, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    return-void
.end method


# virtual methods
.method public final getBlipId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    return v0
.end method

.method public getColumn()D
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing;->getX()D

    move-result-wide v0

    return-wide v0
.end method

.method public getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-object v0
.end method

.method public getHeight()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing;->height:D

    return-wide v0
.end method

.method public getHeight(Ljxl/common/LengthUnit;)D
    .locals 4

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->getHeightInPoints()D

    move-result-wide v0

    sget-object v2, Ljxl/common/LengthUnit;->POINTS:Ljxl/common/LengthUnit;

    invoke-static {v2, p1}, Ljxl/common/LengthConverter;->getConversionFactor(Ljxl/common/LengthUnit;Ljxl/common/LengthUnit;)D

    move-result-wide v2

    mul-double/2addr v0, v2

    return-wide v0
.end method

.method public getHorizontalResolution(Ljxl/common/LengthUnit;)D
    .locals 4

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->getPngReader()Ljxl/biff/drawing/PNGReader;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/biff/drawing/PNGReader;->getHorizontalResolution()I

    move-result v0

    int-to-double v0, v0

    sget-object v2, Ljxl/common/LengthUnit;->METRES:Ljxl/common/LengthUnit;

    invoke-static {v2, p1}, Ljxl/common/LengthConverter;->getConversionFactor(Ljxl/common/LengthUnit;Ljxl/common/LengthUnit;)D

    move-result-wide v2

    div-double/2addr v0, v2

    return-wide v0
.end method

.method protected getImageAnchor()Ljxl/biff/drawing/Drawing$ImageAnchorProperties;
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    return-object v0
.end method

.method public getImageBytes()[B
    .locals 5

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-eq v0, v1, :cond_4

    sget-object v1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_0

    goto :goto_2

    :cond_0
    sget-object v1, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ne v0, v1, :cond_1

    move v0, v2

    goto :goto_0

    :cond_1
    move v0, v3

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    if-nez v0, :cond_3

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->imageData:[B

    if-eqz v0, :cond_2

    goto :goto_1

    :cond_2
    move v2, v3

    :goto_1
    invoke-static {v2}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->imageData:[B

    return-object v0

    :cond_3
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    long-to-int v0, v0

    new-array v1, v0, [B

    new-instance v2, Ljava/io/FileInputStream;

    iget-object v4, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    invoke-direct {v2, v4}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v2, v1, v3, v0}, Ljava/io/FileInputStream;->read([BII)I

    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V

    return-object v1

    :cond_4
    :goto_2
    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing;->getImageData()[B

    move-result-object v0

    return-object v0
.end method

.method public getImageData()[B
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-eq v0, v1, :cond_1

    sget-object v1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_2

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_2
    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget v1, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/DrawingGroup;->getImageData(I)[B

    move-result-object v0

    return-object v0
.end method

.method public getImageFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    return-object v0
.end method

.method public getImageFilePath()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    if-nez v0, :cond_1

    iget v0, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const-string v0, "__new__image__"

    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getImageHeight()I
    .locals 1

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->getPngReader()Ljxl/biff/drawing/PNGReader;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/biff/drawing/PNGReader;->getHeight()I

    move-result v0

    return v0
.end method

.method public getImageWidth()I
    .locals 1

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->getPngReader()Ljxl/biff/drawing/PNGReader;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/biff/drawing/PNGReader;->getWidth()I

    move-result v0

    return v0
.end method

.method public getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    return-object v0
.end method

.method public final getObjectId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Drawing;->objectId:I

    return v0
.end method

.method public getOrigin()Ljxl/biff/drawing/Origin;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    return-object v0
.end method

.method public getReferenceCount()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Drawing;->referenceCount:I

    return v0
.end method

.method public getRow()D
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing;->getY()D

    move-result-wide v0

    return-wide v0
.end method

.method public getShapeId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Drawing;->shapeId:I

    return v0
.end method

.method public getSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 23

    move-object/from16 v0, p0

    iget-boolean v1, v0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v1, :cond_0

    invoke-direct/range {p0 .. p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-object v1, v0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_1

    invoke-direct/range {p0 .. p0}, Ljxl/biff/drawing/Drawing;->getReadSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v1

    return-object v1

    :cond_1
    new-instance v1, Ljxl/biff/drawing/SpContainer;

    invoke-direct {v1}, Ljxl/biff/drawing/SpContainer;-><init>()V

    new-instance v2, Ljxl/biff/drawing/Sp;

    iget-object v3, v0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    iget v4, v0, Ljxl/biff/drawing/Drawing;->shapeId:I

    const/16 v5, 0xa00

    invoke-direct {v2, v3, v4, v5}, Ljxl/biff/drawing/Sp;-><init>(Ljxl/biff/drawing/ShapeType;II)V

    invoke-virtual {v1, v2}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v2, Ljxl/biff/drawing/Opt;

    invoke-direct {v2}, Ljxl/biff/drawing/Opt;-><init>()V

    const/16 v3, 0x104

    const/4 v4, 0x1

    iget v5, v0, Ljxl/biff/drawing/Drawing;->blipId:I

    const/4 v12, 0x0

    invoke-virtual {v2, v3, v4, v12, v5}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    iget-object v3, v0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    sget-object v4, Ljxl/biff/drawing/ShapeType;->PICTURE_FRAME:Ljxl/biff/drawing/ShapeType;

    if-ne v3, v4, :cond_3

    iget-object v3, v0, Ljxl/biff/drawing/Drawing;->imageFile:Ljava/io/File;

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_2
    const-string v3, ""

    :goto_0
    move-object v11, v3

    const/16 v7, 0x105

    const/4 v8, 0x1

    const/4 v9, 0x1

    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v3

    mul-int/lit8 v10, v3, 0x2

    move-object v6, v2

    invoke-virtual/range {v6 .. v11}, Ljxl/biff/drawing/Opt;->addProperty(IZZILjava/lang/String;)V

    const/16 v3, 0x1bf

    const/high16 v4, 0x10000

    invoke-virtual {v2, v3, v12, v12, v4}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    const/16 v3, 0x3bf

    const/high16 v4, 0x80000

    invoke-virtual {v2, v3, v12, v12, v4}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    invoke-virtual {v1, v2}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    :cond_3
    new-instance v2, Ljxl/biff/drawing/ClientAnchor;

    iget-wide v14, v0, Ljxl/biff/drawing/Drawing;->x:D

    iget-wide v3, v0, Ljxl/biff/drawing/Drawing;->y:D

    iget-wide v5, v0, Ljxl/biff/drawing/Drawing;->width:D

    add-double v18, v14, v5

    iget-wide v5, v0, Ljxl/biff/drawing/Drawing;->height:D

    add-double v20, v3, v5

    iget-object v5, v0, Ljxl/biff/drawing/Drawing;->imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    invoke-virtual {v5}, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->getValue()I

    move-result v22

    move-object v13, v2

    move-wide/from16 v16, v3

    invoke-direct/range {v13 .. v22}, Ljxl/biff/drawing/ClientAnchor;-><init>(DDDDI)V

    invoke-virtual {v1, v2}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v2, Ljxl/biff/drawing/ClientData;

    invoke-direct {v2}, Ljxl/biff/drawing/ClientData;-><init>()V

    invoke-virtual {v1, v2}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    return-object v1
.end method

.method public getType()Ljxl/biff/drawing/ShapeType;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->type:Ljxl/biff/drawing/ShapeType;

    return-object v0
.end method

.method public getVerticalResolution(Ljxl/common/LengthUnit;)D
    .locals 4

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->getPngReader()Ljxl/biff/drawing/PNGReader;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/biff/drawing/PNGReader;->getVerticalResolution()I

    move-result v0

    int-to-double v0, v0

    sget-object v2, Ljxl/common/LengthUnit;->METRES:Ljxl/common/LengthUnit;

    invoke-static {v2, p1}, Ljxl/common/LengthConverter;->getConversionFactor(Ljxl/common/LengthUnit;Ljxl/common/LengthUnit;)D

    move-result-wide v2

    div-double/2addr v0, v2

    return-wide v0
.end method

.method public getWidth()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing;->width:D

    return-wide v0
.end method

.method public getWidth(Ljxl/common/LengthUnit;)D
    .locals 4

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->getWidthInPoints()D

    move-result-wide v0

    sget-object v2, Ljxl/common/LengthUnit;->POINTS:Ljxl/common/LengthUnit;

    invoke-static {v2, p1}, Ljxl/common/LengthConverter;->getConversionFactor(Ljxl/common/LengthUnit;Ljxl/common/LengthUnit;)D

    move-result-wide v2

    mul-double/2addr v0, v2

    return-wide v0
.end method

.method public getX()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing;->x:D

    return-wide v0
.end method

.method public getY()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing;->y:D

    return-wide v0
.end method

.method public isFirst()Z
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-virtual {v0}, Ljxl/biff/drawing/MsoDrawingRecord;->isFirst()Z

    move-result v0

    return v0
.end method

.method public isFormObject()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public removeRow(I)V
    .locals 4

    iget-wide v0, p0, Ljxl/biff/drawing/Drawing;->y:D

    int-to-double v2, p1

    cmpl-double p1, v0, v2

    if-lez p1, :cond_0

    invoke-virtual {p0, v2, v3}, Ljxl/biff/drawing/Drawing;->setY(D)V

    :cond_0
    return-void
.end method

.method public setDrawingGroup(Ljxl/biff/drawing/DrawingGroup;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-void
.end method

.method public setHeight(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing;->height:D

    return-void
.end method

.method protected setImageAnchor(Ljxl/biff/drawing/Drawing$ImageAnchorProperties;)V
    .locals 1

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->imageAnchorProperties:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    iget-object p1, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v0, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne p1, v0, :cond_0

    sget-object p1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    :cond_0
    return-void
.end method

.method public final setObjectId(III)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/Drawing;->objectId:I

    iput p2, p0, Ljxl/biff/drawing/Drawing;->blipId:I

    iput p3, p0, Ljxl/biff/drawing/Drawing;->shapeId:I

    iget-object p1, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object p2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne p1, p2, :cond_0

    sget-object p1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    :cond_0
    return-void
.end method

.method public setReferenceCount(I)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/Drawing;->referenceCount:I

    return-void
.end method

.method public setWidth(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing;->width:D

    return-void
.end method

.method public setX(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing;->x:D

    return-void
.end method

.method public setY(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing;->y:D

    return-void
.end method

.method public writeAdditionalRecords(Ljxl/write/biff/File;)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Ljxl/biff/drawing/Drawing;->objRecord:Ljxl/biff/drawing/ObjRecord;

    :goto_0
    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    return-void

    :cond_0
    new-instance v0, Ljxl/biff/drawing/ObjRecord;

    iget v1, p0, Ljxl/biff/drawing/Drawing;->objectId:I

    sget-object v2, Ljxl/biff/drawing/ObjRecord;->PICTURE:Ljxl/biff/drawing/ObjRecord$ObjType;

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/ObjRecord;-><init>(ILjxl/biff/drawing/ObjRecord$ObjType;)V

    goto :goto_0
.end method

.method public writeTailRecords(Ljxl/write/biff/File;)V
    .locals 0

    return-void
.end method
