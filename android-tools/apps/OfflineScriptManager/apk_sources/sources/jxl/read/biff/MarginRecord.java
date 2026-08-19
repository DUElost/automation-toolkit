package jxl.read.biff;

import jxl.biff.DoubleHelper;
import jxl.biff.RecordData;
import jxl.biff.Type;
/* loaded from: classes.dex */
abstract class MarginRecord extends RecordData {
    private double margin;

    /* JADX INFO: Access modifiers changed from: protected */
    public MarginRecord(Type type, Record record) {
        super(type);
        this.margin = DoubleHelper.getIEEEDouble(record.getData(), 0);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public double getMargin() {
        return this.margin;
    }
}
