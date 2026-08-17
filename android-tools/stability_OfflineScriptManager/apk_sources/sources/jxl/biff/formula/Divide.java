package jxl.biff.formula;
/* loaded from: classes.dex */
class Divide extends BinaryOperator implements ParsedThing {
    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.Operator
    public int getPrecedence() {
        return 3;
    }

    @Override // jxl.biff.formula.BinaryOperator
    public String getSymbol() {
        return "/";
    }

    @Override // jxl.biff.formula.BinaryOperator
    Token getToken() {
        return Token.DIVIDE;
    }
}
