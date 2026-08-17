package jxl.biff.formula;

import jxl.biff.CellReferenceHelper;
import jxl.common.Assert;
import jxl.common.Logger;
/* loaded from: classes.dex */
class ColumnRange extends Area {
    static /* synthetic */ Class class$jxl$biff$formula$ColumnRange;
    private static Logger logger;

    static {
        Class cls = class$jxl$biff$formula$ColumnRange;
        if (cls == null) {
            cls = class$("jxl.biff.formula.ColumnRange");
            class$jxl$biff$formula$ColumnRange = cls;
        }
        logger = Logger.getLogger(cls);
    }

    ColumnRange() {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColumnRange(String str) {
        int indexOf = str.indexOf(":");
        Assert.verify(indexOf != -1);
        String substring = str.substring(0, indexOf);
        String substring2 = str.substring(indexOf + 1);
        setRangeData(CellReferenceHelper.getColumn(substring), CellReferenceHelper.getColumn(substring2), 0, 65535, CellReferenceHelper.isColumnRelative(substring), CellReferenceHelper.isColumnRelative(substring2), false, false);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.biff.formula.Area, jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        CellReferenceHelper.getColumnReference(getFirstColumn(), stringBuffer);
        stringBuffer.append(':');
        CellReferenceHelper.getColumnReference(getLastColumn(), stringBuffer);
    }
}
