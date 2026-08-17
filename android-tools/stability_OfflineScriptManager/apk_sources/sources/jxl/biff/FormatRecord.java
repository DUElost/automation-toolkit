package jxl.biff;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import jxl.common.Logger;
import jxl.format.Format;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class FormatRecord extends WritableRecordData implements DisplayFormat, Format {
    public static final BiffType biff7;
    public static final BiffType biff8;
    static /* synthetic */ Class class$jxl$biff$FormatRecord;
    private static String[] dateStrings;
    public static Logger logger;
    private byte[] data;
    private boolean date;
    private java.text.Format format;
    private String formatString;
    private int indexCode;
    private boolean initialized;
    private boolean number;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class BiffType {
        private BiffType() {
        }
    }

    static {
        Class cls = class$jxl$biff$FormatRecord;
        if (cls == null) {
            cls = class$("jxl.biff.FormatRecord");
            class$jxl$biff$FormatRecord = cls;
        }
        logger = Logger.getLogger(cls);
        dateStrings = new String[]{"dd", "mm", "yy", "hh", "ss", "m/", "/d"};
        biff8 = new BiffType();
        biff7 = new BiffType();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public FormatRecord() {
        super(Type.FORMAT);
        this.initialized = false;
    }

    FormatRecord(String str, int i) {
        super(Type.FORMAT);
        this.formatString = str;
        this.indexCode = i;
        this.initialized = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public FormatRecord(FormatRecord formatRecord) {
        super(Type.FORMAT);
        this.initialized = false;
        this.formatString = formatRecord.formatString;
        this.date = formatRecord.date;
        this.number = formatRecord.number;
    }

    /* JADX WARN: Code restructure failed: missing block: B:18:0x0069, code lost:
        r5.date = true;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public FormatRecord(jxl.read.biff.Record r6, jxl.WorkbookSettings r7, jxl.biff.FormatRecord.BiffType r8) {
        /*
            r5 = this;
            r5.<init>(r6)
            jxl.read.biff.Record r6 = r5.getRecord()
            byte[] r6 = r6.getData()
            r0 = 0
            r1 = r6[r0]
            r2 = 1
            r3 = r6[r2]
            int r1 = jxl.biff.IntegerHelper.getInt(r1, r3)
            r5.indexCode = r1
            r5.initialized = r2
            jxl.biff.FormatRecord$BiffType r1 = jxl.biff.FormatRecord.biff8
            r3 = 3
            r4 = 2
            if (r8 != r1) goto L37
            r8 = r6[r4]
            r1 = r6[r3]
            int r8 = jxl.biff.IntegerHelper.getInt(r8, r1)
            r1 = 4
            r1 = r6[r1]
            r3 = 5
            if (r1 != 0) goto L32
            java.lang.String r6 = jxl.biff.StringHelper.getString(r6, r8, r3, r7)
            goto L43
        L32:
            java.lang.String r6 = jxl.biff.StringHelper.getUnicodeString(r6, r8, r3)
            goto L43
        L37:
            r7 = r6[r4]
            byte[] r8 = new byte[r7]
            java.lang.System.arraycopy(r6, r3, r8, r0, r7)
            java.lang.String r6 = new java.lang.String
            r6.<init>(r8)
        L43:
            r5.formatString = r6
            r5.date = r0
            r5.number = r0
        L49:
            java.lang.String[] r6 = jxl.biff.FormatRecord.dateStrings
            int r7 = r6.length
            r8 = -1
            if (r0 >= r7) goto L6b
            r6 = r6[r0]
            java.lang.String r7 = r5.formatString
            int r7 = r7.indexOf(r6)
            if (r7 != r8) goto L69
            java.lang.String r7 = r5.formatString
            java.lang.String r6 = r6.toUpperCase()
            int r6 = r7.indexOf(r6)
            if (r6 == r8) goto L66
            goto L69
        L66:
            int r0 = r0 + 1
            goto L49
        L69:
            r5.date = r2
        L6b:
            boolean r6 = r5.date
            if (r6 != 0) goto L85
            java.lang.String r6 = r5.formatString
            r7 = 35
            int r6 = r6.indexOf(r7)
            if (r6 != r8) goto L83
            java.lang.String r6 = r5.formatString
            r7 = 48
            int r6 = r6.indexOf(r7)
            if (r6 == r8) goto L85
        L83:
            r5.number = r2
        L85:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.biff.FormatRecord.<init>(jxl.read.biff.Record, jxl.WorkbookSettings, jxl.biff.FormatRecord$BiffType):void");
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof FormatRecord) {
            FormatRecord formatRecord = (FormatRecord) obj;
            if (this.initialized && formatRecord.initialized && (this.date != formatRecord.date || this.number != formatRecord.number)) {
                return false;
            }
            return this.formatString.equals(formatRecord.formatString);
        }
        return false;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[(this.formatString.length() * 2) + 3 + 2];
        this.data = bArr;
        IntegerHelper.getTwoBytes(this.indexCode, bArr, 0);
        IntegerHelper.getTwoBytes(this.formatString.length(), this.data, 2);
        byte[] bArr2 = this.data;
        bArr2[4] = 1;
        StringHelper.getUnicodeBytes(this.formatString, bArr2, 5);
        return this.data;
    }

    public final DateFormat getDateFormat() {
        int i;
        int i2;
        int i3;
        char c2;
        int indexOf;
        java.text.Format format = this.format;
        if (format == null || !(format instanceof DateFormat)) {
            String str = this.formatString;
            while (true) {
                int indexOf2 = str.indexOf("AM/PM");
                if (indexOf2 == -1) {
                    break;
                }
                StringBuffer stringBuffer = new StringBuffer(str.substring(0, indexOf2));
                stringBuffer.append('a');
                stringBuffer.append(str.substring(indexOf2 + 5));
                str = stringBuffer.toString();
            }
            while (true) {
                int indexOf3 = str.indexOf("ss.0");
                if (indexOf3 == -1) {
                    break;
                }
                StringBuffer stringBuffer2 = new StringBuffer(str.substring(0, indexOf3));
                stringBuffer2.append("ss.SSS");
                int i4 = indexOf3 + 4;
                while (i4 < str.length() && str.charAt(i4) == '0') {
                    i4++;
                }
                stringBuffer2.append(str.substring(i4));
                str = stringBuffer2.toString();
            }
            StringBuffer stringBuffer3 = new StringBuffer();
            for (int i5 = 0; i5 < str.length(); i5++) {
                if (str.charAt(i5) != '\\') {
                    stringBuffer3.append(str.charAt(i5));
                }
            }
            String stringBuffer4 = stringBuffer3.toString();
            if (stringBuffer4.charAt(0) == '[' && (indexOf = stringBuffer4.indexOf(93)) != -1) {
                stringBuffer4 = stringBuffer4.substring(indexOf + 1);
            }
            char[] charArray = replace(stringBuffer4, ";@", BuildConfig.FLAVOR).toCharArray();
            for (i = 0; i < charArray.length; i++) {
                if (charArray[i] == 'm') {
                    if (i > 0) {
                        int i6 = i - 1;
                        if (charArray[i6] == 'm' || charArray[i6] == 'M') {
                            charArray[i] = charArray[i6];
                        }
                    }
                    int i7 = i - 1;
                    int i8 = i7;
                    while (true) {
                        if (i8 <= 0) {
                            i2 = Integer.MAX_VALUE;
                            break;
                        } else if (charArray[i8] == 'h') {
                            i2 = i - i8;
                            break;
                        } else {
                            i8--;
                        }
                    }
                    int i9 = i + 1;
                    int i10 = i9;
                    while (true) {
                        if (i10 >= charArray.length) {
                            break;
                        } else if (charArray[i10] == 'h') {
                            i2 = Math.min(i2, i10 - i);
                            break;
                        } else {
                            i10++;
                        }
                    }
                    int i11 = i7;
                    while (true) {
                        if (i11 <= 0) {
                            break;
                        } else if (charArray[i11] == 'H') {
                            i2 = i - i11;
                            break;
                        } else {
                            i11--;
                        }
                    }
                    int i12 = i9;
                    while (true) {
                        if (i12 >= charArray.length) {
                            break;
                        } else if (charArray[i12] == 'H') {
                            i2 = Math.min(i2, i12 - i);
                            break;
                        } else {
                            i12++;
                        }
                    }
                    int i13 = i7;
                    while (true) {
                        if (i13 <= 0) {
                            break;
                        } else if (charArray[i13] == 's') {
                            i2 = Math.min(i2, i - i13);
                            break;
                        } else {
                            i13--;
                        }
                    }
                    int i14 = i9;
                    while (true) {
                        if (i14 >= charArray.length) {
                            break;
                        } else if (charArray[i14] == 's') {
                            i2 = Math.min(i2, i14 - i);
                            break;
                        } else {
                            i14++;
                        }
                    }
                    int i15 = i7;
                    while (true) {
                        if (i15 <= 0) {
                            i3 = Integer.MAX_VALUE;
                            break;
                        } else if (charArray[i15] == 'd') {
                            i3 = i - i15;
                            break;
                        } else {
                            i15--;
                        }
                    }
                    int i16 = i9;
                    while (true) {
                        if (i16 >= charArray.length) {
                            break;
                        } else if (charArray[i16] == 'd') {
                            i3 = Math.min(i3, i16 - i);
                            break;
                        } else {
                            i16++;
                        }
                    }
                    while (true) {
                        if (i7 <= 0) {
                            break;
                        } else if (charArray[i7] == 'y') {
                            i3 = Math.min(i3, i - i7);
                            break;
                        } else {
                            i7--;
                        }
                    }
                    while (true) {
                        if (i9 >= charArray.length) {
                            break;
                        } else if (charArray[i9] == 'y') {
                            i3 = Math.min(i3, i9 - i);
                            break;
                        } else {
                            i9++;
                        }
                    }
                    if (i3 < i2) {
                        charArray[i] = Character.toUpperCase(charArray[i]);
                    } else if (i3 == i2 && i3 != Integer.MAX_VALUE && ((c2 = charArray[i - i3]) == 'y' || c2 == 'd')) {
                        charArray[i] = Character.toUpperCase(charArray[i]);
                    }
                }
            }
            try {
                this.format = new SimpleDateFormat(new String(charArray));
            } catch (IllegalArgumentException unused) {
                this.format = new SimpleDateFormat("dd MM yyyy hh:mm:ss");
            }
            return (DateFormat) this.format;
        }
        return (DateFormat) format;
    }

    @Override // jxl.biff.DisplayFormat
    public int getFormatIndex() {
        return this.indexCode;
    }

    @Override // jxl.format.Format
    public String getFormatString() {
        return this.formatString;
    }

    public int getIndexCode() {
        return this.indexCode;
    }

    public final NumberFormat getNumberFormat() {
        java.text.Format format = this.format;
        if (format == null || !(format instanceof NumberFormat)) {
            try {
                this.format = new DecimalFormat(replace(replace(replace(replace(replace(this.formatString, "E+", "E"), "_)", BuildConfig.FLAVOR), "_", BuildConfig.FLAVOR), "[Red]", BuildConfig.FLAVOR), "\\", BuildConfig.FLAVOR));
            } catch (IllegalArgumentException unused) {
                this.format = new DecimalFormat("#.###");
            }
            return (NumberFormat) this.format;
        }
        return (NumberFormat) format;
    }

    public int hashCode() {
        return this.formatString.hashCode();
    }

    @Override // jxl.biff.DisplayFormat
    public void initialize(int i) {
        this.indexCode = i;
        this.initialized = true;
    }

    @Override // jxl.biff.DisplayFormat
    public boolean isBuiltIn() {
        return false;
    }

    public final boolean isDate() {
        return this.date;
    }

    @Override // jxl.biff.DisplayFormat
    public boolean isInitialized() {
        return this.initialized;
    }

    public final boolean isNumber() {
        return this.number;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final String replace(String str, String str2, String str3) {
        while (true) {
            int indexOf = str.indexOf(str2);
            if (indexOf == -1) {
                return str;
            }
            StringBuffer stringBuffer = new StringBuffer(str.substring(0, indexOf));
            stringBuffer.append(str3);
            stringBuffer.append(str.substring(indexOf + str2.length()));
            str = stringBuffer.toString();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setFormatString(String str) {
        this.formatString = str;
    }
}
