package jxl.biff.formula;

import jxl.common.Logger;
/* loaded from: classes.dex */
abstract class ParseItem {
    static /* synthetic */ Class class$jxl$biff$formula$ParseItem;
    private static Logger logger;
    private ParseItem parent;
    private boolean volatileFunction = false;
    private boolean alternateCode = false;
    private boolean valid = true;
    private ParseContext parseContext = ParseContext.DEFAULT;

    static {
        Class cls = class$jxl$biff$formula$ParseItem;
        if (cls == null) {
            cls = class$("jxl.biff.formula.ParseItem");
            class$jxl$biff$formula$ParseItem = cls;
        }
        logger = Logger.getLogger(cls);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void adjustRelativeCellReferences(int i, int i2);

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void columnInserted(int i, int i2, boolean z);

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void columnRemoved(int i, int i2, boolean z);

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract byte[] getBytes();

    /* JADX INFO: Access modifiers changed from: protected */
    public final ParseContext getParseContext() {
        return this.parseContext;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void getString(StringBuffer stringBuffer);

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void handleImportedCellReferences();

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean isValid() {
        return this.valid;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean isVolatile() {
        return this.volatileFunction;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void rowInserted(int i, int i2, boolean z);

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void rowRemoved(int i, int i2, boolean z);

    /* JADX INFO: Access modifiers changed from: protected */
    public void setAlternateCode() {
        this.alternateCode = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setInvalid() {
        this.valid = false;
        ParseItem parseItem = this.parent;
        if (parseItem != null) {
            parseItem.setInvalid();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setParent(ParseItem parseItem) {
        this.parent = parseItem;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setParseContext(ParseContext parseContext) {
        this.parseContext = parseContext;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setVolatile() {
        this.volatileFunction = true;
        ParseItem parseItem = this.parent;
        if (parseItem == null || parseItem.isVolatile()) {
            return;
        }
        this.parent.setVolatile();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final boolean useAlternateCode() {
        return this.alternateCode;
    }
}
