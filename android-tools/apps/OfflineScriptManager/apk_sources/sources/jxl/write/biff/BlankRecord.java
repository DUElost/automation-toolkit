package jxl.write.biff;

import jxl.Cell;
import jxl.CellType;
import jxl.biff.Type;
import jxl.common.Logger;
import jxl.format.CellFormat;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class BlankRecord extends CellValue {
    static /* synthetic */ Class class$jxl$write$biff$BlankRecord;
    private static Logger logger;

    static {
        Class cls = class$jxl$write$biff$BlankRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.BlankRecord");
            class$jxl$write$biff$BlankRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BlankRecord(int i, int i2) {
        super(Type.BLANK, i, i2);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BlankRecord(int i, int i2, CellFormat cellFormat) {
        super(Type.BLANK, i, i2, cellFormat);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BlankRecord(int i, int i2, BlankRecord blankRecord) {
        super(Type.BLANK, i, i2, blankRecord);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BlankRecord(Cell cell) {
        super(Type.BLANK, cell);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.Cell
    public String getContents() {
        return BuildConfig.FLAVOR;
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.EMPTY;
    }
}
