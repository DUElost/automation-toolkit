package jxl.common.log;
/* loaded from: classes.dex */
public class LoggerName {
    public static final String NAME;
    static /* synthetic */ Class class$jxl$common$log$SimpleLogger;

    static {
        Class cls = class$jxl$common$log$SimpleLogger;
        if (cls == null) {
            cls = class$("jxl.common.log.SimpleLogger");
            class$jxl$common$log$SimpleLogger = cls;
        }
        NAME = cls.getName();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }
}
