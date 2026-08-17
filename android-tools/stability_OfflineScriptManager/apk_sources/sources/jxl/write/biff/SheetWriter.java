package jxl.write.biff;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeSet;
import jxl.Cell;
import jxl.Range;
import jxl.SheetSettings;
import jxl.WorkbookSettings;
import jxl.biff.AutoFilter;
import jxl.biff.ByteData;
import jxl.biff.ConditionalFormat;
import jxl.biff.DataValidation;
import jxl.biff.DataValiditySettingsRecord;
import jxl.biff.WorkspaceInformationRecord;
import jxl.biff.XFRecord;
import jxl.biff.drawing.Chart;
import jxl.biff.drawing.SheetDrawingWriter;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Blank;
import jxl.write.WritableCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableHyperlink;
import jxl.write.WriteException;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class SheetWriter {
    static /* synthetic */ Class class$jxl$write$biff$SheetWriter;
    private static Logger logger;
    private AutoFilter autoFilter;
    private ButtonPropertySetRecord buttonPropertySet;
    private ArrayList columnBreaks;
    private TreeSet columnFormats;
    private ArrayList conditionalFormats;
    private DataValidation dataValidation;
    private SheetDrawingWriter drawingWriter;
    private FooterRecord footer;
    private HeaderRecord header;
    private ArrayList hyperlinks;
    private int maxColumnOutlineLevel;
    private int maxRowOutlineLevel;
    private MergedCells mergedCells;
    private int numCols;
    private int numRows;
    private File outputFile;
    private PLSRecord plsRecord;
    private ArrayList rowBreaks;
    private RowRecord[] rows;
    private SheetSettings settings;
    private WritableSheetImpl sheet;
    private ArrayList validatedCells;
    private WorkbookSettings workbookSettings;
    private WorkspaceInformationRecord workspaceOptions = new WorkspaceInformationRecord();
    private boolean chartOnly = false;

    static {
        Class cls = class$jxl$write$biff$SheetWriter;
        if (cls == null) {
            cls = class$("jxl.write.biff.SheetWriter");
            class$jxl$write$biff$SheetWriter = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public SheetWriter(File file, WritableSheetImpl writableSheetImpl, WorkbookSettings workbookSettings) {
        this.outputFile = file;
        this.sheet = writableSheetImpl;
        this.workbookSettings = workbookSettings;
        this.drawingWriter = new SheetDrawingWriter(workbookSettings);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private Cell[] getColumn(int i) {
        int i2 = this.numRows - 1;
        boolean z = false;
        while (i2 >= 0 && !z) {
            RowRecord[] rowRecordArr = this.rows;
            if (rowRecordArr[i2] == null || rowRecordArr[i2].getCell(i) == null) {
                i2--;
            } else {
                z = true;
            }
        }
        Cell[] cellArr = new Cell[i2 + 1];
        for (int i3 = 0; i3 <= i2; i3++) {
            RowRecord[] rowRecordArr2 = this.rows;
            cellArr[i3] = rowRecordArr2[i3] != null ? rowRecordArr2[i3].getCell(i) : null;
        }
        return cellArr;
    }

    private void writeDataValidation() {
        if (this.dataValidation == null || this.validatedCells.size() != 0) {
            if (this.dataValidation != null || this.validatedCells.size() <= 0) {
                Iterator it = this.validatedCells.iterator();
                while (it.hasNext()) {
                    this.dataValidation.add(new DataValiditySettingsRecord(((CellValue) it.next()).getCellFeatures().getDVParser()));
                }
            } else {
                this.dataValidation = new DataValidation(this.sheet.getComboBox() != null ? this.sheet.getComboBox().getObjectId() : -1, this.sheet.getWorkbook(), this.sheet.getWorkbook(), this.workbookSettings);
                Iterator it2 = this.validatedCells.iterator();
                while (it2.hasNext()) {
                    this.dataValidation.add(new DataValiditySettingsRecord(((CellValue) it2.next()).getCellFeatures().getDVParser()));
                }
            }
        }
        this.dataValidation.write(this.outputFile);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void checkMergedBorders() {
        Range[] mergedCells = this.mergedCells.getMergedCells();
        ArrayList arrayList = new ArrayList();
        for (Range range : mergedCells) {
            Cell topLeft = range.getTopLeft();
            XFRecord xFRecord = (XFRecord) topLeft.getCellFormat();
            if (xFRecord != null && xFRecord.hasBorders() && !xFRecord.isRead()) {
                try {
                    CellXFRecord cellXFRecord = new CellXFRecord(xFRecord);
                    Cell bottomRight = range.getBottomRight();
                    Border border = Border.ALL;
                    BorderLineStyle borderLineStyle = BorderLineStyle.NONE;
                    Colour colour = Colour.BLACK;
                    cellXFRecord.setBorder(border, borderLineStyle, colour);
                    Border border2 = Border.LEFT;
                    cellXFRecord.setBorder(border2, xFRecord.getBorderLine(border2), xFRecord.getBorderColour(border2));
                    Border border3 = Border.TOP;
                    cellXFRecord.setBorder(border3, xFRecord.getBorderLine(border3), xFRecord.getBorderColour(border3));
                    if (topLeft.getRow() == bottomRight.getRow()) {
                        Border border4 = Border.BOTTOM;
                        cellXFRecord.setBorder(border4, xFRecord.getBorderLine(border4), xFRecord.getBorderColour(border4));
                    }
                    if (topLeft.getColumn() == bottomRight.getColumn()) {
                        Border border5 = Border.RIGHT;
                        cellXFRecord.setBorder(border5, xFRecord.getBorderLine(border5), xFRecord.getBorderColour(border5));
                    }
                    int indexOf = arrayList.indexOf(cellXFRecord);
                    if (indexOf != -1) {
                        cellXFRecord = (CellXFRecord) arrayList.get(indexOf);
                    } else {
                        arrayList.add(cellXFRecord);
                    }
                    ((WritableCell) topLeft).setCellFormat(cellXFRecord);
                    if (bottomRight.getRow() > topLeft.getRow()) {
                        if (bottomRight.getColumn() != topLeft.getColumn()) {
                            CellXFRecord cellXFRecord2 = new CellXFRecord(xFRecord);
                            cellXFRecord2.setBorder(border, borderLineStyle, colour);
                            cellXFRecord2.setBorder(border2, xFRecord.getBorderLine(border2), xFRecord.getBorderColour(border2));
                            Border border6 = Border.BOTTOM;
                            cellXFRecord2.setBorder(border6, xFRecord.getBorderLine(border6), xFRecord.getBorderColour(border6));
                            int indexOf2 = arrayList.indexOf(cellXFRecord2);
                            if (indexOf2 != -1) {
                                cellXFRecord2 = (CellXFRecord) arrayList.get(indexOf2);
                            } else {
                                arrayList.add(cellXFRecord2);
                            }
                            this.sheet.addCell(new Blank(topLeft.getColumn(), bottomRight.getRow(), cellXFRecord2));
                        }
                        for (int row = topLeft.getRow() + 1; row < bottomRight.getRow(); row++) {
                            CellXFRecord cellXFRecord3 = new CellXFRecord(xFRecord);
                            cellXFRecord3.setBorder(Border.ALL, BorderLineStyle.NONE, Colour.BLACK);
                            Border border7 = Border.LEFT;
                            cellXFRecord3.setBorder(border7, xFRecord.getBorderLine(border7), xFRecord.getBorderColour(border7));
                            if (topLeft.getColumn() == bottomRight.getColumn()) {
                                Border border8 = Border.RIGHT;
                                cellXFRecord3.setBorder(border8, xFRecord.getBorderLine(border8), xFRecord.getBorderColour(border8));
                            }
                            int indexOf3 = arrayList.indexOf(cellXFRecord3);
                            if (indexOf3 != -1) {
                                cellXFRecord3 = (CellXFRecord) arrayList.get(indexOf3);
                            } else {
                                arrayList.add(cellXFRecord3);
                            }
                            this.sheet.addCell(new Blank(topLeft.getColumn(), row, cellXFRecord3));
                        }
                    }
                    if (bottomRight.getColumn() > topLeft.getColumn()) {
                        if (bottomRight.getRow() != topLeft.getRow()) {
                            CellXFRecord cellXFRecord4 = new CellXFRecord(xFRecord);
                            cellXFRecord4.setBorder(Border.ALL, BorderLineStyle.NONE, Colour.BLACK);
                            Border border9 = Border.RIGHT;
                            cellXFRecord4.setBorder(border9, xFRecord.getBorderLine(border9), xFRecord.getBorderColour(border9));
                            Border border10 = Border.TOP;
                            cellXFRecord4.setBorder(border10, xFRecord.getBorderLine(border10), xFRecord.getBorderColour(border10));
                            int indexOf4 = arrayList.indexOf(cellXFRecord4);
                            if (indexOf4 != -1) {
                                cellXFRecord4 = (CellXFRecord) arrayList.get(indexOf4);
                            } else {
                                arrayList.add(cellXFRecord4);
                            }
                            this.sheet.addCell(new Blank(bottomRight.getColumn(), topLeft.getRow(), cellXFRecord4));
                        }
                        for (int row2 = topLeft.getRow() + 1; row2 < bottomRight.getRow(); row2++) {
                            CellXFRecord cellXFRecord5 = new CellXFRecord(xFRecord);
                            cellXFRecord5.setBorder(Border.ALL, BorderLineStyle.NONE, Colour.BLACK);
                            Border border11 = Border.RIGHT;
                            cellXFRecord5.setBorder(border11, xFRecord.getBorderLine(border11), xFRecord.getBorderColour(border11));
                            int indexOf5 = arrayList.indexOf(cellXFRecord5);
                            if (indexOf5 != -1) {
                                cellXFRecord5 = (CellXFRecord) arrayList.get(indexOf5);
                            } else {
                                arrayList.add(cellXFRecord5);
                            }
                            this.sheet.addCell(new Blank(bottomRight.getColumn(), row2, cellXFRecord5));
                        }
                        for (int column = topLeft.getColumn() + 1; column < bottomRight.getColumn(); column++) {
                            CellXFRecord cellXFRecord6 = new CellXFRecord(xFRecord);
                            cellXFRecord6.setBorder(Border.ALL, BorderLineStyle.NONE, Colour.BLACK);
                            Border border12 = Border.TOP;
                            cellXFRecord6.setBorder(border12, xFRecord.getBorderLine(border12), xFRecord.getBorderColour(border12));
                            if (topLeft.getRow() == bottomRight.getRow()) {
                                Border border13 = Border.BOTTOM;
                                cellXFRecord6.setBorder(border13, xFRecord.getBorderLine(border13), xFRecord.getBorderColour(border13));
                            }
                            int indexOf6 = arrayList.indexOf(cellXFRecord6);
                            if (indexOf6 != -1) {
                                cellXFRecord6 = (CellXFRecord) arrayList.get(indexOf6);
                            } else {
                                arrayList.add(cellXFRecord6);
                            }
                            this.sheet.addCell(new Blank(column, topLeft.getRow(), cellXFRecord6));
                        }
                    }
                    if (bottomRight.getColumn() > topLeft.getColumn() || bottomRight.getRow() > topLeft.getRow()) {
                        CellXFRecord cellXFRecord7 = new CellXFRecord(xFRecord);
                        cellXFRecord7.setBorder(Border.ALL, BorderLineStyle.NONE, Colour.BLACK);
                        Border border14 = Border.RIGHT;
                        cellXFRecord7.setBorder(border14, xFRecord.getBorderLine(border14), xFRecord.getBorderColour(border14));
                        Border border15 = Border.BOTTOM;
                        cellXFRecord7.setBorder(border15, xFRecord.getBorderLine(border15), xFRecord.getBorderColour(border15));
                        if (bottomRight.getRow() == topLeft.getRow()) {
                            Border border16 = Border.TOP;
                            cellXFRecord7.setBorder(border16, xFRecord.getBorderLine(border16), xFRecord.getBorderColour(border16));
                        }
                        if (bottomRight.getColumn() == topLeft.getColumn()) {
                            Border border17 = Border.LEFT;
                            cellXFRecord7.setBorder(border17, xFRecord.getBorderLine(border17), xFRecord.getBorderColour(border17));
                        }
                        int indexOf7 = arrayList.indexOf(cellXFRecord7);
                        if (indexOf7 != -1) {
                            cellXFRecord7 = (CellXFRecord) arrayList.get(indexOf7);
                        } else {
                            arrayList.add(cellXFRecord7);
                        }
                        this.sheet.addCell(new Blank(bottomRight.getColumn(), bottomRight.getRow(), cellXFRecord7));
                        for (int column2 = topLeft.getColumn() + 1; column2 < bottomRight.getColumn(); column2++) {
                            CellXFRecord cellXFRecord8 = new CellXFRecord(xFRecord);
                            cellXFRecord8.setBorder(Border.ALL, BorderLineStyle.NONE, Colour.BLACK);
                            Border border18 = Border.BOTTOM;
                            cellXFRecord8.setBorder(border18, xFRecord.getBorderLine(border18), xFRecord.getBorderColour(border18));
                            if (topLeft.getRow() == bottomRight.getRow()) {
                                Border border19 = Border.TOP;
                                cellXFRecord8.setBorder(border19, xFRecord.getBorderLine(border19), xFRecord.getBorderColour(border19));
                            }
                            int indexOf8 = arrayList.indexOf(cellXFRecord8);
                            if (indexOf8 != -1) {
                                cellXFRecord8 = (CellXFRecord) arrayList.get(indexOf8);
                            } else {
                                arrayList.add(cellXFRecord8);
                            }
                            this.sheet.addCell(new Blank(column2, bottomRight.getRow(), cellXFRecord8));
                        }
                    }
                } catch (WriteException e) {
                    logger.warn(e.toString());
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Chart[] getCharts() {
        return this.drawingWriter.getCharts();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final FooterRecord getFooter() {
        return this.footer;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final HeaderRecord getHeader() {
        return this.header;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public WorkspaceInformationRecord getWorkspaceOptions() {
        return this.workspaceOptions;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setAutoFilter(AutoFilter autoFilter) {
        this.autoFilter = autoFilter;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setButtonPropertySet(ButtonPropertySetRecord buttonPropertySetRecord) {
        this.buttonPropertySet = buttonPropertySetRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setChartOnly() {
        this.chartOnly = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setCharts(Chart[] chartArr) {
        this.drawingWriter.setCharts(chartArr);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setConditionalFormats(ArrayList arrayList) {
        this.conditionalFormats = arrayList;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDataValidation(DataValidation dataValidation, ArrayList arrayList) {
        this.dataValidation = dataValidation;
        this.validatedCells = arrayList;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDimensions(int i, int i2) {
        this.numRows = i;
        this.numCols = i2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDrawings(ArrayList arrayList, boolean z) {
        this.drawingWriter.setDrawings(arrayList, z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setPLS(PLSRecord pLSRecord) {
        this.plsRecord = pLSRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setSettings(SheetSettings sheetSettings) {
        this.settings = sheetSettings;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWorkspaceOptions(WorkspaceInformationRecord workspaceInformationRecord) {
        if (workspaceInformationRecord != null) {
            this.workspaceOptions = workspaceInformationRecord;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWriteData(RowRecord[] rowRecordArr, ArrayList arrayList, ArrayList arrayList2, ArrayList arrayList3, MergedCells mergedCells, TreeSet treeSet, int i, int i2) {
        this.rows = rowRecordArr;
        this.rowBreaks = arrayList;
        this.columnBreaks = arrayList2;
        this.hyperlinks = arrayList3;
        this.mergedCells = mergedCells;
        this.columnFormats = treeSet;
        this.maxRowOutlineLevel = i;
        this.maxColumnOutlineLevel = i2;
    }

    public void write() {
        ByteData weird1Record;
        int i;
        PasswordRecord passwordRecord;
        Assert.verify(this.rows != null);
        if (this.chartOnly) {
            this.drawingWriter.write(this.outputFile);
            return;
        }
        this.outputFile.write(new BOFRecord(BOFRecord.sheet));
        int i2 = this.numRows;
        int i3 = i2 / 32;
        if (i2 - (i3 * 32) != 0) {
            i3++;
        }
        int pos = this.outputFile.getPos();
        IndexRecord indexRecord = new IndexRecord(0, this.numRows, i3);
        this.outputFile.write(indexRecord);
        this.outputFile.write(this.settings.getAutomaticFormulaCalculation() ? new CalcModeRecord(CalcModeRecord.automatic) : new CalcModeRecord(CalcModeRecord.manual));
        this.outputFile.write(new CalcCountRecord(100));
        this.outputFile.write(new RefModeRecord());
        this.outputFile.write(new IterationRecord(false));
        this.outputFile.write(new DeltaRecord(0.001d));
        this.outputFile.write(new SaveRecalcRecord(this.settings.getRecalculateFormulasBeforeSave()));
        this.outputFile.write(new PrintHeadersRecord(this.settings.getPrintHeaders()));
        this.outputFile.write(new PrintGridLinesRecord(this.settings.getPrintGridLines()));
        this.outputFile.write(new GridSetRecord(true));
        GuttersRecord guttersRecord = new GuttersRecord();
        guttersRecord.setMaxColumnOutline(this.maxColumnOutlineLevel + 1);
        guttersRecord.setMaxRowOutline(this.maxRowOutlineLevel + 1);
        this.outputFile.write(guttersRecord);
        this.outputFile.write(new DefaultRowHeightRecord(this.settings.getDefaultRowHeight(), this.settings.getDefaultRowHeight() != 255));
        if (this.maxRowOutlineLevel > 0) {
            this.workspaceOptions.setRowOutlines(true);
        }
        if (this.maxColumnOutlineLevel > 0) {
            this.workspaceOptions.setColumnOutlines(true);
        }
        this.workspaceOptions.setFitToPages(this.settings.getFitToPages());
        this.outputFile.write(this.workspaceOptions);
        if (this.rowBreaks.size() > 0) {
            int size = this.rowBreaks.size();
            int[] iArr = new int[size];
            for (int i4 = 0; i4 < size; i4++) {
                iArr[i4] = ((Integer) this.rowBreaks.get(i4)).intValue();
            }
            this.outputFile.write(new HorizontalPageBreaksRecord(iArr));
        }
        if (this.columnBreaks.size() > 0) {
            int size2 = this.columnBreaks.size();
            int[] iArr2 = new int[size2];
            for (int i5 = 0; i5 < size2; i5++) {
                iArr2[i5] = ((Integer) this.columnBreaks.get(i5)).intValue();
            }
            this.outputFile.write(new VerticalPageBreaksRecord(iArr2));
        }
        this.outputFile.write(new HeaderRecord(this.settings.getHeader().toString()));
        this.outputFile.write(new FooterRecord(this.settings.getFooter().toString()));
        this.outputFile.write(new HorizontalCentreRecord(this.settings.isHorizontalCentre()));
        this.outputFile.write(new VerticalCentreRecord(this.settings.isVerticalCentre()));
        if (this.settings.getLeftMargin() != this.settings.getDefaultWidthMargin()) {
            this.outputFile.write(new LeftMarginRecord(this.settings.getLeftMargin()));
        }
        if (this.settings.getRightMargin() != this.settings.getDefaultWidthMargin()) {
            this.outputFile.write(new RightMarginRecord(this.settings.getRightMargin()));
        }
        if (this.settings.getTopMargin() != this.settings.getDefaultHeightMargin()) {
            this.outputFile.write(new TopMarginRecord(this.settings.getTopMargin()));
        }
        if (this.settings.getBottomMargin() != this.settings.getDefaultHeightMargin()) {
            this.outputFile.write(new BottomMarginRecord(this.settings.getBottomMargin()));
        }
        PLSRecord pLSRecord = this.plsRecord;
        if (pLSRecord != null) {
            this.outputFile.write(pLSRecord);
        }
        this.outputFile.write(new SetupRecord(this.settings));
        if (this.settings.isProtected()) {
            this.outputFile.write(new ProtectRecord(this.settings.isProtected()));
            this.outputFile.write(new ScenarioProtectRecord(this.settings.isProtected()));
            this.outputFile.write(new ObjectProtectRecord(this.settings.isProtected()));
            if (this.settings.getPassword() != null) {
                passwordRecord = new PasswordRecord(this.settings.getPassword());
            } else if (this.settings.getPasswordHash() != 0) {
                passwordRecord = new PasswordRecord(this.settings.getPasswordHash());
            }
            this.outputFile.write(passwordRecord);
        }
        indexRecord.setDataStartPosition(this.outputFile.getPos());
        this.outputFile.write(new DefaultColumnWidth(this.settings.getDefaultColumnWidth()));
        WritableCellFormat normalStyle = this.sheet.getWorkbook().getStyles().getNormalStyle();
        WritableCellFormat defaultDateFormat = this.sheet.getWorkbook().getStyles().getDefaultDateFormat();
        Iterator it = this.columnFormats.iterator();
        while (it.hasNext()) {
            ColumnInfoRecord columnInfoRecord = (ColumnInfoRecord) it.next();
            if (columnInfoRecord.getColumn() < 256) {
                this.outputFile.write(columnInfoRecord);
            }
            XFRecord cellFormat = columnInfoRecord.getCellFormat();
            if (cellFormat != normalStyle && columnInfoRecord.getColumn() < 256) {
                Cell[] column = getColumn(columnInfoRecord.getColumn());
                for (int i6 = 0; i6 < column.length; i6++) {
                    if (column[i6] != null && (column[i6].getCellFormat() == normalStyle || column[i6].getCellFormat() == defaultDateFormat)) {
                        ((WritableCell) column[i6]).setCellFormat(cellFormat);
                    }
                }
            }
        }
        AutoFilter autoFilter = this.autoFilter;
        if (autoFilter != null) {
            autoFilter.write(this.outputFile);
        }
        this.outputFile.write(new DimensionRecord(this.numRows, this.numCols));
        for (int i7 = 0; i7 < i3; i7++) {
            DBCellRecord dBCellRecord = new DBCellRecord(this.outputFile.getPos());
            int i8 = i7 * 32;
            int min = Math.min(32, this.numRows - i8);
            boolean z = true;
            int i9 = i8;
            while (true) {
                i = i8 + min;
                if (i9 >= i) {
                    break;
                }
                RowRecord[] rowRecordArr = this.rows;
                if (rowRecordArr[i9] != null) {
                    rowRecordArr[i9].write(this.outputFile);
                    if (z) {
                        dBCellRecord.setCellOffset(this.outputFile.getPos());
                        z = false;
                    }
                }
                i9++;
            }
            while (i8 < i) {
                if (this.rows[i8] != null) {
                    dBCellRecord.addCellRowPosition(this.outputFile.getPos());
                    this.rows[i8].writeCells(this.outputFile);
                }
                i8++;
            }
            indexRecord.addBlockPosition(this.outputFile.getPos());
            dBCellRecord.setPosition(this.outputFile.getPos());
            this.outputFile.write(dBCellRecord);
        }
        if (!this.workbookSettings.getDrawingsDisabled()) {
            this.drawingWriter.write(this.outputFile);
        }
        this.outputFile.write(new Window2Record(this.settings));
        if (this.settings.getHorizontalFreeze() == 0 && this.settings.getVerticalFreeze() == 0) {
            weird1Record = new SelectionRecord(SelectionRecord.upperLeft, 0, 0);
        } else {
            this.outputFile.write(new PaneRecord(this.settings.getHorizontalFreeze(), this.settings.getVerticalFreeze()));
            this.outputFile.write(new SelectionRecord(SelectionRecord.upperLeft, 0, 0));
            if (this.settings.getHorizontalFreeze() != 0) {
                this.outputFile.write(new SelectionRecord(SelectionRecord.upperRight, this.settings.getHorizontalFreeze(), 0));
            }
            if (this.settings.getVerticalFreeze() != 0) {
                this.outputFile.write(new SelectionRecord(SelectionRecord.lowerLeft, 0, this.settings.getVerticalFreeze()));
            }
            if (this.settings.getHorizontalFreeze() != 0 && this.settings.getVerticalFreeze() != 0) {
                this.outputFile.write(new SelectionRecord(SelectionRecord.lowerRight, this.settings.getHorizontalFreeze(), this.settings.getVerticalFreeze()));
            }
            weird1Record = new Weird1Record();
        }
        this.outputFile.write(weird1Record);
        if (this.settings.getZoomFactor() != 100) {
            this.outputFile.write(new SCLRecord(this.settings.getZoomFactor()));
        }
        this.mergedCells.write(this.outputFile);
        Iterator it2 = this.hyperlinks.iterator();
        while (it2.hasNext()) {
            this.outputFile.write((WritableHyperlink) it2.next());
        }
        ButtonPropertySetRecord buttonPropertySetRecord = this.buttonPropertySet;
        if (buttonPropertySetRecord != null) {
            this.outputFile.write(buttonPropertySetRecord);
        }
        if (this.dataValidation != null || this.validatedCells.size() > 0) {
            writeDataValidation();
        }
        ArrayList arrayList = this.conditionalFormats;
        if (arrayList != null && arrayList.size() > 0) {
            Iterator it3 = this.conditionalFormats.iterator();
            while (it3.hasNext()) {
                ((ConditionalFormat) it3.next()).write(this.outputFile);
            }
        }
        this.outputFile.write(new EOFRecord());
        this.outputFile.setData(indexRecord.getData(), pos + 4);
    }
}
