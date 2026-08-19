package jxl.biff.formula;

import java.util.Stack;
import jxl.biff.IntegerHelper;
/* loaded from: classes.dex */
abstract class SubExpression extends Operand implements ParsedThing {
    private int length;
    private ParseItem[] subExpression;

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        return null;
    }

    public int getLength() {
        return this.length;
    }

    public void getOperands(Stack stack) {
    }

    int getPrecedence() {
        return 5;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public ParseItem[] getSubExpression() {
        return this.subExpression;
    }

    public int read(byte[] bArr, int i) {
        this.length = IntegerHelper.getInt(bArr[i], bArr[i + 1]);
        return 2;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setLength(int i) {
        this.length = i;
    }

    public void setSubExpression(ParseItem[] parseItemArr) {
        this.subExpression = parseItemArr;
    }
}
