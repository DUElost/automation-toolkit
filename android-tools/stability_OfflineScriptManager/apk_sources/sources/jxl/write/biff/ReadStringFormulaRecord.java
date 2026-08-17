package jxl.write.biff;

import jxl.StringFormulaCell;
import jxl.biff.FormulaData;
import jxl.biff.IntegerHelper;
import jxl.biff.formula.FormulaException;
import jxl.biff.formula.FormulaParser;
import jxl.common.Assert;
import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class ReadStringFormulaRecord extends ReadFormulaRecord implements StringFormulaCell {
    static /* synthetic */ Class class$jxl$write$biff$ReadFormulaRecord;
    private static Logger logger;

    static {
        Class cls = class$jxl$write$biff$ReadFormulaRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.ReadFormulaRecord");
            class$jxl$write$biff$ReadFormulaRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public ReadStringFormulaRecord(FormulaData formulaData) {
        super(formulaData);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.LabelCell
    public String getString() {
        return ((StringFormulaCell) getReadFormula()).getString();
    }

    @Override // jxl.write.biff.ReadFormulaRecord
    protected byte[] handleFormulaException() {
        byte[] cellData = super.getCellData();
        WritableWorkbookImpl workbook = getSheet().getWorkbook();
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("\"");
        stringBuffer.append(getContents());
        stringBuffer.append("\"");
        FormulaParser formulaParser = new FormulaParser(stringBuffer.toString(), workbook, workbook, workbook.getSettings());
        try {
            formulaParser.parse();
        } catch (FormulaException e) {
            logger.warn(e.getMessage());
            formulaParser = new FormulaParser("\"ERROR\"", workbook, workbook, workbook.getSettings());
            try {
                formulaParser.parse();
            } catch (FormulaException unused) {
                Assert.verify(false);
            }
        }
        byte[] bytes = formulaParser.getBytes();
        int length = bytes.length + 16;
        byte[] bArr = new byte[length];
        IntegerHelper.getTwoBytes(bytes.length, bArr, 14);
        System.arraycopy(bytes, 0, bArr, 16, bytes.length);
        bArr[8] = (byte) (bArr[8] | 2);
        byte[] bArr2 = new byte[cellData.length + length];
        System.arraycopy(cellData, 0, bArr2, 0, cellData.length);
        System.arraycopy(bArr, 0, bArr2, cellData.length, length);
        bArr2[6] = 0;
        bArr2[12] = -1;
        bArr2[13] = -1;
        return bArr2;
    }
}
