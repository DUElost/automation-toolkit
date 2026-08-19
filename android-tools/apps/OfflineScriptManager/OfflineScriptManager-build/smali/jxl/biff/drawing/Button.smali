.class public Ljxl/biff/drawing/Button;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/drawing/DrawingGroupObject;


# static fields
.field static synthetic class$jxl$biff$drawing$Button:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private blipId:I

.field private column:I

.field private commentText:Ljava/lang/String;

.field private drawingData:Ljxl/biff/drawing/DrawingData;

.field private drawingGroup:Ljxl/biff/drawing/DrawingGroup;

.field private drawingNumber:I

.field private escherData:Ljxl/biff/drawing/EscherContainer;

.field private formatting:Ljxl/biff/ContinueRecord;

.field private height:D

.field private initialized:Z

.field private mso:Ljxl/biff/drawing/MsoDrawingRecord;

.field private msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

.field private objRecord:Ljxl/biff/drawing/ObjRecord;

.field private objectId:I

.field private origin:Ljxl/biff/drawing/Origin;

.field private readSpContainer:Ljxl/biff/drawing/EscherContainer;

.field private referenceCount:I

.field private row:I

.field private shapeId:I

.field private spContainer:Ljxl/biff/drawing/EscherContainer;

.field private text:Ljxl/biff/ContinueRecord;

.field private txo:Ljxl/biff/drawing/TextObjectRecord;

.field private type:Ljxl/biff/drawing/ShapeType;

.field private width:D

