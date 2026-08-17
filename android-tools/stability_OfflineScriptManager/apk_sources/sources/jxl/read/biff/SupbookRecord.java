package jxl.read.biff;

import jxl.WorkbookSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class SupbookRecord extends RecordData {
    public static final Type ADDIN;
    public static final Type EXTERNAL;
    public static final Type INTERNAL;
    public static final Type LINK;
    public static final Type UNKNOWN;
    static /* synthetic */ Class class$jxl$read$biff$SupbookRecord;
    private static Logger logger;
    private String fileName;
    private int numSheets;
    private String[] sheetNames;
    private Type type;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class Type {
        private Type() {
        }
    }

    static {
        Class cls = class$jxl$read$biff$SupbookRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.SupbookRecord");
            class$jxl$read$biff$SupbookRecord = cls;
        }
        logger = Logger.getLogger(cls);
        INTERNAL = new Type();
        EXTERNAL = new Type();
        ADDIN = new Type();
        LINK = new Type();
        UNKNOWN = new Type();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public SupbookRecord(Record record, WorkbookSettings workbookSettings) {
        super(record);
        byte[] data = getRecord().getData();
        this.type = data.length == 4 ? (data[2] == 1 && data[3] == 4) ? INTERNAL : (data[2] == 1 && data[3] == 58) ? ADDIN : UNKNOWN : (data[0] == 0 && data[1] == 0) ? LINK : EXTERNAL;
        if (this.type == INTERNAL) {
            this.numSheets = IntegerHelper.getInt(data[0], data[1]);
        }
        if (this.type == EXTERNAL) {
            readExternal(data, workbookSettings);
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private String getEncodedFilename(byte[] bArr, int i, int i2) {
        String str;
        StringBuffer stringBuffer = new StringBuffer();
        int i3 = i + i2;
        while (i2 < i3) {
            char c2 = (char) bArr[i2];
            if (c2 == 1) {
                i2++;
                stringBuffer.append((char) bArr[i2]);
                str = ":\\\\";
            } else {
                if (c2 == 2 || c2 == 3) {
                    stringBuffer.append('\\');
                } else if (c2 == 4) {
                    str = "..\\";
                } else {
                    stringBuffer.append(c2);
                }
                i2++;
            }
            stringBuffer.append(str);
            i2++;
        }
        return stringBuffer.toString();
    }

    private String getUnicodeEncodedFilename(byte[] bArr, int i, int i2) {
        String str;
        StringBuffer stringBuffer = new StringBuffer();
        int i3 = (i * 2) + i2;
        while (i2 < i3) {
            char c2 = (char) IntegerHelper.getInt(bArr[i2], bArr[i2 + 1]);
            if (c2 == 1) {
                i2 += 2;
                stringBuffer.append((char) IntegerHelper.getInt(bArr[i2], bArr[i2 + 1]));
                str = ":\\\\";
            } else {
                if (c2 == 2 || c2 == 3) {
                    stringBuffer.append('\\');
                } else if (c2 == 4) {
                    str = "..\\";
                } else {
                    stringBuffer.append(c2);
                }
                i2 += 2;
            }
            stringBuffer.append(str);
            i2 += 2;
        }
        return stringBuffer.toString();
    }

    private void readExternal(byte[] bArr, WorkbookSettings workbookSettings) {
        int i;
        this.numSheets = IntegerHelper.getInt(bArr[0], bArr[1]);
        int i2 = IntegerHelper.getInt(bArr[2], bArr[3]) - 1;
        int i3 = 6;
        if (bArr[4] == 0) {
            this.fileName = bArr[5] == 0 ? StringHelper.getString(bArr, i2, 6, workbookSettings) : getEncodedFilename(bArr, i2, 6);
        } else {
            i3 = 7;
            this.fileName = IntegerHelper.getInt(bArr[5], bArr[6]) == 0 ? StringHelper.getUnicodeString(bArr, i2, 7) : getUnicodeEncodedFilename(bArr, i2, 7);
            i2 *= 2;
        }
        int i4 = i2 + i3;
        this.sheetNames = new String[this.numSheets];
        for (int i5 = 0; i5 < this.sheetNames.length; i5++) {
            int i6 = IntegerHelper.getInt(bArr[i4], bArr[i4 + 1]);
            int i7 = i4 + 2;
            if (bArr[i7] == 0) {
                this.sheetNames[i5] = StringHelper.getString(bArr, i6, i4 + 3, workbookSettings);
                i = i6 + 3;
            } else if (bArr[i7] == 1) {
                this.sheetNames[i5] = StringHelper.getUnicodeString(bArr, i6, i4 + 3);
                i = (i6 * 2) + 3;
            }
            i4 += i;
        }
    }

    public byte[] getData() {
        return getRecord().getData();
    }

    public String getFileName() {
        return this.fileName;
    }

    public int getNumberOfSheets() {
        return this.numSheets;
    }

    public String getSheetName(int i) {
        return this.sheetNames[i];
    }

    public Type getType() {
        return this.type;
    }
}
