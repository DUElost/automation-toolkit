package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
/* loaded from: classes.dex */
public class GuttersRecord extends RecordData {
    private int columnOutlineLevel;
    private int height;
    private int rowOutlineLevel;
    private int width;

    public GuttersRecord(Record record) {
        super(record);
        byte[] data = getRecord().getData();
        this.width = IntegerHelper.getInt(data[0], data[1]);
        this.height = IntegerHelper.getInt(data[2], data[3]);
        this.rowOutlineLevel = IntegerHelper.getInt(data[4], data[5]);
        this.columnOutlineLevel = IntegerHelper.getInt(data[6], data[7]);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getColumnOutlineLevel() {
        return this.columnOutlineLevel;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getRowOutlineLevel() {
        return this.rowOutlineLevel;
    }
}
