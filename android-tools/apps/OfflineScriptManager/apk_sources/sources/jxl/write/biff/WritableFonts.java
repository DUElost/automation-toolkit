package jxl.write.biff;

import jxl.biff.Fonts;
import jxl.write.WritableFont;
/* loaded from: classes.dex */
public class WritableFonts extends Fonts {
    public WritableFonts(WritableWorkbookImpl writableWorkbookImpl) {
        addFont(writableWorkbookImpl.getStyles().getArial10Pt());
        WritableFont.FontName fontName = WritableFont.ARIAL;
        addFont(new WritableFont(fontName));
        addFont(new WritableFont(fontName));
        addFont(new WritableFont(fontName));
    }
}
