.class public abstract Ljxl/write/biff/CellValue;
.super Ljxl/biff/WritableRecordData;
.source ""

# interfaces
.implements Ljxl/write/WritableCell;


# static fields
.field static synthetic class$jxl$write$biff$CellValue:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private column:I

.field private copied:Z

.field private features:Ljxl/write/WritableCellFeatures;

.field private format:Ljxl/biff/XFRecord;

.field private formattingRecords:Ljxl/biff/FormattingRecords;

.field private referenced:Z

.field private row:I

.field private sheet:Ljxl/write/biff/WritableSheetImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/CellValue;->class$jxl$write$biff$CellValue:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.CellValue"

    invoke-static {v0}, Ljxl/write/biff/CellValue;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/CellValue;->class$jxl$write$biff$CellValue:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/CellValue;->logger:Ljxl/common/Logger;

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/Type;II)V
    .locals 1

    sget-object v0, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    invoke-direct {p0, p1, p2, p3, v0}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/format/CellFormat;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->copied:Z

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/Type;IILjxl/format/CellFormat;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p3, p0, Ljxl/write/biff/CellValue;->row:I

    iput p2, p0, Ljxl/write/biff/CellValue;->column:I

    check-cast p4, Ljxl/biff/XFRecord;

    iput-object p4, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->referenced:Z

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->copied:Z

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/Type;IILjxl/write/biff/CellValue;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p3, p0, Ljxl/write/biff/CellValue;->row:I

    iput p2, p0, Ljxl/write/biff/CellValue;->column:I

    iget-object p1, p4, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    iput-object p1, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->referenced:Z

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->copied:Z

    iget-object p1, p4, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-eqz p1, :cond_0

    new-instance p1, Ljxl/write/WritableCellFeatures;

    iget-object p2, p4, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-direct {p1, p2}, Ljxl/write/WritableCellFeatures;-><init>(Ljxl/CellFeatures;)V

    iput-object p1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {p1, p0}, Ljxl/biff/BaseCellFeatures;->setWritableCell(Ljxl/write/biff/CellValue;)V

    :cond_0
    return-void
.end method

.method protected constructor <init>(Ljxl/biff/Type;Ljxl/Cell;)V
    .locals 2

    invoke-interface {p2}, Ljxl/Cell;->getColumn()I

    move-result v0

    invoke-interface {p2}, Ljxl/Cell;->getRow()I

    move-result v1

    invoke-direct {p0, p1, v0, v1}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;II)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->copied:Z

    invoke-interface {p2}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object p1

    check-cast p1, Ljxl/biff/XFRecord;

    iput-object p1, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    invoke-interface {p2}, Ljxl/Cell;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object p1

    if-eqz p1, :cond_0

    new-instance p1, Ljxl/write/WritableCellFeatures;

    invoke-interface {p2}, Ljxl/Cell;->getCellFeatures()Ljxl/CellFeatures;

    move-result-object p2

    invoke-direct {p1, p2}, Ljxl/write/WritableCellFeatures;-><init>(Ljxl/CellFeatures;)V

    iput-object p1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {p1, p0}, Ljxl/biff/BaseCellFeatures;->setWritableCell(Ljxl/write/biff/CellValue;)V

    :cond_0
    return-void
.end method

