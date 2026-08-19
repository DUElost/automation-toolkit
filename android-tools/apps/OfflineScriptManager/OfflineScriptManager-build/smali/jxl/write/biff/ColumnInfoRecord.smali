.class Ljxl/write/biff/ColumnInfoRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private collapsed:Z

.field private column:I

.field private data:[B

.field private hidden:Z

.field private outlineLevel:I

.field private style:Ljxl/biff/XFRecord;

.field private width:I

.field private xfIndex:I


# direct methods
.method public constructor <init>(IILjxl/biff/XFRecord;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->COLINFO:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p1, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    iput-object p3, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    invoke-virtual {p3}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result p1

    iput p1, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/ColumnInfoRecord;I)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->COLINFO:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getWidth()I

    move-result p2

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getXFIndex()I

    move-result p2

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getOutlineLevel()I

    move-result p2

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getCollapsed()Z

    move-result p1

    iput-boolean p1, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/ColumnInfoRecord;ILjxl/biff/FormattingRecords;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->COLINFO:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getWidth()I

    move-result p2

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getXFIndex()I

    move-result p2

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    invoke-virtual {p3, p2}, Ljxl/biff/FormattingRecords;->getXFRecord(I)Ljxl/biff/XFRecord;

    move-result-object p2

    iput-object p2, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getOutlineLevel()I

    move-result p2

    iput p2, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    invoke-virtual {p1}, Ljxl/read/biff/ColumnInfoRecord;->getCollapsed()Z

    move-result p1

    iput-boolean p1, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    return-void
.end method

.method public constructor <init>(Ljxl/write/biff/ColumnInfoRecord;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->COLINFO:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iget v0, p1, Ljxl/write/biff/ColumnInfoRecord;->column:I

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    iget v0, p1, Ljxl/write/biff/ColumnInfoRecord;->width:I

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    iget-object v0, p1, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    iput-object v0, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    iget v0, p1, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    iget-boolean v0, p1, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    iput-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    iget v0, p1, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    iget-boolean p1, p1, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    iput-boolean p1, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    return-void
.end method


# virtual methods
.method public decrementColumn()V
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    return-void
.end method

.method public decrementOutlineLevel()V
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    if-lez v0, :cond_0

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    :cond_0
    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    if-nez v0, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    :cond_1
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3

    if-ne p1, p0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    instance-of v0, p1, Ljxl/write/biff/ColumnInfoRecord;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    :cond_1
    check-cast p1, Ljxl/write/biff/ColumnInfoRecord;

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    iget v2, p1, Ljxl/write/biff/ColumnInfoRecord;->column:I

    if-ne v0, v2, :cond_6

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    iget v2, p1, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    if-ne v0, v2, :cond_6

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    iget v2, p1, Ljxl/write/biff/ColumnInfoRecord;->width:I

    if-ne v0, v2, :cond_6

    iget-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    iget-boolean v2, p1, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    if-ne v0, v2, :cond_6

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    iget v2, p1, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    if-ne v0, v2, :cond_6

    iget-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    iget-boolean v2, p1, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    if-eq v0, v2, :cond_2

    goto :goto_0

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    if-nez v0, :cond_3

    iget-object v2, p1, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    if-nez v2, :cond_4

    :cond_3
    if-eqz v0, :cond_5

    iget-object v2, p1, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    if-nez v2, :cond_5

    :cond_4
    return v1

    :cond_5
    iget-object p1, p1, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    invoke-virtual {v0, p1}, Ljxl/biff/XFRecord;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_6
    :goto_0
    return v1
.end method

.method public getCellFormat()Ljxl/biff/XFRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    return-object v0
.end method

.method public getCollapsed()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    return v0
.end method

.method public getColumn()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    return v0
.end method

.method public getData()[B
    .locals 3

    const/16 v0, 0xc

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/ColumnInfoRecord;->data:[B

    iget v1, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    iget-object v1, p0, Ljxl/write/biff/ColumnInfoRecord;->data:[B

    const/4 v2, 0x2

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    iget-object v1, p0, Ljxl/write/biff/ColumnInfoRecord;->data:[B

    const/4 v2, 0x4

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    iget-object v1, p0, Ljxl/write/biff/ColumnInfoRecord;->data:[B

    const/4 v2, 0x6

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    const/16 v1, 0x8

    shl-int/2addr v0, v1

    or-int/2addr v0, v2

    iget-boolean v2, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    if-eqz v2, :cond_0

    or-int/lit8 v0, v0, 0x1

    :cond_0
    and-int/lit16 v2, v0, 0x700

    div-int/lit16 v2, v2, 0x100

    iput v2, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    iget-boolean v2, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    if-eqz v2, :cond_1

    or-int/lit16 v0, v0, 0x1000

    :cond_1
    iget-object v2, p0, Ljxl/write/biff/ColumnInfoRecord;->data:[B

    invoke-static {v0, v2, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/ColumnInfoRecord;->data:[B

    return-object v0
.end method

.method getHidden()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    return v0
.end method

.method public getOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    return v0
.end method

.method getWidth()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    return v0
.end method

.method public getXfIndex()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    return v0
.end method

.method public hashCode()I
    .locals 2

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    const/16 v1, 0x2a47

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x4f

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x4f

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x4f

    iget-boolean v0, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    add-int/2addr v1, v0

    iget-object v0, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/biff/XFRecord;->hashCode()I

    move-result v0

    xor-int/2addr v1, v0

    :cond_0
    return v1
.end method

.method public incrementColumn()V
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->column:I

    return-void
.end method

.method public incrementOutlineLevel()V
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    return-void
.end method

.method rationalize(Ljxl/biff/IndexMapping;)V
    .locals 1

    iget v0, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    invoke-virtual {p1, v0}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/ColumnInfoRecord;->xfIndex:I

    return-void
.end method

.method public setCellFormat(Ljxl/biff/XFRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/ColumnInfoRecord;->style:Ljxl/biff/XFRecord;

    return-void
.end method

.method public setCollapsed(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/write/biff/ColumnInfoRecord;->collapsed:Z

    return-void
.end method

.method setHidden(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/write/biff/ColumnInfoRecord;->hidden:Z

    return-void
.end method

.method public setOutlineLevel(I)V
    .locals 0

    iput p1, p0, Ljxl/write/biff/ColumnInfoRecord;->outlineLevel:I

    return-void
.end method

.method setWidth(I)V
    .locals 0

    iput p1, p0, Ljxl/write/biff/ColumnInfoRecord;->width:I

    return-void
.end method
