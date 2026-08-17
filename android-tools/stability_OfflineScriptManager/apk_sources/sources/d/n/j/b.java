package d.n.j;

import java.util.Arrays;
import java.util.List;
/* JADX WARN: Enum visitor error
jadx.core.utils.exceptions.JadxRuntimeException: Init of enum g uses external variables
	at jadx.core.dex.visitors.EnumVisitor.createEnumFieldByConstructor(EnumVisitor.java:444)
	at jadx.core.dex.visitors.EnumVisitor.processEnumFieldByRegister(EnumVisitor.java:391)
	at jadx.core.dex.visitors.EnumVisitor.extractEnumFieldsFromFilledArray(EnumVisitor.java:320)
	at jadx.core.dex.visitors.EnumVisitor.extractEnumFieldsFromInsn(EnumVisitor.java:258)
	at jadx.core.dex.visitors.EnumVisitor.convertToEnum(EnumVisitor.java:151)
	at jadx.core.dex.visitors.EnumVisitor.visit(EnumVisitor.java:100)
 */
/* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
/* loaded from: classes.dex */
public final class b {

    /* renamed from: d  reason: collision with root package name */
    public static final b f2638d;
    public static final b e;
    public static final b f;
    public static final b g;
    public static final b h;
    public static final b i;
    public static final b j;
    private static final /* synthetic */ b[] k;

    /* renamed from: b  reason: collision with root package name */
    public final boolean f2639b;

    /* renamed from: c  reason: collision with root package name */
    private List<d.r.d> f2640c;

    static {
        b bVar = new b("inproc", 0, true, new d.r.d[0]);
        f2638d = bVar;
        b bVar2 = new b("ipc", 1, true, new d.r.d[0]);
        e = bVar2;
        b bVar3 = new b("tcp", 2, true, new d.r.d[0]);
        f = bVar3;
        d.r.d dVar = d.r.d.PUB;
        d.r.d dVar2 = d.r.d.SUB;
        d.r.d dVar3 = d.r.d.XPUB;
        b bVar4 = new b("pgm", 3, false, dVar, dVar2, dVar3, dVar3);
        g = bVar4;
        b bVar5 = new b("epgm", 4, false, dVar, dVar2, dVar3, dVar3);
        h = bVar5;
        b bVar6 = new b("tipc", 5, false, new d.r.d[0]);
        i = bVar6;
        b bVar7 = new b("norm", 6, false, new d.r.d[0]);
        j = bVar7;
        k = new b[]{bVar, bVar2, bVar3, bVar4, bVar5, bVar6, bVar7};
    }

    private b(String str, int i2, boolean z, d.r.d... dVarArr) {
        this.f2639b = z;
        this.f2640c = Arrays.asList(dVarArr);
    }

    public static b b(String str) {
        b[] values;
        for (b bVar : values()) {
            if (bVar.name().equals(str)) {
                return bVar;
            }
        }
        return null;
    }

    public static b valueOf(String str) {
        return (b) Enum.valueOf(b.class, str);
    }

    public static b[] values() {
        b[] bVarArr = k;
        int length = bVarArr.length;
        b[] bVarArr2 = new b[length];
        System.arraycopy(bVarArr, 0, bVarArr2, 0, length);
        return bVarArr2;
    }

    public final boolean a(int i2) {
        return this.f2640c.isEmpty() || this.f2640c.contains(d.r.d.f(i2));
    }
}
