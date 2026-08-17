package jxl.biff.formula;

import jxl.biff.IntegerHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
class IntegerValue extends NumberValue implements ParsedThing {
    static /* synthetic */ Class class$jxl$biff$formula$IntegerValue;
    private static Logger logger;
    private boolean outOfRange;
    private double value;

    static {
        Class cls = class$jxl$biff$formula$IntegerValue;
        if (cls == null) {
            cls = class$("jxl.biff.formula.IntegerValue");
            class$jxl$biff$formula$IntegerValue = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public IntegerValue() {
        this.outOfRange = false;
    }

    public IntegerValue(String str) {
        try {
            this.value = Integer.parseInt(str);
        } catch (NumberFormatException e) {
            logger.warn(e, e);
            this.value = 0.0d;
        }
        double d2 = this.value;
        this.outOfRange = d2 != ((double) ((short) ((int) d2)));
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
        byte[] bArr = {Token.INTEGER.getCode()};
        IntegerHelper.getTwoBytes((int) this.value, bArr, 1);
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

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean isOutOfRange() {
        return this.outOfRange;
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        this.value = IntegerHelper.getInt(bArr[i], bArr[i + 1]);
        return 2;
    }
}
