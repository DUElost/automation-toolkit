package jxl.biff;

import jxl.WorkbookSettings;
import jxl.biff.formula.ExternalSheet;
import jxl.biff.formula.FormulaException;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.read.biff.Record;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class DataValiditySettingsRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$biff$DataValiditySettingsRecord;
    private static Logger logger;
    private byte[] data;
    private DataValidation dataValidation;
    private DVParser dvParser;
    private ExternalSheet externalSheet;
    private WorkbookMethods workbook;
    private WorkbookSettings workbookSettings;

    static {
        Class cls = class$jxl$biff$DataValiditySettingsRecord;
        if (cls == null) {
            cls = class$("jxl.biff.DataValiditySettingsRecord");
            class$jxl$biff$DataValiditySettingsRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public DataValiditySettingsRecord(DVParser dVParser) {
        super(Type.DV);
        this.dvParser = dVParser;
    }

    DataValiditySettingsRecord(DataValiditySettingsRecord dataValiditySettingsRecord) {
        super(Type.DV);
        this.data = dataValiditySettingsRecord.getData();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DataValiditySettingsRecord(DataValiditySettingsRecord dataValiditySettingsRecord, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings) {
        super(Type.DV);
        this.workbook = workbookMethods;
        this.externalSheet = externalSheet;
        this.workbookSettings = workbookSettings;
        Assert.verify(workbookMethods != null);
        Assert.verify(externalSheet != null);
        byte[] bArr = new byte[dataValiditySettingsRecord.data.length];
        this.data = bArr;
        System.arraycopy(dataValiditySettingsRecord.data, 0, bArr, 0, bArr.length);
    }

    public DataValiditySettingsRecord(Record record, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings) {
        super(record);
        this.data = record.getData();
        this.externalSheet = externalSheet;
        this.workbook = workbookMethods;
        this.workbookSettings = workbookSettings;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void initialize() {
        if (this.dvParser == null) {
            this.dvParser = new DVParser(this.data, this.externalSheet, this.workbook, this.workbookSettings);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DVParser getDVParser() {
        return this.dvParser;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        DVParser dVParser = this.dvParser;
        return dVParser == null ? this.data : dVParser.getData();
    }

    public int getFirstColumn() {
        if (this.dvParser == null) {
            initialize();
        }
        return this.dvParser.getFirstColumn();
    }

    public int getFirstRow() {
        if (this.dvParser == null) {
            initialize();
        }
        return this.dvParser.getFirstRow();
    }

    public int getLastColumn() {
        if (this.dvParser == null) {
            initialize();
        }
        return this.dvParser.getLastColumn();
    }

    public int getLastRow() {
        if (this.dvParser == null) {
            initialize();
        }
        return this.dvParser.getLastRow();
    }

    public String getValidationFormula() {
        try {
            if (this.dvParser == null) {
                initialize();
            }
            return this.dvParser.getValidationFormula();
        } catch (FormulaException e) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Cannot read drop down range ");
            stringBuffer.append(e.getMessage());
            logger2.warn(stringBuffer.toString());
            return BuildConfig.FLAVOR;
        }
    }

    public void insertColumn(int i) {
        if (this.dvParser == null) {
            initialize();
        }
        this.dvParser.insertColumn(i);
    }

    public void insertRow(int i) {
        if (this.dvParser == null) {
            initialize();
        }
        this.dvParser.insertRow(i);
    }

    public void removeColumn(int i) {
        if (this.dvParser == null) {
            initialize();
        }
        this.dvParser.removeColumn(i);
    }

    public void removeRow(int i) {
        if (this.dvParser == null) {
            initialize();
        }
        this.dvParser.removeRow(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setDataValidation(DataValidation dataValidation) {
        this.dataValidation = dataValidation;
    }
}
