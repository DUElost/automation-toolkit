package jxl;

import java.io.File;
import java.util.HashMap;
import java.util.Locale;
import jxl.biff.CountryCode;
import jxl.biff.formula.FunctionNames;
import jxl.common.Logger;
/* loaded from: classes.dex */
public final class WorkbookSettings {
    private static final int DEFAULT_ARRAY_GROW_SIZE = 1048576;
    private static final int DEFAULT_INITIAL_FILE_SIZE = 5242880;
    public static final int HIDEOBJ_HIDE_ALL = 2;
    public static final int HIDEOBJ_SHOW_ALL = 0;
    public static final int HIDEOBJ_SHOW_PLACEHOLDERS = 1;
    static /* synthetic */ Class class$jxl$WorkbookSettings;
    private static Logger logger;
    private boolean autoFilterDisabled;
    private boolean cellValidationDisabled;
    private int characterSet;
    private boolean drawingsDisabled;
    private String encoding;
    private boolean excel9file;
    private boolean formulaReferenceAdjustDisabled;
    private FunctionNames functionNames;
    private boolean gcDisabled;
    private boolean ignoreBlankCells;
    private Locale locale;
    private boolean mergedCellCheckingDisabled;
    private boolean namesDisabled;
    private boolean propertySetsDisabled;
    private boolean rationalizationDisabled;
    private File temporaryFileDuringWriteDirectory;
    private boolean useTemporaryFileDuringWrite;
    private String writeAccess;
    private int initialFileSize = DEFAULT_INITIAL_FILE_SIZE;
    private int arrayGrowSize = DEFAULT_ARRAY_GROW_SIZE;
    private HashMap localeFunctionNames = new HashMap();
    private String excelDisplayLanguage = CountryCode.USA.getCode();
    private String excelRegionalSettings = CountryCode.UK.getCode();
    private boolean refreshAll = false;
    private boolean template = false;
    private boolean windowProtected = false;
    private int hideobj = 0;

