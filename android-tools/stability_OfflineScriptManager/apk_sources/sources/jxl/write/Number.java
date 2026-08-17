package jxl.write;

import jxl.NumberCell;
import jxl.format.CellFormat;
import jxl.write.biff.NumberRecord;
/* loaded from: classes.dex */
public class Number extends NumberRecord implements WritableCell, NumberCell {
    public Number(int i, int i2, double d2) {
        super(i, i2, d2);
    }

    public Number(int i, int i2, double d2, CellFormat cellFormat) {
        super(i, i2, d2, cellFormat);
    }

    protected Number(int i, int i2, Number number) {
        super(i, i2, number);
    }

    public Number(NumberCell numberCell) {
        super(numberCell);
    }

    @Override // jxl.write.WritableCell
    public WritableCell copyTo(int i, int i2) {
        return new Number(i, i2, this);
    }

    @Override // jxl.write.biff.NumberRecord
    public void setValue(double d2) {
        super.setValue(d2);
    }
}
