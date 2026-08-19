.class public Ljxl/biff/drawing/Drawing2;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/drawing/DrawingGroupObject;


# static fields
.field static synthetic class$jxl$biff$drawing$Drawing:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private blipId:I

.field private drawingData:Ljxl/biff/drawing/DrawingData;

.field private drawingGroup:Ljxl/biff/drawing/DrawingGroup;

.field private drawingNumber:I

.field private escherData:Ljxl/biff/drawing/EscherContainer;

.field private height:D

.field private imageData:[B

.field private imageFile:Ljava/io/File;

.field private initialized:Z

.field private msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

.field private objectId:I

.field private origin:Ljxl/biff/drawing/Origin;

.field private readSpContainer:Ljxl/biff/drawing/EscherContainer;

.field private referenceCount:I

.field private shapeId:I

.field private type:Ljxl/biff/drawing/ShapeType;

.field private width:D

.field private x:D

.field private y:D


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/Drawing2;->class$jxl$biff$drawing$Drawing:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.Drawing"

    invoke-static {v0}, Ljxl/biff/drawing/Drawing2;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Drawing2;->class$jxl$biff$drawing$Drawing:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Drawing2;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(DDDDLjava/io/File;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    iput-object p9, p0, Ljxl/biff/drawing/Drawing2;->imageFile:Ljava/io/File;

    const/4 p9, 0x1

    iput-boolean p9, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    sget-object v0, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    iput-wide p1, p0, Ljxl/biff/drawing/Drawing2;->x:D

    iput-wide p3, p0, Ljxl/biff/drawing/Drawing2;->y:D

    iput-wide p5, p0, Ljxl/biff/drawing/Drawing2;->width:D

    iput-wide p7, p0, Ljxl/biff/drawing/Drawing2;->height:D

    iput p9, p0, Ljxl/biff/drawing/Drawing2;->referenceCount:I

    sget-object p1, Ljxl/biff/drawing/ShapeType;->PICTURE_FRAME:Ljxl/biff/drawing/ShapeType;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing2;->type:Ljxl/biff/drawing/ShapeType;

    return-void
.end method

.method public constructor <init>(DDDD[B)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    iput-object p9, p0, Ljxl/biff/drawing/Drawing2;->imageData:[B

    const/4 p9, 0x1

    iput-boolean p9, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    sget-object v0, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    iput-wide p1, p0, Ljxl/biff/drawing/Drawing2;->x:D

    iput-wide p3, p0, Ljxl/biff/drawing/Drawing2;->y:D

    iput-wide p5, p0, Ljxl/biff/drawing/Drawing2;->width:D

    iput-wide p7, p0, Ljxl/biff/drawing/Drawing2;->height:D

    iput p9, p0, Ljxl/biff/drawing/Drawing2;->referenceCount:I

    sget-object p1, Ljxl/biff/drawing/ShapeType;->PICTURE_FRAME:Ljxl/biff/drawing/ShapeType;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing2;->type:Ljxl/biff/drawing/ShapeType;

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    check-cast p1, Ljxl/biff/drawing/Drawing2;

    iget-object v1, p1, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p1, Ljxl/biff/drawing/Drawing2;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object v1, p0, Ljxl/biff/drawing/Drawing2;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    iput-object v2, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    iget-object v0, p1, Ljxl/biff/drawing/Drawing2;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-object p2, p0, Ljxl/biff/drawing/Drawing2;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget p1, p1, Ljxl/biff/drawing/Drawing2;->drawingNumber:I

    iput p1, p0, Ljxl/biff/drawing/Drawing2;->drawingNumber:I

    invoke-virtual {p2, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    iput-object p3, p0, Ljxl/biff/drawing/Drawing2;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing2;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    iput-object p2, p0, Ljxl/biff/drawing/Drawing2;->drawingData:Ljxl/biff/drawing/DrawingData;

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    sget-object p3, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    iput-object p3, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    invoke-virtual {p1}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object p3

    invoke-virtual {p2, p3}, Ljxl/biff/drawing/DrawingData;->addRawData([B)V

    iget-object p2, p0, Ljxl/biff/drawing/Drawing2;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {p2, p0}, Ljxl/biff/drawing/DrawingGroup;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :cond_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

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

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->readSpContainer:Ljxl/biff/drawing/EscherContainer;

    return-object v0
.end method

.method private initialize()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    return-void
.end method


# virtual methods
.method public final getBlipId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Drawing2;->blipId:I

    return v0
.end method

.method public getColumn()D
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing2;->getX()D

    move-result-wide v0

    return-wide v0
.end method

.method public getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-object v0
.end method

.method public getHeight()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing2;->height:D

    return-wide v0
.end method

.method public getImageBytes()[B
    .locals 5

    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-eq v1, v2, :cond_4

    sget-object v2, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_0

    goto :goto_1

    :cond_0
    sget-object v2, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    const/4 v3, 0x1

    if-ne v1, v2, :cond_1

    move v1, v3

    goto :goto_0

    :cond_1
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p0, Ljxl/biff/drawing/Drawing2;->imageFile:Ljava/io/File;

    if-nez v1, :cond_3

    iget-object v1, p0, Ljxl/biff/drawing/Drawing2;->imageData:[B

    if-eqz v1, :cond_2

    move v0, v3

    :cond_2
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->imageData:[B

    return-object v0

    :cond_3
    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v1

    long-to-int v1, v1

    new-array v2, v1, [B

    new-instance v3, Ljava/io/FileInputStream;

    iget-object v4, p0, Ljxl/biff/drawing/Drawing2;->imageFile:Ljava/io/File;

    invoke-direct {v3, v4}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v3, v2, v0, v1}, Ljava/io/FileInputStream;->read([BII)I

    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V

    return-object v2

    :cond_4
    :goto_1
    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing2;->getImageData()[B

    move-result-object v0

    return-object v0
.end method

.method public getImageData()[B
    .locals 3

    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v1, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-eq v1, v2, :cond_0

    sget-object v2, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    if-ne v1, v2, :cond_1

    :cond_0
    const/4 v0, 0x1

    :cond_1
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_2

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_2
    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    iget v1, p0, Ljxl/biff/drawing/Drawing2;->blipId:I

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

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

    return-object v0
.end method

.method public final getObjectId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Drawing2;->objectId:I

    return v0
.end method

.method public getOrigin()Ljxl/biff/drawing/Origin;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    return-object v0
.end method

.method public getReferenceCount()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Drawing2;->referenceCount:I

    return v0
.end method

.method public getRow()D
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/drawing/Drawing2;->getY()D

    move-result-wide v0

    return-wide v0
.end method

.method public getShapeId()I
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget v0, p0, Ljxl/biff/drawing/Drawing2;->shapeId:I

    return v0
.end method

.method public getSpContainer()Ljxl/biff/drawing/EscherContainer;
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->getReadSpContainer()Ljxl/biff/drawing/EscherContainer;

    move-result-object v0

    return-object v0
.end method

.method public getType()Ljxl/biff/drawing/ShapeType;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->type:Ljxl/biff/drawing/ShapeType;

    return-object v0
.end method

.method public getWidth()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing2;->width:D

    return-wide v0
.end method

.method public getX()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing2;->x:D

    return-wide v0
.end method

.method public getY()D
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    iget-wide v0, p0, Ljxl/biff/drawing/Drawing2;->y:D

    return-wide v0
.end method

.method public isFirst()Z
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->msoDrawingRecord:Ljxl/biff/drawing/MsoDrawingRecord;

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

    iget-wide v0, p0, Ljxl/biff/drawing/Drawing2;->y:D

    int-to-double v2, p1

    cmpl-double p1, v0, v2

    if-lez p1, :cond_0

    invoke-virtual {p0, v2, v3}, Ljxl/biff/drawing/Drawing2;->setY(D)V

    :cond_0
    return-void
.end method

.method public setDrawingGroup(Ljxl/biff/drawing/DrawingGroup;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/drawing/Drawing2;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-void
.end method

.method public setHeight(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing2;->height:D

    return-void
.end method

.method public final setObjectId(III)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/Drawing2;->objectId:I

    iput p2, p0, Ljxl/biff/drawing/Drawing2;->blipId:I

    iput p3, p0, Ljxl/biff/drawing/Drawing2;->shapeId:I

    iget-object p1, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object p2, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne p1, p2, :cond_0

    sget-object p1, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object p1, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    :cond_0
    return-void
.end method

.method public setReferenceCount(I)V
    .locals 0

    iput p1, p0, Ljxl/biff/drawing/Drawing2;->referenceCount:I

    return-void
.end method

.method public setWidth(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing2;->width:D

    return-void
.end method

.method public setX(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing2;->x:D

    return-void
.end method

.method public setY(D)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    sget-object v1, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    if-ne v0, v1, :cond_1

    iget-boolean v0, p0, Ljxl/biff/drawing/Drawing2;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/Drawing2;->initialize()V

    :cond_0
    sget-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    iput-object v0, p0, Ljxl/biff/drawing/Drawing2;->origin:Ljxl/biff/drawing/Origin;

    :cond_1
    iput-wide p1, p0, Ljxl/biff/drawing/Drawing2;->y:D

    return-void
.end method

.method public writeAdditionalRecords(Ljxl/write/biff/File;)V
    .locals 0

    return-void
.end method

.method public writeTailRecords(Ljxl/write/biff/File;)V
    .locals 0

    return-void
.end method
