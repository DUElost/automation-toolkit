package jxl.biff.drawing;

import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class SpgrContainer extends EscherContainer {
    static /* synthetic */ Class class$jxl$biff$drawing$SpgrContainer;
    private static final Logger logger;

    static {
        Class cls = class$jxl$biff$drawing$SpgrContainer;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.SpgrContainer");
            class$jxl$biff$drawing$SpgrContainer = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public SpgrContainer() {
        super(EscherRecordType.SPGR_CONTAINER);
    }

    public SpgrContainer(EscherRecordData escherRecordData) {
        super(escherRecordData);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }
}
