package jxl.write.biff;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.TreeSet;
import jxl.BooleanCell;
import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Range;
import jxl.WorkbookSettings;
import jxl.biff.CellReferenceHelper;
import jxl.biff.DataValidation;
import jxl.biff.FormattingRecords;
import jxl.biff.FormulaData;
import jxl.biff.NumFormatRecordsException;
import jxl.biff.SheetRangeImpl;
import jxl.biff.WorkspaceInformationRecord;
import jxl.biff.XFRecord;
import jxl.biff.drawing.Drawing;
import jxl.biff.formula.FormulaException;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.CellFormat;
import jxl.write.Blank;
import jxl.write.Boolean;
import jxl.write.DateTime;
import jxl.write.Formula;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.WritableCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableHyperlink;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class WritableSheetCopier {
    static /* synthetic */ Class class$jxl$write$biff$SheetCopier;
    private static Logger logger;
    private boolean chartOnly = false;
    private HashMap fonts;
    private FormattingRecords formatRecords;
    private HashMap formats;
    private ButtonPropertySetRecord fromButtonPropertySet;
    private ArrayList fromColumnBreaks;
    private TreeSet fromColumnFormats;
    private DataValidation fromDataValidation;
    private ArrayList fromDrawings;
    private ArrayList fromHyperlinks;
    private MergedCells fromMergedCells;
    private PLSRecord fromPLSRecord;
    private ArrayList fromRowBreaks;
    private RowRecord[] fromRows;
    private WritableSheetImpl fromSheet;
    private WorkspaceInformationRecord fromWorkspaceOptions;
    private int maxColumnOutlineLevel;
    private int maxRowOutlineLevel;
    private int numRows;
    private SheetWriter sheetWriter;
    private ButtonPropertySetRecord toButtonPropertySet;
    private ArrayList toColumnBreaks;
    private TreeSet toColumnFormats;
    private DataValidation toDataValidation;
    private ArrayList toDrawings;
    private ArrayList toHyperlinks;
    private ArrayList toImages;
    private MergedCells toMergedCells;
    private PLSRecord toPLSRecord;
    private ArrayList toRowBreaks;
    private WritableSheetImpl toSheet;
    private WorkbookSettings workbookSettings;
    private HashMap xfRecords;

    static {
        Class cls = class$jxl$write$biff$SheetCopier;
        if (cls == null) {
            cls = class$("jxl.write.biff.SheetCopier");
            class$jxl$write$biff$SheetCopier = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public WritableSheetCopier(WritableSheet writableSheet, WritableSheet writableSheet2) {
        this.fromSheet = (WritableSheetImpl) writableSheet;
        WritableSheetImpl writableSheetImpl = (WritableSheetImpl) writableSheet2;
        this.toSheet = writableSheetImpl;
        this.workbookSettings = writableSheetImpl.getWorkbook().getSettings();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private WritableCellFormat copyCellFormat(CellFormat cellFormat) {
        try {
            XFRecord xFRecord = (XFRecord) cellFormat;
            WritableCellFormat writableCellFormat = new WritableCellFormat(xFRecord);
            this.formatRecords.addStyle(writableCellFormat);
            this.xfRecords.put(new Integer(xFRecord.getXFIndex()), writableCellFormat);
            this.fonts.put(new Integer(xFRecord.getFontIndex()), new Integer(writableCellFormat.getFontIndex()));
            this.formats.put(new Integer(xFRecord.getFormatRecord()), new Integer(writableCellFormat.getFormatRecord()));
            return writableCellFormat;
        } catch (NumFormatRecordsException unused) {
            logger.warn("Maximum number of format records exceeded.  Using default format.");
            return WritableWorkbook.NORMAL_STYLE;
        }
    }

    private WritableCell deepCopyCell(Cell cell) {
        WritableCell shallowCopyCell = shallowCopyCell(cell);
        if (shallowCopyCell == null) {
            return shallowCopyCell;
        }
        if (shallowCopyCell instanceof ReadFormulaRecord) {
            ReadFormulaRecord readFormulaRecord = (ReadFormulaRecord) shallowCopyCell;
            if (!readFormulaRecord.handleImportedCellReferences(this.fromSheet.getWorkbook(), this.fromSheet.getWorkbook(), this.workbookSettings)) {
                try {
                    Logger logger2 = logger;
                    StringBuffer stringBuffer = new StringBuffer();
                    stringBuffer.append("Formula ");
                    stringBuffer.append(readFormulaRecord.getFormula());
                    stringBuffer.append(" in cell ");
                    stringBuffer.append(CellReferenceHelper.getCellReference(cell.getColumn(), cell.getRow()));
                    stringBuffer.append(" cannot be imported because it references another ");
                    stringBuffer.append(" sheet from the source workbook");
                    logger2.warn(stringBuffer.toString());
                } catch (FormulaException e) {
                    Logger logger3 = logger;
                    StringBuffer stringBuffer2 = new StringBuffer();
                    stringBuffer2.append("Formula  in cell ");
                    stringBuffer2.append(CellReferenceHelper.getCellReference(cell.getColumn(), cell.getRow()));
                    stringBuffer2.append(" cannot be imported:  ");
                    stringBuffer2.append(e.getMessage());
                    logger3.warn(stringBuffer2.toString());
                }
                shallowCopyCell = new Formula(cell.getColumn(), cell.getRow(), "\"ERROR\"");
            }
        }
        CellFormat cellFormat = shallowCopyCell.getCellFormat();
        WritableCellFormat writableCellFormat = (WritableCellFormat) this.xfRecords.get(new Integer(((XFRecord) cellFormat).getXFIndex()));
        if (writableCellFormat == null) {
            writableCellFormat = copyCellFormat(cellFormat);
        }
        shallowCopyCell.setCellFormat(writableCellFormat);
        return shallowCopyCell;
    }

    private WritableCell shallowCopyCell(Cell cell) {
        CellType type = cell.getType();
        if (type == CellType.LABEL) {
            return new Label((LabelCell) cell);
        }
        if (type == CellType.NUMBER) {
            return new Number((NumberCell) cell);
        }
        if (type == CellType.DATE) {
            return new DateTime((DateCell) cell);
        }
        if (type == CellType.BOOLEAN) {
            return new Boolean((BooleanCell) cell);
        }
        if (type == CellType.NUMBER_FORMULA) {
            return new ReadNumberFormulaRecord((FormulaData) cell);
        }
        if (type == CellType.STRING_FORMULA) {
            return new ReadStringFormulaRecord((FormulaData) cell);
        }
        if (type == CellType.BOOLEAN_FORMULA) {
            return new ReadBooleanFormulaRecord((FormulaData) cell);
        }
        if (type == CellType.DATE_FORMULA) {
            return new ReadDateFormulaRecord((FormulaData) cell);
        }
        if (type == CellType.FORMULA_ERROR) {
            return new ReadErrorFormulaRecord((FormulaData) cell);
        }
        if (type != CellType.EMPTY || cell.getCellFormat() == null) {
            return null;
        }
        return new Blank(cell);
    }

    public void copySheet() {
        shallowCopyCells();
        Iterator it = this.fromColumnFormats.iterator();
        while (it.hasNext()) {
            this.toColumnFormats.add(new ColumnInfoRecord((ColumnInfoRecord) it.next()));
        }
        for (Range range : this.fromMergedCells.getMergedCells()) {
            this.toMergedCells.add(new SheetRangeImpl((SheetRangeImpl) range, this.toSheet));
        }
        int i = 0;
        while (true) {
            try {
                RowRecord[] rowRecordArr = this.fromRows;
                if (i >= rowRecordArr.length) {
                    break;
                }
                RowRecord rowRecord = rowRecordArr[i];
                if (rowRecord != null && (!rowRecord.isDefaultHeight() || rowRecord.isCollapsed())) {
                    this.toSheet.getRowRecord(i).setRowDetails(rowRecord.getRowHeight(), rowRecord.matchesDefaultFontHeight(), rowRecord.isCollapsed(), rowRecord.getOutlineLevel(), rowRecord.getGroupStart(), rowRecord.getStyle());
                }
                i++;
            } catch (RowsExceededException unused) {
                Assert.verify(false);
            }
        }
        this.toRowBreaks = new ArrayList(this.fromRowBreaks);
        this.toColumnBreaks = new ArrayList(this.fromColumnBreaks);
        if (this.fromDataValidation != null) {
            this.toDataValidation = new DataValidation(this.fromDataValidation, this.toSheet.getWorkbook(), this.toSheet.getWorkbook(), this.toSheet.getWorkbook().getSettings());
        }
        this.sheetWriter.setCharts(this.fromSheet.getCharts());
        Iterator it2 = this.fromDrawings.iterator();
        while (it2.hasNext()) {
            Object next = it2.next();
            if (next instanceof Drawing) {
                WritableImage writableImage = new WritableImage((Drawing) next, this.toSheet.getWorkbook().getDrawingGroup());
                this.toDrawings.add(writableImage);
                this.toImages.add(writableImage);
            }
        }
        this.sheetWriter.setWorkspaceOptions(this.fromWorkspaceOptions);
        if (this.fromPLSRecord != null) {
            this.toPLSRecord = new PLSRecord(this.fromPLSRecord);
        }
        if (this.fromButtonPropertySet != null) {
            this.toButtonPropertySet = new ButtonPropertySetRecord(this.fromButtonPropertySet);
        }
        Iterator it3 = this.fromHyperlinks.iterator();
        while (it3.hasNext()) {
            this.toHyperlinks.add(new WritableHyperlink((WritableHyperlink) it3.next(), this.toSheet));
        }
    }

    void deepCopyCells() {
        int rows = this.fromSheet.getRows();
        for (int i = 0; i < rows; i++) {
            for (Cell cell : this.fromSheet.getRow(i)) {
                WritableCell deepCopyCell = deepCopyCell(cell);
                if (deepCopyCell != null) {
                    try {
                        this.toSheet.addCell(deepCopyCell);
                    } catch (WriteException unused) {
                        Assert.verify(false);
                    }
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ButtonPropertySetRecord getButtonPropertySet() {
        return this.toButtonPropertySet;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DataValidation getDataValidation() {
        return this.toDataValidation;
    }

    public int getMaxColumnOutlineLevel() {
        return this.maxColumnOutlineLevel;
    }

    public int getMaxRowOutlineLevel() {
        return this.maxRowOutlineLevel;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public PLSRecord getPLSRecord() {
        return this.toPLSRecord;
    }

    boolean isChartOnly() {
        return this.chartOnly;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setButtonPropertySetRecord(ButtonPropertySetRecord buttonPropertySetRecord) {
        this.fromButtonPropertySet = buttonPropertySetRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setColumnBreaks(ArrayList arrayList, ArrayList arrayList2) {
        this.fromColumnBreaks = arrayList;
        this.toColumnBreaks = arrayList2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setColumnFormats(TreeSet treeSet, TreeSet treeSet2) {
        this.fromColumnFormats = treeSet;
        this.toColumnFormats = treeSet2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDataValidation(DataValidation dataValidation) {
        this.fromDataValidation = dataValidation;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDrawings(ArrayList arrayList, ArrayList arrayList2, ArrayList arrayList3) {
        this.fromDrawings = arrayList;
        this.toDrawings = arrayList2;
        this.toImages = arrayList3;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setHyperlinks(ArrayList arrayList, ArrayList arrayList2) {
        this.fromHyperlinks = arrayList;
        this.toHyperlinks = arrayList2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setMergedCells(MergedCells mergedCells, MergedCells mergedCells2) {
        this.fromMergedCells = mergedCells;
        this.toMergedCells = mergedCells2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setPLSRecord(PLSRecord pLSRecord) {
        this.fromPLSRecord = pLSRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setRowBreaks(ArrayList arrayList, ArrayList arrayList2) {
        this.fromRowBreaks = arrayList;
        this.toRowBreaks = arrayList2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setRows(RowRecord[] rowRecordArr) {
        this.fromRows = rowRecordArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setSheetWriter(SheetWriter sheetWriter) {
        this.sheetWriter = sheetWriter;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWorkspaceOptions(WorkspaceInformationRecord workspaceInformationRecord) {
        this.fromWorkspaceOptions = workspaceInformationRecord;
    }

    void shallowCopyCells() {
        int rows = this.fromSheet.getRows();
        for (int i = 0; i < rows; i++) {
            for (Cell cell : this.fromSheet.getRow(i)) {
                WritableCell shallowCopyCell = shallowCopyCell(cell);
                if (shallowCopyCell != null) {
                    try {
                        this.toSheet.addCell(shallowCopyCell);
                    } catch (WriteException unused) {
                        Assert.verify(false);
                    }
                }
            }
        }
        this.numRows = this.toSheet.getRows();
    }
}
