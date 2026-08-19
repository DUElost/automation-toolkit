package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class PaneRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$PaneRecord;
    private static Logger logger;
    private int columnsVisible;
    private int rowsVisible;

    static {
        Class cls = class$jxl$read$biff$PaneRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.PaneRecord");
            class$jxl$read$biff$PaneRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public PaneRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        this.columnsVisible = IntegerHelper.getInt(data[0], data[1]);
        this.rowsVisible = IntegerHelper.getInt(data[2], data[3]);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public final int getColumnsVisible() {
        return this.columnsVisible;
    }

    public final int getRowsVisible() {
        return this.rowsVisible;
    }
}
