package jxl.write.biff;

import java.util.ArrayList;
import java.util.Iterator;
import jxl.Cell;
import jxl.CellType;
import jxl.Range;
import jxl.biff.SheetRangeImpl;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.write.Blank;
import jxl.write.WritableSheet;
import jxl.write.WriteException;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class MergedCells {
    static /* synthetic */ Class class$jxl$write$biff$MergedCells = null;
    private static Logger logger = null;
    private static final int maxRangesPerSheet = 1020;
    private ArrayList ranges = new ArrayList();
    private WritableSheet sheet;

    static {
        Class cls = class$jxl$write$biff$MergedCells;
        if (cls == null) {
            cls = class$("jxl.write.biff.MergedCells");
            class$jxl$write$biff$MergedCells = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public MergedCells(WritableSheet writableSheet) {
        this.sheet = writableSheet;
    }

    private void checkIntersections() {
        ArrayList arrayList = new ArrayList(this.ranges.size());
        Iterator it = this.ranges.iterator();
        while (it.hasNext()) {
            SheetRangeImpl sheetRangeImpl = (SheetRangeImpl) it.next();
            Iterator it2 = arrayList.iterator();
            boolean z = false;
            while (it2.hasNext() && !z) {
                if (((SheetRangeImpl) it2.next()).intersects(sheetRangeImpl)) {
                    Logger logger2 = logger;
                    StringBuffer stringBuffer = new StringBuffer();
                    stringBuffer.append("Could not merge cells ");
                    stringBuffer.append(sheetRangeImpl);
                    stringBuffer.append(" as they clash with an existing set of merged cells.");
                    logger2.warn(stringBuffer.toString());
                    z = true;
                }
            }
            if (!z) {
                arrayList.add(sheetRangeImpl);
            }
        }
        this.ranges = arrayList;
    }

    private void checkRanges() {
        for (int i = 0; i < this.ranges.size(); i++) {
            try {
                SheetRangeImpl sheetRangeImpl = (SheetRangeImpl) this.ranges.get(i);
                Cell topLeft = sheetRangeImpl.getTopLeft();
                Cell bottomRight = sheetRangeImpl.getBottomRight();
                boolean z = false;
                for (int column = topLeft.getColumn(); column <= bottomRight.getColumn(); column++) {
                    for (int row = topLeft.getRow(); row <= bottomRight.getRow(); row++) {
                        if (this.sheet.getCell(column, row).getType() != CellType.EMPTY) {
                            if (z) {
                                Logger logger2 = logger;
                                StringBuffer stringBuffer = new StringBuffer();
                                stringBuffer.append("Range ");
                                stringBuffer.append(sheetRangeImpl);
                                stringBuffer.append(" contains more than one data cell.  ");
                                stringBuffer.append("Setting the other cells to blank.");
                                logger2.warn(stringBuffer.toString());
                                this.sheet.addCell(new Blank(column, row));
                            } else {
                                z = true;
                            }
                        }
                    }
                }
            } catch (WriteException unused) {
                Assert.verify(false);
                return;
            }
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void add(Range range) {
        this.ranges.add(range);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Range[] getMergedCells() {
        int size = this.ranges.size();
        Range[] rangeArr = new Range[size];
        for (int i = 0; i < size; i++) {
            rangeArr[i] = (Range) this.ranges.get(i);
        }
        return rangeArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void insertColumn(int i) {
        Iterator it = this.ranges.iterator();
        while (it.hasNext()) {
            ((SheetRangeImpl) it.next()).insertColumn(i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void insertRow(int i) {
        Iterator it = this.ranges.iterator();
        while (it.hasNext()) {
            ((SheetRangeImpl) it.next()).insertRow(i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeColumn(int i) {
        Iterator it = this.ranges.iterator();
        while (it.hasNext()) {
            SheetRangeImpl sheetRangeImpl = (SheetRangeImpl) it.next();
            if (sheetRangeImpl.getTopLeft().getColumn() == i && sheetRangeImpl.getBottomRight().getColumn() == i) {
                it.remove();
            } else {
                sheetRangeImpl.removeColumn(i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void removeRow(int i) {
        Iterator it = this.ranges.iterator();
        while (it.hasNext()) {
            SheetRangeImpl sheetRangeImpl = (SheetRangeImpl) it.next();
            if (sheetRangeImpl.getTopLeft().getRow() == i && sheetRangeImpl.getBottomRight().getRow() == i) {
                it.remove();
            } else {
                sheetRangeImpl.removeRow(i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void unmergeCells(Range range) {
        int indexOf = this.ranges.indexOf(range);
        if (indexOf != -1) {
            this.ranges.remove(indexOf);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void write(File file) {
        if (this.ranges.size() == 0) {
            return;
        }
        if (!((WritableSheetImpl) this.sheet).getWorkbookSettings().getMergedCellCheckingDisabled()) {
            checkIntersections();
            checkRanges();
        }
        if (this.ranges.size() < maxRangesPerSheet) {
            file.write(new MergedCellsRecord(this.ranges));
            return;
        }
        int size = (this.ranges.size() / maxRangesPerSheet) + 1;
        int i = 0;
        for (int i2 = 0; i2 < size; i2++) {
            int min = Math.min((int) maxRangesPerSheet, this.ranges.size() - i);
            ArrayList arrayList = new ArrayList(min);
            for (int i3 = 0; i3 < min; i3++) {
                arrayList.add(this.ranges.get(i + i3));
            }
            file.write(new MergedCellsRecord(arrayList));
            i += min;
        }
    }
}
