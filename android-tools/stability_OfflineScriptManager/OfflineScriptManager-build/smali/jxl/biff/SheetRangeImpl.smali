.class public Ljxl/biff/SheetRangeImpl;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/Range;


# instance fields
.field private column1:I

.field private column2:I

.field private row1:I

.field private row2:I

.field private sheet:Ljxl/Sheet;


# direct methods
.method public constructor <init>(Ljxl/Sheet;IIII)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    iput p3, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    iput p5, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    iput p2, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iput p4, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    return-void
.end method

.method public constructor <init>(Ljxl/biff/SheetRangeImpl;Ljxl/Sheet;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    iget p2, p1, Ljxl/biff/SheetRangeImpl;->row1:I

    iput p2, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    iget p2, p1, Ljxl/biff/SheetRangeImpl;->row2:I

    iput p2, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    iget p2, p1, Ljxl/biff/SheetRangeImpl;->column1:I

    iput p2, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget p1, p1, Ljxl/biff/SheetRangeImpl;->column2:I

    iput p1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Ljxl/biff/SheetRangeImpl;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Ljxl/biff/SheetRangeImpl;

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget v3, p1, Ljxl/biff/SheetRangeImpl;->column1:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    iget v3, p1, Ljxl/biff/SheetRangeImpl;->column2:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    iget v3, p1, Ljxl/biff/SheetRangeImpl;->row1:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    iget p1, p1, Ljxl/biff/SheetRangeImpl;->row2:I

    if-ne v1, p1, :cond_2

    goto :goto_0

    :cond_2
    move v0, v2

    :goto_0
    return v0
.end method

.method public getBottomRight()Ljxl/Cell;
    .locals 3

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    iget-object v1, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    invoke-interface {v1}, Ljxl/Sheet;->getColumns()I

    move-result v1

    if-ge v0, v1, :cond_1

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    iget-object v1, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    invoke-interface {v1}, Ljxl/Sheet;->getRows()I

    move-result v1

    if-lt v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    iget v2, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    invoke-interface {v0, v1, v2}, Ljxl/Sheet;->getCell(II)Ljxl/Cell;

    move-result-object v0

    return-object v0

    :cond_1
    :goto_0
    new-instance v0, Ljxl/biff/EmptyCell;

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    iget v2, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    invoke-direct {v0, v1, v2}, Ljxl/biff/EmptyCell;-><init>(II)V

    return-object v0
.end method

.method public getFirstSheetIndex()I
    .locals 1

    const/4 v0, -0x1

    return v0
.end method

.method public getLastSheetIndex()I
    .locals 1

    const/4 v0, -0x1

    return v0
.end method

.method public getTopLeft()Ljxl/Cell;
    .locals 3

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget-object v1, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    invoke-interface {v1}, Ljxl/Sheet;->getColumns()I

    move-result v1

    if-ge v0, v1, :cond_1

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    iget-object v1, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    invoke-interface {v1}, Ljxl/Sheet;->getRows()I

    move-result v1

    if-lt v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ljxl/biff/SheetRangeImpl;->sheet:Ljxl/Sheet;

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget v2, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    invoke-interface {v0, v1, v2}, Ljxl/Sheet;->getCell(II)Ljxl/Cell;

    move-result-object v0

    return-object v0

    :cond_1
    :goto_0
    new-instance v0, Ljxl/biff/EmptyCell;

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget v2, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    invoke-direct {v0, v1, v2}, Ljxl/biff/EmptyCell;-><init>(II)V

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    const v1, 0xffff

    xor-int/2addr v0, v1

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    xor-int/2addr v0, v1

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    xor-int/2addr v0, v1

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    xor-int/2addr v0, v1

    return v0
.end method

.method public insertColumn(I)V
    .locals 2

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    if-gt p1, v1, :cond_1

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    :cond_1
    if-gt p1, v0, :cond_2

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    :cond_2
    return-void
.end method

.method public insertRow(I)V
    .locals 2

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    if-gt p1, v1, :cond_1

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    :cond_1
    if-gt p1, v0, :cond_2

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    :cond_2
    return-void
.end method

.method public intersects(Ljxl/biff/SheetRangeImpl;)Z
    .locals 3

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    :cond_0
    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    iget v2, p1, Ljxl/biff/SheetRangeImpl;->row1:I

    if-lt v1, v2, :cond_2

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    iget v2, p1, Ljxl/biff/SheetRangeImpl;->row2:I

    if-gt v1, v2, :cond_2

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    iget v2, p1, Ljxl/biff/SheetRangeImpl;->column1:I

    if-lt v1, v2, :cond_2

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget p1, p1, Ljxl/biff/SheetRangeImpl;->column2:I

    if-le v1, p1, :cond_1

    goto :goto_0

    :cond_1
    return v0

    :cond_2
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method public removeColumn(I)V
    .locals 2

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    if-ge p1, v1, :cond_1

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    :cond_1
    if-ge p1, v0, :cond_2

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    :cond_2
    return-void
.end method

.method public removeRow(I)V
    .locals 2

    iget v0, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    if-ge p1, v1, :cond_1

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    :cond_1
    if-ge p1, v0, :cond_2

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    :cond_2
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column1:I

    iget v2, p0, Ljxl/biff/SheetRangeImpl;->row1:I

    invoke-static {v1, v2, v0}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    const/16 v1, 0x2d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    iget v1, p0, Ljxl/biff/SheetRangeImpl;->column2:I

    iget v2, p0, Ljxl/biff/SheetRangeImpl;->row2:I

    invoke-static {v1, v2, v0}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
