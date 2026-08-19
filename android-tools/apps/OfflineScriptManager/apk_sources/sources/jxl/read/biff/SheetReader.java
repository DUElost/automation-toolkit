package jxl.read.biff;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import jxl.Cell;
import jxl.CellFeatures;
import jxl.CellReferenceHelper;
import jxl.CellType;
import jxl.HeaderFooter;
import jxl.Range;
import jxl.SheetSettings;
import jxl.WorkbookSettings;
import jxl.biff.AutoFilter;
import jxl.biff.AutoFilterInfoRecord;
import jxl.biff.AutoFilterRecord;
import jxl.biff.ConditionalFormat;
import jxl.biff.ConditionalFormatRangeRecord;
import jxl.biff.ConditionalFormatRecord;
import jxl.biff.ContinueRecord;
import jxl.biff.DataValidation;
import jxl.biff.DataValidityListRecord;
import jxl.biff.DataValiditySettingsRecord;
import jxl.biff.FilterModeRecord;
import jxl.biff.FormattingRecords;
import jxl.biff.Type;
import jxl.biff.WorkspaceInformationRecord;
import jxl.biff.drawing.Chart;
import jxl.biff.drawing.Comment;
import jxl.biff.drawing.Drawing2;
import jxl.biff.drawing.DrawingData;
import jxl.biff.drawing.MsoDrawingRecord;
import jxl.biff.drawing.NoteRecord;
import jxl.biff.drawing.ObjRecord;
import jxl.biff.formula.FormulaException;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.PageOrder;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class SheetReader {
    static /* synthetic */ Class class$jxl$read$biff$SheetReader;
    private static Logger logger;
    private AutoFilter autoFilter;
    private ButtonPropertySetRecord buttonPropertySet;
    private Cell[][] cells;
    private int[] columnBreaks;
    private DataValidation dataValidation;
    private DrawingData drawingData;
    private File excelFile;
    private FormattingRecords formattingRecords;
    private int maxColumnOutlineLevel;
    private int maxRowOutlineLevel;
    private Range[] mergedCells;
    private boolean nineteenFour;
    private int numCols;
    private int numRows;
    private PLSRecord plsRecord;
    private int[] rowBreaks;
    private SheetSettings settings;
    private SSTRecord sharedStrings;
    private SheetImpl sheet;
    private BOFRecord sheetBof;
    private int startPosition;
    private WorkbookParser workbook;
    private BOFRecord workbookBof;
    private WorkbookSettings workbookSettings;
    private WorkspaceInformationRecord workspaceOptions;
    private ArrayList columnInfosArray = new ArrayList();
    private ArrayList sharedFormulas = new ArrayList();
    private ArrayList hyperlinks = new ArrayList();
    private ArrayList conditionalFormats = new ArrayList();
    private ArrayList rowProperties = new ArrayList(10);
    private ArrayList charts = new ArrayList();
    private ArrayList drawings = new ArrayList();
    private ArrayList outOfBoundsCells = new ArrayList();

    static {
        Class cls = class$jxl$read$biff$SheetReader;
        if (cls == null) {
            cls = class$("jxl.read.biff.SheetReader");
            class$jxl$read$biff$SheetReader = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public SheetReader(File file, SSTRecord sSTRecord, FormattingRecords formattingRecords, BOFRecord bOFRecord, BOFRecord bOFRecord2, boolean z, WorkbookParser workbookParser, int i, SheetImpl sheetImpl) {
        this.excelFile = file;
        this.sharedStrings = sSTRecord;
        this.formattingRecords = formattingRecords;
        this.sheetBof = bOFRecord;
        this.workbookBof = bOFRecord2;
        this.nineteenFour = z;
        this.workbook = workbookParser;
        this.startPosition = i;
        this.sheet = sheetImpl;
        this.settings = new SheetSettings(sheetImpl);
        this.workbookSettings = this.workbook.getSettings();
    }

    private void addCell(Cell cell) {
        if (cell.getRow() >= this.numRows || cell.getColumn() >= this.numCols) {
            this.outOfBoundsCells.add(cell);
            return;
        }
        if (this.cells[cell.getRow()][cell.getColumn()] != null) {
            StringBuffer stringBuffer = new StringBuffer();
            CellReferenceHelper.getCellReference(cell.getColumn(), cell.getRow(), stringBuffer);
            Logger logger2 = logger;
            StringBuffer stringBuffer2 = new StringBuffer();
            stringBuffer2.append("Cell ");
            stringBuffer2.append(stringBuffer.toString());
            stringBuffer2.append(" already contains data");
            logger2.warn(stringBuffer2.toString());
        }
        this.cells[cell.getRow()][cell.getColumn()] = cell;
    }

    private void addCellComment(int i, int i2, String str, double d2, double d3) {
        Cell cell = this.cells[i2][i];
        if (cell == null) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Cell at ");
            stringBuffer.append(CellReferenceHelper.getCellReference(i, i2));
            stringBuffer.append(" not present - adding a blank");
            logger2.warn(stringBuffer.toString());
            MulBlankCell mulBlankCell = new MulBlankCell(i2, i, 0, this.formattingRecords, this.sheet);
            CellFeatures cellFeatures = new CellFeatures();
            cellFeatures.setReadComment(str, d2, d3);
            mulBlankCell.setCellFeatures(cellFeatures);
            addCell(mulBlankCell);
        } else if (cell instanceof CellFeaturesAccessor) {
            CellFeaturesAccessor cellFeaturesAccessor = (CellFeaturesAccessor) cell;
            CellFeatures cellFeatures2 = cellFeaturesAccessor.getCellFeatures();
            if (cellFeatures2 == null) {
                cellFeatures2 = new CellFeatures();
                cellFeaturesAccessor.setCellFeatures(cellFeatures2);
            }
            cellFeatures2.setReadComment(str, d2, d3);
        } else {
            Logger logger3 = logger;
            StringBuffer stringBuffer2 = new StringBuffer();
            stringBuffer2.append("Not able to add comment to cell type ");
            stringBuffer2.append(cell.getClass().getName());
            stringBuffer2.append(" at ");
            stringBuffer2.append(CellReferenceHelper.getCellReference(i, i2));
            logger3.warn(stringBuffer2.toString());
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0, types: [jxl.Cell[][]] */
    /* JADX WARN: Type inference failed for: r3v3 */
    /* JADX WARN: Type inference failed for: r6v0, types: [jxl.read.biff.SheetReader] */
    /* JADX WARN: Type inference failed for: r8v12 */
    /* JADX WARN: Type inference failed for: r8v13 */
    private void addCellValidation(int i, int i2, int i3, int i4, DataValiditySettingsRecord dataValiditySettingsRecord) {
        for (int i5 = i2; i5 <= i4; i5++) {
            for (int i6 = i; i6 <= i3; i6++) {
                CellFeaturesAccessor cellFeaturesAccessor = null;
                ?? r0 = this.cells;
                if (r0.length > i5 && r0[i5].length > i6) {
                    cellFeaturesAccessor = r0[i5][i6];
                }
                if (cellFeaturesAccessor == null) {
                    Logger logger2 = logger;
                    StringBuffer stringBuffer = new StringBuffer();
                    stringBuffer.append("Cell at ");
                    stringBuffer.append(CellReferenceHelper.getCellReference(i6, i5));
                    stringBuffer.append(" not present - adding a blank");
                    logger2.warn(stringBuffer.toString());
                    MulBlankCell mulBlankCell = new MulBlankCell(i5, i6, 0, this.formattingRecords, this.sheet);
                    CellFeatures cellFeatures = new CellFeatures();
                    cellFeatures.setValidationSettings(dataValiditySettingsRecord);
                    mulBlankCell.setCellFeatures(cellFeatures);
                    addCell(mulBlankCell);
                    return;
                }
                if (cellFeaturesAccessor instanceof CellFeaturesAccessor) {
                    CellFeaturesAccessor cellFeaturesAccessor2 = cellFeaturesAccessor;
                    CellFeatures cellFeatures2 = cellFeaturesAccessor2.getCellFeatures();
                    if (cellFeatures2 == null) {
                        cellFeatures2 = new CellFeatures();
                        cellFeaturesAccessor2.setCellFeatures(cellFeatures2);
                    }
                    cellFeatures2.setValidationSettings(dataValiditySettingsRecord);
                } else {
                    Logger logger3 = logger;
                    StringBuffer stringBuffer2 = new StringBuffer();
                    stringBuffer2.append("Not able to add comment to cell type ");
                    stringBuffer2.append(cellFeaturesAccessor.getClass().getName());
                    stringBuffer2.append(" at ");
                    stringBuffer2.append(CellReferenceHelper.getCellReference(i6, i5));
                    logger3.warn(stringBuffer2.toString());
                }
            }
        }
    }

    private boolean addToSharedFormulas(BaseSharedFormulaRecord baseSharedFormulaRecord) {
        int size = this.sharedFormulas.size();
        boolean z = false;
        for (int i = 0; i < size && !z; i++) {
            z = ((SharedFormulaRecord) this.sharedFormulas.get(i)).add(baseSharedFormulaRecord);
        }
        return z;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:61:0x0162  */
    /* JADX WARN: Removed duplicated region for block: B:62:0x0164  */
    /* JADX WARN: Removed duplicated region for block: B:65:0x0176 A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:66:0x0177 A[Catch: DrawingDataException -> 0x028c, TryCatch #0 {DrawingDataException -> 0x028c, blocks: (B:6:0x000b, B:8:0x0013, B:10:0x0017, B:11:0x001e, B:13:0x0036, B:15:0x003f, B:17:0x0043, B:18:0x004a, B:20:0x006a, B:23:0x0080, B:27:0x008b, B:30:0x00a5, B:32:0x00bc, B:33:0x00c4, B:22:0x0072, B:35:0x00d1, B:37:0x00d9, B:39:0x00dd, B:40:0x00e4, B:42:0x00fc, B:44:0x0104, B:46:0x0108, B:47:0x010f, B:49:0x012f, B:54:0x013b, B:56:0x0144, B:59:0x015a, B:63:0x0165, B:66:0x0177, B:69:0x0186, B:71:0x019d, B:72:0x01a5, B:58:0x014c, B:74:0x01ab, B:76:0x01b3, B:78:0x01b7, B:79:0x01be, B:81:0x01de, B:82:0x01ec, B:86:0x01f7, B:89:0x0211, B:91:0x0228, B:92:0x0230, B:94:0x0236, B:96:0x023e, B:98:0x026a, B:99:0x0271, B:101:0x0282), top: B:106:0x000b }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void handleObjectRecord(jxl.biff.drawing.ObjRecord r11, jxl.biff.drawing.MsoDrawingRecord r12, java.util.HashMap r13) {
        /*
            Method dump skipped, instructions count: 685
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.read.biff.SheetReader.handleObjectRecord(jxl.biff.drawing.ObjRecord, jxl.biff.drawing.MsoDrawingRecord, java.util.HashMap):void");
    }

    private void handleOutOfBoundsCells() {
        int i = this.numRows;
        int i2 = this.numCols;
        Iterator it = this.outOfBoundsCells.iterator();
        while (it.hasNext()) {
            Cell cell = (Cell) it.next();
            i = Math.max(i, cell.getRow() + 1);
            i2 = Math.max(i2, cell.getColumn() + 1);
        }
        Logger logger2 = logger;
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("Some cells exceeded the specified bounds.  Resizing sheet dimensions from ");
        stringBuffer.append(this.numCols);
        stringBuffer.append("x");
        stringBuffer.append(this.numRows);
        stringBuffer.append(" to ");
        stringBuffer.append(i2);
        stringBuffer.append("x");
        stringBuffer.append(i);
        logger2.warn(stringBuffer.toString());
        if (i2 > this.numCols) {
            for (int i3 = 0; i3 < this.numRows; i3++) {
                Cell[] cellArr = new Cell[i2];
                Cell[] cellArr2 = this.cells[i3];
                System.arraycopy(cellArr2, 0, cellArr, 0, cellArr2.length);
                this.cells[i3] = cellArr;
            }
        }
        if (i > this.numRows) {
            Cell[][] cellArr3 = new Cell[i];
            Cell[][] cellArr4 = this.cells;
            System.arraycopy(cellArr4, 0, cellArr3, 0, cellArr4.length);
            this.cells = cellArr3;
            for (int i4 = this.numRows; i4 < i; i4++) {
                cellArr3[i4] = new Cell[i2];
            }
        }
        this.numRows = i;
        this.numCols = i2;
        Iterator it2 = this.outOfBoundsCells.iterator();
        while (it2.hasNext()) {
            addCell((Cell) it2.next());
        }
        this.outOfBoundsCells.clear();
    }

    private Cell revertSharedFormula(BaseSharedFormulaRecord baseSharedFormulaRecord) {
        int pos = this.excelFile.getPos();
        this.excelFile.setPos(baseSharedFormulaRecord.getFilePos());
        Record record = baseSharedFormulaRecord.getRecord();
        File file = this.excelFile;
        FormattingRecords formattingRecords = this.formattingRecords;
        WorkbookParser workbookParser = this.workbook;
        FormulaRecord formulaRecord = new FormulaRecord(record, file, formattingRecords, workbookParser, workbookParser, FormulaRecord.ignoreSharedFormula, this.sheet, this.workbookSettings);
        try {
            Cell formula = formulaRecord.getFormula();
            if (formulaRecord.getFormula().getType() == CellType.NUMBER_FORMULA) {
                NumberFormulaRecord numberFormulaRecord = (NumberFormulaRecord) formulaRecord.getFormula();
                if (this.formattingRecords.isDate(formulaRecord.getXFIndex())) {
                    FormattingRecords formattingRecords2 = this.formattingRecords;
                    WorkbookParser workbookParser2 = this.workbook;
                    formula = new DateFormulaRecord(numberFormulaRecord, formattingRecords2, workbookParser2, workbookParser2, this.nineteenFour, this.sheet);
                }
            }
            this.excelFile.setPos(pos);
            return formula;
        } catch (FormulaException e) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(CellReferenceHelper.getCellReference(formulaRecord.getColumn(), formulaRecord.getRow()));
            stringBuffer.append(" ");
            stringBuffer.append(e.getMessage());
            logger2.warn(stringBuffer.toString());
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final AutoFilter getAutoFilter() {
        return this.autoFilter;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ButtonPropertySetRecord getButtonPropertySet() {
        return this.buttonPropertySet;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final Cell[][] getCells() {
        return this.cells;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ArrayList getCharts() {
        return this.charts;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int[] getColumnBreaks() {
        return this.columnBreaks;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ArrayList getColumnInfosArray() {
        return this.columnInfosArray;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ArrayList getConditionalFormats() {
        return this.conditionalFormats;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final DataValidation getDataValidation() {
        return this.dataValidation;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DrawingData getDrawingData() {
        return this.drawingData;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ArrayList getDrawings() {
        return this.drawings;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ArrayList getHyperlinks() {
        return this.hyperlinks;
    }

    public int getMaxColumnOutlineLevel() {
        return this.maxColumnOutlineLevel;
    }

    public int getMaxRowOutlineLevel() {
        return this.maxRowOutlineLevel;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final Range[] getMergedCells() {
        return this.mergedCells;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int getNumCols() {
        return this.numCols;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int getNumRows() {
        return this.numRows;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final PLSRecord getPLS() {
        return this.plsRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int[] getRowBreaks() {
        return this.rowBreaks;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final ArrayList getRowProperties() {
        return this.rowProperties;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final SheetSettings getSettings() {
        return this.settings;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final WorkspaceInformationRecord getWorkspaceOptions() {
        return this.workspaceOptions;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Multi-variable type inference failed */
    public final void read() {
        ObjRecord objRecord;
        BaseSharedFormulaRecord baseSharedFormulaRecord;
        MsoDrawingRecord msoDrawingRecord;
        HashMap hashMap;
        ArrayList arrayList;
        boolean z;
        AutoFilterInfoRecord autoFilterInfoRecord;
        FilterModeRecord filterModeRecord;
        ConditionalFormat conditionalFormat;
        HashMap hashMap2;
        ArrayList arrayList2;
        BaseSharedFormulaRecord baseSharedFormulaRecord2;
        int i;
        int i2;
        SheetSettings sheetSettings;
        PageOrientation pageOrientation;
        SheetSettings sheetSettings2;
        PageOrder pageOrder;
        ArrayList arrayList3;
        Cell blankCell;
        ColumnInfoRecord columnInfoRecord;
        BaseSharedFormulaRecord baseSharedFormulaRecord3;
        Cell errorRecord;
        NumberRecord numberRecord;
        MulRKRecord mulRKRecord;
        AutoFilterInfoRecord autoFilterInfoRecord2;
        this.excelFile.setPos(this.startPosition);
        HashMap hashMap3 = new HashMap();
        ArrayList arrayList4 = new ArrayList();
        char c2 = 1;
        int i3 = 0;
        boolean z2 = true;
        boolean z3 = true;
        boolean z4 = false;
        AutoFilterInfoRecord autoFilterInfoRecord3 = null;
        FilterModeRecord filterModeRecord2 = null;
        ObjRecord objRecord2 = null;
        ConditionalFormat conditionalFormat2 = null;
        BaseSharedFormulaRecord baseSharedFormulaRecord4 = null;
        MsoDrawingRecord msoDrawingRecord2 = null;
        Window2Record window2Record = null;
        ContinueRecord continueRecord = null;
        while (z2) {
            Record next = this.excelFile.next();
            Type type = next.getType();
            if (type == Type.UNKNOWN && next.getCode() == 0) {
                logger.warn("Biff code zero found");
                if (next.getLength() == 10) {
                    logger.warn("Biff code zero found - trying a dimension record.");
                    next.setType(Type.DIMENSION);
                } else {
                    logger.warn("Biff code zero found - Ignoring.");
                }
            }
            if (type == Type.DIMENSION) {
                DimensionRecord dimensionRecord = this.workbookBof.isBiff8() ? new DimensionRecord(next) : new DimensionRecord(next, DimensionRecord.biff7);
                this.numRows = dimensionRecord.getNumberOfRows();
                int numberOfColumns = dimensionRecord.getNumberOfColumns();
                this.numCols = numberOfColumns;
                int i4 = this.numRows;
                int[] iArr = new int[2];
                iArr[c2] = numberOfColumns;
                iArr[i3] = i4;
                this.cells = (Cell[][]) Array.newInstance(Cell.class, iArr);
            } else if (type == Type.LABELSST) {
                addCell(new LabelSSTRecord(next, this.sharedStrings, this.formattingRecords, this.sheet));
            } else {
                if (type == Type.RK || type == Type.RK2) {
                    objRecord = objRecord2;
                    baseSharedFormulaRecord = baseSharedFormulaRecord4;
                    msoDrawingRecord = msoDrawingRecord2;
                    hashMap = hashMap3;
                    arrayList = arrayList4;
                    z = z2;
                    autoFilterInfoRecord = autoFilterInfoRecord3;
                    filterModeRecord = filterModeRecord2;
                    conditionalFormat = conditionalFormat2;
                    RKRecord rKRecord = new RKRecord(next, this.formattingRecords, this.sheet);
                    if (this.formattingRecords.isDate(rKRecord.getXFIndex())) {
                        addCell(new DateRecord(rKRecord, rKRecord.getXFIndex(), this.formattingRecords, this.nineteenFour, this.sheet));
                    } else {
                        addCell(rKRecord);
                    }
                } else if (type == Type.HLINK) {
                    this.hyperlinks.add(new HyperlinkRecord(next, this.sheet, this.workbookSettings));
                } else if (type == Type.MERGEDCELLS) {
                    MergedCellsRecord mergedCellsRecord = new MergedCellsRecord(next, this.sheet);
                    Range[] rangeArr = this.mergedCells;
                    if (rangeArr == null) {
                        this.mergedCells = mergedCellsRecord.getRanges();
                    } else {
                        Range[] rangeArr2 = new Range[rangeArr.length + mergedCellsRecord.getRanges().length];
                        Range[] rangeArr3 = this.mergedCells;
                        System.arraycopy(rangeArr3, i3, rangeArr2, i3, rangeArr3.length);
                        System.arraycopy(mergedCellsRecord.getRanges(), i3, rangeArr2, this.mergedCells.length, mergedCellsRecord.getRanges().length);
                        this.mergedCells = rangeArr2;
                    }
                } else if (type == Type.MULRK) {
                    MulRKRecord mulRKRecord2 = new MulRKRecord(next);
                    int numberOfColumns2 = mulRKRecord2.getNumberOfColumns();
                    int i5 = i3;
                    while (i5 < numberOfColumns2) {
                        int xFIndex = mulRKRecord2.getXFIndex(i5);
                        int i6 = numberOfColumns2;
                        NumberValue numberValue = new NumberValue(mulRKRecord2.getRow(), mulRKRecord2.getFirstColumn() + i5, RKHelper.getDouble(mulRKRecord2.getRKNumber(i5)), xFIndex, this.formattingRecords, this.sheet);
                        if (this.formattingRecords.isDate(xFIndex)) {
                            mulRKRecord = mulRKRecord2;
                            autoFilterInfoRecord2 = autoFilterInfoRecord3;
                            addCell(new DateRecord(numberValue, xFIndex, this.formattingRecords, this.nineteenFour, this.sheet));
                        } else {
                            mulRKRecord = mulRKRecord2;
                            autoFilterInfoRecord2 = autoFilterInfoRecord3;
                            numberValue.setNumberFormat(this.formattingRecords.getNumberFormat(xFIndex));
                            addCell(numberValue);
                        }
                        i5++;
                        mulRKRecord2 = mulRKRecord;
                        autoFilterInfoRecord3 = autoFilterInfoRecord2;
                        numberOfColumns2 = i6;
                    }
                } else {
                    AutoFilterInfoRecord autoFilterInfoRecord4 = autoFilterInfoRecord3;
                    if (type == Type.NUMBER) {
                        NumberRecord numberRecord2 = new NumberRecord(next, this.formattingRecords, this.sheet);
                        boolean isDate = this.formattingRecords.isDate(numberRecord2.getXFIndex());
                        numberRecord = numberRecord2;
                        if (isDate) {
                            errorRecord = new DateRecord(numberRecord2, numberRecord2.getXFIndex(), this.formattingRecords, this.nineteenFour, this.sheet);
                            addCell(errorRecord);
                        }
                        addCell(numberRecord);
                    } else if (type == Type.BOOLERR) {
                        BooleanRecord booleanRecord = new BooleanRecord(next, this.formattingRecords, this.sheet);
                        boolean isError = booleanRecord.isError();
                        numberRecord = booleanRecord;
                        if (isError) {
                            errorRecord = new ErrorRecord(booleanRecord.getRecord(), this.formattingRecords, this.sheet);
                            addCell(errorRecord);
                        }
                        addCell(numberRecord);
                    } else if (type == Type.PRINTGRIDLINES) {
                        this.settings.setPrintGridLines(new PrintGridLinesRecord(next).getPrintGridLines());
                    } else if (type == Type.PRINTHEADERS) {
                        this.settings.setPrintHeaders(new PrintHeadersRecord(next).getPrintHeaders());
                    } else {
                        if (type == Type.WINDOW2) {
                            window2Record = this.workbookBof.isBiff8() ? new Window2Record(next) : new Window2Record(next, Window2Record.biff7);
                            this.settings.setShowGridLines(window2Record.getShowGridLines());
                            this.settings.setDisplayZeroValues(window2Record.getDisplayZeroValues());
                            this.settings.setSelected(true);
                            this.settings.setPageBreakPreviewMode(window2Record.isPageBreakPreview());
                        } else if (type == Type.PANE) {
                            PaneRecord paneRecord = new PaneRecord(next);
                            if (window2Record != null && window2Record.getFrozen()) {
                                this.settings.setVerticalFreeze(paneRecord.getRowsVisible());
                                this.settings.setHorizontalFreeze(paneRecord.getColumnsVisible());
                            }
                        } else if (type == Type.CONTINUE) {
                            continueRecord = new ContinueRecord(next);
                        } else {
                            if (type == Type.NOTE) {
                                if (!this.workbookSettings.getDrawingsDisabled()) {
                                    NoteRecord noteRecord = new NoteRecord(next);
                                    Comment comment = (Comment) hashMap3.remove(new Integer(noteRecord.getObjectId()));
                                    if (comment == null) {
                                        Logger logger2 = logger;
                                        StringBuffer stringBuffer = new StringBuffer();
                                        stringBuffer.append(" cannot find comment for note id ");
                                        stringBuffer.append(noteRecord.getObjectId());
                                        stringBuffer.append("...ignoring");
                                        logger2.warn(stringBuffer.toString());
                                    } else {
                                        comment.setNote(noteRecord);
                                        this.drawings.add(comment);
                                        z = z2;
                                        autoFilterInfoRecord = autoFilterInfoRecord4;
                                        hashMap2 = hashMap3;
                                        filterModeRecord = filterModeRecord2;
                                        objRecord = objRecord2;
                                        arrayList2 = arrayList4;
                                        conditionalFormat = conditionalFormat2;
                                        baseSharedFormulaRecord = baseSharedFormulaRecord4;
                                        msoDrawingRecord = msoDrawingRecord2;
                                        addCellComment(comment.getColumn(), comment.getRow(), comment.getText(), comment.getWidth(), comment.getHeight());
                                    }
                                }
                                objRecord = objRecord2;
                                baseSharedFormulaRecord = baseSharedFormulaRecord4;
                                msoDrawingRecord = msoDrawingRecord2;
                                hashMap2 = hashMap3;
                                arrayList2 = arrayList4;
                                z = z2;
                                autoFilterInfoRecord = autoFilterInfoRecord4;
                                filterModeRecord = filterModeRecord2;
                                conditionalFormat = conditionalFormat2;
                            } else {
                                objRecord = objRecord2;
                                baseSharedFormulaRecord = baseSharedFormulaRecord4;
                                msoDrawingRecord = msoDrawingRecord2;
                                hashMap2 = hashMap3;
                                arrayList2 = arrayList4;
                                z = z2;
                                autoFilterInfoRecord = autoFilterInfoRecord4;
                                filterModeRecord = filterModeRecord2;
                                conditionalFormat = conditionalFormat2;
                                if (type != Type.ARRAY) {
                                    if (type == Type.PROTECT) {
                                        this.settings.setProtected(new ProtectRecord(next).isProtected());
                                    } else {
                                        if (type == Type.SHAREDFORMULA) {
                                            if (baseSharedFormulaRecord == null) {
                                                logger.warn("Shared template formula is null - trying most recent formula template");
                                                ArrayList arrayList5 = this.sharedFormulas;
                                                SharedFormulaRecord sharedFormulaRecord = (SharedFormulaRecord) arrayList5.get(arrayList5.size() - 1);
                                                if (sharedFormulaRecord != null) {
                                                    baseSharedFormulaRecord3 = sharedFormulaRecord.getTemplateFormula();
                                                    WorkbookParser workbookParser = this.workbook;
                                                    this.sharedFormulas.add(new SharedFormulaRecord(next, baseSharedFormulaRecord3, workbookParser, workbookParser, this.sheet));
                                                    filterModeRecord2 = filterModeRecord;
                                                    conditionalFormat2 = conditionalFormat;
                                                    objRecord2 = objRecord;
                                                    msoDrawingRecord2 = msoDrawingRecord;
                                                    autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                    z2 = z;
                                                    hashMap = hashMap2;
                                                    arrayList = arrayList2;
                                                    baseSharedFormulaRecord = null;
                                                }
                                            }
                                            baseSharedFormulaRecord3 = baseSharedFormulaRecord;
                                            WorkbookParser workbookParser2 = this.workbook;
                                            this.sharedFormulas.add(new SharedFormulaRecord(next, baseSharedFormulaRecord3, workbookParser2, workbookParser2, this.sheet));
                                            filterModeRecord2 = filterModeRecord;
                                            conditionalFormat2 = conditionalFormat;
                                            objRecord2 = objRecord;
                                            msoDrawingRecord2 = msoDrawingRecord;
                                            autoFilterInfoRecord3 = autoFilterInfoRecord;
                                            z2 = z;
                                            hashMap = hashMap2;
                                            arrayList = arrayList2;
                                            baseSharedFormulaRecord = null;
                                        } else if (type == Type.FORMULA || type == Type.FORMULA2) {
                                            hashMap = hashMap2;
                                            arrayList = arrayList2;
                                            File file = this.excelFile;
                                            FormattingRecords formattingRecords = this.formattingRecords;
                                            WorkbookParser workbookParser3 = this.workbook;
                                            FormulaRecord formulaRecord = new FormulaRecord(next, file, formattingRecords, workbookParser3, workbookParser3, this.sheet, this.workbookSettings);
                                            if (formulaRecord.isShared()) {
                                                baseSharedFormulaRecord2 = (BaseSharedFormulaRecord) formulaRecord.getFormula();
                                                z4 = addToSharedFormulas(baseSharedFormulaRecord2);
                                                if (z4) {
                                                    baseSharedFormulaRecord2 = baseSharedFormulaRecord;
                                                }
                                                if (!z4 && baseSharedFormulaRecord != null) {
                                                    addCell(revertSharedFormula(baseSharedFormulaRecord));
                                                }
                                            } else {
                                                Cell formula = formulaRecord.getFormula();
                                                try {
                                                    if (formulaRecord.getFormula().getType() == CellType.NUMBER_FORMULA) {
                                                        NumberFormulaRecord numberFormulaRecord = (NumberFormulaRecord) formulaRecord.getFormula();
                                                        if (this.formattingRecords.isDate(numberFormulaRecord.getXFIndex())) {
                                                            FormattingRecords formattingRecords2 = this.formattingRecords;
                                                            WorkbookParser workbookParser4 = this.workbook;
                                                            formula = new DateFormulaRecord(numberFormulaRecord, formattingRecords2, workbookParser4, workbookParser4, this.nineteenFour, this.sheet);
                                                        }
                                                    }
                                                    addCell(formula);
                                                } catch (FormulaException e) {
                                                    Logger logger3 = logger;
                                                    StringBuffer stringBuffer2 = new StringBuffer();
                                                    stringBuffer2.append(CellReferenceHelper.getCellReference(formula.getColumn(), formula.getRow()));
                                                    stringBuffer2.append(" ");
                                                    stringBuffer2.append(e.getMessage());
                                                    logger3.warn(stringBuffer2.toString());
                                                }
                                                baseSharedFormulaRecord2 = baseSharedFormulaRecord;
                                            }
                                            baseSharedFormulaRecord = baseSharedFormulaRecord2;
                                        } else {
                                            if (type == Type.LABEL) {
                                                blankCell = this.workbookBof.isBiff8() ? new LabelRecord(next, this.formattingRecords, this.sheet, this.workbookSettings) : new LabelRecord(next, this.formattingRecords, this.sheet, this.workbookSettings, LabelRecord.biff7);
                                            } else if (type == Type.RSTRING) {
                                                Assert.verify(!this.workbookBof.isBiff8());
                                                blankCell = new RStringRecord(next, this.formattingRecords, this.sheet, this.workbookSettings, RStringRecord.biff7);
                                            } else if (type != Type.NAME) {
                                                if (type == Type.PASSWORD) {
                                                    this.settings.setPasswordHash(new PasswordRecord(next).getPasswordHash());
                                                } else if (type == Type.ROW) {
                                                    RowRecord rowRecord = new RowRecord(next);
                                                    if (!rowRecord.isDefaultHeight() || !rowRecord.matchesDefaultFontHeight() || rowRecord.isCollapsed() || rowRecord.hasDefaultFormat() || rowRecord.getOutlineLevel() != 0) {
                                                        arrayList3 = this.rowProperties;
                                                        columnInfoRecord = rowRecord;
                                                        arrayList3.add(columnInfoRecord);
                                                    }
                                                } else if (type == Type.BLANK) {
                                                    if (!this.workbookSettings.getIgnoreBlanks()) {
                                                        blankCell = new BlankCell(next, this.formattingRecords, this.sheet);
                                                    }
                                                } else if (type == Type.MULBLANK) {
                                                    if (!this.workbookSettings.getIgnoreBlanks()) {
                                                        MulBlankRecord mulBlankRecord = new MulBlankRecord(next);
                                                        int i7 = 0;
                                                        for (int numberOfColumns3 = mulBlankRecord.getNumberOfColumns(); i7 < numberOfColumns3; numberOfColumns3 = numberOfColumns3) {
                                                            addCell(new MulBlankCell(mulBlankRecord.getRow(), mulBlankRecord.getFirstColumn() + i7, mulBlankRecord.getXFIndex(i7), this.formattingRecords, this.sheet));
                                                            i7++;
                                                        }
                                                    }
                                                } else if (type == Type.SCL) {
                                                    this.settings.setZoomFactor(new SCLRecord(next).getZoomFactor());
                                                } else if (type == Type.COLINFO) {
                                                    ColumnInfoRecord columnInfoRecord2 = new ColumnInfoRecord(next);
                                                    arrayList3 = this.columnInfosArray;
                                                    columnInfoRecord = columnInfoRecord2;
                                                    arrayList3.add(columnInfoRecord);
                                                } else if (type == Type.HEADER) {
                                                    this.settings.setHeader(new HeaderFooter((this.workbookBof.isBiff8() ? new HeaderRecord(next, this.workbookSettings) : new HeaderRecord(next, this.workbookSettings, HeaderRecord.biff7)).getHeader()));
                                                } else if (type == Type.FOOTER) {
                                                    this.settings.setFooter(new HeaderFooter((this.workbookBof.isBiff8() ? new FooterRecord(next, this.workbookSettings) : new FooterRecord(next, this.workbookSettings, FooterRecord.biff7)).getFooter()));
                                                } else if (type == Type.SETUP) {
                                                    SetupRecord setupRecord = new SetupRecord(next);
                                                    if (setupRecord.getInitialized()) {
                                                        if (setupRecord.isPortrait()) {
                                                            sheetSettings = this.settings;
                                                            pageOrientation = PageOrientation.PORTRAIT;
                                                        } else {
                                                            sheetSettings = this.settings;
                                                            pageOrientation = PageOrientation.LANDSCAPE;
                                                        }
                                                        sheetSettings.setOrientation(pageOrientation);
                                                        if (setupRecord.isRightDown()) {
                                                            sheetSettings2 = this.settings;
                                                            pageOrder = PageOrder.RIGHT_THEN_DOWN;
                                                        } else {
                                                            sheetSettings2 = this.settings;
                                                            pageOrder = PageOrder.DOWN_THEN_RIGHT;
                                                        }
                                                        sheetSettings2.setPageOrder(pageOrder);
                                                        this.settings.setPaperSize(PaperSize.getPaperSize(setupRecord.getPaperSize()));
                                                        this.settings.setHeaderMargin(setupRecord.getHeaderMargin());
                                                        this.settings.setFooterMargin(setupRecord.getFooterMargin());
                                                        this.settings.setScaleFactor(setupRecord.getScaleFactor());
                                                        this.settings.setPageStart(setupRecord.getPageStart());
                                                        this.settings.setFitWidth(setupRecord.getFitWidth());
                                                        this.settings.setFitHeight(setupRecord.getFitHeight());
                                                        this.settings.setHorizontalPrintResolution(setupRecord.getHorizontalPrintResolution());
                                                        this.settings.setVerticalPrintResolution(setupRecord.getVerticalPrintResolution());
                                                        this.settings.setCopies(setupRecord.getCopies());
                                                        WorkspaceInformationRecord workspaceInformationRecord = this.workspaceOptions;
                                                        if (workspaceInformationRecord != null) {
                                                            this.settings.setFitToPages(workspaceInformationRecord.getFitToPages());
                                                        }
                                                    }
                                                } else if (type == Type.WSBOOL) {
                                                    this.workspaceOptions = new WorkspaceInformationRecord(next);
                                                } else if (type == Type.DEFCOLWIDTH) {
                                                    this.settings.setDefaultColumnWidth(new DefaultColumnWidthRecord(next).getWidth());
                                                } else if (type == Type.DEFAULTROWHEIGHT) {
                                                    DefaultRowHeightRecord defaultRowHeightRecord = new DefaultRowHeightRecord(next);
                                                    if (defaultRowHeightRecord.getHeight() != 0) {
                                                        this.settings.setDefaultRowHeight(defaultRowHeightRecord.getHeight());
                                                    }
                                                } else {
                                                    if (type == Type.CONDFMT) {
                                                        conditionalFormat2 = new ConditionalFormat(new ConditionalFormatRangeRecord(next));
                                                        this.conditionalFormats.add(conditionalFormat2);
                                                        filterModeRecord2 = filterModeRecord;
                                                    } else if (type == Type.CF) {
                                                        conditionalFormat.addCondition(new ConditionalFormatRecord(next));
                                                    } else if (type == Type.FILTERMODE) {
                                                        filterModeRecord2 = new FilterModeRecord(next);
                                                        conditionalFormat2 = conditionalFormat;
                                                    } else {
                                                        if (type == Type.AUTOFILTERINFO) {
                                                            autoFilterInfoRecord3 = new AutoFilterInfoRecord(next);
                                                            filterModeRecord2 = filterModeRecord;
                                                        } else if (type == Type.AUTOFILTER) {
                                                            if (!this.workbookSettings.getAutoFilterDisabled()) {
                                                                AutoFilterRecord autoFilterRecord = new AutoFilterRecord(next);
                                                                if (this.autoFilter == null) {
                                                                    this.autoFilter = new AutoFilter(filterModeRecord, autoFilterInfoRecord);
                                                                    autoFilterInfoRecord3 = null;
                                                                    filterModeRecord2 = null;
                                                                } else {
                                                                    filterModeRecord2 = filterModeRecord;
                                                                    autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                                }
                                                                this.autoFilter.add(autoFilterRecord);
                                                            }
                                                        } else if (type == Type.LEFTMARGIN) {
                                                            this.settings.setLeftMargin(new LeftMarginRecord(next).getMargin());
                                                        } else if (type == Type.RIGHTMARGIN) {
                                                            this.settings.setRightMargin(new RightMarginRecord(next).getMargin());
                                                        } else if (type == Type.TOPMARGIN) {
                                                            this.settings.setTopMargin(new TopMarginRecord(next).getMargin());
                                                        } else if (type == Type.BOTTOMMARGIN) {
                                                            this.settings.setBottomMargin(new BottomMarginRecord(next).getMargin());
                                                        } else if (type == Type.HORIZONTALPAGEBREAKS) {
                                                            this.rowBreaks = (this.workbookBof.isBiff8() ? new HorizontalPageBreaksRecord(next) : new HorizontalPageBreaksRecord(next, HorizontalPageBreaksRecord.biff7)).getRowBreaks();
                                                        } else if (type == Type.VERTICALPAGEBREAKS) {
                                                            this.columnBreaks = (this.workbookBof.isBiff8() ? new VerticalPageBreaksRecord(next) : new VerticalPageBreaksRecord(next, VerticalPageBreaksRecord.biff7)).getColumnBreaks();
                                                        } else if (type == Type.PLS) {
                                                            this.plsRecord = new PLSRecord(next);
                                                        } else if (type != Type.DVAL) {
                                                            arrayList = arrayList2;
                                                            if (type == Type.HCENTER) {
                                                                this.settings.setHorizontalCentre(new CentreRecord(next).isCentre());
                                                            } else if (type == Type.VCENTER) {
                                                                this.settings.setVerticalCentre(new CentreRecord(next).isCentre());
                                                            } else if (type != Type.DV) {
                                                                if (type == Type.OBJ) {
                                                                    objRecord2 = new ObjRecord(next);
                                                                    if (this.workbookSettings.getDrawingsDisabled()) {
                                                                        hashMap = hashMap2;
                                                                        msoDrawingRecord2 = msoDrawingRecord;
                                                                    } else {
                                                                        if (msoDrawingRecord != null || continueRecord == null) {
                                                                            msoDrawingRecord2 = msoDrawingRecord;
                                                                            hashMap = hashMap2;
                                                                        } else {
                                                                            logger.warn("Cannot find drawing record - using continue record");
                                                                            msoDrawingRecord2 = new MsoDrawingRecord(continueRecord.getRecord());
                                                                            hashMap = hashMap2;
                                                                            continueRecord = null;
                                                                        }
                                                                        handleObjectRecord(objRecord2, msoDrawingRecord2, hashMap);
                                                                        arrayList.add(new Integer(objRecord2.getObjectId()));
                                                                    }
                                                                    if (objRecord2.getType() != ObjRecord.CHART) {
                                                                        filterModeRecord2 = filterModeRecord;
                                                                        conditionalFormat2 = conditionalFormat;
                                                                        autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                                        z2 = z;
                                                                        objRecord2 = null;
                                                                        msoDrawingRecord2 = null;
                                                                    }
                                                                    filterModeRecord2 = filterModeRecord;
                                                                    conditionalFormat2 = conditionalFormat;
                                                                } else {
                                                                    hashMap = hashMap2;
                                                                    if (type == Type.MSODRAWING) {
                                                                        if (!this.workbookSettings.getDrawingsDisabled()) {
                                                                            if (msoDrawingRecord != null) {
                                                                                this.drawingData.addRawData(msoDrawingRecord.getData());
                                                                            }
                                                                            msoDrawingRecord2 = new MsoDrawingRecord(next);
                                                                            if (z3) {
                                                                                msoDrawingRecord2.setFirst();
                                                                                filterModeRecord2 = filterModeRecord;
                                                                                conditionalFormat2 = conditionalFormat;
                                                                                objRecord2 = objRecord;
                                                                                autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                                                z2 = z;
                                                                                z3 = false;
                                                                            } else {
                                                                                filterModeRecord2 = filterModeRecord;
                                                                                conditionalFormat2 = conditionalFormat;
                                                                                objRecord2 = objRecord;
                                                                            }
                                                                        }
                                                                    } else if (type == Type.BUTTONPROPERTYSET) {
                                                                        this.buttonPropertySet = new ButtonPropertySetRecord(next);
                                                                    } else if (type == Type.CALCMODE) {
                                                                        this.settings.setAutomaticFormulaCalculation(new CalcModeRecord(next).isAutomatic());
                                                                    } else if (type == Type.SAVERECALC) {
                                                                        this.settings.setRecalculateFormulasBeforeSave(new SaveRecalcRecord(next).getRecalculateOnSave());
                                                                    } else if (type == Type.GUTS) {
                                                                        GuttersRecord guttersRecord = new GuttersRecord(next);
                                                                        if (guttersRecord.getRowOutlineLevel() > 0) {
                                                                            i = 1;
                                                                            i2 = guttersRecord.getRowOutlineLevel() - 1;
                                                                        } else {
                                                                            i = 1;
                                                                            i2 = 0;
                                                                        }
                                                                        this.maxRowOutlineLevel = i2;
                                                                        this.maxColumnOutlineLevel = guttersRecord.getColumnOutlineLevel() > 0 ? guttersRecord.getRowOutlineLevel() - i : 0;
                                                                    } else if (type == Type.BOF) {
                                                                        BOFRecord bOFRecord = new BOFRecord(next);
                                                                        Assert.verify(!bOFRecord.isWorksheet());
                                                                        int pos = (this.excelFile.getPos() - next.getLength()) - 4;
                                                                        do {
                                                                        } while (this.excelFile.next().getCode() != Type.EOF.value);
                                                                        if (bOFRecord.isChart()) {
                                                                            if (this.workbook.getWorkbookBof().isBiff8()) {
                                                                                if (this.drawingData == null) {
                                                                                    this.drawingData = new DrawingData();
                                                                                }
                                                                                if (!this.workbookSettings.getDrawingsDisabled()) {
                                                                                    Chart chart = new Chart(msoDrawingRecord, objRecord, this.drawingData, pos, this.excelFile.getPos(), this.excelFile, this.workbookSettings);
                                                                                    this.charts.add(chart);
                                                                                    if (this.workbook.getDrawingGroup() != null) {
                                                                                        this.workbook.getDrawingGroup().add(chart);
                                                                                    }
                                                                                }
                                                                            } else {
                                                                                logger.warn("only biff8 charts are supported");
                                                                            }
                                                                            objRecord2 = null;
                                                                            msoDrawingRecord2 = null;
                                                                        } else {
                                                                            objRecord2 = objRecord;
                                                                            msoDrawingRecord2 = msoDrawingRecord;
                                                                        }
                                                                        if (this.sheetBof.isChart()) {
                                                                            z = false;
                                                                        }
                                                                        filterModeRecord2 = filterModeRecord;
                                                                        conditionalFormat2 = conditionalFormat;
                                                                    } else if (type == Type.EOF) {
                                                                        filterModeRecord2 = filterModeRecord;
                                                                        conditionalFormat2 = conditionalFormat;
                                                                        objRecord2 = objRecord;
                                                                        msoDrawingRecord2 = msoDrawingRecord;
                                                                        autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                                        z2 = false;
                                                                    }
                                                                }
                                                                autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                                z2 = z;
                                                            } else if (!this.workbookSettings.getCellValidationDisabled()) {
                                                                WorkbookParser workbookParser5 = this.workbook;
                                                                DataValiditySettingsRecord dataValiditySettingsRecord = new DataValiditySettingsRecord(next, workbookParser5, workbookParser5, workbookParser5.getSettings());
                                                                DataValidation dataValidation = this.dataValidation;
                                                                if (dataValidation != null) {
                                                                    dataValidation.add(dataValiditySettingsRecord);
                                                                    addCellValidation(dataValiditySettingsRecord.getFirstColumn(), dataValiditySettingsRecord.getFirstRow(), dataValiditySettingsRecord.getLastColumn(), dataValiditySettingsRecord.getLastRow(), dataValiditySettingsRecord);
                                                                } else {
                                                                    logger.warn("cannot add data validity settings");
                                                                }
                                                            }
                                                            hashMap = hashMap2;
                                                        } else if (this.workbookSettings.getCellValidationDisabled()) {
                                                            arrayList = arrayList2;
                                                            hashMap = hashMap2;
                                                        } else {
                                                            DataValidityListRecord dataValidityListRecord = new DataValidityListRecord(next);
                                                            if (dataValidityListRecord.getObjectId() != -1) {
                                                                arrayList = arrayList2;
                                                                if (arrayList.contains(new Integer(dataValidityListRecord.getObjectId()))) {
                                                                    this.dataValidation = new DataValidation(dataValidityListRecord);
                                                                } else {
                                                                    Logger logger4 = logger;
                                                                    StringBuffer stringBuffer3 = new StringBuffer();
                                                                    stringBuffer3.append("object id ");
                                                                    stringBuffer3.append(dataValidityListRecord.getObjectId());
                                                                    stringBuffer3.append(" referenced ");
                                                                    stringBuffer3.append(" by data validity list record not found - ignoring");
                                                                    logger4.warn(stringBuffer3.toString());
                                                                }
                                                            } else if (msoDrawingRecord == null || objRecord != null) {
                                                                this.dataValidation = new DataValidation(dataValidityListRecord);
                                                                arrayList = arrayList2;
                                                            } else {
                                                                if (this.drawingData == null) {
                                                                    this.drawingData = new DrawingData();
                                                                }
                                                                this.drawings.add(new Drawing2(msoDrawingRecord, this.drawingData, this.workbook.getDrawingGroup()));
                                                                this.dataValidation = new DataValidation(dataValidityListRecord);
                                                                arrayList = arrayList2;
                                                                msoDrawingRecord2 = null;
                                                                filterModeRecord2 = filterModeRecord;
                                                                conditionalFormat2 = conditionalFormat;
                                                                objRecord2 = objRecord;
                                                                autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                                z2 = z;
                                                                hashMap = hashMap2;
                                                            }
                                                            msoDrawingRecord2 = msoDrawingRecord;
                                                            filterModeRecord2 = filterModeRecord;
                                                            conditionalFormat2 = conditionalFormat;
                                                            objRecord2 = objRecord;
                                                            autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                            z2 = z;
                                                            hashMap = hashMap2;
                                                        }
                                                        conditionalFormat2 = conditionalFormat;
                                                        objRecord2 = objRecord;
                                                        msoDrawingRecord2 = msoDrawingRecord;
                                                        z2 = z;
                                                        hashMap = hashMap2;
                                                        arrayList = arrayList2;
                                                    }
                                                    objRecord2 = objRecord;
                                                    msoDrawingRecord2 = msoDrawingRecord;
                                                    autoFilterInfoRecord3 = autoFilterInfoRecord;
                                                    z2 = z;
                                                    hashMap = hashMap2;
                                                    arrayList = arrayList2;
                                                }
                                            }
                                            addCell(blankCell);
                                        }
                                        hashMap3 = hashMap;
                                        arrayList4 = arrayList;
                                        baseSharedFormulaRecord4 = baseSharedFormulaRecord;
                                        c2 = 1;
                                        i3 = 0;
                                    }
                                }
                            }
                            hashMap = hashMap2;
                            arrayList = arrayList2;
                        }
                        baseSharedFormulaRecord = baseSharedFormulaRecord4;
                        hashMap = hashMap3;
                        arrayList = arrayList4;
                        autoFilterInfoRecord3 = autoFilterInfoRecord4;
                        hashMap3 = hashMap;
                        arrayList4 = arrayList;
                        baseSharedFormulaRecord4 = baseSharedFormulaRecord;
                        c2 = 1;
                        i3 = 0;
                    }
                    objRecord = objRecord2;
                    baseSharedFormulaRecord = baseSharedFormulaRecord4;
                    msoDrawingRecord = msoDrawingRecord2;
                    hashMap = hashMap3;
                    arrayList = arrayList4;
                    z = z2;
                    autoFilterInfoRecord = autoFilterInfoRecord4;
                    filterModeRecord = filterModeRecord2;
                    conditionalFormat = conditionalFormat2;
                }
                filterModeRecord2 = filterModeRecord;
                conditionalFormat2 = conditionalFormat;
                objRecord2 = objRecord;
                msoDrawingRecord2 = msoDrawingRecord;
                autoFilterInfoRecord3 = autoFilterInfoRecord;
                z2 = z;
                hashMap3 = hashMap;
                arrayList4 = arrayList;
                baseSharedFormulaRecord4 = baseSharedFormulaRecord;
                c2 = 1;
                i3 = 0;
            }
            objRecord = objRecord2;
            baseSharedFormulaRecord = baseSharedFormulaRecord4;
            msoDrawingRecord = msoDrawingRecord2;
            hashMap = hashMap3;
            arrayList = arrayList4;
            z = z2;
            autoFilterInfoRecord = autoFilterInfoRecord3;
            filterModeRecord = filterModeRecord2;
            conditionalFormat = conditionalFormat2;
            filterModeRecord2 = filterModeRecord;
            conditionalFormat2 = conditionalFormat;
            objRecord2 = objRecord;
            msoDrawingRecord2 = msoDrawingRecord;
            autoFilterInfoRecord3 = autoFilterInfoRecord;
            z2 = z;
            hashMap3 = hashMap;
            arrayList4 = arrayList;
            baseSharedFormulaRecord4 = baseSharedFormulaRecord;
            c2 = 1;
            i3 = 0;
        }
        ObjRecord objRecord3 = objRecord2;
        BaseSharedFormulaRecord baseSharedFormulaRecord5 = baseSharedFormulaRecord4;
        MsoDrawingRecord msoDrawingRecord3 = msoDrawingRecord2;
        HashMap hashMap4 = hashMap3;
        this.excelFile.restorePos();
        if (this.outOfBoundsCells.size() > 0) {
            handleOutOfBoundsCells();
        }
        Iterator it = this.sharedFormulas.iterator();
        while (it.hasNext()) {
            for (Cell cell : ((SharedFormulaRecord) it.next()).getFormulas(this.formattingRecords, this.nineteenFour)) {
                addCell(cell);
            }
        }
        if (!z4 && baseSharedFormulaRecord5 != null) {
            addCell(revertSharedFormula(baseSharedFormulaRecord5));
        }
        if (msoDrawingRecord3 != null && this.workbook.getDrawingGroup() != null) {
            this.workbook.getDrawingGroup().setDrawingsOmitted(msoDrawingRecord3, objRecord3);
        }
        if (hashMap4.isEmpty()) {
            return;
        }
        logger.warn("Not all comments have a corresponding Note record");
    }
}
