package jxl.biff;

import jxl.Cell;
import jxl.Range;
import jxl.Sheet;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class RangeImpl implements Range {
    static /* synthetic */ Class class$jxl$biff$RangeImpl;
    private static Logger logger;
    private int column1;
    private int column2;
    private int row1;
    private int row2;
    private int sheet1;
    private int sheet2;
    private WorkbookMethods workbook;

    static {
        Class cls = class$jxl$biff$RangeImpl;
        if (cls == null) {
            cls = class$("jxl.biff.RangeImpl");
            class$jxl$biff$RangeImpl = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public RangeImpl(WorkbookMethods workbookMethods, int i, int i2, int i3, int i4, int i5, int i6) {
        this.workbook = workbookMethods;
        this.sheet1 = i;
        this.sheet2 = i4;
        this.row1 = i3;
        this.row2 = i6;
        this.column1 = i2;
        this.column2 = i5;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.Range
    public Cell getBottomRight() {
        Sheet readSheet = this.workbook.getReadSheet(this.sheet2);
        return (this.column2 >= readSheet.getColumns() || this.row2 >= readSheet.getRows()) ? new EmptyCell(this.column2, this.row2) : readSheet.getCell(this.column2, this.row2);
    }

    @Override // jxl.Range
    public int getFirstSheetIndex() {
        return this.sheet1;
    }

    @Override // jxl.Range
    public int getLastSheetIndex() {
        return this.sheet2;
    }

    @Override // jxl.Range
    public Cell getTopLeft() {
        Sheet readSheet = this.workbook.getReadSheet(this.sheet1);
        return (this.column1 >= readSheet.getColumns() || this.row1 >= readSheet.getRows()) ? new EmptyCell(this.column1, this.row1) : readSheet.getCell(this.column1, this.row1);
    }
}
