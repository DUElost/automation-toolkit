package jxl.read.biff;

import jxl.BooleanCell;
import jxl.CellType;
import jxl.biff.FormattingRecords;
import jxl.common.Assert;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class BooleanRecord extends CellValue implements BooleanCell {
    private boolean error;
    private boolean value;

    public BooleanRecord(Record record, FormattingRecords formattingRecords, SheetImpl sheetImpl) {
        super(record, formattingRecords, sheetImpl);
        this.error = false;
        this.value = false;
        byte[] data = getRecord().getData();
        boolean z = data[7] == 1;
        this.error = z;
        if (z) {
            return;
        }
        this.value = data[6] == 1;
    }

    @Override // jxl.Cell
    public String getContents() {
        Assert.verify(!isError());
        return new Boolean(this.value).toString();
    }

    @Override // jxl.biff.RecordData
    public Record getRecord() {
        return super.getRecord();
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.BOOLEAN;
    }

    @Override // jxl.BooleanCell
    public boolean getValue() {
        return this.value;
    }

    public boolean isError() {
        return this.error;
    }
}
