package jxl.write;

import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.write.biff.WritableFontRecord;
/* loaded from: classes.dex */
public class WritableFont extends WritableFontRecord {
    public static final int DEFAULT_POINT_SIZE = 10;
    public static final FontName ARIAL = new FontName("Arial");
    public static final FontName TIMES = new FontName("Times New Roman");
    public static final FontName COURIER = new FontName("Courier New");
    public static final FontName TAHOMA = new FontName("Tahoma");
    public static final BoldStyle NO_BOLD = new BoldStyle(400);
    public static final BoldStyle BOLD = new BoldStyle(700);

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class BoldStyle {
        public int value;

        BoldStyle(int i) {
            this.value = i;
        }
    }

    /* loaded from: classes.dex */
    public static class FontName {
        String name;

        FontName(String str) {
            this.name = str;
        }
    }

    public WritableFont(jxl.format.Font font) {
        super(font);
    }

    public WritableFont(FontName fontName) {
        this(fontName, 10, NO_BOLD, false, UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
    }

    public WritableFont(FontName fontName, int i) {
        this(fontName, i, NO_BOLD, false, UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
    }

    public WritableFont(FontName fontName, int i, BoldStyle boldStyle) {
        this(fontName, i, boldStyle, false, UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
    }

    public WritableFont(FontName fontName, int i, BoldStyle boldStyle, boolean z) {
        this(fontName, i, boldStyle, z, UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
    }

    public WritableFont(FontName fontName, int i, BoldStyle boldStyle, boolean z, UnderlineStyle underlineStyle) {
        this(fontName, i, boldStyle, z, underlineStyle, jxl.format.Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
    }

    public WritableFont(FontName fontName, int i, BoldStyle boldStyle, boolean z, UnderlineStyle underlineStyle, jxl.format.Colour colour) {
        this(fontName, i, boldStyle, z, underlineStyle, colour, ScriptStyle.NORMAL_SCRIPT);
    }

    public WritableFont(FontName fontName, int i, BoldStyle boldStyle, boolean z, UnderlineStyle underlineStyle, jxl.format.Colour colour, ScriptStyle scriptStyle) {
        super(fontName.name, i, boldStyle.value, z, underlineStyle.getValue(), colour.getValue(), scriptStyle.getValue());
    }

    public static FontName createFont(String str) {
        return new FontName(str);
    }

    @Override // jxl.biff.FontRecord, jxl.format.Font
    public boolean isStruckout() {
        return super.isStruckout();
    }

    public void setBoldStyle(BoldStyle boldStyle) {
        super.setBoldStyle(boldStyle.value);
    }

    public void setColour(jxl.format.Colour colour) {
        super.setColour(colour.getValue());
    }

    @Override // jxl.write.biff.WritableFontRecord
    public void setItalic(boolean z) {
        super.setItalic(z);
    }

    @Override // jxl.write.biff.WritableFontRecord
    public void setPointSize(int i) {
        super.setPointSize(i);
    }

    public void setScriptStyle(ScriptStyle scriptStyle) {
        super.setScriptStyle(scriptStyle.getValue());
    }

    @Override // jxl.write.biff.WritableFontRecord
    public void setStruckout(boolean z) {
        super.setStruckout(z);
    }

    public void setUnderlineStyle(UnderlineStyle underlineStyle) {
        super.setUnderlineStyle(underlineStyle.getValue());
    }
}
