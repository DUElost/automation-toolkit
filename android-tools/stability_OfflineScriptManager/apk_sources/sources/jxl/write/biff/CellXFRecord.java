package jxl.write.biff;

import jxl.biff.DisplayFormat;
import jxl.biff.FontRecord;
import jxl.biff.XFRecord;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.CellFormat;
import jxl.format.Colour;
import jxl.format.Orientation;
import jxl.format.Pattern;
import jxl.format.VerticalAlignment;
/* loaded from: classes.dex */
public class CellXFRecord extends XFRecord {
    /* JADX INFO: Access modifiers changed from: protected */
    public CellXFRecord(FontRecord fontRecord, DisplayFormat displayFormat) {
        super(fontRecord, displayFormat);
        setXFDetails(XFRecord.cell, 0);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public CellXFRecord(XFRecord xFRecord) {
        super(xFRecord);
        setXFDetails(XFRecord.cell, 0);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public CellXFRecord(CellFormat cellFormat) {
        super(cellFormat);
    }

    public void setAlignment(Alignment alignment) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFAlignment(alignment);
    }

    public void setBackground(Colour colour, Pattern pattern) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFBackground(colour, pattern);
        super.setXFCellOptions(16384);
    }

    public void setBorder(Border border, BorderLineStyle borderLineStyle, Colour colour) {
        Border border2;
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        if (border == Border.ALL) {
            border2 = Border.LEFT;
        } else if (border != Border.NONE) {
            super.setXFBorder(border, borderLineStyle, colour);
            return;
        } else {
            border2 = Border.LEFT;
            borderLineStyle = BorderLineStyle.NONE;
            colour = Colour.BLACK;
        }
        super.setXFBorder(border2, borderLineStyle, colour);
        super.setXFBorder(Border.RIGHT, borderLineStyle, colour);
        super.setXFBorder(Border.TOP, borderLineStyle, colour);
        super.setXFBorder(Border.BOTTOM, borderLineStyle, colour);
    }

    public void setIndentation(int i) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFIndentation(i);
    }

    public void setLocked(boolean z) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFLocked(z);
        super.setXFCellOptions(32768);
    }

    public void setOrientation(Orientation orientation) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFOrientation(orientation);
    }

    public void setShrinkToFit(boolean z) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFShrinkToFit(z);
    }

    public void setVerticalAlignment(VerticalAlignment verticalAlignment) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFVerticalAlignment(verticalAlignment);
    }

    public void setWrap(boolean z) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setXFWrap(z);
    }
}
