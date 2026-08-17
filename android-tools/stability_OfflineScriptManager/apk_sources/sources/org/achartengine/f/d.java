package org.achartengine.f;
/* loaded from: classes.dex */
public enum d {
    X("x"),
    CIRCLE("circle"),
    TRIANGLE("triangle"),
    SQUARE("square"),
    DIAMOND("diamond"),
    POINT("point");
    

    /* renamed from: b  reason: collision with root package name */
    private String f2783b;

    d(String str) {
        this.f2783b = str;
    }

    /* renamed from: values  reason: to resolve conflict with enum method */
    public static d[] valuesCustom() {
        d[] valuesCustom = values();
        int length = valuesCustom.length;
        d[] dVarArr = new d[length];
        System.arraycopy(valuesCustom, 0, dVarArr, 0, length);
        return dVarArr;
    }

    public String a() {
        return this.f2783b;
    }

    @Override // java.lang.Enum
    public String toString() {
        return a();
    }
}
