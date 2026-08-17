package jxl.read.biff;

import java.text.NumberFormat;
import jxl.CellType;
import jxl.DateCell;
import jxl.DateFormulaCell;
import jxl.biff.FormattingRecords;
import jxl.biff.FormulaData;
import jxl.biff.WorkbookMethods;
import jxl.biff.formula.ExternalSheet;
import jxl.biff.formula.FormulaException;
import jxl.biff.formula.FormulaParser;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class DateFormulaRecord extends DateRecord implements DateCell, FormulaData, DateFormulaCell {
    private byte[] data;
    private ExternalSheet externalSheet;
    private String formulaString;
    private WorkbookMethods nameTable;

    public DateFormulaRecord(NumberFormulaRecord numberFormulaRecord, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, boolean z, SheetImpl sheetImpl) {
        super(numberFormulaRecord, numberFormulaRecord.getXFIndex(), formattingRecords, z, sheetImpl);
        this.externalSheet = externalSheet;
        this.nameTable = workbookMethods;
        this.data = numberFormulaRecord.getFormulaData();
    }

    @Override // jxl.FormulaCell
    public String getFormula() {
        if (this.formulaString == null) {
            byte[] bArr = this.data;
            int length = bArr.length - 16;
            byte[] bArr2 = new byte[length];
            System.arraycopy(bArr, 16, bArr2, 0, length);
            FormulaParser formulaParser = new FormulaParser(bArr2, this, this.externalSheet, this.nameTable, getSheet().getWorkbook().getSettings());
            formulaParser.parse();
            this.formulaString = formulaParser.getFormula();
        }
        return this.formulaString;
    }

    @Override // jxl.biff.FormulaData
    public byte[] getFormulaData() {
        if (getSheet().getWorkbookBof().isBiff8()) {
            return this.data;
        }
        throw new FormulaException(FormulaException.BIFF8_SUPPORTED);
    }

    public NumberFormat getNumberFormat() {
        return null;
    }

    @Override // jxl.read.biff.DateRecord, jxl.Cell
    public CellType getType() {
        return CellType.DATE_FORMULA;
    }

    public double getValue() {
        return 0.0d;
    }
}
