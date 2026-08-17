package jxl.biff.formula;

import jxl.WorkbookSettings;
import jxl.common.Logger;
/* loaded from: classes.dex */
class StringFunction extends StringParseItem {
    static /* synthetic */ Class class$jxl$biff$formula$StringFunction;
    private static Logger logger;
    private Function function;
    private String functionString;

    static {
        Class cls = class$jxl$biff$formula$StringFunction;
        if (cls == null) {
            cls = class$("jxl.biff.formula.StringFunction");
            class$jxl$biff$formula$StringFunction = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public StringFunction(String str) {
        this.functionString = str.substring(0, str.length() - 1);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Function getFunction(WorkbookSettings workbookSettings) {
        if (this.function == null) {
            this.function = Function.getFunction(this.functionString, workbookSettings);
        }
        return this.function;
    }
}
