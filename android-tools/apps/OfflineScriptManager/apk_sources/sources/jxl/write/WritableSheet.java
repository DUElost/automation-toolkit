package jxl.write;

import jxl.CellView;
import jxl.Range;
import jxl.Sheet;
import jxl.format.CellFormat;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
/* loaded from: classes.dex */
public interface WritableSheet extends Sheet {
    void addCell(WritableCell writableCell);

    void addColumnPageBreak(int i);

    void addHyperlink(WritableHyperlink writableHyperlink);

    void addImage(WritableImage writableImage);

    void addRowPageBreak(int i);

    WritableImage getImage(int i);

    @Override // jxl.Sheet
    int getNumberOfImages();

    WritableCell getWritableCell(int i, int i2);

    WritableCell getWritableCell(String str);

    WritableHyperlink[] getWritableHyperlinks();

    void insertColumn(int i);

    void insertRow(int i);

    Range mergeCells(int i, int i2, int i3, int i4);

    void removeColumn(int i);

    void removeHyperlink(WritableHyperlink writableHyperlink);

    void removeHyperlink(WritableHyperlink writableHyperlink, boolean z);

    void removeImage(WritableImage writableImage);

    void removeRow(int i);

    void setColumnGroup(int i, int i2, boolean z);

    void setColumnView(int i, int i2);

    void setColumnView(int i, int i2, CellFormat cellFormat);

    void setColumnView(int i, CellView cellView);

    void setFooter(String str, String str2, String str3);

    void setHeader(String str, String str2, String str3);

    void setHidden(boolean z);

    void setName(String str);

    void setPageSetup(PageOrientation pageOrientation);

    void setPageSetup(PageOrientation pageOrientation, double d2, double d3);

    void setPageSetup(PageOrientation pageOrientation, PaperSize paperSize, double d2, double d3);

    void setProtected(boolean z);

    void setRowGroup(int i, int i2, boolean z);

    void setRowView(int i, int i2);

    void setRowView(int i, int i2, boolean z);

    void setRowView(int i, CellView cellView);

    void setRowView(int i, boolean z);

    void unmergeCells(Range range);

    void unsetColumnGroup(int i, int i2);

    void unsetRowGroup(int i, int i2);
}
