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
public class SharedStringFormulaRecord extends BaseSharedFormulaRecord implements LabelCell, FormulaData, StringFormulaCell {
    protected static final EmptyString EMPTY_STRING;
    static /* synthetic */ Class class$jxl$read$biff$SharedStringFormulaRecord;
    private static Logger logger;
    private String value;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class EmptyString {
        private EmptyString() {
        }
    }

    static {
        Class cls = class$jxl$read$biff$SharedStringFormulaRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.SharedStringFormulaRecord");
            class$jxl$read$biff$SharedStringFormulaRecord = cls;
        }
        logger = Logger.getLogger(cls);
        EMPTY_STRING = new EmptyString();
    }

    public SharedStringFormulaRecord(Record record, File file, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl, WorkbookSettings workbookSettings) {
        super(record, formattingRecords, externalSheet, workbookMethods, sheetImpl, file.getPos());
        int pos = file.getPos();
        int pos2 = file.getPos();
        Record next = file.next();
        boolean z = false;
        int i = 0;
        while (next.getType() != Type.STRING && i < 4) {
            next = file.next();
            i++;
        }
        boolean z2 = i < 4;
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(" @ ");
        stringBuffer.append(pos);
        Assert.verify(z2, stringBuffer.toString());
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
        int i2 = IntegerHelper.getInt(data[0], data[1]);
        int i3 = 3;
        if (data.length == i2 + 2) {
            i3 = 2;
        } else if (data[2] == 1) {
            z = true;
        }
        this.value = !z ? StringHelper.getString(data, i2, i3, workbookSettings) : StringHelper.getUnicodeString(data, i2, i3);
        file.setPos(pos2);
    }

    public SharedStringFormulaRecord(Record record, File file, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl, EmptyString emptyString) {
        super(record, formattingRecords, externalSheet, workbookMethods, sheetImpl, file.getPos());
        this.value = BuildConfig.FLAVOR;
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
        return this.value;
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
            bArr[6] = 0;
            bArr[12] = -1;
            bArr[13] = -1;
            System.arraycopy(bytes, 0, bArr, 22, bytes.length);
            IntegerHelper.getTwoBytes(bytes.length, bArr, 20);
            int i = length - 6;
            byte[] bArr2 = new byte[i];
            System.arraycopy(bArr, 6, bArr2, 0, i);
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
