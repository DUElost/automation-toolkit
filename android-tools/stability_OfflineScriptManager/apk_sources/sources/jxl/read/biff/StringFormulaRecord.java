package jxl.read.biff;

import jxl.CellType;
import jxl.LabelCell;
import jxl.StringFormulaCell;
import jxl.WorkbookSettings;
import jxl.biff.FormattingRecords;
import jxl.biff.FormulaData;
import jxl.biff.IntegerHelper;
import jxl.biff.StringHelper;
import jxl.biff.Type;
import jxl.biff.WorkbookMethods;
import jxl.biff.formula.ExternalSheet;
import jxl.biff.formula.FormulaException;
import jxl.biff.formula.FormulaParser;
import jxl.common.Assert;
import jxl.common.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
class StringFormulaRecord extends CellValue implements LabelCell, FormulaData, StringFormulaCell {
    static /* synthetic */ Class class$jxl$read$biff$StringFormulaRecord;
    private static Logger logger;
    private byte[] data;
    private ExternalSheet externalSheet;
    private String formulaString;
    private WorkbookMethods nameTable;
    private String value;

    static {
        Class cls = class$jxl$read$biff$StringFormulaRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.StringFormulaRecord");
            class$jxl$read$biff$StringFormulaRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public StringFormulaRecord(Record record, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl) {
        super(record, formattingRecords, sheetImpl);
        this.externalSheet = externalSheet;
        this.nameTable = workbookMethods;
        this.data = getRecord().getData();
        this.value = BuildConfig.FLAVOR;
    }

    public StringFormulaRecord(Record record, File file, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl, WorkbookSettings workbookSettings) {
        super(record, formattingRecords, sheetImpl);
        this.externalSheet = externalSheet;
        this.nameTable = workbookMethods;
        this.data = getRecord().getData();
        int pos = file.getPos();
        Record next = file.next();
        int i = 0;
        while (next.getType() != Type.STRING && i < 4) {
            next = file.next();
            i++;
        }
        boolean z = i < 4;
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(" @ ");
        stringBuffer.append(pos);
        Assert.verify(z, stringBuffer.toString());
        byte[] data = next.getData();
        Record peek = file.peek();
        while (peek.getType() == Type.CONTINUE) {
            Record next2 = file.next();
            byte[] bArr = new byte[(data.length + next2.getLength()) - 1];
            System.arraycopy(data, 0, bArr, 0, data.length);
            System.arraycopy(next2.getData(), 1, bArr, data.length, next2.getLength() - 1);
            peek = file.peek();
            data = bArr;
        }
        readString(data, workbookSettings);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void readString(byte[] bArr, WorkbookSettings workbookSettings) {
        int i = IntegerHelper.getInt(bArr[0], bArr[1]);
        if (i == 0) {
            this.value = BuildConfig.FLAVOR;
            return;
        }
        int i2 = 2;
        byte b2 = bArr[2];
        if ((b2 & 15) != b2) {
            i = IntegerHelper.getInt(bArr[0], (byte) 0);
            b2 = bArr[1];
        } else {
            i2 = 3;
        }
        boolean z = (b2 & 4) != 0;
        if ((b2 & 8) != 0) {
            i2 += 2;
        }
        if (z) {
            i2 += 4;
        }
        this.value = (b2 & 1) == 0 ? StringHelper.getString(bArr, i, i2, workbookSettings) : StringHelper.getUnicodeString(bArr, i, i2);
    }

    @Override // jxl.Cell
    public String getContents() {
        return this.value;
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
        if (getSheet().getWorkbook().getWorkbookBof().isBiff8()) {
            byte[] bArr = this.data;
            byte[] bArr2 = new byte[bArr.length - 6];
            System.arraycopy(bArr, 6, bArr2, 0, bArr.length - 6);
            return bArr2;
        }
        throw new FormulaException(FormulaException.BIFF8_SUPPORTED);
    }

    @Override // jxl.LabelCell
    public String getString() {
        return this.value;
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.STRING_FORMULA;
    }
}
