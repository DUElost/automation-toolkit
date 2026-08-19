.class Ljxl/write/biff/GuttersRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private colGutter:I

.field private data:[B

.field private maxColumnOutline:I

.field private maxRowOutline:I

.field private rowGutter:I


# direct methods
.method public constructor <init>()V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->GUTS:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 3

    const/16 v0, 0x8

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/GuttersRecord;->data:[B

    iget v1, p0, Ljxl/write/biff/GuttersRecord;->rowGutter:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/GuttersRecord;->colGutter:I

    iget-object v1, p0, Ljxl/write/biff/GuttersRecord;->data:[B

    const/4 v2, 0x2

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/GuttersRecord;->maxRowOutline:I

    iget-object v1, p0, Ljxl/write/biff/GuttersRecord;->data:[B

    const/4 v2, 0x4

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/GuttersRecord;->maxColumnOutline:I

    iget-object v1, p0, Ljxl/write/biff/GuttersRecord;->data:[B

    const/4 v2, 0x6

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/GuttersRecord;->data:[B

    return-object v0
.end method

.method public getMaxColumnOutline()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/GuttersRecord;->maxColumnOutline:I

    return v0
.end method

.method public getMaxRowOutline()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/GuttersRecord;->maxRowOutline:I

    return v0
.end method

.method public setMaxColumnOutline(I)V
    .locals 0

    iput p1, p0, Ljxl/write/biff/GuttersRecord;->maxColumnOutline:I

    mul-int/lit8 p1, p1, 0xe

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/write/biff/GuttersRecord;->colGutter:I

    return-void
.end method

.method public setMaxRowOutline(I)V
    .locals 0

    iput p1, p0, Ljxl/write/biff/GuttersRecord;->maxRowOutline:I

    mul-int/lit8 p1, p1, 0xe

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/write/biff/GuttersRecord;->rowGutter:I

    return-void
.end method
