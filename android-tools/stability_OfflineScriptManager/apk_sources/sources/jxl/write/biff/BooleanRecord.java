package jxl.write.biff;

import jxl.BooleanCell;
import jxl.CellType;
import jxl.biff.Type;
import jxl.format.CellFormat;
/* loaded from: classes.dex */
public abstract class BooleanRecord extends CellValue {
    private boolean value;

    /* JADX INFO: Access modifiers changed from: protected */
    public BooleanRecord(int i, int i2, BooleanRecord booleanRecord) {
        super(Type.BOOLERR, i, i2, booleanRecord);
        this.value = booleanRecord.value;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BooleanRecord(int i, int i2, boolean z) {
        super(Type.BOOLERR, i, i2);
        this.value = z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BooleanRecord(int i, int i2, boolean z, CellFormat cellFormat) {
        super(Type.BOOLERR, i, i2, cellFormat);
        this.value = z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BooleanRecord(BooleanCell booleanCell) {
        super(Type.BOOLERR, booleanCell);
        this.value = booleanCell.getValue();
    }

    @Override // jxl.Cell
    public String getContents() {
        return new Boolean(this.value).toString();
    }

    @Override // jxl.write.biff.CellValue, jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] data = super.getData();
        byte[] bArr = new byte[data.length + 2];
        System.arraycopy(data, 0, bArr, 0, data.length);
        if (this.value) {
            bArr[data.length] = 1;
        }
        return bArr;
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.BOOLEAN;
    }

    public boolean getValue() {
        return this.value;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setValue(boolean z) {
        this.value = z;
    }
}
