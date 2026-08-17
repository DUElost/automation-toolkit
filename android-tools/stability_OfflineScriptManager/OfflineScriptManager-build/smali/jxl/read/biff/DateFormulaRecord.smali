.class Ljxl/read/biff/DateFormulaRecord;
.super Ljxl/read/biff/DateRecord;
.source ""

# interfaces
.implements Ljxl/DateCell;
.implements Ljxl/biff/FormulaData;
.implements Ljxl/DateFormulaCell;


# instance fields
.field private data:[B

.field private externalSheet:Ljxl/biff/formula/ExternalSheet;

.field private formulaString:Ljava/lang/String;

.field private nameTable:Ljxl/biff/WorkbookMethods;


# direct methods
.method public constructor <init>(Ljxl/read/biff/NumberFormulaRecord;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;ZLjxl/read/biff/SheetImpl;)V
    .locals 6

    invoke-virtual {p1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v2

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Ljxl/read/biff/DateRecord;-><init>(Ljxl/NumberCell;ILjxl/biff/FormattingRecords;ZLjxl/read/biff/SheetImpl;)V

    iput-object p3, p0, Ljxl/read/biff/DateFormulaRecord;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    iput-object p4, p0, Ljxl/read/biff/DateFormulaRecord;->nameTable:Ljxl/biff/WorkbookMethods;

    invoke-virtual {p1}, Ljxl/read/biff/NumberFormulaRecord;->getFormulaData()[B

    move-result-object p1

    iput-object p1, p0, Ljxl/read/biff/DateFormulaRecord;->data:[B

    return-void
.end method


# virtual methods
.method public getFormula()Ljava/lang/String;
    .locals 9

    iget-object v0, p0, Ljxl/read/biff/DateFormulaRecord;->formulaString:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/read/biff/DateFormulaRecord;->data:[B

    array-length v1, v0

    const/16 v2, 0x10

    sub-int/2addr v1, v2

    new-array v4, v1, [B

    const/4 v3, 0x0

    invoke-static {v0, v2, v4, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance v0, Ljxl/biff/formula/FormulaParser;

    iget-object v6, p0, Ljxl/read/biff/DateFormulaRecord;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    iget-object v7, p0, Ljxl/read/biff/DateFormulaRecord;->nameTable:Ljxl/biff/WorkbookMethods;

    invoke-virtual {p0}, Ljxl/read/biff/DateRecord;->getSheet()Ljxl/read/biff/SheetImpl;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getWorkbook()Ljxl/read/biff/WorkbookParser;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getSettings()Ljxl/WorkbookSettings;

    move-result-object v8

    move-object v3, v0

    move-object v5, p0

    invoke-direct/range {v3 .. v8}, Ljxl/biff/formula/FormulaParser;-><init>([BLjxl/Cell;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->parse()V

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljxl/read/biff/DateFormulaRecord;->formulaString:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Ljxl/read/biff/DateFormulaRecord;->formulaString:Ljava/lang/String;

    return-object v0
.end method

.method public getFormulaData()[B
    .locals 2

    invoke-virtual {p0}, Ljxl/read/biff/DateRecord;->getSheet()Ljxl/read/biff/SheetImpl;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getWorkbookBof()Ljxl/read/biff/BOFRecord;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/read/biff/DateFormulaRecord;->data:[B

    return-object v0

    :cond_0
    new-instance v0, Ljxl/biff/formula/FormulaException;

    sget-object v1, Ljxl/biff/formula/FormulaException;->BIFF8_SUPPORTED:Ljxl/biff/formula/FormulaException$FormulaMessage;

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;)V

    throw v0
.end method

.method public getNumberFormat()Ljava/text/NumberFormat;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->DATE_FORMULA:Ljxl/CellType;

    return-object v0
.end method

.method public getValue()D
    .locals 2

    const-wide/16 v0, 0x0

    return-wide v0
.end method
