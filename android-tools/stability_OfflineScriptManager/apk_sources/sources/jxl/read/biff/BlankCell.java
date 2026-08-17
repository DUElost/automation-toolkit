package jxl.read.biff;

import jxl.CellType;
import jxl.biff.FormattingRecords;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class BlankCell extends CellValue {
    /* JADX INFO: Access modifiers changed from: package-private */
    public BlankCell(Record record, FormattingRecords formattingRecords, SheetImpl sheetImpl) {
        super(record, formattingRecords, sheetImpl);
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
