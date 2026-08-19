.class Ljxl/biff/formula/SharedFormulaArea;
.super Ljxl/biff/formula/Operand;
.source ""

# interfaces
.implements Ljxl/biff/formula/ParsedThing;


# instance fields
.field private columnFirst:I

.field private columnFirstRelative:Z

.field private columnLast:I

.field private columnLastRelative:Z

.field private relativeTo:Ljxl/Cell;

.field private rowFirst:I

.field private rowFirstRelative:Z

.field private rowLast:I

.field private rowLastRelative:Z


# direct methods
.method public constructor <init>(Ljxl/Cell;)V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/Operand;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/SharedFormulaArea;->relativeTo:Ljxl/Cell;

    return-void
.end method


# virtual methods
.method getBytes()[B
    .locals 3

    const/16 v0, 0x9

    new-array v0, v0, [B

    sget-object v1, Ljxl/biff/formula/Token;->AREA:Ljxl/biff/formula/Token;

    invoke-virtual {v1}, Ljxl/biff/formula/Token;->getCode()B

    move-result v1

    const/4 v2, 0x0

    aput-byte v1, v0, v2

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirst:I

    const/4 v2, 0x1

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLast:I

    const/4 v2, 0x3

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirst:I

    const/4 v2, 0x5

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLast:I

    const/4 v2, 0x7

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v0
.end method

.method getFirstColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirst:I

    return v0
.end method

.method getFirstRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirst:I

    return v0
.end method

.method getLastColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLast:I

    return v0
.end method

.method getLastRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLast:I

    return v0
.end method

.method public getString(Ljava/lang/StringBuffer;)V
    .locals 2

    iget v0, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirst:I

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirst:I

    invoke-static {v0, v1, p1}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    const/16 v0, 0x3a

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    iget v0, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLast:I

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLast:I

    invoke-static {v0, v1, p1}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    return-void
.end method

.method handleImportedCellReferences()V
    .locals 0

    return-void
.end method

.method public read([BI)I
    .locals 5

    aget-byte v0, p1, p2

    add-int/lit8 v1, p2, 0x1

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getShort(BB)S

    move-result v0

    iput v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirst:I

    add-int/lit8 v0, p2, 0x2

    aget-byte v0, p1, v0

    add-int/lit8 v1, p2, 0x3

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getShort(BB)S

    move-result v0

    iput v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLast:I

    add-int/lit8 v0, p2, 0x4

    aget-byte v0, p1, v0

    add-int/lit8 v1, p2, 0x5

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v1, v0, 0xff

    iput v1, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirst:I

    and-int/lit16 v1, v0, 0x4000

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_0

    move v1, v3

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    iput-boolean v1, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirstRelative:Z

    const v4, 0x8000

    and-int/2addr v0, v4

    if-eqz v0, :cond_1

    move v0, v3

    goto :goto_1

    :cond_1
    move v0, v2

    :goto_1
    iput-boolean v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirstRelative:Z

    if-eqz v1, :cond_2

    iget-object v0, p0, Ljxl/biff/formula/SharedFormulaArea;->relativeTo:Ljxl/Cell;

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v0

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirst:I

    add-int/2addr v0, v1

    iput v0, p0, Ljxl/biff/formula/SharedFormulaArea;->columnFirst:I

    :cond_2
    iget-boolean v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirstRelative:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Ljxl/biff/formula/SharedFormulaArea;->relativeTo:Ljxl/Cell;

    invoke-interface {v0}, Ljxl/Cell;->getRow()I

    move-result v0

    iget v1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirst:I

    add-int/2addr v0, v1

    iput v0, p0, Ljxl/biff/formula/SharedFormulaArea;->rowFirst:I

    :cond_3
    add-int/lit8 v0, p2, 0x6

    aget-byte v0, p1, v0

    add-int/lit8 p2, p2, 0x7

    aget-byte p1, p1, p2

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    and-int/lit16 p2, p1, 0xff

    iput p2, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLast:I

    and-int/lit16 p2, p1, 0x4000

    if-eqz p2, :cond_4

    move p2, v3

    goto :goto_2

    :cond_4
    move p2, v2

    :goto_2
    iput-boolean p2, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLastRelative:Z

    and-int/2addr p1, v4

    if-eqz p1, :cond_5

    move v2, v3

    :cond_5
    iput-boolean v2, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLastRelative:Z

    if-eqz p2, :cond_6

    iget-object p1, p0, Ljxl/biff/formula/SharedFormulaArea;->relativeTo:Ljxl/Cell;

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result p1

    iget p2, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLast:I

    add-int/2addr p1, p2

    iput p1, p0, Ljxl/biff/formula/SharedFormulaArea;->columnLast:I

    :cond_6
    iget-boolean p1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLastRelative:Z

    if-eqz p1, :cond_7

    iget-object p1, p0, Ljxl/biff/formula/SharedFormulaArea;->relativeTo:Ljxl/Cell;

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result p1

    iget p2, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLast:I

    add-int/2addr p1, p2

    iput p1, p0, Ljxl/biff/formula/SharedFormulaArea;->rowLast:I

    :cond_7
    const/16 p1, 0x8

    return p1
.end method
