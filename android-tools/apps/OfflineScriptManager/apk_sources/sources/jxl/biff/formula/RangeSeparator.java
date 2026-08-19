package jxl.biff.formula;

import jxl.biff.IntegerHelper;
/* loaded from: classes.dex */
class RangeSeparator extends BinaryOperator implements ParsedThing {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.BinaryOperator, jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        setVolatile();
        setOperandAlternateCode();
        byte[] bytes = super.getBytes();
        byte[] bArr = new byte[bytes.length + 3];
        System.arraycopy(bytes, 0, bArr, 3, bytes.length);
        bArr[0] = Token.MEM_FUNC.getCode();
        IntegerHelper.getTwoBytes(bytes.length, bArr, 1);
        return bArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.Operator
    public int getPrecedence() {
        return 1;
    }

    @Override // jxl.biff.formula.BinaryOperator
    public String getSymbol() {
        return ":";
    }

    @Override // jxl.biff.formula.BinaryOperator
    Token getToken() {
        return Token.RANGE;
    }
}
