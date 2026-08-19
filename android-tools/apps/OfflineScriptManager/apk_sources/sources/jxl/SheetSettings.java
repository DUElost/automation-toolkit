package jxl;

import jxl.biff.SheetRangeImpl;
import jxl.common.Assert;
import jxl.format.PageOrder;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
/* loaded from: classes.dex */
public final class SheetSettings {
    private static final int DEFAULT_DEFAULT_COLUMN_WIDTH = 8;
    public static final int DEFAULT_DEFAULT_ROW_HEIGHT = 255;
    private static final double DEFAULT_FOOTER_MARGIN = 0.5d;
    private static final double DEFAULT_HEADER_MARGIN = 0.5d;
    private static final double DEFAULT_HEIGHT_MARGIN = 1.0d;
    private static final int DEFAULT_NORMAL_MAGNIFICATION = 100;
    private static final int DEFAULT_PAGE_BREAK_PREVIEW_MAGNIFICATION = 60;
    private static final int DEFAULT_PRINT_RESOLUTION = 300;
    private static final double DEFAULT_WIDTH_MARGIN = 0.75d;
    private static final int DEFAULT_ZOOM_FACTOR = 100;
    private boolean automaticFormulaCalculation;
    private double bottomMargin;
    private int copies;
    private int defaultColumnWidth;
    private int defaultRowHeight;
    private boolean displayZeroValues;
    private int fitHeight;
    private boolean fitToPages;
    private int fitWidth;
    private HeaderFooter footer;
    private double footerMargin;
    private HeaderFooter header;
    private double headerMargin;
    private boolean hidden;
    private boolean horizontalCentre;
    private int horizontalFreeze;
    private int horizontalPrintResolution;
    private double leftMargin;
    private int normalMagnification;
    private PageOrientation orientation;
    private int pageBreakPreviewMagnification;
    private boolean pageBreakPreviewMode;
    private PageOrder pageOrder;
    private int pageStart;
    private PaperSize paperSize;
    private String password;
    private int passwordHash;
    private Range printArea;
    private boolean printGridLines;
    private boolean printHeaders;
    private Range printTitlesCol;
    private Range printTitlesRow;
    private boolean recalculateFormulasBeforeSave;
    private double rightMargin;
    private int scaleFactor;
    private boolean selected;
    private Sheet sheet;
    private boolean sheetProtected;
    private boolean showGridLines;
    private double topMargin;
    private boolean verticalCentre;
    private int verticalFreeze;
    private int verticalPrintResolution;
    private int zoomFactor;
    private static final PageOrientation DEFAULT_ORIENTATION = PageOrientation.PORTRAIT;
    private static final PageOrder DEFAULT_ORDER = PageOrder.RIGHT_THEN_DOWN;
    private static final PaperSize DEFAULT_PAPER_SIZE = PaperSize.A4;

    public SheetSettings(Sheet sheet) {
        this.sheet = sheet;
        this.orientation = DEFAULT_ORIENTATION;
        this.pageOrder = DEFAULT_ORDER;
        this.paperSize = DEFAULT_PAPER_SIZE;
        this.sheetProtected = false;
        this.hidden = false;
        this.selected = false;
        this.headerMargin = 0.5d;
        this.footerMargin = 0.5d;
        this.horizontalPrintResolution = DEFAULT_PRINT_RESOLUTION;
        this.verticalPrintResolution = DEFAULT_PRINT_RESOLUTION;
        this.leftMargin = DEFAULT_WIDTH_MARGIN;
        this.rightMargin = DEFAULT_WIDTH_MARGIN;
        this.topMargin = DEFAULT_HEIGHT_MARGIN;
        this.bottomMargin = DEFAULT_HEIGHT_MARGIN;
        this.fitToPages = false;
        this.showGridLines = true;
        this.printGridLines = false;
        this.printHeaders = false;
        this.pageBreakPreviewMode = false;
        this.displayZeroValues = true;
        this.defaultColumnWidth = 8;
        this.defaultRowHeight = DEFAULT_DEFAULT_ROW_HEIGHT;
        this.zoomFactor = 100;
        this.pageBreakPreviewMagnification = 60;
        this.normalMagnification = 100;
        this.horizontalFreeze = 0;
        this.verticalFreeze = 0;
        this.copies = 1;
        this.header = new HeaderFooter();
        this.footer = new HeaderFooter();
        this.automaticFormulaCalculation = true;
        this.recalculateFormulasBeforeSave = true;
    }

