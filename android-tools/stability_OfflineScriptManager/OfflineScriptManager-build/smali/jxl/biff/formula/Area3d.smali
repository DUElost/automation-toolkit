.class Ljxl/biff/formula/Area3d;
.super Ljxl/biff/formula/Operand;
.source ""

# interfaces
.implements Ljxl/biff/formula/ParsedThing;


# static fields
.field static synthetic class$jxl$biff$formula$Area3d:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private columnFirst:I

.field private columnFirstRelative:Z

.field private columnLast:I

.field private columnLastRelative:Z

.field private rowFirst:I

.field private rowFirstRelative:Z

.field private rowLast:I

.field private rowLastRelative:Z

.field private sheet:I

.field private workbook:Ljxl/biff/formula/ExternalSheet;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/formula/Area3d;->class$jxl$biff$formula$Area3d:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.formula.Area3d"

    invoke-static {v0}, Ljxl/biff/formula/Area3d;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/Area3d;->class$jxl$biff$formula$Area3d:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/Area3d;->logger:Ljxl/common/Logger;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljxl/biff/formula/ExternalSheet;)V
    .locals 6

    invoke-direct {p0}, Ljxl/biff/formula/Operand;-><init>()V

    iput-object p2, p0, Ljxl/biff/formula/Area3d;->workbook:Ljxl/biff/formula/ExternalSheet;

    const-string v0, ":"

    invoke-virtual {p1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, -0x1

    if-eq v0, v3, :cond_0

    move v3, v2

    goto :goto_0

    :cond_0
    move v3, v1

    :goto_0
    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    add-int/lit8 v3, v0, 0x1

    invoke-virtual {p1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x21

    invoke-virtual {p1, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    add-int/lit8 v5, v4, 0x1

    invoke-virtual {p1, v5, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljxl/biff/CellReferenceHelper;->getColumn(Ljava/lang/String;)I

    move-result v5

    iput v5, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    invoke-static {v0}, Ljxl/biff/CellReferenceHelper;->getRow(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    invoke-virtual {p1, v1, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x27

    if-ne v0, v1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    sub-int/2addr v0, v2

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    if-ne v0, v1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    sub-int/2addr v0, v2

    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    :cond_1
    invoke-interface {p2, p1}, Ljxl/biff/formula/ExternalSheet;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result p2

    iput p2, p0, Ljxl/biff/formula/Area3d;->sheet:I

    if-ltz p2, :cond_2

    invoke-static {v3}, Ljxl/biff/CellReferenceHelper;->getColumn(Ljava/lang/String;)I

    move-result p1

    iput p1, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    invoke-static {v3}, Ljxl/biff/CellReferenceHelper;->getRow(Ljava/lang/String;)I

    move-result p1

    iput p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    iput-boolean v2, p0, Ljxl/biff/formula/Area3d;->columnFirstRelative:Z

    iput-boolean v2, p0, Ljxl/biff/formula/Area3d;->rowFirstRelative:Z

    iput-boolean v2, p0, Ljxl/biff/formula/Area3d;->columnLastRelative:Z

    iput-boolean v2, p0, Ljxl/biff/formula/Area3d;->rowLastRelative:Z

    return-void

    :cond_2
    new-instance p2, Ljxl/biff/formula/FormulaException;

    sget-object v0, Ljxl/biff/formula/FormulaException;->SHEET_REF_NOT_FOUND:Ljxl/biff/formula/FormulaException$FormulaMessage;

    invoke-direct {p2, v0, p1}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;Ljava/lang/String;)V

    throw p2
.end method

.method constructor <init>(Ljxl/biff/formula/ExternalSheet;)V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/Operand;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/Area3d;->workbook:Ljxl/biff/formula/ExternalSheet;

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


# virtual methods
.method public adjustRelativeCellReferences(II)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/formula/Area3d;->columnFirstRelative:Z

    if-eqz v0, :cond_0

    iget v0, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    add-int/2addr v0, p1

    iput v0, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    :cond_0
    iget-boolean v0, p0, Ljxl/biff/formula/Area3d;->columnLastRelative:Z

    if-eqz v0, :cond_1

    iget v0, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    add-int/2addr v0, p1

    iput v0, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    :cond_1
    iget-boolean p1, p0, Ljxl/biff/formula/Area3d;->rowFirstRelative:Z

    if-eqz p1, :cond_2

    iget p1, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    add-int/2addr p1, p2

    iput p1, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    :cond_2
    iget-boolean p1, p0, Ljxl/biff/formula/Area3d;->rowLastRelative:Z

    if-eqz p1, :cond_3

    iget p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    add-int/2addr p1, p2

    iput p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    :cond_3
    return-void
.end method

.method public columnInserted(IIZ)V
    .locals 0

    iget p3, p0, Ljxl/biff/formula/Area3d;->sheet:I

    if-eq p1, p3, :cond_0

    return-void

    :cond_0
    iget p1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    if-lt p1, p2, :cond_1

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    :cond_1
    iget p1, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    if-lt p1, p2, :cond_2

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    :cond_2
    return-void
.end method

.method columnRemoved(IIZ)V
    .locals 0

    iget p3, p0, Ljxl/biff/formula/Area3d;->sheet:I

    if-eq p1, p3, :cond_0

    return-void

    :cond_0
    iget p1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    if-ge p2, p1, :cond_1

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    :cond_1
    iget p1, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    if-gt p2, p1, :cond_2

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    :cond_2
    return-void
.end method

.method getBytes()[B
    .locals 4

    const/16 v0, 0xb

    new-array v0, v0, [B

    sget-object v1, Ljxl/biff/formula/Token;->AREA3D:Ljxl/biff/formula/Token;

    invoke-virtual {v1}, Ljxl/biff/formula/Token;->getCode()B

    move-result v1

    const/4 v2, 0x0

    aput-byte v1, v0, v2

    iget v1, p0, Ljxl/biff/formula/Area3d;->sheet:I

    const/4 v2, 0x1

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    const/4 v2, 0x3

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    const/4 v2, 0x5

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    iget-boolean v2, p0, Ljxl/biff/formula/Area3d;->rowFirstRelative:Z

    const v3, 0x8000

    if-eqz v2, :cond_0

    or-int/2addr v1, v3

    :cond_0
    iget-boolean v2, p0, Ljxl/biff/formula/Area3d;->columnFirstRelative:Z

    if-eqz v2, :cond_1

    or-int/lit16 v1, v1, 0x4000

    :cond_1
    const/4 v2, 0x7

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    iget-boolean v2, p0, Ljxl/biff/formula/Area3d;->rowLastRelative:Z

    if-eqz v2, :cond_2

    or-int/2addr v1, v3

    :cond_2
    iget-boolean v2, p0, Ljxl/biff/formula/Area3d;->columnLastRelative:Z

    if-eqz v2, :cond_3

    or-int/lit16 v1, v1, 0x4000

    :cond_3
    const/16 v2, 0x9

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v0
.end method

.method getFirstColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    return v0
.end method

.method getFirstRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    return v0
.end method

.method getLastColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    return v0
.end method

.method getLastRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    return v0
.end method

.method public getString(Ljava/lang/StringBuffer;)V
    .locals 4

    iget v0, p0, Ljxl/biff/formula/Area3d;->sheet:I

    iget v1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    iget v2, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    iget-object v3, p0, Ljxl/biff/formula/Area3d;->workbook:Ljxl/biff/formula/ExternalSheet;

    invoke-static {v0, v1, v2, v3, p1}, Ljxl/biff/CellReferenceHelper;->getCellReference(IIILjxl/biff/formula/ExternalSheet;Ljava/lang/StringBuffer;)V

    const/16 v0, 0x3a

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    iget v0, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    iget v1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    invoke-static {v0, v1, p1}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    return-void
.end method

.method handleImportedCellReferences()V
    .locals 0

    invoke-virtual {p0}, Ljxl/biff/formula/ParseItem;->setInvalid()V

    return-void
.end method

.method public read([BI)I
    .locals 4

    aget-byte v0, p1, p2

    add-int/lit8 v1, p2, 0x1

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/biff/formula/Area3d;->sheet:I

    add-int/lit8 v0, p2, 0x2

    aget-byte v0, p1, v0

    add-int/lit8 v1, p2, 0x3

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    add-int/lit8 v0, p2, 0x4

    aget-byte v0, p1, v0

    add-int/lit8 v1, p2, 0x5

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    add-int/lit8 v0, p2, 0x6

    aget-byte v0, p1, v0

    add-int/lit8 v1, p2, 0x7

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    and-int/lit16 v1, v0, 0xff

    iput v1, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    and-int/lit16 v1, v0, 0x4000

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_0

    move v1, v3

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    iput-boolean v1, p0, Ljxl/biff/formula/Area3d;->columnFirstRelative:Z

    const v1, 0x8000

    and-int/2addr v0, v1

    if-eqz v0, :cond_1

    move v0, v3

    goto :goto_1

    :cond_1
    move v0, v2

    :goto_1
    iput-boolean v0, p0, Ljxl/biff/formula/Area3d;->rowFirstRelative:Z

    add-int/lit8 v0, p2, 0x8

    aget-byte v0, p1, v0

    add-int/lit8 p2, p2, 0x9

    aget-byte p1, p1, p2

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    and-int/lit16 p2, p1, 0xff

    iput p2, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    and-int/lit16 p2, p1, 0x4000

    if-eqz p2, :cond_2

    move p2, v3

    goto :goto_2

    :cond_2
    move p2, v2

    :goto_2
    iput-boolean p2, p0, Ljxl/biff/formula/Area3d;->columnLastRelative:Z

    and-int/2addr p1, v1

    if-eqz p1, :cond_3

    move v2, v3

    :cond_3
    iput-boolean v2, p0, Ljxl/biff/formula/Area3d;->rowLastRelative:Z

    const/16 p1, 0xa

    return p1
.end method

.method rowInserted(IIZ)V
    .locals 0

    iget p3, p0, Ljxl/biff/formula/Area3d;->sheet:I

    if-eq p1, p3, :cond_0

    return-void

    :cond_0
    iget p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    const p3, 0xffff

    if-ne p1, p3, :cond_1

    return-void

    :cond_1
    iget p3, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    if-gt p2, p3, :cond_2

    add-int/lit8 p3, p3, 0x1

    iput p3, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    :cond_2
    if-gt p2, p1, :cond_3

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    :cond_3
    return-void
.end method

.method rowRemoved(IIZ)V
    .locals 0

    iget p3, p0, Ljxl/biff/formula/Area3d;->sheet:I

    if-eq p1, p3, :cond_0

    return-void

    :cond_0
    iget p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    const p3, 0xffff

    if-ne p1, p3, :cond_1

    return-void

    :cond_1
    iget p3, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    if-ge p2, p3, :cond_2

    add-int/lit8 p3, p3, -0x1

    iput p3, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    :cond_2
    if-gt p2, p1, :cond_3

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    :cond_3
    return-void
.end method

.method protected setRangeData(IIIIIZZZZ)V
    .locals 0

    iput p1, p0, Ljxl/biff/formula/Area3d;->sheet:I

    iput p2, p0, Ljxl/biff/formula/Area3d;->columnFirst:I

    iput p3, p0, Ljxl/biff/formula/Area3d;->columnLast:I

    iput p4, p0, Ljxl/biff/formula/Area3d;->rowFirst:I

    iput p5, p0, Ljxl/biff/formula/Area3d;->rowLast:I

    iput-boolean p6, p0, Ljxl/biff/formula/Area3d;->columnFirstRelative:Z

    iput-boolean p7, p0, Ljxl/biff/formula/Area3d;->columnLastRelative:Z

    iput-boolean p8, p0, Ljxl/biff/formula/Area3d;->rowFirstRelative:Z

    iput-boolean p9, p0, Ljxl/biff/formula/Area3d;->rowLastRelative:Z

    return-void
.end method
