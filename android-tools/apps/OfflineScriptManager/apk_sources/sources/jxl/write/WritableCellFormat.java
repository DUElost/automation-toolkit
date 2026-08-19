package jxl.write;

import jxl.biff.DisplayFormat;
import jxl.format.CellFormat;
import jxl.format.Orientation;
import jxl.write.biff.CellXFRecord;
/* loaded from: classes.dex */
public class WritableCellFormat extends CellXFRecord {
    public WritableCellFormat() {
        this(WritableWorkbook.ARIAL_10_PT, NumberFormats.DEFAULT);
    }

    public WritableCellFormat(DisplayFormat displayFormat) {
        this(WritableWorkbook.ARIAL_10_PT, displayFormat);
    }

    public WritableCellFormat(CellFormat cellFormat) {
        super(cellFormat);
    }

    public WritableCellFormat(WritableFont writableFont) {
        this(writableFont, NumberFormats.DEFAULT);
    }

    public WritableCellFormat(WritableFont writableFont, DisplayFormat displayFormat) {
        super(writableFont, displayFormat);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setAlignment(jxl.format.Alignment alignment) {
        super.setAlignment(alignment);
    }

    public void setBackground(jxl.format.Colour colour) {
        setBackground(colour, jxl.format.Pattern.SOLID);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setBackground(jxl.format.Colour colour, jxl.format.Pattern pattern) {
        super.setBackground(colour, pattern);
    }

    public void setBorder(jxl.format.Border border, jxl.format.BorderLineStyle borderLineStyle) {
        super.setBorder(border, borderLineStyle, jxl.format.Colour.BLACK);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setBorder(jxl.format.Border border, jxl.format.BorderLineStyle borderLineStyle, jxl.format.Colour colour) {
        super.setBorder(border, borderLineStyle, colour);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setIndentation(int i) {
        super.setIndentation(i);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setLocked(boolean z) {
        super.setLocked(z);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setOrientation(Orientation orientation) {
        super.setOrientation(orientation);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setShrinkToFit(boolean z) {
        super.setShrinkToFit(z);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setVerticalAlignment(jxl.format.VerticalAlignment verticalAlignment) {
        super.setVerticalAlignment(verticalAlignment);
    }

    @Override // jxl.write.biff.CellXFRecord
    public void setWrap(boolean z) {
        super.setWrap(z);
    }
}