    public SheetSettings(SheetSettings sheetSettings, Sheet sheet) {
        Assert.verify(sheetSettings != null);
        this.sheet = sheet;
        this.orientation = sheetSettings.orientation;
        this.pageOrder = sheetSettings.pageOrder;
        this.paperSize = sheetSettings.paperSize;
        this.sheetProtected = sheetSettings.sheetProtected;
        this.hidden = sheetSettings.hidden;
        this.selected = false;
        this.headerMargin = sheetSettings.headerMargin;
        this.footerMargin = sheetSettings.footerMargin;
        this.scaleFactor = sheetSettings.scaleFactor;
        this.pageStart = sheetSettings.pageStart;
        this.fitWidth = sheetSettings.fitWidth;
        this.fitHeight = sheetSettings.fitHeight;
        this.horizontalPrintResolution = sheetSettings.horizontalPrintResolution;
        this.verticalPrintResolution = sheetSettings.verticalPrintResolution;
        this.leftMargin = sheetSettings.leftMargin;
        this.rightMargin = sheetSettings.rightMargin;
        this.topMargin = sheetSettings.topMargin;
        this.bottomMargin = sheetSettings.bottomMargin;
        this.fitToPages = sheetSettings.fitToPages;
        this.password = sheetSettings.password;
        this.passwordHash = sheetSettings.passwordHash;
        this.defaultColumnWidth = sheetSettings.defaultColumnWidth;
        this.defaultRowHeight = sheetSettings.defaultRowHeight;
        this.zoomFactor = sheetSettings.zoomFactor;
        this.pageBreakPreviewMagnification = sheetSettings.pageBreakPreviewMagnification;
        this.normalMagnification = sheetSettings.normalMagnification;
        this.showGridLines = sheetSettings.showGridLines;
        this.displayZeroValues = sheetSettings.displayZeroValues;
        this.pageBreakPreviewMode = sheetSettings.pageBreakPreviewMode;
        this.horizontalFreeze = sheetSettings.horizontalFreeze;
        this.verticalFreeze = sheetSettings.verticalFreeze;
        this.horizontalCentre = sheetSettings.horizontalCentre;
        this.verticalCentre = sheetSettings.verticalCentre;
        this.copies = sheetSettings.copies;
        this.header = new HeaderFooter(sheetSettings.header);
        this.footer = new HeaderFooter(sheetSettings.footer);
        this.automaticFormulaCalculation = sheetSettings.automaticFormulaCalculation;
        this.recalculateFormulasBeforeSave = sheetSettings.recalculateFormulasBeforeSave;
        if (sheetSettings.printArea != null) {
            this.printArea = new SheetRangeImpl(this.sheet, sheetSettings.getPrintArea().getTopLeft().getColumn(), sheetSettings.getPrintArea().getTopLeft().getRow(), sheetSettings.getPrintArea().getBottomRight().getColumn(), sheetSettings.getPrintArea().getBottomRight().getRow());
        }
        if (sheetSettings.printTitlesRow != null) {
            this.printTitlesRow = new SheetRangeImpl(this.sheet, sheetSettings.getPrintTitlesRow().getTopLeft().getColumn(), sheetSettings.getPrintTitlesRow().getTopLeft().getRow(), sheetSettings.getPrintTitlesRow().getBottomRight().getColumn(), sheetSettings.getPrintTitlesRow().getBottomRight().getRow());
        }
        if (sheetSettings.printTitlesCol != null) {
            this.printTitlesCol = new SheetRangeImpl(this.sheet, sheetSettings.getPrintTitlesCol().getTopLeft().getColumn(), sheetSettings.getPrintTitlesCol().getTopLeft().getRow(), sheetSettings.getPrintTitlesCol().getBottomRight().getColumn(), sheetSettings.getPrintTitlesCol().getBottomRight().getRow());
        }
    }

