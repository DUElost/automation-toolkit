package jxl.write.biff;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.TreeSet;
import java.util.regex.Pattern;
import jxl.Cell;
import jxl.CellFeatures;
import jxl.CellType;
import jxl.CellView;
import jxl.HeaderFooter;
import jxl.Hyperlink;
import jxl.Image;
import jxl.LabelCell;
import jxl.Range;
import jxl.Sheet;
import jxl.SheetSettings;
import jxl.WorkbookSettings;
import jxl.biff.AutoFilter;
import jxl.biff.CellFinder;
import jxl.biff.CellReferenceHelper;
import jxl.biff.ConditionalFormat;
import jxl.biff.DataValidation;
import jxl.biff.EmptyCell;
import jxl.biff.FormattingRecords;
import jxl.biff.IndexMapping;
import jxl.biff.NumFormatRecordsException;
import jxl.biff.SheetRangeImpl;
import jxl.biff.WorkspaceInformationRecord;
import jxl.biff.XFRecord;
import jxl.biff.drawing.Chart;
import jxl.biff.drawing.ComboBox;
import jxl.biff.drawing.Drawing;
import jxl.biff.drawing.DrawingGroupObject;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.CellFormat;
import jxl.format.Font;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
import jxl.write.Blank;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableHyperlink;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class WritableSheetImpl implements WritableSheet {
    static /* synthetic */ Class class$jxl$write$biff$WritableSheetImpl = null;
    private static final char[] illegalSheetNameCharacters;
    private static final String[] imageTypes;
    private static Logger logger = null;
    private static final int maxSheetNameLength = 31;
    private static final int numRowsPerSheet = 65536;
    private static final int rowGrowSize = 10;
    private AutoFilter autoFilter;
    private ButtonPropertySetRecord buttonPropertySet;
    private ComboBox comboBox;
    private DataValidation dataValidation;
    private FormattingRecords formatRecords;
    private int maxColumnOutlineLevel;
    private int maxRowOutlineLevel;
    private String name;
    private File outputFile;
    private PLSRecord plsRecord;
    private SharedStrings sharedStrings;
    private SheetWriter sheetWriter;
    private WritableWorkbookImpl workbook;
    private WorkbookSettings workbookSettings;
    private RowRecord[] rows = new RowRecord[0];
    private int numRows = 0;
    private int numColumns = 0;
    private boolean chartOnly = false;
    private boolean drawingsModified = false;
    private TreeSet columnFormats = new TreeSet(new ColumnInfoComparator());
    private TreeSet autosizedColumns = new TreeSet();
    private ArrayList hyperlinks = new ArrayList();
    private MergedCells mergedCells = new MergedCells(this);
    private ArrayList rowBreaks = new ArrayList();
    private ArrayList columnBreaks = new ArrayList();
    private ArrayList drawings = new ArrayList();
    private ArrayList images = new ArrayList();
    private ArrayList conditionalFormats = new ArrayList();
    private ArrayList validatedCells = new ArrayList();
    private SheetSettings settings = new SheetSettings(this);

    /* loaded from: classes.dex */
    private static class ColumnInfoComparator implements Comparator {
        private ColumnInfoComparator() {
        }

        @Override // java.util.Comparator
        public int compare(Object obj, Object obj2) {
            if (obj == obj2) {
                return 0;
            }
            Assert.verify(obj instanceof ColumnInfoRecord);
            Assert.verify(obj2 instanceof ColumnInfoRecord);
            return ((ColumnInfoRecord) obj).getColumn() - ((ColumnInfoRecord) obj2).getColumn();
        }

        @Override // java.util.Comparator
        public boolean equals(Object obj) {
            return obj == this;
        }
    }

    static {
        Class cls = class$jxl$write$biff$WritableSheetImpl;
        if (cls == null) {
            cls = class$("jxl.write.biff.WritableSheetImpl");
            class$jxl$write$biff$WritableSheetImpl = cls;
        }
        logger = Logger.getLogger(cls);
        illegalSheetNameCharacters = new char[]{'*', ':', '?', '\\'};
        imageTypes = new String[]{"png"};
    }

    public WritableSheetImpl(String str, File file, FormattingRecords formattingRecords, SharedStrings sharedStrings, WorkbookSettings workbookSettings, WritableWorkbookImpl writableWorkbookImpl) {
        this.name = validateName(str);
        this.outputFile = file;
        this.workbook = writableWorkbookImpl;
        this.formatRecords = formattingRecords;
        this.sharedStrings = sharedStrings;
        this.workbookSettings = workbookSettings;
        this.sheetWriter = new SheetWriter(this.outputFile, this, this.workbookSettings);
    }

    private void autosizeColumn(int i) {
        ColumnInfoRecord columnInfo = getColumnInfo(i);
        Font font = columnInfo.getCellFormat().getFont();
        Font font2 = WritableWorkbook.NORMAL_STYLE.getFont();
        int i2 = 0;
        for (int i3 = 0; i3 < this.numRows; i3++) {
            RowRecord[] rowRecordArr = this.rows;
            CellValue cell = rowRecordArr[i3] != null ? rowRecordArr[i3].getCell(i) : null;
            if (cell != null) {
                String contents = cell.getContents();
                Font font3 = cell.getCellFormat().getFont();
                if (font3.equals(font2)) {
                    font3 = font;
                }
                int pointSize = font3.getPointSize();
                int length = contents.length();
                if (font3.isItalic() || font3.getBoldWeight() > 400) {
                    length += 2;
                }
                i2 = Math.max(i2, length * pointSize * 256);
            }
        }
        columnInfo.setWidth(i2 / font2.getPointSize());
    }

    private void autosizeColumns() {
        Iterator it = this.autosizedColumns.iterator();
        while (it.hasNext()) {
            autosizeColumn(((Integer) it.next()).intValue());
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private DrawingGroupObject[] getDrawings() {
        return (DrawingGroupObject[]) this.drawings.toArray(new DrawingGroupObject[this.drawings.size()]);
    }

    private WorkspaceInformationRecord getWorkspaceOptions() {
        return this.sheetWriter.getWorkspaceOptions();
    }

    private String validateName(String str) {
        int i = 0;
        if (str.length() > 31) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Sheet name ");
            stringBuffer.append(str);
            stringBuffer.append(" too long - truncating");
            logger2.warn(stringBuffer.toString());
            str = str.substring(0, 31);
        }
        if (str.charAt(0) == '\'') {
            logger.warn("Sheet naming cannot start with ' - removing");
            str = str.substring(1);
        }
        while (true) {
            char[] cArr = illegalSheetNameCharacters;
            if (i >= cArr.length) {
                return str;
            }
            String replace = str.replace(cArr[i], '@');
            if (str != replace) {
                Logger logger3 = logger;
                StringBuffer stringBuffer2 = new StringBuffer();
                stringBuffer2.append(cArr[i]);
                stringBuffer2.append(" is not a valid character within a sheet name - replacing");
                logger3.warn(stringBuffer2.toString());
            }
            i++;
            str = replace;
        }
    }

    @Override // jxl.write.WritableSheet
    public void addCell(WritableCell writableCell) {
        if (writableCell.getType() == CellType.EMPTY && writableCell != null && writableCell.getCellFormat() == null) {
            return;
        }
        CellValue cellValue = (CellValue) writableCell;
        if (cellValue.isReferenced()) {
            throw new JxlWriteException(JxlWriteException.cellReferenced);
        }
        int row = writableCell.getRow();
        RowRecord rowRecord = getRowRecord(row);
        rowRecord.addCell(cellValue);
        this.numRows = Math.max(row + 1, this.numRows);
        this.numColumns = Math.max(this.numColumns, rowRecord.getMaxColumn());
        cellValue.setCellDetails(this.formatRecords, this.sharedStrings, this);
    }

    @Override // jxl.write.WritableSheet
    public void addColumnPageBreak(int i) {
        Iterator it = this.columnBreaks.iterator();
        boolean z = false;
        while (it.hasNext() && !z) {
            if (((Integer) it.next()).intValue() == i) {
                z = true;
            }
        }
        if (z) {
            return;
        }
        this.columnBreaks.add(new Integer(i));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addDrawing(DrawingGroupObject drawingGroupObject) {
        this.drawings.add(drawingGroupObject);
        Assert.verify(!(drawingGroupObject instanceof Drawing));
    }

    @Override // jxl.write.WritableSheet
    public void addHyperlink(WritableHyperlink writableHyperlink) {
        String contents;
        Cell cell = getCell(writableHyperlink.getColumn(), writableHyperlink.getRow());
        if (writableHyperlink.isFile() || writableHyperlink.isUNC()) {
            contents = writableHyperlink.getContents();
            if (contents == null) {
                contents = writableHyperlink.getFile().getPath();
            }
        } else if (writableHyperlink.isURL()) {
            contents = writableHyperlink.getContents();
            if (contents == null) {
                contents = writableHyperlink.getURL().toString();
            }
        } else {
            contents = writableHyperlink.isLocation() ? writableHyperlink.getContents() : null;
        }
        if (cell.getType() == CellType.LABEL) {
            Label label = (Label) cell;
            label.setString(contents);
            WritableCellFormat writableCellFormat = new WritableCellFormat(label.getCellFormat());
            writableCellFormat.setFont(WritableWorkbook.HYPERLINK_FONT);
            label.setCellFormat(writableCellFormat);
        } else {
            addCell(new Label(writableHyperlink.getColumn(), writableHyperlink.getRow(), contents, WritableWorkbook.HYPERLINK_STYLE));
        }
        for (int row = writableHyperlink.getRow(); row <= writableHyperlink.getLastRow(); row++) {
            for (int column = writableHyperlink.getColumn(); column <= writableHyperlink.getLastColumn(); column++) {
                if (row != writableHyperlink.getRow() && column != writableHyperlink.getColumn() && this.rows.length < writableHyperlink.getLastColumn()) {
                    RowRecord[] rowRecordArr = this.rows;
                    if (rowRecordArr[row] != null) {
                        rowRecordArr[row].removeCell(column);
                    }
                }
            }
        }
        writableHyperlink.initialize(this);
        this.hyperlinks.add(writableHyperlink);
    }

    @Override // jxl.write.WritableSheet
    public void addImage(WritableImage writableImage) {
        String str;
        boolean z;
        java.io.File imageFile = writableImage.getImageFile();
        int i = 1;
        if (imageFile != null) {
            String name = imageFile.getName();
            int lastIndexOf = name.lastIndexOf(46);
            str = lastIndexOf != -1 ? name.substring(lastIndexOf + 1) : BuildConfig.FLAVOR;
            int i2 = 0;
            z = false;
            while (true) {
                String[] strArr = imageTypes;
                if (i2 >= strArr.length || z) {
                    break;
                }
                if (str.equalsIgnoreCase(strArr[i2])) {
                    z = true;
                }
                i2++;
            }
        } else {
            str = "?";
            z = true;
        }
        if (z) {
            this.workbook.addDrawing(writableImage);
            this.drawings.add(writableImage);
            this.images.add(writableImage);
            return;
        }
        StringBuffer stringBuffer = new StringBuffer("Image type ");
        stringBuffer.append(str);
        stringBuffer.append(" not supported.  Supported types are ");
        stringBuffer.append(imageTypes[0]);
        while (true) {
            String[] strArr2 = imageTypes;
            if (i >= strArr2.length) {
                logger.warn(stringBuffer.toString());
                return;
            }
            stringBuffer.append(", ");
            stringBuffer.append(strArr2[i]);
            i++;
        }
    }

    @Override // jxl.write.WritableSheet
    public void addRowPageBreak(int i) {
        Iterator it = this.rowBreaks.iterator();
        boolean z = false;
        while (it.hasNext() && !z) {
            if (((Integer) it.next()).intValue() == i) {
                z = true;
            }
        }
        if (z) {
            return;
        }
        this.rowBreaks.add(new Integer(i));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addValidationCell(CellValue cellValue) {
        this.validatedCells.add(cellValue);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void checkMergedBorders() {
        this.sheetWriter.setWriteData(this.rows, this.rowBreaks, this.columnBreaks, this.hyperlinks, this.mergedCells, this.columnFormats, this.maxRowOutlineLevel, this.maxColumnOutlineLevel);
        this.sheetWriter.setDimensions(getRows(), getColumns());
        this.sheetWriter.checkMergedBorders();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void copy(Sheet sheet) {
        this.settings = new SheetSettings(sheet.getSettings(), this);
        SheetCopier sheetCopier = new SheetCopier(sheet, this);
        sheetCopier.setColumnFormats(this.columnFormats);
        sheetCopier.setFormatRecords(this.formatRecords);
        sheetCopier.setHyperlinks(this.hyperlinks);
        sheetCopier.setMergedCells(this.mergedCells);
        sheetCopier.setRowBreaks(this.rowBreaks);
        sheetCopier.setColumnBreaks(this.columnBreaks);
        sheetCopier.setSheetWriter(this.sheetWriter);
        sheetCopier.setDrawings(this.drawings);
        sheetCopier.setImages(this.images);
        sheetCopier.setConditionalFormats(this.conditionalFormats);
        sheetCopier.copySheet();
        this.dataValidation = sheetCopier.getDataValidation();
        this.comboBox = sheetCopier.getComboBox();
        this.plsRecord = sheetCopier.getPLSRecord();
        this.chartOnly = sheetCopier.isChartOnly();
        this.buttonPropertySet = sheetCopier.getButtonPropertySet();
        this.numRows = sheetCopier.getRows();
        this.autoFilter = sheetCopier.getAutoFilter();
        this.maxRowOutlineLevel = sheetCopier.getMaxRowOutlineLevel();
        this.maxColumnOutlineLevel = sheetCopier.getMaxColumnOutlineLevel();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void copy(WritableSheet writableSheet) {
        this.settings = new SheetSettings(writableSheet.getSettings(), this);
        WritableSheetImpl writableSheetImpl = (WritableSheetImpl) writableSheet;
        WritableSheetCopier writableSheetCopier = new WritableSheetCopier(writableSheet, this);
        writableSheetCopier.setColumnFormats(writableSheetImpl.columnFormats, this.columnFormats);
        writableSheetCopier.setMergedCells(writableSheetImpl.mergedCells, this.mergedCells);
        writableSheetCopier.setRows(writableSheetImpl.rows);
        writableSheetCopier.setRowBreaks(writableSheetImpl.rowBreaks, this.rowBreaks);
        writableSheetCopier.setColumnBreaks(writableSheetImpl.columnBreaks, this.columnBreaks);
        writableSheetCopier.setDataValidation(writableSheetImpl.dataValidation);
        writableSheetCopier.setSheetWriter(this.sheetWriter);
        writableSheetCopier.setDrawings(writableSheetImpl.drawings, this.drawings, this.images);
        writableSheetCopier.setWorkspaceOptions(writableSheetImpl.getWorkspaceOptions());
        writableSheetCopier.setPLSRecord(writableSheetImpl.plsRecord);
        writableSheetCopier.setButtonPropertySetRecord(writableSheetImpl.buttonPropertySet);
        writableSheetCopier.setHyperlinks(writableSheetImpl.hyperlinks, this.hyperlinks);
        writableSheetCopier.copySheet();
        this.dataValidation = writableSheetCopier.getDataValidation();
        this.plsRecord = writableSheetCopier.getPLSRecord();
        this.buttonPropertySet = writableSheetCopier.getButtonPropertySet();
    }

    @Override // jxl.Sheet
    public Cell findCell(String str) {
        return new CellFinder(this).findCell(str);
    }

    @Override // jxl.Sheet
    public Cell findCell(String str, int i, int i2, int i3, int i4, boolean z) {
        return new CellFinder(this).findCell(str, i, i2, i3, i4, z);
    }

    @Override // jxl.Sheet
    public Cell findCell(Pattern pattern, int i, int i2, int i3, int i4, boolean z) {
        return new CellFinder(this).findCell(pattern, i, i2, i3, i4, z);
    }

    @Override // jxl.Sheet
    public LabelCell findLabelCell(String str) {
        return new CellFinder(this).findLabelCell(str);
    }

    @Override // jxl.Sheet
    public Cell getCell(int i, int i2) {
        return getWritableCell(i, i2);
    }

    @Override // jxl.Sheet
    public Cell getCell(String str) {
        return getCell(CellReferenceHelper.getColumn(str), CellReferenceHelper.getRow(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Chart[] getCharts() {
        return this.sheetWriter.getCharts();
    }

    @Override // jxl.Sheet
    public Cell[] getColumn(int i) {
        int i2 = this.numRows - 1;
        boolean z = false;
        while (i2 >= 0 && !z) {
            if (getCell(i, i2).getType() != CellType.EMPTY) {
                z = true;
            } else {
                i2--;
            }
        }
        Cell[] cellArr = new Cell[i2 + 1];
        for (int i3 = 0; i3 <= i2; i3++) {
            cellArr[i3] = getCell(i, i3);
        }
        return cellArr;
    }

    @Override // jxl.Sheet
    public CellFormat getColumnFormat(int i) {
        return getColumnView(i).getFormat();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColumnInfoRecord getColumnInfo(int i) {
        Iterator it = this.columnFormats.iterator();
        boolean z = false;
        ColumnInfoRecord columnInfoRecord = null;
        while (it.hasNext() && !z) {
            columnInfoRecord = (ColumnInfoRecord) it.next();
            if (columnInfoRecord.getColumn() >= i) {
                z = true;
            }
        }
        if (z && columnInfoRecord.getColumn() == i) {
            return columnInfoRecord;
        }
        return null;
    }

    @Override // jxl.Sheet
    public int[] getColumnPageBreaks() {
        int[] iArr = new int[this.columnBreaks.size()];
        Iterator it = this.columnBreaks.iterator();
        int i = 0;
        while (it.hasNext()) {
            iArr[i] = ((Integer) it.next()).intValue();
            i++;
        }
        return iArr;
    }

    @Override // jxl.Sheet
    public CellView getColumnView(int i) {
        ColumnInfoRecord columnInfo = getColumnInfo(i);
        CellView cellView = new CellView();
        if (columnInfo != null) {
            cellView.setDimension(columnInfo.getWidth() / 256);
            cellView.setSize(columnInfo.getWidth());
            cellView.setHidden(columnInfo.getHidden());
            cellView.setFormat(columnInfo.getCellFormat());
        } else {
            cellView.setDimension(this.settings.getDefaultColumnWidth() / 256);
            cellView.setSize(this.settings.getDefaultColumnWidth() * 256);
        }
        return cellView;
    }

    @Override // jxl.Sheet
    public int getColumnWidth(int i) {
        return getColumnView(i).getDimension();
    }

    @Override // jxl.Sheet
    public int getColumns() {
        return this.numColumns;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ComboBox getComboBox() {
        return this.comboBox;
    }

    public DataValidation getDataValidation() {
        return this.dataValidation;
    }

    @Override // jxl.Sheet
    public Image getDrawing(int i) {
        return (Image) this.images.get(i);
    }

    final FooterRecord getFooter() {
        return this.sheetWriter.getFooter();
    }

    final HeaderRecord getHeader() {
        return this.sheetWriter.getHeader();
    }

    @Override // jxl.Sheet
    public Hyperlink[] getHyperlinks() {
        Hyperlink[] hyperlinkArr = new Hyperlink[this.hyperlinks.size()];
        for (int i = 0; i < this.hyperlinks.size(); i++) {
            hyperlinkArr[i] = (Hyperlink) this.hyperlinks.get(i);
        }
        return hyperlinkArr;
    }

    @Override // jxl.write.WritableSheet
    public WritableImage getImage(int i) {
        return (WritableImage) this.images.get(i);
    }

    @Override // jxl.Sheet
    public Range[] getMergedCells() {
        return this.mergedCells.getMergedCells();
    }

    @Override // jxl.Sheet
    public String getName() {
        return this.name;
    }

    @Override // jxl.write.WritableSheet, jxl.Sheet
    public int getNumberOfImages() {
        return this.images.size();
    }

    @Override // jxl.Sheet
    public Cell[] getRow(int i) {
        int i2 = this.numColumns - 1;
        boolean z = false;
        while (i2 >= 0 && !z) {
            if (getCell(i2, i).getType() != CellType.EMPTY) {
                z = true;
            } else {
                i2--;
            }
        }
        Cell[] cellArr = new Cell[i2 + 1];
        for (int i3 = 0; i3 <= i2; i3++) {
            cellArr[i3] = getCell(i3, i);
        }
        return cellArr;
    }

    @Override // jxl.Sheet
    public int getRowHeight(int i) {
        return getRowView(i).getDimension();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public RowRecord getRowInfo(int i) {
        if (i >= 0) {
            RowRecord[] rowRecordArr = this.rows;
            if (i > rowRecordArr.length) {
                return null;
            }
            return rowRecordArr[i];
        }
        return null;
    }

    @Override // jxl.Sheet
    public int[] getRowPageBreaks() {
        int[] iArr = new int[this.rowBreaks.size()];
        Iterator it = this.rowBreaks.iterator();
        int i = 0;
        while (it.hasNext()) {
            iArr[i] = ((Integer) it.next()).intValue();
            i++;
        }
        return iArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public RowRecord getRowRecord(int i) {
        if (i < numRowsPerSheet) {
            RowRecord[] rowRecordArr = this.rows;
            if (i >= rowRecordArr.length) {
                RowRecord[] rowRecordArr2 = new RowRecord[Math.max(rowRecordArr.length + 10, i + 1)];
                this.rows = rowRecordArr2;
                System.arraycopy(rowRecordArr, 0, rowRecordArr2, 0, rowRecordArr.length);
            }
            RowRecord rowRecord = this.rows[i];
            if (rowRecord == null) {
                RowRecord rowRecord2 = new RowRecord(i, this);
                this.rows[i] = rowRecord2;
                return rowRecord2;
            }
            return rowRecord;
        }
        throw new RowsExceededException();
    }

    @Override // jxl.Sheet
    public CellView getRowView(int i) {
        int defaultRowHeight;
        CellView cellView = new CellView();
        try {
            RowRecord rowRecord = getRowRecord(i);
            if (rowRecord != null && !rowRecord.isDefaultHeight()) {
                if (rowRecord.isCollapsed()) {
                    cellView.setHidden(true);
                    return cellView;
                }
                cellView.setDimension(rowRecord.getRowHeight());
                defaultRowHeight = rowRecord.getRowHeight();
                cellView.setSize(defaultRowHeight);
                return cellView;
            }
            cellView.setDimension(this.settings.getDefaultRowHeight());
            defaultRowHeight = this.settings.getDefaultRowHeight();
            cellView.setSize(defaultRowHeight);
            return cellView;
        } catch (RowsExceededException unused) {
            cellView.setDimension(this.settings.getDefaultRowHeight());
            cellView.setSize(this.settings.getDefaultRowHeight());
            return cellView;
        }
    }

    @Override // jxl.Sheet
    public int getRows() {
        return this.numRows;
    }

    @Override // jxl.Sheet
    public SheetSettings getSettings() {
        return this.settings;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public WritableWorkbookImpl getWorkbook() {
        return this.workbook;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public WorkbookSettings getWorkbookSettings() {
        return this.workbookSettings;
    }

    @Override // jxl.write.WritableSheet
    public WritableCell getWritableCell(int i, int i2) {
        RowRecord[] rowRecordArr = this.rows;
        CellValue cell = (i2 >= rowRecordArr.length || rowRecordArr[i2] == null) ? null : rowRecordArr[i2].getCell(i);
        return cell == null ? new EmptyCell(i, i2) : cell;
    }

    @Override // jxl.write.WritableSheet
    public WritableCell getWritableCell(String str) {
        return getWritableCell(CellReferenceHelper.getColumn(str), CellReferenceHelper.getRow(str));
    }

    @Override // jxl.write.WritableSheet
    public WritableHyperlink[] getWritableHyperlinks() {
        WritableHyperlink[] writableHyperlinkArr = new WritableHyperlink[this.hyperlinks.size()];
        for (int i = 0; i < this.hyperlinks.size(); i++) {
            writableHyperlinkArr[i] = (WritableHyperlink) this.hyperlinks.get(i);
        }
        return writableHyperlinkArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void importSheet(Sheet sheet) {
        this.settings = new SheetSettings(sheet.getSettings(), this);
        SheetCopier sheetCopier = new SheetCopier(sheet, this);
        sheetCopier.setColumnFormats(this.columnFormats);
        sheetCopier.setFormatRecords(this.formatRecords);
        sheetCopier.setHyperlinks(this.hyperlinks);
        sheetCopier.setMergedCells(this.mergedCells);
        sheetCopier.setRowBreaks(this.rowBreaks);
        sheetCopier.setColumnBreaks(this.columnBreaks);
        sheetCopier.setSheetWriter(this.sheetWriter);
        sheetCopier.setDrawings(this.drawings);
        sheetCopier.setImages(this.images);
        sheetCopier.importSheet();
        this.dataValidation = sheetCopier.getDataValidation();
        this.comboBox = sheetCopier.getComboBox();
        this.plsRecord = sheetCopier.getPLSRecord();
        this.chartOnly = sheetCopier.isChartOnly();
        this.buttonPropertySet = sheetCopier.getButtonPropertySet();
        this.numRows = sheetCopier.getRows();
        this.maxRowOutlineLevel = sheetCopier.getMaxRowOutlineLevel();
        this.maxColumnOutlineLevel = sheetCopier.getMaxColumnOutlineLevel();
    }

    @Override // jxl.write.WritableSheet
    public void insertColumn(int i) {
        if (i < 0 || i >= this.numColumns) {
            return;
        }
        for (int i2 = 0; i2 < this.numRows; i2++) {
            RowRecord[] rowRecordArr = this.rows;
            if (rowRecordArr[i2] != null) {
                rowRecordArr[i2].insertColumn(i);
            }
        }
        Iterator it = this.hyperlinks.iterator();
        while (it.hasNext()) {
            ((HyperlinkRecord) it.next()).insertColumn(i);
        }
        Iterator it2 = this.columnFormats.iterator();
        while (it2.hasNext()) {
            ColumnInfoRecord columnInfoRecord = (ColumnInfoRecord) it2.next();
            if (columnInfoRecord.getColumn() >= i) {
                columnInfoRecord.incrementColumn();
            }
        }
        if (this.autosizedColumns.size() > 0) {
            TreeSet treeSet = new TreeSet();
            Iterator it3 = this.autosizedColumns.iterator();
            while (it3.hasNext()) {
                Integer num = (Integer) it3.next();
                if (num.intValue() >= i) {
                    treeSet.add(new Integer(num.intValue() + 1));
                } else {
                    treeSet.add(num);
                }
            }
            this.autosizedColumns = treeSet;
        }
        DataValidation dataValidation = this.dataValidation;
        if (dataValidation != null) {
            dataValidation.insertColumn(i);
        }
        ArrayList arrayList = this.validatedCells;
        if (arrayList != null && arrayList.size() > 0) {
            Iterator it4 = this.validatedCells.iterator();
            while (it4.hasNext()) {
                CellFeatures cellFeatures = ((CellValue) it4.next()).getCellFeatures();
                if (cellFeatures.getDVParser() != null) {
                    cellFeatures.getDVParser().insertColumn(i);
                }
            }
        }
        this.mergedCells.insertColumn(i);
        ArrayList arrayList2 = new ArrayList();
        Iterator it5 = this.columnBreaks.iterator();
        while (it5.hasNext()) {
            int intValue = ((Integer) it5.next()).intValue();
            if (intValue >= i) {
                intValue++;
            }
            arrayList2.add(new Integer(intValue));
        }
        this.columnBreaks = arrayList2;
        Iterator it6 = this.conditionalFormats.iterator();
        while (it6.hasNext()) {
            ((ConditionalFormat) it6.next()).insertColumn(i);
        }
        if (this.workbookSettings.getFormulaAdjust()) {
            this.workbook.columnInserted(this, i);
        }
        this.numColumns++;
    }

    @Override // jxl.write.WritableSheet
    public void insertRow(int i) {
        int i2;
        if (i < 0 || i >= (i2 = this.numRows)) {
            return;
        }
        RowRecord[] rowRecordArr = this.rows;
        if (i2 == rowRecordArr.length) {
            this.rows = new RowRecord[rowRecordArr.length + 10];
        } else {
            this.rows = new RowRecord[rowRecordArr.length];
        }
        System.arraycopy(rowRecordArr, 0, this.rows, 0, i);
        int i3 = i + 1;
        System.arraycopy(rowRecordArr, i, this.rows, i3, this.numRows - i);
        while (i3 <= this.numRows) {
            RowRecord[] rowRecordArr2 = this.rows;
            if (rowRecordArr2[i3] != null) {
                rowRecordArr2[i3].incrementRow();
            }
            i3++;
        }
        Iterator it = this.hyperlinks.iterator();
        while (it.hasNext()) {
            ((HyperlinkRecord) it.next()).insertRow(i);
        }
        DataValidation dataValidation = this.dataValidation;
        if (dataValidation != null) {
            dataValidation.insertRow(i);
        }
        ArrayList arrayList = this.validatedCells;
        if (arrayList != null && arrayList.size() > 0) {
            Iterator it2 = this.validatedCells.iterator();
            while (it2.hasNext()) {
                CellFeatures cellFeatures = ((CellValue) it2.next()).getCellFeatures();
                if (cellFeatures.getDVParser() != null) {
                    cellFeatures.getDVParser().insertRow(i);
                }
            }
        }
        this.mergedCells.insertRow(i);
        ArrayList arrayList2 = new ArrayList();
        Iterator it3 = this.rowBreaks.iterator();
        while (it3.hasNext()) {
            int intValue = ((Integer) it3.next()).intValue();
            if (intValue >= i) {
                intValue++;
            }
            arrayList2.add(new Integer(intValue));
        }
        this.rowBreaks = arrayList2;
        Iterator it4 = this.conditionalFormats.iterator();
        while (it4.hasNext()) {
            ((ConditionalFormat) it4.next()).insertRow(i);
        }
        if (this.workbookSettings.getFormulaAdjust()) {
            this.workbook.rowInserted(this, i);
        }
        this.numRows++;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean isChartOnly() {
        return this.chartOnly;
    }

    @Override // jxl.Sheet
    public boolean isHidden() {
        return this.settings.isHidden();
    }

    @Override // jxl.Sheet
    public boolean isProtected() {
        return this.settings.isProtected();
    }

    @Override // jxl.write.WritableSheet
    public Range mergeCells(int i, int i2, int i3, int i4) {
        if (i3 < i || i4 < i2) {
            logger.warn("Cannot merge cells - top left and bottom right incorrectly specified");
        }
        if (i3 >= this.numColumns || i4 >= this.numRows) {
            addCell(new Blank(i3, i4));
        }
        SheetRangeImpl sheetRangeImpl = new SheetRangeImpl(this, i, i2, i3, i4);
        this.mergedCells.add(sheetRangeImpl);
        return sheetRangeImpl;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rationalize(IndexMapping indexMapping, IndexMapping indexMapping2, IndexMapping indexMapping3) {
        Iterator it = this.columnFormats.iterator();
        while (it.hasNext()) {
            ((ColumnInfoRecord) it.next()).rationalize(indexMapping);
        }
        int i = 0;
        while (true) {
            RowRecord[] rowRecordArr = this.rows;
            if (i >= rowRecordArr.length) {
                break;
            }
            if (rowRecordArr[i] != null) {
                rowRecordArr[i].rationalize(indexMapping);
            }
            i++;
        }
        for (Chart chart : getCharts()) {
            chart.rationalize(indexMapping, indexMapping2, indexMapping3);
        }
    }

    @Override // jxl.write.WritableSheet
    public void removeColumn(int i) {
        if (i < 0 || i >= this.numColumns) {
            return;
        }
        for (int i2 = 0; i2 < this.numRows; i2++) {
            RowRecord[] rowRecordArr = this.rows;
            if (rowRecordArr[i2] != null) {
                rowRecordArr[i2].removeColumn(i);
            }
        }
        Iterator it = this.hyperlinks.iterator();
        while (it.hasNext()) {
            HyperlinkRecord hyperlinkRecord = (HyperlinkRecord) it.next();
            if (hyperlinkRecord.getColumn() == i && hyperlinkRecord.getLastColumn() == i) {
                it.remove();
            } else {
                hyperlinkRecord.removeColumn(i);
            }
        }
        DataValidation dataValidation = this.dataValidation;
        if (dataValidation != null) {
            dataValidation.removeColumn(i);
        }
        ArrayList arrayList = this.validatedCells;
        if (arrayList != null && arrayList.size() > 0) {
            Iterator it2 = this.validatedCells.iterator();
            while (it2.hasNext()) {
                CellFeatures cellFeatures = ((CellValue) it2.next()).getCellFeatures();
                if (cellFeatures.getDVParser() != null) {
                    cellFeatures.getDVParser().removeColumn(i);
                }
            }
        }
        this.mergedCells.removeColumn(i);
        ArrayList arrayList2 = new ArrayList();
        Iterator it3 = this.columnBreaks.iterator();
        while (it3.hasNext()) {
            int intValue = ((Integer) it3.next()).intValue();
            if (intValue != i) {
                if (intValue > i) {
                    intValue--;
                }
                arrayList2.add(new Integer(intValue));
            }
        }
        this.columnBreaks = arrayList2;
        Iterator it4 = this.columnFormats.iterator();
        ColumnInfoRecord columnInfoRecord = null;
        while (it4.hasNext()) {
            ColumnInfoRecord columnInfoRecord2 = (ColumnInfoRecord) it4.next();
            if (columnInfoRecord2.getColumn() == i) {
                columnInfoRecord = columnInfoRecord2;
            } else if (columnInfoRecord2.getColumn() > i) {
                columnInfoRecord2.decrementColumn();
            }
        }
        if (columnInfoRecord != null) {
            this.columnFormats.remove(columnInfoRecord);
        }
        if (this.autosizedColumns.size() > 0) {
            TreeSet treeSet = new TreeSet();
            Iterator it5 = this.autosizedColumns.iterator();
            while (it5.hasNext()) {
                Integer num = (Integer) it5.next();
                if (num.intValue() != i) {
                    if (num.intValue() > i) {
                        treeSet.add(new Integer(num.intValue() - 1));
                    } else {
                        treeSet.add(num);
                    }
                }
            }
            this.autosizedColumns = treeSet;
        }
        Iterator it6 = this.conditionalFormats.iterator();
        while (it6.hasNext()) {
            ((ConditionalFormat) it6.next()).removeColumn(i);
        }
        if (this.workbookSettings.getFormulaAdjust()) {
            this.workbook.columnRemoved(this, i);
        }
        this.numColumns--;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeDataValidation(CellValue cellValue) {
        this.dataValidation.removeDataValidation(cellValue.getColumn(), cellValue.getRow());
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeDrawing(DrawingGroupObject drawingGroupObject) {
        int size = this.drawings.size();
        this.drawings.remove(drawingGroupObject);
        int size2 = this.drawings.size();
        this.drawingsModified = true;
        Assert.verify(size2 == size - 1);
    }

    @Override // jxl.write.WritableSheet
    public void removeHyperlink(WritableHyperlink writableHyperlink) {
        removeHyperlink(writableHyperlink, false);
    }

    @Override // jxl.write.WritableSheet
    public void removeHyperlink(WritableHyperlink writableHyperlink, boolean z) {
        ArrayList arrayList = this.hyperlinks;
        arrayList.remove(arrayList.indexOf(writableHyperlink));
        if (z) {
            return;
        }
        Assert.verify(this.rows.length > writableHyperlink.getRow() && this.rows[writableHyperlink.getRow()] != null);
        this.rows[writableHyperlink.getRow()].removeCell(writableHyperlink.getColumn());
    }

    @Override // jxl.write.WritableSheet
    public void removeImage(WritableImage writableImage) {
        this.drawings.remove(writableImage);
        this.images.remove(writableImage);
        this.drawingsModified = true;
        this.workbook.removeDrawing(writableImage);
    }

    @Override // jxl.write.WritableSheet
    public void removeRow(int i) {
        if (i < 0 || i >= this.numRows) {
            if (this.workbookSettings.getFormulaAdjust()) {
                this.workbook.rowRemoved(this, i);
                return;
            }
            return;
        }
        RowRecord[] rowRecordArr = this.rows;
        RowRecord[] rowRecordArr2 = new RowRecord[rowRecordArr.length];
        this.rows = rowRecordArr2;
        System.arraycopy(rowRecordArr, 0, rowRecordArr2, 0, i);
        int i2 = i + 1;
        System.arraycopy(rowRecordArr, i2, this.rows, i, this.numRows - i2);
        for (int i3 = i; i3 < this.numRows; i3++) {
            RowRecord[] rowRecordArr3 = this.rows;
            if (rowRecordArr3[i3] != null) {
                rowRecordArr3[i3].decrementRow();
            }
        }
        Iterator it = this.hyperlinks.iterator();
        while (it.hasNext()) {
            HyperlinkRecord hyperlinkRecord = (HyperlinkRecord) it.next();
            if (hyperlinkRecord.getRow() == i && hyperlinkRecord.getLastRow() == i) {
                it.remove();
            } else {
                hyperlinkRecord.removeRow(i);
            }
        }
        DataValidation dataValidation = this.dataValidation;
        if (dataValidation != null) {
            dataValidation.removeRow(i);
        }
        ArrayList arrayList = this.validatedCells;
        if (arrayList != null && arrayList.size() > 0) {
            Iterator it2 = this.validatedCells.iterator();
            while (it2.hasNext()) {
                CellFeatures cellFeatures = ((CellValue) it2.next()).getCellFeatures();
                if (cellFeatures.getDVParser() != null) {
                    cellFeatures.getDVParser().removeRow(i);
                }
            }
        }
        this.mergedCells.removeRow(i);
        ArrayList arrayList2 = new ArrayList();
        Iterator it3 = this.rowBreaks.iterator();
        while (it3.hasNext()) {
            int intValue = ((Integer) it3.next()).intValue();
            if (intValue != i) {
                if (intValue > i) {
                    intValue--;
                }
                arrayList2.add(new Integer(intValue));
            }
        }
        this.rowBreaks = arrayList2;
        Iterator it4 = this.conditionalFormats.iterator();
        while (it4.hasNext()) {
            ((ConditionalFormat) it4.next()).removeRow(i);
        }
        if (this.workbookSettings.getFormulaAdjust()) {
            this.workbook.rowRemoved(this, i);
        }
        this.numRows--;
    }

    @Override // jxl.write.WritableSheet
    public void setColumnGroup(int i, int i2, boolean z) {
        if (i2 < i) {
            logger.warn("Cannot merge cells - top and bottom rows incorrectly specified");
        }
        while (i <= i2) {
            ColumnInfoRecord columnInfo = getColumnInfo(i);
            if (columnInfo == null) {
                setColumnView(i, new CellView());
                columnInfo = getColumnInfo(i);
            }
            columnInfo.incrementOutlineLevel();
            columnInfo.setCollapsed(z);
            this.maxColumnOutlineLevel = Math.max(this.maxColumnOutlineLevel, columnInfo.getOutlineLevel());
            i++;
        }
    }

    @Override // jxl.write.WritableSheet
    public void setColumnView(int i, int i2) {
        CellView cellView = new CellView();
        cellView.setSize(i2 * 256);
        setColumnView(i, cellView);
    }

    @Override // jxl.write.WritableSheet
    public void setColumnView(int i, int i2, CellFormat cellFormat) {
        CellView cellView = new CellView();
        cellView.setSize(i2 * 256);
        cellView.setFormat(cellFormat);
        setColumnView(i, cellView);
    }

    @Override // jxl.write.WritableSheet
    public void setColumnView(int i, CellView cellView) {
        XFRecord xFRecord = (XFRecord) cellView.getFormat();
        if (xFRecord == null) {
            xFRecord = getWorkbook().getStyles().getNormalStyle();
        }
        try {
            if (!xFRecord.isInitialized()) {
                this.formatRecords.addStyle(xFRecord);
            }
            int dimension = cellView.depUsed() ? cellView.getDimension() * 256 : cellView.getSize();
            if (cellView.isAutosize()) {
                this.autosizedColumns.add(new Integer(i));
            }
            ColumnInfoRecord columnInfoRecord = new ColumnInfoRecord(i, dimension, xFRecord);
            if (cellView.isHidden()) {
                columnInfoRecord.setHidden(true);
            }
            if (this.columnFormats.contains(columnInfoRecord)) {
                this.columnFormats.remove(columnInfoRecord);
            }
            this.columnFormats.add(columnInfoRecord);
        } catch (NumFormatRecordsException unused) {
            logger.warn("Maximum number of format records exceeded.  Using default format.");
            ColumnInfoRecord columnInfoRecord2 = new ColumnInfoRecord(i, cellView.getDimension() * 256, WritableWorkbook.NORMAL_STYLE);
            if (this.columnFormats.contains(columnInfoRecord2)) {
                return;
            }
            this.columnFormats.add(columnInfoRecord2);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setComboBox(ComboBox comboBox) {
        this.comboBox = comboBox;
    }

    @Override // jxl.write.WritableSheet
    public void setFooter(String str, String str2, String str3) {
        HeaderFooter headerFooter = new HeaderFooter();
        headerFooter.getLeft().append(str);
        headerFooter.getCentre().append(str2);
        headerFooter.getRight().append(str3);
        this.settings.setFooter(headerFooter);
    }

    @Override // jxl.write.WritableSheet
    public void setHeader(String str, String str2, String str3) {
        HeaderFooter headerFooter = new HeaderFooter();
        headerFooter.getLeft().append(str);
        headerFooter.getCentre().append(str2);
        headerFooter.getRight().append(str3);
        this.settings.setHeader(headerFooter);
    }

    @Override // jxl.write.WritableSheet
    public void setHidden(boolean z) {
        this.settings.setHidden(z);
    }

    @Override // jxl.write.WritableSheet
    public void setName(String str) {
        this.name = str;
    }

    @Override // jxl.write.WritableSheet
    public void setPageSetup(PageOrientation pageOrientation) {
        this.settings.setOrientation(pageOrientation);
    }

    @Override // jxl.write.WritableSheet
    public void setPageSetup(PageOrientation pageOrientation, double d2, double d3) {
        this.settings.setOrientation(pageOrientation);
        this.settings.setHeaderMargin(d2);
        this.settings.setFooterMargin(d3);
    }

    @Override // jxl.write.WritableSheet
    public void setPageSetup(PageOrientation pageOrientation, PaperSize paperSize, double d2, double d3) {
        this.settings.setPaperSize(paperSize);
        this.settings.setOrientation(pageOrientation);
        this.settings.setHeaderMargin(d2);
        this.settings.setFooterMargin(d3);
    }

    @Override // jxl.write.WritableSheet
    public void setProtected(boolean z) {
        this.settings.setProtected(z);
    }

    @Override // jxl.write.WritableSheet
    public void setRowGroup(int i, int i2, boolean z) {
        if (i2 < i) {
            logger.warn("Cannot merge cells - top and bottom rows incorrectly specified");
        }
        while (i <= i2) {
            RowRecord rowRecord = getRowRecord(i);
            i++;
            this.numRows = Math.max(i, this.numRows);
            rowRecord.incrementOutlineLevel();
            rowRecord.setCollapsed(z);
            this.maxRowOutlineLevel = Math.max(this.maxRowOutlineLevel, rowRecord.getOutlineLevel());
        }
    }

    @Override // jxl.write.WritableSheet
    public void setRowView(int i, int i2) {
        CellView cellView = new CellView();
        cellView.setSize(i2);
        cellView.setHidden(false);
        setRowView(i, cellView);
    }

    @Override // jxl.write.WritableSheet
    public void setRowView(int i, int i2, boolean z) {
        CellView cellView = new CellView();
        cellView.setSize(i2);
        cellView.setHidden(z);
        setRowView(i, cellView);
    }

    @Override // jxl.write.WritableSheet
    public void setRowView(int i, CellView cellView) {
        RowRecord rowRecord = getRowRecord(i);
        XFRecord xFRecord = (XFRecord) cellView.getFormat();
        if (xFRecord != null) {
            try {
                if (!xFRecord.isInitialized()) {
                    this.formatRecords.addStyle(xFRecord);
                }
            } catch (NumFormatRecordsException unused) {
                logger.warn("Maximum number of format records exceeded.  Using default format.");
                xFRecord = null;
            }
        }
        rowRecord.setRowDetails(cellView.getSize(), false, cellView.isHidden(), 0, false, xFRecord);
        this.numRows = Math.max(this.numRows, i + 1);
    }

    @Override // jxl.write.WritableSheet
    public void setRowView(int i, boolean z) {
        CellView cellView = new CellView();
        cellView.setHidden(z);
        setRowView(i, cellView);
    }

    public void setSelected() {
        this.settings.setSelected();
    }

    @Override // jxl.write.WritableSheet
    public void unmergeCells(Range range) {
        this.mergedCells.unmergeCells(range);
    }

    @Override // jxl.write.WritableSheet
    public void unsetColumnGroup(int i, int i2) {
        if (i2 < i) {
            logger.warn("Cannot merge cells - top and bottom rows incorrectly specified");
        }
        while (i <= i2) {
            getColumnInfo(i).decrementOutlineLevel();
            i++;
        }
        this.maxColumnOutlineLevel = 0;
        Iterator it = this.columnFormats.iterator();
        while (it.hasNext()) {
            this.maxColumnOutlineLevel = Math.max(this.maxColumnOutlineLevel, ((ColumnInfoRecord) it.next()).getOutlineLevel());
        }
    }

    @Override // jxl.write.WritableSheet
    public void unsetRowGroup(int i, int i2) {
        if (i2 < i) {
            logger.warn("Cannot merge cells - top and bottom rows incorrectly specified");
        }
        if (i2 >= this.numRows) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(BuildConfig.FLAVOR);
            stringBuffer.append(i2);
            stringBuffer.append(" is greater than the sheet bounds");
            logger2.warn(stringBuffer.toString());
            i2 = this.numRows - 1;
        }
        while (i <= i2) {
            this.rows[i].decrementOutlineLevel();
            i++;
        }
        this.maxRowOutlineLevel = 0;
        int length = this.rows.length;
        while (true) {
            int i3 = length - 1;
            if (length <= 0) {
                return;
            }
            this.maxRowOutlineLevel = Math.max(this.maxRowOutlineLevel, this.rows[i3].getOutlineLevel());
            length = i3;
        }
    }

    public void write() {
        boolean z = this.drawingsModified;
        if (this.workbook.getDrawingGroup() != null) {
            z |= this.workbook.getDrawingGroup().hasDrawingsOmitted();
        }
        if (this.autosizedColumns.size() > 0) {
            autosizeColumns();
        }
        this.sheetWriter.setWriteData(this.rows, this.rowBreaks, this.columnBreaks, this.hyperlinks, this.mergedCells, this.columnFormats, this.maxRowOutlineLevel, this.maxColumnOutlineLevel);
        this.sheetWriter.setDimensions(getRows(), getColumns());
        this.sheetWriter.setSettings(this.settings);
        this.sheetWriter.setPLS(this.plsRecord);
        this.sheetWriter.setDrawings(this.drawings, z);
        this.sheetWriter.setButtonPropertySet(this.buttonPropertySet);
        this.sheetWriter.setDataValidation(this.dataValidation, this.validatedCells);
        this.sheetWriter.setConditionalFormats(this.conditionalFormats);
        this.sheetWriter.setAutoFilter(this.autoFilter);
        this.sheetWriter.write();
    }
}
