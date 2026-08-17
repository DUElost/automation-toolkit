package jxl.biff;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import jxl.WorkbookSettings;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.CellFormat;
import jxl.format.Colour;
import jxl.format.Font;
import jxl.format.Format;
import jxl.format.Orientation;
import jxl.format.Pattern;
import jxl.format.VerticalAlignment;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class XFRecord extends WritableRecordData implements CellFormat {
    private static final int USE_ALIGNMENT = 16;
    private static final int USE_BACKGROUND = 64;
    private static final int USE_BORDER = 32;
    private static final int USE_DEFAULT_VALUE = 248;
    private static final int USE_FONT = 4;
    private static final int USE_FORMAT = 8;
    private static final int USE_PROTECTION = 128;
    public static final BiffType biff7;
    public static final BiffType biff8;
    protected static final XFType cell;
    static /* synthetic */ Class class$jxl$biff$XFRecord;
    private static final int[] dateFormats;
    private static final DateFormat[] javaDateFormats;
    private static NumberFormat[] javaNumberFormats;
    private static Logger logger;
    private static int[] numberFormats;
    protected static final XFType style;
    private Alignment align;
    private Colour backgroundColour;
    private BiffType biffType;
    private BorderLineStyle bottomBorder;
    private Colour bottomBorderColour;
    private boolean copied;
    private boolean date;
    private DateFormat dateFormat;
    private Format excelFormat;
    private FontRecord font;
    private int fontIndex;
    private DisplayFormat format;
    public int formatIndex;
    private boolean formatInfoInitialized;
    private FormattingRecords formattingRecords;
    private boolean hidden;
    private int indentation;
    private boolean initialized;
    private BorderLineStyle leftBorder;
    private Colour leftBorderColour;
    private boolean locked;
    private boolean number;
    private NumberFormat numberFormat;
    private int options;
    private Orientation orientation;
    private int parentFormat;
    private Pattern pattern;
    private boolean read;
    private BorderLineStyle rightBorder;
    private Colour rightBorderColour;
    private boolean shrinkToFit;
    private BorderLineStyle topBorder;
    private Colour topBorderColour;
    private byte usedAttributes;
    private VerticalAlignment valign;
    private boolean wrap;
    private XFType xfFormatType;
    private int xfIndex;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class BiffType {
        private BiffType() {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class XFType {
        private XFType() {
        }
    }

    static {
        Class cls = class$jxl$biff$XFRecord;
        if (cls == null) {
            cls = class$("jxl.biff.XFRecord");
            class$jxl$biff$XFRecord = cls;
        }
        logger = Logger.getLogger(cls);
        dateFormats = new int[]{14, 15, 16, 17, 18, 19, 20, 21, 22, 45, 46, 47};
        javaDateFormats = new DateFormat[]{SimpleDateFormat.getDateInstance(3), SimpleDateFormat.getDateInstance(2), new SimpleDateFormat("d-MMM"), new SimpleDateFormat("MMM-yy"), new SimpleDateFormat("h:mm a"), new SimpleDateFormat("h:mm:ss a"), new SimpleDateFormat("H:mm"), new SimpleDateFormat("H:mm:ss"), new SimpleDateFormat("M/d/yy H:mm"), new SimpleDateFormat("mm:ss"), new SimpleDateFormat("H:mm:ss"), new SimpleDateFormat("mm:ss.S")};
        numberFormats = new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 37, 38, 39, 40, 41, 42, 43, 44, 48};
        javaNumberFormats = new NumberFormat[]{new DecimalFormat("0"), new DecimalFormat("0.00"), new DecimalFormat("#,##0"), new DecimalFormat("#,##0.00"), new DecimalFormat("$#,##0;($#,##0)"), new DecimalFormat("$#,##0;($#,##0)"), new DecimalFormat("$#,##0.00;($#,##0.00)"), new DecimalFormat("$#,##0.00;($#,##0.00)"), new DecimalFormat("0%"), new DecimalFormat("0.00%"), new DecimalFormat("0.00E00"), new DecimalFormat("#,##0;(#,##0)"), new DecimalFormat("#,##0;(#,##0)"), new DecimalFormat("#,##0.00;(#,##0.00)"), new DecimalFormat("#,##0.00;(#,##0.00)"), new DecimalFormat("#,##0;(#,##0)"), new DecimalFormat("$#,##0;($#,##0)"), new DecimalFormat("#,##0.00;(#,##0.00)"), new DecimalFormat("$#,##0.00;($#,##0.00)"), new DecimalFormat("##0.0E0")};
        biff8 = new BiffType();
        biff7 = new BiffType();
        cell = new XFType();
        style = new XFType();
    }

    public XFRecord(FontRecord fontRecord, DisplayFormat displayFormat) {
        super(Type.XF);
        this.initialized = false;
        this.locked = true;
        this.hidden = false;
        this.align = Alignment.GENERAL;
        this.valign = VerticalAlignment.BOTTOM;
        this.orientation = Orientation.HORIZONTAL;
        this.wrap = false;
        BorderLineStyle borderLineStyle = BorderLineStyle.NONE;
        this.leftBorder = borderLineStyle;
        this.rightBorder = borderLineStyle;
        this.topBorder = borderLineStyle;
        this.bottomBorder = borderLineStyle;
        Colour colour = Colour.AUTOMATIC;
        this.leftBorderColour = colour;
        this.rightBorderColour = colour;
        this.topBorderColour = colour;
        this.bottomBorderColour = colour;
        this.pattern = Pattern.NONE;
        this.backgroundColour = Colour.DEFAULT_BACKGROUND;
        this.indentation = 0;
        this.shrinkToFit = false;
        this.usedAttributes = (byte) 124;
        this.parentFormat = 0;
        this.xfFormatType = null;
        this.font = fontRecord;
        this.format = displayFormat;
        this.biffType = biff8;
        this.read = false;
        this.copied = false;
        this.formatInfoInitialized = true;
        Assert.verify(fontRecord != null);
        Assert.verify(this.format != null);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public XFRecord(XFRecord xFRecord) {
        super(Type.XF);
        this.initialized = false;
        this.locked = xFRecord.locked;
        this.hidden = xFRecord.hidden;
        this.align = xFRecord.align;
        this.valign = xFRecord.valign;
        this.orientation = xFRecord.orientation;
        this.wrap = xFRecord.wrap;
        this.leftBorder = xFRecord.leftBorder;
        this.rightBorder = xFRecord.rightBorder;
        this.topBorder = xFRecord.topBorder;
        this.bottomBorder = xFRecord.bottomBorder;
        this.leftBorderColour = xFRecord.leftBorderColour;
        this.rightBorderColour = xFRecord.rightBorderColour;
        this.topBorderColour = xFRecord.topBorderColour;
        this.bottomBorderColour = xFRecord.bottomBorderColour;
        this.pattern = xFRecord.pattern;
        this.xfFormatType = xFRecord.xfFormatType;
        this.indentation = xFRecord.indentation;
        this.shrinkToFit = xFRecord.shrinkToFit;
        this.parentFormat = xFRecord.parentFormat;
        this.backgroundColour = xFRecord.backgroundColour;
        this.font = xFRecord.font;
        this.format = xFRecord.format;
        this.fontIndex = xFRecord.fontIndex;
        this.formatIndex = xFRecord.formatIndex;
        this.formatInfoInitialized = xFRecord.formatInfoInitialized;
        this.biffType = biff8;
        this.read = false;
        this.copied = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public XFRecord(CellFormat cellFormat) {
        super(Type.XF);
        FormatRecord formatRecord;
        DisplayFormat displayFormat;
        Assert.verify(cellFormat != null);
        Assert.verify(cellFormat instanceof XFRecord);
        XFRecord xFRecord = (XFRecord) cellFormat;
        if (!xFRecord.formatInfoInitialized) {
            xFRecord.initializeFormatInformation();
        }
        this.locked = xFRecord.locked;
        this.hidden = xFRecord.hidden;
        this.align = xFRecord.align;
        this.valign = xFRecord.valign;
        this.orientation = xFRecord.orientation;
        this.wrap = xFRecord.wrap;
        this.leftBorder = xFRecord.leftBorder;
        this.rightBorder = xFRecord.rightBorder;
        this.topBorder = xFRecord.topBorder;
        this.bottomBorder = xFRecord.bottomBorder;
        this.leftBorderColour = xFRecord.leftBorderColour;
        this.rightBorderColour = xFRecord.rightBorderColour;
        this.topBorderColour = xFRecord.topBorderColour;
        this.bottomBorderColour = xFRecord.bottomBorderColour;
        this.pattern = xFRecord.pattern;
        this.xfFormatType = xFRecord.xfFormatType;
        this.parentFormat = xFRecord.parentFormat;
        this.indentation = xFRecord.indentation;
        this.shrinkToFit = xFRecord.shrinkToFit;
        this.backgroundColour = xFRecord.backgroundColour;
        this.font = new FontRecord(xFRecord.getFont());
        if (xFRecord.getFormat() == null) {
            if (xFRecord.format.isBuiltIn()) {
                displayFormat = xFRecord.format;
                this.format = displayFormat;
            } else {
                formatRecord = new FormatRecord((FormatRecord) xFRecord.format);
                this.format = formatRecord;
            }
        } else if (xFRecord.getFormat() instanceof BuiltInFormat) {
            this.excelFormat = (BuiltInFormat) xFRecord.excelFormat;
            displayFormat = (BuiltInFormat) xFRecord.excelFormat;
            this.format = displayFormat;
        } else {
            Assert.verify(xFRecord.formatInfoInitialized);
            Assert.verify(xFRecord.excelFormat instanceof FormatRecord);
            formatRecord = new FormatRecord((FormatRecord) xFRecord.excelFormat);
            this.excelFormat = formatRecord;
            this.format = formatRecord;
        }
        this.biffType = biff8;
        this.formatInfoInitialized = true;
        this.read = false;
        this.copied = false;
        this.initialized = false;
    }

    public XFRecord(Record record, WorkbookSettings workbookSettings, BiffType biffType) {
        super(record);
        this.biffType = biffType;
        byte[] data = getRecord().getData();
        this.fontIndex = IntegerHelper.getInt(data[0], data[1]);
        this.formatIndex = IntegerHelper.getInt(data[2], data[3]);
        this.date = false;
        this.number = false;
        int i = 0;
        while (true) {
            int[] iArr = dateFormats;
            if (i >= iArr.length || this.date) {
                break;
            }
            if (this.formatIndex == iArr[i]) {
                this.date = true;
                this.dateFormat = javaDateFormats[i];
            }
            i++;
        }
        int i2 = 0;
        while (true) {
            int[] iArr2 = numberFormats;
            if (i2 >= iArr2.length || this.number) {
                break;
            }
            if (this.formatIndex == iArr2[i2]) {
                this.number = true;
                DecimalFormat decimalFormat = (DecimalFormat) javaNumberFormats[i2].clone();
                decimalFormat.setDecimalFormatSymbols(new DecimalFormatSymbols(workbookSettings.getLocale()));
                this.numberFormat = decimalFormat;
            }
            i2++;
        }
        int i3 = IntegerHelper.getInt(data[4], data[5]);
        int i4 = (65520 & i3) >> 4;
        this.parentFormat = i4;
        XFType xFType = (i3 & 4) == 0 ? cell : style;
        this.xfFormatType = xFType;
        this.locked = (i3 & 1) != 0;
        this.hidden = (i3 & 2) != 0;
        if (xFType == cell && (i4 & 4095) == 4095) {
            this.parentFormat = 0;
            logger.warn("Invalid parent format found - ignoring");
        }
        this.initialized = false;
        this.read = true;
        this.formatInfoInitialized = false;
        this.copied = false;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:39:0x0158, code lost:
        if (r0 != jxl.format.Colour.DEFAULT_BACKGROUND1) goto L35;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void initializeFormatInformation() {
        /*
            Method dump skipped, instructions count: 358
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.biff.XFRecord.initializeFormatInformation():void");
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof XFRecord) {
            XFRecord xFRecord = (XFRecord) obj;
            if (!this.formatInfoInitialized) {
                initializeFormatInformation();
            }
            if (!xFRecord.formatInfoInitialized) {
                xFRecord.initializeFormatInformation();
            }
            if (this.xfFormatType == xFRecord.xfFormatType && this.parentFormat == xFRecord.parentFormat && this.locked == xFRecord.locked && this.hidden == xFRecord.hidden && this.usedAttributes == xFRecord.usedAttributes && this.align == xFRecord.align && this.valign == xFRecord.valign && this.orientation == xFRecord.orientation && this.wrap == xFRecord.wrap && this.shrinkToFit == xFRecord.shrinkToFit && this.indentation == xFRecord.indentation && this.leftBorder == xFRecord.leftBorder && this.rightBorder == xFRecord.rightBorder && this.topBorder == xFRecord.topBorder && this.bottomBorder == xFRecord.bottomBorder && this.leftBorderColour == xFRecord.leftBorderColour && this.rightBorderColour == xFRecord.rightBorderColour && this.topBorderColour == xFRecord.topBorderColour && this.bottomBorderColour == xFRecord.bottomBorderColour && this.backgroundColour == xFRecord.backgroundColour && this.pattern == xFRecord.pattern) {
                if (this.initialized && xFRecord.initialized) {
                    if (this.fontIndex != xFRecord.fontIndex || this.formatIndex != xFRecord.formatIndex) {
                        return false;
                    }
                } else if (!this.font.equals(xFRecord.font) || !this.format.equals(xFRecord.format)) {
                }
                return true;
            }
            return false;
        }
        return false;
    }

    @Override // jxl.format.CellFormat
    public Alignment getAlignment() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.align;
    }

    @Override // jxl.format.CellFormat
    public Colour getBackgroundColour() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.backgroundColour;
    }

    @Override // jxl.format.CellFormat
    public BorderLineStyle getBorder(Border border) {
        return getBorderLine(border);
    }

    @Override // jxl.format.CellFormat
    public Colour getBorderColour(Border border) {
        if (border == Border.NONE || border == Border.ALL) {
            return Colour.PALETTE_BLACK;
        }
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return border == Border.LEFT ? this.leftBorderColour : border == Border.RIGHT ? this.rightBorderColour : border == Border.TOP ? this.topBorderColour : border == Border.BOTTOM ? this.bottomBorderColour : Colour.BLACK;
    }

    @Override // jxl.format.CellFormat
    public BorderLineStyle getBorderLine(Border border) {
        if (border == Border.NONE || border == Border.ALL) {
            return BorderLineStyle.NONE;
        }
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return border == Border.LEFT ? this.leftBorder : border == Border.RIGHT ? this.rightBorder : border == Border.TOP ? this.topBorder : border == Border.BOTTOM ? this.bottomBorder : BorderLineStyle.NONE;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        byte[] bArr = new byte[20];
        IntegerHelper.getTwoBytes(this.fontIndex, bArr, 0);
        IntegerHelper.getTwoBytes(this.formatIndex, bArr, 2);
        int i = getLocked() ? 1 : 0;
        if (getHidden()) {
            i |= 2;
        }
        if (this.xfFormatType == style) {
            i |= 4;
            this.parentFormat = 65535;
        }
        IntegerHelper.getTwoBytes((this.parentFormat << 4) | i, bArr, 4);
        int value = this.align.getValue();
        if (this.wrap) {
            value |= 8;
        }
        IntegerHelper.getTwoBytes(value | (this.valign.getValue() << 4) | (this.orientation.getValue() << 8), bArr, 6);
        bArr[9] = 16;
        int value2 = (this.rightBorder.getValue() << 4) | this.leftBorder.getValue() | (this.topBorder.getValue() << 8) | (this.bottomBorder.getValue() << 12);
        IntegerHelper.getTwoBytes(value2, bArr, 10);
        if (value2 != 0) {
            IntegerHelper.getTwoBytes((((byte) this.leftBorderColour.getValue()) & Byte.MAX_VALUE) | ((((byte) this.rightBorderColour.getValue()) & Byte.MAX_VALUE) << 7), bArr, 12);
            IntegerHelper.getTwoBytes((((byte) this.topBorderColour.getValue()) & Byte.MAX_VALUE) | ((((byte) this.bottomBorderColour.getValue()) & Byte.MAX_VALUE) << 7), bArr, 14);
        }
        IntegerHelper.getTwoBytes(this.pattern.getValue() << 10, bArr, 16);
        IntegerHelper.getTwoBytes(this.backgroundColour.getValue() | 8192, bArr, 18);
        int i2 = this.options | (this.indentation & 15);
        this.options = i2;
        this.options = this.shrinkToFit ? 16 | i2 : i2 & 239;
        bArr[8] = (byte) this.options;
        if (this.biffType == biff8) {
            bArr[9] = this.usedAttributes;
        }
        return bArr;
    }

    public DateFormat getDateFormat() {
        return this.dateFormat;
    }

    @Override // jxl.format.CellFormat
    public Font getFont() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.font;
    }

    public int getFontIndex() {
        return this.fontIndex;
    }

    @Override // jxl.format.CellFormat
    public Format getFormat() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.excelFormat;
    }

    public int getFormatRecord() {
        return this.formatIndex;
    }

    protected final boolean getHidden() {
        return this.hidden;
    }

    @Override // jxl.format.CellFormat
    public int getIndentation() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.indentation;
    }

    protected final boolean getLocked() {
        return this.locked;
    }

    public NumberFormat getNumberFormat() {
        return this.numberFormat;
    }

    @Override // jxl.format.CellFormat
    public Orientation getOrientation() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.orientation;
    }

    @Override // jxl.format.CellFormat
    public Pattern getPattern() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.pattern;
    }

    @Override // jxl.format.CellFormat
    public VerticalAlignment getVerticalAlignment() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.valign;
    }

    @Override // jxl.format.CellFormat
    public boolean getWrap() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.wrap;
    }

    public final int getXFIndex() {
        return this.xfIndex;
    }

    @Override // jxl.format.CellFormat
    public final boolean hasBorders() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        BorderLineStyle borderLineStyle = this.leftBorder;
        BorderLineStyle borderLineStyle2 = BorderLineStyle.NONE;
        return (borderLineStyle == borderLineStyle2 && this.rightBorder == borderLineStyle2 && this.topBorder == borderLineStyle2 && this.bottomBorder == borderLineStyle2) ? false : true;
    }

    public int hashCode() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        int i = ((((((629 + (this.hidden ? 1 : 0)) * 37) + (this.locked ? 1 : 0)) * 37) + (this.wrap ? 1 : 0)) * 37) + (this.shrinkToFit ? 1 : 0);
        XFType xFType = this.xfFormatType;
        if (xFType == cell) {
            i = (i * 37) + 1;
        } else if (xFType == style) {
            i = (i * 37) + 2;
        }
        return (37 * ((((((((((((((((((((((((((((((i * 37) + (this.align.getValue() + 1)) * 37) + (this.valign.getValue() + 1)) * 37) + this.orientation.getValue()) ^ this.leftBorder.getDescription().hashCode()) ^ this.rightBorder.getDescription().hashCode()) ^ this.topBorder.getDescription().hashCode()) ^ this.bottomBorder.getDescription().hashCode()) * 37) + this.leftBorderColour.getValue()) * 37) + this.rightBorderColour.getValue()) * 37) + this.topBorderColour.getValue()) * 37) + this.bottomBorderColour.getValue()) * 37) + this.backgroundColour.getValue()) * 37) + this.pattern.getValue() + 1) * 37) + this.usedAttributes) * 37) + this.parentFormat) * 37) + this.fontIndex) * 37) + this.formatIndex)) + this.indentation;
    }

    public final void initialize(int i, FormattingRecords formattingRecords, Fonts fonts) {
        this.xfIndex = i;
        this.formattingRecords = formattingRecords;
        if (this.read || this.copied) {
            this.initialized = true;
            return;
        }
        if (!this.font.isInitialized()) {
            fonts.addFont(this.font);
        }
        if (!this.format.isInitialized()) {
            formattingRecords.addFormat(this.format);
        }
        this.fontIndex = this.font.getFontIndex();
        this.formatIndex = this.format.getFormatIndex();
        this.initialized = true;
    }

    public boolean isDate() {
        return this.date;
    }

    public final boolean isInitialized() {
        return this.initialized;
    }

    @Override // jxl.format.CellFormat
    public boolean isLocked() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.locked;
    }

    public boolean isNumber() {
        return this.number;
    }

    public final boolean isRead() {
        return this.read;
    }

    @Override // jxl.format.CellFormat
    public boolean isShrinkToFit() {
        if (!this.formatInfoInitialized) {
            initializeFormatInformation();
        }
        return this.shrinkToFit;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rationalize(IndexMapping indexMapping) {
        this.xfIndex = indexMapping.getNewIndex(this.xfIndex);
        if (this.xfFormatType == cell) {
            this.parentFormat = indexMapping.getNewIndex(this.parentFormat);
        }
    }

    public void setFont(FontRecord fontRecord) {
        this.font = fontRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setFontIndex(int i) {
        this.fontIndex = i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setFormatIndex(int i) {
        this.formatIndex = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFAlignment(Alignment alignment) {
        Assert.verify(!this.initialized);
        this.align = alignment;
        this.usedAttributes = (byte) (this.usedAttributes | 16);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFBackground(Colour colour, Pattern pattern) {
        Assert.verify(!this.initialized);
        this.backgroundColour = colour;
        this.pattern = pattern;
        this.usedAttributes = (byte) (this.usedAttributes | 64);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFBorder(Border border, BorderLineStyle borderLineStyle, Colour colour) {
        Assert.verify(!this.initialized);
        if (colour == Colour.BLACK || colour == Colour.UNKNOWN) {
            colour = Colour.PALETTE_BLACK;
        }
        if (border == Border.LEFT) {
            this.leftBorder = borderLineStyle;
            this.leftBorderColour = colour;
        } else if (border == Border.RIGHT) {
            this.rightBorder = borderLineStyle;
            this.rightBorderColour = colour;
        } else if (border == Border.TOP) {
            this.topBorder = borderLineStyle;
            this.topBorderColour = colour;
        } else if (border == Border.BOTTOM) {
            this.bottomBorder = borderLineStyle;
            this.bottomBorderColour = colour;
        }
        this.usedAttributes = (byte) (this.usedAttributes | 32);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setXFCellOptions(int i) {
        this.options = i | this.options;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFDetails(XFType xFType, int i) {
        this.xfFormatType = xFType;
        this.parentFormat = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFIndentation(int i) {
        Assert.verify(!this.initialized);
        this.indentation = i;
        this.usedAttributes = (byte) (this.usedAttributes | 16);
    }

    final void setXFIndex(int i) {
        this.xfIndex = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setXFLocked(boolean z) {
        this.locked = z;
        this.usedAttributes = (byte) (this.usedAttributes | 128);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFOrientation(Orientation orientation) {
        Assert.verify(!this.initialized);
        this.orientation = orientation;
        this.usedAttributes = (byte) (this.usedAttributes | 16);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFShrinkToFit(boolean z) {
        Assert.verify(!this.initialized);
        this.shrinkToFit = z;
        this.usedAttributes = (byte) (this.usedAttributes | 16);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFVerticalAlignment(VerticalAlignment verticalAlignment) {
        Assert.verify(!this.initialized);
        this.valign = verticalAlignment;
        this.usedAttributes = (byte) (this.usedAttributes | 16);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setXFWrap(boolean z) {
        Assert.verify(!this.initialized);
        this.wrap = z;
        this.usedAttributes = (byte) (this.usedAttributes | 16);
    }

    public final void uninitialize() {
        if (this.initialized) {
            logger.warn("A default format has been initialized");
        }
        this.initialized = false;
    }
}
