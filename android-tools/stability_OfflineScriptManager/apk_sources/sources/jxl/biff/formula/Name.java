package jxl.biff.formula;
/* loaded from: classes.dex */
class Name extends Operand implements ParsedThing {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        return new byte[6];
    }

    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        stringBuffer.append("[Name record not implemented]");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
        setInvalid();
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        return 6;
    }
}
