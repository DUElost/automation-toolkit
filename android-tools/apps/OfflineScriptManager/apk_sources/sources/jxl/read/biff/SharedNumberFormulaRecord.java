package jxl.read.biff;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import jxl.CellType;
import jxl.NumberCell;
import jxl.NumberFormulaCell;
import jxl.biff.DoubleHelper;
import jxl.biff.FormattingRecords;
import jxl.biff.FormulaData;
import jxl.biff.IntegerHelper;
import jxl.biff.WorkbookMethods;
import jxl.biff.formula.ExternalSheet;
import jxl.biff.formula.FormulaException;
import jxl.biff.formula.FormulaParser;
import jxl.common.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class SharedNumberFormulaRecord extends BaseSharedFormulaRecord implements NumberCell, FormulaData, NumberFormulaCell {
    static /* synthetic */ Class class$jxl$read$biff$SharedNumberFormulaRecord;
    private static DecimalFormat defaultFormat;
    private static Logger logger;
    private NumberFormat format;
    private FormattingRecords formattingRecords;
    private double value;

    static {
        Class cls = class$jxl$read$biff$SharedNumberFormulaRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.SharedNumberFormulaRecord");
            class$jxl$read$biff$SharedNumberFormulaRecord = cls;
        }
        logger = Logger.getLogger(cls);
        defaultFormat = new DecimalFormat("#.###");
    }

    public SharedNumberFormulaRecord(Record record, File file, double d2, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl) {
        super(record, formattingRecords, externalSheet, workbookMethods, sheetImpl, file.getPos());
        this.value = d2;
        this.format = defaultFormat;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.Cell
    public String getContents() {
        return !Double.isNaN(this.value) ? this.format.format(this.value) : BuildConfig.FLAVOR;
    }

    @Override // jxl.biff.FormulaData
    public byte[] getFormulaData() {
        if (getSheet().getWorkbookBof().isBiff8()) {
            FormulaParser formulaParser = new FormulaParser(getTokens(), this, getExternalSheet(), getNameTable(), getSheet().getWorkbook().getSettings());
            formulaParser.parse();
            byte[] bytes = formulaParser.getBytes();
            int length = bytes.length + 22;
            byte[] bArr = new byte[length];
            IntegerHelper.getTwoBytes(getRow(), bArr, 0);
            IntegerHelper.getTwoBytes(getColumn(), bArr, 2);
            IntegerHelper.getTwoBytes(getXFIndex(), bArr, 4);
            DoubleHelper.getIEEEBytes(this.value, bArr, 6);
            System.arraycopy(bytes, 0, bArr, 22, bytes.length);
            IntegerHelper.getTwoBytes(bytes.length, bArr, 20);
            int i = length - 6;
            byte[] bArr2 = new byte[i];
            System.arraycopy(bArr, 6, bArr2, 0, i);
            return bArr2;
        }
        throw new FormulaException(FormulaException.BIFF8_SUPPORTED);
    }

    @Override // jxl.NumberCell
    public NumberFormat getNumberFormat() {
        return this.format;
    }

    @Override // jxl.Cell
    public CellType getType() {
        return CellType.NUMBER_FORMULA;
    }

    @Override // jxl.NumberCell
    public double getValue() {
        return this.value;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void setNumberFormat(NumberFormat numberFormat) {
        if (numberFormat != null) {
            this.format = numberFormat;
        }
    }
}
