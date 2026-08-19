.class Ljxl/write/biff/WritableSheetCopier;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$SheetCopier:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private chartOnly:Z

.field private fonts:Ljava/util/HashMap;

.field private formatRecords:Ljxl/biff/FormattingRecords;

.field private formats:Ljava/util/HashMap;

.field private fromButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

.field private fromColumnBreaks:Ljava/util/ArrayList;

.field private fromColumnFormats:Ljava/util/TreeSet;

.field private fromDataValidation:Ljxl/biff/DataValidation;

.field private fromDrawings:Ljava/util/ArrayList;

.field private fromHyperlinks:Ljava/util/ArrayList;

.field private fromMergedCells:Ljxl/write/biff/MergedCells;

.field private fromPLSRecord:Ljxl/write/biff/PLSRecord;

.field private fromRowBreaks:Ljava/util/ArrayList;

.field private fromRows:[Ljxl/write/biff/RowRecord;

.field private fromSheet:Ljxl/write/biff/WritableSheetImpl;

.field private fromWorkspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

.field private maxColumnOutlineLevel:I

.field private maxRowOutlineLevel:I

.field private numRows:I

.field private sheetWriter:Ljxl/write/biff/SheetWriter;

.field private toButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

.field private toColumnBreaks:Ljava/util/ArrayList;

.field private toColumnFormats:Ljava/util/TreeSet;

.field private toDataValidation:Ljxl/biff/DataValidation;

.field private toDrawings:Ljava/util/ArrayList;

.field private toHyperlinks:Ljava/util/ArrayList;

.field private toImages:Ljava/util/ArrayList;

.field private toMergedCells:Ljxl/write/biff/MergedCells;

.field private toPLSRecord:Ljxl/write/biff/PLSRecord;

.field private toRowBreaks:Ljava/util/ArrayList;

.field private toSheet:Ljxl/write/biff/WritableSheetImpl;

.field private workbookSettings:Ljxl/WorkbookSettings;

.field private xfRecords:Ljava/util/HashMap;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/WritableSheetCopier;->class$jxl$write$biff$SheetCopier:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.SheetCopier"

    invoke-static {v0}, Ljxl/write/biff/WritableSheetCopier;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/WritableSheetCopier;->class$jxl$write$biff$SheetCopier:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/WritableSheetCopier;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/write/WritableSheet;Ljxl/write/WritableSheet;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    check-cast p1, Ljxl/write/biff/WritableSheetImpl;

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    check-cast p2, Ljxl/write/biff/WritableSheetImpl;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {p2}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSettings()Ljxl/WorkbookSettings;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/WritableSheetCopier;->chartOnly:Z

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

.method private copyCellFormat(Ljxl/format/CellFormat;)Ljxl/write/WritableCellFormat;
    .locals 5

    :try_start_0
    check-cast p1, Ljxl/biff/XFRecord;

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0, p1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/format/CellFormat;)V

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1, v0}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v1

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFontIndex()I

    move-result v1

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->fonts:Ljava/util/HashMap;

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v1}, Ljava/lang/Integer;-><init>(I)V

    new-instance v1, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljxl/biff/XFRecord;->getFontIndex()I

    move-result v4

    invoke-direct {v1, v4}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result p1

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->formats:Ljava/util/HashMap;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    new-instance p1, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result v3

    invoke-direct {p1, v3}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljxl/biff/NumFormatRecordsException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    sget-object p1, Ljxl/write/biff/WritableSheetCopier;->logger:Ljxl/common/Logger;

    const-string v0, "Maximum number of format records exceeded.  Using default format."

    invoke-virtual {p1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    sget-object p1, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    return-object p1
.end method

.method private deepCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;
    .locals 5

    invoke-direct {p0, p1}, Ljxl/write/biff/WritableSheetCopier;->shallowCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;

    move-result-object v0

    if-nez v0, :cond_0

    return-object v0

    :cond_0
    instance-of v1, v0, Ljxl/write/biff/ReadFormulaRecord;

    if-eqz v1, :cond_1

    move-object v1, v0

    check-cast v1, Ljxl/write/biff/ReadFormulaRecord;

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v2

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    iget-object v4, p0, Ljxl/write/biff/WritableSheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1, v2, v3, v4}, Ljxl/write/biff/ReadFormulaRecord;->handleImportedCellReferences(Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    if-eqz v2, :cond_1

    :try_start_0
    sget-object v0, Ljxl/write/biff/WritableSheetCopier;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Formula "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljxl/write/biff/ReadFormulaRecord;->getFormula()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " in cell "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v1

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v3

    invoke-static {v1, v3}, Ljxl/biff/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " cannot be imported because it references another "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " sheet from the source workbook"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljxl/biff/formula/FormulaException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    sget-object v1, Ljxl/write/biff/WritableSheetCopier;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Formula  in cell "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v3

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v4

    invoke-static {v3, v4}, Ljxl/biff/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v3, " cannot be imported:  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_0
    new-instance v0, Ljxl/write/Formula;

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v1

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result p1

    const-string v2, "\"ERROR\""

    invoke-direct {v0, v1, p1, v2}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    :cond_1
    invoke-interface {v0}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object p1

    move-object v1, p1

    check-cast v1, Ljxl/biff/XFRecord;

    invoke-virtual {v1}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v1

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/WritableCellFormat;

    if-nez v1, :cond_2

    invoke-direct {p0, p1}, Ljxl/write/biff/WritableSheetCopier;->copyCellFormat(Ljxl/format/CellFormat;)Ljxl/write/WritableCellFormat;

    move-result-object v1

    :cond_2
    invoke-interface {v0, v1}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    return-object v0
.end method

.method private shallowCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;
    .locals 2

    invoke-interface {p1}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v0

    sget-object v1, Ljxl/CellType;->LABEL:Ljxl/CellType;

    if-ne v0, v1, :cond_0

    new-instance v0, Ljxl/write/Label;

    check-cast p1, Ljxl/LabelCell;

    invoke-direct {v0, p1}, Ljxl/write/Label;-><init>(Ljxl/LabelCell;)V

    goto/16 :goto_0

    :cond_0
    sget-object v1, Ljxl/CellType;->NUMBER:Ljxl/CellType;

    if-ne v0, v1, :cond_1

    new-instance v0, Ljxl/write/Number;

    check-cast p1, Ljxl/NumberCell;

    invoke-direct {v0, p1}, Ljxl/write/Number;-><init>(Ljxl/NumberCell;)V

    goto/16 :goto_0

    :cond_1
    sget-object v1, Ljxl/CellType;->DATE:Ljxl/CellType;

    if-ne v0, v1, :cond_2

    new-instance v0, Ljxl/write/DateTime;

    check-cast p1, Ljxl/DateCell;

    invoke-direct {v0, p1}, Ljxl/write/DateTime;-><init>(Ljxl/DateCell;)V

    goto :goto_0

    :cond_2
    sget-object v1, Ljxl/CellType;->BOOLEAN:Ljxl/CellType;

    if-ne v0, v1, :cond_3

    new-instance v0, Ljxl/write/Boolean;

    check-cast p1, Ljxl/BooleanCell;

    invoke-direct {v0, p1}, Ljxl/write/Boolean;-><init>(Ljxl/BooleanCell;)V

    goto :goto_0

    :cond_3
    sget-object v1, Ljxl/CellType;->NUMBER_FORMULA:Ljxl/CellType;

    if-ne v0, v1, :cond_4

    new-instance v0, Ljxl/write/biff/ReadNumberFormulaRecord;

    check-cast p1, Ljxl/biff/FormulaData;

    invoke-direct {v0, p1}, Ljxl/write/biff/ReadNumberFormulaRecord;-><init>(Ljxl/biff/FormulaData;)V

    goto :goto_0

    :cond_4
    sget-object v1, Ljxl/CellType;->STRING_FORMULA:Ljxl/CellType;

    if-ne v0, v1, :cond_5

    new-instance v0, Ljxl/write/biff/ReadStringFormulaRecord;

    check-cast p1, Ljxl/biff/FormulaData;

    invoke-direct {v0, p1}, Ljxl/write/biff/ReadStringFormulaRecord;-><init>(Ljxl/biff/FormulaData;)V

    goto :goto_0

    :cond_5
    sget-object v1, Ljxl/CellType;->BOOLEAN_FORMULA:Ljxl/CellType;

    if-ne v0, v1, :cond_6

    new-instance v0, Ljxl/write/biff/ReadBooleanFormulaRecord;

    check-cast p1, Ljxl/biff/FormulaData;

    invoke-direct {v0, p1}, Ljxl/write/biff/ReadBooleanFormulaRecord;-><init>(Ljxl/biff/FormulaData;)V

    goto :goto_0

    :cond_6
    sget-object v1, Ljxl/CellType;->DATE_FORMULA:Ljxl/CellType;

    if-ne v0, v1, :cond_7

    new-instance v0, Ljxl/write/biff/ReadDateFormulaRecord;

    check-cast p1, Ljxl/biff/FormulaData;

    invoke-direct {v0, p1}, Ljxl/write/biff/ReadDateFormulaRecord;-><init>(Ljxl/biff/FormulaData;)V

    goto :goto_0

    :cond_7
    sget-object v1, Ljxl/CellType;->FORMULA_ERROR:Ljxl/CellType;

    if-ne v0, v1, :cond_8

    new-instance v0, Ljxl/write/biff/ReadErrorFormulaRecord;

    check-cast p1, Ljxl/biff/FormulaData;

    invoke-direct {v0, p1}, Ljxl/write/biff/ReadErrorFormulaRecord;-><init>(Ljxl/biff/FormulaData;)V

    goto :goto_0

    :cond_8
    sget-object v1, Ljxl/CellType;->EMPTY:Ljxl/CellType;

    if-ne v0, v1, :cond_9

    invoke-interface {p1}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object v0

    if-eqz v0, :cond_9

    new-instance v0, Ljxl/write/Blank;

    invoke-direct {v0, p1}, Ljxl/write/Blank;-><init>(Ljxl/Cell;)V

    goto :goto_0

    :cond_9
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method


# virtual methods
.method public copySheet()V
    .locals 11

    invoke-virtual {p0}, Ljxl/write/biff/WritableSheetCopier;->shallowCopyCells()V

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromColumnFormats:Ljava/util/TreeSet;

    invoke-virtual {v0}, Ljava/util/TreeSet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljxl/write/biff/ColumnInfoRecord;

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/ColumnInfoRecord;

    invoke-direct {v1, v2}, Ljxl/write/biff/ColumnInfoRecord;-><init>(Ljxl/write/biff/ColumnInfoRecord;)V

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->toColumnFormats:Ljava/util/TreeSet;

    invoke-virtual {v2, v1}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromMergedCells:Ljxl/write/biff/MergedCells;

    invoke-virtual {v0}, Ljxl/write/biff/MergedCells;->getMergedCells()[Ljxl/Range;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    :goto_1
    array-length v3, v0

    if-ge v2, v3, :cond_1

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->toMergedCells:Ljxl/write/biff/MergedCells;

    new-instance v4, Ljxl/biff/SheetRangeImpl;

    aget-object v5, v0, v2

    check-cast v5, Ljxl/biff/SheetRangeImpl;

    iget-object v6, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-direct {v4, v5, v6}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/biff/SheetRangeImpl;Ljxl/Sheet;)V

    invoke-virtual {v3, v4}, Ljxl/write/biff/MergedCells;->add(Ljxl/Range;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    move v0, v1

    :goto_2
    :try_start_0
    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->fromRows:[Ljxl/write/biff/RowRecord;

    array-length v3, v2

    if-ge v0, v3, :cond_4

    aget-object v2, v2, v0

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->isDefaultHeight()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->isCollapsed()Z

    move-result v3

    if-eqz v3, :cond_3

    :cond_2
    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3, v0}, Ljxl/write/biff/WritableSheetImpl;->getRowRecord(I)Ljxl/write/biff/RowRecord;

    move-result-object v4

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->getRowHeight()I

    move-result v5

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->matchesDefaultFontHeight()Z

    move-result v6

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->isCollapsed()Z

    move-result v7

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->getOutlineLevel()I

    move-result v8

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->getGroupStart()Z

    move-result v9

    invoke-virtual {v2}, Ljxl/write/biff/RowRecord;->getStyle()Ljxl/biff/XFRecord;

    move-result-object v10

    invoke-virtual/range {v4 .. v10}, Ljxl/write/biff/RowRecord;->setRowDetails(IZZIZLjxl/biff/XFRecord;)V
    :try_end_0
    .catch Ljxl/write/biff/RowsExceededException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :catch_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    :cond_4
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromRowBreaks:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toRowBreaks:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromColumnBreaks:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toColumnBreaks:Ljava/util/ArrayList;

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromDataValidation:Ljxl/biff/DataValidation;

    if-eqz v0, :cond_5

    new-instance v0, Ljxl/biff/DataValidation;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromDataValidation:Ljxl/biff/DataValidation;

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v2

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    iget-object v4, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v4

    invoke-virtual {v4}, Ljxl/write/biff/WritableWorkbookImpl;->getSettings()Ljxl/WorkbookSettings;

    move-result-object v4

    invoke-direct {v0, v1, v2, v3, v4}, Ljxl/biff/DataValidation;-><init>(Ljxl/biff/DataValidation;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iput-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toDataValidation:Ljxl/biff/DataValidation;

    :cond_5
    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1}, Ljxl/write/biff/WritableSheetImpl;->getCharts()[Ljxl/biff/drawing/Chart;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljxl/write/biff/SheetWriter;->setCharts([Ljxl/biff/drawing/Chart;)V

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromDrawings:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_6
    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Ljxl/biff/drawing/Drawing;

    if-eqz v2, :cond_6

    new-instance v2, Ljxl/write/WritableImage;

    check-cast v1, Ljxl/biff/drawing/Drawing;

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v3

    invoke-direct {v2, v1, v3}, Ljxl/write/WritableImage;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;)V

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->toDrawings:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->toImages:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_7
    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromWorkspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    invoke-virtual {v0, v1}, Ljxl/write/biff/SheetWriter;->setWorkspaceOptions(Ljxl/biff/WorkspaceInformationRecord;)V

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromPLSRecord:Ljxl/write/biff/PLSRecord;

    if-eqz v0, :cond_8

    new-instance v0, Ljxl/write/biff/PLSRecord;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromPLSRecord:Ljxl/write/biff/PLSRecord;

    invoke-direct {v0, v1}, Ljxl/write/biff/PLSRecord;-><init>(Ljxl/write/biff/PLSRecord;)V

    iput-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toPLSRecord:Ljxl/write/biff/PLSRecord;

    :cond_8
    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    if-eqz v0, :cond_9

    new-instance v0, Ljxl/write/biff/ButtonPropertySetRecord;

    iget-object v1, p0, Ljxl/write/biff/WritableSheetCopier;->fromButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    invoke-direct {v0, v1}, Ljxl/write/biff/ButtonPropertySetRecord;-><init>(Ljxl/write/biff/ButtonPropertySetRecord;)V

    iput-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    :cond_9
    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromHyperlinks:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_4
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_a

    new-instance v1, Ljxl/write/WritableHyperlink;

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/WritableHyperlink;

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-direct {v1, v2, v3}, Ljxl/write/WritableHyperlink;-><init>(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V

    iget-object v2, p0, Ljxl/write/biff/WritableSheetCopier;->toHyperlinks:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4

    :cond_a
    return-void
.end method

.method deepCopyCells()V
    .locals 7

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getRows()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3, v2}, Ljxl/write/biff/WritableSheetImpl;->getRow(I)[Ljxl/Cell;

    move-result-object v3

    move v4, v1

    :goto_1
    array-length v5, v3

    if-ge v4, v5, :cond_1

    aget-object v5, v3, v4

    invoke-direct {p0, v5}, Ljxl/write/biff/WritableSheetCopier;->deepCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;

    move-result-object v5

    if-eqz v5, :cond_0

    :try_start_0
    iget-object v6, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6, v5}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V
    :try_end_0
    .catch Ljxl/write/WriteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    :cond_0
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method getButtonPropertySet()Ljxl/write/biff/ButtonPropertySetRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    return-object v0
.end method

.method getDataValidation()Ljxl/biff/DataValidation;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toDataValidation:Ljxl/biff/DataValidation;

    return-object v0
.end method

.method public getMaxColumnOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/WritableSheetCopier;->maxColumnOutlineLevel:I

    return v0
.end method

.method public getMaxRowOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/WritableSheetCopier;->maxRowOutlineLevel:I

    return v0
.end method

.method getPLSRecord()Ljxl/write/biff/PLSRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toPLSRecord:Ljxl/write/biff/PLSRecord;

    return-object v0
.end method

.method isChartOnly()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/write/biff/WritableSheetCopier;->chartOnly:Z

    return v0
.end method

.method setButtonPropertySetRecord(Ljxl/write/biff/ButtonPropertySetRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromButtonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    return-void
.end method

.method setColumnBreaks(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromColumnBreaks:Ljava/util/ArrayList;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toColumnBreaks:Ljava/util/ArrayList;

    return-void
.end method

.method setColumnFormats(Ljava/util/TreeSet;Ljava/util/TreeSet;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromColumnFormats:Ljava/util/TreeSet;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toColumnFormats:Ljava/util/TreeSet;

    return-void
.end method

.method setDataValidation(Ljxl/biff/DataValidation;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromDataValidation:Ljxl/biff/DataValidation;

    return-void
.end method

.method setDrawings(Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromDrawings:Ljava/util/ArrayList;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toDrawings:Ljava/util/ArrayList;

    iput-object p3, p0, Ljxl/write/biff/WritableSheetCopier;->toImages:Ljava/util/ArrayList;

    return-void
.end method

.method setHyperlinks(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromHyperlinks:Ljava/util/ArrayList;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toHyperlinks:Ljava/util/ArrayList;

    return-void
.end method

.method setMergedCells(Ljxl/write/biff/MergedCells;Ljxl/write/biff/MergedCells;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromMergedCells:Ljxl/write/biff/MergedCells;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toMergedCells:Ljxl/write/biff/MergedCells;

    return-void
.end method

.method setPLSRecord(Ljxl/write/biff/PLSRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromPLSRecord:Ljxl/write/biff/PLSRecord;

    return-void
.end method

.method setRowBreaks(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromRowBreaks:Ljava/util/ArrayList;

    iput-object p2, p0, Ljxl/write/biff/WritableSheetCopier;->toRowBreaks:Ljava/util/ArrayList;

    return-void
.end method

.method setRows([Ljxl/write/biff/RowRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromRows:[Ljxl/write/biff/RowRecord;

    return-void
.end method

.method setSheetWriter(Ljxl/write/biff/SheetWriter;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    return-void
.end method

.method setWorkspaceOptions(Ljxl/biff/WorkspaceInformationRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/WritableSheetCopier;->fromWorkspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    return-void
.end method

.method shallowCopyCells()V
    .locals 7

    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getRows()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Ljxl/write/biff/WritableSheetCopier;->fromSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3, v2}, Ljxl/write/biff/WritableSheetImpl;->getRow(I)[Ljxl/Cell;

    move-result-object v3

    move v4, v1

    :goto_1
    array-length v5, v3

    if-ge v4, v5, :cond_1

    aget-object v5, v3, v4

    invoke-direct {p0, v5}, Ljxl/write/biff/WritableSheetCopier;->shallowCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;

    move-result-object v5

    if-eqz v5, :cond_0

    :try_start_0
    iget-object v6, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6, v5}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V
    :try_end_0
    .catch Ljxl/write/WriteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    :cond_0
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/WritableSheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getRows()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/WritableSheetCopier;->numRows:I

    return-void
.end method
