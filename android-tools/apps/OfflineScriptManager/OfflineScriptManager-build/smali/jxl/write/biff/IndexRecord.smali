.class Ljxl/write/biff/IndexRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private blocks:I

.field private bofPosition:I

.field private data:[B

.field private dataPos:I

.field private rows:I


# direct methods
.method public constructor <init>(III)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->INDEX:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p1, p0, Ljxl/write/biff/IndexRecord;->bofPosition:I

    iput p2, p0, Ljxl/write/biff/IndexRecord;->rows:I

    iput p3, p0, Ljxl/write/biff/IndexRecord;->blocks:I

    mul-int/lit8 p3, p3, 0x4

    const/16 p1, 0x10

    add-int/2addr p3, p1

    new-array p2, p3, [B

    iput-object p2, p0, Ljxl/write/biff/IndexRecord;->data:[B

    iput p1, p0, Ljxl/write/biff/IndexRecord;->dataPos:I

    return-void
.end method


# virtual methods
.method addBlockPosition(I)V
    .locals 2

    iget v0, p0, Ljxl/write/biff/IndexRecord;->bofPosition:I

    sub-int/2addr p1, v0

    iget-object v0, p0, Ljxl/write/biff/IndexRecord;->data:[B

    iget v1, p0, Ljxl/write/biff/IndexRecord;->dataPos:I

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget p1, p0, Ljxl/write/biff/IndexRecord;->dataPos:I

    add-int/lit8 p1, p1, 0x4

    iput p1, p0, Ljxl/write/biff/IndexRecord;->dataPos:I

    return-void
.end method

.method protected getData()[B
    .locals 3

    iget v0, p0, Ljxl/write/biff/IndexRecord;->rows:I

    iget-object v1, p0, Ljxl/write/biff/IndexRecord;->data:[B

    const/16 v2, 0x8

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/IndexRecord;->data:[B

    return-object v0
.end method

.method setDataStartPosition(I)V
    .locals 2

    iget v0, p0, Ljxl/write/biff/IndexRecord;->bofPosition:I

    sub-int/2addr p1, v0

    iget-object v0, p0, Ljxl/write/biff/IndexRecord;->data:[B

    const/16 v1, 0xc

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-void
.end method
