package jxl.biff;

import jxl.WorkbookSettings;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.Colour;
import jxl.format.Font;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class FontRecord extends WritableRecordData implements Font {
    private static final int EXCEL_UNITS_PER_POINT = 20;
    public static final Biff7 biff7;
    static /* synthetic */ Class class$jxl$biff$FontRecord;
    private static Logger logger;
    private int boldWeight;
    private byte characterSet;
    private int colourIndex;
    private byte fontFamily;
    private int fontIndex;
    private boolean initialized;
    private boolean italic;
    private String name;
    private int pointHeight;
    private int scriptStyle;
    private boolean struckout;
    private int underlineStyle;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class Biff7 {
        private Biff7() {
        }
    }

    static {
        Class cls = class$jxl$biff$FontRecord;
        if (cls == null) {
            cls = class$("jxl.biff.FontRecord");
            class$jxl$biff$FontRecord = cls;
        }
        logger = Logger.getLogger(cls);
        biff7 = new Biff7();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public FontRecord(String str, int i, int i2, boolean z, int i3, int i4, int i5) {
        super(Type.FONT);
        this.boldWeight = i2;
        this.underlineStyle = i3;
        this.name = str;
        this.pointHeight = i;
        this.italic = z;
        this.scriptStyle = i5;
        this.colourIndex = i4;
        this.initialized = false;
        this.struckout = false;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public FontRecord(Font font) {
        super(Type.FONT);
        Assert.verify(font != null);
        this.pointHeight = font.getPointSize();
        this.colourIndex = font.getColour().getValue();
        this.boldWeight = font.getBoldWeight();
        this.scriptStyle = font.getScriptStyle().getValue();
        this.underlineStyle = font.getUnderlineStyle().getValue();
        this.italic = font.isItalic();
        this.name = font.getName();
        this.struckout = font.isStruckout();
        this.initialized = false;
    }

    public FontRecord(Record record, WorkbookSettings workbookSettings) {
        super(record);
        byte[] data = getRecord().getData();
        this.pointHeight = IntegerHelper.getInt(data[0], data[1]) / 20;
        this.colourIndex = IntegerHelper.getInt(data[4], data[5]);
        this.boldWeight = IntegerHelper.getInt(data[6], data[7]);
        this.scriptStyle = IntegerHelper.getInt(data[8], data[9]);
        this.underlineStyle = data[10];
        this.fontFamily = data[11];
        this.characterSet = data[12];
        this.initialized = false;
        if ((data[2] & 2) != 0) {
            this.italic = true;
        }
        if ((data[2] & 8) != 0) {
            this.struckout = true;
        }
        byte b2 = data[14];
        this.name = data[15] == 0 ? StringHelper.getString(data, b2, 16, workbookSettings) : data[15] == 1 ? StringHelper.getUnicodeString(data, b2, 16) : StringHelper.getString(data, b2, 15, workbookSettings);
    }

    public FontRecord(Record record, WorkbookSettings workbookSettings, Biff7 biff72) {
        super(record);
        byte[] data = getRecord().getData();
        this.pointHeight = IntegerHelper.getInt(data[0], data[1]) / 20;
        this.colourIndex = IntegerHelper.getInt(data[4], data[5]);
        this.boldWeight = IntegerHelper.getInt(data[6], data[7]);
        this.scriptStyle = IntegerHelper.getInt(data[8], data[9]);
        this.underlineStyle = data[10];
        this.fontFamily = data[11];
        this.initialized = false;
        if ((data[2] & 2) != 0) {
            this.italic = true;
        }
        if ((data[2] & 8) != 0) {
            this.struckout = true;
        }
        this.name = StringHelper.getString(data, data[14], 15, workbookSettings);
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
        if (obj instanceof FontRecord) {
            FontRecord fontRecord = (FontRecord) obj;
            return this.pointHeight == fontRecord.pointHeight && this.colourIndex == fontRecord.colourIndex && this.boldWeight == fontRecord.boldWeight && this.scriptStyle == fontRecord.scriptStyle && this.underlineStyle == fontRecord.underlineStyle && this.italic == fontRecord.italic && this.struckout == fontRecord.struckout && this.fontFamily == fontRecord.fontFamily && this.characterSet == fontRecord.characterSet && this.name.equals(fontRecord.name);
        }
        return false;
    }

    @Override // jxl.format.Font
    public int getBoldWeight() {
        return this.boldWeight;
    }

    @Override // jxl.format.Font
    public Colour getColour() {
        return Colour.getInternalColour(this.colourIndex);
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[(this.name.length() * 2) + 16];
        IntegerHelper.getTwoBytes(this.pointHeight * 20, bArr, 0);
        if (this.italic) {
            bArr[2] = (byte) (bArr[2] | 2);
        }
        if (this.struckout) {
            bArr[2] = (byte) (bArr[2] | 8);
        }
        IntegerHelper.getTwoBytes(this.colourIndex, bArr, 4);
        IntegerHelper.getTwoBytes(this.boldWeight, bArr, 6);
        IntegerHelper.getTwoBytes(this.scriptStyle, bArr, 8);
        bArr[10] = (byte) this.underlineStyle;
        bArr[11] = this.fontFamily;
        bArr[12] = this.characterSet;
        bArr[13] = 0;
        bArr[14] = (byte) this.name.length();
        bArr[15] = 1;
        StringHelper.getUnicodeBytes(this.name, bArr, 16);
        return bArr;
    }

    public final int getFontIndex() {
        return this.fontIndex;
    }

    @Override // jxl.format.Font
    public String getName() {
        return this.name;
    }

    @Override // jxl.format.Font
    public int getPointSize() {
        return this.pointHeight;
    }

    @Override // jxl.format.Font
    public ScriptStyle getScriptStyle() {
        return ScriptStyle.getStyle(this.scriptStyle);
    }

    @Override // jxl.format.Font
    public UnderlineStyle getUnderlineStyle() {
        return UnderlineStyle.getStyle(this.underlineStyle);
    }

    public int hashCode() {
        return this.name.hashCode();
    }

    public final void initialize(int i) {
        this.fontIndex = i;
        this.initialized = true;
    }

    public final boolean isInitialized() {
        return this.initialized;
    }

    @Override // jxl.format.Font
    public boolean isItalic() {
        return this.italic;
    }

    @Override // jxl.format.Font
    public boolean isStruckout() {
        return this.struckout;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontBoldStyle(int i) {
        Assert.verify(!this.initialized);
        this.boldWeight = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontColour(int i) {
        Assert.verify(!this.initialized);
        this.colourIndex = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontItalic(boolean z) {
        Assert.verify(!this.initialized);
        this.italic = z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontPointSize(int i) {
        Assert.verify(!this.initialized);
        this.pointHeight = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontScriptStyle(int i) {
        Assert.verify(!this.initialized);
        this.scriptStyle = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontStruckout(boolean z) {
        this.struckout = z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setFontUnderlineStyle(int i) {
        Assert.verify(!this.initialized);
        this.underlineStyle = i;
    }

    public final void uninitialize() {
        this.initialized = false;
    }
}
