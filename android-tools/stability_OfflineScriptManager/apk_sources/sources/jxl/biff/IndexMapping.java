package jxl.biff;

import jxl.common.Logger;
/* loaded from: classes.dex */
public final class IndexMapping {
    static /* synthetic */ Class class$jxl$biff$IndexMapping;
    private static Logger logger;
    private int[] newIndices;

    static {
        Class cls = class$jxl$biff$IndexMapping;
        if (cls == null) {
            cls = class$("jxl.biff.IndexMapping");
            class$jxl$biff$IndexMapping = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public IndexMapping(int i) {
        this.newIndices = new int[i];
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public int getNewIndex(int i) {
        return this.newIndices[i];
    }

    public void setMapping(int i, int i2) {
        this.newIndices[i] = i2;
    }
}
