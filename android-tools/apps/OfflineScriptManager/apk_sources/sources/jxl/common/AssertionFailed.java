package jxl.common;
/* loaded from: classes.dex */
public class AssertionFailed extends RuntimeException {
    public AssertionFailed() {
        printStackTrace();
    }

    public AssertionFailed(String str) {
        super(str);
    }
}
