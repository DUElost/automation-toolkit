package jxl.read.biff;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import jxl.CellFeatures;
import jxl.CellType;
import jxl.NumberCell;
import jxl.biff.FormattingRecords;
import jxl.format.CellFormat;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class NumberValue implements NumberCell, CellFeaturesAccessor {
    private static DecimalFormat defaultFormat = new DecimalFormat("#.###");
    private CellFormat cellFormat;
    private int column;
    private CellFeatures features;
    private FormattingRecords formattingRecords;
    private int row;
    private SheetImpl sheet;
    private double value;
    private int xfIndex;
    private NumberFormat format = defaultFormat;
    private boolean initialized = false;

    public NumberValue(int i, int i2, double d2, int i3, FormattingRecords formattingRecords, SheetImpl sheetImpl) {
        this.row = i;
        this.column = i2;
        this.value = d2;
        this.xfIndex = i3;
        this.formattingRecords = formattingRecords;
        this.sheet = sheetImpl;
    }

    @Override // jxl.Cell
    public CellFeatures getCellFeatures() {
        return this.features;
    }

    @Override // jxl.Cell
    public CellFormat getCellFormat() {
        if (!this.initialized) {
            this.cellFormat = this.formattingRecords.getXFRecord(this.xfIndex);
            this.initialized = true;
        }
        return this.cellFormat;
    }

    @Override // jxl.Cell
    public final int getColumn() {
        return this.column;
    }

    @Override // jxl.Cell
    public String getContents() {
        return this.format.format(this.value);
    }

    @Override // jxl.NumberCell
    public NumberFormat getNumberFormat() {
        return this.format;
    }

    @Override // jxl.Cell
    public final int getRow() {
        return this.row;
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.NUMBER;
    }

    @Override // jxl.NumberCell
    public double getValue() {
        return this.value;
    }

    @Override // jxl.Cell
    public boolean isHidden() {
        ColumnInfoRecord columnInfo = this.sheet.getColumnInfo(this.column);
        if (columnInfo == null || columnInfo.getWidth() != 0) {
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
        this.features = cellFeatures;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void setNumberFormat(NumberFormat numberFormat) {
        if (numberFormat != null) {
            this.format = numberFormat;
        }
    }
}
