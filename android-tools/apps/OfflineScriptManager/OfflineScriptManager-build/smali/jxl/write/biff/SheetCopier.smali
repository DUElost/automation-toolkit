.class Ljxl/write/biff/SheetCopier;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$SheetCopier:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private autoFilter:Ljxl/biff/AutoFilter;

.field private buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

.field private chartOnly:Z

.field private columnBreaks:Ljava/util/ArrayList;

.field private columnFormats:Ljava/util/TreeSet;

.field private comboBox:Ljxl/biff/drawing/ComboBox;

.field private conditionalFormats:Ljava/util/ArrayList;

.field private dataValidation:Ljxl/biff/DataValidation;

.field private drawings:Ljava/util/ArrayList;

.field private fonts:Ljava/util/HashMap;

.field private formatRecords:Ljxl/biff/FormattingRecords;

.field private formats:Ljava/util/HashMap;

.field private fromSheet:Ljxl/read/biff/SheetImpl;

.field private hyperlinks:Ljava/util/ArrayList;

.field private images:Ljava/util/ArrayList;

.field private maxColumnOutlineLevel:I

.field private maxRowOutlineLevel:I

.field private mergedCells:Ljxl/write/biff/MergedCells;

.field private numRows:I

.field private plsRecord:Ljxl/write/biff/PLSRecord;

.field private rowBreaks:Ljava/util/ArrayList;

.field private sheetWriter:Ljxl/write/biff/SheetWriter;

.field private toSheet:Ljxl/write/biff/WritableSheetImpl;

.field private workbookSettings:Ljxl/WorkbookSettings;

