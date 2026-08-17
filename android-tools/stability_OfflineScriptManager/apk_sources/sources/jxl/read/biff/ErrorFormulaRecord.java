package jxl.read.biff;

import jxl.CellType;
import jxl.ErrorCell;
import jxl.ErrorFormulaCell;
import jxl.biff.FormattingRecords;
import jxl.biff.FormulaData;
import jxl.biff.WorkbookMethods;
import jxl.biff.formula.ExternalSheet;
import jxl.biff.formula.FormulaErrorCode;
import jxl.biff.formula.FormulaException;
import jxl.biff.formula.FormulaParser;
import jxl.common.Assert;
/* loaded from: classes.dex */
class ErrorFormulaRecord extends CellValue implements ErrorCell, FormulaData, ErrorFormulaCell {
    private byte[] data;
    private FormulaErrorCode error;
    private int errorCode;
    private ExternalSheet externalSheet;
    private String formulaString;
    private WorkbookMethods nameTable;

    public ErrorFormulaRecord(Record record, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl) {
        super(record, formattingRecords, sheetImpl);
        this.externalSheet = externalSheet;
        this.nameTable = workbookMethods;
        byte[] data = getRecord().getData();
        this.data = data;
        Assert.verify(data[6] == 2);
        this.errorCode = this.data[8];
    }

    @Override // jxl.Cell
    public String getContents() {
        if (this.error == null) {
            this.error = FormulaErrorCode.getErrorCode(this.errorCode);
        }
        FormulaErrorCode formulaErrorCode = this.error;
        if (formulaErrorCode != FormulaErrorCode.UNKNOWN) {
            return formulaErrorCode.getDescription();
        }
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("ERROR ");
        stringBuffer.append(this.errorCode);
        return stringBuffer.toString();
    }

    @Override // jxl.ErrorCell
    public int getErrorCode() {
        return this.errorCode;
    }

    @Override // jxl.FormulaCell
    public String getFormula() {
        if (this.formulaString == null) {
            byte[] bArr = this.data;
            int length = bArr.length - 22;
            byte[] bArr2 = new byte[length];
            System.arraycopy(bArr, 22, bArr2, 0, length);
            FormulaParser formulaParser = new FormulaParser(bArr2, this, this.externalSheet, this.nameTable, getSheet().getWorkbook().getSettings());
            formulaParser.parse();
            this.formulaString = formulaParser.getFormula();
        }
        return this.formulaString;
    }

    @Override // jxl.biff.FormulaData
    public byte[] getFormulaData() {
        if (getSheet().getWorkbookBof().isBiff8()) {
            byte[] bArr = this.data;
            byte[] bArr2 = new byte[bArr.length - 6];
            System.arraycopy(bArr, 6, bArr2, 0, bArr.length - 6);
            return bArr2;
        }
        throw new FormulaException(FormulaException.BIFF8_SUPPORTED);
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.FORMULA_ERROR;
    }
}
