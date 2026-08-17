package jxl.read.biff;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.regex.Pattern;
import jxl.Cell;
import jxl.CellView;
import jxl.Hyperlink;
import jxl.Image;
import jxl.LabelCell;
import jxl.Range;
import jxl.Sheet;
import jxl.SheetSettings;
import jxl.WorkbookSettings;
import jxl.biff.AutoFilter;
import jxl.biff.BuiltInName;
import jxl.biff.CellFinder;
import jxl.biff.CellReferenceHelper;
import jxl.biff.ConditionalFormat;
import jxl.biff.DataValidation;
import jxl.biff.EmptyCell;
import jxl.biff.FormattingRecords;
import jxl.biff.Type;
import jxl.biff.WorkspaceInformationRecord;
import jxl.biff.drawing.Chart;
import jxl.biff.drawing.Drawing;
import jxl.biff.drawing.DrawingData;
import jxl.biff.drawing.DrawingGroupObject;
import jxl.common.Logger;
import jxl.format.CellFormat;
import jxl.read.biff.NameRecord;
/* loaded from: classes.dex */
public class SheetImpl implements Sheet {
    static /* synthetic */ Class class$jxl$read$biff$SheetImpl;
    private static Logger logger;
    private AutoFilter autoFilter;
    private ButtonPropertySetRecord buttonPropertySet;
    private Cell[][] cells;
    private ArrayList charts;
    private int[] columnBreaks;
    private ColumnInfoRecord[] columnInfos;
    private ArrayList conditionalFormats;
    private DataValidation dataValidation;
    private ArrayList drawings;
    private File excelFile;
    private FormattingRecords formattingRecords;
    private boolean hidden;
    private ArrayList images;
    private ArrayList localNames;
    private int maxColumnOutlineLevel;
    private int maxRowOutlineLevel;
    private Range[] mergedCells;
    private String name;
    private boolean nineteenFour;
    private int numCols;
    private int numRows;
    private PLSRecord plsRecord;
    private int[] rowBreaks;
    private RowRecord[] rowRecords;
    private SheetSettings settings;
    private SSTRecord sharedStrings;
    private BOFRecord sheetBof;
    private int startPosition;
    private WorkbookParser workbook;
    private BOFRecord workbookBof;
    private WorkbookSettings workbookSettings;
    private WorkspaceInformationRecord workspaceOptions;
    private ArrayList columnInfosArray = new ArrayList();
    private ArrayList sharedFormulas = new ArrayList();
    private ArrayList hyperlinks = new ArrayList();
    private ArrayList rowProperties = new ArrayList(10);
    private boolean columnInfosInitialized = false;
    private boolean rowRecordsInitialized = false;