.field private xfRecords:Ljava/util/HashMap;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/SheetCopier;->class$jxl$write$biff$SheetCopier:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.SheetCopier"

    invoke-static {v0}, Ljxl/write/biff/SheetCopier;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/SheetCopier;->class$jxl$write$biff$SheetCopier:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/Sheet;Ljxl/write/WritableSheet;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    check-cast p1, Ljxl/read/biff/SheetImpl;

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    check-cast p2, Ljxl/write/biff/WritableSheetImpl;

    iput-object p2, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {p2}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSettings()Ljxl/WorkbookSettings;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/SheetCopier;->chartOnly:Z

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

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1, v0}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v1

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFontIndex()I

    move-result v1

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fonts:Ljava/util/HashMap;

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v1}, Ljava/lang/Integer;-><init>(I)V

    new-instance v1, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljxl/biff/XFRecord;->getFontIndex()I

    move-result v4

    invoke-direct {v1, v4}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result p1

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->formats:Ljava/util/HashMap;

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
    sget-object p1, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

    const-string v0, "Maximum number of format records exceeded.  Using default format."

    invoke-virtual {p1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    sget-object p1, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    return-object p1
.end method

.method private deepCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;
    .locals 5

    invoke-direct {p0, p1}, Ljxl/write/biff/SheetCopier;->shallowCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;

    move-result-object v0

    if-nez v0, :cond_0

    return-object v0

    :cond_0
    instance-of v1, v0, Ljxl/write/biff/ReadFormulaRecord;

    if-eqz v1, :cond_1

    move-object v1, v0

    check-cast v1, Ljxl/write/biff/ReadFormulaRecord;

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getWorkbook()Ljxl/read/biff/WorkbookParser;

    move-result-object v2

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v3}, Ljxl/read/biff/SheetImpl;->getWorkbook()Ljxl/read/biff/WorkbookParser;

    move-result-object v3

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1, v2, v3, v4}, Ljxl/write/biff/ReadFormulaRecord;->handleImportedCellReferences(Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    if-eqz v2, :cond_1

    :try_start_0
    sget-object v0, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

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

    sget-object v1, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

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

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/WritableCellFormat;

    if-nez v1, :cond_2

    invoke-direct {p0, p1}, Ljxl/write/biff/SheetCopier;->copyCellFormat(Ljxl/format/CellFormat;)Ljxl/write/WritableCellFormat;

    move-result-object v1

    :cond_2
    invoke-interface {v0, v1}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    return-object v0
.end method

.method private importNames()V
    .locals 18

    move-object/from16 v0, p0

    iget-object v1, v0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getWorkbook()Ljxl/read/biff/WorkbookParser;

    move-result-object v1

    iget-object v2, v0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v2

    iget-object v3, v0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1, v3}, Ljxl/read/biff/WorkbookParser;->getIndex(Ljxl/Sheet;)I

    move-result v10

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getNameRecords()[Ljxl/read/biff/NameRecord;

    move-result-object v11

    invoke-virtual {v2}, Ljxl/write/WritableWorkbook;->getRangeNames()[Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x0

    move v14, v13

    :goto_0
    array-length v3, v11

    if-ge v14, v3, :cond_3

    aget-object v3, v11, v14

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord;->getRanges()[Ljxl/read/biff/NameRecord$NameRange;

    move-result-object v15

    move v9, v13

    :goto_1
    array-length v3, v15

    if-ge v9, v3, :cond_2

    aget-object v3, v15, v9

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v3

    invoke-virtual {v1, v3}, Ljxl/read/biff/WorkbookParser;->getExternalSheetIndex(I)I

    move-result v3

    if-ne v10, v3, :cond_1

    aget-object v3, v11, v14

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v12, v4}, Ljava/util/Arrays;->binarySearch([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v3

    if-gez v3, :cond_0

    iget-object v5, v0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    aget-object v3, v15, v9

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord$NameRange;->getFirstColumn()I

    move-result v6

    aget-object v3, v15, v9

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord$NameRange;->getFirstRow()I

    move-result v7

    aget-object v3, v15, v9

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord$NameRange;->getLastColumn()I

    move-result v8

    aget-object v3, v15, v9

    invoke-virtual {v3}, Ljxl/read/biff/NameRecord$NameRange;->getLastRow()I

    move-result v16

    move-object v3, v2

    move/from16 v17, v9

    move/from16 v9, v16

    invoke-virtual/range {v3 .. v9}, Ljxl/write/WritableWorkbook;->addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V

    goto :goto_2

    :cond_0
    move/from16 v17, v9

    sget-object v3, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    const-string v6, "Named range "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v4, " is already present in the destination workbook"

    invoke-virtual {v5, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :cond_1
    move/from16 v17, v9

    :goto_2
    add-int/lit8 v9, v17, 0x1

    goto :goto_1

    :cond_2
    add-int/lit8 v14, v14, 0x1

    goto :goto_0

    :cond_3
    return-void
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
    .locals 13

    invoke-virtual {p0}, Ljxl/write/biff/SheetCopier;->shallowCopyCells()V

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getColumnInfos()[Ljxl/read/biff/ColumnInfoRecord;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_1

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljxl/read/biff/ColumnInfoRecord;->getStartColumn()I

    move-result v4

    :goto_1
    invoke-virtual {v3}, Ljxl/read/biff/ColumnInfoRecord;->getEndColumn()I

    move-result v5

    if-gt v4, v5, :cond_0

    new-instance v5, Ljxl/write/biff/ColumnInfoRecord;

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-direct {v5, v3, v4, v6}, Ljxl/write/biff/ColumnInfoRecord;-><init>(Ljxl/read/biff/ColumnInfoRecord;ILjxl/biff/FormattingRecords;)V

    invoke-virtual {v3}, Ljxl/read/biff/ColumnInfoRecord;->getHidden()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljxl/write/biff/ColumnInfoRecord;->setHidden(Z)V

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->columnFormats:Ljava/util/TreeSet;

    invoke-virtual {v6, v5}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getHyperlinks()[Ljxl/Hyperlink;

    move-result-object v0

    move v2, v1

    :goto_2
    array-length v3, v0

    if-ge v2, v3, :cond_2

    new-instance v3, Ljxl/write/WritableHyperlink;

    aget-object v4, v0, v2

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-direct {v3, v4, v5}, Ljxl/write/WritableHyperlink;-><init>(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->hyperlinks:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getMergedCells()[Ljxl/Range;

    move-result-object v0

    move v2, v1

    :goto_3
    array-length v3, v0

    if-ge v2, v3, :cond_3

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->mergedCells:Ljxl/write/biff/MergedCells;

    new-instance v4, Ljxl/biff/SheetRangeImpl;

    aget-object v5, v0, v2

    check-cast v5, Ljxl/biff/SheetRangeImpl;

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-direct {v4, v5, v6}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/biff/SheetRangeImpl;Ljxl/Sheet;)V

    invoke-virtual {v3, v4}, Ljxl/write/biff/MergedCells;->add(Ljxl/Range;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    :cond_3
    const/4 v0, 0x1

    :try_start_0
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getRowProperties()[Ljxl/read/biff/RowRecord;

    move-result-object v2

    move v3, v1

    :goto_4
    array-length v4, v2

    if-ge v3, v4, :cond_5

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    aget-object v5, v2, v3

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getRowNumber()I

    move-result v5

    invoke-virtual {v4, v5}, Ljxl/write/biff/WritableSheetImpl;->getRowRecord(I)Ljxl/write/biff/RowRecord;

    move-result-object v6

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/read/biff/RowRecord;->hasDefaultFormat()Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->formatRecords:Ljxl/biff/FormattingRecords;

    aget-object v5, v2, v3

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getXFIndex()I

    move-result v5

    invoke-virtual {v4, v5}, Ljxl/biff/FormattingRecords;->getXFRecord(I)Ljxl/biff/XFRecord;

    move-result-object v4

    goto :goto_5

    :cond_4
    const/4 v4, 0x0

    :goto_5
    move-object v12, v4

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/read/biff/RowRecord;->getRowHeight()I

    move-result v7

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/read/biff/RowRecord;->matchesDefaultFontHeight()Z

    move-result v8

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/read/biff/RowRecord;->isCollapsed()Z

    move-result v9

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/read/biff/RowRecord;->getOutlineLevel()I

    move-result v10

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/read/biff/RowRecord;->getGroupStart()Z

    move-result v11

    invoke-virtual/range {v6 .. v12}, Ljxl/write/biff/RowRecord;->setRowDetails(IZZIZLjxl/biff/XFRecord;)V

    iget v4, p0, Ljxl/write/biff/SheetCopier;->numRows:I

    aget-object v5, v2, v3

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getRowNumber()I

    move-result v5

    add-int/2addr v5, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    iput v4, p0, Ljxl/write/biff/SheetCopier;->numRows:I
    :try_end_0
    .catch Ljxl/write/biff/RowsExceededException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    :catch_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    :cond_5
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getRowPageBreaks()[I

    move-result-object v2

    if-eqz v2, :cond_6

    move v3, v1

    :goto_6
    array-length v4, v2

    if-ge v3, v4, :cond_6

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->rowBreaks:Ljava/util/ArrayList;

    new-instance v5, Ljava/lang/Integer;

    aget v6, v2, v3

    invoke-direct {v5, v6}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_6

    :cond_6
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getColumnPageBreaks()[I

    move-result-object v2

    if-eqz v2, :cond_7

    move v3, v1

    :goto_7
    array-length v4, v2

    if-ge v3, v4, :cond_7

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->columnBreaks:Ljava/util/ArrayList;

    new-instance v5, Ljava/lang/Integer;

    aget v6, v2, v3

    invoke-direct {v5, v6}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_7

    :cond_7
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v3}, Ljxl/read/biff/SheetImpl;->getCharts()[Ljxl/biff/drawing/Chart;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljxl/write/biff/SheetWriter;->setCharts([Ljxl/biff/drawing/Chart;)V

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getDrawings()[Ljxl/biff/drawing/DrawingGroupObject;

    move-result-object v2

    move v3, v1

    :goto_8
    array-length v4, v2

    if-ge v3, v4, :cond_e

    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/Drawing;

    if-eqz v4, :cond_8

    new-instance v4, Ljxl/write/WritableImage;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Ljxl/write/WritableImage;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;)V

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->images:Ljava/util/ArrayList;

    :goto_9
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_c

    :cond_8
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/Comment;

    if-eqz v4, :cond_a

    new-instance v4, Ljxl/biff/drawing/Comment;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/Comment;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4}, Ljxl/biff/drawing/Comment;->getColumn()I

    move-result v6

    invoke-virtual {v4}, Ljxl/biff/drawing/Comment;->getRow()I

    move-result v7

    invoke-virtual {v5, v6, v7}, Ljxl/write/biff/WritableSheetImpl;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v5

    check-cast v5, Ljxl/write/biff/CellValue;

    invoke-virtual {v5}, Ljxl/write/biff/CellValue;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object v6

    if-eqz v6, :cond_9

    move v6, v0

    goto :goto_a

    :cond_9
    move v6, v1

    :goto_a
    invoke-static {v6}, Ljxl/common/Assert;->verify(Z)V

    invoke-virtual {v5}, Ljxl/write/biff/CellValue;->getWritableCellFeatures()Ljxl/write/WritableCellFeatures;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljxl/biff/BaseCellFeatures;->setCommentDrawing(Ljxl/biff/drawing/Comment;)V

    goto :goto_c

    :cond_a
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/Button;

    if-eqz v4, :cond_b

    new-instance v4, Ljxl/biff/drawing/Button;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/Button;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    :goto_b
    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    goto :goto_9

    :cond_b
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/ComboBox;

    if-eqz v4, :cond_c

    new-instance v4, Ljxl/biff/drawing/ComboBox;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/ComboBox;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    goto :goto_b

    :cond_c
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/CheckBox;

    if-eqz v4, :cond_d

    new-instance v4, Ljxl/biff/drawing/CheckBox;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/CheckBox;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    goto :goto_b

    :cond_d
    :goto_c
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_8

    :cond_e
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getDataValidation()Ljxl/biff/DataValidation;

    move-result-object v2

    if-eqz v2, :cond_f

    new-instance v3, Ljxl/biff/DataValidation;

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v4

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v5}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v5

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v3, v2, v4, v5, v6}, Ljxl/biff/DataValidation;-><init>(Ljxl/biff/DataValidation;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iput-object v3, p0, Ljxl/write/biff/SheetCopier;->dataValidation:Ljxl/biff/DataValidation;

    invoke-virtual {v3}, Ljxl/biff/DataValidation;->getComboBoxObjectId()I

    move-result v2

    if-eqz v2, :cond_f

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/biff/drawing/ComboBox;

    iput-object v2, p0, Ljxl/write/biff/SheetCopier;->comboBox:Ljxl/biff/drawing/ComboBox;

    :cond_f
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getConditionalFormats()[Ljxl/biff/ConditionalFormat;

    move-result-object v2

    array-length v3, v2

    if-lez v3, :cond_10

    :goto_d
    array-length v3, v2

    if-ge v1, v3, :cond_10

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->conditionalFormats:Ljava/util/ArrayList;

    aget-object v4, v2, v1

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_d

    :cond_10
    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getAutoFilter()Ljxl/biff/AutoFilter;

    move-result-object v1

    iput-object v1, p0, Ljxl/write/biff/SheetCopier;->autoFilter:Ljxl/biff/AutoFilter;

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getWorkspaceOptions()Ljxl/biff/WorkspaceInformationRecord;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljxl/write/biff/SheetWriter;->setWorkspaceOptions(Ljxl/biff/WorkspaceInformationRecord;)V

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getSheetBof()Ljxl/read/biff/BOFRecord;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isChart()Z

    move-result v1

    if-eqz v1, :cond_11

    iput-boolean v0, p0, Ljxl/write/biff/SheetCopier;->chartOnly:Z

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    invoke-virtual {v0}, Ljxl/write/biff/SheetWriter;->setChartOnly()V

    :cond_11
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getPLS()Ljxl/read/biff/PLSRecord;

    move-result-object v0

    if-eqz v0, :cond_13

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getWorkbookBof()Ljxl/read/biff/BOFRecord;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/BOFRecord;->isBiff7()Z

    move-result v0

    if-eqz v0, :cond_12

    sget-object v0, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

    const-string v1, "Cannot copy Biff7 print settings record - ignoring"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_e

    :cond_12
    new-instance v0, Ljxl/write/biff/PLSRecord;

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getPLS()Ljxl/read/biff/PLSRecord;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/write/biff/PLSRecord;-><init>(Ljxl/read/biff/PLSRecord;)V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->plsRecord:Ljxl/write/biff/PLSRecord;

    :cond_13
    :goto_e
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;

    move-result-object v0

    if-eqz v0, :cond_14

    new-instance v0, Ljxl/write/biff/ButtonPropertySetRecord;

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/write/biff/ButtonPropertySetRecord;-><init>(Ljxl/read/biff/ButtonPropertySetRecord;)V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    :cond_14
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getMaxRowOutlineLevel()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SheetCopier;->maxRowOutlineLevel:I

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getMaxColumnOutlineLevel()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SheetCopier;->maxColumnOutlineLevel:I

    return-void
.end method

.method public copyWritableSheet()V
    .locals 0

    invoke-virtual {p0}, Ljxl/write/biff/SheetCopier;->shallowCopyCells()V

    return-void
.end method

.method deepCopyCells()V
    .locals 7

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getRows()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v3, v2}, Ljxl/read/biff/SheetImpl;->getRow(I)[Ljxl/Cell;

    move-result-object v3

    move v4, v1

    :goto_1
    array-length v5, v3

    if-ge v4, v5, :cond_1

    aget-object v5, v3, v4

    invoke-direct {p0, v5}, Ljxl/write/biff/SheetCopier;->deepCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;

    move-result-object v5

    if-eqz v5, :cond_0

    :try_start_0
    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

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

.method getAutoFilter()Ljxl/biff/AutoFilter;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->autoFilter:Ljxl/biff/AutoFilter;

    return-object v0
.end method

.method getButtonPropertySet()Ljxl/write/biff/ButtonPropertySetRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    return-object v0
.end method

.method getComboBox()Ljxl/biff/drawing/ComboBox;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->comboBox:Ljxl/biff/drawing/ComboBox;

    return-object v0
.end method

.method getDataValidation()Ljxl/biff/DataValidation;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->dataValidation:Ljxl/biff/DataValidation;

    return-object v0
.end method

.method public getMaxColumnOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/SheetCopier;->maxColumnOutlineLevel:I

    return v0
.end method

.method public getMaxRowOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/SheetCopier;->maxRowOutlineLevel:I

    return v0
.end method

.method getPLSRecord()Ljxl/write/biff/PLSRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->plsRecord:Ljxl/write/biff/PLSRecord;

    return-object v0
.end method

.method getRows()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/SheetCopier;->numRows:I

    return v0
.end method

.method public importSheet()V
    .locals 15

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->fonts:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->formats:Ljava/util/HashMap;

    invoke-virtual {p0}, Ljxl/write/biff/SheetCopier;->deepCopyCells()V

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getColumnInfos()[Ljxl/read/biff/ColumnInfoRecord;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_2

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljxl/read/biff/ColumnInfoRecord;->getStartColumn()I

    move-result v4

    :goto_1
    invoke-virtual {v3}, Ljxl/read/biff/ColumnInfoRecord;->getEndColumn()I

    move-result v5

    if-gt v4, v5, :cond_1

    new-instance v5, Ljxl/write/biff/ColumnInfoRecord;

    invoke-direct {v5, v3, v4}, Ljxl/write/biff/ColumnInfoRecord;-><init>(Ljxl/read/biff/ColumnInfoRecord;I)V

    invoke-virtual {v5}, Ljxl/write/biff/ColumnInfoRecord;->getXfIndex()I

    move-result v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v8, Ljava/lang/Integer;

    invoke-direct {v8, v6}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v7, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/write/WritableCellFormat;

    if-nez v6, :cond_0

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v7, v4}, Ljxl/read/biff/SheetImpl;->getColumnView(I)Ljxl/CellView;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v7

    invoke-direct {p0, v7}, Ljxl/write/biff/SheetCopier;->copyCellFormat(Ljxl/format/CellFormat;)Ljxl/write/WritableCellFormat;

    :cond_0
    invoke-virtual {v5, v6}, Ljxl/write/biff/ColumnInfoRecord;->setCellFormat(Ljxl/biff/XFRecord;)V

    invoke-virtual {v3}, Ljxl/read/biff/ColumnInfoRecord;->getHidden()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljxl/write/biff/ColumnInfoRecord;->setHidden(Z)V

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->columnFormats:Ljava/util/TreeSet;

    invoke-virtual {v6, v5}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getHyperlinks()[Ljxl/Hyperlink;

    move-result-object v0

    move v2, v1

    :goto_2
    array-length v3, v0

    if-ge v2, v3, :cond_3

    new-instance v3, Ljxl/write/WritableHyperlink;

    aget-object v4, v0, v2

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-direct {v3, v4, v5}, Ljxl/write/WritableHyperlink;-><init>(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->hyperlinks:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_3
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getMergedCells()[Ljxl/Range;

    move-result-object v0

    move v2, v1

    :goto_3
    array-length v3, v0

    if-ge v2, v3, :cond_4

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->mergedCells:Ljxl/write/biff/MergedCells;

    new-instance v4, Ljxl/biff/SheetRangeImpl;

    aget-object v5, v0, v2

    check-cast v5, Ljxl/biff/SheetRangeImpl;

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-direct {v4, v5, v6}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/biff/SheetRangeImpl;Ljxl/Sheet;)V

    invoke-virtual {v3, v4}, Ljxl/write/biff/MergedCells;->add(Ljxl/Range;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    :cond_4
    const/4 v0, 0x1

    :try_start_0
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getRowProperties()[Ljxl/read/biff/RowRecord;

    move-result-object v2

    move v3, v1

    :goto_4
    array-length v4, v2

    if-ge v3, v4, :cond_6

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    aget-object v5, v2, v3

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getRowNumber()I

    move-result v5

    invoke-virtual {v4, v5}, Ljxl/write/biff/WritableSheetImpl;->getRowRecord(I)Ljxl/write/biff/RowRecord;

    move-result-object v6

    const/4 v4, 0x0

    aget-object v5, v2, v3

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->hasDefaultFormat()Z

    move-result v7

    if-eqz v7, :cond_5

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->xfRecords:Ljava/util/HashMap;

    new-instance v7, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getXFIndex()I

    move-result v8

    invoke-direct {v7, v8}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v4, v7}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljxl/write/WritableCellFormat;

    if-nez v4, :cond_5

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getRowNumber()I

    move-result v7

    iget-object v8, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v8, v7}, Ljxl/read/biff/SheetImpl;->getRowView(I)Ljxl/CellView;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/CellView;->getFormat()Ljxl/format/CellFormat;

    move-result-object v7

    invoke-direct {p0, v7}, Ljxl/write/biff/SheetCopier;->copyCellFormat(Ljxl/format/CellFormat;)Ljxl/write/WritableCellFormat;

    :cond_5
    move-object v12, v4

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getRowHeight()I

    move-result v7

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->matchesDefaultFontHeight()Z

    move-result v8

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->isCollapsed()Z

    move-result v9

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getOutlineLevel()I

    move-result v10

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getGroupStart()Z

    move-result v11

    invoke-virtual/range {v6 .. v12}, Ljxl/write/biff/RowRecord;->setRowDetails(IZZIZLjxl/biff/XFRecord;)V

    iget v4, p0, Ljxl/write/biff/SheetCopier;->numRows:I

    aget-object v5, v2, v3

    invoke-virtual {v5}, Ljxl/read/biff/RowRecord;->getRowNumber()I

    move-result v5

    add-int/2addr v5, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    iput v4, p0, Ljxl/write/biff/SheetCopier;->numRows:I
    :try_end_0
    .catch Ljxl/write/biff/RowsExceededException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    :catch_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    :cond_6
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getRowPageBreaks()[I

    move-result-object v2

    if-eqz v2, :cond_7

    move v3, v1

    :goto_5
    array-length v4, v2

    if-ge v3, v4, :cond_7

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->rowBreaks:Ljava/util/ArrayList;

    new-instance v5, Ljava/lang/Integer;

    aget v6, v2, v3

    invoke-direct {v5, v6}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    :cond_7
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getColumnPageBreaks()[I

    move-result-object v2

    if-eqz v2, :cond_8

    move v3, v1

    :goto_6
    array-length v4, v2

    if-ge v3, v4, :cond_8

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->columnBreaks:Ljava/util/ArrayList;

    new-instance v5, Ljava/lang/Integer;

    aget v6, v2, v3

    invoke-direct {v5, v6}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_6

    :cond_8
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getCharts()[Ljxl/biff/drawing/Chart;

    move-result-object v2

    if-eqz v2, :cond_9

    array-length v2, v2

    if-lez v2, :cond_9

    sget-object v2, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

    const-string v3, "Importing of charts is not supported"

    invoke-virtual {v2, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_9
    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getDrawings()[Ljxl/biff/drawing/DrawingGroupObject;

    move-result-object v2

    array-length v3, v2

    if-lez v3, :cond_a

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v3

    if-nez v3, :cond_a

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/write/biff/WritableWorkbookImpl;->createDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    :cond_a
    move v3, v1

    :goto_7
    array-length v4, v2

    if-ge v3, v4, :cond_10

    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/Drawing;

    if-eqz v4, :cond_b

    new-instance v4, Ljxl/write/WritableImage;

    aget-object v5, v2, v3

    invoke-interface {v5}, Ljxl/biff/drawing/DrawingGroupObject;->getX()D

    move-result-wide v6

    aget-object v5, v2, v3

    invoke-interface {v5}, Ljxl/biff/drawing/DrawingGroupObject;->getY()D

    move-result-wide v8

    aget-object v5, v2, v3

    invoke-interface {v5}, Ljxl/biff/drawing/DrawingGroupObject;->getWidth()D

    move-result-wide v10

    aget-object v5, v2, v3

    invoke-interface {v5}, Ljxl/biff/drawing/DrawingGroupObject;->getHeight()D

    move-result-wide v12

    aget-object v5, v2, v3

    invoke-interface {v5}, Ljxl/biff/drawing/DrawingGroupObject;->getImageData()[B

    move-result-object v14

    move-object v5, v4

    invoke-direct/range {v5 .. v14}, Ljxl/write/WritableImage;-><init>(DDDD[B)V

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v5}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljxl/write/biff/WritableWorkbookImpl;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->images:Ljava/util/ArrayList;

    :goto_8
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_b

    :cond_b
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/Comment;

    if-eqz v4, :cond_d

    new-instance v4, Ljxl/biff/drawing/Comment;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/Comment;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4}, Ljxl/biff/drawing/Comment;->getColumn()I

    move-result v6

    invoke-virtual {v4}, Ljxl/biff/drawing/Comment;->getRow()I

    move-result v7

    invoke-virtual {v5, v6, v7}, Ljxl/write/biff/WritableSheetImpl;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v5

    check-cast v5, Ljxl/write/biff/CellValue;

    invoke-virtual {v5}, Ljxl/write/biff/CellValue;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object v6

    if-eqz v6, :cond_c

    move v6, v0

    goto :goto_9

    :cond_c
    move v6, v1

    :goto_9
    invoke-static {v6}, Ljxl/common/Assert;->verify(Z)V

    invoke-virtual {v5}, Ljxl/write/biff/CellValue;->getWritableCellFeatures()Ljxl/write/WritableCellFeatures;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljxl/biff/BaseCellFeatures;->setCommentDrawing(Ljxl/biff/drawing/Comment;)V

    goto :goto_b

    :cond_d
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/Button;

    if-eqz v4, :cond_e

    new-instance v4, Ljxl/biff/drawing/Button;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/Button;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    :goto_a
    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    goto :goto_8

    :cond_e
    aget-object v4, v2, v3

    instance-of v4, v4, Ljxl/biff/drawing/ComboBox;

    if-eqz v4, :cond_f

    new-instance v4, Ljxl/biff/drawing/ComboBox;

    aget-object v5, v2, v3

    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v6}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v6

    invoke-virtual {v6}, Ljxl/write/biff/WritableWorkbookImpl;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v6

    iget-object v7, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v4, v5, v6, v7}, Ljxl/biff/drawing/ComboBox;-><init>(Ljxl/biff/drawing/DrawingGroupObject;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    goto :goto_a

    :cond_f
    :goto_b
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_7

    :cond_10
    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getDataValidation()Ljxl/biff/DataValidation;

    move-result-object v1

    if-eqz v1, :cond_11

    new-instance v2, Ljxl/biff/DataValidation;

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    iget-object v4, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v4

    iget-object v5, p0, Ljxl/write/biff/SheetCopier;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v2, v1, v3, v4, v5}, Ljxl/biff/DataValidation;-><init>(Ljxl/biff/DataValidation;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iput-object v2, p0, Ljxl/write/biff/SheetCopier;->dataValidation:Ljxl/biff/DataValidation;

    invoke-virtual {v2}, Ljxl/biff/DataValidation;->getComboBoxObjectId()I

    move-result v1

    if-eqz v1, :cond_11

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/drawing/ComboBox;

    iput-object v1, p0, Ljxl/write/biff/SheetCopier;->comboBox:Ljxl/biff/drawing/ComboBox;

    :cond_11
    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    iget-object v2, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getWorkspaceOptions()Ljxl/biff/WorkspaceInformationRecord;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljxl/write/biff/SheetWriter;->setWorkspaceOptions(Ljxl/biff/WorkspaceInformationRecord;)V

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getSheetBof()Ljxl/read/biff/BOFRecord;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isChart()Z

    move-result v1

    if-eqz v1, :cond_12

    iput-boolean v0, p0, Ljxl/write/biff/SheetCopier;->chartOnly:Z

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    invoke-virtual {v0}, Ljxl/write/biff/SheetWriter;->setChartOnly()V

    :cond_12
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getPLS()Ljxl/read/biff/PLSRecord;

    move-result-object v0

    if-eqz v0, :cond_14

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getWorkbookBof()Ljxl/read/biff/BOFRecord;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/BOFRecord;->isBiff7()Z

    move-result v0

    if-eqz v0, :cond_13

    sget-object v0, Ljxl/write/biff/SheetCopier;->logger:Ljxl/common/Logger;

    const-string v1, "Cannot copy Biff7 print settings record - ignoring"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_c

    :cond_13
    new-instance v0, Ljxl/write/biff/PLSRecord;

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getPLS()Ljxl/read/biff/PLSRecord;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/write/biff/PLSRecord;-><init>(Ljxl/read/biff/PLSRecord;)V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->plsRecord:Ljxl/write/biff/PLSRecord;

    :cond_14
    :goto_c
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;

    move-result-object v0

    if-eqz v0, :cond_15

    new-instance v0, Ljxl/write/biff/ButtonPropertySetRecord;

    iget-object v1, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v1}, Ljxl/read/biff/SheetImpl;->getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/write/biff/ButtonPropertySetRecord;-><init>(Ljxl/read/biff/ButtonPropertySetRecord;)V

    iput-object v0, p0, Ljxl/write/biff/SheetCopier;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    :cond_15
    invoke-direct {p0}, Ljxl/write/biff/SheetCopier;->importNames()V

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getMaxRowOutlineLevel()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SheetCopier;->maxRowOutlineLevel:I

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getMaxColumnOutlineLevel()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SheetCopier;->maxColumnOutlineLevel:I

    return-void
.end method

.method isChartOnly()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/write/biff/SheetCopier;->chartOnly:Z

    return v0
.end method

.method setColumnBreaks(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->columnBreaks:Ljava/util/ArrayList;

    return-void
.end method

.method setColumnFormats(Ljava/util/TreeSet;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->columnFormats:Ljava/util/TreeSet;

    return-void
.end method

.method setConditionalFormats(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->conditionalFormats:Ljava/util/ArrayList;

    return-void
.end method

.method setDrawings(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->drawings:Ljava/util/ArrayList;

    return-void
.end method

.method setFormatRecords(Ljxl/biff/FormattingRecords;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->formatRecords:Ljxl/biff/FormattingRecords;

    return-void
.end method

.method setHyperlinks(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->hyperlinks:Ljava/util/ArrayList;

    return-void
.end method

.method setImages(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->images:Ljava/util/ArrayList;

    return-void
.end method

.method setMergedCells(Ljxl/write/biff/MergedCells;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->mergedCells:Ljxl/write/biff/MergedCells;

    return-void
.end method

.method setRowBreaks(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->rowBreaks:Ljava/util/ArrayList;

    return-void
.end method

.method setSheetWriter(Ljxl/write/biff/SheetWriter;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetCopier;->sheetWriter:Ljxl/write/biff/SheetWriter;

    return-void
.end method

.method shallowCopyCells()V
    .locals 7

    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v0}, Ljxl/read/biff/SheetImpl;->getRows()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Ljxl/write/biff/SheetCopier;->fromSheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v3, v2}, Ljxl/read/biff/SheetImpl;->getRow(I)[Ljxl/Cell;

    move-result-object v3

    move v4, v1

    :goto_1
    array-length v5, v3

    if-ge v4, v5, :cond_1

    aget-object v5, v3, v4

    invoke-direct {p0, v5}, Ljxl/write/biff/SheetCopier;->shallowCopyCell(Ljxl/Cell;)Ljxl/write/WritableCell;

    move-result-object v5

    if-eqz v5, :cond_0

    :try_start_0
    iget-object v6, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

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
    iget-object v0, p0, Ljxl/write/biff/SheetCopier;->toSheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getRows()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/SheetCopier;->numRows:I

    return-void
.end method
