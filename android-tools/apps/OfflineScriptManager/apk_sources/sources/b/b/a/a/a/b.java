package b.b.a.a.a;
/* loaded from: classes.dex */
public class b {

    /* renamed from: a  reason: collision with root package name */
    private final String f1342a;

    /* renamed from: b  reason: collision with root package name */
    private final String f1343b;

    public b(String str, String str2) {
        if (str == null || str2 == null) {
            throw new IllegalArgumentException("className and testName must be non-null");
        }
        this.f1342a = str;
        this.f1343b = str2;
    }

    public String a() {
        return this.f1342a;
    }

    public String b() {
        return this.f1343b;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj != null && b.class == obj.getClass()) {
            b bVar = (b) obj;
            String str = this.f1342a;
            if (str == null) {
                if (bVar.f1342a != null) {
                    return false;
                }
            } else if (!str.equals(bVar.f1342a)) {
                return false;
            }
            String str2 = this.f1343b;
            String str3 = bVar.f1343b;
            if (str2 == null) {
                if (str3 != null) {
                    return false;
                }
            } else if (!str2.equals(str3)) {
                return false;
            }
            return true;
        }
        return false;
    }

    public int hashCode() {
        String str = this.f1342a;
        int hashCode = ((str == null ? 0 : str.hashCode()) + 31) * 31;
        String str2 = this.f1343b;
        return hashCode + (str2 != null ? str2.hashCode() : 0);
    }

    public String toString() {
        return String.format("%s#%s", a(), b());
    }
}
