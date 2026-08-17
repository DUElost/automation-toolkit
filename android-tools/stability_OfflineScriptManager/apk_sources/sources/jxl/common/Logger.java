package jxl.common;

import java.security.AccessControlException;
import jxl.common.log.LoggerName;
import jxl.common.log.SimpleLogger;
/* loaded from: classes.dex */
public abstract class Logger {
    private static Logger logger;

    public static final Logger getLogger(Class cls) {
        if (logger == null) {
            initializeLogger();
        }
        return logger.getLoggerImpl(cls);
    }

    private static synchronized void initializeLogger() {
        SimpleLogger simpleLogger;
        String stringBuffer;
        synchronized (Logger.class) {
            if (logger != null) {
                return;
            }
            String str = LoggerName.NAME;
            try {
                try {
                    try {
                        try {
                            String property = System.getProperty("logger");
                            if (property != null) {
                                str = property;
                            }
                            logger = (Logger) Class.forName(str).newInstance();
                        } catch (IllegalAccessException unused) {
                            simpleLogger = new SimpleLogger();
                            logger = simpleLogger;
                            StringBuffer stringBuffer2 = new StringBuffer();
                            stringBuffer2.append("Could not instantiate logger ");
                            stringBuffer2.append(str);
                            stringBuffer2.append(" using default");
                            stringBuffer = stringBuffer2.toString();
                            simpleLogger.warn(stringBuffer);
                        }
                    } catch (ClassNotFoundException unused2) {
                        simpleLogger = new SimpleLogger();
                        logger = simpleLogger;
                        StringBuffer stringBuffer3 = new StringBuffer();
                        stringBuffer3.append("Could not instantiate logger ");
                        stringBuffer3.append(str);
                        stringBuffer3.append(" using default");
                        stringBuffer = stringBuffer3.toString();
                        simpleLogger.warn(stringBuffer);
                    }
                } catch (InstantiationException unused3) {
                    simpleLogger = new SimpleLogger();
                    logger = simpleLogger;
                    StringBuffer stringBuffer4 = new StringBuffer();
                    stringBuffer4.append("Could not instantiate logger ");
                    stringBuffer4.append(str);
                    stringBuffer4.append(" using default");
                    stringBuffer = stringBuffer4.toString();
                    simpleLogger.warn(stringBuffer);
                }
            } catch (AccessControlException unused4) {
                simpleLogger = new SimpleLogger();
                logger = simpleLogger;
                StringBuffer stringBuffer5 = new StringBuffer();
                stringBuffer5.append("Could not instantiate logger ");
                stringBuffer5.append(str);
                stringBuffer5.append(" using default");
                stringBuffer = stringBuffer5.toString();
                simpleLogger.warn(stringBuffer);
            }
        }
    }

    public abstract void debug(Object obj);

    public abstract void debug(Object obj, Throwable th);

    public abstract void error(Object obj);

    public abstract void error(Object obj, Throwable th);

    public abstract void fatal(Object obj);

    public abstract void fatal(Object obj, Throwable th);

    protected abstract Logger getLoggerImpl(Class cls);

    public abstract void info(Object obj);

    public abstract void info(Object obj, Throwable th);

    public void setSuppressWarnings(boolean z) {
    }

    public abstract void warn(Object obj);

    public abstract void warn(Object obj, Throwable th);
}
