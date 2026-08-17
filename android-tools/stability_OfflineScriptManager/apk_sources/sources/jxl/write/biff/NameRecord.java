package jxl.write.biff;

import jxl.SheetSettings;
import jxl.biff.BuiltInName;
import jxl.biff.IntegerHelper;
import jxl.biff.StringHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.common.Logger;
import jxl.read.biff.NameRecord;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class NameRecord extends WritableRecordData {
    private static final NameRange EMPTY_RANGE;
    private static final int areaReference = 59;
    private static final int cellReference = 58;
    static /* synthetic */ Class class$jxl$write$biff$NameRecord = null;
    private static Logger logger = null;
    private static final int subExpression = 41;
    private static final int union = 16;
    private BuiltInName builtInName;
    private byte[] data;
    private int index;
    private boolean modified;
    private String name;
    private NameRange[] ranges;
    private int sheetRef;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class NameRange {
        private int columnFirst;
        private int columnLast;
        private int externalSheet;
        private int rowFirst;
        private int rowLast;

        NameRange(int i, int i2, int i3, int i4, int i5) {
            this.columnFirst = i4;
            this.rowFirst = i2;
            this.columnLast = i5;
            this.rowLast = i3;
            this.externalSheet = i;
        }

        NameRange(NameRecord.NameRange nameRange) {
            this.columnFirst = nameRange.getFirstColumn();
            this.rowFirst = nameRange.getFirstRow();
            this.columnLast = nameRange.getLastColumn();
            this.rowLast = nameRange.getLastRow();
            this.externalSheet = nameRange.getExternalSheet();
        }

        void decrementFirstColumn() {
            this.columnFirst--;
        }

        void decrementFirstRow() {
            this.rowFirst--;
        }

        void decrementLastColumn() {
            this.columnLast--;
        }

        void decrementLastRow() {
            this.rowLast--;
        }

        byte[] getData() {
            byte[] bArr = new byte[10];
            IntegerHelper.getTwoBytes(this.externalSheet, bArr, 0);
            IntegerHelper.getTwoBytes(this.rowFirst, bArr, 2);
            IntegerHelper.getTwoBytes(this.rowLast, bArr, 4);
            IntegerHelper.getTwoBytes(this.columnFirst & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT, bArr, 6);
            IntegerHelper.getTwoBytes(this.columnLast & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT, bArr, 8);
            return bArr;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public int getExternalSheet() {
            return this.externalSheet;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public int getFirstColumn() {
            return this.columnFirst;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public int getFirstRow() {
            return this.rowFirst;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public int getLastColumn() {
            return this.columnLast;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public int getLastRow() {
            return this.rowLast;
        }

        void incrementFirstColumn() {
            this.columnFirst++;
        }

        void incrementFirstRow() {
            this.rowFirst++;
        }

        void incrementLastColumn() {
            this.columnLast++;
        }

        void incrementLastRow() {
            this.rowLast++;
        }
    }

    static {
        Class cls = class$jxl$write$biff$NameRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.NameRecord");
            class$jxl$write$biff$NameRecord = cls;
        }
        logger = Logger.getLogger(cls);
        EMPTY_RANGE = new NameRange(0, 0, 0, 0, 0);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public NameRecord(String str, int i, int i2, int i3, int i4, int i5, int i6, boolean z) {
        super(Type.NAME);
        this.sheetRef = 0;
        this.name = str;
        this.index = i;
        this.sheetRef = z ? 0 : i + 1;
        this.ranges = r9;
        NameRange[] nameRangeArr = {new NameRange(i2, i3, i4, i5, i6)};
        this.modified = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public NameRecord(BuiltInName builtInName, int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9, int i10, boolean z) {
        super(Type.NAME);
        this.sheetRef = 0;
        this.builtInName = builtInName;
        this.index = i;
        this.sheetRef = z ? 0 : i + 1;
        NameRange[] nameRangeArr = new NameRange[2];
        this.ranges = nameRangeArr;
        nameRangeArr[0] = new NameRange(i2, i3, i4, i5, i6);
        this.ranges[1] = new NameRange(i2, i7, i8, i9, i10);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public NameRecord(BuiltInName builtInName, int i, int i2, int i3, int i4, int i5, int i6, boolean z) {
        super(Type.NAME);
        this.sheetRef = 0;
        this.builtInName = builtInName;
        this.index = i;
        this.sheetRef = z ? 0 : i + 1;
        this.ranges = r8;
        NameRange[] nameRangeArr = {new NameRange(i2, i3, i4, i5, i6)};
    }

    public NameRecord(jxl.read.biff.NameRecord nameRecord, int i) {
        super(Type.NAME);
        int i2 = 0;
        this.sheetRef = 0;
        this.data = nameRecord.getData();
        this.name = nameRecord.getName();
        this.sheetRef = nameRecord.getSheetRef();
        this.index = i;
        this.modified = false;
        NameRecord.NameRange[] ranges = nameRecord.getRanges();
        this.ranges = new NameRange[ranges.length];
        while (true) {
            NameRange[] nameRangeArr = this.ranges;
            if (i2 >= nameRangeArr.length) {
                return;
            }
            nameRangeArr[i2] = new NameRange(ranges[i2]);
            i2++;
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void columnInserted(int i, int i2) {
        int i3 = 0;
        while (true) {
            NameRange[] nameRangeArr = this.ranges;
            if (i3 >= nameRangeArr.length) {
                return;
            }
            if (i == nameRangeArr[i3].getExternalSheet()) {
                if (i2 <= this.ranges[i3].getFirstColumn()) {
                    this.ranges[i3].incrementFirstColumn();
                    this.modified = true;
                }
                if (i2 <= this.ranges[i3].getLastColumn()) {
                    this.ranges[i3].incrementLastColumn();
                    this.modified = true;
                }
            }
            i3++;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean columnRemoved(int i, int i2) {
        NameRange[] nameRangeArr;
        int i3 = 0;
        while (true) {
            NameRange[] nameRangeArr2 = this.ranges;
            if (i3 >= nameRangeArr2.length) {
                break;
            }
            if (i == nameRangeArr2[i3].getExternalSheet()) {
                if (i2 == this.ranges[i3].getFirstColumn() && i2 == this.ranges[i3].getLastColumn()) {
                    this.ranges[i3] = EMPTY_RANGE;
                }
                if (i2 < this.ranges[i3].getFirstColumn() && i2 > 0) {
                    this.ranges[i3].decrementFirstColumn();
                    this.modified = true;
                }
                if (i2 <= this.ranges[i3].getLastColumn()) {
                    this.ranges[i3].decrementLastColumn();
                    this.modified = true;
                }
            }
            i3++;
        }
        int i4 = 0;
        int i5 = 0;
        while (true) {
            nameRangeArr = this.ranges;
            if (i4 >= nameRangeArr.length) {
                break;
            }
            if (nameRangeArr[i4] == EMPTY_RANGE) {
                i5++;
            }
            i4++;
        }
        if (i5 == nameRangeArr.length) {
            return true;
        }
        NameRange[] nameRangeArr3 = new NameRange[nameRangeArr.length - i5];
        int i6 = 0;
        while (true) {
            NameRange[] nameRangeArr4 = this.ranges;
            if (i6 >= nameRangeArr4.length) {
                this.ranges = nameRangeArr3;
                return false;
            }
            if (nameRangeArr4[i6] != EMPTY_RANGE) {
                nameRangeArr3[i6] = nameRangeArr4[i6];
            }
            i6++;
        }
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = this.data;
        if (bArr == null || this.modified) {
            NameRange[] nameRangeArr = this.ranges;
            int length = nameRangeArr.length > 1 ? (nameRangeArr.length * 11) + 4 : 11;
            byte[] bArr2 = new byte[length + 15 + (this.builtInName != null ? 1 : this.name.length())];
            this.data = bArr2;
            IntegerHelper.getTwoBytes(this.builtInName != null ? 32 : 0, bArr2, 0);
            byte[] bArr3 = this.data;
            bArr3[2] = 0;
            if (this.builtInName != null) {
                bArr3[3] = 1;
            } else {
                bArr3[3] = (byte) this.name.length();
            }
            IntegerHelper.getTwoBytes(length, this.data, 4);
            IntegerHelper.getTwoBytes(this.sheetRef, this.data, 6);
            IntegerHelper.getTwoBytes(this.sheetRef, this.data, 8);
            BuiltInName builtInName = this.builtInName;
            if (builtInName != null) {
                this.data[15] = (byte) builtInName.getValue();
            } else {
                StringHelper.getBytes(this.name, this.data, 15);
            }
            int length2 = this.builtInName != null ? 16 : this.name.length() + 15;
            NameRange[] nameRangeArr2 = this.ranges;
            if (nameRangeArr2.length > 1) {
                byte[] bArr4 = this.data;
                int i = length2 + 1;
                bArr4[length2] = 41;
                IntegerHelper.getTwoBytes(length - 3, bArr4, i);
                int i2 = i + 2;
                int i3 = 0;
                while (true) {
                    NameRange[] nameRangeArr3 = this.ranges;
                    if (i3 >= nameRangeArr3.length) {
                        break;
                    }
                    int i4 = i2 + 1;
                    this.data[i2] = 59;
                    byte[] data = nameRangeArr3[i3].getData();
                    System.arraycopy(data, 0, this.data, i4, data.length);
                    i2 = i4 + data.length;
                    i3++;
                }
                this.data[i2] = 16;
            } else {
                this.data[length2] = 59;
                byte[] data2 = nameRangeArr2[0].getData();
                System.arraycopy(data2, 0, this.data, length2 + 1, data2.length);
            }
            return this.data;
        }
        return bArr;
    }

    public int getIndex() {
        return this.index;
    }

    public String getName() {
        return this.name;
    }

    public NameRange[] getRanges() {
        return this.ranges;
    }

    public int getSheetRef() {
        return this.sheetRef;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rowInserted(int i, int i2) {
        int i3 = 0;
        while (true) {
            NameRange[] nameRangeArr = this.ranges;
            if (i3 >= nameRangeArr.length) {
                return;
            }
            if (i == nameRangeArr[i3].getExternalSheet()) {
                if (i2 <= this.ranges[i3].getFirstRow()) {
                    this.ranges[i3].incrementFirstRow();
                    this.modified = true;
                }
                if (i2 <= this.ranges[i3].getLastRow()) {
                    this.ranges[i3].incrementLastRow();
                    this.modified = true;
                }
            }
            i3++;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean rowRemoved(int i, int i2) {
        NameRange[] nameRangeArr;
        int i3 = 0;
        while (true) {
            NameRange[] nameRangeArr2 = this.ranges;
            if (i3 >= nameRangeArr2.length) {
                break;
            }
            if (i == nameRangeArr2[i3].getExternalSheet()) {
                if (i2 == this.ranges[i3].getFirstRow() && i2 == this.ranges[i3].getLastRow()) {
                    this.ranges[i3] = EMPTY_RANGE;
                }
                if (i2 < this.ranges[i3].getFirstRow() && i2 > 0) {
                    this.ranges[i3].decrementFirstRow();
                    this.modified = true;
                }
                if (i2 <= this.ranges[i3].getLastRow()) {
                    this.ranges[i3].decrementLastRow();
                    this.modified = true;
                }
            }
            i3++;
        }
        int i4 = 0;
        int i5 = 0;
        while (true) {
            nameRangeArr = this.ranges;
            if (i4 >= nameRangeArr.length) {
                break;
            }
            if (nameRangeArr[i4] == EMPTY_RANGE) {
                i5++;
            }
            i4++;
        }
        if (i5 == nameRangeArr.length) {
            return true;
        }
        NameRange[] nameRangeArr3 = new NameRange[nameRangeArr.length - i5];
        int i6 = 0;
        while (true) {
            NameRange[] nameRangeArr4 = this.ranges;
            if (i6 >= nameRangeArr4.length) {
                this.ranges = nameRangeArr3;
                return false;
            }
            if (nameRangeArr4[i6] != EMPTY_RANGE) {
                nameRangeArr3[i6] = nameRangeArr4[i6];
            }
            i6++;
        }
    }

    public void setSheetRef(int i) {
        this.sheetRef = i;
        IntegerHelper.getTwoBytes(i, this.data, 8);
    }
}
