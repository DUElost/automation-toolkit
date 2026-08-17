.class public abstract Ljxl/read/biff/BaseSharedFormulaRecord;
.super Ljxl/read/biff/CellValue;
.source ""

# interfaces
.implements Ljxl/biff/FormulaData;


# instance fields
.field private externalSheet:Ljxl/biff/formula/ExternalSheet;

.field private filePos:I

.field private formulaString:Ljava/lang/String;

.field private nameTable:Ljxl/biff/WorkbookMethods;

.field private tokens:[B


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/read/biff/SheetImpl;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p5}, Ljxl/read/biff/CellValue;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    iput-object p3, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    iput-object p4, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->nameTable:Ljxl/biff/WorkbookMethods;

    iput p6, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->filePos:I

    return-void
.end method


# virtual methods
.method protected final getExternalSheet()Ljxl/biff/formula/ExternalSheet;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    return-object v0
.end method

.method final getFilePos()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->filePos:I

    return v0
.end method

.method public getFormula()Ljava/lang/String;
    .locals 7

    iget-object v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->formulaString:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/biff/formula/FormulaParser;

    iget-object v2, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->tokens:[B

    iget-object v4, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    iget-object v5, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->nameTable:Ljxl/biff/WorkbookMethods;

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

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->formulaString:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->formulaString:Ljava/lang/String;

    return-object v0
.end method

.method protected final getNameTable()Ljxl/biff/WorkbookMethods;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->nameTable:Ljxl/biff/WorkbookMethods;

    return-object v0
.end method

.method public getRecord()Ljxl/read/biff/Record;
    .locals 1

    invoke-super {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    return-object v0
.end method

.method protected final getTokens()[B
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->tokens:[B

    return-object v0
.end method

.method setTokens([B)V
    .locals 0

    iput-object p1, p0, Ljxl/read/biff/BaseSharedFormulaRecord;->tokens:[B

    return-void
.end method