.field private workbookSettings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/Button;->class$jxl$biff$drawing$Button:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.Button"

    invoke-static {v0}, Ljxl/biff/drawing/Button;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Button;->class$jxl$biff$drawing$Button:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Button;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    check-cast p1, Ljxl/biff/drawing/Button;

    iget-object v1, p1, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p1, Ljxl/biff/drawing/Button;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object v1, p0, Ljxl/biff/drawing/Button;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iget-object v1, p1, Ljxl/biff/drawing/Button;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-object v1, p0, Ljxl/biff/drawing/Button;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    iput-object v2, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    iget-object v0, p1, Ljxl/biff/drawing/Button;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object v0, p0, Ljxl/biff/drawing/Button;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/Button;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget v0, p1, Ljxl/biff/drawing/Button;->drawingNumber:I

    iput v0, p0, Ljxl/biff/drawing/Button;->drawingNumber:I

    invoke-virtual {p2, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object p2, p1, Ljxl/biff/drawing/Button;->mso:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object p2, p0, Ljxl/biff/drawing/Button;->mso:Ljxl/biff/drawing/MsoDrawingRecord;

    iget-object p2, p1, Ljxl/biff/drawing/Button;->txo:Ljxl/biff/drawing/TextObjectRecord;

    iput-object p2, p0, Ljxl/biff/drawing/Button;->txo:Ljxl/biff/drawing/TextObjectRecord;

    iget-object p2, p1, Ljxl/biff/drawing/Button;->text:Ljxl/biff/ContinueRecord;

    iput-object p2, p0, Ljxl/biff/drawing/Button;->text:Ljxl/biff/ContinueRecord;

    iget-object p1, p1, Ljxl/biff/drawing/Button;->formatting:Ljxl/biff/ContinueRecord;

    iput-object p1, p0, Ljxl/biff/drawing/Button;->formatting:Ljxl/biff/ContinueRecord;

    iput-object p3, p0, Ljxl/biff/drawing/Button;->workbookSettings:Ljxl/WorkbookSettings;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    iput-object p4, p0, Ljxl/biff/drawing/Button;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iput-object p1, p0, Ljxl/biff/drawing/Button;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object p3, p0, Ljxl/biff/drawing/Button;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/Button;->objRecord:Ljxl/biff/drawing/ObjRecord;

    iput-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    iput-object p5, p0, Ljxl/biff/drawing/Button;->workbookSettings:Ljxl/WorkbookSettings;

    sget-object p2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    iput-object p2, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    invoke-virtual {p1}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object p1

    invoke-virtual {p3, p1}, Ljxl/biff/drawing/DrawingData;->addData([B)V

    iget-object p1, p0, Ljxl/biff/drawing/Button;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p1}, Ljxl/biff/drawing/DrawingData;->getNumDrawings()I

    move-result p1

    const/4 p2, 0x1

    sub-int/2addr p1, p2

    iput p1, p0, Ljxl/biff/drawing/Button;->drawingNumber:I

    iget-object p1, p0, Ljxl/biff/drawing/Button;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {p1, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object p1, p0, Ljxl/biff/drawing/Button;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    if-eqz p1, :cond_0

    iget-object p1, p0, Ljxl/biff/drawing/Button;->objRecord:Ljxl/biff/drawing/ObjRecord;

    if-eqz p1, :cond_0

    move v0, p2

    :cond_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

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

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Button;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    return-object v0
.end method

.method private initialize()V
    .locals 6

    iget-object v0, p0, Ljxl/biff/drawing/Button;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget v1, p0, Ljxl/biff/drawing/Button;->drawingNumber:I

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/DrawingData;->getSpContainer(I)Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/drawing/Button;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Button;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v0}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v0

    iget-object v3, p0, Ljxl/biff/drawing/Button;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    invoke-virtual {v3}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object v3

    aget-object v3, v3, v1

    check-cast v3, Ljxl/biff/drawing/Sp;

    iget-object v4, p0, Ljxl/biff/drawing/Button;->objRecord:Ljxl/biff/drawing/ObjRecord;

    invoke-virtual {v4}, Ljxl/biff/drawing/ObjRecord;->getObjectId()I

    move-result v4

    iput v4, p0, Ljxl/biff/drawing/Button;->objectId:I

    invoke-virtual {v3}, Ljxl/biff/drawing/Sp;->getShapeId()I

    move-result v4

    iput v4, p0, Ljxl/biff/drawing/Button;->shapeId:I

    invoke-virtual {v3}, Ljxl/biff/drawing/Sp;->getShapeType()I

    move-result v3

    invoke-static {v3}, Ljxl/biff/drawing/ShapeType;->getType(I)Ljxl/biff/drawing/ShapeType;

    move-result-object v3

    iput-object v3, p0, Ljxl/biff/drawing/Button;->type:Ljxl/biff/drawing/ShapeType;

    sget-object v4, Ljxl/biff/drawing/ShapeType;->UNKNOWN:Ljxl/biff/drawing/ShapeType;

    if-ne v3, v4, :cond_1

    sget-object v3, Ljxl/biff/drawing/Button;->logger:Ljxl/common/Logger;

    const-string v4, "Unknown shape type"

    invoke-virtual {v3, v4}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_1
    const/4 v3, 0x0

    :goto_1
    array-length v4, v0

    if-ge v1, v4, :cond_3

    if-nez v3, :cond_3

    aget-object v4, v0, v1

    invoke-virtual {v4}, Ljxl/biff/drawing/EscherRecord;->getType()Ljxl/biff/drawing/EscherRecordType;

    move-result-object v4

    sget-object v5, Ljxl/biff/drawing/EscherRecordType;->CLIENT_ANCHOR:Ljxl/biff/drawing/EscherRecordType;

    if-ne v4, v5, :cond_2

    aget-object v3, v0, v1

    check-cast v3, Ljxl/biff/drawing/ClientAnchor;

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_3
    if-nez v3, :cond_4

    sget-object v0, Ljxl/biff/drawing/Button;->logger:Ljxl/common/Logger;

    const-string v1, "Client anchor not found"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :cond_4
    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getX1()D

    move-result-wide v0

    double-to-int v0, v0

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/drawing/Button;->column:I

    invoke-virtual {v3}, Ljxl/biff/drawing/ClientAnchor;->getY1()D

    move-result-wide v0

    double-to-int v0, v0

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/drawing/Button;->row:I

    :goto_2
    iput-boolean v2, p0, Ljxl/biff/drawing/Button;->initialized:Z

    return-void
.end method


# virtual methods
.method public addMso(Ljxl/biff/drawing/MsoDrawingRecord;)V
    .locals 1

    iput-object p1, p0, Ljxl/biff/drawing/Button;->mso:Ljxl/biff/drawing/MsoDrawingRecord;

    iget-object v0, p0, Ljxl/biff/drawing/Button;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p1}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/biff/drawing/DrawingData;->addRawData([B)V

    return-void
.end method

.method public final getBlipId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Button;->blipId:I

    return v0
.end method

.method public getColumn()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Button;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-object v0
.end method

.method public getHeight()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Button;->height:D

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

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

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

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_2

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_2
    iget-object v0, p0, Ljxl/biff/drawing/Button;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget v1, p0, Ljxl/biff/drawing/Button;->blipId:I

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

    iget-object v0, p0, Ljxl/biff/drawing/Button;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    return-object v0
.end method

.method public final getObjectId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Button;->objectId:I

    return v0
.end method

.method public getOrigin()Ljxl/biff/drawing/Origin;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    return-object v0
.end method

.method public getReferenceCount()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Button;->referenceCount:I

    return v0
.end method

.method public getRow()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final getShapeId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Button;->shapeId:I

    return v0
.end method

.method public getSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->getReadSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    return-object v0

    :cond_1
    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Button;->spContainer:Ljxl/biff/drawing/EscherContainer;

    return-object v0
.end method

.method public getText()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    if-nez v0, :cond_2

    iget-object v0, p0, Ljxl/biff/drawing/Button;->text:Ljxl/biff/ContinueRecord;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Button;->text:Ljxl/biff/ContinueRecord;

    invoke-virtual {v0}, Ljxl/biff/ContinueRecord;->getData()[B

    move-result-object v0

    aget-byte v1, v0, v1

    if-nez v1, :cond_1

    array-length v1, v0

    sub-int/2addr v1, v2

    iget-object v3, p0, Ljxl/biff/drawing/Button;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_1
    array-length v1, v0

    sub-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x2

    invoke-static {v0, v1, v2}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object v0

    :goto_1
    iput-object v0, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    :cond_2
    iget-object v0, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    return-object v0
.end method

.method public getType()Ljxl/biff/drawing/ShapeType;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Button;->type:Ljxl/biff/drawing/ShapeType;

    return-object v0
.end method

.method public getWidth()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Button;->width:D

    return-wide v0
.end method

.method public getX()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Button;->column:I

    int-to-double v0, v0

    return-wide v0
.end method

.method public getY()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Button;->row:I

    int-to-double v0, v0

    return-wide v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public isFirst()Z
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Button;->mso:Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-virtual {v0}, Ljxl/biff/drawing/MsoDrawingRecord;->isFirst()Z

    move-result v0

    return v0
.end method

.method public isFormObject()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public setButtonText(Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    iget-object p1, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v0, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne p1, v0, :cond_0

    sget-object p1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object p1, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    :cond_0
    return-void
.end method

.method public setDrawingGroup(Ljxl/biff/drawing/DrawingGroup;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/Button;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-void
.end method

.method public setFormatting(Ljxl/biff/ContinueRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/Button;->formatting:Ljxl/biff/ContinueRecord;

    return-void
.end method

.method public setHeight(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Button;->height:D

    return-void
.end method

.method public final setObjectId(III)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/Button;->objectId:I

    iput p2, p0, Ljxl/biff/drawing/Button;->blipId:I

    iput p3, p0, Ljxl/biff/drawing/Button;->shapeId:I

    iget-object p1, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object p2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne p1, p2, :cond_0

    sget-object p1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object p1, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    :cond_0
    return-void
.end method

.method public setReferenceCount(I)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/Button;->referenceCount:I

    return-void
.end method

.method public setText(Ljxl/biff/ContinueRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/Button;->text:Ljxl/biff/ContinueRecord;

    return-void
.end method

.method public setTextObject(Ljxl/biff/drawing/TextObjectRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/Button;->txo:Ljxl/biff/drawing/TextObjectRecord;

    return-void
.end method

.method public setWidth(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Button;->width:D

    return-void
.end method

.method public setX(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    double-to-int p1, p1

    iput p1, p0, Ljxl/biff/drawing/Button;->column:I

    return-void
.end method

.method public setY(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Button;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Button;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    double-to-int p1, p1

    iput p1, p0, Ljxl/biff/drawing/Button;->row:I

    return-void
.end method

.method public writeAdditionalRecords(Ljxl/write/biff/File;)V
    .locals 5

    iget-object v0, p0, Ljxl/biff/drawing/Button;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Ljxl/biff/drawing/Button;->objRecord:Ljxl/biff/drawing/ObjRecord;

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v0, p0, Ljxl/biff/drawing/Button;->mso:Ljxl/biff/drawing/MsoDrawingRecord;

    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Button;->txo:Ljxl/biff/drawing/TextObjectRecord;

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v0, p0, Ljxl/biff/drawing/Button;->text:Ljxl/biff/ContinueRecord;

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v0, p0, Ljxl/biff/drawing/Button;->formatting:Ljxl/biff/ContinueRecord;

    if-eqz v0, :cond_1

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_1
    return-void

    :cond_2
    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    new-instance v1, Ljxl/biff/drawing/ObjRecord;

    iget v2, p0, Ljxl/biff/drawing/Button;->objectId:I

    sget-object v3, Ljxl/biff/drawing/ObjRecord;->EXCELNOTE:Ljxl/biff/drawing/ObjRecord$ObjType;

    invoke-direct {v1, v2, v3}, Ljxl/biff/drawing/ObjRecord;-><init>(ILjxl/biff/drawing/ObjRecord$ObjType;)V

    invoke-virtual {p1, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/biff/drawing/ClientTextBox;

    invoke-direct {v1}, Ljxl/biff/drawing/ClientTextBox;-><init>()V

    new-instance v2, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-virtual {v1}, Ljxl/biff/drawing/ClientTextBox;->getData()[B

    move-result-object v1

    invoke-direct {v2, v1}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>([B)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/biff/drawing/TextObjectRecord;

    invoke-virtual {p0}, Ljxl/biff/drawing/Button;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljxl/biff/drawing/TextObjectRecord;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x2

    mul-int/2addr v1, v2

    const/4 v3, 0x1

    add-int/2addr v1, v3

    new-array v1, v1, [B

    aput-byte v3, v1, v0

    iget-object v4, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    invoke-static {v4, v1, v3}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    new-instance v3, Ljxl/biff/ContinueRecord;

    invoke-direct {v3, v1}, Ljxl/biff/ContinueRecord;-><init>([B)V

    invoke-virtual {p1, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    const/16 v1, 0x10

    new-array v1, v1, [B

    invoke-static {v0, v1, v0}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v2, p0, Ljxl/biff/drawing/Button;->commentText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0x8

    invoke-static {v2, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    const/16 v2, 0xa

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    new-instance v0, Ljxl/biff/ContinueRecord;

    invoke-direct {v0, v1}, Ljxl/biff/ContinueRecord;-><init>([B)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    return-void
.end method

.method public writeTailRecords(Ljxl/write/biff/File;)V
    .locals 0

    return-void
.end method
