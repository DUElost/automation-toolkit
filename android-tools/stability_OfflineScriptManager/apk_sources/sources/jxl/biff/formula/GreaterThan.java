package jxl.biff.formula;
/* loaded from: classes.dex */
class GreaterThan extends BinaryOperator implements ParsedThing {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.Operator
    public int getPrecedence() {
        return 5;
    }

    @Override // jxl.biff.formula.BinaryOperator
    public String getSymbol() {
        return ">";
    }

    @Override // jxl.biff.formula.BinaryOperator
    Token getToken() {
        return Token.GREATER_THAN;
    }
}
