package jxl.write.biff;

import jxl.SheetSettings;
import jxl.biff.DoubleHelper;
import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.common.Logger;
import jxl.format.PageOrder;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
/* loaded from: classes.dex */
class SetupRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$write$biff$SetupRecord;
    private int copies;
    private byte[] data;
    private int fitHeight;
    private int fitWidth;
    private double footerMargin;
    private double headerMargin;
    private int horizontalPrintResolution;
    private boolean initialized;
    Logger logger;
    private PageOrder order;
    private PageOrientation orientation;
    private int pageStart;
    private int paperSize;
    private int scaleFactor;
    private int verticalPrintResolution;

    public SetupRecord(SheetSettings sheetSettings) {
        super(Type.SETUP);
        Class cls = class$jxl$write$biff$SetupRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.SetupRecord");
            class$jxl$write$biff$SetupRecord = cls;
        }
        this.logger = Logger.getLogger(cls);
        this.orientation = sheetSettings.getOrientation();
        this.order = sheetSettings.getPageOrder();
        this.headerMargin = sheetSettings.getHeaderMargin();
        this.footerMargin = sheetSettings.getFooterMargin();
        this.paperSize = sheetSettings.getPaperSize().getValue();
        this.horizontalPrintResolution = sheetSettings.getHorizontalPrintResolution();
        this.verticalPrintResolution = sheetSettings.getVerticalPrintResolution();
        this.fitWidth = sheetSettings.getFitWidth();
        this.fitHeight = sheetSettings.getFitHeight();
        this.pageStart = sheetSettings.getPageStart();
        this.scaleFactor = sheetSettings.getScaleFactor();
        this.copies = sheetSettings.getCopies();
        this.initialized = true;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[34];
        this.data = bArr;
        IntegerHelper.getTwoBytes(this.paperSize, bArr, 0);
        IntegerHelper.getTwoBytes(this.scaleFactor, this.data, 2);
        IntegerHelper.getTwoBytes(this.pageStart, this.data, 4);
        IntegerHelper.getTwoBytes(this.fitWidth, this.data, 6);
        IntegerHelper.getTwoBytes(this.fitHeight, this.data, 8);
        int i = this.order == PageOrder.RIGHT_THEN_DOWN ? 1 : 0;
        if (this.orientation == PageOrientation.PORTRAIT) {
            i |= 2;
        }
        if (this.pageStart != 0) {
            i |= 128;
        }
        if (!this.initialized) {
            i |= 4;
        }
        IntegerHelper.getTwoBytes(i, this.data, 10);
        IntegerHelper.getTwoBytes(this.horizontalPrintResolution, this.data, 12);
        IntegerHelper.getTwoBytes(this.verticalPrintResolution, this.data, 14);
        DoubleHelper.getIEEEBytes(this.headerMargin, this.data, 16);
        DoubleHelper.getIEEEBytes(this.footerMargin, this.data, 24);
        IntegerHelper.getTwoBytes(this.copies, this.data, 32);
        return this.data;
    }

    public void setMargins(double d2, double d3) {
        this.headerMargin = d2;
        this.footerMargin = d3;
    }

    public void setOrder(PageOrder pageOrder) {
        this.order = pageOrder;
    }

    public void setOrientation(PageOrientation pageOrientation) {
        this.orientation = pageOrientation;
    }

    public void setPaperSize(PaperSize paperSize) {
        this.paperSize = paperSize.getValue();
    }
}