    static {
        Class cls = class$jxl$read$biff$SheetImpl;
        if (cls == null) {
            cls = class$("jxl.read.biff.SheetImpl");
            class$jxl$read$biff$SheetImpl = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public SheetImpl(File file, SSTRecord sSTRecord, FormattingRecords formattingRecords, BOFRecord bOFRecord, BOFRecord bOFRecord2, boolean z, WorkbookParser workbookParser) {
        this.excelFile = file;
        this.sharedStrings = sSTRecord;
        this.formattingRecords = formattingRecords;
        this.sheetBof = bOFRecord;
        this.workbookBof = bOFRecord2;
        this.nineteenFour = z;
        this.workbook = workbookParser;
        this.workbookSettings = workbookParser.getSettings();
        this.startPosition = file.getPos();
        if (this.sheetBof.isChart()) {
            this.startPosition -= this.sheetBof.getLength() + 4;
        }
        int i = 1;
        while (i >= 1) {
            Record next = file.next();
            i = next.getCode() == Type.EOF.value ? i - 1 : i;
            if (next.getCode() == Type.BOF.value) {
                i++;
            }
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void initializeImages() {
        if (this.images != null) {
            return;
        }
        this.images = new ArrayList();
        DrawingGroupObject[] drawings = getDrawings();
        for (int i = 0; i < drawings.length; i++) {
            if (drawings[i] instanceof Drawing) {
                this.images.add(drawings[i]);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addLocalName(NameRecord nameRecord) {
        if (this.localNames == null) {
            this.localNames = new ArrayList();
        }
        this.localNames.add(nameRecord);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void clear() {
        this.cells = null;
        this.mergedCells = null;
        this.columnInfosArray.clear();
        this.sharedFormulas.clear();
        this.hyperlinks.clear();
        this.columnInfosInitialized = false;
        if (this.workbookSettings.getGCDisabled()) {
            return;
        }
        System.gc();
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

    public AutoFilter getAutoFilter() {
        return this.autoFilter;
    }

    public ButtonPropertySetRecord getButtonPropertySet() {
        return this.buttonPropertySet;
    }

    @Override // jxl.Sheet
    public Cell getCell(int i, int i2) {
        if (this.cells == null) {
            readSheet();
        }
        Cell cell = this.cells[i2][i];
        if (cell == null) {
            EmptyCell emptyCell = new EmptyCell(i, i2);
            this.cells[i2][i] = emptyCell;
            return emptyCell;
        }
        return cell;
    }

    @Override // jxl.Sheet
    public Cell getCell(String str) {
        return getCell(CellReferenceHelper.getColumn(str), CellReferenceHelper.getRow(str));
    }

    public final Chart[] getCharts() {
        int size = this.charts.size();
        Chart[] chartArr = new Chart[size];
        for (int i = 0; i < size; i++) {
            chartArr[i] = (Chart) this.charts.get(i);
        }
        return chartArr;
    }

    @Override // jxl.Sheet
    public Cell[] getColumn(int i) {
        if (this.cells == null) {
            readSheet();
        }
        int i2 = this.numRows - 1;
        boolean z = false;
        while (i2 >= 0 && !z) {
            if (this.cells[i2][i] != null) {
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

    public ColumnInfoRecord getColumnInfo(int i) {
        if (!this.columnInfosInitialized) {
            Iterator it = this.columnInfosArray.iterator();
            while (it.hasNext()) {
                ColumnInfoRecord columnInfoRecord = (ColumnInfoRecord) it.next();
                int max = Math.max(0, columnInfoRecord.getStartColumn());
                int min = Math.min(this.columnInfos.length - 1, columnInfoRecord.getEndColumn());
                for (int i2 = max; i2 <= min; i2++) {
                    this.columnInfos[i2] = columnInfoRecord;
                }
                if (min < max) {
                    this.columnInfos[max] = columnInfoRecord;
                }
            }
            this.columnInfosInitialized = true;
        }
        ColumnInfoRecord[] columnInfoRecordArr = this.columnInfos;
        if (i < columnInfoRecordArr.length) {
            return columnInfoRecordArr[i];
        }
        return null;
    }

    public ColumnInfoRecord[] getColumnInfos() {
        ColumnInfoRecord[] columnInfoRecordArr = new ColumnInfoRecord[this.columnInfosArray.size()];
        for (int i = 0; i < this.columnInfosArray.size(); i++) {
            columnInfoRecordArr[i] = (ColumnInfoRecord) this.columnInfosArray.get(i);
        }
        return columnInfoRecordArr;
    }

    @Override // jxl.Sheet
    public final int[] getColumnPageBreaks() {
        return this.columnBreaks;
    }

    @Override // jxl.Sheet
    public CellView getColumnView(int i) {
        ColumnInfoRecord columnInfo = getColumnInfo(i);
        CellView cellView = new CellView();
        if (columnInfo != null) {
            cellView.setDimension(columnInfo.getWidth() / 256);
            cellView.setSize(columnInfo.getWidth());
            cellView.setHidden(columnInfo.getHidden());
            cellView.setFormat(this.formattingRecords.getXFRecord(columnInfo.getXFIndex()));
        } else {
            cellView.setDimension(this.settings.getDefaultColumnWidth());
            cellView.setSize(this.settings.getDefaultColumnWidth() * 256);
        }
        return cellView;
    }

    @Override // jxl.Sheet
    public int getColumnWidth(int i) {
        return getColumnView(i).getSize() / 256;
    }

    @Override // jxl.Sheet
    public int getColumns() {
        if (this.cells == null) {
            readSheet();
        }
        return this.numCols;
    }

    public ConditionalFormat[] getConditionalFormats() {
        return (ConditionalFormat[]) this.conditionalFormats.toArray(new ConditionalFormat[this.conditionalFormats.size()]);
    }

    public DataValidation getDataValidation() {
        return this.dataValidation;
    }

    @Override // jxl.Sheet
    public Image getDrawing(int i) {
        if (this.images == null) {
            initializeImages();
        }
        return (Image) this.images.get(i);
    }

    public DrawingData getDrawingData() {
        SheetReader sheetReader = new SheetReader(this.excelFile, this.sharedStrings, this.formattingRecords, this.sheetBof, this.workbookBof, this.nineteenFour, this.workbook, this.startPosition, this);
        sheetReader.read();
        return sheetReader.getDrawingData();
    }

    public final DrawingGroupObject[] getDrawings() {
        return (DrawingGroupObject[]) this.drawings.toArray(new DrawingGroupObject[this.drawings.size()]);
    }

    @Override // jxl.Sheet
    public Hyperlink[] getHyperlinks() {
        Hyperlink[] hyperlinkArr = new Hyperlink[this.hyperlinks.size()];
        for (int i = 0; i < this.hyperlinks.size(); i++) {
            hyperlinkArr[i] = (Hyperlink) this.hyperlinks.get(i);
        }
        return hyperlinkArr;
    }

    public int getMaxColumnOutlineLevel() {
        return this.maxColumnOutlineLevel;
    }

    public int getMaxRowOutlineLevel() {
        return this.maxRowOutlineLevel;
    }

    @Override // jxl.Sheet
    public Range[] getMergedCells() {
        Range[] rangeArr = this.mergedCells;
        return rangeArr == null ? new Range[0] : rangeArr;
    }

    @Override // jxl.Sheet
    public String getName() {
        return this.name;
    }

    @Override // jxl.Sheet
    public int getNumberOfImages() {
        if (this.images == null) {
            initializeImages();
        }
        return this.images.size();
    }

    public PLSRecord getPLS() {
        return this.plsRecord;
    }

    @Override // jxl.Sheet
    public Cell[] getRow(int i) {
        if (this.cells == null) {
            readSheet();
        }
        int i2 = this.numCols - 1;
        boolean z = false;
        while (i2 >= 0 && !z) {
            if (this.cells[i][i2] != null) {
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
        if (!this.rowRecordsInitialized) {
            this.rowRecords = new RowRecord[getRows()];
            Iterator it = this.rowProperties.iterator();
            while (it.hasNext()) {
                RowRecord rowRecord = (RowRecord) it.next();
                int rowNumber = rowRecord.getRowNumber();
                RowRecord[] rowRecordArr = this.rowRecords;
                if (rowNumber < rowRecordArr.length) {
                    rowRecordArr[rowNumber] = rowRecord;
                }
            }
            this.rowRecordsInitialized = true;
        }
        RowRecord[] rowRecordArr2 = this.rowRecords;
        if (i < rowRecordArr2.length) {
            return rowRecordArr2[i];
        }
        return null;
    }

    @Override // jxl.Sheet
    public final int[] getRowPageBreaks() {
        return this.rowBreaks;
    }

    public RowRecord[] getRowProperties() {
        int size = this.rowProperties.size();
        RowRecord[] rowRecordArr = new RowRecord[size];
        for (int i = 0; i < size; i++) {
            rowRecordArr[i] = (RowRecord) this.rowProperties.get(i);
        }
        return rowRecordArr;
    }

    @Override // jxl.Sheet
    public CellView getRowView(int i) {
        RowRecord rowInfo = getRowInfo(i);
        CellView cellView = new CellView();
        if (rowInfo != null) {
            cellView.setDimension(rowInfo.getRowHeight());
            cellView.setSize(rowInfo.getRowHeight());
            cellView.setHidden(rowInfo.isCollapsed());
            if (rowInfo.hasDefaultFormat()) {
                cellView.setFormat(this.formattingRecords.getXFRecord(rowInfo.getXFIndex()));
            }
        } else {
            cellView.setDimension(this.settings.getDefaultRowHeight());
            cellView.setSize(this.settings.getDefaultRowHeight());
        }
        return cellView;
    }

    @Override // jxl.Sheet
    public int getRows() {
        if (this.cells == null) {
            readSheet();
        }
        return this.numRows;
    }

    @Override // jxl.Sheet
    public SheetSettings getSettings() {
        return this.settings;
    }

    public BOFRecord getSheetBof() {
        return this.sheetBof;
    }

    public WorkbookParser getWorkbook() {
        return this.workbook;
    }

    public BOFRecord getWorkbookBof() {
        return this.workbookBof;
    }

    public WorkspaceInformationRecord getWorkspaceOptions() {
        return this.workspaceOptions;
    }

    @Override // jxl.Sheet
    public boolean isHidden() {
        return this.hidden;
    }

    @Override // jxl.Sheet
    public boolean isProtected() {
        return this.settings.isProtected();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void readSheet() {
        ArrayList arrayList;
        if (!this.sheetBof.isWorksheet()) {
            this.numRows = 0;
            this.numCols = 0;
            this.cells = (Cell[][]) Array.newInstance(Cell.class, 0, 0);
        }
        SheetReader sheetReader = new SheetReader(this.excelFile, this.sharedStrings, this.formattingRecords, this.sheetBof, this.workbookBof, this.nineteenFour, this.workbook, this.startPosition, this);
        sheetReader.read();
        this.numRows = sheetReader.getNumRows();
        this.numCols = sheetReader.getNumCols();
        this.cells = sheetReader.getCells();
        this.rowProperties = sheetReader.getRowProperties();
        this.columnInfosArray = sheetReader.getColumnInfosArray();
        this.hyperlinks = sheetReader.getHyperlinks();
        this.conditionalFormats = sheetReader.getConditionalFormats();
        this.autoFilter = sheetReader.getAutoFilter();
        this.charts = sheetReader.getCharts();
        this.drawings = sheetReader.getDrawings();
        this.dataValidation = sheetReader.getDataValidation();
        this.mergedCells = sheetReader.getMergedCells();
        SheetSettings settings = sheetReader.getSettings();
        this.settings = settings;
        settings.setHidden(this.hidden);
        this.rowBreaks = sheetReader.getRowBreaks();
        this.columnBreaks = sheetReader.getColumnBreaks();
        this.workspaceOptions = sheetReader.getWorkspaceOptions();
        this.plsRecord = sheetReader.getPLS();
        this.buttonPropertySet = sheetReader.getButtonPropertySet();
        this.maxRowOutlineLevel = sheetReader.getMaxRowOutlineLevel();
        this.maxColumnOutlineLevel = sheetReader.getMaxColumnOutlineLevel();
        if (!this.workbookSettings.getGCDisabled()) {
            System.gc();
        }
        if (this.columnInfosArray.size() > 0) {
            this.columnInfos = new ColumnInfoRecord[((ColumnInfoRecord) this.columnInfosArray.get(arrayList.size() - 1)).getEndColumn() + 1];
        } else {
            this.columnInfos = new ColumnInfoRecord[0];
        }
        ArrayList arrayList2 = this.localNames;
        if (arrayList2 != null) {
            Iterator it = arrayList2.iterator();
            while (it.hasNext()) {
                NameRecord nameRecord = (NameRecord) it.next();
                if (nameRecord.getBuiltInName() == BuiltInName.PRINT_AREA) {
                    if (nameRecord.getRanges().length > 0) {
                        NameRecord.NameRange nameRange = nameRecord.getRanges()[0];
                        this.settings.setPrintArea(nameRange.getFirstColumn(), nameRange.getFirstRow(), nameRange.getLastColumn(), nameRange.getLastRow());
                    }
                } else if (nameRecord.getBuiltInName() == BuiltInName.PRINT_TITLES) {
                    for (int i = 0; i < nameRecord.getRanges().length; i++) {
                        NameRecord.NameRange nameRange2 = nameRecord.getRanges()[i];
                        if (nameRange2.getFirstColumn() == 0 && nameRange2.getLastColumn() == 255) {
                            this.settings.setPrintTitlesRow(nameRange2.getFirstRow(), nameRange2.getLastRow());
                        } else {
                            this.settings.setPrintTitlesCol(nameRange2.getFirstColumn(), nameRange2.getLastColumn());
                        }
                    }
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void setHidden(boolean z) {
        this.hidden = z;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void setName(String str) {
        this.name = str;
    }
}
