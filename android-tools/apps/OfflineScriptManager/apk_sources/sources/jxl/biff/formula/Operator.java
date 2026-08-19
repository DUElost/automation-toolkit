package jxl.biff.formula;

import java.util.Stack;
/* loaded from: classes.dex */
abstract class Operator extends ParseItem {
    private ParseItem[] operands = new ParseItem[0];

    /* JADX INFO: Access modifiers changed from: protected */
    public void add(ParseItem parseItem) {
        parseItem.setParent(this);
        ParseItem[] parseItemArr = this.operands;
        ParseItem[] parseItemArr2 = new ParseItem[parseItemArr.length + 1];
        System.arraycopy(parseItemArr, 0, parseItemArr2, 0, parseItemArr.length);
        parseItemArr2[this.operands.length] = parseItem;
        this.operands = parseItemArr2;
    }

    public abstract void getOperands(Stack stack);

    /* JADX INFO: Access modifiers changed from: protected */
    public ParseItem[] getOperands() {
        return this.operands;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract int getPrecedence();

    /* JADX INFO: Access modifiers changed from: protected */
    public void setOperandAlternateCode() {
        int i = 0;
        while (true) {
            ParseItem[] parseItemArr = this.operands;
            if (i >= parseItemArr.length) {
                return;
            }
            parseItemArr[i].setAlternateCode();
            i++;
        }
    }
}
