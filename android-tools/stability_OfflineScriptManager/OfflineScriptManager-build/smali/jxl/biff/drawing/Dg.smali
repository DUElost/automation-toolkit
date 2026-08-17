.class Ljxl/biff/drawing/Dg;
.super Ljxl/biff/drawing/EscherAtom;
.source ""


# instance fields
.field private data:[B

.field private drawingId:I

.field private seed:I

.field private shapeCount:I


# direct methods
.method public constructor <init>(I)V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/EscherRecordType;->DG:Ljxl/biff/drawing/EscherRecordType;

    invoke-direct {p0, v0}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordType;)V

    const/4 v0, 0x1

    iput v0, p0, Ljxl/biff/drawing/Dg;->drawingId:I

    add-int/2addr p1, v0

    iput p1, p0, Ljxl/biff/drawing/Dg;->shapeCount:I

    add-int/lit16 p1, p1, 0x400

    add-int/2addr p1, v0

    iput p1, p0, Ljxl/biff/drawing/Dg;->seed:I

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setInstance(I)V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/EscherRecordData;)V
    .locals 4

    invoke-direct {p0, p1}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getInstance()I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/Dg;->drawingId:I

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte v0, p1, v0

    const/4 v1, 0x1

    aget-byte v1, p1, v1

    const/4 v2, 0x2

    aget-byte v2, p1, v2

    const/4 v3, 0x3

    aget-byte v3, p1, v3

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/biff/drawing/Dg;->shapeCount:I

    const/4 v0, 0x4

    aget-byte v0, p1, v0

    const/4 v1, 0x5

    aget-byte v1, p1, v1

    const/4 v2, 0x6

    aget-byte v2, p1, v2

    const/4 v3, 0x7

    aget-byte p1, p1, v3

    invoke-static {v0, v1, v2, p1}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/Dg;->seed:I

    return-void
.end method


# virtual methods
.method getData()[B
    .locals 3

    const/16 v0, 0x8

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/biff/drawing/Dg;->data:[B

    iget v1, p0, Ljxl/biff/drawing/Dg;->shapeCount:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v0, p0, Ljxl/biff/drawing/Dg;->seed:I

    iget-object v1, p0, Ljxl/biff/drawing/Dg;->data:[B

    const/4 v2, 0x4

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v0, p0, Ljxl/biff/drawing/Dg;->data:[B

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setHeaderData([B)[B

    move-result-object v0

    return-object v0
.end method

.method public getDrawingId()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Dg;->drawingId:I

    return v0
.end method
