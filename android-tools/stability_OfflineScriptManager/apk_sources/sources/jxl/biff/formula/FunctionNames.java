package jxl.biff.formula;

import java.util.HashMap;
import java.util.Locale;
import java.util.ResourceBundle;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class FunctionNames {
    static /* synthetic */ Class class$jxl$biff$formula$FunctionNames;
    private static Logger logger;
    private HashMap functions;
    private HashMap names;

    static {
        Class cls = class$jxl$biff$formula$FunctionNames;
        if (cls == null) {
            cls = class$("jxl.biff.formula.FunctionNames");
            class$jxl$biff$formula$FunctionNames = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public FunctionNames(Locale locale) {
        ResourceBundle bundle = ResourceBundle.getBundle("functions", locale);
        Function[] functions = Function.getFunctions();
        this.names = new HashMap(functions.length);
        this.functions = new HashMap(functions.length);
        for (Function function : functions) {
            String propertyName = function.getPropertyName();
            String string = propertyName.length() != 0 ? bundle.getString(propertyName) : null;
            if (string != null) {
                this.names.put(function, string);
                this.functions.put(string, function);
            }
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Function getFunction(String str) {
        return (Function) this.functions.get(str);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String getName(Function function) {
        return (String) this.names.get(function);
    }
}
