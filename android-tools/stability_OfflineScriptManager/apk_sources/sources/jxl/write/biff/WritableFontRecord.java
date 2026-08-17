package jxl.write.biff;

import jxl.biff.FontRecord;
import jxl.format.Font;
/* loaded from: classes.dex */
public class WritableFontRecord extends FontRecord {
    /* JADX INFO: Access modifiers changed from: protected */
    public WritableFontRecord(String str, int i, int i2, boolean z, int i3, int i4, int i5) {
        super(str, i, i2, z, i3, i4, i5);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public WritableFontRecord(Font font) {
        super(font);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setBoldStyle(int i) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontBoldStyle(i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setColour(int i) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontColour(i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setItalic(boolean z) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontItalic(z);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setPointSize(int i) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontPointSize(i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setScriptStyle(int i) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontScriptStyle(i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setStruckout(boolean z) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontStruckout(z);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setUnderlineStyle(int i) {
        if (isInitialized()) {
            throw new JxlWriteException(JxlWriteException.formatInitialized);
        }
        super.setFontUnderlineStyle(i);
    }
}
