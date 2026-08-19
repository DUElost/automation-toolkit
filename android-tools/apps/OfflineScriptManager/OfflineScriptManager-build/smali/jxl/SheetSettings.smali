.class public final Ljxl/SheetSettings;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final DEFAULT_DEFAULT_COLUMN_WIDTH:I = 0x8

.field public static final DEFAULT_DEFAULT_ROW_HEIGHT:I = 0xff

.field private static final DEFAULT_FOOTER_MARGIN:D = 0.5

.field private static final DEFAULT_HEADER_MARGIN:D = 0.5

.field private static final DEFAULT_HEIGHT_MARGIN:D = 1.0

.field private static final DEFAULT_NORMAL_MAGNIFICATION:I = 0x64

.field private static final DEFAULT_ORDER:Ljxl/format/PageOrder;

.field private static final DEFAULT_ORIENTATION:Ljxl/format/PageOrientation;

.field private static final DEFAULT_PAGE_BREAK_PREVIEW_MAGNIFICATION:I = 0x3c

.field private static final DEFAULT_PAPER_SIZE:Ljxl/format/PaperSize;

.field private static final DEFAULT_PRINT_RESOLUTION:I = 0x12c

.field private static final DEFAULT_WIDTH_MARGIN:D = 0.75

.field private static final DEFAULT_ZOOM_FACTOR:I = 0x64


# instance fields
.field private automaticFormulaCalculation:Z

.field private bottomMargin:D

.field private copies:I

.field private defaultColumnWidth:I

.field private defaultRowHeight:I

.field private displayZeroValues:Z

.field private fitHeight:I

.field private fitToPages:Z

.field private fitWidth:I

.field private footer:Ljxl/HeaderFooter;

.field private footerMargin:D

.field private header:Ljxl/HeaderFooter;

.field private headerMargin:D

.field private hidden:Z

.field private horizontalCentre:Z

.field private horizontalFreeze:I

.field private horizontalPrintResolution:I

.field private leftMargin:D

.field private normalMagnification:I

.field private orientation:Ljxl/format/PageOrientation;

.field private pageBreakPreviewMagnification:I

.field private pageBreakPreviewMode:Z

.field private pageOrder:Ljxl/format/PageOrder;

.field private pageStart:I

.field private paperSize:Ljxl/format/PaperSize;

.field private password:Ljava/lang/String;

.field private passwordHash:I

.field private printArea:Ljxl/Range;

.field private printGridLines:Z

.field private printHeaders:Z

.field private printTitlesCol:Ljxl/Range;

.field private printTitlesRow:Ljxl/Range;

.field private recalculateFormulasBeforeSave:Z

.field private rightMargin:D

.field private scaleFactor:I

.field private selected:Z

.field private sheet:Ljxl/Sheet;

.field private sheetProtected:Z

.field private showGridLines:Z

.field private topMargin:D

.field private verticalCentre:Z

.field private verticalFreeze:I

.field private verticalPrintResolution:I

.field private zoomFactor:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/format/PageOrientation;->PORTRAIT:Ljxl/format/PageOrientation;

    sput-object v0, Ljxl/SheetSettings;->DEFAULT_ORIENTATION:Ljxl/format/PageOrientation;

    sget-object v0, Ljxl/format/PageOrder;->RIGHT_THEN_DOWN:Ljxl/format/PageOrder;

    sput-object v0, Ljxl/SheetSettings;->DEFAULT_ORDER:Ljxl/format/PageOrder;

    sget-object v0, Ljxl/format/PaperSize;->A4:Ljxl/format/PaperSize;

    sput-object v0, Ljxl/SheetSettings;->DEFAULT_PAPER_SIZE:Ljxl/format/PaperSize;

    return-void
.end method

