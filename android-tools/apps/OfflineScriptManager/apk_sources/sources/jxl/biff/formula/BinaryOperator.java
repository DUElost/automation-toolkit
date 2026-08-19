package jxl.biff.formula;

import java.util.Stack;
import jxl.common.Logger;
/* loaded from: classes.dex */
abstract class BinaryOperator extends Operator implements ParsedThing {
    static /* synthetic */ Class class$jxl$biff$formula$BinaryOperator;
    private static final Logger logger;

    static {
        Class cls = class$jxl$biff$formula$BinaryOperator;
        if (cls == null) {
            cls = class$("jxl.biff.formula.BinaryOperator");
            class$jxl$biff$formula$BinaryOperator = cls;
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

    @Override // jxl.biff.formula.ParseItem
    public void adjustRelativeCellReferences(int i, int i2) {
        ParseItem[] operands = getOperands();
        operands[1].adjustRelativeCellReferences(i, i2);
        operands[0].adjustRelativeCellReferences(i, i2);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void columnInserted(int i, int i2, boolean z) {
        ParseItem[] operands = getOperands();
        operands[1].columnInserted(i, i2, z);
        operands[0].columnInserted(i, i2, z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void columnRemoved(int i, int i2, boolean z) {
        ParseItem[] operands = getOperands();
        operands[1].columnRemoved(i, i2, z);
        operands[0].columnRemoved(i, i2, z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        ParseItem[] operands = getOperands();
        byte[] bArr = new byte[0];
        int length = operands.length - 1;
        while (length >= 0) {
            byte[] bytes = operands[length].getBytes();
            byte[] bArr2 = new byte[bArr.length + bytes.length];
            System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
            System.arraycopy(bytes, 0, bArr2, bArr.length, bytes.length);
            length--;
            bArr = bArr2;
        }
        byte[] bArr3 = new byte[bArr.length + 1];
        System.arraycopy(bArr, 0, bArr3, 0, bArr.length);
        bArr3[bArr.length] = getToken().getCode();
        return bArr3;
    }

    @Override // jxl.biff.formula.Operator
    public void getOperands(Stack stack) {
        add((ParseItem) stack.pop());
        add((ParseItem) stack.pop());
    }

    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        ParseItem[] operands = getOperands();
        operands[1].getString(stringBuffer);
        stringBuffer.append(getSymbol());
        operands[0].getString(stringBuffer);
    }

    abstract String getSymbol();

    abstract Token getToken();

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
        ParseItem[] operands = getOperands();
        operands[0].handleImportedCellReferences();
        operands[1].handleImportedCellReferences();
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        return 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void rowInserted(int i, int i2, boolean z) {
        ParseItem[] operands = getOperands();
        operands[1].rowInserted(i, i2, z);
        operands[0].rowInserted(i, i2, z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void rowRemoved(int i, int i2, boolean z) {
        ParseItem[] operands = getOperands();
        operands[1].rowRemoved(i, i2, z);
        operands[0].rowRemoved(i, i2, z);
    }
}
