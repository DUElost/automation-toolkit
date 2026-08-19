package jxl.biff.formula;
/* loaded from: classes.dex */
class ErrorConstant extends Operand implements ParsedThing {
    private FormulaErrorCode error;

    public ErrorConstant() {
    }

    public ErrorConstant(String str) {
        this.error = FormulaErrorCode.getErrorCode(str);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        return new byte[]{Token.ERR.getCode(), (byte) this.error.getCode()};
    }

    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        stringBuffer.append(this.error.getDescription());
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        this.error = FormulaErrorCode.getErrorCode(bArr[i]);
        return 1;
    }
}
