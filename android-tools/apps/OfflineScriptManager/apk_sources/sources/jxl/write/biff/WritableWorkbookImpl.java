package jxl.write.biff;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import jxl.Range;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.biff.BuiltInName;
import jxl.biff.CellReferenceHelper;
import jxl.biff.CountryCode;
import jxl.biff.Fonts;
import jxl.biff.FormattingRecords;
import jxl.biff.IndexMapping;
import jxl.biff.IntegerHelper;
import jxl.biff.RangeImpl;
import jxl.biff.WorkbookMethods;
import jxl.biff.XCTRecord;
import jxl.biff.drawing.Drawing;
import jxl.biff.drawing.DrawingGroup;
import jxl.biff.drawing.DrawingGroupObject;
import jxl.biff.drawing.Origin;
import jxl.biff.formula.ExternalSheet;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.Colour;
import jxl.format.RGB;
import jxl.read.biff.WorkbookParser;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.biff.NameRecord;
/* loaded from: classes.dex */
public class WritableWorkbookImpl extends WritableWorkbook implements ExternalSheet, WorkbookMethods {
    private static Object SYNCHRONIZER;
    static /* synthetic */ Class class$jxl$write$biff$WritableWorkbookImpl;
    private static Logger logger;
    private String[] addInFunctionNames;
    private ButtonPropertySetRecord buttonPropertySet;
    private boolean closeStream;
    private boolean containsMacros;
    private CountryRecord countryRecord;
    private DrawingGroup drawingGroup;
    private ExternalSheetRecord externSheet;
    private Fonts fonts;
    private FormattingRecords formatRecords;
    private HashMap nameRecords;
    private ArrayList names;
    private File outputFile;
    private ArrayList rcirCells;
    private WorkbookSettings settings;
    private SharedStrings sharedStrings;
    private ArrayList sheets;
    private Styles styles;
    private ArrayList supbooks;
    private boolean wbProtected;
    private XCTRecord[] xctRecords;

    static {
        Class cls = class$jxl$write$biff$WritableWorkbookImpl;
        if (cls == null) {
            cls = class$("jxl.write.biff.WritableWorkbookImpl");
            class$jxl$write$biff$WritableWorkbookImpl = cls;
        }
        logger = Logger.getLogger(cls);
        SYNCHRONIZER = new Object();
    }

    public WritableWorkbookImpl(OutputStream outputStream, Workbook workbook, boolean z, WorkbookSettings workbookSettings) {
        WorkbookParser workbookParser = (WorkbookParser) workbook;
        synchronized (SYNCHRONIZER) {
            WritableWorkbook.ARIAL_10_PT.uninitialize();
            WritableWorkbook.HYPERLINK_FONT.uninitialize();
            WritableWorkbook.NORMAL_STYLE.uninitialize();
            WritableWorkbook.HYPERLINK_STYLE.uninitialize();
            WritableWorkbook.HIDDEN_STYLE.uninitialize();
            DateRecord.defaultDateFormat.uninitialize();
        }
        this.closeStream = z;
        this.sheets = new ArrayList();
        this.sharedStrings = new SharedStrings();
        this.nameRecords = new HashMap();
        this.fonts = workbookParser.getFonts();
        this.formatRecords = workbookParser.getFormattingRecords();
        this.wbProtected = false;
        this.settings = workbookSettings;
        this.rcirCells = new ArrayList();
        this.styles = new Styles();
        this.outputFile = new File(outputStream, workbookSettings, workbookParser.getCompoundFile());
        this.containsMacros = false;
        if (!workbookSettings.getPropertySetsDisabled()) {
            this.containsMacros = workbookParser.containsMacros();
        }
        if (workbookParser.getCountryRecord() != null) {
            this.countryRecord = new CountryRecord(workbookParser.getCountryRecord());
        }
        this.addInFunctionNames = workbookParser.getAddInFunctionNames();
        this.xctRecords = workbookParser.getXCTRecords();
        if (workbookParser.getExternalSheetRecord() != null) {
            this.externSheet = new ExternalSheetRecord(workbookParser.getExternalSheetRecord());
            jxl.read.biff.SupbookRecord[] supbookRecords = workbookParser.getSupbookRecords();
            this.supbooks = new ArrayList(supbookRecords.length);
            for (jxl.read.biff.SupbookRecord supbookRecord : supbookRecords) {
                if (supbookRecord.getType() == jxl.read.biff.SupbookRecord.INTERNAL || supbookRecord.getType() == jxl.read.biff.SupbookRecord.EXTERNAL) {
                    this.supbooks.add(new SupbookRecord(supbookRecord, this.settings));
                } else if (supbookRecord.getType() != jxl.read.biff.SupbookRecord.ADDIN) {
                    logger.warn("unsupported supbook type - ignoring");
                }
            }
        }
        if (workbookParser.getDrawingGroup() != null) {
            this.drawingGroup = new DrawingGroup(workbookParser.getDrawingGroup());
        }
        if (this.containsMacros && workbookParser.getButtonPropertySet() != null) {
            this.buttonPropertySet = new ButtonPropertySetRecord(workbookParser.getButtonPropertySet());
        }
        if (!this.settings.getNamesDisabled()) {
            jxl.read.biff.NameRecord[] nameRecords = workbookParser.getNameRecords();
            this.names = new ArrayList(nameRecords.length);
            for (int i = 0; i < nameRecords.length; i++) {
                if (nameRecords[i].isBiff8()) {
                    NameRecord nameRecord = new NameRecord(nameRecords[i], i);
                    this.names.add(nameRecord);
                    this.nameRecords.put(nameRecord.getName(), nameRecord);
                } else {
                    logger.warn("Cannot copy Biff7 name records - ignoring");
                }
            }
        }
        copyWorkbook(workbook);
        DrawingGroup drawingGroup = this.drawingGroup;
        if (drawingGroup != null) {
            drawingGroup.updateData(workbookParser.getDrawingGroup());
        }
    }