.method private addCellFormat()V
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/write/biff/WritableWorkbookImpl;->getStyles()Ljxl/write/biff/Styles;

    move-result-object v0

    iget-object v1, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    invoke-virtual {v0, v1}, Ljxl/write/biff/Styles;->getFormat(Ljxl/biff/XFRecord;)Ljxl/biff/XFRecord;

    move-result-object v1

    iput-object v1, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    :try_start_0
    invoke-virtual {v1}, Ljxl/biff/XFRecord;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Ljxl/write/biff/CellValue;->formattingRecords:Ljxl/biff/FormattingRecords;

    iget-object v2, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    invoke-virtual {v1, v2}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V
    :try_end_0
    .catch Ljxl/biff/NumFormatRecordsException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    sget-object v1, Ljxl/write/biff/CellValue;->logger:Ljxl/common/Logger;

    const-string v2, "Maximum number of format records exceeded.  Using default format."

    invoke-virtual {v1, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljxl/write/biff/Styles;->getNormalStyle()Ljxl/write/WritableCellFormat;

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    :cond_0
    :goto_0
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
.method public final addCellFeatures()V
    .locals 10

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-boolean v1, p0, Ljxl/write/biff/CellValue;->copied:Z

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ne v1, v2, :cond_1

    iput-boolean v3, p0, Ljxl/write/biff/CellValue;->copied:Z

    return-void

    :cond_1
    invoke-virtual {v0}, Ljxl/CellFeatures;->getComment()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    new-instance v0, Ljxl/biff/drawing/Comment;

    iget-object v1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v1}, Ljxl/CellFeatures;->getComment()Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Ljxl/write/biff/CellValue;->column:I

    iget v4, p0, Ljxl/write/biff/CellValue;->row:I

    invoke-direct {v0, v1, v2, v4}, Ljxl/biff/drawing/Comment;-><init>(Ljava/lang/String;II)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v1}, Ljxl/biff/BaseCellFeatures;->getCommentWidth()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setWidth(D)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v1}, Ljxl/biff/BaseCellFeatures;->getCommentHeight()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setHeight(D)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1, v0}, Ljxl/write/biff/WritableSheetImpl;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/write/biff/WritableWorkbookImpl;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v1, v0}, Ljxl/biff/BaseCellFeatures;->setCommentDrawing(Ljxl/biff/drawing/Comment;)V

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->hasDataValidation()Z

    move-result v0

    if-eqz v0, :cond_5

    :try_start_0
    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->getDVParser()Ljxl/biff/DVParser;

    move-result-object v4

    iget v5, p0, Ljxl/write/biff/CellValue;->column:I

    iget v6, p0, Ljxl/write/biff/CellValue;->row:I

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v7

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v8

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getWorkbookSettings()Ljxl/WorkbookSettings;

    move-result-object v9

    invoke-virtual/range {v4 .. v9}, Ljxl/biff/DVParser;->setCell(IILjxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V
    :try_end_0
    .catch Ljxl/biff/formula/FormulaException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    :goto_0
    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0, p0}, Ljxl/write/biff/WritableSheetImpl;->addValidationCell(Ljxl/write/biff/CellValue;)V

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->hasDropDown()Z

    move-result v0

    if-nez v0, :cond_3

    return-void

    :cond_3
    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getComboBox()Ljxl/biff/drawing/ComboBox;

    move-result-object v0

    if-nez v0, :cond_4

    new-instance v0, Ljxl/biff/drawing/ComboBox;

    invoke-direct {v0}, Ljxl/biff/drawing/ComboBox;-><init>()V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1, v0}, Ljxl/write/biff/WritableSheetImpl;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1}, Ljxl/write/biff/WritableSheetImpl;->getWorkbook()Ljxl/write/biff/WritableWorkbookImpl;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/write/biff/WritableWorkbookImpl;->addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1, v0}, Ljxl/write/biff/WritableSheetImpl;->setComboBox(Ljxl/biff/drawing/ComboBox;)V

    :cond_4
    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    iget-object v1, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1}, Ljxl/write/biff/WritableSheetImpl;->getComboBox()Ljxl/biff/drawing/ComboBox;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljxl/biff/BaseCellFeatures;->setComboBox(Ljxl/biff/drawing/ComboBox;)V

    :cond_5
    return-void
.end method

.method columnInserted(Ljxl/Sheet;II)V
    .locals 0

    return-void
.end method

.method columnRemoved(Ljxl/Sheet;II)V
    .locals 0

    return-void
.end method

.method decrementColumn()V
    .locals 3

    iget v0, p0, Ljxl/write/biff/CellValue;->column:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/write/biff/CellValue;->column:I

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->getCommentDrawing()Ljxl/biff/drawing/Comment;

    move-result-object v0

    if-eqz v0, :cond_0

    iget v1, p0, Ljxl/write/biff/CellValue;->column:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setX(D)V

    iget v1, p0, Ljxl/write/biff/CellValue;->row:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setY(D)V

    :cond_0
    return-void
.end method

.method decrementRow()V
    .locals 3

    iget v0, p0, Ljxl/write/biff/CellValue;->row:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/write/biff/CellValue;->row:I

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->getCommentDrawing()Ljxl/biff/drawing/Comment;

    move-result-object v0

    if-eqz v0, :cond_0

    iget v1, p0, Ljxl/write/biff/CellValue;->column:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setX(D)V

    iget v1, p0, Ljxl/write/biff/CellValue;->row:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setY(D)V

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->hasDropDown()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Ljxl/write/biff/CellValue;->logger:Ljxl/common/Logger;

    const-string v1, "need to change value for drop down drawing"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_1
    return-void
.end method

.method public getCellFeatures()Ljxl/CellFeatures;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    return-object v0
.end method

.method public getCellFormat()Ljxl/format/CellFormat;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    return-object v0
.end method

.method public getColumn()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/CellValue;->column:I

    return v0
.end method

