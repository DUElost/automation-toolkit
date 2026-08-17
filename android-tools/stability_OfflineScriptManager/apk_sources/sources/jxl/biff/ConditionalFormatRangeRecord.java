package jxl.biff;

import jxl.common.Logger;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class ConditionalFormatRangeRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$biff$ConditionalFormatRangeRecord;
    private static Logger logger;
    private byte[] data;
    private Range enclosingRange;
    private boolean initialized;
    private boolean modified;
    private int numRanges;
    private Range[] ranges;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class Range {
        public int firstColumn;
        public int firstRow;
        public int lastColumn;
        public int lastRow;
        public boolean modified = false;

        public void insertColumn(int i) {
            int i2 = this.lastColumn;
            if (i > i2) {
                return;
            }
            int i3 = this.firstColumn;
            if (i <= i3) {
                this.firstColumn = i3 + 1;
                this.modified = true;
            }
            if (i <= i2) {
                this.lastColumn = i2 + 1;
                this.modified = true;
            }
        }

        public void insertRow(int i) {
            int i2 = this.lastRow;
            if (i > i2) {
                return;
            }
            int i3 = this.firstRow;
            if (i <= i3) {
                this.firstRow = i3 + 1;
                this.modified = true;
            }
            if (i <= i2) {
                this.lastRow = i2 + 1;
                this.modified = true;
            }
        }

        public void removeColumn(int i) {
            int i2 = this.lastColumn;
            if (i > i2) {
                return;
            }
            int i3 = this.firstColumn;
            if (i < i3) {
                this.firstColumn = i3 - 1;
                this.modified = true;
            }
            if (i <= i2) {
                this.lastColumn = i2 - 1;
                this.modified = true;
            }
        }

        public void removeRow(int i) {
            int i2 = this.lastRow;
            if (i > i2) {
                return;
            }
            int i3 = this.firstRow;
            if (i < i3) {
                this.firstRow = i3 - 1;
                this.modified = true;
            }
            if (i <= i2) {
                this.lastRow = i2 - 1;
                this.modified = true;
            }
        }
    }

    static {
        Class cls = class$jxl$biff$ConditionalFormatRangeRecord;
        if (cls == null) {
            cls = class$("jxl.biff.ConditionalFormatRangeRecord");
            class$jxl$biff$ConditionalFormatRangeRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public ConditionalFormatRangeRecord(Record record) {
        super(record);
        this.initialized = false;
        this.modified = false;
        this.data = getRecord().getData();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void initialize() {
        Range range = new Range();
        this.enclosingRange = range;
        byte[] bArr = this.data;
        range.firstRow = IntegerHelper.getInt(bArr[4], bArr[5]);
        Range range2 = this.enclosingRange;
        byte[] bArr2 = this.data;
        range2.lastRow = IntegerHelper.getInt(bArr2[6], bArr2[7]);
        Range range3 = this.enclosingRange;
        byte[] bArr3 = this.data;
        range3.firstColumn = IntegerHelper.getInt(bArr3[8], bArr3[9]);
        Range range4 = this.enclosingRange;
        byte[] bArr4 = this.data;
        range4.lastColumn = IntegerHelper.getInt(bArr4[10], bArr4[11]);
        byte[] bArr5 = this.data;
        int i = IntegerHelper.getInt(bArr5[12], bArr5[13]);
        this.numRanges = i;
        this.ranges = new Range[i];
        int i2 = 14;
        for (int i3 = 0; i3 < this.numRanges; i3++) {
            this.ranges[i3] = new Range();
            Range range5 = this.ranges[i3];
            byte[] bArr6 = this.data;
            range5.firstRow = IntegerHelper.getInt(bArr6[i2], bArr6[i2 + 1]);
            Range range6 = this.ranges[i3];
            byte[] bArr7 = this.data;
            range6.lastRow = IntegerHelper.getInt(bArr7[i2 + 2], bArr7[i2 + 3]);
            Range range7 = this.ranges[i3];
            byte[] bArr8 = this.data;
            range7.firstColumn = IntegerHelper.getInt(bArr8[i2 + 4], bArr8[i2 + 5]);
            Range range8 = this.ranges[i3];
            byte[] bArr9 = this.data;
            range8.lastColumn = IntegerHelper.getInt(bArr9[i2 + 6], bArr9[i2 + 7]);
            i2 += 8;
        }
        this.initialized = true;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        if (!this.modified) {
            return this.data;
        }
        int i = 14;
        byte[] bArr = new byte[(this.ranges.length * 8) + 14];
        int i2 = 0;
        System.arraycopy(this.data, 0, bArr, 0, 4);
        IntegerHelper.getTwoBytes(this.enclosingRange.firstRow, bArr, 4);
        IntegerHelper.getTwoBytes(this.enclosingRange.lastRow, bArr, 6);
        IntegerHelper.getTwoBytes(this.enclosingRange.firstColumn, bArr, 8);
        IntegerHelper.getTwoBytes(this.enclosingRange.lastColumn, bArr, 10);
        IntegerHelper.getTwoBytes(this.numRanges, bArr, 12);
        while (true) {
            Range[] rangeArr = this.ranges;
            if (i2 >= rangeArr.length) {
                return bArr;
            }
            IntegerHelper.getTwoBytes(rangeArr[i2].firstRow, bArr, i);
            IntegerHelper.getTwoBytes(this.ranges[i2].lastRow, bArr, i + 2);
            IntegerHelper.getTwoBytes(this.ranges[i2].firstColumn, bArr, i + 4);
            IntegerHelper.getTwoBytes(this.ranges[i2].lastColumn, bArr, i + 6);
            i += 8;
            i2++;
        }
    }

    public void insertColumn(int i) {
        if (!this.initialized) {
            initialize();
        }
        this.enclosingRange.insertColumn(i);
        if (this.enclosingRange.modified) {
            this.modified = true;
        }
        int i2 = 0;
        while (true) {
            Range[] rangeArr = this.ranges;
            if (i2 >= rangeArr.length) {
                return;
            }
            rangeArr[i2].insertColumn(i);
            if (this.ranges[i2].modified) {
                this.modified = true;
            }
            i2++;
        }
    }

    public void insertRow(int i) {
        if (!this.initialized) {
            initialize();
        }
        this.enclosingRange.insertRow(i);
        if (this.enclosingRange.modified) {
            this.modified = true;
        }
        int i2 = 0;
        while (true) {
            Range[] rangeArr = this.ranges;
            if (i2 >= rangeArr.length) {
                return;
            }
            rangeArr[i2].insertRow(i);
            if (this.ranges[i2].modified) {
                this.modified = true;
            }
            i2++;
        }
    }

    public void removeColumn(int i) {
        if (!this.initialized) {
            initialize();
        }
        this.enclosingRange.removeColumn(i);
        if (this.enclosingRange.modified) {
            this.modified = true;
        }
        int i2 = 0;
        while (true) {
            Range[] rangeArr = this.ranges;
            if (i2 >= rangeArr.length) {
                return;
            }
            rangeArr[i2].removeColumn(i);
            if (this.ranges[i2].modified) {
                this.modified = true;
            }
            i2++;
        }
    }

    public void removeRow(int i) {
        if (!this.initialized) {
            initialize();
        }
        this.enclosingRange.removeRow(i);
        if (this.enclosingRange.modified) {
            this.modified = true;
        }
        int i2 = 0;
        while (true) {
            Range[] rangeArr = this.ranges;
            if (i2 >= rangeArr.length) {
                return;
            }
            rangeArr[i2].removeRow(i);
            if (this.ranges[i2].modified) {
                this.modified = true;
            }
            i2++;
        }
    }
}
