package jxl.write.biff;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import jxl.CellType;
import jxl.Hyperlink;
import jxl.Range;
import jxl.biff.CellReferenceHelper;
import jxl.biff.IntegerHelper;
import jxl.biff.SheetRangeImpl;
import jxl.biff.StringHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class HyperlinkRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$write$biff$HyperlinkRecord;
    private static final LinkType fileLink;
    private static Logger logger;
    private static final LinkType uncLink;
    private static final LinkType unknown;
    private static final LinkType urlLink;
    private static final LinkType workbookLink;
    private String contents;
    private byte[] data;
    private java.io.File file;
    private int firstColumn;
    private int firstRow;
    private int lastColumn;
    private int lastRow;
    private LinkType linkType;
    private String location;
    private boolean modified;
    private Range range;
    private WritableSheet sheet;
    private URL url;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class LinkType {
        private LinkType() {
        }
    }

    static {
        Class cls = class$jxl$write$biff$HyperlinkRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.HyperlinkRecord");
            class$jxl$write$biff$HyperlinkRecord = cls;
        }
        logger = Logger.getLogger(cls);
        urlLink = new LinkType();
        fileLink = new LinkType();
        uncLink = new LinkType();
        workbookLink = new LinkType();
        unknown = new LinkType();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HyperlinkRecord(int i, int i2, int i3, int i4, java.io.File file, String str) {
        super(Type.HLINK);
        this.firstColumn = i;
        this.firstRow = i2;
        this.lastColumn = Math.max(i, i3);
        this.lastRow = Math.max(this.firstRow, i4);
        this.contents = str;
        this.file = file;
        this.linkType = file.getPath().startsWith("\\\\") ? uncLink : fileLink;
        this.modified = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HyperlinkRecord(int i, int i2, int i3, int i4, String str, WritableSheet writableSheet, int i5, int i6, int i7, int i8) {
        super(Type.HLINK);
        this.firstColumn = i;
        this.firstRow = i2;
        this.lastColumn = Math.max(i, i3);
        this.lastRow = Math.max(this.firstRow, i4);
        setLocation(writableSheet, i5, i6, i7, i8);
        this.contents = str;
        this.linkType = workbookLink;
        this.modified = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HyperlinkRecord(int i, int i2, int i3, int i4, URL url, String str) {
        super(Type.HLINK);
        this.firstColumn = i;
        this.firstRow = i2;
        this.lastColumn = Math.max(i, i3);
        this.lastRow = Math.max(this.firstRow, i4);
        this.url = url;
        this.contents = str;
        this.linkType = urlLink;
        this.modified = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HyperlinkRecord(Hyperlink hyperlink, WritableSheet writableSheet) {
        super(Type.HLINK);
        if (hyperlink instanceof jxl.read.biff.HyperlinkRecord) {
            copyReadHyperlink(hyperlink, writableSheet);
        } else {
            copyWritableHyperlink(hyperlink, writableSheet);
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void copyReadHyperlink(Hyperlink hyperlink, WritableSheet writableSheet) {
        jxl.read.biff.HyperlinkRecord hyperlinkRecord = (jxl.read.biff.HyperlinkRecord) hyperlink;
        this.data = hyperlinkRecord.getRecord().getData();
        this.sheet = writableSheet;
        this.firstRow = hyperlinkRecord.getRow();
        this.firstColumn = hyperlinkRecord.getColumn();
        this.lastRow = hyperlinkRecord.getLastRow();
        int lastColumn = hyperlinkRecord.getLastColumn();
        this.lastColumn = lastColumn;
        this.range = new SheetRangeImpl(writableSheet, this.firstColumn, this.firstRow, lastColumn, this.lastRow);
        this.linkType = unknown;
        if (hyperlinkRecord.isFile()) {
            this.linkType = fileLink;
            this.file = hyperlinkRecord.getFile();
        } else if (hyperlinkRecord.isURL()) {
            this.linkType = urlLink;
            this.url = hyperlinkRecord.getURL();
        } else if (hyperlinkRecord.isLocation()) {
            this.linkType = workbookLink;
            this.location = hyperlinkRecord.getLocation();
        }
        this.modified = false;
    }

    private void copyWritableHyperlink(Hyperlink hyperlink, WritableSheet writableSheet) {
        HyperlinkRecord hyperlinkRecord = (HyperlinkRecord) hyperlink;
        this.firstRow = hyperlinkRecord.firstRow;
        this.lastRow = hyperlinkRecord.lastRow;
        this.firstColumn = hyperlinkRecord.firstColumn;
        this.lastColumn = hyperlinkRecord.lastColumn;
        if (hyperlinkRecord.url != null) {
            try {
                this.url = new URL(hyperlinkRecord.url.toString());
            } catch (MalformedURLException unused) {
                Assert.verify(false);
            }
        }
        if (hyperlinkRecord.file != null) {
            this.file = new java.io.File(hyperlinkRecord.file.getPath());
        }
        this.location = hyperlinkRecord.location;
        this.contents = hyperlinkRecord.contents;
        this.linkType = hyperlinkRecord.linkType;
        this.modified = true;
        this.sheet = writableSheet;
        this.range = new SheetRangeImpl(writableSheet, this.firstColumn, this.firstRow, this.lastColumn, this.lastRow);
    }

    private byte[] getFileData(byte[] bArr) {
        char charAt;
        ArrayList arrayList = new ArrayList();
        ArrayList arrayList2 = new ArrayList();
        arrayList.add(this.file.getName());
        arrayList2.add(getShortName(this.file.getName()));
        java.io.File file = this.file;
        while (true) {
            file = file.getParentFile();
            if (file == null) {
                break;
            }
            arrayList.add(file.getName());
            arrayList2.add(getShortName(file.getName()));
        }
        int size = arrayList.size() - 1;
        boolean z = true;
        int i = 0;
        while (z) {
            if (((String) arrayList.get(size)).equals("..")) {
                i++;
                arrayList.remove(size);
                arrayList2.remove(size);
            } else {
                z = false;
            }
            size--;
        }
        StringBuffer stringBuffer = new StringBuffer();
        StringBuffer stringBuffer2 = new StringBuffer();
        if (this.file.getPath().charAt(1) == ':' && (charAt = this.file.getPath().charAt(0)) != 'C' && charAt != 'c') {
            stringBuffer.append(charAt);
            stringBuffer.append(':');
            stringBuffer2.append(charAt);
            stringBuffer2.append(':');
        }
        for (int size2 = arrayList.size() - 1; size2 >= 0; size2--) {
            stringBuffer.append((String) arrayList.get(size2));
            stringBuffer2.append((String) arrayList2.get(size2));
            if (size2 != 0) {
                stringBuffer.append("\\");
                stringBuffer2.append("\\");
            }
        }
        String stringBuffer3 = stringBuffer.toString();
        String stringBuffer4 = stringBuffer2.toString();
        int length = bArr.length + 4 + stringBuffer4.length() + 1 + 16 + 2 + 8 + ((stringBuffer3.length() + 1) * 2) + 24;
        String str = this.contents;
        if (str != null) {
            length += ((str.length() + 1) * 2) + 4;
        }
        byte[] bArr2 = new byte[length];
        System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        int length2 = bArr.length;
        String str2 = this.contents;
        if (str2 != null) {
            IntegerHelper.getFourBytes(str2.length() + 1, bArr2, length2);
            StringHelper.getUnicodeBytes(this.contents, bArr2, length2 + 4);
            length2 += ((this.contents.length() + 1) * 2) + 4;
        }
        bArr2[length2] = 3;
        bArr2[length2 + 1] = 3;
        bArr2[length2 + 2] = 0;
        bArr2[length2 + 3] = 0;
        bArr2[length2 + 4] = 0;
        bArr2[length2 + 5] = 0;
        bArr2[length2 + 6] = 0;
        bArr2[length2 + 7] = 0;
        bArr2[length2 + 8] = -64;
        bArr2[length2 + 9] = 0;
        bArr2[length2 + 10] = 0;
        bArr2[length2 + 11] = 0;
        bArr2[length2 + 12] = 0;
        bArr2[length2 + 13] = 0;
        bArr2[length2 + 14] = 0;
        bArr2[length2 + 15] = 70;
        int i2 = length2 + 16;
        IntegerHelper.getTwoBytes(i, bArr2, i2);
        int i3 = i2 + 2;
        IntegerHelper.getFourBytes(stringBuffer4.length() + 1, bArr2, i3);
        StringHelper.getBytes(stringBuffer4, bArr2, i3 + 4);
        int length3 = i3 + stringBuffer4.length() + 1 + 4;
        bArr2[length3] = -1;
        bArr2[length3 + 1] = -1;
        bArr2[length3 + 2] = -83;
        bArr2[length3 + 3] = -34;
        bArr2[length3 + 4] = 0;
        bArr2[length3 + 5] = 0;
        bArr2[length3 + 6] = 0;
        bArr2[length3 + 7] = 0;
        bArr2[length3 + 8] = 0;
        bArr2[length3 + 9] = 0;
        bArr2[length3 + 10] = 0;
        bArr2[length3 + 11] = 0;
        bArr2[length3 + 12] = 0;
        bArr2[length3 + 13] = 0;
        bArr2[length3 + 14] = 0;
        bArr2[length3 + 15] = 0;
        bArr2[length3 + 16] = 0;
        bArr2[length3 + 17] = 0;
        bArr2[length3 + 18] = 0;
        bArr2[length3 + 19] = 0;
        bArr2[length3 + 20] = 0;
        bArr2[length3 + 21] = 0;
        bArr2[length3 + 22] = 0;
        bArr2[length3 + 23] = 0;
        int i4 = length3 + 24;
        IntegerHelper.getFourBytes((stringBuffer3.length() * 2) + 6, bArr2, i4);
        int i5 = i4 + 4;
        IntegerHelper.getFourBytes(stringBuffer3.length() * 2, bArr2, i5);
        int i6 = i5 + 4;
        bArr2[i6] = 3;
        bArr2[i6 + 1] = 0;
        StringHelper.getUnicodeBytes(stringBuffer3, bArr2, i6 + 2);
        stringBuffer3.length();
        return bArr2;
    }

    private byte[] getLocationData(byte[] bArr) {
        byte[] bArr2 = new byte[bArr.length + 4 + ((this.location.length() + 1) * 2)];
        System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        int length = bArr.length;
        IntegerHelper.getFourBytes(this.location.length() + 1, bArr2, length);
        StringHelper.getUnicodeBytes(this.location, bArr2, length + 4);
        return bArr2;
    }

    private String getShortName(String str) {
        String substring;
        int indexOf = str.indexOf(46);
        if (indexOf == -1) {
            substring = BuildConfig.FLAVOR;
        } else {
            String substring2 = str.substring(0, indexOf);
            substring = str.substring(indexOf + 1);
            str = substring2;
        }
        if (str.length() > 8) {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(str.substring(0, 6));
            stringBuffer.append("~");
            stringBuffer.append(str.length() - 8);
            str = stringBuffer.toString().substring(0, 8);
        }
        String substring3 = substring.substring(0, Math.min(3, substring.length()));
        if (substring3.length() > 0) {
            StringBuffer stringBuffer2 = new StringBuffer();
            stringBuffer2.append(str);
            stringBuffer2.append('.');
            stringBuffer2.append(substring3);
            return stringBuffer2.toString();
        }
        return str;
    }

    private byte[] getUNCData(byte[] bArr) {
        String path = this.file.getPath();
        byte[] bArr2 = new byte[bArr.length + (path.length() * 2) + 2 + 4];
        System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        int length = bArr.length;
        IntegerHelper.getFourBytes(path.length() + 1, bArr2, length);
        StringHelper.getUnicodeBytes(path, bArr2, length + 4);
        return bArr2;
    }

    private byte[] getURLData(byte[] bArr) {
        String url = this.url.toString();
        int length = bArr.length + 20 + ((url.length() + 1) * 2);
        String str = this.contents;
        if (str != null) {
            length += ((str.length() + 1) * 2) + 4;
        }
        byte[] bArr2 = new byte[length];
        System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        int length2 = bArr.length;
        String str2 = this.contents;
        if (str2 != null) {
            IntegerHelper.getFourBytes(str2.length() + 1, bArr2, length2);
            StringHelper.getUnicodeBytes(this.contents, bArr2, length2 + 4);
            length2 += ((this.contents.length() + 1) * 2) + 4;
        }
        bArr2[length2] = -32;
        bArr2[length2 + 1] = -55;
        bArr2[length2 + 2] = -22;
        bArr2[length2 + 3] = 121;
        bArr2[length2 + 4] = -7;
        bArr2[length2 + 5] = -70;
        bArr2[length2 + 6] = -50;
        bArr2[length2 + 7] = 17;
        bArr2[length2 + 8] = -116;
        bArr2[length2 + 9] = -126;
        bArr2[length2 + 10] = 0;
        bArr2[length2 + 11] = -86;
        bArr2[length2 + 12] = 0;
        bArr2[length2 + 13] = 75;
        bArr2[length2 + 14] = -87;
        bArr2[length2 + 15] = 11;
        IntegerHelper.getFourBytes((url.length() + 1) * 2, bArr2, length2 + 16);
        StringHelper.getUnicodeBytes(url, bArr2, length2 + 20);
        return bArr2;
    }

    private void setLocation(WritableSheet writableSheet, int i, int i2, int i3, int i4) {
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append('\'');
        int indexOf = writableSheet.getName().indexOf(39);
        String name = writableSheet.getName();
        if (indexOf != -1) {
            int i5 = 0;
            while (true) {
                int indexOf2 = name.indexOf(39, i5);
                if (indexOf2 == -1 || i5 >= name.length()) {
                    break;
                }
                stringBuffer.append(name.substring(i5, indexOf2));
                stringBuffer.append("''");
                i5 = indexOf2 + 1;
            }
            name = name.substring(i5);
        }
        stringBuffer.append(name);
        stringBuffer.append('\'');
        stringBuffer.append('!');
        int max = Math.max(i, i3);
        int max2 = Math.max(i2, i4);
        CellReferenceHelper.getCellReference(i, i2, stringBuffer);
        stringBuffer.append(':');
        CellReferenceHelper.getCellReference(max, max2, stringBuffer);
        this.location = stringBuffer.toString();
    }

    public int getColumn() {
        return this.firstColumn;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String getContents() {
        return this.contents;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        if (this.modified) {
            int i = 0;
            IntegerHelper.getTwoBytes(this.firstRow, r0, 0);
            IntegerHelper.getTwoBytes(this.lastRow, r0, 2);
            IntegerHelper.getTwoBytes(this.firstColumn, r0, 4);
            IntegerHelper.getTwoBytes(this.lastColumn, r0, 6);
            byte[] bArr = {0, 0, 0, 0, 0, 0, 0, 0, -48, -55, -22, 121, -7, -70, -50, 17, -116, -126, 0, -86, 0, 75, -87, 11, 2, 0, 0, 0};
            if (isURL()) {
                i = 3;
                if (this.contents != null) {
                    i = 23;
                }
            } else if (isFile()) {
                i = 1;
                if (this.contents != null) {
                    i = 21;
                }
            } else if (isLocation()) {
                i = 8;
            } else if (isUNC()) {
                i = 259;
            }
            IntegerHelper.getFourBytes(i, bArr, 28);
            if (isURL()) {
                this.data = getURLData(bArr);
            } else if (isFile()) {
                this.data = getFileData(bArr);
            } else if (isLocation()) {
                this.data = getLocationData(bArr);
            } else if (isUNC()) {
                this.data = getUNCData(bArr);
            }
            return this.data;
        }
        return this.data;
    }

    public java.io.File getFile() {
        return this.file;
    }

    public int getLastColumn() {
        return this.lastColumn;
    }

    public int getLastRow() {
        return this.lastRow;
    }

    public Range getRange() {
        return this.range;
    }

    public int getRow() {
        return this.firstRow;
    }

    public URL getURL() {
        return this.url;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void initialize(WritableSheet writableSheet) {
        this.sheet = writableSheet;
        this.range = new SheetRangeImpl(writableSheet, this.firstColumn, this.firstRow, this.lastColumn, this.lastRow);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void insertColumn(int i) {
        Assert.verify((this.sheet == null || this.range == null) ? false : true);
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
        if (this.modified) {
            this.range = new SheetRangeImpl(this.sheet, this.firstColumn, this.firstRow, this.lastColumn, this.lastRow);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void insertRow(int i) {
        Assert.verify((this.sheet == null || this.range == null) ? false : true);
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
        if (this.modified) {
            this.range = new SheetRangeImpl(this.sheet, this.firstColumn, this.firstRow, this.lastColumn, this.lastRow);
        }
    }

    public boolean isFile() {
        return this.linkType == fileLink;
    }

    public boolean isLocation() {
        return this.linkType == workbookLink;
    }

    public boolean isUNC() {
        return this.linkType == uncLink;
    }

    public boolean isURL() {
        return this.linkType == urlLink;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeColumn(int i) {
        Assert.verify((this.sheet == null || this.range == null) ? false : true);
        int i2 = this.lastColumn;
        if (i > i2) {
            return;
        }
        int i3 = this.firstColumn;
        if (i < i3) {
            this.firstColumn = i3 - 1;
            this.modified = true;
        }
        if (i < i2) {
            this.lastColumn = i2 - 1;
            this.modified = true;
        }
        if (this.modified) {
            Assert.verify(this.range != null);
            this.range = new SheetRangeImpl(this.sheet, this.firstColumn, this.firstRow, this.lastColumn, this.lastRow);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeRow(int i) {
        Assert.verify((this.sheet == null || this.range == null) ? false : true);
        int i2 = this.lastRow;
        if (i > i2) {
            return;
        }
        int i3 = this.firstRow;
        if (i < i3) {
            this.firstRow = i3 - 1;
            this.modified = true;
        }
        if (i < i2) {
            this.lastRow = i2 - 1;
            this.modified = true;
        }
        if (this.modified) {
            Assert.verify(this.range != null);
            this.range = new SheetRangeImpl(this.sheet, this.firstColumn, this.firstRow, this.lastColumn, this.lastRow);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setContents(String str) {
        this.contents = str;
        this.modified = true;
    }

    public void setFile(java.io.File file) {
        this.linkType = fileLink;
        this.url = null;
        this.location = null;
        this.contents = null;
        this.file = file;
        this.modified = true;
        WritableSheet writableSheet = this.sheet;
        if (writableSheet == null) {
            return;
        }
        WritableCell writableCell = writableSheet.getWritableCell(this.firstColumn, this.firstRow);
        Assert.verify(writableCell.getType() == CellType.LABEL);
        ((Label) writableCell).setString(file.toString());
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setLocation(String str, WritableSheet writableSheet, int i, int i2, int i3, int i4) {
        this.linkType = workbookLink;
        this.url = null;
        this.file = null;
        this.modified = true;
        this.contents = str;
        setLocation(writableSheet, i, i2, i3, i4);
        if (writableSheet == null) {
            return;
        }
        WritableCell writableCell = writableSheet.getWritableCell(this.firstColumn, this.firstRow);
        Assert.verify(writableCell.getType() == CellType.LABEL);
        ((Label) writableCell).setString(str);
    }

    public void setURL(URL url) {
        URL url2 = this.url;
        this.linkType = urlLink;
        this.file = null;
        this.location = null;
        this.contents = null;
        this.url = url;
        this.modified = true;
        WritableSheet writableSheet = this.sheet;
        if (writableSheet == null) {
            return;
        }
        WritableCell writableCell = writableSheet.getWritableCell(this.firstColumn, this.firstRow);
        if (writableCell.getType() == CellType.LABEL) {
            Label label = (Label) writableCell;
            String url3 = url2.toString();
            String substring = (url3.charAt(url3.length() - 1) == '/' || url3.charAt(url3.length() - 1) == '\\') ? url3.substring(0, url3.length() - 1) : BuildConfig.FLAVOR;
            if (label.getString().equals(url3) || label.getString().equals(substring)) {
                label.setString(url.toString());
            }
        }
    }

    public String toString() {
        return isFile() ? this.file.toString() : isURL() ? this.url.toString() : isUNC() ? this.file.toString() : BuildConfig.FLAVOR;
    }
}
