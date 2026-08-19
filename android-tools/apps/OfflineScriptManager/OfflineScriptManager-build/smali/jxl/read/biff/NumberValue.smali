.class Ljxl/read/biff/NumberValue;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/NumberCell;
.implements Ljxl/read/biff/CellFeaturesAccessor;


# static fields
.field private static defaultFormat:Ljava/text/DecimalFormat;


# instance fields
.field private cellFormat:Ljxl/format/CellFormat;

.field private column:I

.field private features:Ljxl/CellFeatures;

.field private format:Ljava/text/NumberFormat;

.field private formattingRecords:Ljxl/biff/FormattingRecords;

.field private initialized:Z

.field private row:I

.field private sheet:Ljxl/read/biff/SheetImpl;

.field private value:D

.field private xfIndex:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/text/DecimalFormat;

    const-string v1, "#.###"

    invoke-direct {v0, v1}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/read/biff/NumberValue;->defaultFormat:Ljava/text/DecimalFormat;

    return-void
.end method

.method public constructor <init>(IIDILjxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/read/biff/NumberValue;->row:I

    iput p2, p0, Ljxl/read/biff/NumberValue;->column:I

    iput-wide p3, p0, Ljxl/read/biff/NumberValue;->value:D

    sget-object p1, Ljxl/read/biff/NumberValue;->defaultFormat:Ljava/text/DecimalFormat;

    iput-object p1, p0, Ljxl/read/biff/NumberValue;->format:Ljava/text/NumberFormat;

    iput p5, p0, Ljxl/read/biff/NumberValue;->xfIndex:I

    iput-object p6, p0, Ljxl/read/biff/NumberValue;->formattingRecords:Ljxl/biff/FormattingRecords;

    iput-object p7, p0, Ljxl/read/biff/NumberValue;->sheet:Ljxl/read/biff/SheetImpl;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/read/biff/NumberValue;->initialized:Z

    return-void
.end method


# virtual methods
.method public getCellFeatures()Ljxl/CellFeatures;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/NumberValue;->features:Ljxl/CellFeatures;

    return-object v0
.end method

.method public getCellFormat()Ljxl/format/CellFormat;
    .locals 2

    iget-boolean v0, p0, Ljxl/read/biff/NumberValue;->initialized:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/read/biff/NumberValue;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget v1, p0, Ljxl/read/biff/NumberValue;->xfIndex:I

    invoke-virtual {v0, v1}, Ljxl/biff/FormattingRecords;->getXFRecord(I)Ljxl/biff/XFRecord;

    move-result-object v0

    iput-object v0, p0, Ljxl/read/biff/NumberValue;->cellFormat:Ljxl/format/CellFormat;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/read/biff/NumberValue;->initialized:Z

    :cond_0
    iget-object v0, p0, Ljxl/read/biff/NumberValue;->cellFormat:Ljxl/format/CellFormat;

    return-object v0
.end method

.method public final getColumn()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/NumberValue;->column:I

    return v0
.end method

.method public getContents()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Ljxl/read/biff/NumberValue;->format:Ljava/text/NumberFormat;

    iget-wide v1, p0, Ljxl/read/biff/NumberValue;->value:D

    invoke-virtual {v0, v1, v2}, Ljava/text/NumberFormat;->format(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNumberFormat()Ljava/text/NumberFormat;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/NumberValue;->format:Ljava/text/NumberFormat;

    return-object v0
.end method

.method public final getRow()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/NumberValue;->row:I

    return v0
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->NUMBER:Ljxl/CellType;

    return-object v0
.end method

.method public getValue()D
    .locals 2

    iget-wide v0, p0, Ljxl/read/biff/NumberValue;->value:D

    return-wide v0
.end method

.method public isHidden()Z
    .locals 3

    iget-object v0, p0, Ljxl/read/biff/NumberValue;->sheet:Ljxl/read/biff/SheetImpl;

    iget v1, p0, Ljxl/read/biff/NumberValue;->column:I

    invoke-virtual {v0, v1}, Ljxl/read/biff/SheetImpl;->getColumnInfo(I)Ljxl/read/biff/ColumnInfoRecord;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/read/biff/ColumnInfoRecord;->getWidth()I

    move-result v0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Ljxl/read/biff/NumberValue;->sheet:Ljxl/read/biff/SheetImpl;

    iget v2, p0, Ljxl/read/biff/NumberValue;->row:I

    invoke-virtual {v0, v2}, Ljxl/read/biff/SheetImpl;->getRowInfo(I)Ljxl/read/biff/RowRecord;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljxl/read/biff/RowRecord;->getRowHeight()I

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Ljxl/read/biff/RowRecord;->isCollapsed()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    return v1

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public setCellFeatures(Ljxl/CellFeatures;)V
    .locals 0

    iput-object p1, p0, Ljxl/read/biff/NumberValue;->features:Ljxl/CellFeatures;

    return-void
.end method

.method final setNumberFormat(Ljava/text/NumberFormat;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Ljxl/read/biff/NumberValue;->format:Ljava/text/NumberFormat;

    :cond_0
    return-void
.end method
