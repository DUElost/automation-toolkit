package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.Type;
/* loaded from: classes.dex */
public class ColumnInfoRecord extends RecordData {
    private boolean collapsed;
    private byte[] data;
    private int endColumn;
    private boolean hidden;
    private int outlineLevel;
    private int startColumn;
    private int width;
    private int xfIndex;

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColumnInfoRecord(Record record) {
        super(Type.COLINFO);
        byte[] data = record.getData();
        this.data = data;
        this.startColumn = IntegerHelper.getInt(data[0], data[1]);
        byte[] bArr = this.data;
        this.endColumn = IntegerHelper.getInt(bArr[2], bArr[3]);
        byte[] bArr2 = this.data;
        this.width = IntegerHelper.getInt(bArr2[4], bArr2[5]);
        byte[] bArr3 = this.data;
        this.xfIndex = IntegerHelper.getInt(bArr3[6], bArr3[7]);
        byte[] bArr4 = this.data;
        int i = IntegerHelper.getInt(bArr4[8], bArr4[9]);
        this.hidden = (i & 1) != 0;
        this.outlineLevel = (i & 1792) >> 8;
        this.collapsed = (i & 4096) != 0;
    }

    public boolean getCollapsed() {
        return this.collapsed;
    }

    public int getEndColumn() {
        return this.endColumn;
    }

    public boolean getHidden() {
        return this.hidden;
    }

    public int getOutlineLevel() {
        return this.outlineLevel;
    }

    public int getStartColumn() {
        return this.startColumn;
    }

    public int getWidth() {
        return this.width;
    }

    public int getXFIndex() {
        return this.xfIndex;
    }
}
