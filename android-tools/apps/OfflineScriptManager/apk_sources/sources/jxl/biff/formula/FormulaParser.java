package jxl.biff.formula;

import jxl.Cell;
import jxl.WorkbookSettings;
import jxl.biff.WorkbookMethods;
import jxl.common.Assert;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class FormulaParser {
    static /* synthetic */ Class class$jxl$biff$formula$FormulaParser;
    private static final Logger logger;
    private Parser parser;

    static {
        Class cls = class$jxl$biff$formula$FormulaParser;
        if (cls == null) {
            cls = class$("jxl.biff.formula.FormulaParser");
            class$jxl$biff$formula$FormulaParser = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public FormulaParser(String str, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings) {
        this.parser = new StringFormulaParser(str, externalSheet, workbookMethods, workbookSettings, ParseContext.DEFAULT);
    }

    public FormulaParser(String str, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings, ParseContext parseContext) {
        this.parser = new StringFormulaParser(str, externalSheet, workbookMethods, workbookSettings, parseContext);
    }

    public FormulaParser(byte[] bArr, Cell cell, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings) {
        if (externalSheet.getWorkbookBof() != null && !externalSheet.getWorkbookBof().isBiff8()) {
            throw new FormulaException(FormulaException.BIFF8_SUPPORTED);
        }
        Assert.verify(workbookMethods != null);
        this.parser = new TokenFormulaParser(bArr, cell, externalSheet, workbookMethods, workbookSettings);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public void adjustRelativeCellReferences(int i, int i2) {
        this.parser.adjustRelativeCellReferences(i, i2);
    }

    public void columnInserted(int i, int i2, boolean z) {
        this.parser.columnInserted(i, i2, z);
    }

    public void columnRemoved(int i, int i2, boolean z) {
        this.parser.columnRemoved(i, i2, z);
    }

    public byte[] getBytes() {
        return this.parser.getBytes();
    }

    public String getFormula() {
        return this.parser.getFormula();
    }

    public boolean handleImportedCellReferences() {
        return this.parser.handleImportedCellReferences();
    }

    public void parse() {
        this.parser.parse();
    }

    public void rowInserted(int i, int i2, boolean z) {
        this.parser.rowInserted(i, i2, z);
    }

    public void rowRemoved(int i, int i2, boolean z) {
        this.parser.rowRemoved(i, i2, z);
    }
}