    public boolean getAutomaticFormulaCalculation() {
        return this.automaticFormulaCalculation;
    }

    public double getBottomMargin() {
        return this.bottomMargin;
    }

    public int getCopies() {
        return this.copies;
    }

    public int getDefaultColumnWidth() {
        return this.defaultColumnWidth;
    }

    public double getDefaultHeightMargin() {
        return DEFAULT_HEIGHT_MARGIN;
    }

    public int getDefaultRowHeight() {
        return this.defaultRowHeight;
    }

    public double getDefaultWidthMargin() {
        return DEFAULT_WIDTH_MARGIN;
    }

    public boolean getDisplayZeroValues() {
        return this.displayZeroValues;
    }

    public int getFitHeight() {
        return this.fitHeight;
    }

    public boolean getFitToPages() {
        return this.fitToPages;
    }

    public int getFitWidth() {
        return this.fitWidth;
    }

    public HeaderFooter getFooter() {
        return this.footer;
    }

    public double getFooterMargin() {
        return this.footerMargin;
    }

    public HeaderFooter getHeader() {
        return this.header;
    }

    public double getHeaderMargin() {
        return this.headerMargin;
    }

    public int getHorizontalFreeze() {
        return this.horizontalFreeze;
    }

    public int getHorizontalPrintResolution() {
        return this.horizontalPrintResolution;
    }

    public double getLeftMargin() {
        return this.leftMargin;
    }

    public int getNormalMagnification() {
        return this.normalMagnification;
    }

    public PageOrientation getOrientation() {
        return this.orientation;
    }

    public int getPageBreakPreviewMagnification() {
        return this.pageBreakPreviewMagnification;
    }

    public boolean getPageBreakPreviewMode() {
        return this.pageBreakPreviewMode;
    }

    public PageOrder getPageOrder() {
        return this.pageOrder;
    }

    public int getPageStart() {
        return this.pageStart;
    }

    public PaperSize getPaperSize() {
        return this.paperSize;
    }

    public String getPassword() {
        return this.password;
    }

    public int getPasswordHash() {
        return this.passwordHash;
    }

    public Range getPrintArea() {
        return this.printArea;
    }

    public boolean getPrintGridLines() {
        return this.printGridLines;
    }

    public boolean getPrintHeaders() {
        return this.printHeaders;
    }

    public Range getPrintTitlesCol() {
        return this.printTitlesCol;
    }

    public Range getPrintTitlesRow() {
        return this.printTitlesRow;
    }

    public boolean getRecalculateFormulasBeforeSave() {
        return this.recalculateFormulasBeforeSave;
    }

    public double getRightMargin() {
        return this.rightMargin;
    }

    public int getScaleFactor() {
        return this.scaleFactor;
    }

    public boolean getShowGridLines() {
        return this.showGridLines;
    }

    public double getTopMargin() {
        return this.topMargin;
    }

    public int getVerticalFreeze() {
        return this.verticalFreeze;
    }

    public int getVerticalPrintResolution() {
        return this.verticalPrintResolution;
    }

    public int getZoomFactor() {
        return this.zoomFactor;
    }

    public boolean isHidden() {
        return this.hidden;
    }

    public boolean isHorizontalCentre() {
        return this.horizontalCentre;
    }

    public boolean isProtected() {
        return this.sheetProtected;
    }

    public boolean isSelected() {
        return this.selected;
    }

    public boolean isVerticalCentre() {
        return this.verticalCentre;
    }

    public void setAutomaticFormulaCalculation(boolean z) {
        this.automaticFormulaCalculation = z;
    }

    public void setBottomMargin(double d2) {
        this.bottomMargin = d2;
    }

    public void setCopies(int i) {
        this.copies = i;
    }

    public void setDefaultColumnWidth(int i) {
        this.defaultColumnWidth = i;
    }

