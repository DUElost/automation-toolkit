package jxl.biff.formula;

import jxl.WorkbookSettings;
import jxl.biff.StringHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
class StringValue extends Operand implements ParsedThing {
    static /* synthetic */ Class class$jxl$biff$formula$StringValue;
    private static final Logger logger;
    private WorkbookSettings settings;
    private String value;

    static {
        Class cls = class$jxl$biff$formula$StringValue;
        if (cls == null) {
            cls = class$("jxl.biff.formula.StringValue");
            class$jxl$biff$formula$StringValue = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public StringValue(String str) {
        this.value = str;
    }

    public StringValue(WorkbookSettings workbookSettings) {
        this.settings = workbookSettings;
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
        byte[] bArr = new byte[(this.value.length() * 2) + 3];
        bArr[0] = Token.STRING.getCode();
        bArr[1] = (byte) this.value.length();
        bArr[2] = 1;
        StringHelper.getUnicodeBytes(this.value, bArr, 3);
        return bArr;
    }

    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        stringBuffer.append("\"");
        stringBuffer.append(this.value);
        stringBuffer.append("\"");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.formula.ParseItem
    public void handleImportedCellReferences() {
    }

    @Override // jxl.biff.formula.ParsedThing
    public int read(byte[] bArr, int i) {
        int i2 = bArr[i] & 255;
        int i3 = bArr[i + 1] & 1;
        int i4 = i + 2;
        if (i3 == 0) {
            this.value = StringHelper.getString(bArr, i2, i4, this.settings);
        } else {
            this.value = StringHelper.getUnicodeString(bArr, i2, i4);
            i2 *= 2;
        }
        return i2 + 2;
    }
}
