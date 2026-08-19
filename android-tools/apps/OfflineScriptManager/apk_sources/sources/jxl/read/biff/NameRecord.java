package jxl.read.biff;

import java.util.ArrayList;
import jxl.SheetSettings;
import jxl.WorkbookSettings;
import jxl.biff.BuiltInName;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
import jxl.common.Assert;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class NameRecord extends RecordData {
    private static final int areaReference = 59;
    public static Biff7 biff7 = null;
    private static final int builtIn = 32;
    private static final int cellReference = 58;
    static /* synthetic */ Class class$jxl$read$biff$NameRecord = null;
    private static final int commandMacro = 12;
    private static Logger logger = null;
    private static final int subExpression = 41;
    private static final int union = 16;
    private BuiltInName builtInName;
    private int index;
    private boolean isbiff8;
    private String name;
    private ArrayList ranges;
    private int sheetRef;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class Biff7 {
        private Biff7() {
        }
    }

    /* loaded from: classes.dex */
    public class NameRange {
        private int columnFirst;
        private int columnLast;
        private int externalSheet;
        private int rowFirst;
        private int rowLast;

        NameRange(int i, int i2, int i3, int i4, int i5) {
            this.columnFirst = i2;
            this.rowFirst = i3;
            this.columnLast = i4;
            this.rowLast = i5;
            this.externalSheet = i;
        }

        public int getExternalSheet() {
            return this.externalSheet;
        }

        public int getFirstColumn() {
            return this.columnFirst;
        }

        public int getFirstRow() {
            return this.rowFirst;
        }

        public int getLastColumn() {
            return this.columnLast;
        }

        public int getLastRow() {
            return this.rowLast;
        }
    }

    static {
        Class cls = class$jxl$read$biff$NameRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.NameRecord");
            class$jxl$read$biff$NameRecord = cls;
        }
        logger = Logger.getLogger(cls);
        biff7 = new Biff7();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public NameRecord(Record record, WorkbookSettings workbookSettings, int i) {
        super(record);
        NameRange nameRange;
        this.sheetRef = 0;
        this.index = i;
        this.isbiff8 = true;
        try {
            this.ranges = new ArrayList();
            byte[] data = getRecord().getData();
            int i2 = IntegerHelper.getInt(data[0], data[1]);
            byte b2 = data[3];
            this.sheetRef = IntegerHelper.getInt(data[8], data[9]);
            if ((i2 & 32) != 0) {
                this.builtInName = BuiltInName.getBuiltInName(data[15]);
            } else {
                this.name = StringHelper.getString(data, b2, 15, workbookSettings);
            }
            if ((i2 & 12) != 0) {
                return;
            }
            int i3 = b2 + 15;
            if (data[i3] == 58) {
                int i4 = IntegerHelper.getInt(data[i3 + 1], data[i3 + 2]);
                int i5 = IntegerHelper.getInt(data[i3 + 3], data[i3 + 4]);
                int i6 = IntegerHelper.getInt(data[i3 + 5], data[i3 + 6]);
                int i7 = i6 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
                Assert.verify((i6 & 786432) == 0);
                nameRange = new NameRange(i4, i7, i5, i7, i5);
            } else if (data[i3] == 59) {
                for (int i8 = i3; i8 < data.length; i8 += 11) {
                    int i9 = IntegerHelper.getInt(data[i8 + 1], data[i8 + 2]);
                    int i10 = IntegerHelper.getInt(data[i8 + 3], data[i8 + 4]);
                    int i11 = IntegerHelper.getInt(data[i8 + 5], data[i8 + 6]);
                    int i12 = IntegerHelper.getInt(data[i8 + 7], data[i8 + 8]);
                    int i13 = i12 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
                    Assert.verify((i12 & 786432) == 0);
                    int i14 = IntegerHelper.getInt(data[i8 + 9], data[i8 + 10]);
                    int i15 = i14 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
                    Assert.verify((i14 & 786432) == 0);
                    this.ranges.add(new NameRange(i9, i13, i10, i15, i11));
                }
                return;
            } else if (data[i3] == 41) {
                if (i3 < data.length && data[i3] != 58 && data[i3] != 59) {
                    if (data[i3] == 41) {
                        i3 += 3;
                    } else if (data[i3] == 16) {
                        i3++;
                    }
                }
                int i16 = i3;
                while (i16 < data.length) {
                    int i17 = IntegerHelper.getInt(data[i16 + 1], data[i16 + 2]);
                    int i18 = IntegerHelper.getInt(data[i16 + 3], data[i16 + 4]);
                    int i19 = IntegerHelper.getInt(data[i16 + 5], data[i16 + 6]);
                    int i20 = IntegerHelper.getInt(data[i16 + 7], data[i16 + 8]);
                    int i21 = i20 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
                    Assert.verify((i20 & 786432) == 0 ? true : r8);
                    int i22 = IntegerHelper.getInt(data[i16 + 9], data[i16 + 10]);
                    int i23 = i22 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
                    Assert.verify((i22 & 786432) == 0 ? true : r8);
                    this.ranges.add(new NameRange(i17, i21, i18, i23, i19));
                    i16 += 11;
                    if (i16 < data.length && data[i16] != 58 && data[i16] != 59) {
                        if (data[i16] == 41) {
                            i16 += 3;
                        } else if (data[i16] == 16) {
                            i16++;
                        }
                    }
                    r8 = false;
                }
                return;
            } else {
                String str = this.name;
                if (str == null) {
                    str = this.builtInName.getName();
                }
                Logger logger2 = logger;
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Cannot read name ranges for ");
                stringBuffer.append(str);
                stringBuffer.append(" - setting to empty");
                logger2.warn(stringBuffer.toString());
                nameRange = new NameRange(0, 0, 0, 0, 0);
            }
            this.ranges.add(nameRange);
        } catch (Throwable unused) {
            logger.warn("Cannot read name");
            this.name = "ERROR";
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x00c9, code lost:
        if (r12[r14] == 16) goto L31;
     */
    /* JADX WARN: Removed duplicated region for block: B:30:0x00d0 A[Catch: all -> 0x011f, TryCatch #0 {all -> 0x011f, blocks: (B:3:0x000a, B:6:0x0037, B:8:0x003d, B:9:0x0069, B:11:0x006f, B:13:0x0072, B:14:0x00ad, B:16:0x00b3, B:18:0x00b8, B:20:0x00bc, B:22:0x00c0, B:24:0x00c4, B:25:0x00c7, B:27:0x00cb, B:28:0x00cd, B:30:0x00d0, B:32:0x010d, B:34:0x0111, B:36:0x0115, B:39:0x011a), top: B:44:0x000a }] */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:27:0x00cb -> B:28:0x00cd). Please submit an issue!!! */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public NameRecord(jxl.read.biff.Record r12, jxl.WorkbookSettings r13, int r14, jxl.read.biff.NameRecord.Biff7 r15) {
        /*
            Method dump skipped, instructions count: 299
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.read.biff.NameRecord.<init>(jxl.read.biff.Record, jxl.WorkbookSettings, int, jxl.read.biff.NameRecord$Biff7):void");
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public BuiltInName getBuiltInName() {
        return this.builtInName;
    }

    public byte[] getData() {
        return getRecord().getData();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getIndex() {
        return this.index;
    }

    public String getName() {
        return this.name;
    }

    public NameRange[] getRanges() {
        return (NameRange[]) this.ranges.toArray(new NameRange[this.ranges.size()]);
    }

    public int getSheetRef() {
        return this.sheetRef;
    }

    public boolean isBiff8() {
        return this.isbiff8;
    }

    public boolean isGlobal() {
        return this.sheetRef == 0;
    }

    public void setSheetRef(int i) {
        this.sheetRef = i;
    }
}
