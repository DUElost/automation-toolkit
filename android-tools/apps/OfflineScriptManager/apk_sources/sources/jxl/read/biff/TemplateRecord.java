package jxl.read.biff;

import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class TemplateRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$TemplateRecord;
    private static Logger logger;
    private boolean template;

    static {
        Class cls = class$jxl$read$biff$TemplateRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.TemplateRecord");
            class$jxl$read$biff$TemplateRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public TemplateRecord(Record record) {
        super(record);
        this.template = true;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean getTemplate() {
        return this.template;
    }
}
