package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class RowRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$RowRecord = null;
    private static final int defaultHeightIndicator = 255;
    private static Logger logger;
    private boolean collapsed;
    private boolean defaultFormat;
    private boolean groupStart;
    private boolean matchesDefFontHeight;
    private int outlineLevel;
    private int rowHeight;
    private int rowNumber;
    private int xfIndex;

    static {
        Class cls = class$jxl$read$biff$RowRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.RowRecord");
            class$jxl$read$biff$RowRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public RowRecord(Record record) {
        super(record);
        byte[] data = getRecord().getData();
        this.rowNumber = IntegerHelper.getInt(data[0], data[1]);
        this.rowHeight = IntegerHelper.getInt(data[6], data[7]);
        int i = IntegerHelper.getInt(data[12], data[13], data[14], data[15]);
        this.outlineLevel = i & 7;
        this.groupStart = (i & 16) != 0;
        this.collapsed = (i & 32) != 0;
        this.matchesDefFontHeight = (i & 64) == 0;
        this.defaultFormat = (i & 128) != 0;
        this.xfIndex = (i & 268369920) >> 16;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean getGroupStart() {
        return this.groupStart;
    }

    public int getOutlineLevel() {
        return this.outlineLevel;
    }

    public int getRowHeight() {
        return this.rowHeight;
    }

    public int getRowNumber() {
        return this.rowNumber;
    }

    public int getXFIndex() {
        return this.xfIndex;
    }

    public boolean hasDefaultFormat() {
        return this.defaultFormat;
    }

    public boolean isCollapsed() {
        return this.collapsed;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean isDefaultHeight() {
        return this.rowHeight == 255;
    }

    public boolean matchesDefaultFontHeight() {
        return this.matchesDefFontHeight;
    }
}
