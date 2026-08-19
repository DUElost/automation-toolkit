package jxl.biff.formula;

import jxl.JXLException;
/* loaded from: classes.dex */
public class FormulaException extends JXLException {
    static final FormulaMessage UNRECOGNIZED_TOKEN = new FormulaMessage("Unrecognized token");
    static final FormulaMessage UNRECOGNIZED_FUNCTION = new FormulaMessage("Unrecognized function");
    public static final FormulaMessage BIFF8_SUPPORTED = new FormulaMessage("Only biff8 formulas are supported");
    static final FormulaMessage LEXICAL_ERROR = new FormulaMessage("Lexical error:  ");
    static final FormulaMessage INCORRECT_ARGUMENTS = new FormulaMessage("Incorrect arguments supplied to function");
    static final FormulaMessage SHEET_REF_NOT_FOUND = new FormulaMessage("Could not find sheet");
    static final FormulaMessage CELL_NAME_NOT_FOUND = new FormulaMessage("Could not find named cell");

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class FormulaMessage {
        private String message;

        FormulaMessage(String str) {
            this.message = str;
        }

        public String getMessage() {
            return this.message;
        }
    }

    public FormulaException(FormulaMessage formulaMessage) {
        super(formulaMessage.message);
    }

    /* JADX WARN: Illegal instructions before constructor call */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public FormulaException(jxl.biff.formula.FormulaException.FormulaMessage r2, int r3) {
        /*
            r1 = this;
            java.lang.StringBuffer r0 = new java.lang.StringBuffer
            r0.<init>()
            java.lang.String r2 = jxl.biff.formula.FormulaException.FormulaMessage.access$000(r2)
            r0.append(r2)
            java.lang.String r2 = " "
            r0.append(r2)
            r0.append(r3)
            java.lang.String r2 = r0.toString()
            r1.<init>(r2)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.biff.formula.FormulaException.<init>(jxl.biff.formula.FormulaException$FormulaMessage, int):void");
    }

    /* JADX WARN: Illegal instructions before constructor call */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public FormulaException(jxl.biff.formula.FormulaException.FormulaMessage r2, java.lang.String r3) {
        /*
            r1 = this;
            java.lang.StringBuffer r0 = new java.lang.StringBuffer
            r0.<init>()
            java.lang.String r2 = jxl.biff.formula.FormulaException.FormulaMessage.access$000(r2)
            r0.append(r2)
            java.lang.String r2 = " "
            r0.append(r2)
            r0.append(r3)
            java.lang.String r2 = r0.toString()
            r1.<init>(r2)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.biff.formula.FormulaException.<init>(jxl.biff.formula.FormulaException$FormulaMessage, java.lang.String):void");
    }
}
