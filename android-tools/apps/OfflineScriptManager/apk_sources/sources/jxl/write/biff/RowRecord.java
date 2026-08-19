package jxl.write.biff;

import java.util.ArrayList;
import java.util.Iterator;
import jxl.SheetSettings;
import jxl.biff.CellReferenceHelper;
import jxl.biff.IndexMapping;
import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.biff.XFRecord;
import jxl.common.Logger;
import jxl.write.WritableSheet;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class RowRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$write$biff$RowRecord = null;
    private static int defaultHeightIndicator = 0;
    private static final int growSize = 10;
    private static final Logger logger;
    private static int maxColumns = 0;
    private static final int maxRKValue = 536870911;
    private static final int minRKValue = -536870912;
    private CellValue[] cells;
    private boolean collapsed;
    private byte[] data;
    private boolean defaultFormat;
    private boolean groupStart;
    private boolean matchesDefFontHeight;
    private int numColumns;
    private int outlineLevel;
    private int rowHeight;
    private int rowNumber;
    private WritableSheet sheet;
    private XFRecord style;
    private int xfIndex;

    static {
        Class cls = class$jxl$write$biff$RowRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.RowRecord");
            class$jxl$write$biff$RowRecord = cls;
        }
        logger = Logger.getLogger(cls);
        defaultHeightIndicator = SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
        maxColumns = 256;
    }

    public RowRecord(int i, WritableSheet writableSheet) {
        super(Type.ROW);
        this.rowNumber = i;
        this.cells = new CellValue[0];
        this.numColumns = 0;
        this.rowHeight = defaultHeightIndicator;
        this.collapsed = false;
        this.matchesDefFontHeight = true;
        this.sheet = writableSheet;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void writeIntegerValues(ArrayList arrayList, File file) {
        if (arrayList.size() == 0) {
            return;
        }
        if (arrayList.size() >= 3) {
            file.write(new MulRKRecord(arrayList));
        } else {
            Iterator it = arrayList.iterator();
            while (it.hasNext()) {
                file.write((CellValue) it.next());
            }
        }
        arrayList.clear();
    }

    public void addCell(CellValue cellValue) {
        int column = cellValue.getColumn();
        if (column >= maxColumns) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Could not add cell at ");
            stringBuffer.append(CellReferenceHelper.getCellReference(cellValue.getRow(), cellValue.getColumn()));
            stringBuffer.append(" because it exceeds the maximum column limit");
            logger2.warn(stringBuffer.toString());
            return;
        }
        CellValue[] cellValueArr = this.cells;
        if (column >= cellValueArr.length) {
            CellValue[] cellValueArr2 = new CellValue[Math.max(cellValueArr.length + 10, column + 1)];
            this.cells = cellValueArr2;
            System.arraycopy(cellValueArr, 0, cellValueArr2, 0, cellValueArr.length);
        }
        CellValue[] cellValueArr3 = this.cells;
        if (cellValueArr3[column] != null) {
            cellValueArr3[column].removeCellFeatures();
        }
        this.cells[column] = cellValue;
        this.numColumns = Math.max(column + 1, this.numColumns);
    }

    public void decrementOutlineLevel() {
        int i = this.outlineLevel;
        if (i > 0) {
            this.outlineLevel = i - 1;
        }
        if (this.outlineLevel == 0) {
            this.collapsed = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void decrementRow() {
        this.rowNumber--;
        int i = 0;
        while (true) {
            CellValue[] cellValueArr = this.cells;
            if (i >= cellValueArr.length) {
                return;
            }
            if (cellValueArr[i] != null) {
                cellValueArr[i].decrementRow();
            }
            i++;
        }
    }

    public CellValue getCell(int i) {
        if (i < 0 || i >= this.numColumns) {
            return null;
        }
        return this.cells[i];
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[16];
        int i = this.rowHeight;
        if (this.sheet.getSettings().getDefaultRowHeight() != 255 && i == defaultHeightIndicator) {
            i = this.sheet.getSettings().getDefaultRowHeight();
        }
        IntegerHelper.getTwoBytes(this.rowNumber, bArr, 0);
        IntegerHelper.getTwoBytes(this.numColumns, bArr, 4);
        IntegerHelper.getTwoBytes(i, bArr, 6);
        int i2 = this.outlineLevel + 256;
        if (this.groupStart) {
            i2 |= 16;
        }
        if (this.collapsed) {
            i2 |= 32;
        }
        if (!this.matchesDefFontHeight) {
            i2 |= 64;
        }
        if (this.defaultFormat) {
            i2 = i2 | 128 | (this.xfIndex << 16);
        }
        IntegerHelper.getFourBytes(i2, bArr, 12);
        return bArr;
    }

    public boolean getGroupStart() {
        return this.groupStart;
    }

    public int getMaxColumn() {
        return this.numColumns;
    }

    public int getOutlineLevel() {
        return this.outlineLevel;
    }

    public int getRowHeight() {
        return this.rowHeight;
    }

    public int getRowNumber() {
        return this.rowNumber;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public XFRecord getStyle() {
        return this.style;
    }

    boolean hasDefaultFormat() {
        return this.defaultFormat;
    }

    public void incrementOutlineLevel() {
        this.outlineLevel++;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void incrementRow() {
        this.rowNumber++;
        int i = 0;
        while (true) {
            CellValue[] cellValueArr = this.cells;
            if (i >= cellValueArr.length) {
                return;
            }
            if (cellValueArr[i] != null) {
                cellValueArr[i].incrementRow();
            }
            i++;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void insertColumn(int i) {
        int i2 = this.numColumns;
        if (i >= i2) {
            return;
        }
        if (i2 >= maxColumns) {
            logger.warn("Could not insert column because maximum column limit has been reached");
            return;
        }
        CellValue[] cellValueArr = this.cells;
        if (i2 >= cellValueArr.length - 1) {
            this.cells = new CellValue[cellValueArr.length + 10];
        } else {
            this.cells = new CellValue[cellValueArr.length];
        }
        System.arraycopy(cellValueArr, 0, this.cells, 0, i);
        int i3 = i + 1;
        System.arraycopy(cellValueArr, i, this.cells, i3, this.numColumns - i);
        while (true) {
            int i4 = this.numColumns;
            if (i3 > i4) {
                this.numColumns = i4 + 1;
                return;
            }
            CellValue[] cellValueArr2 = this.cells;
            if (cellValueArr2[i3] != null) {
                cellValueArr2[i3].incrementColumn();
            }
            i3++;
        }
    }

    public boolean isCollapsed() {
        return this.collapsed;
    }

    public boolean isDefaultHeight() {
        return this.rowHeight == defaultHeightIndicator;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean matchesDefaultFontHeight() {
        return this.matchesDefFontHeight;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rationalize(IndexMapping indexMapping) {
        if (this.defaultFormat) {
            this.xfIndex = indexMapping.getNewIndex(this.xfIndex);
        }
    }

    public void removeCell(int i) {
        if (i >= this.numColumns) {
            return;
        }
        this.cells[i] = null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeColumn(int i) {
        if (i >= this.numColumns) {
            return;
        }
        CellValue[] cellValueArr = this.cells;
        CellValue[] cellValueArr2 = new CellValue[cellValueArr.length];
        this.cells = cellValueArr2;
        System.arraycopy(cellValueArr, 0, cellValueArr2, 0, i);
        int i2 = i + 1;
        System.arraycopy(cellValueArr, i2, this.cells, i, this.numColumns - i2);
        while (true) {
            int i3 = this.numColumns;
            if (i >= i3) {
                this.numColumns = i3 - 1;
                return;
            }
            CellValue[] cellValueArr3 = this.cells;
            if (cellValueArr3[i] != null) {
                cellValueArr3[i].decrementColumn();
            }
            i++;
        }
    }

    public void setCollapsed(boolean z) {
        this.collapsed = z;
    }

    public void setGroupStart(boolean z) {
        this.groupStart = z;
    }

    public void setOutlineLevel(int i) {
        this.outlineLevel = i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setRowDetails(int i, boolean z, boolean z2, int i2, boolean z3, XFRecord xFRecord) {
        this.rowHeight = i;
        this.collapsed = z2;
        this.matchesDefFontHeight = z;
        this.outlineLevel = i2;
        this.groupStart = z3;
        if (xFRecord != null) {
            this.defaultFormat = true;
            this.style = xFRecord;
            this.xfIndex = xFRecord.getXFIndex();
        }
    }

    public void setRowHeight(int i) {
        if (i == 0) {
            setCollapsed(true);
        } else {
            this.rowHeight = i;
        }
        this.matchesDefFontHeight = false;
    }

    public void write(File file) {
        file.write(this);
    }

    /* JADX WARN: Removed duplicated region for block: B:20:0x0051  */
    /* JADX WARN: Removed duplicated region for block: B:21:0x0059  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void writeCells(jxl.write.biff.File r9) {
        /*
            r8 = this;
            java.util.ArrayList r0 = new java.util.ArrayList
            r0.<init>()
            r1 = 0
            r2 = r1
        L7:
            int r3 = r8.numColumns
            if (r2 >= r3) goto L86
            jxl.write.biff.CellValue[] r3 = r8.cells
            r4 = r3[r2]
            if (r4 == 0) goto L80
            r3 = r3[r2]
            jxl.CellType r3 = r3.getType()
            jxl.CellType r4 = jxl.CellType.NUMBER
            if (r3 != r4) goto L4e
            jxl.write.biff.CellValue[] r3 = r8.cells
            r3 = r3[r2]
            jxl.write.Number r3 = (jxl.write.Number) r3
            double r4 = r3.getValue()
            double r6 = r3.getValue()
            int r6 = (int) r6
            double r6 = (double) r6
            int r4 = (r4 > r6 ? 1 : (r4 == r6 ? 0 : -1))
            if (r4 != 0) goto L4e
            double r4 = r3.getValue()
            r6 = 4737786807976984576(0x41bfffffff000000, double:5.36870911E8)
            int r4 = (r4 > r6 ? 1 : (r4 == r6 ? 0 : -1))
            if (r4 >= 0) goto L4e
            double r4 = r3.getValue()
            r6 = -4485585228861014016(0xc1c0000000000000, double:-5.36870912E8)
            int r4 = (r4 > r6 ? 1 : (r4 == r6 ? 0 : -1))
            if (r4 <= 0) goto L4e
            jxl.CellFeatures r3 = r3.getCellFeatures()
            if (r3 != 0) goto L4e
            r3 = 1
            goto L4f
        L4e:
            r3 = r1
        L4f:
            if (r3 == 0) goto L59
            jxl.write.biff.CellValue[] r3 = r8.cells
            r3 = r3[r2]
            r0.add(r3)
            goto L83
        L59:
            r8.writeIntegerValues(r0, r9)
            jxl.write.biff.CellValue[] r3 = r8.cells
            r3 = r3[r2]
            r9.write(r3)
            jxl.write.biff.CellValue[] r3 = r8.cells
            r3 = r3[r2]
            jxl.CellType r3 = r3.getType()
            jxl.CellType r4 = jxl.CellType.STRING_FORMULA
            if (r3 != r4) goto L83
            jxl.write.biff.StringRecord r3 = new jxl.write.biff.StringRecord
            jxl.write.biff.CellValue[] r4 = r8.cells
            r4 = r4[r2]
            java.lang.String r4 = r4.getContents()
            r3.<init>(r4)
            r9.write(r3)
            goto L83
        L80:
            r8.writeIntegerValues(r0, r9)
        L83:
            int r2 = r2 + 1
            goto L7
        L86:
            r8.writeIntegerValues(r0, r9)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.write.biff.RowRecord.writeCells(jxl.write.biff.File):void");
    }
}
