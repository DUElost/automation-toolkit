package jxl.read.biff;

import jxl.CellType;
import jxl.WorkbookSettings;
import jxl.biff.DoubleHelper;
import jxl.biff.FormattingRecords;
import jxl.biff.IntegerHelper;
import jxl.biff.WorkbookMethods;
import jxl.biff.formula.ExternalSheet;
import jxl.common.Assert;
import jxl.common.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class FormulaRecord extends CellValue {
    static /* synthetic */ Class class$jxl$read$biff$FormulaRecord;
    public static final IgnoreSharedFormula ignoreSharedFormula;
    private static Logger logger;
    private CellValue formula;
    private boolean shared;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class IgnoreSharedFormula {
        private IgnoreSharedFormula() {
        }
    }

    static {
        Class cls = class$jxl$read$biff$FormulaRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.FormulaRecord");
            class$jxl$read$biff$FormulaRecord = cls;
        }
        logger = Logger.getLogger(cls);
        ignoreSharedFormula = new IgnoreSharedFormula();
    }

    public FormulaRecord(Record record, File file, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, IgnoreSharedFormula ignoreSharedFormula2, SheetImpl sheetImpl, WorkbookSettings workbookSettings) {
        super(record, formattingRecords, sheetImpl);
        byte[] data = getRecord().getData();
        this.shared = false;
        if (data[6] == 0 && data[12] == -1 && data[13] == -1) {
            this.formula = new StringFormulaRecord(record, file, formattingRecords, externalSheet, workbookMethods, sheetImpl, workbookSettings);
        } else {
            this.formula = (data[6] == 1 && data[12] == -1 && data[13] == -1) ? new BooleanFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl) : (data[6] == 2 && data[12] == -1 && data[13] == -1) ? new ErrorFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl) : new NumberFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl);
        }
    }

    public FormulaRecord(Record record, File file, FormattingRecords formattingRecords, ExternalSheet externalSheet, WorkbookMethods workbookMethods, SheetImpl sheetImpl, WorkbookSettings workbookSettings) {
        super(record, formattingRecords, sheetImpl);
        BaseSharedFormulaRecord baseSharedFormulaRecord;
        byte[] data = getRecord().getData();
        this.shared = false;
        if ((IntegerHelper.getInt(data[14], data[15]) & 8) == 0) {
            if (data[6] == 0 && data[12] == -1 && data[13] == -1) {
                this.formula = new StringFormulaRecord(record, file, formattingRecords, externalSheet, workbookMethods, sheetImpl, workbookSettings);
                return;
            } else {
                this.formula = (data[6] == 1 && data[12] == -1 && data[13] == -1) ? new BooleanFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl) : (data[6] == 2 && data[12] == -1 && data[13] == -1) ? new ErrorFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl) : (data[6] == 3 && data[12] == -1 && data[13] == -1) ? new StringFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl) : new NumberFormulaRecord(record, formattingRecords, externalSheet, workbookMethods, sheetImpl);
                return;
            }
        }
        this.shared = true;
        if (data[6] == 0 && data[12] == -1 && data[13] == -1) {
            baseSharedFormulaRecord = new SharedStringFormulaRecord(record, file, formattingRecords, externalSheet, workbookMethods, sheetImpl, workbookSettings);
        } else if (data[6] == 3 && data[12] == -1 && data[13] == -1) {
            baseSharedFormulaRecord = new SharedStringFormulaRecord(record, file, formattingRecords, externalSheet, workbookMethods, sheetImpl, SharedStringFormulaRecord.EMPTY_STRING);
        } else if (data[6] == 2 && data[12] == -1 && data[13] == -1) {
            baseSharedFormulaRecord = new SharedErrorFormulaRecord(record, file, data[8], formattingRecords, externalSheet, workbookMethods, sheetImpl);
        } else if (data[6] == 1 && data[12] == -1 && data[13] == -1) {
            baseSharedFormulaRecord = new SharedBooleanFormulaRecord(record, file, data[8] == 1, formattingRecords, externalSheet, workbookMethods, sheetImpl);
        } else {
            SharedNumberFormulaRecord sharedNumberFormulaRecord = new SharedNumberFormulaRecord(record, file, DoubleHelper.getIEEEDouble(data, 6), formattingRecords, externalSheet, workbookMethods, sheetImpl);
            sharedNumberFormulaRecord.setNumberFormat(formattingRecords.getNumberFormat(getXFIndex()));
            baseSharedFormulaRecord = sharedNumberFormulaRecord;
        }
        this.formula = baseSharedFormulaRecord;
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
        Assert.verify(false);
        return BuildConfig.FLAVOR;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final CellValue getFormula() {
        return this.formula;
    }

    @Override // jxl.Cell
    public CellType getType() {
        Assert.verify(false);
        return CellType.EMPTY;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean isShared() {
        return this.shared;
    }
}
