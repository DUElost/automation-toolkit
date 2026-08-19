package jxl.biff.formula;

import jxl.biff.IntegerHelper;
/* loaded from: classes.dex */
class MemArea extends SubExpression {
    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        ParseItem parseItem;
        ParseItem[] subExpression = getSubExpression();
        if (subExpression.length == 1) {
            parseItem = subExpression[0];
        } else if (subExpression.length != 2) {
            return;
        } else {
            subExpression[1].getString(stringBuffer);
            stringBuffer.append(':');
            parseItem = subExpression[0];
        }
        parseItem.getString(stringBuffer);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }

    @Override // jxl.biff.formula.SubExpression, jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        setLength(IntegerHelper.getInt(bArr[i + 4], bArr[i + 5]));
        return 6;
    }
}
