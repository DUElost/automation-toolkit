package jxl.biff.formula;

import jxl.biff.DoubleHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
class DoubleValue extends NumberValue implements ParsedThing {
    static /* synthetic */ Class class$jxl$biff$formula$DoubleValue;
    private static Logger logger;
    private double value;

    static {
        Class cls = class$jxl$biff$formula$DoubleValue;
        if (cls == null) {
            cls = class$("jxl.biff.formula.DoubleValue");
            class$jxl$biff$formula$DoubleValue = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public DoubleValue() {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DoubleValue(double d2) {
        this.value = d2;
    }

    public DoubleValue(String str) {
        try {
            this.value = Double.parseDouble(str);
        } catch (NumberFormatException e) {
            logger.warn(e, e);
            this.value = 0.0d;
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        byte[] bArr = new byte[9];
        bArr[0] = Token.DOUBLE.getCode();
        DoubleHelper.getIEEEBytes(this.value, bArr, 1);
        return bArr;
    }

    @Override // jxl.biff.formula.NumberValue
    public double getValue() {
        return this.value;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        this.value = DoubleHelper.getIEEEDouble(bArr, i);
        return 8;
    }
}