.method public constructor <init>(Ljxl/Sheet;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    sget-object p1, Ljxl/SheetSettings;->DEFAULT_ORIENTATION:Ljxl/format/PageOrientation;

    iput-object p1, p0, Ljxl/SheetSettings;->orientation:Ljxl/format/PageOrientation;

    sget-object p1, Ljxl/SheetSettings;->DEFAULT_ORDER:Ljxl/format/PageOrder;

    iput-object p1, p0, Ljxl/SheetSettings;->pageOrder:Ljxl/format/PageOrder;

    sget-object p1, Ljxl/SheetSettings;->DEFAULT_PAPER_SIZE:Ljxl/format/PaperSize;

    iput-object p1, p0, Ljxl/SheetSettings;->paperSize:Ljxl/format/PaperSize;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/SheetSettings;->sheetProtected:Z

    iput-boolean p1, p0, Ljxl/SheetSettings;->hidden:Z

    iput-boolean p1, p0, Ljxl/SheetSettings;->selected:Z

    const-wide/high16 v0, 0x3fe0000000000000L    # 0.5

    iput-wide v0, p0, Ljxl/SheetSettings;->headerMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->footerMargin:D

    const/16 v0, 0x12c

    iput v0, p0, Ljxl/SheetSettings;->horizontalPrintResolution:I

    iput v0, p0, Ljxl/SheetSettings;->verticalPrintResolution:I

    const-wide/high16 v0, 0x3fe8000000000000L    # 0.75

    iput-wide v0, p0, Ljxl/SheetSettings;->leftMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->rightMargin:D

    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    iput-wide v0, p0, Ljxl/SheetSettings;->topMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->bottomMargin:D

    iput-boolean p1, p0, Ljxl/SheetSettings;->fitToPages:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/SheetSettings;->showGridLines:Z

    iput-boolean p1, p0, Ljxl/SheetSettings;->printGridLines:Z

    iput-boolean p1, p0, Ljxl/SheetSettings;->printHeaders:Z

    iput-boolean p1, p0, Ljxl/SheetSettings;->pageBreakPreviewMode:Z

    iput-boolean v0, p0, Ljxl/SheetSettings;->displayZeroValues:Z

    const/16 v1, 0x8

    iput v1, p0, Ljxl/SheetSettings;->defaultColumnWidth:I

    const/16 v1, 0xff

    iput v1, p0, Ljxl/SheetSettings;->defaultRowHeight:I

    const/16 v1, 0x64

    iput v1, p0, Ljxl/SheetSettings;->zoomFactor:I

    const/16 v2, 0x3c

    iput v2, p0, Ljxl/SheetSettings;->pageBreakPreviewMagnification:I

    iput v1, p0, Ljxl/SheetSettings;->normalMagnification:I

    iput p1, p0, Ljxl/SheetSettings;->horizontalFreeze:I

    iput p1, p0, Ljxl/SheetSettings;->verticalFreeze:I

    iput v0, p0, Ljxl/SheetSettings;->copies:I

    new-instance p1, Ljxl/HeaderFooter;

    invoke-direct {p1}, Ljxl/HeaderFooter;-><init>()V

    iput-object p1, p0, Ljxl/SheetSettings;->header:Ljxl/HeaderFooter;

    new-instance p1, Ljxl/HeaderFooter;

    invoke-direct {p1}, Ljxl/HeaderFooter;-><init>()V

    iput-object p1, p0, Ljxl/SheetSettings;->footer:Ljxl/HeaderFooter;

    iput-boolean v0, p0, Ljxl/SheetSettings;->automaticFormulaCalculation:Z

    iput-boolean v0, p0, Ljxl/SheetSettings;->recalculateFormulasBeforeSave:Z

    return-void
.end method

.method public constructor <init>(Ljxl/SheetSettings;Ljxl/Sheet;)V
    .locals 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iput-object p2, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    iget-object p2, p1, Ljxl/SheetSettings;->orientation:Ljxl/format/PageOrientation;

    iput-object p2, p0, Ljxl/SheetSettings;->orientation:Ljxl/format/PageOrientation;

    iget-object p2, p1, Ljxl/SheetSettings;->pageOrder:Ljxl/format/PageOrder;

    iput-object p2, p0, Ljxl/SheetSettings;->pageOrder:Ljxl/format/PageOrder;

    iget-object p2, p1, Ljxl/SheetSettings;->paperSize:Ljxl/format/PaperSize;

    iput-object p2, p0, Ljxl/SheetSettings;->paperSize:Ljxl/format/PaperSize;

    iget-boolean p2, p1, Ljxl/SheetSettings;->sheetProtected:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->sheetProtected:Z

    iget-boolean p2, p1, Ljxl/SheetSettings;->hidden:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->hidden:Z

    iput-boolean v0, p0, Ljxl/SheetSettings;->selected:Z

    iget-wide v0, p1, Ljxl/SheetSettings;->headerMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->headerMargin:D

    iget-wide v0, p1, Ljxl/SheetSettings;->footerMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->footerMargin:D

    iget p2, p1, Ljxl/SheetSettings;->scaleFactor:I

    iput p2, p0, Ljxl/SheetSettings;->scaleFactor:I

    iget p2, p1, Ljxl/SheetSettings;->pageStart:I

    iput p2, p0, Ljxl/SheetSettings;->pageStart:I

    iget p2, p1, Ljxl/SheetSettings;->fitWidth:I

    iput p2, p0, Ljxl/SheetSettings;->fitWidth:I

    iget p2, p1, Ljxl/SheetSettings;->fitHeight:I

    iput p2, p0, Ljxl/SheetSettings;->fitHeight:I

    iget p2, p1, Ljxl/SheetSettings;->horizontalPrintResolution:I

    iput p2, p0, Ljxl/SheetSettings;->horizontalPrintResolution:I

    iget p2, p1, Ljxl/SheetSettings;->verticalPrintResolution:I

    iput p2, p0, Ljxl/SheetSettings;->verticalPrintResolution:I

    iget-wide v0, p1, Ljxl/SheetSettings;->leftMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->leftMargin:D

    iget-wide v0, p1, Ljxl/SheetSettings;->rightMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->rightMargin:D

    iget-wide v0, p1, Ljxl/SheetSettings;->topMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->topMargin:D

    iget-wide v0, p1, Ljxl/SheetSettings;->bottomMargin:D

    iput-wide v0, p0, Ljxl/SheetSettings;->bottomMargin:D

    iget-boolean p2, p1, Ljxl/SheetSettings;->fitToPages:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->fitToPages:Z

    iget-object p2, p1, Ljxl/SheetSettings;->password:Ljava/lang/String;

    iput-object p2, p0, Ljxl/SheetSettings;->password:Ljava/lang/String;

    iget p2, p1, Ljxl/SheetSettings;->passwordHash:I

    iput p2, p0, Ljxl/SheetSettings;->passwordHash:I

    iget p2, p1, Ljxl/SheetSettings;->defaultColumnWidth:I

    iput p2, p0, Ljxl/SheetSettings;->defaultColumnWidth:I

    iget p2, p1, Ljxl/SheetSettings;->defaultRowHeight:I

    iput p2, p0, Ljxl/SheetSettings;->defaultRowHeight:I

    iget p2, p1, Ljxl/SheetSettings;->zoomFactor:I

    iput p2, p0, Ljxl/SheetSettings;->zoomFactor:I

    iget p2, p1, Ljxl/SheetSettings;->pageBreakPreviewMagnification:I

    iput p2, p0, Ljxl/SheetSettings;->pageBreakPreviewMagnification:I

    iget p2, p1, Ljxl/SheetSettings;->normalMagnification:I

    iput p2, p0, Ljxl/SheetSettings;->normalMagnification:I

    iget-boolean p2, p1, Ljxl/SheetSettings;->showGridLines:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->showGridLines:Z

    iget-boolean p2, p1, Ljxl/SheetSettings;->displayZeroValues:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->displayZeroValues:Z

    iget-boolean p2, p1, Ljxl/SheetSettings;->pageBreakPreviewMode:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->pageBreakPreviewMode:Z

    iget p2, p1, Ljxl/SheetSettings;->horizontalFreeze:I

    iput p2, p0, Ljxl/SheetSettings;->horizontalFreeze:I

    iget p2, p1, Ljxl/SheetSettings;->verticalFreeze:I

    iput p2, p0, Ljxl/SheetSettings;->verticalFreeze:I

    iget-boolean p2, p1, Ljxl/SheetSettings;->horizontalCentre:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->horizontalCentre:Z

    iget-boolean p2, p1, Ljxl/SheetSettings;->verticalCentre:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->verticalCentre:Z

    iget p2, p1, Ljxl/SheetSettings;->copies:I

    iput p2, p0, Ljxl/SheetSettings;->copies:I

    new-instance p2, Ljxl/HeaderFooter;

    iget-object v0, p1, Ljxl/SheetSettings;->header:Ljxl/HeaderFooter;

    invoke-direct {p2, v0}, Ljxl/HeaderFooter;-><init>(Ljxl/HeaderFooter;)V

    iput-object p2, p0, Ljxl/SheetSettings;->header:Ljxl/HeaderFooter;

    new-instance p2, Ljxl/HeaderFooter;

    iget-object v0, p1, Ljxl/SheetSettings;->footer:Ljxl/HeaderFooter;

    invoke-direct {p2, v0}, Ljxl/HeaderFooter;-><init>(Ljxl/HeaderFooter;)V

    iput-object p2, p0, Ljxl/SheetSettings;->footer:Ljxl/HeaderFooter;

    iget-boolean p2, p1, Ljxl/SheetSettings;->automaticFormulaCalculation:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->automaticFormulaCalculation:Z

    iget-boolean p2, p1, Ljxl/SheetSettings;->recalculateFormulasBeforeSave:Z

    iput-boolean p2, p0, Ljxl/SheetSettings;->recalculateFormulasBeforeSave:Z

    iget-object p2, p1, Ljxl/SheetSettings;->printArea:Ljxl/Range;

    if-eqz p2, :cond_1

    new-instance p2, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintArea()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v2

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintArea()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getRow()I

    move-result v3

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintArea()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v4

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintArea()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getRow()I

    move-result v5

    move-object v0, p2

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p2, p0, Ljxl/SheetSettings;->printArea:Ljxl/Range;

    :cond_1
    iget-object p2, p1, Ljxl/SheetSettings;->printTitlesRow:Ljxl/Range;

    if-eqz p2, :cond_2

    new-instance p2, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesRow()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v2

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesRow()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getRow()I

    move-result v3

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesRow()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v4

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesRow()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getRow()I

    move-result v5

    move-object v0, p2

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p2, p0, Ljxl/SheetSettings;->printTitlesRow:Ljxl/Range;

    :cond_2
    iget-object p2, p1, Ljxl/SheetSettings;->printTitlesCol:Ljxl/Range;

    if-eqz p2, :cond_3

    new-instance p2, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesCol()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v2

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesCol()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getRow()I

    move-result v3

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesCol()Ljxl/Range;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getColumn()I

    move-result v4

    invoke-virtual {p1}, Ljxl/SheetSettings;->getPrintTitlesCol()Ljxl/Range;

    move-result-object p1

    invoke-interface {p1}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object p1

    invoke-interface {p1}, Ljxl/Cell;->getRow()I

    move-result v5

    move-object v0, p2

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p2, p0, Ljxl/SheetSettings;->printTitlesCol:Ljxl/Range;

    :cond_3
    return-void
.end method


# virtual methods
.method public getAutomaticFormulaCalculation()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->automaticFormulaCalculation:Z

    return v0
.end method

.method public getBottomMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/SheetSettings;->bottomMargin:D

    return-wide v0
.end method

.method public getCopies()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->copies:I

    return v0
.end method

.method public getDefaultColumnWidth()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->defaultColumnWidth:I

    return v0
.end method

.method public getDefaultHeightMargin()D
    .locals 2

    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    return-wide v0
.end method

.method public getDefaultRowHeight()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->defaultRowHeight:I

    return v0
.end method

.method public getDefaultWidthMargin()D
    .locals 2

    const-wide/high16 v0, 0x3fe8000000000000L    # 0.75

    return-wide v0
.end method

.method public getDisplayZeroValues()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->displayZeroValues:Z

    return v0
.end method

.method public getFitHeight()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->fitHeight:I

    return v0
.end method

.method public getFitToPages()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->fitToPages:Z

    return v0
.end method

.method public getFitWidth()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->fitWidth:I

    return v0
.end method

.method public getFooter()Ljxl/HeaderFooter;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->footer:Ljxl/HeaderFooter;

    return-object v0
.end method

.method public getFooterMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/SheetSettings;->footerMargin:D

    return-wide v0
.end method

.method public getHeader()Ljxl/HeaderFooter;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->header:Ljxl/HeaderFooter;

    return-object v0
.end method

.method public getHeaderMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/SheetSettings;->headerMargin:D

    return-wide v0
.end method

.method public getHorizontalFreeze()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->horizontalFreeze:I

    return v0
.end method

.method public getHorizontalPrintResolution()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->horizontalPrintResolution:I

    return v0
.end method

.method public getLeftMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/SheetSettings;->leftMargin:D

    return-wide v0
.end method

.method public getNormalMagnification()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->normalMagnification:I

    return v0
.end method

.method public getOrientation()Ljxl/format/PageOrientation;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->orientation:Ljxl/format/PageOrientation;

    return-object v0
.end method

.method public getPageBreakPreviewMagnification()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->pageBreakPreviewMagnification:I

    return v0
.end method

.method public getPageBreakPreviewMode()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->pageBreakPreviewMode:Z

    return v0
.end method

.method public getPageOrder()Ljxl/format/PageOrder;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->pageOrder:Ljxl/format/PageOrder;

    return-object v0
.end method

.method public getPageStart()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->pageStart:I

    return v0
.end method

.method public getPaperSize()Ljxl/format/PaperSize;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->paperSize:Ljxl/format/PaperSize;

    return-object v0
.end method

.method public getPassword()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->password:Ljava/lang/String;

    return-object v0
.end method

.method public getPasswordHash()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->passwordHash:I

    return v0
.end method

.method public getPrintArea()Ljxl/Range;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->printArea:Ljxl/Range;

    return-object v0
.end method

.method public getPrintGridLines()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->printGridLines:Z

    return v0
.end method

.method public getPrintHeaders()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->printHeaders:Z

    return v0
.end method

.method public getPrintTitlesCol()Ljxl/Range;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->printTitlesCol:Ljxl/Range;

    return-object v0
.end method

.method public getPrintTitlesRow()Ljxl/Range;
    .locals 1

    iget-object v0, p0, Ljxl/SheetSettings;->printTitlesRow:Ljxl/Range;

    return-object v0
.end method

.method public getRecalculateFormulasBeforeSave()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->recalculateFormulasBeforeSave:Z

    return v0
.end method

.method public getRightMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/SheetSettings;->rightMargin:D

    return-wide v0
.end method

.method public getScaleFactor()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->scaleFactor:I

    return v0
.end method

.method public getShowGridLines()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->showGridLines:Z

    return v0
.end method

.method public getTopMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/SheetSettings;->topMargin:D

    return-wide v0
.end method

.method public getVerticalFreeze()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->verticalFreeze:I

    return v0
.end method

.method public getVerticalPrintResolution()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->verticalPrintResolution:I

    return v0
.end method

.method public getZoomFactor()I
    .locals 1

    iget v0, p0, Ljxl/SheetSettings;->zoomFactor:I

    return v0
.end method

.method public isHidden()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->hidden:Z

    return v0
.end method

.method public isHorizontalCentre()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->horizontalCentre:Z

    return v0
.end method

.method public isProtected()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->sheetProtected:Z

    return v0
.end method

.method public isSelected()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->selected:Z

    return v0
.end method

.method public isVerticalCentre()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/SheetSettings;->verticalCentre:Z

    return v0
.end method

.method public setAutomaticFormulaCalculation(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->automaticFormulaCalculation:Z

    return-void
.end method

.method public setBottomMargin(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/SheetSettings;->bottomMargin:D

    return-void
.end method

.method public setCopies(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->copies:I

    return-void
.end method

.method public setDefaultColumnWidth(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->defaultColumnWidth:I

    return-void
.end method

.method public setDefaultRowHeight(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->defaultRowHeight:I

    return-void
.end method

.method public setDisplayZeroValues(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->displayZeroValues:Z

    return-void
.end method

.method public setFitHeight(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->fitHeight:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/SheetSettings;->fitToPages:Z

    return-void
.end method

.method public setFitToPages(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->fitToPages:Z

    return-void
.end method

.method public setFitWidth(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->fitWidth:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/SheetSettings;->fitToPages:Z

    return-void
.end method

.method public setFooter(Ljxl/HeaderFooter;)V
    .locals 0

    iput-object p1, p0, Ljxl/SheetSettings;->footer:Ljxl/HeaderFooter;

    return-void
.end method

.method public setFooterMargin(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/SheetSettings;->footerMargin:D

    return-void
.end method

.method public setHeader(Ljxl/HeaderFooter;)V
    .locals 0

    iput-object p1, p0, Ljxl/SheetSettings;->header:Ljxl/HeaderFooter;

    return-void
.end method

.method public setHeaderMargin(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/SheetSettings;->headerMargin:D

    return-void
.end method

.method public setHidden(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->hidden:Z

    return-void
.end method

.method public setHorizontalCentre(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->horizontalCentre:Z

    return-void
.end method

.method public setHorizontalFreeze(I)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p1, v0}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ljxl/SheetSettings;->horizontalFreeze:I

    return-void
.end method

.method public setHorizontalPrintResolution(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->horizontalPrintResolution:I

    return-void
.end method

.method public setLeftMargin(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/SheetSettings;->leftMargin:D

    return-void
.end method

.method public setNormalMagnification(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->normalMagnification:I

    return-void
.end method

.method public setOrientation(Ljxl/format/PageOrientation;)V
    .locals 0

    iput-object p1, p0, Ljxl/SheetSettings;->orientation:Ljxl/format/PageOrientation;

    return-void
.end method

.method public setPageBreakPreviewMagnification(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->pageBreakPreviewMagnification:I

    return-void
.end method

.method public setPageBreakPreviewMode(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->pageBreakPreviewMode:Z

    return-void
.end method

.method public setPageOrder(Ljxl/format/PageOrder;)V
    .locals 0

    iput-object p1, p0, Ljxl/SheetSettings;->pageOrder:Ljxl/format/PageOrder;

    return-void
.end method

.method public setPageStart(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->pageStart:I

    return-void
.end method

.method public setPaperSize(Ljxl/format/PaperSize;)V
    .locals 0

    iput-object p1, p0, Ljxl/SheetSettings;->paperSize:Ljxl/format/PaperSize;

    return-void
.end method

.method public setPassword(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Ljxl/SheetSettings;->password:Ljava/lang/String;

    return-void
.end method

.method public setPasswordHash(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->passwordHash:I

    return-void
.end method

.method public setPrintArea(IIII)V
    .locals 7

    new-instance v6, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    move-object v0, v6

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object v6, p0, Ljxl/SheetSettings;->printArea:Ljxl/Range;

    return-void
.end method

.method public setPrintGridLines(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->printGridLines:Z

    return-void
.end method

.method public setPrintHeaders(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->printHeaders:Z

    return-void
.end method

.method public setPrintTitles(IIII)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Ljxl/SheetSettings;->setPrintTitlesRow(II)V

    invoke-virtual {p0, p3, p4}, Ljxl/SheetSettings;->setPrintTitlesCol(II)V

    return-void
.end method

.method public setPrintTitlesCol(II)V
    .locals 7

    new-instance v6, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    const/4 v3, 0x0

    const v5, 0xffff

    move-object v0, v6

    move v2, p1

    move v4, p2

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object v6, p0, Ljxl/SheetSettings;->printTitlesCol:Ljxl/Range;

    return-void
.end method

.method public setPrintTitlesRow(II)V
    .locals 7

    new-instance v6, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/SheetSettings;->sheet:Ljxl/Sheet;

    const/4 v2, 0x0

    const/16 v4, 0xff

    move-object v0, v6

    move v3, p1

    move v5, p2

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object v6, p0, Ljxl/SheetSettings;->printTitlesRow:Ljxl/Range;

    return-void
.end method

.method public setProtected(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->sheetProtected:Z

    return-void
.end method

.method public setRecalculateFormulasBeforeSave(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->recalculateFormulasBeforeSave:Z

    return-void
.end method

.method public setRightMargin(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/SheetSettings;->rightMargin:D

    return-void
.end method

.method public setScaleFactor(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->scaleFactor:I

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/SheetSettings;->fitToPages:Z

    return-void
.end method

.method public setSelected()V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ljxl/SheetSettings;->setSelected(Z)V

    return-void
.end method

.method public setSelected(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->selected:Z

    return-void
.end method

.method public setShowGridLines(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->showGridLines:Z

    return-void
.end method

.method public setTopMargin(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/SheetSettings;->topMargin:D

    return-void
.end method

.method public setVerticalCentre(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/SheetSettings;->verticalCentre:Z

    return-void
.end method

.method public setVerticalFreeze(I)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p1, v0}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ljxl/SheetSettings;->verticalFreeze:I

    return-void
.end method

.method public setVerticalPrintResolution(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->verticalPrintResolution:I

    return-void
.end method

.method public setZoomFactor(I)V
    .locals 0

    iput p1, p0, Ljxl/SheetSettings;->zoomFactor:I

    return-void
.end method
