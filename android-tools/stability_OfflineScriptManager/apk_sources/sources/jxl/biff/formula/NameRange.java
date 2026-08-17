package jxl.biff.formula;

import jxl.biff.IntegerHelper;
import jxl.biff.NameRangeException;
import jxl.biff.WorkbookMethods;
import jxl.common.Assert;
import jxl.common.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
class NameRange extends Operand implements ParsedThing {
    static /* synthetic */ Class class$jxl$biff$formula$NameRange;
    private static Logger logger;
    private int index;
    private String name;
    private WorkbookMethods nameTable;

    static {
        Class cls = class$jxl$biff$formula$NameRange;
        if (cls == null) {
            cls = class$("jxl.biff.formula.NameRange");
            class$jxl$biff$formula$NameRange = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public NameRange(String str, WorkbookMethods workbookMethods) {
        this.name = str;
        this.nameTable = workbookMethods;
        int nameIndex = workbookMethods.getNameIndex(str);
        this.index = nameIndex;
        if (nameIndex < 0) {
            throw new FormulaException(FormulaException.CELL_NAME_NOT_FOUND, this.name);
        }
        this.index = nameIndex + 1;
    }

    public NameRange(WorkbookMethods workbookMethods) {
        this.nameTable = workbookMethods;
        Assert.verify(workbookMethods != null);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public byte[] getBytes() {
        byte[] bArr = new byte[5];
        Token token = Token.NAMED_RANGE;
        bArr[0] = token.getValueCode();
        if (getParseContext() == ParseContext.DATA_VALIDATION) {
            bArr[0] = token.getReferenceCode();
        }
        IntegerHelper.getTwoBytes(this.index, bArr, 1);
        return bArr;
    }

    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        stringBuffer.append(this.name);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
        setInvalid();
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        try {
            int i2 = IntegerHelper.getInt(bArr[i], bArr[i + 1]);
            this.index = i2;
            this.name = this.nameTable.getName(i2 - 1);
            return 4;
        } catch (NameRangeException unused) {
            throw new FormulaException(FormulaException.CELL_NAME_NOT_FOUND, BuildConfig.FLAVOR);
        }
    }
}
