package jxl.biff.drawing;

import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class BStoreContainer extends EscherContainer {
    static /* synthetic */ Class class$jxl$biff$drawing$BStoreContainer;
    private static Logger logger;
    private int numBlips;

    static {
        Class cls = class$jxl$biff$drawing$BStoreContainer;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.BStoreContainer");
            class$jxl$biff$drawing$BStoreContainer = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public BStoreContainer() {
        super(EscherRecordType.BSTORE_CONTAINER);
    }

    public BStoreContainer(EscherRecordData escherRecordData) {
        super(escherRecordData);
        this.numBlips = getInstance();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public BlipStoreEntry getDrawing(int i) {
        return (BlipStoreEntry) getChildren()[i];
    }

    public int getNumBlips() {
        return this.numBlips;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setNumBlips(int i) {
        this.numBlips = i;
        setInstance(i);
    }
}
