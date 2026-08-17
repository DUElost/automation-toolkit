package jxl.read.biff;

import jxl.Cell;
import jxl.CellFeatures;
import jxl.biff.FormattingRecords;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.XFRecord;
import jxl.common.Logger;
import jxl.format.CellFormat;
/* loaded from: classes.dex */
public abstract class CellValue extends RecordData implements Cell, CellFeaturesAccessor {
    static /* synthetic */ Class class$jxl$read$biff$CellValue;
    private static Logger logger;
    private int column;
    private CellFeatures features;
    private XFRecord format;
    private FormattingRecords formattingRecords;
    private boolean initialized;
    private int row;
    private SheetImpl sheet;
    private int xfIndex;

    static {
        Class cls = class$jxl$read$biff$CellValue;
        if (cls == null) {
            cls = class$("jxl.read.biff.CellValue");
            class$jxl$read$biff$CellValue = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public CellValue(Record record, FormattingRecords formattingRecords, SheetImpl sheetImpl) {
        super(record);
        byte[] data = getRecord().getData();
        this.row = IntegerHelper.getInt(data[0], data[1]);
        this.column = IntegerHelper.getInt(data[2], data[3]);
        this.xfIndex = IntegerHelper.getInt(data[4], data[5]);
        this.sheet = sheetImpl;
        this.formattingRecords = formattingRecords;
        this.initialized = false;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.Cell
    public CellFeatures getCellFeatures() {
        return this.features;
    }

    @Override // jxl.Cell
    public CellFormat getCellFormat() {
        if (!this.initialized) {
            this.format = this.formattingRecords.getXFRecord(this.xfIndex);
            this.initialized = true;
        }
        return this.format;
    }

    @Override // jxl.Cell
    public final int getColumn() {
        return this.column;
    }

    @Override // jxl.Cell
    public final int getRow() {
        return this.row;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public SheetImpl getSheet() {
        return this.sheet;
    }

    public final int getXFIndex() {
        return this.xfIndex;
    }

    @Override // jxl.Cell
    public boolean isHidden() {
        ColumnInfoRecord columnInfo = this.sheet.getColumnInfo(this.column);
        if (columnInfo == null || !(columnInfo.getWidth() == 0 || columnInfo.getHidden())) {
            RowRecord rowInfo = this.sheet.getRowInfo(this.row);
            if (rowInfo != null) {
                return rowInfo.getRowHeight() == 0 || rowInfo.isCollapsed();
            }
            return false;
        }
        return true;
    }

    @Override // jxl.read.biff.CellFeaturesAccessor
    public void setCellFeatures(CellFeatures cellFeatures) {
        if (this.features != null) {
            logger.warn("current cell features not null - overwriting");
        }
        this.features = cellFeatures;
    }
}
