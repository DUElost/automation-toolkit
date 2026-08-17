.class final Ljxl/write/biff/SheetWriter;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$SheetWriter:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private autoFilter:Ljxl/biff/AutoFilter;

.field private buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

.field private chartOnly:Z

.field private columnBreaks:Ljava/util/ArrayList;

.field private columnFormats:Ljava/util/TreeSet;

.field private conditionalFormats:Ljava/util/ArrayList;

.field private dataValidation:Ljxl/biff/DataValidation;

.field private drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

.field private footer:Ljxl/write/biff/FooterRecord;

.field private header:Ljxl/write/biff/HeaderRecord;

.field private hyperlinks:Ljava/util/ArrayList;

.field private maxColumnOutlineLevel:I

.field private maxRowOutlineLevel:I

.field private mergedCells:Ljxl/write/biff/MergedCells;

.field private numCols:I

.field private numRows:I

.field private outputFile:Ljxl/write/biff/File;

.field private plsRecord:Ljxl/write/biff/PLSRecord;

.field private rowBreaks:Ljava/util/ArrayList;

.field private rows:[Ljxl/write/biff/RowRecord;

.field private settings:Ljxl/SheetSettings;

.field private sheet:Ljxl/write/biff/WritableSheetImpl;

.field private validatedCells:Ljava/util/ArrayList;

.field private workbookSettings:Ljxl/WorkbookSettings;

.field private workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/SheetWriter;->class$jxl$write$biff$SheetWriter:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.SheetWriter"

    invoke-static {v0}, Ljxl/write/biff/SheetWriter;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/SheetWriter;->class$jxl$write$biff$SheetWriter:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/SheetWriter;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/write/biff/File;Ljxl/write/biff/WritableSheetImpl;Ljxl/WorkbookSettings;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    iput-object p2, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance p1, Ljxl/biff/WorkspaceInformationRecord;

    invoke-direct {p1}, Ljxl/biff/WorkspaceInformationRecord;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    iput-object p3, p0, Ljxl/write/biff/SheetWriter;->workbookSettings:Ljxl/WorkbookSettings;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/SheetWriter;->chartOnly:Z

    new-instance p1, Ljxl/biff/drawing/SheetDrawingWriter;

    invoke-direct {p1, p3}, Ljxl/biff/drawing/SheetDrawingWriter;-><init>(Ljxl/WorkbookSettings;)V

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

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

.method private getColumn(I)[Ljxl/Cell;
    .locals 6

    iget v0, p0, Ljxl/write/biff/SheetWriter;->numRows:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ltz v0, :cond_1

    if-nez v3, :cond_1

    iget-object v4, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    aget-object v5, v4, v0

    if-eqz v5, :cond_0

    aget-object v4, v4, v0

    invoke-virtual {v4, p1}, Ljxl/write/biff/RowRecord;->getCell(I)Ljxl/write/biff/CellValue;

    move-result-object v4

    if-eqz v4, :cond_0

    move v3, v1

    goto :goto_0

    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_1
    add-int/lit8 v1, v0, 0x1

    new-array v1, v1, [Ljxl/Cell;

    :goto_1
    if-gt v2, v0, :cond_3

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    aget-object v4, v3, v2

    if-eqz v4, :cond_2

    aget-object v3, v3, v2

    invoke-virtual {v3, p1}, Ljxl/write/biff/RowRecord;->getCell(I)Ljxl/write/biff/CellValue;

    move-result-object v3

    goto :goto_2

    :cond_2
    const/4 v3, 0x0

    :goto_2
    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    return-object v1
.end method

.method private writeDataValidation()V
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    if-eqz v0, :cond_1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->validatedCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v0, v1}, Ljxl/biff/DataValidation;->write(Ljxl/write/biff/File;)V

    return-void

    :cond_1
    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    if-nez v0, :cond_3

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->validatedCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_3

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getComboBox()Ljxl/biff/drawing/ComboBox;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getComboBox()Ljxl/biff/drawing/ComboBox;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/biff/drawing/ComboBox;->getObjectId()I

    move-result v0

    goto :goto_0

    :cond_2
    const/4 v0, -0x1

    :goto_0
    new-instance v1, Ljxl/biff/DataValidation;

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v2

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v3

    iget-object v4, p0, Ljxl/write/biff/SheetWriter;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v0, v2, v3, v4}, Ljxl/biff/DataValidation;-><init>(ILjxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iput-object v1, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->validatedCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/biff/CellValue;

    invoke-virtual {v1}, Ljxl/write/biff/CellValue;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object v1

    new-instance v2, Ljxl/biff/DataValiditySettingsRecord;

    invoke-virtual {v1}, Ljxl/biff/BaseCellFeatures;->getDVParser()Ljxl/biff/DVParser;

    move-result-object v1

    invoke-direct {v2, v1}, Ljxl/biff/DataValiditySettingsRecord;-><init>(Ljxl/biff/DVParser;)V

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    invoke-virtual {v1, v2}, Ljxl/biff/DataValidation;->add(Ljxl/biff/DataValiditySettingsRecord;)V

    goto :goto_1

    :cond_3
    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->validatedCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/biff/CellValue;

    invoke-virtual {v1}, Ljxl/write/biff/CellValue;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object v1

    new-instance v2, Ljxl/biff/DataValiditySettingsRecord;

    invoke-virtual {v1}, Ljxl/biff/BaseCellFeatures;->getDVParser()Ljxl/biff/DVParser;

    move-result-object v1

    invoke-direct {v2, v1}, Ljxl/biff/DataValiditySettingsRecord;-><init>(Ljxl/biff/DVParser;)V

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    invoke-virtual {v1, v2}, Ljxl/biff/DataValidation;->add(Ljxl/biff/DataValiditySettingsRecord;)V

    goto :goto_2
.end method


# virtual methods
.method checkMergedBorders()V
    .locals 15

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->mergedCells:Ljxl/write/biff/MergedCells;

    invoke-virtual {v0}, Ljxl/write/biff/MergedCells;->getMergedCells()[Ljxl/Range;

    move-result-object v0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_16

    aget-object v3, v0, v2

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v4

    invoke-interface {v4}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object v5

    check-cast v5, Ljxl/biff/XFRecord;

    if-eqz v5, :cond_15

    invoke-virtual {v5}, Ljxl/biff/XFRecord;->hasBorders()Z

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_15

    invoke-virtual {v5}, Ljxl/biff/XFRecord;->isRead()Z

    move-result v6

    if-nez v6, :cond_15

    :try_start_0
    new-instance v6, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v6, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    sget-object v8, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v9, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v10, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v11, Ljxl/format/Border;->LEFT:Ljxl/format/Border;

    invoke-virtual {v5, v11}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v12

    invoke-virtual {v5, v11}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v13

    invoke-virtual {v6, v11, v12, v13}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v12, Ljxl/format/Border;->TOP:Ljxl/format/Border;

    invoke-virtual {v5, v12}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v13

    invoke-virtual {v5, v12}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v14

    invoke-virtual {v6, v12, v13, v14}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v12

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v13

    if-ne v12, v13, :cond_0

    sget-object v12, Ljxl/format/Border;->BOTTOM:Ljxl/format/Border;

    invoke-virtual {v5, v12}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v13

    invoke-virtual {v5, v12}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v14

    invoke-virtual {v6, v12, v13, v14}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_0
    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v12

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v13

    if-ne v12, v13, :cond_1

    sget-object v12, Ljxl/format/Border;->RIGHT:Ljxl/format/Border;

    invoke-virtual {v5, v12}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v13

    invoke-virtual {v5, v12}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v14

    invoke-virtual {v6, v12, v13, v14}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_1
    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v12

    const/4 v13, -0x1

    if-eq v12, v13, :cond_2

    invoke-virtual {v1, v12}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/write/biff/CellXFRecord;

    goto :goto_1

    :cond_2
    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_1
    move-object v12, v4

    check-cast v12, Ljxl/write/WritableCell;

    invoke-interface {v12, v6}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v6

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v12

    if-le v6, v12, :cond_7

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v12

    if-eq v6, v12, :cond_4

    new-instance v6, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v6, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-virtual {v5, v11}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v8

    invoke-virtual {v5, v11}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v9

    invoke-virtual {v6, v11, v8, v9}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v8, Ljxl/format/Border;->BOTTOM:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v8

    if-eq v8, v13, :cond_3

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/write/biff/CellXFRecord;

    goto :goto_2

    :cond_3
    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_2
    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v9, Ljxl/write/Blank;

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v10

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v11

    invoke-direct {v9, v10, v11, v6}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v8, v9}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V

    :cond_4
    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v6

    add-int/2addr v6, v7

    :goto_3
    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v8

    if-ge v6, v8, :cond_7

    new-instance v8, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v8, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    sget-object v9, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v10, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v11, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v9, Ljxl/format/Border;->LEFT:Ljxl/format/Border;

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v10

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v11

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v9

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v10

    if-ne v9, v10, :cond_5

    sget-object v9, Ljxl/format/Border;->RIGHT:Ljxl/format/Border;

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v10

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v11

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_5
    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v9

    if-eq v9, v13, :cond_6

    invoke-virtual {v1, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/write/biff/CellXFRecord;

    goto :goto_4

    :cond_6
    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_4
    iget-object v9, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v10, Ljxl/write/Blank;

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v11

    invoke-direct {v10, v11, v6, v8}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v9, v10}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    :cond_7
    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v8

    if-le v6, v8, :cond_e

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v6

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v8

    if-eq v6, v8, :cond_9

    new-instance v6, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v6, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    sget-object v8, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v9, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v10, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v8, Ljxl/format/Border;->RIGHT:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v8, Ljxl/format/Border;->TOP:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v8

    if-eq v8, v13, :cond_8

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/write/biff/CellXFRecord;

    goto :goto_5

    :cond_8
    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_5
    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v9, Ljxl/write/Blank;

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v10

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v11

    invoke-direct {v9, v10, v11, v6}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v8, v9}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V

    :cond_9
    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v6

    add-int/2addr v6, v7

    :goto_6
    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v8

    if-ge v6, v8, :cond_b

    new-instance v8, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v8, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    sget-object v9, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v10, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v11, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v9, Ljxl/format/Border;->RIGHT:Ljxl/format/Border;

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v10

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v11

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v9

    if-eq v9, v13, :cond_a

    invoke-virtual {v1, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/write/biff/CellXFRecord;

    goto :goto_7

    :cond_a
    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_7
    iget-object v9, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v10, Ljxl/write/Blank;

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v11

    invoke-direct {v10, v11, v6, v8}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v9, v10}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_6

    :cond_b
    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v6

    add-int/2addr v6, v7

    :goto_8
    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v8

    if-ge v6, v8, :cond_e

    new-instance v8, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v8, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    sget-object v9, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v10, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v11, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v9, Ljxl/format/Border;->TOP:Ljxl/format/Border;

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v10

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v11

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v9

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v10

    if-ne v9, v10, :cond_c

    sget-object v9, Ljxl/format/Border;->BOTTOM:Ljxl/format/Border;

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v10

    invoke-virtual {v5, v9}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v11

    invoke-virtual {v8, v9, v10, v11}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_c
    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v9

    if-eq v9, v13, :cond_d

    invoke-virtual {v1, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljxl/write/biff/CellXFRecord;

    goto :goto_9

    :cond_d
    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_9
    iget-object v9, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v10, Ljxl/write/Blank;

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v11

    invoke-direct {v10, v6, v11, v8}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v9, v10}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_8

    :cond_e
    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v8

    if-gt v6, v8, :cond_f

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v6

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v8

    if-le v6, v8, :cond_15

    :cond_f
    new-instance v6, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v6, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    sget-object v8, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v9, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v10, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v8, Ljxl/format/Border;->RIGHT:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v8, Ljxl/format/Border;->BOTTOM:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v8

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v9

    if-ne v8, v9, :cond_10

    sget-object v8, Ljxl/format/Border;->TOP:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_10
    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v8

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v9

    if-ne v8, v9, :cond_11

    sget-object v8, Ljxl/format/Border;->LEFT:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v6, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_11
    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v8

    if-eq v8, v13, :cond_12

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/write/biff/CellXFRecord;

    goto :goto_a

    :cond_12
    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_a
    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v9, Ljxl/write/Blank;

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v10

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v11

    invoke-direct {v9, v10, v11, v6}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v8, v9}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v6

    add-int/2addr v6, v7

    :goto_b
    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v7

    if-ge v6, v7, :cond_15

    new-instance v7, Ljxl/write/biff/CellXFRecord;

    invoke-direct {v7, v5}, Ljxl/write/biff/CellXFRecord;-><init>(Ljxl/biff/XFRecord;)V

    sget-object v8, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v9, Ljxl/format/BorderLineStyle;->NONE:Ljxl/format/BorderLineStyle;

    sget-object v10, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    invoke-virtual {v7, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    sget-object v8, Ljxl/format/Border;->BOTTOM:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v7, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v8

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v9

    if-ne v8, v9, :cond_13

    sget-object v8, Ljxl/format/Border;->TOP:Ljxl/format/Border;

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderLine(Ljxl/format/Border;)Ljxl/format/BorderLineStyle;

    move-result-object v9

    invoke-virtual {v5, v8}, Ljxl/biff/XFRecord;->getBorderColour(Ljxl/format/Border;)Ljxl/format/Colour;

    move-result-object v10

    invoke-virtual {v7, v8, v9, v10}, Ljxl/write/biff/CellXFRecord;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    :cond_13
    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v8

    if-eq v8, v13, :cond_14

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljxl/write/biff/CellXFRecord;

    goto :goto_c

    :cond_14
    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_c
    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    new-instance v9, Ljxl/write/Blank;

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v10

    invoke-direct {v9, v6, v10, v7}, Ljxl/write/Blank;-><init>(IILjxl/format/CellFormat;)V

    invoke-virtual {v8, v9}, Ljxl/write/biff/WritableSheetImpl;->addCell(Ljxl/write/WritableCell;)V
    :try_end_0
    .catch Ljxl/write/WriteException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v6, v6, 0x1

    goto :goto_b

    :catch_0
    move-exception v3

    sget-object v4, Ljxl/write/biff/SheetWriter;->logger:Ljxl/common/Logger;

    invoke-virtual {v3}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_15
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    :cond_16
    return-void
.end method

.method getCharts()[Ljxl/biff/drawing/Chart;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

    invoke-virtual {v0}, Ljxl/biff/drawing/SheetDrawingWriter;->getCharts()[Ljxl/biff/drawing/Chart;

    move-result-object v0

    return-object v0
.end method

.method final getFooter()Ljxl/write/biff/FooterRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->footer:Ljxl/write/biff/FooterRecord;

    return-object v0
.end method

.method final getHeader()Ljxl/write/biff/HeaderRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->header:Ljxl/write/biff/HeaderRecord;

    return-object v0
.end method

.method getWorkspaceOptions()Ljxl/biff/WorkspaceInformationRecord;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    return-object v0
.end method

.method setAutoFilter(Ljxl/biff/AutoFilter;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->autoFilter:Ljxl/biff/AutoFilter;

    return-void
.end method

.method setButtonPropertySet(Ljxl/write/biff/ButtonPropertySetRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    return-void
.end method

.method setChartOnly()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/write/biff/SheetWriter;->chartOnly:Z

    return-void
.end method

.method setCharts([Ljxl/biff/drawing/Chart;)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

    invoke-virtual {v0, p1}, Ljxl/biff/drawing/SheetDrawingWriter;->setCharts([Ljxl/biff/drawing/Chart;)V

    return-void
.end method

.method setConditionalFormats(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->conditionalFormats:Ljava/util/ArrayList;

    return-void
.end method

.method setDataValidation(Ljxl/biff/DataValidation;Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    iput-object p2, p0, Ljxl/write/biff/SheetWriter;->validatedCells:Ljava/util/ArrayList;

    return-void
.end method

.method setDimensions(II)V
    .locals 0

    iput p1, p0, Ljxl/write/biff/SheetWriter;->numRows:I

    iput p2, p0, Ljxl/write/biff/SheetWriter;->numCols:I

    return-void
.end method

.method setDrawings(Ljava/util/ArrayList;Z)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

    invoke-virtual {v0, p1, p2}, Ljxl/biff/drawing/SheetDrawingWriter;->setDrawings(Ljava/util/ArrayList;Z)V

    return-void
.end method

.method setPLS(Ljxl/write/biff/PLSRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->plsRecord:Ljxl/write/biff/PLSRecord;

    return-void
.end method

.method setSettings(Ljxl/SheetSettings;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    return-void
.end method

.method setWorkspaceOptions(Ljxl/biff/WorkspaceInformationRecord;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    :cond_0
    return-void
.end method

.method setWriteData([Ljxl/write/biff/RowRecord;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljxl/write/biff/MergedCells;Ljava/util/TreeSet;II)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    iput-object p2, p0, Ljxl/write/biff/SheetWriter;->rowBreaks:Ljava/util/ArrayList;

    iput-object p3, p0, Ljxl/write/biff/SheetWriter;->columnBreaks:Ljava/util/ArrayList;

    iput-object p4, p0, Ljxl/write/biff/SheetWriter;->hyperlinks:Ljava/util/ArrayList;

    iput-object p5, p0, Ljxl/write/biff/SheetWriter;->mergedCells:Ljxl/write/biff/MergedCells;

    iput-object p6, p0, Ljxl/write/biff/SheetWriter;->columnFormats:Ljava/util/TreeSet;

    iput p7, p0, Ljxl/write/biff/SheetWriter;->maxRowOutlineLevel:I

    iput p8, p0, Ljxl/write/biff/SheetWriter;->maxColumnOutlineLevel:I

    return-void
.end method

.method public write()V
    .locals 14

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-boolean v0, p0, Ljxl/write/biff/SheetWriter;->chartOnly:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v0, v1}, Ljxl/biff/drawing/SheetDrawingWriter;->write(Ljxl/write/biff/File;)V

    return-void

    :cond_1
    new-instance v0, Ljxl/write/biff/BOFRecord;

    sget-object v3, Ljxl/write/biff/BOFRecord;->sheet:Ljxl/write/biff/BOFRecord$SheetBOF;

    invoke-direct {v0, v3}, Ljxl/write/biff/BOFRecord;-><init>(Ljxl/write/biff/BOFRecord$SheetBOF;)V

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget v0, p0, Ljxl/write/biff/SheetWriter;->numRows:I

    div-int/lit8 v3, v0, 0x20

    mul-int/lit8 v4, v3, 0x20

    sub-int/2addr v0, v4

    if-eqz v0, :cond_2

    add-int/lit8 v3, v3, 0x1

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v0}, Ljxl/write/biff/File;->getPos()I

    move-result v0

    new-instance v4, Ljxl/write/biff/IndexRecord;

    iget v5, p0, Ljxl/write/biff/SheetWriter;->numRows:I

    invoke-direct {v4, v2, v5, v3}, Ljxl/write/biff/IndexRecord;-><init>(III)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v5, v4}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getAutomaticFormulaCalculation()Z

    move-result v5

    if-eqz v5, :cond_3

    new-instance v5, Ljxl/write/biff/CalcModeRecord;

    sget-object v6, Ljxl/write/biff/CalcModeRecord;->automatic:Ljxl/write/biff/CalcModeRecord$CalcMode;

    invoke-direct {v5, v6}, Ljxl/write/biff/CalcModeRecord;-><init>(Ljxl/write/biff/CalcModeRecord$CalcMode;)V

    goto :goto_1

    :cond_3
    new-instance v5, Ljxl/write/biff/CalcModeRecord;

    sget-object v6, Ljxl/write/biff/CalcModeRecord;->manual:Ljxl/write/biff/CalcModeRecord$CalcMode;

    invoke-direct {v5, v6}, Ljxl/write/biff/CalcModeRecord;-><init>(Ljxl/write/biff/CalcModeRecord$CalcMode;)V

    :goto_1
    iget-object v6, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v6, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/CalcCountRecord;

    const/16 v6, 0x64

    invoke-direct {v5, v6}, Ljxl/write/biff/CalcCountRecord;-><init>(I)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/RefModeRecord;

    invoke-direct {v5}, Ljxl/write/biff/RefModeRecord;-><init>()V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/IterationRecord;

    invoke-direct {v5, v2}, Ljxl/write/biff/IterationRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/DeltaRecord;

    const-wide v7, 0x3f50624dd2f1a9fcL    # 0.001

    invoke-direct {v5, v7, v8}, Ljxl/write/biff/DeltaRecord;-><init>(D)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/SaveRecalcRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getRecalculateFormulasBeforeSave()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/SaveRecalcRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/PrintHeadersRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getPrintHeaders()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/PrintHeadersRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/PrintGridLinesRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getPrintGridLines()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/PrintGridLinesRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/GridSetRecord;

    invoke-direct {v5, v1}, Ljxl/write/biff/GridSetRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/GuttersRecord;

    invoke-direct {v5}, Ljxl/write/biff/GuttersRecord;-><init>()V

    iget v7, p0, Ljxl/write/biff/SheetWriter;->maxColumnOutlineLevel:I

    add-int/2addr v7, v1

    invoke-virtual {v5, v7}, Ljxl/write/biff/GuttersRecord;->setMaxColumnOutline(I)V

    iget v7, p0, Ljxl/write/biff/SheetWriter;->maxRowOutlineLevel:I

    add-int/2addr v7, v1

    invoke-virtual {v5, v7}, Ljxl/write/biff/GuttersRecord;->setMaxRowOutline(I)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/DefaultRowHeightRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getDefaultRowHeight()I

    move-result v7

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v8}, Ljxl/SheetSettings;->getDefaultRowHeight()I

    move-result v8

    const/16 v9, 0xff

    if-eq v8, v9, :cond_4

    move v8, v1

    goto :goto_2

    :cond_4
    move v8, v2

    :goto_2
    invoke-direct {v5, v7, v8}, Ljxl/write/biff/DefaultRowHeightRecord;-><init>(IZ)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget v5, p0, Ljxl/write/biff/SheetWriter;->maxRowOutlineLevel:I

    if-lez v5, :cond_5

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    invoke-virtual {v5, v1}, Ljxl/biff/WorkspaceInformationRecord;->setRowOutlines(Z)V

    :cond_5
    iget v5, p0, Ljxl/write/biff/SheetWriter;->maxColumnOutlineLevel:I

    if-lez v5, :cond_6

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    invoke-virtual {v5, v1}, Ljxl/biff/WorkspaceInformationRecord;->setColumnOutlines(Z)V

    :cond_6
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getFitToPages()Z

    move-result v7

    invoke-virtual {v5, v7}, Ljxl/biff/WorkspaceInformationRecord;->setFitToPages(Z)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->workspaceOptions:Ljxl/biff/WorkspaceInformationRecord;

    invoke-virtual {v5, v7}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->rowBreaks:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-lez v5, :cond_8

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->rowBreaks:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    new-array v7, v5, [I

    move v8, v2

    :goto_3
    if-ge v8, v5, :cond_7

    iget-object v9, p0, Ljxl/write/biff/SheetWriter;->rowBreaks:Ljava/util/ArrayList;

    invoke-virtual {v9, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Integer;

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    aput v9, v7, v8

    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    :cond_7
    new-instance v5, Ljxl/write/biff/HorizontalPageBreaksRecord;

    invoke-direct {v5, v7}, Ljxl/write/biff/HorizontalPageBreaksRecord;-><init>([I)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_8
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->columnBreaks:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-lez v5, :cond_a

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->columnBreaks:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    new-array v7, v5, [I

    move v8, v2

    :goto_4
    if-ge v8, v5, :cond_9

    iget-object v9, p0, Ljxl/write/biff/SheetWriter;->columnBreaks:Ljava/util/ArrayList;

    invoke-virtual {v9, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Integer;

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    aput v9, v7, v8

    add-int/lit8 v8, v8, 0x1

    goto :goto_4

    :cond_9
    new-instance v5, Ljxl/write/biff/VerticalPageBreaksRecord;

    invoke-direct {v5, v7}, Ljxl/write/biff/VerticalPageBreaksRecord;-><init>([I)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_a
    new-instance v5, Ljxl/write/biff/HeaderRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getHeader()Ljxl/HeaderFooter;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/HeaderFooter;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v7}, Ljxl/write/biff/HeaderRecord;-><init>(Ljava/lang/String;)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/FooterRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getFooter()Ljxl/HeaderFooter;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/HeaderFooter;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v7}, Ljxl/write/biff/FooterRecord;-><init>(Ljava/lang/String;)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/HorizontalCentreRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->isHorizontalCentre()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/HorizontalCentreRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/VerticalCentreRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->isVerticalCentre()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/VerticalCentreRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getLeftMargin()D

    move-result-wide v7

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getDefaultWidthMargin()D

    move-result-wide v9

    cmpl-double v5, v7, v9

    if-eqz v5, :cond_b

    new-instance v5, Ljxl/write/biff/LeftMarginRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getLeftMargin()D

    move-result-wide v7

    invoke-direct {v5, v7, v8}, Ljxl/write/biff/LeftMarginRecord;-><init>(D)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_b
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getRightMargin()D

    move-result-wide v7

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getDefaultWidthMargin()D

    move-result-wide v9

    cmpl-double v5, v7, v9

    if-eqz v5, :cond_c

    new-instance v5, Ljxl/write/biff/RightMarginRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getRightMargin()D

    move-result-wide v7

    invoke-direct {v5, v7, v8}, Ljxl/write/biff/RightMarginRecord;-><init>(D)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_c
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getTopMargin()D

    move-result-wide v7

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getDefaultHeightMargin()D

    move-result-wide v9

    cmpl-double v5, v7, v9

    if-eqz v5, :cond_d

    new-instance v5, Ljxl/write/biff/TopMarginRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getTopMargin()D

    move-result-wide v7

    invoke-direct {v5, v7, v8}, Ljxl/write/biff/TopMarginRecord;-><init>(D)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_d
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getBottomMargin()D

    move-result-wide v7

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getDefaultHeightMargin()D

    move-result-wide v9

    cmpl-double v5, v7, v9

    if-eqz v5, :cond_e

    new-instance v5, Ljxl/write/biff/BottomMarginRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getBottomMargin()D

    move-result-wide v7

    invoke-direct {v5, v7, v8}, Ljxl/write/biff/BottomMarginRecord;-><init>(D)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_e
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->plsRecord:Ljxl/write/biff/PLSRecord;

    if-eqz v5, :cond_f

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_f
    new-instance v5, Ljxl/write/biff/SetupRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-direct {v5, v7}, Ljxl/write/biff/SetupRecord;-><init>(Ljxl/SheetSettings;)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->isProtected()Z

    move-result v5

    if-eqz v5, :cond_11

    new-instance v5, Ljxl/write/biff/ProtectRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->isProtected()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/ProtectRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/ScenarioProtectRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->isProtected()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/ScenarioProtectRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v5, Ljxl/write/biff/ObjectProtectRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->isProtected()Z

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/ObjectProtectRecord;-><init>(Z)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getPassword()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_10

    new-instance v5, Ljxl/write/biff/PasswordRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getPassword()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v7}, Ljxl/write/biff/PasswordRecord;-><init>(Ljava/lang/String;)V

    :goto_5
    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    goto :goto_6

    :cond_10
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getPasswordHash()I

    move-result v5

    if-eqz v5, :cond_11

    new-instance v5, Ljxl/write/biff/PasswordRecord;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getPasswordHash()I

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/PasswordRecord;-><init>(I)V

    goto :goto_5

    :cond_11
    :goto_6
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v5}, Ljxl/write/biff/File;->getPos()I

    move-result v5

    invoke-virtual {v4, v5}, Ljxl/write/biff/IndexRecord;->setDataStartPosition(I)V

    new-instance v5, Ljxl/write/biff/DefaultColumnWidth;

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v7}, Ljxl/SheetSettings;->getDefaultColumnWidth()I

    move-result v7

    invoke-direct {v5, v7}, Ljxl/write/biff/DefaultColumnWidth;-><init>(I)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v5}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v5

    invoke-virtual {v5}, Ljxl/write/biff/WritableWorkbookImpl;->getStyles()Ljxl/write/biff/Styles;

    move-result-object v5

    invoke-virtual {v5}, Ljxl/write/biff/Styles;->getNormalStyle()Ljxl/write/WritableCellFormat;

    move-result-object v5

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v7}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/write/biff/WritableWorkbookImpl;->getStyles()Ljxl/write/biff/Styles;

    move-result-object v7

    invoke-virtual {v7}, Ljxl/write/biff/Styles;->getDefaultDateFormat()Ljxl/write/WritableCellFormat;

    move-result-object v7

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->columnFormats:Ljava/util/TreeSet;

    invoke-virtual {v8}, Ljava/util/TreeSet;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_12
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_16

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljxl/write/biff/ColumnInfoRecord;

    invoke-virtual {v9}, Ljxl/write/biff/ColumnInfoRecord;->getColumn()I

    move-result v10

    const/16 v11, 0x100

    if-ge v10, v11, :cond_13

    iget-object v10, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v10, v9}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_13
    invoke-virtual {v9}, Ljxl/write/biff/ColumnInfoRecord;->getCellFormat()Ljxl/biff/XFRecord;

    move-result-object v10

    if-eq v10, v5, :cond_12

    invoke-virtual {v9}, Ljxl/write/biff/ColumnInfoRecord;->getColumn()I

    move-result v12

    if-ge v12, v11, :cond_12

    invoke-virtual {v9}, Ljxl/write/biff/ColumnInfoRecord;->getColumn()I

    move-result v9

    invoke-direct {p0, v9}, Ljxl/write/biff/SheetWriter;->getColumn(I)[Ljxl/Cell;

    move-result-object v9

    move v11, v2

    :goto_7
    array-length v12, v9

    if-ge v11, v12, :cond_12

    aget-object v12, v9, v11

    if-eqz v12, :cond_15

    aget-object v12, v9, v11

    invoke-interface {v12}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object v12

    if-eq v12, v5, :cond_14

    aget-object v12, v9, v11

    invoke-interface {v12}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object v12

    if-ne v12, v7, :cond_15

    :cond_14
    aget-object v12, v9, v11

    check-cast v12, Ljxl/write/WritableCell;

    invoke-interface {v12, v10}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    :cond_15
    add-int/lit8 v11, v11, 0x1

    goto :goto_7

    :cond_16
    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->autoFilter:Ljxl/biff/AutoFilter;

    if-eqz v5, :cond_17

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v5, v7}, Ljxl/biff/AutoFilter;->write(Ljxl/write/biff/File;)V

    :cond_17
    new-instance v5, Ljxl/write/biff/DimensionRecord;

    iget v7, p0, Ljxl/write/biff/SheetWriter;->numRows:I

    iget v8, p0, Ljxl/write/biff/SheetWriter;->numCols:I

    invoke-direct {v5, v7, v8}, Ljxl/write/biff/DimensionRecord;-><init>(II)V

    iget-object v7, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v7, v5}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    move v5, v2

    :goto_8
    if-ge v5, v3, :cond_1c

    new-instance v7, Ljxl/write/biff/DBCellRecord;

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v8}, Ljxl/write/biff/File;->getPos()I

    move-result v8

    invoke-direct {v7, v8}, Ljxl/write/biff/DBCellRecord;-><init>(I)V

    iget v8, p0, Ljxl/write/biff/SheetWriter;->numRows:I

    mul-int/lit8 v9, v5, 0x20

    sub-int/2addr v8, v9

    const/16 v10, 0x20

    invoke-static {v10, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    move v11, v1

    move v10, v9

    :goto_9
    add-int v12, v9, v8

    if-ge v10, v12, :cond_19

    iget-object v12, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    aget-object v13, v12, v10

    if-eqz v13, :cond_18

    aget-object v12, v12, v10

    iget-object v13, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v12, v13}, Ljxl/write/biff/RowRecord;->write(Ljxl/write/biff/File;)V

    if-eqz v11, :cond_18

    iget-object v11, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v11}, Ljxl/write/biff/File;->getPos()I

    move-result v11

    invoke-virtual {v7, v11}, Ljxl/write/biff/DBCellRecord;->setCellOffset(I)V

    move v11, v2

    :cond_18
    add-int/lit8 v10, v10, 0x1

    goto :goto_9

    :cond_19
    :goto_a
    if-ge v9, v12, :cond_1b

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    aget-object v8, v8, v9

    if-eqz v8, :cond_1a

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v8}, Ljxl/write/biff/File;->getPos()I

    move-result v8

    invoke-virtual {v7, v8}, Ljxl/write/biff/DBCellRecord;->addCellRowPosition(I)V

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->rows:[Ljxl/write/biff/RowRecord;

    aget-object v8, v8, v9

    iget-object v10, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v8, v10}, Ljxl/write/biff/RowRecord;->writeCells(Ljxl/write/biff/File;)V

    :cond_1a
    add-int/lit8 v9, v9, 0x1

    goto :goto_a

    :cond_1b
    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v8}, Ljxl/write/biff/File;->getPos()I

    move-result v8

    invoke-virtual {v4, v8}, Ljxl/write/biff/IndexRecord;->addBlockPosition(I)V

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v8}, Ljxl/write/biff/File;->getPos()I

    move-result v8

    invoke-virtual {v7, v8}, Ljxl/write/biff/DBCellRecord;->setPosition(I)V

    iget-object v8, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v8, v7}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_8

    :cond_1c
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->workbookSettings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getDrawingsDisabled()Z

    move-result v1

    if-nez v1, :cond_1d

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->drawingWriter:Ljxl/biff/drawing/SheetDrawingWriter;

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v1, v3}, Ljxl/biff/drawing/SheetDrawingWriter;->write(Ljxl/write/biff/File;)V

    :cond_1d
    new-instance v1, Ljxl/write/biff/Window2Record;

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-direct {v1, v3}, Ljxl/write/biff/Window2Record;-><init>(Ljxl/SheetSettings;)V

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getHorizontalFreeze()I

    move-result v1

    if-nez v1, :cond_1f

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getVerticalFreeze()I

    move-result v1

    if-eqz v1, :cond_1e

    goto :goto_c

    :cond_1e
    new-instance v1, Ljxl/write/biff/SelectionRecord;

    sget-object v3, Ljxl/write/biff/SelectionRecord;->upperLeft:Ljxl/write/biff/SelectionRecord$PaneType;

    invoke-direct {v1, v3, v2, v2}, Ljxl/write/biff/SelectionRecord;-><init>(Ljxl/write/biff/SelectionRecord$PaneType;II)V

    :goto_b
    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    goto/16 :goto_d

    :cond_1f
    :goto_c
    new-instance v1, Ljxl/write/biff/PaneRecord;

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v3}, Ljxl/SheetSettings;->getHorizontalFreeze()I

    move-result v3

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getVerticalFreeze()I

    move-result v5

    invoke-direct {v1, v3, v5}, Ljxl/write/biff/PaneRecord;-><init>(II)V

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/SelectionRecord;

    sget-object v3, Ljxl/write/biff/SelectionRecord;->upperLeft:Ljxl/write/biff/SelectionRecord$PaneType;

    invoke-direct {v1, v3, v2, v2}, Ljxl/write/biff/SelectionRecord;-><init>(Ljxl/write/biff/SelectionRecord$PaneType;II)V

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getHorizontalFreeze()I

    move-result v1

    if-eqz v1, :cond_20

    new-instance v1, Ljxl/write/biff/SelectionRecord;

    sget-object v3, Ljxl/write/biff/SelectionRecord;->upperRight:Ljxl/write/biff/SelectionRecord$PaneType;

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getHorizontalFreeze()I

    move-result v5

    invoke-direct {v1, v3, v5, v2}, Ljxl/write/biff/SelectionRecord;-><init>(Ljxl/write/biff/SelectionRecord$PaneType;II)V

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_20
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getVerticalFreeze()I

    move-result v1

    if-eqz v1, :cond_21

    new-instance v1, Ljxl/write/biff/SelectionRecord;

    sget-object v3, Ljxl/write/biff/SelectionRecord;->lowerLeft:Ljxl/write/biff/SelectionRecord$PaneType;

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getVerticalFreeze()I

    move-result v5

    invoke-direct {v1, v3, v2, v5}, Ljxl/write/biff/SelectionRecord;-><init>(Ljxl/write/biff/SelectionRecord$PaneType;II)V

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_21
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getHorizontalFreeze()I

    move-result v1

    if-eqz v1, :cond_22

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getVerticalFreeze()I

    move-result v1

    if-eqz v1, :cond_22

    new-instance v1, Ljxl/write/biff/SelectionRecord;

    sget-object v2, Ljxl/write/biff/SelectionRecord;->lowerRight:Ljxl/write/biff/SelectionRecord$PaneType;

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v3}, Ljxl/SheetSettings;->getHorizontalFreeze()I

    move-result v3

    iget-object v5, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v5}, Ljxl/SheetSettings;->getVerticalFreeze()I

    move-result v5

    invoke-direct {v1, v2, v3, v5}, Ljxl/write/biff/SelectionRecord;-><init>(Ljxl/write/biff/SelectionRecord$PaneType;II)V

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_22
    new-instance v1, Ljxl/write/biff/Weird1Record;

    invoke-direct {v1}, Ljxl/write/biff/Weird1Record;-><init>()V

    goto/16 :goto_b

    :goto_d
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v1}, Ljxl/SheetSettings;->getZoomFactor()I

    move-result v1

    if-eq v1, v6, :cond_23

    new-instance v1, Ljxl/write/biff/SCLRecord;

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->settings:Ljxl/SheetSettings;

    invoke-virtual {v2}, Ljxl/SheetSettings;->getZoomFactor()I

    move-result v2

    invoke-direct {v1, v2}, Ljxl/write/biff/SCLRecord;-><init>(I)V

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_23
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->mergedCells:Ljxl/write/biff/MergedCells;

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v1, v2}, Ljxl/write/biff/MergedCells;->write(Ljxl/write/biff/File;)V

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->hyperlinks:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_e
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_24

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/WritableHyperlink;

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    goto :goto_e

    :cond_24
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    if-eqz v1, :cond_25

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_25
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->dataValidation:Ljxl/biff/DataValidation;

    if-nez v1, :cond_26

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->validatedCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_27

    :cond_26
    invoke-direct {p0}, Ljxl/write/biff/SheetWriter;->writeDataValidation()V

    :cond_27
    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->conditionalFormats:Ljava/util/ArrayList;

    if-eqz v1, :cond_28

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_28

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->conditionalFormats:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_f
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_28

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/biff/ConditionalFormat;

    iget-object v3, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v3}, Ljxl/biff/ConditionalFormat;->write(Ljxl/write/biff/File;)V

    goto :goto_f

    :cond_28
    new-instance v1, Ljxl/write/biff/EOFRecord;

    invoke-direct {v1}, Ljxl/write/biff/EOFRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/write/biff/SheetWriter;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v4}, Ljxl/write/biff/IndexRecord;->getData()[B

    move-result-object v2

    add-int/lit8 v0, v0, 0x4

    invoke-virtual {v1, v2, v0}, Ljxl/write/biff/File;->setData([BI)V

    return-void
.end method
