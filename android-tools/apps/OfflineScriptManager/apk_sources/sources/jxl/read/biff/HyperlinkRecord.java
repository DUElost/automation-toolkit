package jxl.read.biff;

import java.net.MalformedURLException;
import java.net.URL;
import jxl.Hyperlink;
import jxl.Range;
import jxl.Sheet;
import jxl.WorkbookSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.SheetRangeImpl;
import jxl.biff.StringHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class HyperlinkRecord extends RecordData implements Hyperlink {
    static /* synthetic */ Class class$jxl$read$biff$HyperlinkRecord;
    private static final LinkType fileLink;
    private static Logger logger;
    private static final LinkType unknown;
    private static final LinkType urlLink;
    private static final LinkType workbookLink;
    private java.io.File file;
    private int firstColumn;
    private int firstRow;
    private int lastColumn;
    private int lastRow;
    private LinkType linkType;
    private String location;
    private SheetRangeImpl range;
    private URL url;

    /* loaded from: classes.dex */
    private static class LinkType {
        private LinkType() {
        }
    }

    static {
        Class cls = class$jxl$read$biff$HyperlinkRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.HyperlinkRecord");
            class$jxl$read$biff$HyperlinkRecord = cls;
        }
        logger = Logger.getLogger(cls);
        urlLink = new LinkType();
        fileLink = new LinkType();
        workbookLink = new LinkType();
        unknown = new LinkType();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public HyperlinkRecord(Record record, Sheet sheet, WorkbookSettings workbookSettings) {
        super(record);
        LinkType linkType;
        this.linkType = unknown;
        byte[] data = getRecord().getData();
        this.firstRow = IntegerHelper.getInt(data[0], data[1]);
        this.lastRow = IntegerHelper.getInt(data[2], data[3]);
        this.firstColumn = IntegerHelper.getInt(data[4], data[5]);
        int i = IntegerHelper.getInt(data[6], data[7]);
        this.lastColumn = i;
        this.range = new SheetRangeImpl(sheet, this.firstColumn, this.firstRow, i, this.lastRow);
        int i2 = IntegerHelper.getInt(data[28], data[29], data[30], data[31]);
        int i3 = ((i2 & 20) != 0 ? (IntegerHelper.getInt(data[32], data[33], data[34], data[35]) * 2) + 4 : 0) + 32;
        int i4 = i3 + ((i2 & 128) != 0 ? (IntegerHelper.getInt(data[i3], data[i3 + 1], data[i3 + 2], data[i3 + 3]) * 2) + 4 : 0);
        if ((i2 & 3) == 3) {
            this.linkType = urlLink;
            if (data[i4] == 3) {
                linkType = fileLink;
                this.linkType = linkType;
            }
        } else if ((i2 & 1) != 0) {
            this.linkType = fileLink;
            if (data[i4] == -32) {
                linkType = urlLink;
                this.linkType = linkType;
            }
        } else if ((i2 & 8) != 0) {
            linkType = workbookLink;
            this.linkType = linkType;
        }
        LinkType linkType2 = this.linkType;
        if (linkType2 == urlLink) {
            String str = null;
            int i5 = i4 + 16;
            try {
                try {
                    str = StringHelper.getUnicodeString(data, (IntegerHelper.getInt(data[i5], data[i5 + 1], data[i5 + 2], data[i5 + 3]) / 2) - 1, i5 + 4);
                    this.url = new URL(str);
                } catch (MalformedURLException unused) {
                    Logger logger2 = logger;
                    StringBuffer stringBuffer = new StringBuffer();
                    stringBuffer.append("URL ");
                    stringBuffer.append(str);
                    stringBuffer.append(" is malformed.  Trying a file");
                    logger2.warn(stringBuffer.toString());
                    try {
                        this.linkType = fileLink;
                        this.file = new java.io.File(str);
                    } catch (Exception unused2) {
                        logger.warn("Cannot set to file.  Setting a default URL");
                        this.linkType = urlLink;
                        this.url = new URL("http://www.andykhan.com/jexcelapi/index.html");
                    }
                }
            } catch (MalformedURLException unused3) {
            }
        } else if (linkType2 == fileLink) {
            int i6 = i4 + 16;
            try {
                int i7 = IntegerHelper.getInt(data[i6], data[i6 + 1]);
                String string = StringHelper.getString(data, IntegerHelper.getInt(data[i6 + 2], data[i6 + 3], data[i6 + 4], data[i6 + 5]) - 1, i6 + 6, workbookSettings);
                StringBuffer stringBuffer2 = new StringBuffer();
                for (int i8 = 0; i8 < i7; i8++) {
                    stringBuffer2.append("..\\");
                }
                stringBuffer2.append(string);
                this.file = new java.io.File(stringBuffer2.toString());
            } catch (Throwable th) {
                th.printStackTrace();
                Logger logger3 = logger;
                StringBuffer stringBuffer3 = new StringBuffer();
                stringBuffer3.append("Exception when parsing file ");
                stringBuffer3.append(th.getClass().getName());
                stringBuffer3.append(".");
                logger3.warn(stringBuffer3.toString());
                this.file = new java.io.File(".");
            }
        } else if (linkType2 == workbookLink) {
            this.location = StringHelper.getUnicodeString(data, IntegerHelper.getInt(data[32], data[33], data[34], data[35]) - 1, 36);
        } else {
            logger.warn("Cannot determine link type");
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.Hyperlink
    public int getColumn() {
        return this.firstColumn;
    }

    @Override // jxl.Hyperlink
    public java.io.File getFile() {
        return this.file;
    }

    @Override // jxl.Hyperlink
    public int getLastColumn() {
        return this.lastColumn;
    }

    @Override // jxl.Hyperlink
    public int getLastRow() {
        return this.lastRow;
    }

    public String getLocation() {
        return this.location;
    }

    @Override // jxl.Hyperlink
    public Range getRange() {
        return this.range;
    }

    @Override // jxl.biff.RecordData
    public Record getRecord() {
        return super.getRecord();
    }

    @Override // jxl.Hyperlink
    public int getRow() {
        return this.firstRow;
    }

    @Override // jxl.Hyperlink
    public URL getURL() {
        return this.url;
    }

    @Override // jxl.Hyperlink
    public boolean isFile() {
        return this.linkType == fileLink;
    }

    @Override // jxl.Hyperlink
    public boolean isLocation() {
        return this.linkType == workbookLink;
    }

    @Override // jxl.Hyperlink
    public boolean isURL() {
        return this.linkType == urlLink;
    }
}