.method public getData()[B
    .locals 3

    const/4 v0, 0x6

    new-array v0, v0, [B

    iget v1, p0, Ljxl/write/biff/CellValue;->row:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/write/biff/CellValue;->column:I

    const/4 v2, 0x2

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v1, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    invoke-virtual {v1}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v1

    const/4 v2, 0x4

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v0
.end method

.method public getRow()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/CellValue;->row:I

    return v0
.end method

.method protected getSheet()Ljxl/write/biff/WritableSheetImpl;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    return-object v0
.end method

.method public getWritableCellFeatures()Ljxl/write/WritableCellFeatures;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    return-object v0
.end method

.method final getXFIndex()I
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    invoke-virtual {v0}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v0

    return v0
.end method

.method incrementColumn()V
    .locals 3

    iget v0, p0, Ljxl/write/biff/CellValue;->column:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/write/biff/CellValue;->column:I

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->getCommentDrawing()Ljxl/biff/drawing/Comment;

    move-result-object v0

    if-eqz v0, :cond_0

    iget v1, p0, Ljxl/write/biff/CellValue;->column:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setX(D)V

    iget v1, p0, Ljxl/write/biff/CellValue;->row:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setY(D)V

    :cond_0
    return-void
.end method

.method incrementRow()V
    .locals 3

    iget v0, p0, Ljxl/write/biff/CellValue;->row:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/write/biff/CellValue;->row:I

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/biff/BaseCellFeatures;->getCommentDrawing()Ljxl/biff/drawing/Comment;

    move-result-object v0

    if-eqz v0, :cond_0

    iget v1, p0, Ljxl/write/biff/CellValue;->column:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setX(D)V

    iget v1, p0, Ljxl/write/biff/CellValue;->row:I

    int-to-double v1, v1

    invoke-virtual {v0, v1, v2}, Ljxl/biff/drawing/Comment;->setY(D)V

    :cond_0
    return-void
.end method

.method public isHidden()Z
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    iget v1, p0, Ljxl/write/biff/CellValue;->column:I

    invoke-virtual {v0, v1}, Ljxl/write/biff/WritableSheetImpl;->getColumnInfo(I)Ljxl/write/biff/ColumnInfoRecord;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/write/biff/ColumnInfoRecord;->getWidth()I

    move-result v0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    iget v2, p0, Ljxl/write/biff/CellValue;->row:I

    invoke-virtual {v0, v2}, Ljxl/write/biff/WritableSheetImpl;->getRowInfo(I)Ljxl/write/biff/RowRecord;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljxl/write/biff/RowRecord;->getRowHeight()I

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Ljxl/write/biff/RowRecord;->isCollapsed()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    return v1

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method final isReferenced()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/write/biff/CellValue;->referenced:Z

    return v0
.end method

.method public final removeCellFeatures()V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Ljxl/write/WritableCellFeatures;->removeComment()V

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {v0}, Ljxl/write/WritableCellFeatures;->removeDataValidation()V

    return-void
.end method

.method public final removeComment(Ljxl/biff/drawing/Comment;)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0, p1}, Ljxl/write/biff/WritableSheetImpl;->removeDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V

    return-void
.end method

.method public final removeDataValidation()V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0, p0}, Ljxl/write/biff/WritableSheetImpl;->removeDataValidation(Ljxl/write/biff/CellValue;)V

    return-void
.end method

.method rowInserted(Ljxl/Sheet;II)V
    .locals 0

    return-void
.end method

.method rowRemoved(Ljxl/Sheet;II)V
    .locals 0

    return-void
.end method

.method setCellDetails(Ljxl/biff/FormattingRecords;Ljxl/write/biff/SharedStrings;Ljxl/write/biff/WritableSheetImpl;)V
    .locals 0

    const/4 p2, 0x1

    iput-boolean p2, p0, Ljxl/write/biff/CellValue;->referenced:Z

    iput-object p3, p0, Ljxl/write/biff/CellValue;->sheet:Ljxl/write/biff/WritableSheetImpl;

    iput-object p1, p0, Ljxl/write/biff/CellValue;->formattingRecords:Ljxl/biff/FormattingRecords;

    invoke-direct {p0}, Ljxl/write/biff/CellValue;->addCellFormat()V

    invoke-virtual {p0}, Ljxl/write/biff/CellValue;->addCellFeatures()V

    return-void
.end method

.method public setCellFeatures(Ljxl/write/WritableCellFeatures;)V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    if-eqz v0, :cond_0

    sget-object v0, Ljxl/write/biff/CellValue;->logger:Ljxl/common/Logger;

    const-string v1, "current cell features not null - overwriting"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_0
    iput-object p1, p0, Ljxl/write/biff/CellValue;->features:Ljxl/write/WritableCellFeatures;

    invoke-virtual {p1, p0}, Ljxl/biff/BaseCellFeatures;->setWritableCell(Ljxl/write/biff/CellValue;)V

    iget-boolean p1, p0, Ljxl/write/biff/CellValue;->referenced:Z

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Ljxl/write/biff/CellValue;->addCellFeatures()V

    :cond_1
    return-void
.end method

.method public setCellFormat(Ljxl/format/CellFormat;)V
    .locals 0

    check-cast p1, Ljxl/biff/XFRecord;

    iput-object p1, p0, Ljxl/write/biff/CellValue;->format:Ljxl/biff/XFRecord;

    iget-boolean p1, p0, Ljxl/write/biff/CellValue;->referenced:Z

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Ljxl/write/biff/CellValue;->formattingRecords:Ljxl/biff/FormattingRecords;

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    invoke-static {p1}, Ljxl/common/Assert;->verify(Z)V

    invoke-direct {p0}, Ljxl/write/biff/CellValue;->addCellFormat()V

    return-void
.end method

.method final setCopied(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/write/biff/CellValue;->copied:Z

    return-void
.end method
