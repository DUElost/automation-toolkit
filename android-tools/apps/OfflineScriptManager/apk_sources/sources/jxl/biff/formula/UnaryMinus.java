package jxl.biff.formula;
/* loaded from: classes.dex */
class UnaryMinus extends UnaryOperator implements ParsedThing {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.Operator
    public int getPrecedence() {
        return 2;
    }

    @Override // jxl.biff.formula.UnaryOperator
    public String getSymbol() {
        return "-";
    }

    @Override // jxl.biff.formula.UnaryOperator
    Token getToken() {
        return Token.UNARY_MINUS;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.UnaryOperator, jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }
}
