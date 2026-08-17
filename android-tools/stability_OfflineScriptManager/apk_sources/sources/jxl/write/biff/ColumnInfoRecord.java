package jxl.write.biff;

import jxl.biff.FormattingRecords;
import jxl.biff.IndexMapping;
import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.biff.XFRecord;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class ColumnInfoRecord extends WritableRecordData {
    private boolean collapsed;
    private int column;
    private byte[] data;
    private boolean hidden;
    private int outlineLevel;
    private XFRecord style;
    private int width;
    private int xfIndex;

    public ColumnInfoRecord(int i, int i2, XFRecord xFRecord) {
        super(Type.COLINFO);
        this.column = i;
        this.width = i2;
        this.style = xFRecord;
        this.xfIndex = xFRecord.getXFIndex();
        this.hidden = false;
    }

    public ColumnInfoRecord(jxl.read.biff.ColumnInfoRecord columnInfoRecord, int i) {
        super(Type.COLINFO);
        this.column = i;
        this.width = columnInfoRecord.getWidth();
        this.xfIndex = columnInfoRecord.getXFIndex();
        this.outlineLevel = columnInfoRecord.getOutlineLevel();
        this.collapsed = columnInfoRecord.getCollapsed();
    }

    public ColumnInfoRecord(jxl.read.biff.ColumnInfoRecord columnInfoRecord, int i, FormattingRecords formattingRecords) {
        super(Type.COLINFO);
        this.column = i;
        this.width = columnInfoRecord.getWidth();
        int xFIndex = columnInfoRecord.getXFIndex();
        this.xfIndex = xFIndex;
        this.style = formattingRecords.getXFRecord(xFIndex);
        this.outlineLevel = columnInfoRecord.getOutlineLevel();
        this.collapsed = columnInfoRecord.getCollapsed();
    }

    public ColumnInfoRecord(ColumnInfoRecord columnInfoRecord) {
        super(Type.COLINFO);
        this.column = columnInfoRecord.column;
        this.width = columnInfoRecord.width;
        this.style = columnInfoRecord.style;
        this.xfIndex = columnInfoRecord.xfIndex;
        this.hidden = columnInfoRecord.hidden;
        this.outlineLevel = columnInfoRecord.outlineLevel;
        this.collapsed = columnInfoRecord.collapsed;
    }

    public void decrementColumn() {
        this.column--;
    }

    public void decrementOutlineLevel() {
        int i = this.outlineLevel;
        if (i > 0) {
            this.outlineLevel = i - 1;
        }
        if (this.outlineLevel == 0) {
            this.collapsed = false;
        }
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof ColumnInfoRecord) {
            ColumnInfoRecord columnInfoRecord = (ColumnInfoRecord) obj;
            if (this.column == columnInfoRecord.column && this.xfIndex == columnInfoRecord.xfIndex && this.width == columnInfoRecord.width && this.hidden == columnInfoRecord.hidden && this.outlineLevel == columnInfoRecord.outlineLevel && this.collapsed == columnInfoRecord.collapsed) {
                XFRecord xFRecord = this.style;
                if ((xFRecord != null || columnInfoRecord.style == null) && (xFRecord == null || columnInfoRecord.style != null)) {
                    return xFRecord.equals(columnInfoRecord.style);
                }
                return false;
            }
            return false;
        }
        return false;
    }

    public XFRecord getCellFormat() {
        return this.style;
    }

    public boolean getCollapsed() {
        return this.collapsed;
    }

    public int getColumn() {
        return this.column;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[12];
        this.data = bArr;
        IntegerHelper.getTwoBytes(this.column, bArr, 0);
        IntegerHelper.getTwoBytes(this.column, this.data, 2);
        IntegerHelper.getTwoBytes(this.width, this.data, 4);
        IntegerHelper.getTwoBytes(this.xfIndex, this.data, 6);
        int i = (this.outlineLevel << 8) | 6;
        if (this.hidden) {
            i |= 1;
        }
        this.outlineLevel = (i & 1792) / 256;
        if (this.collapsed) {
            i |= 4096;
        }
        IntegerHelper.getTwoBytes(i, this.data, 8);
        return this.data;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean getHidden() {
        return this.hidden;
    }

    public int getOutlineLevel() {
        return this.outlineLevel;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getWidth() {
        return this.width;
    }

    public int getXfIndex() {
        return this.xfIndex;
    }

    public int hashCode() {
        int i = ((((((10823 + this.column) * 79) + this.xfIndex) * 79) + this.width) * 79) + (this.hidden ? 1 : 0);
        XFRecord xFRecord = this.style;
        return xFRecord != null ? i ^ xFRecord.hashCode() : i;
    }

    public void incrementColumn() {
        this.column++;
    }

    public void incrementOutlineLevel() {
        this.outlineLevel++;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rationalize(IndexMapping indexMapping) {
        this.xfIndex = indexMapping.getNewIndex(this.xfIndex);
    }

    public void setCellFormat(XFRecord xFRecord) {
        this.style = xFRecord;
    }

    public void setCollapsed(boolean z) {
        this.collapsed = z;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setHidden(boolean z) {
        this.hidden = z;
    }

    public void setOutlineLevel(int i) {
        this.outlineLevel = i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWidth(int i) {
        this.width = i;
    }
}
