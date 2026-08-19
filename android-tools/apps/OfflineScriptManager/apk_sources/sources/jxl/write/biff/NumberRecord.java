package jxl.write.biff;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import jxl.CellType;
import jxl.NumberCell;
import jxl.biff.DoubleHelper;
import jxl.biff.Type;
import jxl.biff.XFRecord;
import jxl.format.CellFormat;
/* loaded from: classes.dex */
public abstract class NumberRecord extends CellValue {
    private static DecimalFormat defaultFormat = new DecimalFormat("#.###");
    private NumberFormat format;
    private double value;

    /* JADX INFO: Access modifiers changed from: protected */
    public NumberRecord(int i, int i2, double d2) {
        super(Type.NUMBER, i, i2);
        this.value = d2;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public NumberRecord(int i, int i2, double d2, CellFormat cellFormat) {
        super(Type.NUMBER, i, i2, cellFormat);
        this.value = d2;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public NumberRecord(int i, int i2, NumberRecord numberRecord) {
        super(Type.NUMBER, i, i2, numberRecord);
        this.value = numberRecord.value;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public NumberRecord(NumberCell numberCell) {
        super(Type.NUMBER, numberCell);
        this.value = numberCell.getValue();
    }

    @Override // jxl.Cell
    public String getContents() {
        if (this.format == null) {
            NumberFormat numberFormat = ((XFRecord) getCellFormat()).getNumberFormat();
            this.format = numberFormat;
            if (numberFormat == null) {
                this.format = defaultFormat;
            }
        }
        return this.format.format(this.value);
    }

    @Override // jxl.write.biff.CellValue, jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] data = super.getData();
        byte[] bArr = new byte[data.length + 8];
        System.arraycopy(data, 0, bArr, 0, data.length);
        DoubleHelper.getIEEEBytes(this.value, bArr, data.length);
        return bArr;
    }

    public NumberFormat getNumberFormat() {
        return null;
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.NUMBER;
    }

    public double getValue() {
        return this.value;
    }

    public void setValue(double d2) {
        this.value = d2;
    }
}
