package c.b.a.b.b;
/* loaded from: classes.dex */
class g implements c.b.a.a.d.b {

    /* renamed from: a  reason: collision with root package name */
    String f1705a;

    /* renamed from: b  reason: collision with root package name */
    int f1706b;

    /* JADX INFO: Access modifiers changed from: package-private */
    public g(Class cls, String str, int i) {
        this.f1705a = str;
        this.f1706b = i;
    }

    public String a() {
        return this.f1705a;
    }

    public int b() {
        return this.f1706b;
    }

    public String toString() {
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(a());
        stringBuffer.append(":");
        stringBuffer.append(b());
        return stringBuffer.toString();
    }
}