    public void setDefaultRowHeight(int i) {
        this.defaultRowHeight = i;
    }

    public void setDisplayZeroValues(boolean z) {
        this.displayZeroValues = z;
    }

    public void setFitHeight(int i) {
        this.fitHeight = i;
        this.fitToPages = true;
    }

    public void setFitToPages(boolean z) {
        this.fitToPages = z;
    }

    public void setFitWidth(int i) {
        this.fitWidth = i;
        this.fitToPages = true;
    }

    public void setFooter(HeaderFooter headerFooter) {
        this.footer = headerFooter;
    }

    public void setFooterMargin(double d2) {
        this.footerMargin = d2;
    }

    public void setHeader(HeaderFooter headerFooter) {
        this.header = headerFooter;
    }

    public void setHeaderMargin(double d2) {
        this.headerMargin = d2;
    }

    public void setHidden(boolean z) {
        this.hidden = z;
    }

    public void setHorizontalCentre(boolean z) {
        this.horizontalCentre = z;
    }

    public void setHorizontalFreeze(int i) {
        this.horizontalFreeze = Math.max(i, 0);
    }

    public void setHorizontalPrintResolution(int i) {
        this.horizontalPrintResolution = i;
    }

    public void setLeftMargin(double d2) {
        this.leftMargin = d2;
    }

    public void setNormalMagnification(int i) {
        this.normalMagnification = i;
    }

    public void setOrientation(PageOrientation pageOrientation) {
        this.orientation = pageOrientation;
    }

    public void setPageBreakPreviewMagnification(int i) {
        this.pageBreakPreviewMagnification = i;
    }

    public void setPageBreakPreviewMode(boolean z) {
        this.pageBreakPreviewMode = z;
    }

    public void setPageOrder(PageOrder pageOrder) {
        this.pageOrder = pageOrder;
    }

    public void setPageStart(int i) {
        this.pageStart = i;
    }

    public void setPaperSize(PaperSize paperSize) {
        this.paperSize = paperSize;
    }

    public void setPassword(String str) {
        this.password = str;
    }

    public void setPasswordHash(int i) {
        this.passwordHash = i;
    }

    public void setPrintArea(int i, int i2, int i3, int i4) {
        this.printArea = new SheetRangeImpl(this.sheet, i, i2, i3, i4);
    }

    public void setPrintGridLines(boolean z) {
        this.printGridLines = z;
    }

    public void setPrintHeaders(boolean z) {
        this.printHeaders = z;
    }

    public void setPrintTitles(int i, int i2, int i3, int i4) {
        setPrintTitlesRow(i, i2);
        setPrintTitlesCol(i3, i4);
    }

    public void setPrintTitlesCol(int i, int i2) {
        this.printTitlesCol = new SheetRangeImpl(this.sheet, i, 0, i2, 65535);
    }

    public void setPrintTitlesRow(int i, int i2) {
        this.printTitlesRow = new SheetRangeImpl(this.sheet, 0, i, DEFAULT_DEFAULT_ROW_HEIGHT, i2);
    }

    public void setProtected(boolean z) {
        this.sheetProtected = z;
    }

    public void setRecalculateFormulasBeforeSave(boolean z) {
        this.recalculateFormulasBeforeSave = z;
    }

    public void setRightMargin(double d2) {
        this.rightMargin = d2;
    }

    public void setScaleFactor(int i) {
        this.scaleFactor = i;
        this.fitToPages = false;
    }

    public void setSelected() {
        setSelected(true);
    }

    public void setSelected(boolean z) {
        this.selected = z;
    }

    public void setShowGridLines(boolean z) {
        this.showGridLines = z;
    }

    public void setTopMargin(double d2) {
        this.topMargin = d2;
    }

    public void setVerticalCentre(boolean z) {
        this.verticalCentre = z;
    }

    public void setVerticalFreeze(int i) {
        this.verticalFreeze = Math.max(i, 0);
    }

    public void setVerticalPrintResolution(int i) {
        this.verticalPrintResolution = i;
    }

    public void setZoomFactor(int i) {
        this.zoomFactor = i;
    }
}
