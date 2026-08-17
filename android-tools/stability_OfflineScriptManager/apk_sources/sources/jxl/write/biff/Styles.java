package jxl.write.biff;

import jxl.biff.XFRecord;
import jxl.common.Logger;
import jxl.write.DateFormat;
import jxl.write.DateFormats;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class Styles {
    static /* synthetic */ Class class$jxl$write$biff$Styles;
    private static Logger logger;
    private WritableCellFormat defaultDateFormat;
    private WritableFont arial10pt = null;
    private WritableFont hyperlinkFont = null;
    private WritableCellFormat normalStyle = null;
    private WritableCellFormat hyperlinkStyle = null;
    private WritableCellFormat hiddenStyle = null;

    static {
        Class cls = class$jxl$write$biff$Styles;
        if (cls == null) {
            cls = class$("jxl.write.biff.Styles");
            class$jxl$write$biff$Styles = cls;
        }
        logger = Logger.getLogger(cls);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private synchronized void initArial10Pt() {
        this.arial10pt = new WritableFont(WritableWorkbook.ARIAL_10_PT);
    }

    private synchronized void initDefaultDateFormat() {
        this.defaultDateFormat = new WritableCellFormat(DateFormats.DEFAULT);
    }

    private synchronized void initHiddenStyle() {
        this.hiddenStyle = new WritableCellFormat(getArial10Pt(), new DateFormat(";;;"));
    }

    private synchronized void initHyperlinkFont() {
        this.hyperlinkFont = new WritableFont(WritableWorkbook.HYPERLINK_FONT);
    }

    private synchronized void initHyperlinkStyle() {
        this.hyperlinkStyle = new WritableCellFormat(getHyperlinkFont(), NumberFormats.DEFAULT);
    }

    private synchronized void initNormalStyle() {
        WritableCellFormat writableCellFormat = new WritableCellFormat(getArial10Pt(), NumberFormats.DEFAULT);
        this.normalStyle = writableCellFormat;
        writableCellFormat.setFont(getArial10Pt());
    }

    public WritableFont getArial10Pt() {
        if (this.arial10pt == null) {
            initArial10Pt();
        }
        return this.arial10pt;
    }

    public WritableCellFormat getDefaultDateFormat() {
        if (this.defaultDateFormat == null) {
            initDefaultDateFormat();
        }
        return this.defaultDateFormat;
    }

    public XFRecord getFormat(XFRecord xFRecord) {
        WritableFont hyperlinkFont;
        if (xFRecord == WritableWorkbook.NORMAL_STYLE) {
            xFRecord = getNormalStyle();
        } else if (xFRecord == WritableWorkbook.HYPERLINK_STYLE) {
            xFRecord = getHyperlinkStyle();
        } else if (xFRecord == WritableWorkbook.HIDDEN_STYLE) {
            xFRecord = getHiddenStyle();
        } else if (xFRecord == DateRecord.defaultDateFormat) {
            xFRecord = getDefaultDateFormat();
        }
        if (xFRecord.getFont() != WritableWorkbook.ARIAL_10_PT) {
            if (xFRecord.getFont() == WritableWorkbook.HYPERLINK_FONT) {
                hyperlinkFont = getHyperlinkFont();
            }
            return xFRecord;
        }
        hyperlinkFont = getArial10Pt();
        xFRecord.setFont(hyperlinkFont);
        return xFRecord;
    }

    public WritableCellFormat getHiddenStyle() {
        if (this.hiddenStyle == null) {
            initHiddenStyle();
        }
        return this.hiddenStyle;
    }

    public WritableFont getHyperlinkFont() {
        if (this.hyperlinkFont == null) {
            initHyperlinkFont();
        }
        return this.hyperlinkFont;
    }

    public WritableCellFormat getHyperlinkStyle() {
        if (this.hyperlinkStyle == null) {
            initHyperlinkStyle();
        }
        return this.hyperlinkStyle;
    }

    public WritableCellFormat getNormalStyle() {
        if (this.normalStyle == null) {
            initNormalStyle();
        }
        return this.normalStyle;
    }
}
