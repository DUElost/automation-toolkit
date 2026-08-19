package jxl.biff;

import java.util.regex.Pattern;
import jxl.Cell;
import jxl.CellType;
import jxl.LabelCell;
import jxl.Sheet;
/* loaded from: classes.dex */
public class CellFinder {
    private Sheet sheet;

    public CellFinder(Sheet sheet) {
        this.sheet = sheet;
    }

    public Cell findCell(String str) {
        Cell cell = null;
        boolean z = false;
        for (int i = 0; i < this.sheet.getRows() && !z; i++) {
            Cell[] row = this.sheet.getRow(i);
            for (int i2 = 0; i2 < row.length && !z; i2++) {
                if (row[i2].getContents().equals(str)) {
                    cell = row[i2];
                    z = true;
                }
            }
        }
        return cell;
    }

    public Cell findCell(String str, int i, int i2, int i3, int i4, boolean z) {
        int i5 = i3 - i;
        int i6 = i4 - i2;
        if (z) {
            i2 = i4;
        }
        if (z) {
            i = i3;
        }
        int i7 = z ? -1 : 1;
        Cell cell = null;
        boolean z2 = false;
        for (int i8 = 0; i8 <= i5 && !z2; i8++) {
            for (int i9 = 0; i9 <= i6 && !z2; i9++) {
                int i10 = (i8 * i7) + i;
                int i11 = (i9 * i7) + i2;
                if (i10 < this.sheet.getColumns() && i11 < this.sheet.getRows()) {
                    Cell cell2 = this.sheet.getCell(i10, i11);
                    if (cell2.getType() != CellType.EMPTY && cell2.getContents().equals(str)) {
                        z2 = true;
                        cell = cell2;
                    }
                }
            }
        }
        return cell;
    }

    public Cell findCell(Pattern pattern, int i, int i2, int i3, int i4, boolean z) {
        int i5 = i3 - i;
        int i6 = i4 - i2;
        if (z) {
            i2 = i4;
        }
        if (z) {
            i = i3;
        }
        int i7 = z ? -1 : 1;
        Cell cell = null;
        boolean z2 = false;
        for (int i8 = 0; i8 <= i5 && !z2; i8++) {
            for (int i9 = 0; i9 <= i6 && !z2; i9++) {
                int i10 = (i8 * i7) + i;
                int i11 = (i9 * i7) + i2;
                if (i10 < this.sheet.getColumns() && i11 < this.sheet.getRows()) {
                    Cell cell2 = this.sheet.getCell(i10, i11);
                    if (cell2.getType() != CellType.EMPTY && pattern.matcher(cell2.getContents()).matches()) {
                        z2 = true;
                        cell = cell2;
                    }
                }
            }
        }
        return cell;
    }

    public LabelCell findLabelCell(String str) {
        LabelCell labelCell = null;
        boolean z = false;
        for (int i = 0; i < this.sheet.getRows() && !z; i++) {
            Cell[] row = this.sheet.getRow(i);
            for (int i2 = 0; i2 < row.length && !z; i2++) {
                if ((row[i2].getType() == CellType.LABEL || row[i2].getType() == CellType.STRING_FORMULA) && row[i2].getContents().equals(str)) {
                    labelCell = (LabelCell) row[i2];
                    z = true;
                }
            }
        }
        return labelCell;
    }
}
