package jxl.biff.formula;

import java.util.Stack;
import jxl.common.Assert;
/* loaded from: classes.dex */
abstract class StringOperator extends Operator {
    @Override // jxl.biff.formula.ParseItem
    public void adjustRelativeCellReferences(int i, int i2) {
        Assert.verify(false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void columnInserted(int i, int i2, boolean z) {
        Assert.verify(false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void columnRemoved(int i, int i2, boolean z) {
        Assert.verify(false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract Operator getBinaryOperator();

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        Assert.verify(false);
        return null;
    }

    @Override // jxl.biff.formula.Operator
    public void getOperands(Stack stack) {
        Assert.verify(false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.Operator
    public int getPrecedence() {
        Assert.verify(false);
        return 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        Assert.verify(false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract Operator getUnaryOperator();

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void rowInserted(int i, int i2, boolean z) {
        Assert.verify(false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void rowRemoved(int i, int i2, boolean z) {
        Assert.verify(false);
    }
}