    public WritableWorkbookImpl(OutputStream outputStream, boolean z, WorkbookSettings workbookSettings) {
        this.outputFile = new File(outputStream, workbookSettings, null);
        this.sheets = new ArrayList();
        this.sharedStrings = new SharedStrings();
        this.nameRecords = new HashMap();
        this.closeStream = z;
        this.wbProtected = false;
        this.containsMacros = false;
        this.settings = workbookSettings;
        this.rcirCells = new ArrayList();
        this.styles = new Styles();
        synchronized (SYNCHRONIZER) {
            WritableWorkbook.ARIAL_10_PT.uninitialize();
            WritableWorkbook.HYPERLINK_FONT.uninitialize();
            WritableWorkbook.NORMAL_STYLE.uninitialize();
            WritableWorkbook.HYPERLINK_STYLE.uninitialize();
            WritableWorkbook.HIDDEN_STYLE.uninitialize();
            DateRecord.defaultDateFormat.uninitialize();
        }
        this.fonts = new WritableFonts(this);
        this.formatRecords = new WritableFormattingRecords(this.fonts, this.styles);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void copyWorkbook(Workbook workbook) {
        int numberOfSheets = workbook.getNumberOfSheets();
        this.wbProtected = workbook.isProtected();
        for (int i = 0; i < numberOfSheets; i++) {
            Sheet sheet = workbook.getSheet(i);
            ((WritableSheetImpl) createSheet(sheet.getName(), i, false)).copy(sheet);
        }
    }

    private WritableSheet createSheet(String str, int i, boolean z) {
        ExternalSheetRecord externalSheetRecord;
        WritableSheetImpl writableSheetImpl = new WritableSheetImpl(str, this.outputFile, this.formatRecords, this.sharedStrings, this.settings, this);
        if (i <= 0) {
            this.sheets.add(0, writableSheetImpl);
            i = 0;
        } else if (i > this.sheets.size()) {
            i = this.sheets.size();
            this.sheets.add(writableSheetImpl);
        } else {
            this.sheets.add(i, writableSheetImpl);
        }
        if (z && (externalSheetRecord = this.externSheet) != null) {
            externalSheetRecord.sheetInserted(i);
        }
        ArrayList arrayList = this.supbooks;
        if (arrayList != null && arrayList.size() > 0) {
            SupbookRecord supbookRecord = (SupbookRecord) this.supbooks.get(0);
            if (supbookRecord.getType() == SupbookRecord.INTERNAL) {
                supbookRecord.adjustInternal(this.sheets.size());
            }
        }
        return writableSheetImpl;
    }

    private int getInternalSheetIndex(String str) {
        String[] sheetNames = getSheetNames();
        for (int i = 0; i < sheetNames.length; i++) {
            if (str.equals(sheetNames[i])) {
                return i;
            }
        }
        return -1;
    }

    private void rationalize() {
        IndexMapping rationalizeFonts = this.formatRecords.rationalizeFonts();
        IndexMapping rationalizeDisplayFormats = this.formatRecords.rationalizeDisplayFormats();
        IndexMapping rationalize = this.formatRecords.rationalize(rationalizeFonts, rationalizeDisplayFormats);
        for (int i = 0; i < this.sheets.size(); i++) {
            ((WritableSheetImpl) this.sheets.get(i)).rationalize(rationalize, rationalizeFonts, rationalizeDisplayFormats);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addDrawing(DrawingGroupObject drawingGroupObject) {
        if (this.drawingGroup == null) {
            this.drawingGroup = new DrawingGroup(Origin.WRITE);
        }
        this.drawingGroup.add(drawingGroupObject);
    }

    @Override // jxl.write.WritableWorkbook
    public void addNameArea(String str, WritableSheet writableSheet, int i, int i2, int i3, int i4) {
        addNameArea(str, writableSheet, i, i2, i3, i4, true);
    }

    void addNameArea(String str, WritableSheet writableSheet, int i, int i2, int i3, int i4, boolean z) {
        if (this.names == null) {
            this.names = new ArrayList();
        }
        NameRecord nameRecord = new NameRecord(str, this.names.size(), getExternalSheetIndex(writableSheet.getName()), i2, i4, i, i3, z);
        this.names.add(nameRecord);
        this.nameRecords.put(str, nameRecord);
    }

    void addNameArea(BuiltInName builtInName, WritableSheet writableSheet, int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, boolean z) {
        if (this.names == null) {
            this.names = new ArrayList();
        }
        NameRecord nameRecord = new NameRecord(builtInName, getInternalSheetIndex(writableSheet.getName()), getExternalSheetIndex(writableSheet.getName()), i6, i8, i5, i7, i2, i4, i, i3, z);
        this.names.add(nameRecord);
        this.nameRecords.put(builtInName, nameRecord);
    }

    void addNameArea(BuiltInName builtInName, WritableSheet writableSheet, int i, int i2, int i3, int i4, boolean z) {
        if (this.names == null) {
            this.names = new ArrayList();
        }
        NameRecord nameRecord = new NameRecord(builtInName, getInternalSheetIndex(writableSheet.getName()), getExternalSheetIndex(writableSheet.getName()), i2, i4, i, i3, z);
        this.names.add(nameRecord);
        this.nameRecords.put(builtInName, nameRecord);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addRCIRCell(CellValue cellValue) {
        this.rcirCells.add(cellValue);
    }

    @Override // jxl.write.WritableWorkbook
    public void close() {
        this.outputFile.close(this.closeStream);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void columnInserted(WritableSheetImpl writableSheetImpl, int i) {
        int externalSheetIndex = getExternalSheetIndex(writableSheetImpl.getName());
        Iterator it = this.rcirCells.iterator();
        while (it.hasNext()) {
            ((CellValue) it.next()).columnInserted(writableSheetImpl, externalSheetIndex, i);
        }
        ArrayList arrayList = this.names;
        if (arrayList != null) {
            Iterator it2 = arrayList.iterator();
            while (it2.hasNext()) {
                ((NameRecord) it2.next()).columnInserted(externalSheetIndex, i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void columnRemoved(WritableSheetImpl writableSheetImpl, int i) {
        int externalSheetIndex = getExternalSheetIndex(writableSheetImpl.getName());
        Iterator it = this.rcirCells.iterator();
        while (it.hasNext()) {
            ((CellValue) it.next()).columnRemoved(writableSheetImpl, externalSheetIndex, i);
        }
        ArrayList arrayList = new ArrayList();
        ArrayList arrayList2 = this.names;
        if (arrayList2 != null) {
            Iterator it2 = arrayList2.iterator();
            while (it2.hasNext()) {
                NameRecord nameRecord = (NameRecord) it2.next();
                if (nameRecord.columnRemoved(externalSheetIndex, i)) {
                    arrayList.add(nameRecord);
                }
            }
            Iterator it3 = arrayList.iterator();
            while (it3.hasNext()) {
                NameRecord nameRecord2 = (NameRecord) it3.next();
                boolean remove = this.names.remove(nameRecord2);
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Could not remove name ");
                stringBuffer.append(nameRecord2.getName());
                Assert.verify(remove, stringBuffer.toString());
            }
        }
    }

    @Override // jxl.write.WritableWorkbook
    public void copySheet(int i, String str, int i2) {
        ((WritableSheetImpl) createSheet(str, i2)).copy(getSheet(i));
    }

    @Override // jxl.write.WritableWorkbook
    public void copySheet(String str, String str2, int i) {
        ((WritableSheetImpl) createSheet(str2, i)).copy(getSheet(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DrawingGroup createDrawingGroup() {
        if (this.drawingGroup == null) {
            this.drawingGroup = new DrawingGroup(Origin.WRITE);
        }
        return this.drawingGroup;
    }

    @Override // jxl.write.WritableWorkbook
    public WritableSheet createSheet(String str, int i) {
        return createSheet(str, i, true);
    }

    @Override // jxl.write.WritableWorkbook
    public Range[] findByName(String str) {
        NameRecord nameRecord = (NameRecord) this.nameRecords.get(str);
        if (nameRecord == null) {
            return null;
        }
        NameRecord.NameRange[] ranges = nameRecord.getRanges();
        Range[] rangeArr = new Range[ranges.length];
        for (int i = 0; i < ranges.length; i++) {
            rangeArr[i] = new RangeImpl(this, getExternalSheetIndex(ranges[i].getExternalSheet()), ranges[i].getFirstColumn(), ranges[i].getFirstRow(), getLastExternalSheetIndex(ranges[i].getExternalSheet()), ranges[i].getLastColumn(), ranges[i].getLastRow());
        }
        return rangeArr;
    }

    @Override // jxl.write.WritableWorkbook
    public WritableCell findCellByName(String str) {
        NameRecord nameRecord = (NameRecord) this.nameRecords.get(str);
        if (nameRecord == null) {
            return null;
        }
        NameRecord.NameRange[] ranges = nameRecord.getRanges();
        return getSheet(getExternalSheetIndex(ranges[0].getExternalSheet())).getWritableCell(ranges[0].getFirstColumn(), ranges[0].getFirstRow());
    }

    public RGB getColourRGB(Colour colour) {
        return this.formatRecords.getColourRGB(colour);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DrawingGroup getDrawingGroup() {
        return this.drawingGroup;
    }

    @Override // jxl.biff.formula.ExternalSheet
    public int getExternalSheetIndex(int i) {
        ExternalSheetRecord externalSheetRecord = this.externSheet;
        if (externalSheetRecord == null) {
            return i;
        }
        Assert.verify(externalSheetRecord != null);
        return this.externSheet.getFirstTabIndex(i);
    }

    @Override // jxl.biff.formula.ExternalSheet
    public int getExternalSheetIndex(String str) {
        if (this.externSheet == null) {
            this.externSheet = new ExternalSheetRecord();
            ArrayList arrayList = new ArrayList();
            this.supbooks = arrayList;
            arrayList.add(new SupbookRecord(getNumberOfSheets(), this.settings));
        }
        Iterator it = this.sheets.iterator();
        boolean z = false;
        int i = 0;
        while (it.hasNext() && !z) {
            if (((WritableSheetImpl) it.next()).getName().equals(str)) {
                z = true;
            } else {
                i++;
            }
        }
        if (z) {
            SupbookRecord supbookRecord = (SupbookRecord) this.supbooks.get(0);
            if (supbookRecord.getType() != SupbookRecord.INTERNAL || supbookRecord.getNumberOfSheets() != getNumberOfSheets()) {
                Logger logger2 = logger;
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Cannot find sheet ");
                stringBuffer.append(str);
                stringBuffer.append(" in supbook record");
                logger2.warn(stringBuffer.toString());
            }
            return this.externSheet.getIndex(0, i);
        }
        int lastIndexOf = str.lastIndexOf(93);
        int lastIndexOf2 = str.lastIndexOf(91);
        int i2 = -1;
        if (lastIndexOf == -1 || lastIndexOf2 == -1) {
            logger.warn("Square brackets");
            return -1;
        }
        String substring = str.substring(lastIndexOf + 1);
        String substring2 = str.substring(lastIndexOf2 + 1, lastIndexOf);
        String substring3 = str.substring(0, lastIndexOf2);
        StringBuffer stringBuffer2 = new StringBuffer();
        stringBuffer2.append(substring3);
        stringBuffer2.append(substring2);
        String stringBuffer3 = stringBuffer2.toString();
        SupbookRecord supbookRecord2 = null;
        boolean z2 = false;
        for (int i3 = 0; i3 < this.supbooks.size() && !z2; i3++) {
            supbookRecord2 = (SupbookRecord) this.supbooks.get(i3);
            if (supbookRecord2.getType() == SupbookRecord.EXTERNAL && supbookRecord2.getFileName().equals(stringBuffer3)) {
                z2 = true;
                i2 = i3;
            }
        }
        if (!z2) {
            supbookRecord2 = new SupbookRecord(stringBuffer3, this.settings);
            i2 = this.supbooks.size();
            this.supbooks.add(supbookRecord2);
        }
        return this.externSheet.getIndex(i2, supbookRecord2.getSheetIndex(substring));
    }

    @Override // jxl.biff.formula.ExternalSheet
    public String getExternalSheetName(int i) {
        SupbookRecord supbookRecord = (SupbookRecord) this.supbooks.get(this.externSheet.getSupbookIndex(i));
        int firstTabIndex = this.externSheet.getFirstTabIndex(i);
        if (supbookRecord.getType() == SupbookRecord.INTERNAL) {
            return getSheet(firstTabIndex).getName();
        }
        if (supbookRecord.getType() != SupbookRecord.EXTERNAL) {
            logger.warn("Unknown Supbook 1");
            return "[UNKNOWN]";
        }
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(supbookRecord.getFileName());
        stringBuffer.append(supbookRecord.getSheetName(firstTabIndex));
        return stringBuffer.toString();
    }

    @Override // jxl.biff.formula.ExternalSheet
    public int getLastExternalSheetIndex(int i) {
        ExternalSheetRecord externalSheetRecord = this.externSheet;
        if (externalSheetRecord == null) {
            return i;
        }
        Assert.verify(externalSheetRecord != null);
        return this.externSheet.getLastTabIndex(i);
    }

    @Override // jxl.biff.formula.ExternalSheet
    public int getLastExternalSheetIndex(String str) {
        if (this.externSheet == null) {
            this.externSheet = new ExternalSheetRecord();
            ArrayList arrayList = new ArrayList();
            this.supbooks = arrayList;
            arrayList.add(new SupbookRecord(getNumberOfSheets(), this.settings));
        }
        Iterator it = this.sheets.iterator();
        boolean z = true;
        boolean z2 = false;
        int i = 0;
        while (it.hasNext() && !z2) {
            if (((WritableSheetImpl) it.next()).getName().equals(str)) {
                z2 = true;
            } else {
                i++;
            }
        }
        if (z2) {
            SupbookRecord supbookRecord = (SupbookRecord) this.supbooks.get(0);
            if (supbookRecord.getType() != SupbookRecord.INTERNAL || supbookRecord.getNumberOfSheets() != getNumberOfSheets()) {
                z = false;
            }
            Assert.verify(z);
            return this.externSheet.getIndex(0, i);
        }
        return -1;
    }

    public String getLastExternalSheetName(int i) {
        SupbookRecord supbookRecord = (SupbookRecord) this.supbooks.get(this.externSheet.getSupbookIndex(i));
        int lastTabIndex = this.externSheet.getLastTabIndex(i);
        if (supbookRecord.getType() == SupbookRecord.INTERNAL) {
            return getSheet(lastTabIndex).getName();
        }
        if (supbookRecord.getType() == SupbookRecord.EXTERNAL) {
            Assert.verify(false);
        }
        logger.warn("Unknown Supbook 2");
        return "[UNKNOWN]";
    }

    @Override // jxl.biff.WorkbookMethods
    public String getName(int i) {
        Assert.verify(i >= 0 && i < this.names.size());
        return ((NameRecord) this.names.get(i)).getName();
    }

    @Override // jxl.biff.WorkbookMethods
    public int getNameIndex(String str) {
        NameRecord nameRecord = (NameRecord) this.nameRecords.get(str);
        if (nameRecord != null) {
            return nameRecord.getIndex();
        }
        return -1;
    }

    @Override // jxl.write.WritableWorkbook
    public int getNumberOfSheets() {
        return this.sheets.size();
    }

    @Override // jxl.write.WritableWorkbook
    public String[] getRangeNames() {
        ArrayList arrayList = this.names;
        if (arrayList == null) {
            return new String[0];
        }
        String[] strArr = new String[arrayList.size()];
        for (int i = 0; i < this.names.size(); i++) {
            strArr[i] = ((NameRecord) this.names.get(i)).getName();
        }
        return strArr;
    }

    @Override // jxl.biff.WorkbookMethods
    public Sheet getReadSheet(int i) {
        return getSheet(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public WorkbookSettings getSettings() {
        return this.settings;
    }

    @Override // jxl.write.WritableWorkbook
    public WritableSheet getSheet(int i) {
        return (WritableSheet) this.sheets.get(i);
    }

    @Override // jxl.write.WritableWorkbook
    public WritableSheet getSheet(String str) {
        Iterator it = this.sheets.iterator();
        boolean z = false;
        WritableSheet writableSheet = null;
        while (it.hasNext() && !z) {
            writableSheet = (WritableSheet) it.next();
            if (writableSheet.getName().equals(str)) {
                z = true;
            }
        }
        if (z) {
            return writableSheet;
        }
        return null;
    }

    @Override // jxl.write.WritableWorkbook
    public String[] getSheetNames() {
        int numberOfSheets = getNumberOfSheets();
        String[] strArr = new String[numberOfSheets];
        for (int i = 0; i < numberOfSheets; i++) {
            strArr[i] = getSheet(i).getName();
        }
        return strArr;
    }

    @Override // jxl.write.WritableWorkbook
    public WritableSheet[] getSheets() {
        WritableSheet[] writableSheetArr = new WritableSheet[getNumberOfSheets()];
        for (int i = 0; i < getNumberOfSheets(); i++) {
            writableSheetArr[i] = getSheet(i);
        }
        return writableSheetArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Styles getStyles() {
        return this.styles;
    }

    @Override // jxl.biff.formula.ExternalSheet
    public jxl.read.biff.BOFRecord getWorkbookBof() {
        return null;
    }

    @Override // jxl.write.WritableWorkbook
    public WritableCell getWritableCell(String str) {
        return getSheet(CellReferenceHelper.getSheet(str)).getWritableCell(str);
    }

    @Override // jxl.write.WritableWorkbook
    public WritableSheet importSheet(String str, int i, Sheet sheet) {
        WritableSheet createSheet = createSheet(str, i);
        ((WritableSheetImpl) createSheet).importSheet(sheet);
        return createSheet;
    }

    @Override // jxl.write.WritableWorkbook
    public WritableSheet moveSheet(int i, int i2) {
        int min = Math.min(Math.max(i, 0), this.sheets.size() - 1);
        int min2 = Math.min(Math.max(i2, 0), this.sheets.size() - 1);
        WritableSheet writableSheet = (WritableSheet) this.sheets.remove(min);
        this.sheets.add(min2, writableSheet);
        return writableSheet;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeDrawing(Drawing drawing) {
        Assert.verify(this.drawingGroup != null);
        this.drawingGroup.remove(drawing);
    }

    @Override // jxl.write.WritableWorkbook
    public void removeRangeName(String str) {
        Iterator it = this.names.iterator();
        boolean z = false;
        int i = 0;
        while (it.hasNext() && !z) {
            if (((NameRecord) it.next()).getName().equals(str)) {
                z = true;
            } else {
                i++;
            }
        }
        if (z) {
            this.names.remove(i);
            if (this.nameRecords.remove(str) == null) {
                Logger logger2 = logger;
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Could not remove ");
                stringBuffer.append(str);
                stringBuffer.append(" from index lookups");
                logger2.warn(stringBuffer.toString());
            }
        }
    }

    @Override // jxl.write.WritableWorkbook
    public void removeSheet(int i) {
        if (i <= 0) {
            this.sheets.remove(0);
            i = 0;
        } else if (i >= this.sheets.size()) {
            i = this.sheets.size() - 1;
            ArrayList arrayList = this.sheets;
            arrayList.remove(arrayList.size() - 1);
        } else {
            this.sheets.remove(i);
        }
        ExternalSheetRecord externalSheetRecord = this.externSheet;
        if (externalSheetRecord != null) {
            externalSheetRecord.sheetRemoved(i);
        }
        ArrayList arrayList2 = this.supbooks;
        if (arrayList2 != null && arrayList2.size() > 0) {
            SupbookRecord supbookRecord = (SupbookRecord) this.supbooks.get(0);
            if (supbookRecord.getType() == SupbookRecord.INTERNAL) {
                supbookRecord.adjustInternal(this.sheets.size());
            }
        }
        ArrayList arrayList3 = this.names;
        if (arrayList3 == null || arrayList3.size() <= 0) {
            return;
        }
        for (int i2 = 0; i2 < this.names.size(); i2++) {
            NameRecord nameRecord = (NameRecord) this.names.get(i2);
            int sheetRef = nameRecord.getSheetRef();
            int i3 = i + 1;
            if (sheetRef == i3) {
                nameRecord.setSheetRef(0);
            } else if (sheetRef > i3) {
                if (sheetRef < 1) {
                    sheetRef = 1;
                }
                nameRecord.setSheetRef(sheetRef - 1);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rowInserted(WritableSheetImpl writableSheetImpl, int i) {
        int externalSheetIndex = getExternalSheetIndex(writableSheetImpl.getName());
        Iterator it = this.rcirCells.iterator();
        while (it.hasNext()) {
            ((CellValue) it.next()).rowInserted(writableSheetImpl, externalSheetIndex, i);
        }
        ArrayList arrayList = this.names;
        if (arrayList != null) {
            Iterator it2 = arrayList.iterator();
            while (it2.hasNext()) {
                ((NameRecord) it2.next()).rowInserted(externalSheetIndex, i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rowRemoved(WritableSheetImpl writableSheetImpl, int i) {
        int externalSheetIndex = getExternalSheetIndex(writableSheetImpl.getName());
        Iterator it = this.rcirCells.iterator();
        while (it.hasNext()) {
            ((CellValue) it.next()).rowRemoved(writableSheetImpl, externalSheetIndex, i);
        }
        ArrayList arrayList = new ArrayList();
        ArrayList arrayList2 = this.names;
        if (arrayList2 != null) {
            Iterator it2 = arrayList2.iterator();
            while (it2.hasNext()) {
                NameRecord nameRecord = (NameRecord) it2.next();
                if (nameRecord.rowRemoved(externalSheetIndex, i)) {
                    arrayList.add(nameRecord);
                }
            }
            Iterator it3 = arrayList.iterator();
            while (it3.hasNext()) {
                NameRecord nameRecord2 = (NameRecord) it3.next();
                boolean remove = this.names.remove(nameRecord2);
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Could not remove name ");
                stringBuffer.append(nameRecord2.getName());
                Assert.verify(remove, stringBuffer.toString());
            }
        }
    }

    @Override // jxl.write.WritableWorkbook
    public void setColourRGB(Colour colour, int i, int i2, int i3) {
        this.formatRecords.setColourRGB(colour, i, i2, i3);
    }

    @Override // jxl.write.WritableWorkbook
    public void setOutputFile(java.io.File file) {
        this.outputFile.setOutputFile(new FileOutputStream(file));
    }

    @Override // jxl.write.WritableWorkbook
    public void setProtected(boolean z) {
        this.wbProtected = z;
    }

    @Override // jxl.write.WritableWorkbook
    public void write() {
        int column;
        int row;
        int column2;
        int row2;
        boolean z;
        WritableWorkbookImpl writableWorkbookImpl;
        BuiltInName builtInName;
        for (int i = 0; i < getNumberOfSheets(); i++) {
            WritableSheetImpl writableSheetImpl = (WritableSheetImpl) getSheet(i);
            writableSheetImpl.checkMergedBorders();
            Range printArea = writableSheetImpl.getSettings().getPrintArea();
            if (printArea != null) {
                addNameArea(BuiltInName.PRINT_AREA, (WritableSheet) writableSheetImpl, printArea.getTopLeft().getColumn(), printArea.getTopLeft().getRow(), printArea.getBottomRight().getColumn(), printArea.getBottomRight().getRow(), false);
            }
            Range printTitlesRow = writableSheetImpl.getSettings().getPrintTitlesRow();
            Range printTitlesCol = writableSheetImpl.getSettings().getPrintTitlesCol();
            if (printTitlesRow == null || printTitlesCol == null) {
                if (printTitlesRow != null) {
                    builtInName = BuiltInName.PRINT_TITLES;
                    column = printTitlesRow.getTopLeft().getColumn();
                    row = printTitlesRow.getTopLeft().getRow();
                    column2 = printTitlesRow.getBottomRight().getColumn();
                    row2 = printTitlesRow.getBottomRight().getRow();
                    z = false;
                    writableWorkbookImpl = this;
                } else if (printTitlesCol != null) {
                    BuiltInName builtInName2 = BuiltInName.PRINT_TITLES;
                    column = printTitlesCol.getTopLeft().getColumn();
                    row = printTitlesCol.getTopLeft().getRow();
                    column2 = printTitlesCol.getBottomRight().getColumn();
                    row2 = printTitlesCol.getBottomRight().getRow();
                    z = false;
                    writableWorkbookImpl = this;
                    builtInName = builtInName2;
                }
                writableWorkbookImpl.addNameArea(builtInName, writableSheetImpl, column, row, column2, row2, z);
            } else {
                addNameArea(BuiltInName.PRINT_TITLES, writableSheetImpl, printTitlesRow.getTopLeft().getColumn(), printTitlesRow.getTopLeft().getRow(), printTitlesRow.getBottomRight().getColumn(), printTitlesRow.getBottomRight().getRow(), printTitlesCol.getTopLeft().getColumn(), printTitlesCol.getTopLeft().getRow(), printTitlesCol.getBottomRight().getColumn(), printTitlesCol.getBottomRight().getRow(), false);
            }
        }
        if (!this.settings.getRationalizationDisabled()) {
            rationalize();
        }
        this.outputFile.write(new BOFRecord(BOFRecord.workbookGlobals));
        if (this.settings.getTemplate()) {
            this.outputFile.write(new TemplateRecord());
        }
        this.outputFile.write(new InterfaceHeaderRecord());
        this.outputFile.write(new MMSRecord(0, 0));
        this.outputFile.write(new InterfaceEndRecord());
        this.outputFile.write(new WriteAccessRecord(this.settings.getWriteAccess()));
        this.outputFile.write(new CodepageRecord());
        this.outputFile.write(new DSFRecord());
        if (this.settings.getExcel9File()) {
            this.outputFile.write(new Excel9FileRecord());
        }
        this.outputFile.write(new TabIdRecord(getNumberOfSheets()));
        if (this.containsMacros) {
            this.outputFile.write(new ObjProjRecord());
        }
        ButtonPropertySetRecord buttonPropertySetRecord = this.buttonPropertySet;
        if (buttonPropertySetRecord != null) {
            this.outputFile.write(buttonPropertySetRecord);
        }
        this.outputFile.write(new FunctionGroupCountRecord());
        this.outputFile.write(new WindowProtectRecord(this.settings.getWindowProtected()));
        this.outputFile.write(new ProtectRecord(this.wbProtected));
        this.outputFile.write(new PasswordRecord((String) null));
        this.outputFile.write(new Prot4RevRecord(false));
        this.outputFile.write(new Prot4RevPassRecord());
        boolean z2 = false;
        int i2 = 0;
        for (int i3 = 0; i3 < getNumberOfSheets() && !z2; i3++) {
            if (((WritableSheetImpl) getSheet(i3)).getSettings().isSelected()) {
                i2 = i3;
                z2 = true;
            }
        }
        if (!z2) {
            ((WritableSheetImpl) getSheet(0)).getSettings().setSelected(true);
            i2 = 0;
        }
        this.outputFile.write(new Window1Record(i2));
        this.outputFile.write(new BackupRecord(false));
        this.outputFile.write(new HideobjRecord(this.settings.getHideobj()));
        this.outputFile.write(new NineteenFourRecord(false));
        this.outputFile.write(new PrecisionRecord(false));
        this.outputFile.write(new RefreshAllRecord(this.settings.getRefreshAll()));
        this.outputFile.write(new BookboolRecord(true));
        this.fonts.write(this.outputFile);
        this.formatRecords.write(this.outputFile);
        if (this.formatRecords.getPalette() != null) {
            this.outputFile.write(this.formatRecords.getPalette());
        }
        this.outputFile.write(new UsesElfsRecord());
        int[] iArr = new int[getNumberOfSheets()];
        for (int i4 = 0; i4 < getNumberOfSheets(); i4++) {
            iArr[i4] = this.outputFile.getPos();
            WritableSheet sheet = getSheet(i4);
            BoundsheetRecord boundsheetRecord = new BoundsheetRecord(sheet.getName());
            if (sheet.getSettings().isHidden()) {
                boundsheetRecord.setHidden();
            }
            if (((WritableSheetImpl) this.sheets.get(i4)).isChartOnly()) {
                boundsheetRecord.setChartOnly();
            }
            this.outputFile.write(boundsheetRecord);
        }
        if (this.countryRecord == null) {
            CountryCode countryCode = CountryCode.getCountryCode(this.settings.getExcelDisplayLanguage());
            CountryCode countryCode2 = CountryCode.UNKNOWN;
            if (countryCode == countryCode2) {
                Logger logger2 = logger;
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Unknown country code ");
                stringBuffer.append(this.settings.getExcelDisplayLanguage());
                stringBuffer.append(" using ");
                CountryCode countryCode3 = CountryCode.USA;
                stringBuffer.append(countryCode3.getCode());
                logger2.warn(stringBuffer.toString());
                countryCode = countryCode3;
            }
            CountryCode countryCode4 = CountryCode.getCountryCode(this.settings.getExcelRegionalSettings());
            this.countryRecord = new CountryRecord(countryCode, countryCode4);
            if (countryCode4 == countryCode2) {
                Logger logger3 = logger;
                StringBuffer stringBuffer2 = new StringBuffer();
                stringBuffer2.append("Unknown country code ");
                stringBuffer2.append(this.settings.getExcelDisplayLanguage());
                stringBuffer2.append(" using ");
                stringBuffer2.append(CountryCode.UK.getCode());
                logger3.warn(stringBuffer2.toString());
            }
        }
        this.outputFile.write(this.countryRecord);
        String[] strArr = this.addInFunctionNames;
        if (strArr != null && strArr.length > 0) {
            for (int i5 = 0; i5 < this.addInFunctionNames.length; i5++) {
                this.outputFile.write(new ExternalNameRecord(this.addInFunctionNames[i5]));
            }
        }
        if (this.xctRecords != null) {
            int i6 = 0;
            while (true) {
                XCTRecord[] xCTRecordArr = this.xctRecords;
                if (i6 >= xCTRecordArr.length) {
                    break;
                }
                this.outputFile.write(xCTRecordArr[i6]);
                i6++;
            }
        }
        if (this.externSheet != null) {
            for (int i7 = 0; i7 < this.supbooks.size(); i7++) {
                this.outputFile.write((SupbookRecord) this.supbooks.get(i7));
            }
            this.outputFile.write(this.externSheet);
        }
        if (this.names != null) {
            for (int i8 = 0; i8 < this.names.size(); i8++) {
                this.outputFile.write((NameRecord) this.names.get(i8));
            }
        }
        DrawingGroup drawingGroup = this.drawingGroup;
        if (drawingGroup != null) {
            drawingGroup.write(this.outputFile);
        }
        this.sharedStrings.write(this.outputFile);
        this.outputFile.write(new EOFRecord());
        for (int i9 = 0; i9 < getNumberOfSheets(); i9++) {
            File file = this.outputFile;
            file.setData(IntegerHelper.getFourBytes(file.getPos()), iArr[i9] + 4);
            ((WritableSheetImpl) getSheet(i9)).write();
        }
    }
}
