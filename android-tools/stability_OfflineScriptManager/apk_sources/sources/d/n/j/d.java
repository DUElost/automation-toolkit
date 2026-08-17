package d.n.j;
/* loaded from: classes.dex */
public enum d implements c {
    INET,
    INET6;

    /* renamed from: values  reason: to resolve conflict with enum method */
    public static d[] valuesCustom() {
        d[] valuesCustom = values();
        int length = valuesCustom.length;
        d[] dVarArr = new d[length];
        System.arraycopy(valuesCustom, 0, dVarArr, 0, length);
        return dVarArr;
    }
}
