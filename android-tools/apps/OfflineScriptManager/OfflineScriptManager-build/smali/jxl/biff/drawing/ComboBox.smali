.class public Ljxl/biff/drawing/ComboBox;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/drawing/DrawingGroupObject;


# static fields
.field static synthetic class$jxl$biff$drawing$ComboBox:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private blipId:I

.field private column:I

.field private drawingData:Ljxl/biff/drawing/DrawingData;

.field private drawingGroup:Ljxl/biff/drawing/DrawingGroup;

.field private drawingNumber:I

.field private escherData:Ljxl/biff/drawing/EscherContainer;

.field private height:D

.field private initialized:Z

.field private msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

.field private objRecord:Ljxl/biff/drawing/ObjRecord;

.field private objectId:I

.field private origin:Ljxl/biff/drawing/Origin;

.field private readSpContainer:Ljxl/biff/drawing/EscherContainer;

.field private referenceCount:I

.field private row:I

.field private shapeId:I

.field private spContainer:Ljxl/biff/drawing/EscherContainer;

.field private type:Ljxl/biff/drawing/ShapeType;

.field private width:D

.field private workbookSettings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/ComboBox;->class$jxl$biff$drawing$ComboBox:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.ComboBox"

    invoke-static {v0}, Ljxl/biff/drawing/ComboBox;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/ComboBox;->class$jxl$biff$drawing$ComboBox:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/ComboBox;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    sget-object v1, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    iput-object v1, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    iput v0, p0, Ljxl/biff/drawing/ComboBox;->referenceCount:I

    sget-object v0, Ljxl/biff/drawing/ShapeType;->HOST_CONTROL:Ljxl/biff/drawing/ShapeType;

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->type:Ljxl/biff/drawing/ShapeType;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    check-cast p1, Ljxl/biff/drawing/ComboBox;

    iget-object v1, p1, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p1, Ljxl/biff/drawing/ComboBox;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object v1, p0, Ljxl/biff/drawing/ComboBox;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iget-object v1, p1, Ljxl/biff/drawing/ComboBox;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-object v1, p0, Ljxl/biff/drawing/ComboBox;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    iput-object v2, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    iget-object v0, p1, Ljxl/biff/drawing/ComboBox;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/ComboBox;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget p1, p1, Ljxl/biff/drawing/ComboBox;->drawingNumber:I

    iput p1, p0, Ljxl/biff/drawing/ComboBox;->drawingNumber:I

    invoke-virtual {p2, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iput-object p3, p0, Ljxl/biff/drawing/ComboBox;->workbookSettings:Ljxl/WorkbookSettings;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    iput-object p4, p0, Ljxl/biff/drawing/ComboBox;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iput-object p1, p0, Ljxl/biff/drawing/ComboBox;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object p3, p0, Ljxl/biff/drawing/ComboBox;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/ComboBox;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    iput-object p5, p0, Ljxl/biff/drawing/ComboBox;->workbookSettings:Ljxl/WorkbookSettings;

    sget-object p4, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    iput-object p4, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    invoke-virtual {p1}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object p4

    invoke-virtual {p3, p4}, Ljxl/biff/drawing/DrawingData;->addData([B)V

    iget-object p3, p0, Ljxl/biff/drawing/ComboBox;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p3}, Ljxl/biff/drawing/DrawingData;->getNumDrawings()I

    move-result p3

    const/4 p4, 0x1

    sub-int/2addr p3, p4

    iput p3, p0, Ljxl/biff/drawing/ComboBox;->drawingNumber:I

    iget-object p3, p0, Ljxl/biff/drawing/ComboBox;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {p3, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    move v0, p4

    :cond_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

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

.method private getReadSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    return-object v0
.end method

.method private initialize()V
    .locals 6

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget v1, p0, Ljxl/biff/drawing/ComboBox;->drawingNumber:I

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/DrawingData;->getSpContainer(I)Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v0}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v0

    iget-object v3, p0, Ljxl/biff/drawing/ComboBox;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v3}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v3

    aget-object v3, v3, v2

    check-cast v3, Ljxl/biff/drawing/Sp;

    iget-object v4, p0, Ljxl/biff/drawing/ComboBox;->objRecord:Ljxl/biff/drawing/ObjRecord;

    invoke-virtual {v4}, Ljxl/biff/drawing/ObjRecord;->getObjectId()I

    move-result v4

    iput v4, p0, Ljxl/biff/drawing/ComboBox;->objectId:I

    invoke-virtual {v3}, Ljxl/biff/drawing/Sp;->getShapeId()I

    move-result v4

    iput v4, p0, Ljxl/biff/drawing/ComboBox;->shapeId:I

    invoke-virtual {v3}, Ljxl/biff/drawing/Sp;->getShapeType()I

    move-result v3

    invoke-static {v3}, Ljxl/biff/drawing/ShapeType;->getType(I)Ljxl/biff/drawing/ShapeType;

    move-result-object v3

    iput-object v3, p0, Ljxl/biff/drawing/ComboBox;->type:Ljxl/biff/drawing/ShapeType;

    sget-object v4, Ljxl/biff/drawing/ShapeType;->UNKNOWN:Ljxl/biff/drawing/ShapeType;

    if-ne v3, v4, :cond_1

    sget-object v3, Ljxl/biff/drawing/ComboBox;->logger:Ljxl/common/Logger;

    const-string v4, "Unknown shape type"

    invoke-virtual {v3, v4}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_1
    const/4 v3, 0x0

    :goto_1
    array-length v4, v0

    if-ge v2, v4, :cond_3

    if-nez v3, :cond_3

    aget-object v4, v0, v2

    invoke-virtual {v4}, Ljxl/biff/drawing/EscherRecord;->getType()Ljxl/biff/drawing/EscherRecordType;

    move-result-object v4

    sget-object v5, Ljxl/biff/drawing/EscherRecordType;->CLIENT_ANCHOR:Ljxl/biff/drawing/EscherRecordType;

    if-ne v4, v5, :cond_2

    aget-object v3, v0, v2

    check-cast v3, Ljxl/biff/drawing/ClientAnchor;

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    if-nez v3, :cond_4

    sget-object v0, Ljxl/biff/drawing/ComboBox;->logger:Ljxl/common/Logger;

    const-string v2, "Client anchor not found"

    invoke-virtual {v0, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :cond_4
    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getX1()D

    move-result-wide v4

    double-to-int v0, v4

    iput v0, p0, Ljxl/biff/drawing/ComboBox;->column:I

    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getY1()D

    move-result-wide v2

    double-to-int v0, v2

    iput v0, p0, Ljxl/biff/drawing/ComboBox;->row:I

    :goto_2
    iput-boolean v1, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    return-void
.end method


# virtual methods
.method public final getBlipId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/ComboBox;->blipId:I

    return v0
.end method

.method public getColumn()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-object v0
.end method

.method public getHeight()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/ComboBox;->height:D

    return-wide v0
.end method

.method public getImageBytes()[B
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public getImageData()[B
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

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

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_2

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_2
    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget v1, p0, Ljxl/biff/drawing/ComboBox;->blipId:I

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/DrawingGroup;->getImageData(I)[B

    move-result-object v0

    return-object v0
.end method

.method public getImageFilePath()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public getMsoDrawingRecord()Ljxl/biff/drawing/MsoDrawingRecord;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    return-object v0
.end method

.method public final getObjectId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/ComboBox;->objectId:I

    return v0
.end method

.method public getOrigin()Ljxl/biff/drawing/Origin;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    return-object v0
.end method

.method public getReferenceCount()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/ComboBox;->referenceCount:I

    return v0
.end method

.method public getRow()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final getShapeId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/ComboBox;->shapeId:I

    return v0
.end method

.method public getSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 15

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->getReadSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    return-object v0

    :cond_1
    new-instance v0, Ljxl/biff/drawing/SpContainer;

    invoke-direct {v0}, Ljxl/biff/drawing/SpContainer;-><init>()V

    new-instance v1, Ljxl/biff/drawing/Sp;

    iget-object v2, p0, Ljxl/biff/drawing/ComboBox;->type:Ljxl/biff/drawing/ShapeType;

    iget v3, p0, Ljxl/biff/drawing/ComboBox;->shapeId:I

    const/16 v4, 0xa00

    invoke-direct {v1, v2, v3, v4}, Ljxl/biff/drawing/Sp;-><init>(Ljxl/biff/drawing/ShapeType;II)V

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v1, Ljxl/biff/drawing/Opt;

    invoke-direct {v1}, Ljxl/biff/drawing/Opt;-><init>()V

    const/16 v2, 0x7f

    const v3, 0x1040104

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v4, v3}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    const/16 v2, 0xbf

    const v3, 0x80008

    invoke-virtual {v1, v2, v4, v4, v3}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    const/16 v2, 0x1ff

    const/high16 v3, 0x80000

    invoke-virtual {v1, v2, v4, v4, v3}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    const/16 v2, 0x3bf

    const/high16 v3, 0x20000

    invoke-virtual {v1, v2, v4, v4, v3}, Ljxl/biff/drawing/Opt;->addProperty(IZZI)V

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v1, Ljxl/biff/drawing/ClientAnchor;

    iget v2, p0, Ljxl/biff/drawing/ComboBox;->column:I

    int-to-double v6, v2

    iget v3, p0, Ljxl/biff/drawing/ComboBox;->row:I

    int-to-double v8, v3

    add-int/lit8 v2, v2, 0x1

    int-to-double v10, v2

    add-int/lit8 v3, v3, 0x1

    int-to-double v12, v3

    const/4 v14, 0x1

    move-object v5, v1

    invoke-direct/range {v5 .. v14}, Ljxl/biff/drawing/ClientAnchor;-><init>(DDDDI)V

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    new-instance v1, Ljxl/biff/drawing/ClientData;

    invoke-direct {v1}, Ljxl/biff/drawing/ClientData;-><init>()V

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/EscherContainer;->add(Ljxl/biff/drawing/EscherRecord;)V

    return-object v0
.end method

.method public getType()Ljxl/biff/drawing/ShapeType;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->type:Ljxl/biff/drawing/ShapeType;

    return-object v0
.end method

.method public getWidth()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/ComboBox;->width:D

    return-wide v0
.end method

.method public getX()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/ComboBox;->column:I

    int-to-double v0, v0

    return-wide v0
.end method

.method public getY()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/ComboBox;->row:I

    int-to-double v0, v0

    return-wide v0
.end method

.method public hashCode()I
    .locals 1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public isFirst()Z
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-virtual {v0}, Ljxl/biff/drawing/MsoDrawingRecord;->isFirst()Z

    move-result v0

    return v0
.end method

.method public isFormObject()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public setDrawingGroup(Ljxl/biff/drawing/DrawingGroup;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/ComboBox;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-void
.end method

.method public setHeight(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/ComboBox;->height:D

    return-void
.end method

.method public final setObjectId(III)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/ComboBox;->objectId:I

    iput p2, p0, Ljxl/biff/drawing/ComboBox;->blipId:I

    iput p3, p0, Ljxl/biff/drawing/ComboBox;->shapeId:I

    iget-object p1, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object p2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne p1, p2, :cond_0

    sget-object p1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object p1, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    :cond_0
    return-void
.end method

.method public setReferenceCount(I)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/ComboBox;->referenceCount:I

    return-void
.end method

.method public setWidth(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/ComboBox;->width:D

    return-void
.end method

.method public setX(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    double-to-int p1, p1

    iput p1, p0, Ljxl/biff/drawing/ComboBox;->column:I

    return-void
.end method

.method public setY(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/ComboBox;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/ComboBox;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    double-to-int p1, p1

    iput p1, p0, Ljxl/biff/drawing/ComboBox;->row:I

    return-void
.end method

.method public writeAdditionalRecords(Ljxl/write/biff/File;)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Ljxl/biff/drawing/ComboBox;->objRecord:Ljxl/biff/drawing/ObjRecord;

    :goto_0
    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    return-void

    :cond_0
    new-instance v0, Ljxl/biff/drawing/ObjRecord;

    iget v1, p0, Ljxl/biff/drawing/ComboBox;->objectId:I

    sget-object v2, Ljxl/biff/drawing/ObjRecord;->COMBOBOX:Ljxl/biff/drawing/ObjRecord$ObjType;

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/ObjRecord;-><init>(ILjxl/biff/drawing/ObjRecord$ObjType;)V

    goto :goto_0
.end method

.method public writeTailRecords(Ljxl/write/biff/File;)V
    .locals 0

    return-void
.end method
