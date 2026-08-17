package jxl.biff.formula;
/* loaded from: classes.dex */
class Percent extends UnaryOperator implements ParsedThing {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.Operator
    public int getPrecedence() {
        return 5;
    }

    @Override // jxl.biff.formula.UnaryOperator, jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        getOperands()[0].getString(stringBuffer);
        stringBuffer.append(getSymbol());
    }

    @Override // jxl.biff.formula.UnaryOperator
    public String getSymbol() {
        return "%";
    }

    @Override // jxl.biff.formula.UnaryOperator
    Token getToken() {
        return Token.PERCENT;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.UnaryOperator, jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
        getOperands()[0].handleImportedCellReferences();
    }
}
