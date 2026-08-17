.class final Ljxl/read/biff/SheetReader;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$read$biff$SheetReader:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private autoFilter:Ljxl/biff/AutoFilter;

.field private buttonPropertySet:Ljxl/read/biff/ButtonPropertySetRecord;

.field private cells:[[Ljxl/Cell;

.field private charts:Ljava/util/ArrayList;

.field private columnBreaks:[I

.field private columnInfosArray:Ljava/util/ArrayList;

.field private conditionalFormats:Ljava/util/ArrayList;

.field private dataValidation:Ljxl/biff/DataValidation;

.field private drawingData:Ljxl/biff/drawing/DrawingData;

.field private drawings:Ljava/util/ArrayList;

.field private excelFile:Ljxl/read/biff/File;

.field private formattingRecords:Ljxl/biff/FormattingRecords;

.field private hyperlinks:Ljava/util/ArrayList;

.field private maxColumnOutlineLevel:I

.field private maxRowOutlineLevel:I

.field private mergedCells:[Ljxl/Range;

.field private nineteenFour:Z

.field private numCols:I

.field private numRows:I

.field private outOfBoundsCells:Ljava/util/ArrayList;

.field private plsRecord:Ljxl/read/biff/PLSRecord;

.field private rowBreaks:[I

.field private rowProperties:Ljava/util/ArrayList;

.field private settings:Ljxl/SheetSettings;

.field private sharedFormulas:Ljava/util/ArrayList;

.field private sharedStrings:Ljxl/read/biff/SSTRecord;

.field private sheet:Ljxl/read/biff/SheetImpl;

.field private sheetBof:Ljxl/read/biff/BOFRecord;

.field private startPosition:I

.field private workbook:Ljxl/read/biff/WorkbookParser;

.field private workbookBof:Ljxl/read/biff/BOFRecord;

.field private workbookSettings:Ljxl/WorkbookSettings;

.field private workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/read/biff/SheetReader;->class$jxl$read$biff$SheetReader:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.read.biff.SheetReader"

    invoke-static {v0}, Ljxl/read/biff/SheetReader;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/SheetReader;->class$jxl$read$biff$SheetReader:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    return-void
.end method

.method constructor <init>(Ljxl/read/biff/File;Ljxl/read/biff/SSTRecord;Ljxl/biff/FormattingRecords;Ljxl/read/biff/BOFRecord;Ljxl/read/biff/BOFRecord;ZLjxl/read/biff/WorkbookParser;ILjxl/read/biff/SheetImpl;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    iput-object p2, p0, Ljxl/read/biff/SheetReader;->sharedStrings:Ljxl/read/biff/SSTRecord;

    iput-object p3, p0, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iput-object p4, p0, Ljxl/read/biff/SheetReader;->sheetBof:Ljxl/read/biff/BOFRecord;

    iput-object p5, p0, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->columnInfosArray:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->sharedFormulas:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->hyperlinks:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->conditionalFormats:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    const/16 p2, 0xa

    invoke-direct {p1, p2}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->rowProperties:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->charts:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->outOfBoundsCells:Ljava/util/ArrayList;

    iput-boolean p6, p0, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    iput-object p7, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    iput p8, p0, Ljxl/read/biff/SheetReader;->startPosition:I

    iput-object p9, p0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    new-instance p1, Ljxl/SheetSettings;

    invoke-direct {p1, p9}, Ljxl/SheetSettings;-><init>(Ljxl/Sheet;)V

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {p1}, Ljxl/read/biff/WorkbookParser;->getSettings()Ljxl/WorkbookSettings;

    move-result-object p1

    iput-object p1, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    return-void
.end method

.method private addCell(Ljxl/Cell;)V
    .locals 4

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v0

    iget v1, p0, Ljxl/read/biff/SheetReader;->numRows:I

    if-ge v0, v1, :cond_1

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v0

    iget v1, p0, Ljxl/read/biff/SheetReader;->numCols:I

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v1

    aget-object v0, v0, v1

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v1

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v1

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v2

    invoke-static {v1, v2, v0}, Ljxl/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    sget-object v1, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Cell "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v0, " already contains data"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v1

    aget-object v0, v0, v1

    invoke-interface {p1}, Ljxl/Cell;->getColumn()I

    move-result v1

    aput-object p1, v0, v1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ljxl/read/biff/SheetReader;->outOfBoundsCells:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_0
    return-void
.end method

.method private addCellComment(IILjava/lang/String;DD)V
    .locals 14

    move-object v0, p0

    iget-object v1, v0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    aget-object v1, v1, p2

    aget-object v1, v1, p1

    if-nez v1, :cond_0

    sget-object v1, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Cell at "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static/range {p1 .. p2}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v3, " not present - adding a blank"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    new-instance v1, Ljxl/read/biff/MulBlankCell;

    const/4 v5, 0x0

    iget-object v6, v0, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v7, v0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object v2, v1

    move/from16 v3, p2

    move v4, p1

    invoke-direct/range {v2 .. v7}, Ljxl/read/biff/MulBlankCell;-><init>(IIILjxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    new-instance v2, Ljxl/CellFeatures;

    invoke-direct {v2}, Ljxl/CellFeatures;-><init>()V

    move-object v8, v2

    move-object/from16 v9, p3

    move-wide/from16 v10, p4

    move-wide/from16 v12, p6

    invoke-virtual/range {v8 .. v13}, Ljxl/biff/BaseCellFeatures;->setReadComment(Ljava/lang/String;DD)V

    invoke-virtual {v1, v2}, Ljxl/read/biff/MulBlankCell;->setCellFeatures(Ljxl/CellFeatures;)V

    invoke-direct {p0, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    return-void

    :cond_0
    instance-of v2, v1, Ljxl/read/biff/CellFeaturesAccessor;

    if-eqz v2, :cond_2

    check-cast v1, Ljxl/read/biff/CellFeaturesAccessor;

    invoke-interface {v1}, Ljxl/read/biff/CellFeaturesAccessor;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object v2

    if-nez v2, :cond_1

    new-instance v2, Ljxl/CellFeatures;

    invoke-direct {v2}, Ljxl/CellFeatures;-><init>()V

    invoke-interface {v1, v2}, Ljxl/read/biff/CellFeaturesAccessor;->setCellFeatures(Ljxl/CellFeatures;)V

    :cond_1
    move-object v3, v2

    move-object/from16 v4, p3

    move-wide/from16 v5, p4

    move-wide/from16 v7, p6

    invoke-virtual/range {v3 .. v8}, Ljxl/biff/BaseCellFeatures;->setReadComment(Ljava/lang/String;DD)V

    goto :goto_0

    :cond_2
    sget-object v2, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Not able to add comment to cell type "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " at "

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static/range {p1 .. p2}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method private addCellValidation(IIIILjxl/biff/DataValiditySettingsRecord;)V
    .locals 6

    move v1, p2

    :goto_0
    if-gt v1, p4, :cond_5

    move v2, p1

    :goto_1
    if-gt v2, p3, :cond_4

    const/4 p2, 0x0

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    array-length v3, v0

    if-le v3, v1, :cond_0

    aget-object v3, v0, v1

    array-length v3, v3

    if-le v3, v2, :cond_0

    aget-object p2, v0, v1

    aget-object p2, p2, v2

    :cond_0
    if-nez p2, :cond_1

    sget-object p1, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance p2, Ljava/lang/StringBuffer;

    invoke-direct {p2}, Ljava/lang/StringBuffer;-><init>()V

    const-string p3, "Cell at "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static {v2, v1}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p3, " not present - adding a blank"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    new-instance p1, Ljxl/read/biff/MulBlankCell;

    const/4 v3, 0x0

    iget-object v4, p0, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v5, p0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object v0, p1

    invoke-direct/range {v0 .. v5}, Ljxl/read/biff/MulBlankCell;-><init>(IIILjxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    new-instance p2, Ljxl/CellFeatures;

    invoke-direct {p2}, Ljxl/CellFeatures;-><init>()V

    invoke-virtual {p2, p5}, Ljxl/biff/BaseCellFeatures;->setValidationSettings(Ljxl/biff/DataValiditySettingsRecord;)V

    invoke-virtual {p1, p2}, Ljxl/read/biff/MulBlankCell;->setCellFeatures(Ljxl/CellFeatures;)V

    invoke-direct {p0, p1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    return-void

    :cond_1
    instance-of v0, p2, Ljxl/read/biff/CellFeaturesAccessor;

    if-eqz v0, :cond_3

    check-cast p2, Ljxl/read/biff/CellFeaturesAccessor;

    invoke-interface {p2}, Ljxl/read/biff/CellFeaturesAccessor;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object v0

    if-nez v0, :cond_2

    new-instance v0, Ljxl/CellFeatures;

    invoke-direct {v0}, Ljxl/CellFeatures;-><init>()V

    invoke-interface {p2, v0}, Ljxl/read/biff/CellFeaturesAccessor;->setCellFeatures(Ljxl/CellFeatures;)V

    :cond_2
    invoke-virtual {v0, p5}, Ljxl/biff/BaseCellFeatures;->setValidationSettings(Ljxl/biff/DataValiditySettingsRecord;)V

    goto :goto_2

    :cond_3
    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Not able to add comment to cell type "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v3, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p2, " at "

    invoke-virtual {v3, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static {v2, v1}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v3, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_1

    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_5
    return-void
.end method

.method private addToSharedFormulas(Ljxl/read/biff/BaseSharedFormulaRecord;)Z
    .locals 3

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->sharedFormulas:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v1, v0, :cond_0

    if-nez v2, :cond_0

    iget-object v2, p0, Ljxl/read/biff/SheetReader;->sharedFormulas:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/read/biff/SharedFormulaRecord;

    invoke-virtual {v2, p1}, Ljxl/read/biff/SharedFormulaRecord;->add(Ljxl/read/biff/BaseSharedFormulaRecord;)Z

    move-result v2

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return v2
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

.method private handleObjectRecord(Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/MsoDrawingRecord;Ljava/util/HashMap;)V
    .locals 10

    if-nez p2, :cond_0

    sget-object p1, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string p2, "Object record is not associated with a drawing  record - ignoring"

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return-void

    :cond_0
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object v1

    sget-object v2, Ljxl/biff/drawing/ObjRecord;->PICTURE:Ljxl/biff/drawing/ObjRecord$ObjType;

    if-ne v1, v2, :cond_2

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez p3, :cond_1

    new-instance p3, Ljxl/biff/drawing/DrawingData;

    invoke-direct {p3}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_1
    new-instance p3, Ljxl/biff/drawing/Drawing;

    iget-object v4, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v1, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v5

    iget-object v6, p0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object v1, p3

    move-object v2, p2

    move-object v3, p1

    invoke-direct/range {v1 .. v6}, Ljxl/biff/drawing/Drawing;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/Sheet;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void

    :cond_2
    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object v1

    sget-object v2, Ljxl/biff/drawing/ObjRecord;->EXCELNOTE:Ljxl/biff/drawing/ObjRecord$ObjType;

    const/4 v3, 0x0

    if-ne v1, v2, :cond_9

    iget-object v1, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez v1, :cond_3

    new-instance v1, Ljxl/biff/drawing/DrawingData;

    invoke-direct {v1}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object v1, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_3
    new-instance v1, Ljxl/biff/drawing/Comment;

    iget-object v7, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v2, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v2}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v8

    iget-object v9, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object v4, v1

    move-object v5, p2

    move-object v6, p1

    invoke-direct/range {v4 .. v9}, Ljxl/biff/drawing/Comment;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v2, Ljxl/biff/Type;->MSODRAWING:Ljxl/biff/Type;

    if-eq p2, v2, :cond_4

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v2, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne p2, v2, :cond_5

    :cond_4
    new-instance p2, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {p2, p1}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1, p2}, Ljxl/biff/drawing/Comment;->addMso(Ljxl/biff/drawing/MsoDrawingRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    :cond_5
    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v2, Ljxl/biff/Type;->TXO:Ljxl/biff/Type;

    if-ne p2, v2, :cond_6

    move p2, v0

    goto :goto_0

    :cond_6
    move p2, v3

    :goto_0
    invoke-static {p2}, Ljxl/common/Assert;->verify(Z)V

    new-instance p2, Ljxl/biff/drawing/TextObjectRecord;

    invoke-direct {p2, p1}, Ljxl/biff/drawing/TextObjectRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1, p2}, Ljxl/biff/drawing/Comment;->setTextObject(Ljxl/biff/drawing/TextObjectRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v2, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne p2, v2, :cond_7

    move v3, v0

    :cond_7
    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    new-instance p2, Ljxl/biff/ContinueRecord;

    invoke-direct {p2, p1}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1, p2}, Ljxl/biff/drawing/Comment;->setText(Ljxl/biff/ContinueRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    if-ne p2, v2, :cond_8

    new-instance p2, Ljxl/biff/ContinueRecord;

    invoke-direct {p2, p1}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1, p2}, Ljxl/biff/drawing/Comment;->setFormatting(Ljxl/biff/ContinueRecord;)V

    :cond_8
    new-instance p1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljxl/biff/drawing/Comment;->getObjectId()I

    move-result p2

    invoke-direct {p1, p2}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {p3, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_9
    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object p3

    sget-object v1, Ljxl/biff/drawing/ObjRecord;->COMBOBOX:Ljxl/biff/drawing/ObjRecord$ObjType;

    if-ne p3, v1, :cond_b

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez p3, :cond_a

    new-instance p3, Ljxl/biff/drawing/DrawingData;

    invoke-direct {p3}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_a
    new-instance p3, Ljxl/biff/drawing/ComboBox;

    iget-object v4, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v1, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v5

    iget-object v6, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object v1, p3

    move-object v2, p2

    move-object v3, p1

    invoke-direct/range {v1 .. v6}, Ljxl/biff/drawing/ComboBox;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void

    :cond_b
    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object p3

    sget-object v1, Ljxl/biff/drawing/ObjRecord;->CHECKBOX:Ljxl/biff/drawing/ObjRecord$ObjType;

    if-ne p3, v1, :cond_15

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez p3, :cond_c

    new-instance p3, Ljxl/biff/drawing/DrawingData;

    invoke-direct {p3}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_c
    new-instance p3, Ljxl/biff/drawing/CheckBox;

    iget-object v7, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v1, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v8

    iget-object v9, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object v4, p3

    move-object v5, p2

    move-object v6, p1

    invoke-direct/range {v4 .. v9}, Ljxl/biff/drawing/CheckBox;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->MSODRAWING:Ljxl/biff/Type;

    if-eq p2, v1, :cond_e

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v2, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne p2, v2, :cond_d

    goto :goto_1

    :cond_d
    move p2, v3

    goto :goto_2

    :cond_e
    :goto_1
    move p2, v0

    :goto_2
    invoke-static {p2}, Ljxl/common/Assert;->verify(Z)V

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    if-eq p2, v1, :cond_f

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne p2, v1, :cond_10

    :cond_f
    new-instance p2, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {p2, p1}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/CheckBox;->addMso(Ljxl/biff/drawing/MsoDrawingRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    :cond_10
    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->TXO:Ljxl/biff/Type;

    if-ne p2, v1, :cond_11

    move p2, v0

    goto :goto_3

    :cond_11
    move p2, v3

    :goto_3
    invoke-static {p2}, Ljxl/common/Assert;->verify(Z)V

    new-instance p2, Ljxl/biff/drawing/TextObjectRecord;

    invoke-direct {p2, p1}, Ljxl/biff/drawing/TextObjectRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/CheckBox;->setTextObject(Ljxl/biff/drawing/TextObjectRecord;)V

    invoke-virtual {p2}, Ljxl/biff/drawing/TextObjectRecord;->getTextLength()I

    move-result p1

    if-nez p1, :cond_12

    return-void

    :cond_12
    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne p2, v1, :cond_13

    move v3, v0

    :cond_13
    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    new-instance p2, Ljxl/biff/ContinueRecord;

    invoke-direct {p2, p1}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/CheckBox;->setText(Ljxl/biff/ContinueRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    if-ne p2, v1, :cond_14

    new-instance p2, Ljxl/biff/ContinueRecord;

    invoke-direct {p2, p1}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/CheckBox;->setFormatting(Ljxl/biff/ContinueRecord;)V

    :cond_14
    iget-object p1, p0, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void

    :cond_15
    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object p3

    sget-object v1, Ljxl/biff/drawing/ObjRecord;->BUTTON:Ljxl/biff/drawing/ObjRecord$ObjType;

    if-ne p3, v1, :cond_1b

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez p3, :cond_16

    new-instance p3, Ljxl/biff/drawing/DrawingData;

    invoke-direct {p3}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_16
    new-instance p3, Ljxl/biff/drawing/Button;

    iget-object v7, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v1, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v8

    iget-object v9, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object v4, p3

    move-object v5, p2

    move-object v6, p1

    invoke-direct/range {v4 .. v9}, Ljxl/biff/drawing/Button;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;Ljxl/WorkbookSettings;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->MSODRAWING:Ljxl/biff/Type;

    if-ne p2, v1, :cond_17

    new-instance p2, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {p2, p1}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/Button;->addMso(Ljxl/biff/drawing/MsoDrawingRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    :cond_17
    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->TXO:Ljxl/biff/Type;

    if-ne p2, v1, :cond_18

    move p2, v0

    goto :goto_4

    :cond_18
    move p2, v3

    :goto_4
    invoke-static {p2}, Ljxl/common/Assert;->verify(Z)V

    new-instance p2, Ljxl/biff/drawing/TextObjectRecord;

    invoke-direct {p2, p1}, Ljxl/biff/drawing/TextObjectRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/Button;->setTextObject(Ljxl/biff/drawing/TextObjectRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    sget-object v1, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne p2, v1, :cond_19

    move v3, v0

    :cond_19
    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    new-instance p2, Ljxl/biff/ContinueRecord;

    invoke-direct {p2, p1}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/Button;->setText(Ljxl/biff/ContinueRecord;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object p2

    if-ne p2, v1, :cond_1a

    new-instance p2, Ljxl/biff/ContinueRecord;

    invoke-direct {p2, p1}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p3, p2}, Ljxl/biff/drawing/Button;->setFormatting(Ljxl/biff/ContinueRecord;)V

    :cond_1a
    iget-object p1, p0, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void

    :cond_1b
    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object p3

    sget-object v1, Ljxl/biff/drawing/ObjRecord;->CHART:Ljxl/biff/drawing/ObjRecord$ObjType;

    if-eq p3, v1, :cond_1e

    sget-object p3, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {p1}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    const-string v2, " on sheet \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v2, p0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-virtual {v2}, Ljxl/read/biff/SheetImpl;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v2, "\" not supported - omitting"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez p3, :cond_1c

    new-instance p3, Ljxl/biff/drawing/DrawingData;

    invoke-direct {p3}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_1c
    iget-object p3, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {p2}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object v1

    invoke-virtual {p3, v1}, Ljxl/biff/drawing/DrawingData;->addData([B)V

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {p3}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object p3

    if-eqz p3, :cond_1d

    iget-object p3, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {p3}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object p3

    invoke-virtual {p3, p2, p1}, Ljxl/biff/drawing/DrawingGroup;->setDrawingsOmitted(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;)V
    :try_end_0
    .catch Ljxl/biff/drawing/DrawingDataException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1d
    return-void

    :catch_0
    move-exception p1

    sget-object p2, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance p3, Ljava/lang/StringBuffer;

    invoke-direct {p3}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {p1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p1, "...disabling drawings for the remainder of the workbook"

    invoke-virtual {p3, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    iget-object p1, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v0}, Ljxl/WorkbookSettings;->setDrawingsDisabled(Z)V

    :cond_1e
    return-void
.end method

.method private handleOutOfBoundsCells()V
    .locals 7

    iget v0, p0, Ljxl/read/biff/SheetReader;->numRows:I

    iget v1, p0, Ljxl/read/biff/SheetReader;->numCols:I

    iget-object v2, p0, Ljxl/read/biff/SheetReader;->outOfBoundsCells:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/Cell;

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    invoke-static {v0, v4}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v1

    goto :goto_0

    :cond_0
    sget-object v2, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Some cells exceeded the specified bounds.  Resizing sheet dimensions from "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v4, p0, Ljxl/read/biff/SheetReader;->numCols:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v4, "x"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v5, p0, Ljxl/read/biff/SheetReader;->numRows:I

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v5, " to "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    iget v2, p0, Ljxl/read/biff/SheetReader;->numCols:I

    const/4 v3, 0x0

    if-le v1, v2, :cond_1

    move v2, v3

    :goto_1
    iget v4, p0, Ljxl/read/biff/SheetReader;->numRows:I

    if-ge v2, v4, :cond_1

    new-array v4, v1, [Ljxl/Cell;

    iget-object v5, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    aget-object v5, v5, v2

    array-length v6, v5

    invoke-static {v5, v3, v4, v3, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v5, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    aput-object v4, v5, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    iget v2, p0, Ljxl/read/biff/SheetReader;->numRows:I

    if-le v0, v2, :cond_2

    new-array v2, v0, [[Ljxl/Cell;

    iget-object v4, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    array-length v5, v4

    invoke-static {v4, v3, v2, v3, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iput-object v2, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    iget v3, p0, Ljxl/read/biff/SheetReader;->numRows:I

    :goto_2
    if-ge v3, v0, :cond_2

    new-array v4, v1, [Ljxl/Cell;

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_2
    iput v0, p0, Ljxl/read/biff/SheetReader;->numRows:I

    iput v1, p0, Ljxl/read/biff/SheetReader;->numCols:I

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->outOfBoundsCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/Cell;

    invoke-direct {p0, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto :goto_3

    :cond_3
    iget-object v0, p0, Ljxl/read/biff/SheetReader;->outOfBoundsCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method private revertSharedFormula(Ljxl/read/biff/BaseSharedFormulaRecord;)Ljxl/Cell;
    .locals 12

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v0}, Ljxl/read/biff/File;->getPos()I

    move-result v0

    iget-object v1, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {p1}, Ljxl/read/biff/BaseSharedFormulaRecord;->getFilePos()I

    move-result v2

    invoke-virtual {v1, v2}, Ljxl/read/biff/File;->setPos(I)V

    new-instance v1, Ljxl/read/biff/FormulaRecord;

    invoke-virtual {p1}, Ljxl/read/biff/BaseSharedFormulaRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object v4

    iget-object v5, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    iget-object v6, p0, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v8, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    sget-object v9, Ljxl/read/biff/FormulaRecord;->ignoreSharedFormula:Ljxl/read/biff/FormulaRecord$IgnoreSharedFormula;

    iget-object v10, p0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    iget-object v11, p0, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object v3, v1

    move-object v7, v8

    invoke-direct/range {v3 .. v11}, Ljxl/read/biff/FormulaRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/File;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/read/biff/FormulaRecord$IgnoreSharedFormula;Ljxl/read/biff/SheetImpl;Ljxl/WorkbookSettings;)V

    :try_start_0
    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object p1

    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object v2

    invoke-interface {v2}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v2

    sget-object v3, Ljxl/CellType;->NUMBER_FORMULA:Ljxl/CellType;

    if-ne v2, v3, :cond_0

    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object v2

    move-object v4, v2

    check-cast v4, Ljxl/read/biff/NumberFormulaRecord;

    iget-object v2, p0, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v3

    invoke-virtual {v2, v3}, Ljxl/biff/FormattingRecords;->isDate(I)Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance p1, Ljxl/read/biff/DateFormulaRecord;

    iget-object v5, p0, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v7, p0, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    iget-boolean v8, p0, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    iget-object v9, p0, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object v3, p1

    move-object v6, v7

    invoke-direct/range {v3 .. v9}, Ljxl/read/biff/DateFormulaRecord;-><init>(Ljxl/read/biff/NumberFormulaRecord;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;ZLjxl/read/biff/SheetImpl;)V

    :cond_0
    iget-object v2, p0, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v2, v0}, Ljxl/read/biff/File;->setPos(I)V
    :try_end_0
    .catch Ljxl/biff/formula/FormulaException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getColumn()I

    move-result v3

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getRow()I

    move-result v1

    invoke-static {v3, v1}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const/4 p1, 0x0

    return-object p1
.end method


# virtual methods
.method final getAutoFilter()Ljxl/biff/AutoFilter;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->autoFilter:Ljxl/biff/AutoFilter;

    return-object v0
.end method

.method final getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->buttonPropertySet:Ljxl/read/biff/ButtonPropertySetRecord;

    return-object v0
.end method

.method final getCells()[[Ljxl/Cell;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    return-object v0
.end method

.method final getCharts()Ljava/util/ArrayList;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->charts:Ljava/util/ArrayList;

    return-object v0
.end method

.method final getColumnBreaks()[I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->columnBreaks:[I

    return-object v0
.end method

.method final getColumnInfosArray()Ljava/util/ArrayList;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->columnInfosArray:Ljava/util/ArrayList;

    return-object v0
.end method

.method final getConditionalFormats()Ljava/util/ArrayList;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->conditionalFormats:Ljava/util/ArrayList;

    return-object v0
.end method

.method final getDataValidation()Ljxl/biff/DataValidation;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->dataValidation:Ljxl/biff/DataValidation;

    return-object v0
.end method

.method getDrawingData()Ljxl/biff/drawing/DrawingData;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    return-object v0
.end method

.method final getDrawings()Ljava/util/ArrayList;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    return-object v0
.end method

.method final getHyperlinks()Ljava/util/ArrayList;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->hyperlinks:Ljava/util/ArrayList;

    return-object v0
.end method

.method public getMaxColumnOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SheetReader;->maxColumnOutlineLevel:I

    return v0
.end method

.method public getMaxRowOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SheetReader;->maxRowOutlineLevel:I

    return v0
.end method

.method final getMergedCells()[Ljxl/Range;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->mergedCells:[Ljxl/Range;

    return-object v0
.end method

.method final getNumCols()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SheetReader;->numCols:I

    return v0
.end method

.method final getNumRows()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/SheetReader;->numRows:I

    return v0
.end method

.method final getPLS()Ljxl/read/biff/PLSRecord;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->plsRecord:Ljxl/read/biff/PLSRecord;

    return-object v0
.end method

.method final getRowBreaks()[I
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->rowBreaks:[I

    return-object v0
.end method

.method final getRowProperties()Ljava/util/ArrayList;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->rowProperties:Ljava/util/ArrayList;

    return-object v0
.end method

.method final getSettings()Ljxl/SheetSettings;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    return-object v0
.end method

.method final getWorkspaceOptions()Ljxl/biff/WorkspaceInformationRecord;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/SheetReader;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    return-object v0
.end method

.method final read()V
    .locals 31

    move-object/from16 v9, p0

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    iget v1, v9, Ljxl/read/biff/SheetReader;->startPosition:I

    invoke-virtual {v0, v1}, Ljxl/read/biff/File;->setPos(I)V

    new-instance v10, Ljava/util/HashMap;

    invoke-direct {v10}, Ljava/util/HashMap;-><init>()V

    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    const/4 v12, 0x1

    const/4 v13, 0x0

    move v15, v12

    move/from16 v27, v15

    move/from16 v16, v13

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    :goto_0
    if-eqz v15, :cond_69

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v0}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object v1

    sget-object v2, Ljxl/biff/Type;->UNKNOWN:Ljxl/biff/Type;

    if-ne v1, v2, :cond_1

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getCode()I

    move-result v2

    if-nez v2, :cond_1

    sget-object v2, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v14, "Biff code zero found"

    invoke-virtual {v2, v14}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getLength()I

    move-result v2

    const/16 v14, 0xa

    if-ne v2, v14, :cond_0

    sget-object v2, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v14, "Biff code zero found - trying a dimension record."

    invoke-virtual {v2, v14}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    sget-object v2, Ljxl/biff/Type;->DIMENSION:Ljxl/biff/Type;

    invoke-virtual {v0, v2}, Ljxl/read/biff/Record;->setType(Ljxl/biff/Type;)V

    goto :goto_1

    :cond_0
    sget-object v2, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v14, "Biff code zero found - Ignoring."

    invoke-virtual {v2, v14}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_1
    :goto_1
    sget-object v2, Ljxl/biff/Type;->DIMENSION:Ljxl/biff/Type;

    if-ne v1, v2, :cond_3

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_2

    new-instance v1, Ljxl/read/biff/DimensionRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/DimensionRecord;-><init>(Ljxl/read/biff/Record;)V

    goto :goto_2

    :cond_2
    new-instance v1, Ljxl/read/biff/DimensionRecord;

    sget-object v2, Ljxl/read/biff/DimensionRecord;->biff7:Ljxl/read/biff/DimensionRecord$Biff7;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/DimensionRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/DimensionRecord$Biff7;)V

    :goto_2
    invoke-virtual {v1}, Ljxl/read/biff/DimensionRecord;->getNumberOfRows()I

    move-result v0

    iput v0, v9, Ljxl/read/biff/SheetReader;->numRows:I

    invoke-virtual {v1}, Ljxl/read/biff/DimensionRecord;->getNumberOfColumns()I

    move-result v0

    iput v0, v9, Ljxl/read/biff/SheetReader;->numCols:I

    iget v1, v9, Ljxl/read/biff/SheetReader;->numRows:I

    const/4 v2, 0x2

    new-array v2, v2, [I

    aput v0, v2, v12

    aput v1, v2, v13

    const-class v0, Ljxl/Cell;

    invoke-static {v0, v2}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[Ljxl/Cell;

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->cells:[[Ljxl/Cell;

    goto :goto_3

    :cond_3
    sget-object v2, Ljxl/biff/Type;->LABELSST:Ljxl/biff/Type;

    if-ne v1, v2, :cond_5

    new-instance v1, Ljxl/read/biff/LabelSSTRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->sharedStrings:Ljxl/read/biff/SSTRecord;

    iget-object v14, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v12, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v1, v0, v2, v14, v12}, Ljxl/read/biff/LabelSSTRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/SSTRecord;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    invoke-direct {v9, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    :cond_4
    :goto_3
    move-object v12, v5

    move-object v14, v7

    move-object v13, v8

    move-object v2, v10

    move-object v7, v11

    move/from16 v28, v15

    move-object v15, v3

    :goto_4
    move-object v10, v4

    move-object v11, v6

    goto/16 :goto_2b

    :cond_5
    sget-object v2, Ljxl/biff/Type;->RK:Ljxl/biff/Type;

    if-eq v1, v2, :cond_66

    sget-object v2, Ljxl/biff/Type;->RK2:Ljxl/biff/Type;

    if-ne v1, v2, :cond_6

    goto/16 :goto_2a

    :cond_6
    sget-object v2, Ljxl/biff/Type;->HLINK:Ljxl/biff/Type;

    if-ne v1, v2, :cond_7

    new-instance v1, Ljxl/read/biff/HyperlinkRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    iget-object v12, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v0, v2, v12}, Ljxl/read/biff/HyperlinkRecord;-><init>(Ljxl/read/biff/Record;Ljxl/Sheet;Ljxl/WorkbookSettings;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->hyperlinks:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_7
    sget-object v2, Ljxl/biff/Type;->MERGEDCELLS:Ljxl/biff/Type;

    if-ne v1, v2, :cond_9

    new-instance v1, Ljxl/read/biff/MergedCellsRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/MergedCellsRecord;-><init>(Ljxl/read/biff/Record;Ljxl/Sheet;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->mergedCells:[Ljxl/Range;

    if-nez v0, :cond_8

    invoke-virtual {v1}, Ljxl/read/biff/MergedCellsRecord;->getRanges()[Ljxl/Range;

    move-result-object v0

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->mergedCells:[Ljxl/Range;

    goto :goto_3

    :cond_8
    array-length v0, v0

    invoke-virtual {v1}, Ljxl/read/biff/MergedCellsRecord;->getRanges()[Ljxl/Range;

    move-result-object v2

    array-length v2, v2

    add-int/2addr v0, v2

    new-array v0, v0, [Ljxl/Range;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->mergedCells:[Ljxl/Range;

    array-length v12, v2

    invoke-static {v2, v13, v0, v13, v12}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {v1}, Ljxl/read/biff/MergedCellsRecord;->getRanges()[Ljxl/Range;

    move-result-object v2

    iget-object v12, v9, Ljxl/read/biff/SheetReader;->mergedCells:[Ljxl/Range;

    array-length v12, v12

    invoke-virtual {v1}, Ljxl/read/biff/MergedCellsRecord;->getRanges()[Ljxl/Range;

    move-result-object v1

    array-length v1, v1

    invoke-static {v2, v13, v0, v12, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->mergedCells:[Ljxl/Range;

    goto :goto_3

    :cond_9
    sget-object v2, Ljxl/biff/Type;->MULRK:Ljxl/biff/Type;

    if-ne v1, v2, :cond_b

    new-instance v1, Ljxl/read/biff/MulRKRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/MulRKRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/MulRKRecord;->getNumberOfColumns()I

    move-result v0

    move v2, v13

    :goto_5
    if-ge v2, v0, :cond_4

    invoke-virtual {v1, v2}, Ljxl/read/biff/MulRKRecord;->getXFIndex(I)I

    move-result v12

    new-instance v14, Ljxl/read/biff/NumberValue;

    invoke-virtual {v1}, Ljxl/read/biff/MulRKRecord;->getRow()I

    move-result v18

    invoke-virtual {v1}, Ljxl/read/biff/MulRKRecord;->getFirstColumn()I

    move-result v17

    add-int v19, v17, v2

    invoke-virtual {v1, v2}, Ljxl/read/biff/MulRKRecord;->getRKNumber(I)I

    move-result v17

    invoke-static/range {v17 .. v17}, Ljxl/read/biff/RKHelper;->getDouble(I)D

    move-result-wide v20

    iget-object v13, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    move/from16 v28, v0

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v14

    move/from16 v22, v12

    move-object/from16 v23, v13

    move-object/from16 v24, v0

    invoke-direct/range {v17 .. v24}, Ljxl/read/biff/NumberValue;-><init>(IIDILjxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v0, v12}, Ljxl/biff/FormattingRecords;->isDate(I)Z

    move-result v0

    if-eqz v0, :cond_a

    new-instance v0, Ljxl/read/biff/DateRecord;

    iget-object v13, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    move-object/from16 v23, v1

    iget-boolean v1, v9, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    move-object/from16 v24, v3

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v0

    move-object/from16 v18, v14

    move/from16 v19, v12

    move-object/from16 v20, v13

    move/from16 v21, v1

    move-object/from16 v22, v3

    invoke-direct/range {v17 .. v22}, Ljxl/read/biff/DateRecord;-><init>(Ljxl/NumberCell;ILjxl/biff/FormattingRecords;ZLjxl/read/biff/SheetImpl;)V

    invoke-direct {v9, v0}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto :goto_6

    :cond_a
    move-object/from16 v23, v1

    move-object/from16 v24, v3

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v0, v12}, Ljxl/biff/FormattingRecords;->getNumberFormat(I)Ljava/text/NumberFormat;

    move-result-object v0

    invoke-virtual {v14, v0}, Ljxl/read/biff/NumberValue;->setNumberFormat(Ljava/text/NumberFormat;)V

    invoke-direct {v9, v14}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    :goto_6
    add-int/lit8 v2, v2, 0x1

    move-object/from16 v1, v23

    move-object/from16 v3, v24

    move/from16 v0, v28

    const/4 v13, 0x0

    goto :goto_5

    :cond_b
    move-object/from16 v24, v3

    sget-object v2, Ljxl/biff/Type;->NUMBER:Ljxl/biff/Type;

    if-ne v1, v2, :cond_d

    new-instance v1, Ljxl/read/biff/NumberRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v1, v0, v2, v3}, Ljxl/read/biff/NumberRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/biff/FormattingRecords;->isDate(I)Z

    move-result v0

    if-eqz v0, :cond_c

    new-instance v0, Ljxl/read/biff/DateRecord;

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v19

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-boolean v3, v9, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    iget-object v12, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v0

    move-object/from16 v18, v1

    move-object/from16 v20, v2

    move/from16 v21, v3

    move-object/from16 v22, v12

    invoke-direct/range {v17 .. v22}, Ljxl/read/biff/DateRecord;-><init>(Ljxl/NumberCell;ILjxl/biff/FormattingRecords;ZLjxl/read/biff/SheetImpl;)V

    :goto_7
    invoke-direct {v9, v0}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto :goto_8

    :cond_c
    invoke-direct {v9, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto :goto_8

    :cond_d
    sget-object v2, Ljxl/biff/Type;->BOOLERR:Ljxl/biff/Type;

    if-ne v1, v2, :cond_e

    new-instance v1, Ljxl/read/biff/BooleanRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v1, v0, v2, v3}, Ljxl/read/biff/BooleanRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    invoke-virtual {v1}, Ljxl/read/biff/BooleanRecord;->isError()Z

    move-result v0

    if-eqz v0, :cond_c

    new-instance v0, Ljxl/read/biff/ErrorRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BooleanRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object v1

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v0, v1, v2, v3}, Ljxl/read/biff/ErrorRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    goto :goto_7

    :cond_e
    sget-object v2, Ljxl/biff/Type;->PRINTGRIDLINES:Ljxl/biff/Type;

    if-ne v1, v2, :cond_10

    new-instance v1, Ljxl/read/biff/PrintGridLinesRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/PrintGridLinesRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/PrintGridLinesRecord;->getPrintGridLines()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setPrintGridLines(Z)V

    :cond_f
    :goto_8
    move-object v12, v5

    move-object v14, v7

    move-object v13, v8

    move-object v2, v10

    move-object v7, v11

    move/from16 v28, v15

    move-object/from16 v15, v24

    goto/16 :goto_4

    :cond_10
    sget-object v2, Ljxl/biff/Type;->PRINTHEADERS:Ljxl/biff/Type;

    if-ne v1, v2, :cond_11

    new-instance v1, Ljxl/read/biff/PrintHeadersRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/PrintHeadersRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/PrintHeadersRecord;->getPrintHeaders()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setPrintHeaders(Z)V

    goto :goto_8

    :cond_11
    sget-object v2, Ljxl/biff/Type;->WINDOW2:Ljxl/biff/Type;

    if-ne v1, v2, :cond_13

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_12

    new-instance v1, Ljxl/read/biff/Window2Record;

    invoke-direct {v1, v0}, Ljxl/read/biff/Window2Record;-><init>(Ljxl/read/biff/Record;)V

    goto :goto_9

    :cond_12
    new-instance v1, Ljxl/read/biff/Window2Record;

    sget-object v2, Ljxl/read/biff/Window2Record;->biff7:Ljxl/read/biff/Window2Record$Biff7;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/Window2Record;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/Window2Record$Biff7;)V

    :goto_9
    move-object/from16 v25, v1

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual/range {v25 .. v25}, Ljxl/read/biff/Window2Record;->getShowGridLines()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setShowGridLines(Z)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual/range {v25 .. v25}, Ljxl/read/biff/Window2Record;->getDisplayZeroValues()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setDisplayZeroValues(Z)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setSelected(Z)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual/range {v25 .. v25}, Ljxl/read/biff/Window2Record;->isPageBreakPreview()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setPageBreakPreviewMode(Z)V

    goto :goto_a

    :cond_13
    sget-object v2, Ljxl/biff/Type;->PANE:Ljxl/biff/Type;

    if-ne v1, v2, :cond_14

    new-instance v1, Ljxl/read/biff/PaneRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/PaneRecord;-><init>(Ljxl/read/biff/Record;)V

    if-eqz v25, :cond_f

    invoke-virtual/range {v25 .. v25}, Ljxl/read/biff/Window2Record;->getFrozen()Z

    move-result v0

    if-eqz v0, :cond_f

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/PaneRecord;->getRowsVisible()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setVerticalFreeze(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/PaneRecord;->getColumnsVisible()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setHorizontalFreeze(I)V

    goto :goto_8

    :cond_14
    sget-object v2, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    if-ne v1, v2, :cond_15

    new-instance v1, Ljxl/biff/ContinueRecord;

    invoke-direct {v1, v0}, Ljxl/biff/ContinueRecord;-><init>(Ljxl/read/biff/Record;)V

    move-object/from16 v26, v1

    :goto_a
    move-object v14, v7

    move-object v2, v10

    move-object v7, v11

    move-object/from16 v3, v24

    goto/16 :goto_2d

    :cond_15
    sget-object v2, Ljxl/biff/Type;->NOTE:Ljxl/biff/Type;

    if-ne v1, v2, :cond_19

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getDrawingsDisabled()Z

    move-result v1

    if-nez v1, :cond_17

    new-instance v1, Ljxl/biff/drawing/NoteRecord;

    invoke-direct {v1, v0}, Ljxl/biff/drawing/NoteRecord;-><init>(Ljxl/read/biff/Record;)V

    new-instance v0, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljxl/biff/drawing/NoteRecord;->getObjectId()I

    move-result v2

    invoke-direct {v0, v2}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v10, v0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/biff/drawing/Comment;

    if-nez v0, :cond_16

    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, " cannot find comment for note id "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljxl/biff/drawing/NoteRecord;->getObjectId()I

    move-result v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v1, "...ignoring"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_b

    :cond_16
    invoke-virtual {v0, v1}, Ljxl/biff/drawing/Comment;->setNote(Ljxl/biff/drawing/NoteRecord;)V

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0}, Ljxl/biff/drawing/Comment;->getColumn()I

    move-result v2

    invoke-virtual {v0}, Ljxl/biff/drawing/Comment;->getRow()I

    move-result v3

    invoke-virtual {v0}, Ljxl/biff/drawing/Comment;->getText()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v0}, Ljxl/biff/drawing/Comment;->getWidth()D

    move-result-wide v13

    invoke-virtual {v0}, Ljxl/biff/drawing/Comment;->getHeight()D

    move-result-wide v17

    move-object/from16 v1, p0

    move/from16 v28, v15

    move-object/from16 v15, v24

    move-object/from16 v29, v10

    move-object v10, v4

    move-object v4, v12

    move-object v12, v5

    move-object/from16 v30, v11

    move-object v11, v6

    move-wide v5, v13

    move-object v14, v7

    move-object v13, v8

    move-wide/from16 v7, v17

    invoke-direct/range {v1 .. v8}, Ljxl/read/biff/SheetReader;->addCellComment(IILjava/lang/String;DD)V

    goto :goto_c

    :cond_17
    :goto_b
    move-object v12, v5

    move-object v14, v7

    move-object v13, v8

    move-object/from16 v29, v10

    move-object/from16 v30, v11

    move/from16 v28, v15

    move-object/from16 v15, v24

    move-object v10, v4

    move-object v11, v6

    :cond_18
    :goto_c
    move-object/from16 v2, v29

    move-object/from16 v7, v30

    goto/16 :goto_2b

    :cond_19
    move-object v12, v5

    move-object v14, v7

    move-object v13, v8

    move-object/from16 v29, v10

    move-object/from16 v30, v11

    move/from16 v28, v15

    move-object/from16 v15, v24

    move-object v10, v4

    move-object v11, v6

    sget-object v2, Ljxl/biff/Type;->ARRAY:Ljxl/biff/Type;

    if-ne v1, v2, :cond_1a

    :goto_d
    goto :goto_c

    :cond_1a
    sget-object v2, Ljxl/biff/Type;->PROTECT:Ljxl/biff/Type;

    if-ne v1, v2, :cond_1b

    new-instance v1, Ljxl/read/biff/ProtectRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/ProtectRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/ProtectRecord;->isProtected()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setProtected(Z)V

    goto :goto_c

    :cond_1b
    sget-object v2, Ljxl/biff/Type;->SHAREDFORMULA:Ljxl/biff/Type;

    if-ne v1, v2, :cond_1d

    if-nez v14, :cond_1c

    sget-object v1, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v2, "Shared template formula is null - trying most recent formula template"

    invoke-virtual {v1, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->sharedFormulas:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/read/biff/SharedFormulaRecord;

    if-eqz v1, :cond_1c

    invoke-virtual {v1}, Ljxl/read/biff/SharedFormulaRecord;->getTemplateFormula()Ljxl/read/biff/BaseSharedFormulaRecord;

    move-result-object v7

    move-object/from16 v19, v7

    goto :goto_e

    :cond_1c
    move-object/from16 v19, v14

    :goto_e
    new-instance v1, Ljxl/read/biff/SharedFormulaRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v1

    move-object/from16 v18, v0

    move-object/from16 v20, v2

    move-object/from16 v21, v2

    move-object/from16 v22, v3

    invoke-direct/range {v17 .. v22}, Ljxl/read/biff/SharedFormulaRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/BaseSharedFormulaRecord;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/read/biff/SheetImpl;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->sharedFormulas:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-object v4, v10

    move-object v6, v11

    move-object v5, v12

    move-object v8, v13

    move-object v3, v15

    move/from16 v15, v28

    move-object/from16 v2, v29

    move-object/from16 v7, v30

    const/4 v14, 0x0

    goto/16 :goto_2d

    :cond_1d
    sget-object v2, Ljxl/biff/Type;->FORMULA:Ljxl/biff/Type;

    if-eq v1, v2, :cond_61

    sget-object v2, Ljxl/biff/Type;->FORMULA2:Ljxl/biff/Type;

    if-ne v1, v2, :cond_1e

    goto/16 :goto_27

    :cond_1e
    sget-object v2, Ljxl/biff/Type;->LABEL:Ljxl/biff/Type;

    if-ne v1, v2, :cond_20

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_1f

    new-instance v1, Ljxl/read/biff/LabelRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    iget-object v4, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v0, v2, v3, v4}, Ljxl/read/biff/LabelRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;Ljxl/WorkbookSettings;)V

    goto :goto_f

    :cond_1f
    new-instance v1, Ljxl/read/biff/LabelRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    iget-object v4, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    sget-object v22, Ljxl/read/biff/LabelRecord;->biff7:Ljxl/read/biff/LabelRecord$Biff7;

    move-object/from16 v17, v1

    move-object/from16 v18, v0

    move-object/from16 v19, v2

    move-object/from16 v20, v3

    move-object/from16 v21, v4

    invoke-direct/range {v17 .. v22}, Ljxl/read/biff/LabelRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;Ljxl/WorkbookSettings;Ljxl/read/biff/LabelRecord$Biff7;)V

    :goto_f
    invoke-direct {v9, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto/16 :goto_c

    :cond_20
    sget-object v2, Ljxl/biff/Type;->RSTRING:Ljxl/biff/Type;

    if-ne v1, v2, :cond_21

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    const/4 v2, 0x1

    xor-int/2addr v1, v2

    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    new-instance v1, Ljxl/read/biff/RStringRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    iget-object v4, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    sget-object v22, Ljxl/read/biff/RStringRecord;->biff7:Ljxl/read/biff/RStringRecord$Biff7;

    move-object/from16 v17, v1

    move-object/from16 v18, v0

    move-object/from16 v19, v2

    move-object/from16 v20, v3

    move-object/from16 v21, v4

    invoke-direct/range {v17 .. v22}, Ljxl/read/biff/RStringRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;Ljxl/WorkbookSettings;Ljxl/read/biff/RStringRecord$Biff7;)V

    goto :goto_f

    :cond_21
    sget-object v2, Ljxl/biff/Type;->NAME:Ljxl/biff/Type;

    if-ne v1, v2, :cond_22

    goto/16 :goto_d

    :cond_22
    sget-object v2, Ljxl/biff/Type;->PASSWORD:Ljxl/biff/Type;

    if-ne v1, v2, :cond_23

    new-instance v1, Ljxl/read/biff/PasswordRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/PasswordRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/PasswordRecord;->getPasswordHash()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setPasswordHash(I)V

    goto/16 :goto_c

    :cond_23
    sget-object v2, Ljxl/biff/Type;->ROW:Ljxl/biff/Type;

    if-ne v1, v2, :cond_25

    new-instance v1, Ljxl/read/biff/RowRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/RowRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/RowRecord;->isDefaultHeight()Z

    move-result v0

    if-eqz v0, :cond_24

    invoke-virtual {v1}, Ljxl/read/biff/RowRecord;->matchesDefaultFontHeight()Z

    move-result v0

    if-eqz v0, :cond_24

    invoke-virtual {v1}, Ljxl/read/biff/RowRecord;->isCollapsed()Z

    move-result v0

    if-nez v0, :cond_24

    invoke-virtual {v1}, Ljxl/read/biff/RowRecord;->hasDefaultFormat()Z

    move-result v0

    if-nez v0, :cond_24

    invoke-virtual {v1}, Ljxl/read/biff/RowRecord;->getOutlineLevel()I

    move-result v0

    if-eqz v0, :cond_18

    :cond_24
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->rowProperties:Ljava/util/ArrayList;

    goto/16 :goto_11

    :cond_25
    sget-object v2, Ljxl/biff/Type;->BLANK:Ljxl/biff/Type;

    if-ne v1, v2, :cond_26

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getIgnoreBlanks()Z

    move-result v1

    if-nez v1, :cond_18

    new-instance v1, Ljxl/read/biff/BlankCell;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v1, v0, v2, v3}, Ljxl/read/biff/BlankCell;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    goto/16 :goto_f

    :cond_26
    sget-object v2, Ljxl/biff/Type;->MULBLANK:Ljxl/biff/Type;

    if-ne v1, v2, :cond_27

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getIgnoreBlanks()Z

    move-result v1

    if-nez v1, :cond_18

    new-instance v1, Ljxl/read/biff/MulBlankRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/MulBlankRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/MulBlankRecord;->getNumberOfColumns()I

    move-result v0

    const/4 v2, 0x0

    :goto_10
    if-ge v2, v0, :cond_18

    invoke-virtual {v1, v2}, Ljxl/read/biff/MulBlankRecord;->getXFIndex(I)I

    move-result v6

    new-instance v8, Ljxl/read/biff/MulBlankCell;

    invoke-virtual {v1}, Ljxl/read/biff/MulBlankRecord;->getRow()I

    move-result v4

    invoke-virtual {v1}, Ljxl/read/biff/MulBlankRecord;->getFirstColumn()I

    move-result v3

    add-int v5, v3, v2

    iget-object v7, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v3

    move-object v3, v8

    move/from16 v18, v0

    move-object v0, v8

    move-object/from16 v8, v17

    invoke-direct/range {v3 .. v8}, Ljxl/read/biff/MulBlankCell;-><init>(IIILjxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    invoke-direct {v9, v0}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    add-int/lit8 v2, v2, 0x1

    move/from16 v0, v18

    goto :goto_10

    :cond_27
    sget-object v2, Ljxl/biff/Type;->SCL:Ljxl/biff/Type;

    if-ne v1, v2, :cond_28

    new-instance v1, Ljxl/read/biff/SCLRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/SCLRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SCLRecord;->getZoomFactor()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setZoomFactor(I)V

    goto/16 :goto_c

    :cond_28
    sget-object v2, Ljxl/biff/Type;->COLINFO:Ljxl/biff/Type;

    if-ne v1, v2, :cond_29

    new-instance v1, Ljxl/read/biff/ColumnInfoRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/ColumnInfoRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->columnInfosArray:Ljava/util/ArrayList;

    :goto_11
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_c

    :cond_29
    sget-object v2, Ljxl/biff/Type;->HEADER:Ljxl/biff/Type;

    if-ne v1, v2, :cond_2b

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_2a

    new-instance v1, Ljxl/read/biff/HeaderRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/HeaderRecord;-><init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;)V

    goto :goto_12

    :cond_2a
    new-instance v1, Ljxl/read/biff/HeaderRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    sget-object v3, Ljxl/read/biff/HeaderRecord;->biff7:Ljxl/read/biff/HeaderRecord$Biff7;

    invoke-direct {v1, v0, v2, v3}, Ljxl/read/biff/HeaderRecord;-><init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;Ljxl/read/biff/HeaderRecord$Biff7;)V

    :goto_12
    new-instance v0, Ljxl/HeaderFooter;

    invoke-virtual {v1}, Ljxl/read/biff/HeaderRecord;->getHeader()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/HeaderFooter;-><init>(Ljava/lang/String;)V

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1, v0}, Ljxl/SheetSettings;->setHeader(Ljxl/HeaderFooter;)V

    goto/16 :goto_c

    :cond_2b
    sget-object v2, Ljxl/biff/Type;->FOOTER:Ljxl/biff/Type;

    if-ne v1, v2, :cond_2d

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_2c

    new-instance v1, Ljxl/read/biff/FooterRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/FooterRecord;-><init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;)V

    goto :goto_13

    :cond_2c
    new-instance v1, Ljxl/read/biff/FooterRecord;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    sget-object v3, Ljxl/read/biff/FooterRecord;->biff7:Ljxl/read/biff/FooterRecord$Biff7;

    invoke-direct {v1, v0, v2, v3}, Ljxl/read/biff/FooterRecord;-><init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;Ljxl/read/biff/FooterRecord$Biff7;)V

    :goto_13
    new-instance v0, Ljxl/HeaderFooter;

    invoke-virtual {v1}, Ljxl/read/biff/FooterRecord;->getFooter()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/HeaderFooter;-><init>(Ljava/lang/String;)V

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1, v0}, Ljxl/SheetSettings;->setFooter(Ljxl/HeaderFooter;)V

    goto/16 :goto_c

    :cond_2d
    sget-object v2, Ljxl/biff/Type;->SETUP:Ljxl/biff/Type;

    if-ne v1, v2, :cond_30

    new-instance v1, Ljxl/read/biff/SetupRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/SetupRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getInitialized()Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->isPortrait()Z

    move-result v0

    if-eqz v0, :cond_2e

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    sget-object v2, Ljxl/format/PageOrientation;->PORTRAIT:Ljxl/format/PageOrientation;

    goto :goto_14

    :cond_2e
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    sget-object v2, Ljxl/format/PageOrientation;->LANDSCAPE:Ljxl/format/PageOrientation;

    :goto_14
    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setOrientation(Ljxl/format/PageOrientation;)V

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->isRightDown()Z

    move-result v0

    if-eqz v0, :cond_2f

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    sget-object v2, Ljxl/format/PageOrder;->RIGHT_THEN_DOWN:Ljxl/format/PageOrder;

    goto :goto_15

    :cond_2f
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    sget-object v2, Ljxl/format/PageOrder;->DOWN_THEN_RIGHT:Ljxl/format/PageOrder;

    :goto_15
    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setPageOrder(Ljxl/format/PageOrder;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getPaperSize()I

    move-result v2

    invoke-static {v2}, Ljxl/format/PaperSize;->getPaperSize(I)Ljxl/format/PaperSize;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setPaperSize(Ljxl/format/PaperSize;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getHeaderMargin()D

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljxl/SheetSettings;->setHeaderMargin(D)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getFooterMargin()D

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljxl/SheetSettings;->setFooterMargin(D)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getScaleFactor()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setScaleFactor(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getPageStart()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setPageStart(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getFitWidth()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setFitWidth(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getFitHeight()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setFitHeight(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getHorizontalPrintResolution()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setHorizontalPrintResolution(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getVerticalPrintResolution()I

    move-result v2

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setVerticalPrintResolution(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SetupRecord;->getCopies()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setCopies(I)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    if-eqz v0, :cond_18

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v0}, Ljxl/biff/WorkspaceInformationRecord;->getFitToPages()Z

    move-result v0

    invoke-virtual {v1, v0}, Ljxl/SheetSettings;->setFitToPages(Z)V

    goto/16 :goto_c

    :cond_30
    sget-object v2, Ljxl/biff/Type;->WSBOOL:Ljxl/biff/Type;

    if-ne v1, v2, :cond_31

    new-instance v1, Ljxl/biff/WorkspaceInformationRecord;

    invoke-direct {v1, v0}, Ljxl/biff/WorkspaceInformationRecord;-><init>(Ljxl/read/biff/Record;)V

    iput-object v1, v9, Ljxl/read/biff/SheetReader;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    goto/16 :goto_c

    :cond_31
    sget-object v2, Ljxl/biff/Type;->DEFCOLWIDTH:Ljxl/biff/Type;

    if-ne v1, v2, :cond_32

    new-instance v1, Ljxl/read/biff/DefaultColumnWidthRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/DefaultColumnWidthRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/DefaultColumnWidthRecord;->getWidth()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setDefaultColumnWidth(I)V

    goto/16 :goto_c

    :cond_32
    sget-object v2, Ljxl/biff/Type;->DEFAULTROWHEIGHT:Ljxl/biff/Type;

    if-ne v1, v2, :cond_33

    new-instance v1, Ljxl/read/biff/DefaultRowHeightRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/DefaultRowHeightRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/DefaultRowHeightRecord;->getHeight()I

    move-result v0

    if-eqz v0, :cond_18

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/DefaultRowHeightRecord;->getHeight()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setDefaultRowHeight(I)V

    goto/16 :goto_c

    :cond_33
    sget-object v2, Ljxl/biff/Type;->CONDFMT:Ljxl/biff/Type;

    if-ne v1, v2, :cond_34

    new-instance v1, Ljxl/biff/ConditionalFormatRangeRecord;

    invoke-direct {v1, v0}, Ljxl/biff/ConditionalFormatRangeRecord;-><init>(Ljxl/read/biff/Record;)V

    new-instance v6, Ljxl/biff/ConditionalFormat;

    invoke-direct {v6, v1}, Ljxl/biff/ConditionalFormat;-><init>(Ljxl/biff/ConditionalFormatRangeRecord;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->conditionalFormats:Ljava/util/ArrayList;

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-object v4, v10

    :goto_16
    move-object v5, v12

    move-object v8, v13

    move-object v3, v15

    :goto_17
    move/from16 v15, v28

    move-object/from16 v2, v29

    move-object/from16 v7, v30

    goto/16 :goto_2d

    :cond_34
    sget-object v2, Ljxl/biff/Type;->CF:Ljxl/biff/Type;

    if-ne v1, v2, :cond_35

    new-instance v1, Ljxl/biff/ConditionalFormatRecord;

    invoke-direct {v1, v0}, Ljxl/biff/ConditionalFormatRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v11, v1}, Ljxl/biff/ConditionalFormat;->addCondition(Ljxl/biff/ConditionalFormatRecord;)V

    goto/16 :goto_c

    :cond_35
    sget-object v2, Ljxl/biff/Type;->FILTERMODE:Ljxl/biff/Type;

    if-ne v1, v2, :cond_36

    new-instance v4, Ljxl/biff/FilterModeRecord;

    invoke-direct {v4, v0}, Ljxl/biff/FilterModeRecord;-><init>(Ljxl/read/biff/Record;)V

    move-object v6, v11

    goto :goto_16

    :cond_36
    sget-object v2, Ljxl/biff/Type;->AUTOFILTERINFO:Ljxl/biff/Type;

    if-ne v1, v2, :cond_37

    new-instance v3, Ljxl/biff/AutoFilterInfoRecord;

    invoke-direct {v3, v0}, Ljxl/biff/AutoFilterInfoRecord;-><init>(Ljxl/read/biff/Record;)V

    move-object v4, v10

    :goto_18
    move-object v6, v11

    move-object v5, v12

    move-object v8, v13

    goto :goto_17

    :cond_37
    sget-object v2, Ljxl/biff/Type;->AUTOFILTER:Ljxl/biff/Type;

    if-ne v1, v2, :cond_39

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getAutoFilterDisabled()Z

    move-result v1

    if-nez v1, :cond_18

    new-instance v1, Ljxl/biff/AutoFilterRecord;

    invoke-direct {v1, v0}, Ljxl/biff/AutoFilterRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->autoFilter:Ljxl/biff/AutoFilter;

    if-nez v0, :cond_38

    new-instance v0, Ljxl/biff/AutoFilter;

    invoke-direct {v0, v10, v15}, Ljxl/biff/AutoFilter;-><init>(Ljxl/biff/FilterModeRecord;Ljxl/biff/AutoFilterInfoRecord;)V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->autoFilter:Ljxl/biff/AutoFilter;

    const/4 v3, 0x0

    const/4 v4, 0x0

    goto :goto_19

    :cond_38
    move-object v4, v10

    move-object v3, v15

    :goto_19
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->autoFilter:Ljxl/biff/AutoFilter;

    invoke-virtual {v0, v1}, Ljxl/biff/AutoFilter;->add(Ljxl/biff/AutoFilterRecord;)V

    goto :goto_18

    :cond_39
    sget-object v2, Ljxl/biff/Type;->LEFTMARGIN:Ljxl/biff/Type;

    if-ne v1, v2, :cond_3a

    new-instance v1, Ljxl/read/biff/LeftMarginRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/LeftMarginRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/MarginRecord;->getMargin()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljxl/SheetSettings;->setLeftMargin(D)V

    goto/16 :goto_c

    :cond_3a
    sget-object v2, Ljxl/biff/Type;->RIGHTMARGIN:Ljxl/biff/Type;

    if-ne v1, v2, :cond_3b

    new-instance v1, Ljxl/read/biff/RightMarginRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/RightMarginRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/MarginRecord;->getMargin()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljxl/SheetSettings;->setRightMargin(D)V

    goto/16 :goto_c

    :cond_3b
    sget-object v2, Ljxl/biff/Type;->TOPMARGIN:Ljxl/biff/Type;

    if-ne v1, v2, :cond_3c

    new-instance v1, Ljxl/read/biff/TopMarginRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/TopMarginRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/MarginRecord;->getMargin()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljxl/SheetSettings;->setTopMargin(D)V

    goto/16 :goto_c

    :cond_3c
    sget-object v2, Ljxl/biff/Type;->BOTTOMMARGIN:Ljxl/biff/Type;

    if-ne v1, v2, :cond_3d

    new-instance v1, Ljxl/read/biff/BottomMarginRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/BottomMarginRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/MarginRecord;->getMargin()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljxl/SheetSettings;->setBottomMargin(D)V

    goto/16 :goto_c

    :cond_3d
    sget-object v2, Ljxl/biff/Type;->HORIZONTALPAGEBREAKS:Ljxl/biff/Type;

    if-ne v1, v2, :cond_3f

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_3e

    new-instance v1, Ljxl/read/biff/HorizontalPageBreaksRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/HorizontalPageBreaksRecord;-><init>(Ljxl/read/biff/Record;)V

    goto :goto_1a

    :cond_3e
    new-instance v1, Ljxl/read/biff/HorizontalPageBreaksRecord;

    sget-object v2, Ljxl/read/biff/HorizontalPageBreaksRecord;->biff7:Ljxl/read/biff/HorizontalPageBreaksRecord$Biff7;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/HorizontalPageBreaksRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/HorizontalPageBreaksRecord$Biff7;)V

    :goto_1a
    invoke-virtual {v1}, Ljxl/read/biff/HorizontalPageBreaksRecord;->getRowBreaks()[I

    move-result-object v0

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->rowBreaks:[I

    goto/16 :goto_c

    :cond_3f
    sget-object v2, Ljxl/biff/Type;->VERTICALPAGEBREAKS:Ljxl/biff/Type;

    if-ne v1, v2, :cond_41

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v1

    if-eqz v1, :cond_40

    new-instance v1, Ljxl/read/biff/VerticalPageBreaksRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/VerticalPageBreaksRecord;-><init>(Ljxl/read/biff/Record;)V

    goto :goto_1b

    :cond_40
    new-instance v1, Ljxl/read/biff/VerticalPageBreaksRecord;

    sget-object v2, Ljxl/read/biff/VerticalPageBreaksRecord;->biff7:Ljxl/read/biff/VerticalPageBreaksRecord$Biff7;

    invoke-direct {v1, v0, v2}, Ljxl/read/biff/VerticalPageBreaksRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/VerticalPageBreaksRecord$Biff7;)V

    :goto_1b
    invoke-virtual {v1}, Ljxl/read/biff/VerticalPageBreaksRecord;->getColumnBreaks()[I

    move-result-object v0

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->columnBreaks:[I

    goto/16 :goto_c

    :cond_41
    sget-object v2, Ljxl/biff/Type;->PLS:Ljxl/biff/Type;

    if-ne v1, v2, :cond_42

    new-instance v1, Ljxl/read/biff/PLSRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/PLSRecord;-><init>(Ljxl/read/biff/Record;)V

    iput-object v1, v9, Ljxl/read/biff/SheetReader;->plsRecord:Ljxl/read/biff/PLSRecord;

    goto/16 :goto_c

    :cond_42
    sget-object v2, Ljxl/biff/Type;->DVAL:Ljxl/biff/Type;

    if-ne v1, v2, :cond_49

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getCellValidationDisabled()Z

    move-result v1

    if-nez v1, :cond_47

    new-instance v1, Ljxl/biff/DataValidityListRecord;

    invoke-direct {v1, v0}, Ljxl/biff/DataValidityListRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/biff/DataValidityListRecord;->getObjectId()I

    move-result v0

    const/4 v2, -0x1

    if-ne v0, v2, :cond_45

    if-eqz v13, :cond_44

    if-nez v12, :cond_44

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez v0, :cond_43

    new-instance v0, Ljxl/biff/drawing/DrawingData;

    invoke-direct {v0}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_43
    new-instance v0, Ljxl/biff/drawing/Drawing2;

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v3}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v3

    invoke-direct {v0, v13, v2, v3}, Ljxl/biff/drawing/Drawing2;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/DrawingData;Ljxl/biff/drawing/DrawingGroup;)V

    iget-object v2, v9, Ljxl/read/biff/SheetReader;->drawings:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Ljxl/biff/DataValidation;

    invoke-direct {v0, v1}, Ljxl/biff/DataValidation;-><init>(Ljxl/biff/DataValidityListRecord;)V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->dataValidation:Ljxl/biff/DataValidation;

    move-object/from16 v7, v30

    const/4 v8, 0x0

    goto :goto_1d

    :cond_44
    new-instance v0, Ljxl/biff/DataValidation;

    invoke-direct {v0, v1}, Ljxl/biff/DataValidation;-><init>(Ljxl/biff/DataValidityListRecord;)V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->dataValidation:Ljxl/biff/DataValidation;

    move-object/from16 v7, v30

    goto :goto_1c

    :cond_45
    new-instance v0, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljxl/biff/DataValidityListRecord;->getObjectId()I

    move-result v2

    invoke-direct {v0, v2}, Ljava/lang/Integer;-><init>(I)V

    move-object/from16 v7, v30

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_46

    new-instance v0, Ljxl/biff/DataValidation;

    invoke-direct {v0, v1}, Ljxl/biff/DataValidation;-><init>(Ljxl/biff/DataValidityListRecord;)V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->dataValidation:Ljxl/biff/DataValidation;

    goto :goto_1c

    :cond_46
    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "object id "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljxl/biff/DataValidityListRecord;->getObjectId()I

    move-result v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v1, " referenced "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " by data validity list record not found - ignoring"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_1c
    move-object v8, v13

    :goto_1d
    move-object v4, v10

    move-object v6, v11

    move-object v5, v12

    move-object v3, v15

    move/from16 v15, v28

    move-object/from16 v2, v29

    goto/16 :goto_2d

    :cond_47
    move-object/from16 v7, v30

    :cond_48
    :goto_1e
    move-object/from16 v2, v29

    goto/16 :goto_2b

    :cond_49
    move-object/from16 v7, v30

    sget-object v2, Ljxl/biff/Type;->HCENTER:Ljxl/biff/Type;

    if-ne v1, v2, :cond_4a

    new-instance v1, Ljxl/read/biff/CentreRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/CentreRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/CentreRecord;->isCentre()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setHorizontalCentre(Z)V

    goto :goto_1e

    :cond_4a
    sget-object v2, Ljxl/biff/Type;->VCENTER:Ljxl/biff/Type;

    if-ne v1, v2, :cond_4b

    new-instance v1, Ljxl/read/biff/CentreRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/CentreRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/CentreRecord;->isCentre()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setVerticalCentre(Z)V

    goto :goto_1e

    :cond_4b
    sget-object v2, Ljxl/biff/Type;->DV:Ljxl/biff/Type;

    if-ne v1, v2, :cond_4d

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getCellValidationDisabled()Z

    move-result v1

    if-nez v1, :cond_48

    new-instance v6, Ljxl/biff/DataValiditySettingsRecord;

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getSettings()Ljxl/WorkbookSettings;

    move-result-object v2

    invoke-direct {v6, v0, v1, v1, v2}, Ljxl/biff/DataValiditySettingsRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->dataValidation:Ljxl/biff/DataValidation;

    if-eqz v0, :cond_4c

    invoke-virtual {v0, v6}, Ljxl/biff/DataValidation;->add(Ljxl/biff/DataValiditySettingsRecord;)V

    invoke-virtual {v6}, Ljxl/biff/DataValiditySettingsRecord;->getFirstColumn()I

    move-result v2

    invoke-virtual {v6}, Ljxl/biff/DataValiditySettingsRecord;->getFirstRow()I

    move-result v3

    invoke-virtual {v6}, Ljxl/biff/DataValiditySettingsRecord;->getLastColumn()I

    move-result v4

    invoke-virtual {v6}, Ljxl/biff/DataValiditySettingsRecord;->getLastRow()I

    move-result v5

    move-object/from16 v1, p0

    invoke-direct/range {v1 .. v6}, Ljxl/read/biff/SheetReader;->addCellValidation(IIIILjxl/biff/DataValiditySettingsRecord;)V

    goto :goto_1e

    :cond_4c
    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v1, "cannot add data validity settings"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_1e

    :cond_4d
    sget-object v2, Ljxl/biff/Type;->OBJ:Ljxl/biff/Type;

    if-ne v1, v2, :cond_51

    new-instance v5, Ljxl/biff/drawing/ObjRecord;

    invoke-direct {v5, v0}, Ljxl/biff/drawing/ObjRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getDrawingsDisabled()Z

    move-result v0

    if-nez v0, :cond_4f

    if-nez v13, :cond_4e

    if-eqz v26, :cond_4e

    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v1, "Cannot find drawing record - using continue record"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    new-instance v8, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-virtual/range {v26 .. v26}, Ljxl/biff/ContinueRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-direct {v8, v0}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>(Ljxl/read/biff/Record;)V

    move-object/from16 v2, v29

    const/16 v26, 0x0

    goto :goto_1f

    :cond_4e
    move-object v8, v13

    move-object/from16 v2, v29

    :goto_1f
    invoke-direct {v9, v5, v8, v2}, Ljxl/read/biff/SheetReader;->handleObjectRecord(Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/MsoDrawingRecord;Ljava/util/HashMap;)V

    new-instance v0, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljxl/biff/drawing/ObjRecord;->getObjectId()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_20

    :cond_4f
    move-object/from16 v2, v29

    move-object v8, v13

    :goto_20
    invoke-virtual {v5}, Ljxl/biff/drawing/ObjRecord;->getType()Ljxl/biff/drawing/ObjRecord$ObjType;

    move-result-object v0

    sget-object v1, Ljxl/biff/drawing/ObjRecord;->CHART:Ljxl/biff/drawing/ObjRecord$ObjType;

    if-eq v0, v1, :cond_50

    move-object v4, v10

    move-object v6, v11

    move-object v3, v15

    move/from16 v15, v28

    const/4 v5, 0x0

    const/4 v8, 0x0

    goto/16 :goto_2d

    :cond_50
    :goto_21
    move-object v4, v10

    move-object v6, v11

    goto/16 :goto_2c

    :cond_51
    move-object/from16 v2, v29

    sget-object v3, Ljxl/biff/Type;->MSODRAWING:Ljxl/biff/Type;

    if-ne v1, v3, :cond_54

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getDrawingsDisabled()Z

    move-result v1

    if-nez v1, :cond_68

    if-eqz v13, :cond_52

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    invoke-virtual {v13}, Ljxl/biff/drawing/MsoDrawingRecord;->getData()[B

    move-result-object v3

    invoke-virtual {v1, v3}, Ljxl/biff/drawing/DrawingData;->addRawData([B)V

    :cond_52
    new-instance v8, Ljxl/biff/drawing/MsoDrawingRecord;

    invoke-direct {v8, v0}, Ljxl/biff/drawing/MsoDrawingRecord;-><init>(Ljxl/read/biff/Record;)V

    if-eqz v27, :cond_53

    invoke-virtual {v8}, Ljxl/biff/drawing/MsoDrawingRecord;->setFirst()V

    move-object v4, v10

    move-object v6, v11

    move-object v5, v12

    move-object v3, v15

    move/from16 v15, v28

    const/16 v27, 0x0

    goto/16 :goto_2d

    :cond_53
    move-object v4, v10

    move-object v6, v11

    move-object v5, v12

    goto/16 :goto_2c

    :cond_54
    sget-object v3, Ljxl/biff/Type;->BUTTONPROPERTYSET:Ljxl/biff/Type;

    if-ne v1, v3, :cond_55

    new-instance v1, Ljxl/read/biff/ButtonPropertySetRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/ButtonPropertySetRecord;-><init>(Ljxl/read/biff/Record;)V

    iput-object v1, v9, Ljxl/read/biff/SheetReader;->buttonPropertySet:Ljxl/read/biff/ButtonPropertySetRecord;

    goto/16 :goto_2b

    :cond_55
    sget-object v3, Ljxl/biff/Type;->CALCMODE:Ljxl/biff/Type;

    if-ne v1, v3, :cond_56

    new-instance v1, Ljxl/read/biff/CalcModeRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/CalcModeRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/CalcModeRecord;->isAutomatic()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setAutomaticFormulaCalculation(Z)V

    goto/16 :goto_2b

    :cond_56
    sget-object v3, Ljxl/biff/Type;->SAVERECALC:Ljxl/biff/Type;

    if-ne v1, v3, :cond_57

    new-instance v1, Ljxl/read/biff/SaveRecalcRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/SaveRecalcRecord;-><init>(Ljxl/read/biff/Record;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/read/biff/SaveRecalcRecord;->getRecalculateOnSave()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setRecalculateFormulasBeforeSave(Z)V

    goto/16 :goto_2b

    :cond_57
    sget-object v3, Ljxl/biff/Type;->GUTS:Ljxl/biff/Type;

    if-ne v1, v3, :cond_5a

    new-instance v1, Ljxl/read/biff/GuttersRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/GuttersRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/GuttersRecord;->getRowOutlineLevel()I

    move-result v0

    if-lez v0, :cond_58

    invoke-virtual {v1}, Ljxl/read/biff/GuttersRecord;->getRowOutlineLevel()I

    move-result v0

    const/4 v3, 0x1

    sub-int/2addr v0, v3

    goto :goto_22

    :cond_58
    const/4 v3, 0x1

    const/4 v0, 0x0

    :goto_22
    iput v0, v9, Ljxl/read/biff/SheetReader;->maxRowOutlineLevel:I

    invoke-virtual {v1}, Ljxl/read/biff/GuttersRecord;->getColumnOutlineLevel()I

    move-result v0

    if-lez v0, :cond_59

    invoke-virtual {v1}, Ljxl/read/biff/GuttersRecord;->getRowOutlineLevel()I

    move-result v0

    sub-int/2addr v0, v3

    goto :goto_23

    :cond_59
    const/4 v0, 0x0

    :goto_23
    iput v0, v9, Ljxl/read/biff/SheetReader;->maxColumnOutlineLevel:I

    goto/16 :goto_2b

    :cond_5a
    sget-object v3, Ljxl/biff/Type;->BOF:Ljxl/biff/Type;

    if-ne v1, v3, :cond_60

    new-instance v1, Ljxl/read/biff/BOFRecord;

    invoke-direct {v1, v0}, Ljxl/read/biff/BOFRecord;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isWorksheet()Z

    move-result v3

    const/4 v4, 0x1

    xor-int/2addr v3, v4

    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v3}, Ljxl/read/biff/File;->getPos()I

    move-result v3

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getLength()I

    move-result v0

    sub-int/2addr v3, v0

    add-int/lit8 v21, v3, -0x4

    :goto_24
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v0}, Ljxl/read/biff/File;->next()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getCode()I

    move-result v0

    sget-object v3, Ljxl/biff/Type;->EOF:Ljxl/biff/Type;

    iget v3, v3, Ljxl/biff/Type;->value:I

    if-eq v0, v3, :cond_5b

    goto :goto_24

    :cond_5b
    invoke-virtual {v1}, Ljxl/read/biff/BOFRecord;->isChart()Z

    move-result v0

    if-eqz v0, :cond_5f

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getWorkbookBof()Ljxl/read/biff/BOFRecord;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/BOFRecord;->isBiff8()Z

    move-result v0

    if-nez v0, :cond_5c

    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v1, "only biff8 charts are supported"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_25

    :cond_5c
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    if-nez v0, :cond_5d

    new-instance v0, Ljxl/biff/drawing/DrawingData;

    invoke-direct {v0}, Ljxl/biff/drawing/DrawingData;-><init>()V

    iput-object v0, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    :cond_5d
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getDrawingsDisabled()Z

    move-result v0

    if-nez v0, :cond_5e

    new-instance v0, Ljxl/biff/drawing/Chart;

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->drawingData:Ljxl/biff/drawing/DrawingData;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v3}, Ljxl/read/biff/File;->getPos()I

    move-result v22

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    iget-object v5, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object/from16 v17, v0

    move-object/from16 v18, v13

    move-object/from16 v19, v12

    move-object/from16 v20, v1

    move-object/from16 v23, v3

    move-object/from16 v24, v5

    invoke-direct/range {v17 .. v24}, Ljxl/biff/drawing/Chart;-><init>(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;Ljxl/biff/drawing/DrawingData;IILjxl/read/biff/File;Ljxl/WorkbookSettings;)V

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->charts:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v1

    if-eqz v1, :cond_5e

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v1}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/biff/drawing/DrawingGroup;->add(Ljxl/biff/drawing/Chart;)V

    :cond_5e
    :goto_25
    const/4 v5, 0x0

    const/4 v8, 0x0

    goto :goto_26

    :cond_5f
    move-object v5, v12

    move-object v8, v13

    :goto_26
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->sheetBof:Ljxl/read/biff/BOFRecord;

    invoke-virtual {v0}, Ljxl/read/biff/BOFRecord;->isChart()Z

    move-result v0

    if-eqz v0, :cond_50

    const/16 v28, 0x0

    goto/16 :goto_21

    :cond_60
    const/4 v4, 0x1

    sget-object v0, Ljxl/biff/Type;->EOF:Ljxl/biff/Type;

    if-ne v1, v0, :cond_68

    move-object v4, v10

    move-object v6, v11

    move-object v5, v12

    move-object v8, v13

    move-object v3, v15

    const/4 v15, 0x0

    goto/16 :goto_2d

    :cond_61
    :goto_27
    move-object/from16 v2, v29

    move-object/from16 v7, v30

    const/4 v4, 0x1

    new-instance v1, Ljxl/read/biff/FormulaRecord;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    iget-object v5, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v6, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    iget-object v8, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    iget-object v4, v9, Ljxl/read/biff/SheetReader;->workbookSettings:Ljxl/WorkbookSettings;

    move-object/from16 v17, v1

    move-object/from16 v18, v0

    move-object/from16 v19, v3

    move-object/from16 v20, v5

    move-object/from16 v21, v6

    move-object/from16 v22, v6

    move-object/from16 v23, v8

    move-object/from16 v24, v4

    invoke-direct/range {v17 .. v24}, Ljxl/read/biff/FormulaRecord;-><init>(Ljxl/read/biff/Record;Ljxl/read/biff/File;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/read/biff/SheetImpl;Ljxl/WorkbookSettings;)V

    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->isShared()Z

    move-result v0

    if-eqz v0, :cond_63

    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object v0

    check-cast v0, Ljxl/read/biff/BaseSharedFormulaRecord;

    invoke-direct {v9, v0}, Ljxl/read/biff/SheetReader;->addToSharedFormulas(Ljxl/read/biff/BaseSharedFormulaRecord;)Z

    move-result v16

    if-eqz v16, :cond_62

    move-object v0, v14

    :cond_62
    if-nez v16, :cond_65

    if-eqz v14, :cond_65

    invoke-direct {v9, v14}, Ljxl/read/biff/SheetReader;->revertSharedFormula(Ljxl/read/biff/BaseSharedFormulaRecord;)Ljxl/Cell;

    move-result-object v1

    invoke-direct {v9, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto :goto_29

    :cond_63
    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object v3

    :try_start_0
    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v0

    sget-object v4, Ljxl/CellType;->NUMBER_FORMULA:Ljxl/CellType;

    if-ne v0, v4, :cond_64

    invoke-virtual {v1}, Ljxl/read/biff/FormulaRecord;->getFormula()Ljxl/read/biff/CellValue;

    move-result-object v0

    move-object/from16 v18, v0

    check-cast v18, Ljxl/read/biff/NumberFormulaRecord;

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual/range {v18 .. v18}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/biff/FormattingRecords;->isDate(I)Z

    move-result v0

    if-eqz v0, :cond_64

    new-instance v0, Ljxl/read/biff/DateFormulaRecord;

    iget-object v1, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v4, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    iget-boolean v5, v9, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    iget-object v6, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v0

    move-object/from16 v19, v1

    move-object/from16 v20, v4

    move-object/from16 v21, v4

    move/from16 v22, v5

    move-object/from16 v23, v6

    invoke-direct/range {v17 .. v23}, Ljxl/read/biff/DateFormulaRecord;-><init>(Ljxl/read/biff/NumberFormulaRecord;Ljxl/biff/FormattingRecords;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;ZLjxl/read/biff/SheetImpl;)V

    move-object v3, v0

    :cond_64
    invoke-direct {v9, v3}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V
    :try_end_0
    .catch Ljxl/biff/formula/FormulaException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_28

    :catch_0
    move-exception v0

    sget-object v1, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v5

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v3

    invoke-static {v5, v3}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v3, " "

    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_28
    move-object v0, v14

    :cond_65
    :goto_29
    move-object v14, v0

    goto :goto_2b

    :cond_66
    :goto_2a
    move-object v12, v5

    move-object v14, v7

    move-object v13, v8

    move-object v2, v10

    move-object v7, v11

    move/from16 v28, v15

    move-object v15, v3

    move-object v10, v4

    move-object v11, v6

    new-instance v1, Ljxl/read/biff/RKRecord;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v4, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    invoke-direct {v1, v0, v3, v4}, Ljxl/read/biff/RKRecord;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v3

    invoke-virtual {v0, v3}, Ljxl/biff/FormattingRecords;->isDate(I)Z

    move-result v0

    if-eqz v0, :cond_67

    new-instance v0, Ljxl/read/biff/DateRecord;

    invoke-virtual {v1}, Ljxl/read/biff/CellValue;->getXFIndex()I

    move-result v19

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-boolean v4, v9, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    iget-object v5, v9, Ljxl/read/biff/SheetReader;->sheet:Ljxl/read/biff/SheetImpl;

    move-object/from16 v17, v0

    move-object/from16 v18, v1

    move-object/from16 v20, v3

    move/from16 v21, v4

    move-object/from16 v22, v5

    invoke-direct/range {v17 .. v22}, Ljxl/read/biff/DateRecord;-><init>(Ljxl/NumberCell;ILjxl/biff/FormattingRecords;ZLjxl/read/biff/SheetImpl;)V

    invoke-direct {v9, v0}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    goto :goto_2b

    :cond_67
    invoke-direct {v9, v1}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    :cond_68
    :goto_2b
    move-object v4, v10

    move-object v6, v11

    move-object v5, v12

    move-object v8, v13

    :goto_2c
    move-object v3, v15

    move/from16 v15, v28

    :goto_2d
    move-object v10, v2

    move-object v11, v7

    move-object v7, v14

    const/4 v12, 0x1

    const/4 v13, 0x0

    goto/16 :goto_0

    :cond_69
    move-object v12, v5

    move-object v14, v7

    move-object v13, v8

    move-object v2, v10

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->excelFile:Ljxl/read/biff/File;

    invoke-virtual {v0}, Ljxl/read/biff/File;->restorePos()V

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->outOfBoundsCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_6a

    invoke-direct/range {p0 .. p0}, Ljxl/read/biff/SheetReader;->handleOutOfBoundsCells()V

    :cond_6a
    iget-object v0, v9, Ljxl/read/biff/SheetReader;->sharedFormulas:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_6b
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6c

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/read/biff/SharedFormulaRecord;

    iget-object v3, v9, Ljxl/read/biff/SheetReader;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-boolean v4, v9, Ljxl/read/biff/SheetReader;->nineteenFour:Z

    invoke-virtual {v1, v3, v4}, Ljxl/read/biff/SharedFormulaRecord;->getFormulas(Ljxl/biff/FormattingRecords;Z)[Ljxl/Cell;

    move-result-object v1

    const/4 v3, 0x0

    :goto_2e
    array-length v4, v1

    if-ge v3, v4, :cond_6b

    aget-object v4, v1, v3

    invoke-direct {v9, v4}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_2e

    :cond_6c
    if-nez v16, :cond_6d

    if-eqz v14, :cond_6d

    invoke-direct {v9, v14}, Ljxl/read/biff/SheetReader;->revertSharedFormula(Ljxl/read/biff/BaseSharedFormulaRecord;)Ljxl/Cell;

    move-result-object v0

    invoke-direct {v9, v0}, Ljxl/read/biff/SheetReader;->addCell(Ljxl/Cell;)V

    :cond_6d
    if-eqz v13, :cond_6e

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v0

    if-eqz v0, :cond_6e

    iget-object v0, v9, Ljxl/read/biff/SheetReader;->workbook:Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object v0

    invoke-virtual {v0, v13, v12}, Ljxl/biff/drawing/DrawingGroup;->setDrawingsOmitted(Ljxl/biff/drawing/MsoDrawingRecord;Ljxl/biff/drawing/ObjRecord;)V

    :cond_6e
    invoke-virtual {v2}, Ljava/util/HashMap;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6f

    sget-object v0, Ljxl/read/biff/SheetReader;->logger:Ljxl/common/Logger;

    const-string v1, "Not all comments have a corresponding Note record"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_6f
    return-void
.end method
