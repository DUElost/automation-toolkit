.class public Ljxl/read/biff/SharedDateFormulaRecord;
.super Ljxl/read/biff/BaseSharedFormulaRecord;
.source ""

# interfaces
.implements Ljxl/DateCell;
.implements Ljxl/biff/FormulaData;
.implements Ljxl/DateFormulaCell;


# instance fields
.field private dateRecord:Ljxl/read/biff/DateRecord;

.field private value:D


# direct methods
.method public constructor <init>(Ljxl/read/biff/SharedNumberFormulaRecord;Ljxl/biff/FormattingRecords;ZLjxl/read/biff/SheetImpl;I)V
    .locals 14

    move-object v7, p0

    invoke-virtual {p1}, Ljxl/read/biff/BaseSharedFormulaRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object v1

    invoke-virtual {p1}, Ljxl/read/biff/BaseSharedFormulaRecord;->getExternalSheet()Ljxl/biff/formula/ExternalSheet;

    move-result-object v3

    invoke-virtual {p1}, Ljxl/read/biff/BaseSharedFormulaRecord;->getNameTable()Ljxl/biff/WorkbookMethods;

    move-result-object v4

    move-object v0, p0

    move-object/from16 v2, p2

    move-object/from16 v5, p4

    move/from16 v6, p5

    invoke-direct/range {v0 .. v6}, Ljxl/read/biff/BaseSharedFormulaRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/read/biff/SheetImpl;I)V

    new-instance v0, Ljxl/read/biff/DateRecord;

    invoke-virtual {p1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v10

    move-object v8, v0

    move-object v9, p1

    move-object/from16 v11, p2

    move/from16 v12, p3

    move-object/from16 v13, p4

    invoke-direct/range {v8 .. v13}, Ljxl/read/biff/DateRecord;-><init>(Ljxl/NumberCell;ILjxl/biff/FormattingRecords;ZLjxl/read/biff/SheetImpl;)V

    iput-object v0, v7, Ljxl/read/biff/SharedDateFormulaRecord;->dateRecord:Ljxl/read/biff/DateRecord;

    invoke-virtual {p1}, Ljxl/read/biff/SharedNumberFormulaRecord;->getValue()D

    move-result-wide v0

    iput-wide v0, v7, Ljxl/read/biff/SharedDateFormulaRecord;->value:D

    return-void
.end method


# virtual methods
.method public getContents()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SharedDateFormulaRecord;->dateRecord:Ljxl/read/biff/DateRecord;

    invoke-virtual {v0}, Ljxl/read/biff/DateRecord;->getContents()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDate()Ljava/util/Date;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SharedDateFormulaRecord;->dateRecord:Ljxl/read/biff/DateRecord;

    invoke-virtual {v0}, Ljxl/read/biff/DateRecord;->getDate()Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getDateFormat()Ljava/text/DateFormat;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SharedDateFormulaRecord;->dateRecord:Ljxl/read/biff/DateRecord;

    invoke-virtual {v0}, Ljxl/read/biff/DateRecord;->getDateFormat()Ljava/text/DateFormat;

    move-result-object v0

    return-object v0
.end method

.method public getFormulaData()[B
    .locals 8

    invoke-virtual {p0}, Ljxl/read/biff/CellValue;->getSheet()Ljxl/read/biff/SheetImpl;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getWorkbookBof()Ljxl/read/biff/BOFRecord;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljxl/biff/formula/FormulaParser;

    invoke-virtual {p0}, Ljxl/read/biff/BaseSharedFormulaRecord;->getTokens()[B

    move-result-object v2

    invoke-virtual {p0}, Ljxl/read/biff/BaseSharedFormulaRecord;->getExternalSheet()Ljxl/biff/formula/ExternalSheet;

    move-result-object v4

    invoke-virtual {p0}, Ljxl/read/biff/BaseSharedFormulaRecord;->getNameTable()Ljxl/biff/WorkbookMethods;

    move-result-object v5

    invoke-virtual {p0}, Ljxl/read/biff/CellValue;->getSheet()Ljxl/read/biff/SheetImpl;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getWorkbook()Ljxl/read/biff/WorkbookParser;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getSettings()Ljxl/WorkbookSettings;

    move-result-object v6

    move-object v1, v0

    move-object v3, p0

    invoke-direct/range {v1 .. v6}, Ljxl/biff/formula/FormulaParser;-><init>([BLjxl/Cell;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->parse()V

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getBytes()[B

    move-result-object v0

    array-length v1, v0

    const/16 v2, 0x16

    add-int/2addr v1, v2

    new-array v3, v1, [B

    invoke-virtual {p0}, Ljxl/read/biff/CellValue;->getRow()I

    move-result v4

    const/4 v5, 0x0

    invoke-static {v4, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    invoke-virtual {p0}, Ljxl/read/biff/CellValue;->getColumn()I

    move-result v4

    const/4 v6, 0x2

    invoke-static {v4, v3, v6}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    invoke-virtual {p0}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v4

    const/4 v6, 0x4

    invoke-static {v4, v3, v6}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-wide v6, p0, Ljxl/read/biff/SharedDateFormulaRecord;->value:D

    const/4 v4, 0x6

    invoke-static {v6, v7, v3, v4}, Ljxl/biff/DoubleHelper;->getIEEEBytes(D[BI)V

    array-length v6, v0

    invoke-static {v0, v5, v3, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v0, v0

    const/16 v2, 0x14

    invoke-static {v0, v3, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    sub-int/2addr v1, v4

    new-array v0, v1, [B

    invoke-static {v3, v4, v0, v5, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v0

    :cond_0
    new-instance v0, Ljxl/biff/formula/FormulaException;

    sget-object v1, Ljxl/biff/formula/FormulaException;->BIFF8_SUPPORTED:Ljxl/biff/formula/FormulaException$FormulaMessage;

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;)V

    throw v0
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->DATE_FORMULA:Ljxl/CellType;

    return-object v0
.end method

.method public getValue()D
    .locals 2

    iget-wide v0, p0, Ljxl/read/biff/SharedDateFormulaRecord;->value:D

    return-wide v0
.end method

.method public isTime()Z
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SharedDateFormulaRecord;->dateRecord:Ljxl/read/biff/DateRecord;

    invoke-virtual {v0}, Ljxl/read/biff/DateRecord;->isTime()Z

    move-result v0

    return v0
.end method
