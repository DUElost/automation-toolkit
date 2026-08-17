package jxl.biff.formula;

import jxl.common.Logger;
/* loaded from: classes.dex */
class Minus extends StringOperator {
    static /* synthetic */ Class class$jxl$biff$formula$StringOperator;
    private static Logger logger;

    static {
        Class cls = class$jxl$biff$formula$StringOperator;
        if (cls == null) {
            cls = class$("jxl.biff.formula.StringOperator");
            class$jxl$biff$formula$StringOperator = cls;
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

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.StringOperator
    public Operator getBinaryOperator() {
        return new Subtract();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.StringOperator
    public Operator getUnaryOperator() {
        return new UnaryMinus();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }
}
