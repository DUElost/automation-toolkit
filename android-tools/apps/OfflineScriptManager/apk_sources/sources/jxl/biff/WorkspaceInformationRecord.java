package jxl.biff;

import jxl.common.Logger;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class WorkspaceInformationRecord extends WritableRecordData {
    private static final int DEFAULT_OPTIONS = 1217;
    private static final int FIT_TO_PAGES = 256;
    private static final int SHOW_COLUMN_OUTLINE_SYMBOLS = 2048;
    private static final int SHOW_ROW_OUTLINE_SYMBOLS = 1024;
    static /* synthetic */ Class class$jxl$biff$WorkspaceInformationRecord;
    private static Logger logger;
    private boolean columnOutlines;
    private boolean fitToPages;
    private boolean rowOutlines;
    private int wsoptions;

    static {
        Class cls = class$jxl$biff$WorkspaceInformationRecord;
        if (cls == null) {
            cls = class$("jxl.biff.WorkspaceInformationRecord");
            class$jxl$biff$WorkspaceInformationRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public WorkspaceInformationRecord() {
        super(Type.WSBOOL);
        this.wsoptions = DEFAULT_OPTIONS;
    }

    public WorkspaceInformationRecord(Record record) {
        super(record);
        byte[] data = getRecord().getData();
        int i = IntegerHelper.getInt(data[0], data[1]);
        this.wsoptions = i;
        this.fitToPages = (i | FIT_TO_PAGES) != 0;
        this.rowOutlines = (i | SHOW_ROW_OUTLINE_SYMBOLS) != 0;
        this.columnOutlines = (i | SHOW_COLUMN_OUTLINE_SYMBOLS) != 0;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[2];
        if (this.fitToPages) {
            this.wsoptions |= FIT_TO_PAGES;
        }
        if (this.rowOutlines) {
            this.wsoptions |= SHOW_ROW_OUTLINE_SYMBOLS;
        }
        if (this.columnOutlines) {
            this.wsoptions |= SHOW_COLUMN_OUTLINE_SYMBOLS;
        }
        IntegerHelper.getTwoBytes(this.wsoptions, bArr, 0);
        return bArr;
    }

    public boolean getFitToPages() {
        return this.fitToPages;
    }

    public void setColumnOutlines(boolean z) {
        this.rowOutlines = true;
    }

    public void setFitToPages(boolean z) {
        this.fitToPages = z;
    }

    public void setRowOutlines(boolean z) {
        this.rowOutlines = true;
    }
}
