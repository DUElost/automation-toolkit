package jxl.read.biff;

import jxl.biff.DoubleHelper;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.Type;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class SetupRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$SetupRecord;
    private static Logger logger;
    private int copies;
    private byte[] data;
    private int fitHeight;
    private int fitWidth;
    private double footerMargin;
    private double headerMargin;
    private int horizontalPrintResolution;
    private boolean initialized;
    private boolean pageOrder;
    private int pageStart;
    private int paperSize;
    private boolean portraitOrientation;
    private int scaleFactor;
    private int verticalPrintResolution;

    static {
        Class cls = class$jxl$read$biff$SetupRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.SetupRecord");
            class$jxl$read$biff$SetupRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public SetupRecord(Record record) {
        super(Type.SETUP);
        byte[] data = record.getData();
        this.data = data;
        this.paperSize = IntegerHelper.getInt(data[0], data[1]);
        byte[] bArr = this.data;
        this.scaleFactor = IntegerHelper.getInt(bArr[2], bArr[3]);
        byte[] bArr2 = this.data;
        this.pageStart = IntegerHelper.getInt(bArr2[4], bArr2[5]);
        byte[] bArr3 = this.data;
        this.fitWidth = IntegerHelper.getInt(bArr3[6], bArr3[7]);
        byte[] bArr4 = this.data;
        this.fitHeight = IntegerHelper.getInt(bArr4[8], bArr4[9]);
        byte[] bArr5 = this.data;
        this.horizontalPrintResolution = IntegerHelper.getInt(bArr5[12], bArr5[13]);
        byte[] bArr6 = this.data;
        this.verticalPrintResolution = IntegerHelper.getInt(bArr6[14], bArr6[15]);
        byte[] bArr7 = this.data;
        this.copies = IntegerHelper.getInt(bArr7[32], bArr7[33]);
        this.headerMargin = DoubleHelper.getIEEEDouble(this.data, 16);
        this.footerMargin = DoubleHelper.getIEEEDouble(this.data, 24);
        byte[] bArr8 = this.data;
        int i = IntegerHelper.getInt(bArr8[10], bArr8[11]);
        this.pageOrder = (i & 1) != 0;
        this.portraitOrientation = (i & 2) != 0;
        this.initialized = (i & 4) == 0;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public int getCopies() {
        return this.copies;
    }

    public int getFitHeight() {
        return this.fitHeight;
    }

    public int getFitWidth() {
        return this.fitWidth;
    }

    public double getFooterMargin() {
        return this.footerMargin;
    }

    public double getHeaderMargin() {
        return this.headerMargin;
    }

    public int getHorizontalPrintResolution() {
        return this.horizontalPrintResolution;
    }

    public boolean getInitialized() {
        return this.initialized;
    }

    public int getPageStart() {
        return this.pageStart;
    }

    public int getPaperSize() {
        return this.paperSize;
    }

    public int getScaleFactor() {
        return this.scaleFactor;
    }

    public int getVerticalPrintResolution() {
        return this.verticalPrintResolution;
    }

    public boolean isPortrait() {
        return this.portraitOrientation;
    }

    public boolean isRightDown() {
        return this.pageOrder;
    }
}
