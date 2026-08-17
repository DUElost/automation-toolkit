package jxl.biff.formula;
/* loaded from: classes.dex */
class Plus extends StringOperator {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.StringOperator
    public Operator getBinaryOperator() {
        return new Add();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.StringOperator
    public Operator getUnaryOperator() {
        return new UnaryPlus();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }
}
