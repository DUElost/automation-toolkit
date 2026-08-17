package jxl.write.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
class IndexRecord extends WritableRecordData {
    private int blocks;
    private int bofPosition;
    private byte[] data;
    private int dataPos;
    private int rows;

    public IndexRecord(int i, int i2, int i3) {
        super(Type.INDEX);
        this.bofPosition = i;
        this.rows = i2;
        this.blocks = i3;
        this.data = new byte[(i3 * 4) + 16];
        this.dataPos = 16;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addBlockPosition(int i) {
        IntegerHelper.getFourBytes(i - this.bofPosition, this.data, this.dataPos);
        this.dataPos += 4;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        IntegerHelper.getFourBytes(this.rows, this.data, 8);
        return this.data;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDataStartPosition(int i) {
        IntegerHelper.getFourBytes(i - this.bofPosition, this.data, 12);
    }
}