    static {
        Class cls = class$jxl$WorkbookSettings;
        if (cls == null) {
            cls = class$("jxl.WorkbookSettings");
            class$jxl$WorkbookSettings = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX WARN: Removed duplicated region for block: B:22:0x00e2 A[Catch: SecurityException -> 0x00e9, TRY_LEAVE, TryCatch #1 {SecurityException -> 0x00e9, blocks: (B:13:0x00b9, B:15:0x00bf, B:18:0x00c6, B:20:0x00dc, B:22:0x00e2, B:19:0x00d6), top: B:29:0x00b9 }] */
    /* JADX WARN: Removed duplicated region for block: B:31:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public WorkbookSettings() {
        /*
            r6 = this;
            java.lang.String r0 = "jxl.encoding"
            java.lang.String r1 = "jxl.country"
            java.lang.String r2 = "jxl.lang"
            java.lang.String r3 = "Error accessing system properties."
            r6.<init>()
            r4 = 0
            r6.excel9file = r4
            r5 = 5242880(0x500000, float:7.34684E-39)
            r6.initialFileSize = r5
            r5 = 1048576(0x100000, float:1.469368E-39)
            r6.arrayGrowSize = r5
            java.util.HashMap r5 = new java.util.HashMap
            r5.<init>()
            r6.localeFunctionNames = r5
            jxl.biff.CountryCode r5 = jxl.biff.CountryCode.USA
            java.lang.String r5 = r5.getCode()
            r6.excelDisplayLanguage = r5
            jxl.biff.CountryCode r5 = jxl.biff.CountryCode.UK
            java.lang.String r5 = r5.getCode()
            r6.excelRegionalSettings = r5
            r6.refreshAll = r4
            r6.template = r4
            r6.excel9file = r4
            r6.windowProtected = r4
            r6.hideobj = r4
            java.lang.String r5 = "jxl.nowarnings"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.setSuppressWarnings(r5)     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.nodrawings"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.drawingsDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.nonames"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.namesDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.nogc"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.gcDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.norat"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.rationalizationDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.nomergedcellchecks"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.mergedCellCheckingDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.noformulaadjust"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.formulaReferenceAdjustDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.nopropertysets"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.propertySetsDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.ignoreblanks"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.ignoreBlankCells = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.nocellvalidation"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            r6.cellValidationDisabled = r5     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r5 = "jxl.autofilter"
            boolean r5 = java.lang.Boolean.getBoolean(r5)     // Catch: java.lang.SecurityException -> Lb3
            if (r5 != 0) goto L91
            r4 = 1
        L91:
            r6.autoFilterDisabled = r4     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r4 = "jxl.usetemporaryfileduringwrite"
            boolean r4 = java.lang.Boolean.getBoolean(r4)     // Catch: java.lang.SecurityException -> Lb3
            r6.useTemporaryFileDuringWrite = r4     // Catch: java.lang.SecurityException -> Lb3
            java.lang.String r4 = "jxl.temporaryfileduringwritedirectory"
            java.lang.String r4 = java.lang.System.getProperty(r4)     // Catch: java.lang.SecurityException -> Lb3
            if (r4 == 0) goto Laa
            java.io.File r5 = new java.io.File     // Catch: java.lang.SecurityException -> Lb3
            r5.<init>(r4)     // Catch: java.lang.SecurityException -> Lb3
            r6.temporaryFileDuringWriteDirectory = r5     // Catch: java.lang.SecurityException -> Lb3
        Laa:
            java.lang.String r4 = "file.encoding"
            java.lang.String r4 = java.lang.System.getProperty(r4)     // Catch: java.lang.SecurityException -> Lb3
            r6.encoding = r4     // Catch: java.lang.SecurityException -> Lb3
            goto Lb9
        Lb3:
            r4 = move-exception
            jxl.common.Logger r5 = jxl.WorkbookSettings.logger
            r5.warn(r3, r4)
        Lb9:
            java.lang.String r4 = java.lang.System.getProperty(r2)     // Catch: java.lang.SecurityException -> Le9
            if (r4 == 0) goto Ld6
            java.lang.String r4 = java.lang.System.getProperty(r1)     // Catch: java.lang.SecurityException -> Le9
            if (r4 != 0) goto Lc6
            goto Ld6
        Lc6:
            java.util.Locale r4 = new java.util.Locale     // Catch: java.lang.SecurityException -> Le9
            java.lang.String r2 = java.lang.System.getProperty(r2)     // Catch: java.lang.SecurityException -> Le9
            java.lang.String r1 = java.lang.System.getProperty(r1)     // Catch: java.lang.SecurityException -> Le9
            r4.<init>(r2, r1)     // Catch: java.lang.SecurityException -> Le9
            r6.locale = r4     // Catch: java.lang.SecurityException -> Le9
            goto Ldc
        Ld6:
            java.util.Locale r1 = java.util.Locale.getDefault()     // Catch: java.lang.SecurityException -> Le9
            r6.locale = r1     // Catch: java.lang.SecurityException -> Le9
        Ldc:
            java.lang.String r1 = java.lang.System.getProperty(r0)     // Catch: java.lang.SecurityException -> Le9
            if (r1 == 0) goto Lf5
            java.lang.String r0 = java.lang.System.getProperty(r0)     // Catch: java.lang.SecurityException -> Le9
            r6.encoding = r0     // Catch: java.lang.SecurityException -> Le9
            goto Lf5
        Le9:
            r0 = move-exception
            jxl.common.Logger r1 = jxl.WorkbookSettings.logger
            r1.warn(r3, r0)
            java.util.Locale r0 = java.util.Locale.getDefault()
            r6.locale = r0
        Lf5:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.WorkbookSettings.<init>():void");
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public int getArrayGrowSize() {
        return this.arrayGrowSize;
    }

    public boolean getAutoFilterDisabled() {
        return this.autoFilterDisabled;
    }

    public boolean getCellValidationDisabled() {
        return this.cellValidationDisabled;
    }

    public int getCharacterSet() {
        return this.characterSet;
    }

    public boolean getDrawingsDisabled() {
        return this.drawingsDisabled;
    }

    public String getEncoding() {
        return this.encoding;
    }

    public boolean getExcel9File() {
        return this.excel9file;
    }

    public String getExcelDisplayLanguage() {
        return this.excelDisplayLanguage;
    }

    public String getExcelRegionalSettings() {
        return this.excelRegionalSettings;
    }

    public boolean getFormulaAdjust() {
        return !this.formulaReferenceAdjustDisabled;
    }

    public FunctionNames getFunctionNames() {
        if (this.functionNames == null) {
            FunctionNames functionNames = (FunctionNames) this.localeFunctionNames.get(this.locale);
            this.functionNames = functionNames;
            if (functionNames == null) {
                FunctionNames functionNames2 = new FunctionNames(this.locale);
                this.functionNames = functionNames2;
                this.localeFunctionNames.put(this.locale, functionNames2);
            }
        }
        return this.functionNames;
    }

    public boolean getGCDisabled() {
        return this.gcDisabled;
    }

    public int getHideobj() {
        return this.hideobj;
    }

    public boolean getIgnoreBlanks() {
        return this.ignoreBlankCells;
    }

    public int getInitialFileSize() {
        return this.initialFileSize;
    }

    public Locale getLocale() {
        return this.locale;
    }

    public boolean getMergedCellCheckingDisabled() {
        return this.mergedCellCheckingDisabled;
    }

    public boolean getNamesDisabled() {
        return this.namesDisabled;
    }

    public boolean getPropertySetsDisabled() {
        return this.propertySetsDisabled;
    }

    public boolean getRationalizationDisabled() {
        return this.rationalizationDisabled;
    }

    public boolean getRefreshAll() {
        return this.refreshAll;
    }

    public boolean getTemplate() {
        return this.template;
    }

    public File getTemporaryFileDuringWriteDirectory() {
        return this.temporaryFileDuringWriteDirectory;
    }

    public boolean getUseTemporaryFileDuringWrite() {
        return this.useTemporaryFileDuringWrite;
    }

    public boolean getWindowProtected() {
        return this.windowProtected;
    }

    public String getWriteAccess() {
        return this.writeAccess;
    }

    public void setArrayGrowSize(int i) {
        this.arrayGrowSize = i;
    }

    public void setAutoFilterDisabled(boolean z) {
        this.autoFilterDisabled = z;
    }

    public void setCellValidationDisabled(boolean z) {
        this.cellValidationDisabled = z;
    }

    public void setCharacterSet(int i) {
        this.characterSet = i;
    }

    public void setDrawingsDisabled(boolean z) {
        this.drawingsDisabled = z;
    }

    public void setEncoding(String str) {
        this.encoding = str;
    }

    public void setExcel9File(boolean z) {
        this.excel9file = z;
    }

    public void setExcelDisplayLanguage(String str) {
        this.excelDisplayLanguage = str;
    }

    public void setExcelRegionalSettings(String str) {
        this.excelRegionalSettings = str;
    }

    public void setFormulaAdjust(boolean z) {
        this.formulaReferenceAdjustDisabled = !z;
    }

    public void setGCDisabled(boolean z) {
        this.gcDisabled = z;
    }

    public void setHideobj(int i) {
        this.hideobj = i;
    }

    public void setIgnoreBlanks(boolean z) {
        this.ignoreBlankCells = z;
    }

    public void setInitialFileSize(int i) {
        this.initialFileSize = i;
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    public void setMergedCellChecking(boolean z) {
        this.mergedCellCheckingDisabled = !z;
    }

    public void setNamesDisabled(boolean z) {
        this.namesDisabled = z;
    }

    public void setPropertySets(boolean z) {
        this.propertySetsDisabled = !z;
    }

    public void setRationalization(boolean z) {
        this.rationalizationDisabled = !z;
    }

    public void setRefreshAll(boolean z) {
        this.refreshAll = z;
    }

    public void setSuppressWarnings(boolean z) {
        logger.setSuppressWarnings(z);
    }

    public void setTemplate(boolean z) {
        this.template = z;
    }

    public void setTemporaryFileDuringWriteDirectory(File file) {
        this.temporaryFileDuringWriteDirectory = file;
    }

    public void setUseTemporaryFileDuringWrite(boolean z) {
        this.useTemporaryFileDuringWrite = z;
    }

    public void setWindowProtected(boolean z) {
        this.windowProtected = this.windowProtected;
    }

    public void setWriteAccess(String str) {
        this.writeAccess = str;
    }
}
