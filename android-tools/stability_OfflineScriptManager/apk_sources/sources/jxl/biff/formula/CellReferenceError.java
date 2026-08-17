package jxl.biff.formula;

import jxl.common.Logger;
/* loaded from: classes.dex */
class CellReferenceError extends Operand implements ParsedThing {
    static /* synthetic */ Class class$jxl$biff$formula$CellReferenceError;
    private static Logger logger;

    static {
        Class cls = class$jxl$biff$formula$CellReferenceError;
        if (cls == null) {
            cls = class$("jxl.biff.formula.CellReferenceError");
            class$jxl$biff$formula$CellReferenceError = cls;
        }
        logger = Logger.getLogger(cls);
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
        byte[] bArr = new byte[5];
        bArr[0] = Token.REFERR.getCode();
        return bArr;
    }

    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        stringBuffer.append(FormulaErrorCode.REF.getDescription());
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        return 4;
    }
}
