package jxl.biff.formula;
/* loaded from: classes.dex */
abstract class Operand extends ParseItem {
    @Override // jxl.biff.formula.ParseItem
    public void adjustRelativeCellReferences(int i, int i2) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void columnInserted(int i, int i2, boolean z) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void columnRemoved(int i, int i2, boolean z) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void rowInserted(int i, int i2, boolean z) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void rowRemoved(int i, int i2, boolean z) {
    }
}
