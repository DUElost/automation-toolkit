package jxl.write.biff;

import jxl.Cell;
import jxl.CellFeatures;
import jxl.Sheet;
import jxl.biff.FormattingRecords;
import jxl.biff.IntegerHelper;
import jxl.biff.NumFormatRecordsException;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.biff.XFRecord;
import jxl.biff.drawing.ComboBox;
import jxl.biff.drawing.Comment;
import jxl.biff.formula.FormulaException;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.format.CellFormat;
import jxl.write.WritableCell;
import jxl.write.WritableCellFeatures;
import jxl.write.WritableWorkbook;
/* loaded from: classes.dex */
public abstract class CellValue extends WritableRecordData implements WritableCell {
    static /* synthetic */ Class class$jxl$write$biff$CellValue;
    private static Logger logger;
    private int column;
    private boolean copied;
    private WritableCellFeatures features;
    private XFRecord format;
    private FormattingRecords formattingRecords;
    private boolean referenced;
    private int row;
    private WritableSheetImpl sheet;

    static {
        Class cls = class$jxl$write$biff$CellValue;
        if (cls == null) {
            cls = class$("jxl.write.biff.CellValue");
            class$jxl$write$biff$CellValue = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public CellValue(Type type, int i, int i2) {
        this(type, i, i2, WritableWorkbook.NORMAL_STYLE);
        this.copied = false;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public CellValue(Type type, int i, int i2, CellFormat cellFormat) {
        super(type);
        this.row = i2;
        this.column = i;
        this.format = (XFRecord) cellFormat;
        this.referenced = false;
        this.copied = false;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public CellValue(Type type, int i, int i2, CellValue cellValue) {
        super(type);
        this.row = i2;
        this.column = i;
        this.format = cellValue.format;
        this.referenced = false;
        this.copied = false;
        if (cellValue.features != null) {
            WritableCellFeatures writableCellFeatures = new WritableCellFeatures(cellValue.features);
            this.features = writableCellFeatures;
            writableCellFeatures.setWritableCell(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public CellValue(Type type, Cell cell) {
        this(type, cell.getColumn(), cell.getRow());
        this.copied = true;
        this.format = (XFRecord) cell.getCellFormat();
        if (cell.getCellFeatures() != null) {
            WritableCellFeatures writableCellFeatures = new WritableCellFeatures(cell.getCellFeatures());
            this.features = writableCellFeatures;
            writableCellFeatures.setWritableCell(this);
        }
    }

    private void addCellFormat() {
        Styles styles = this.sheet.getWorkbook().getStyles();
        XFRecord format = styles.getFormat(this.format);
        this.format = format;
        try {
            if (format.isInitialized()) {
                return;
            }
            this.formattingRecords.addStyle(this.format);
        } catch (NumFormatRecordsException unused) {
            logger.warn("Maximum number of format records exceeded.  Using default format.");
            this.format = styles.getNormalStyle();
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public final void addCellFeatures() {
        WritableCellFeatures writableCellFeatures = this.features;
        if (writableCellFeatures == null) {
            return;
        }
        if (this.copied) {
            this.copied = false;
            return;
        }
        if (writableCellFeatures.getComment() != null) {
            Comment comment = new Comment(this.features.getComment(), this.column, this.row);
            comment.setWidth(this.features.getCommentWidth());
            comment.setHeight(this.features.getCommentHeight());
            this.sheet.addDrawing(comment);
            this.sheet.getWorkbook().addDrawing(comment);
            this.features.setCommentDrawing(comment);
        }
        if (this.features.hasDataValidation()) {
            try {
                this.features.getDVParser().setCell(this.column, this.row, this.sheet.getWorkbook(), this.sheet.getWorkbook(), this.sheet.getWorkbookSettings());
            } catch (FormulaException e) {
                e.printStackTrace();
                Assert.verify(false);
            }
            this.sheet.addValidationCell(this);
            if (this.features.hasDropDown()) {
                if (this.sheet.getComboBox() == null) {
                    ComboBox comboBox = new ComboBox();
                    this.sheet.addDrawing(comboBox);
                    this.sheet.getWorkbook().addDrawing(comboBox);
                    this.sheet.setComboBox(comboBox);
                }
                this.features.setComboBox(this.sheet.getComboBox());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void columnInserted(Sheet sheet, int i, int i2) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void columnRemoved(Sheet sheet, int i, int i2) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void decrementColumn() {
        Comment commentDrawing;
        this.column--;
        WritableCellFeatures writableCellFeatures = this.features;
        if (writableCellFeatures == null || (commentDrawing = writableCellFeatures.getCommentDrawing()) == null) {
            return;
        }
        commentDrawing.setX(this.column);
        commentDrawing.setY(this.row);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void decrementRow() {
        this.row--;
        WritableCellFeatures writableCellFeatures = this.features;
        if (writableCellFeatures != null) {
            Comment commentDrawing = writableCellFeatures.getCommentDrawing();
            if (commentDrawing != null) {
                commentDrawing.setX(this.column);
                commentDrawing.setY(this.row);
            }
            if (this.features.hasDropDown()) {
                logger.warn("need to change value for drop down drawing");
            }
        }
    }

    @Override // jxl.Cell
    public CellFeatures getCellFeatures() {
        return this.features;
    }

    @Override // jxl.Cell
    public CellFormat getCellFormat() {
        return this.format;
    }

    @Override // jxl.Cell
    public int getColumn() {
        return this.column;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[6];
        IntegerHelper.getTwoBytes(this.row, bArr, 0);
        IntegerHelper.getTwoBytes(this.column, bArr, 2);
        IntegerHelper.getTwoBytes(this.format.getXFIndex(), bArr, 4);
        return bArr;
    }

    @Override // jxl.Cell
    public int getRow() {
        return this.row;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public WritableSheetImpl getSheet() {
        return this.sheet;
    }

    @Override // jxl.write.WritableCell
    public WritableCellFeatures getWritableCellFeatures() {
        return this.features;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int getXFIndex() {
        return this.format.getXFIndex();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void incrementColumn() {
        Comment commentDrawing;
        this.column++;
        WritableCellFeatures writableCellFeatures = this.features;
        if (writableCellFeatures == null || (commentDrawing = writableCellFeatures.getCommentDrawing()) == null) {
            return;
        }
        commentDrawing.setX(this.column);
        commentDrawing.setY(this.row);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void incrementRow() {
        Comment commentDrawing;
        this.row++;
        WritableCellFeatures writableCellFeatures = this.features;
        if (writableCellFeatures == null || (commentDrawing = writableCellFeatures.getCommentDrawing()) == null) {
            return;
        }
        commentDrawing.setX(this.column);
        commentDrawing.setY(this.row);
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

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean isReferenced() {
        return this.referenced;
    }

    public final void removeCellFeatures() {
        WritableCellFeatures writableCellFeatures = this.features;
        if (writableCellFeatures == null) {
            return;
        }
        writableCellFeatures.removeComment();
        this.features.removeDataValidation();
    }

    public final void removeComment(Comment comment) {
        this.sheet.removeDrawing(comment);
    }

    public final void removeDataValidation() {
        this.sheet.removeDataValidation(this);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rowInserted(Sheet sheet, int i, int i2) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void rowRemoved(Sheet sheet, int i, int i2) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setCellDetails(FormattingRecords formattingRecords, SharedStrings sharedStrings, WritableSheetImpl writableSheetImpl) {
        this.referenced = true;
        this.sheet = writableSheetImpl;
        this.formattingRecords = formattingRecords;
        addCellFormat();
        addCellFeatures();
    }

    @Override // jxl.write.WritableCell
    public void setCellFeatures(WritableCellFeatures writableCellFeatures) {
        if (this.features != null) {
            logger.warn("current cell features not null - overwriting");
        }
        this.features = writableCellFeatures;
        writableCellFeatures.setWritableCell(this);
        if (this.referenced) {
            addCellFeatures();
        }
    }

    @Override // jxl.write.WritableCell
    public void setCellFormat(CellFormat cellFormat) {
        this.format = (XFRecord) cellFormat;
        if (this.referenced) {
            Assert.verify(this.formattingRecords != null);
            addCellFormat();
        }
    }

    final void setCopied(boolean z) {
        this.copied = z;
    }
}
