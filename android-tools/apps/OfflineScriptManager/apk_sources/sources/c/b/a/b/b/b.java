package c.b.a.b.b;

import c.b.a.a.a;
import c.b.a.b.b.c;
import java.util.Hashtable;
import java.util.StringTokenizer;
/* loaded from: classes.dex */
public final class b {
    static Hashtable e;
    private static Object[] f;
    static /* synthetic */ Class g;

    /* renamed from: a  reason: collision with root package name */
    Class f1690a;

    /* renamed from: b  reason: collision with root package name */
    ClassLoader f1691b;

    /* renamed from: c  reason: collision with root package name */
    String f1692c;

    /* renamed from: d  reason: collision with root package name */
    int f1693d = 0;

    static {
        Hashtable hashtable = new Hashtable();
        e = hashtable;
        hashtable.put("void", Void.TYPE);
        e.put("boolean", Boolean.TYPE);
        e.put("byte", Byte.TYPE);
        e.put("char", Character.TYPE);
        e.put("short", Short.TYPE);
        e.put("int", Integer.TYPE);
        e.put("long", Long.TYPE);
        e.put("float", Float.TYPE);
        e.put("double", Double.TYPE);
        f = new Object[0];
    }

    public b(String str, Class cls) {
        this.f1692c = str;
        this.f1690a = cls;
        this.f1691b = cls.getClassLoader();
    }

    static /* synthetic */ Class a(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e2) {
            throw new NoClassDefFoundError(e2.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static Class b(String str, ClassLoader classLoader) {
        if (str.equals("*")) {
            return null;
        }
        Class cls = (Class) e.get(str);
        if (cls != null) {
            return cls;
        }
        try {
            return classLoader == null ? Class.forName(str) : Class.forName(str, false, classLoader);
        } catch (ClassNotFoundException unused) {
            Class cls2 = g;
            if (cls2 == null) {
                Class a2 = a("java.lang.ClassNotFoundException");
                g = a2;
                return a2;
            }
            return cls2;
        }
    }

    public static c.b.a.a.a c(a.InterfaceC0057a interfaceC0057a, Object obj, Object obj2) {
        return new c(interfaceC0057a, obj, obj2, f);
    }

    public static c.b.a.a.a d(a.InterfaceC0057a interfaceC0057a, Object obj, Object obj2, Object obj3) {
        return new c(interfaceC0057a, obj, obj2, new Object[]{obj3});
    }

    public c.b.a.a.d.a e(String str, String str2, String str3, String str4, String str5, String str6, String str7) {
        int parseInt = Integer.parseInt(str, 16);
        Class b2 = b(str3, this.f1691b);
        StringTokenizer stringTokenizer = new StringTokenizer(str4, ":");
        int countTokens = stringTokenizer.countTokens();
        Class[] clsArr = new Class[countTokens];
        for (int i = 0; i < countTokens; i++) {
            clsArr[i] = b(stringTokenizer.nextToken(), this.f1691b);
        }
        StringTokenizer stringTokenizer2 = new StringTokenizer(str5, ":");
        int countTokens2 = stringTokenizer2.countTokens();
        String[] strArr = new String[countTokens2];
        for (int i2 = 0; i2 < countTokens2; i2++) {
            strArr[i2] = stringTokenizer2.nextToken();
        }
        StringTokenizer stringTokenizer3 = new StringTokenizer(str6, ":");
        int countTokens3 = stringTokenizer3.countTokens();
        Class[] clsArr2 = new Class[countTokens3];
        for (int i3 = 0; i3 < countTokens3; i3++) {
            clsArr2[i3] = b(stringTokenizer3.nextToken(), this.f1691b);
        }
        return new e(parseInt, str2, b2, clsArr, strArr, clsArr2, b(str7, this.f1691b));
    }

    public a.InterfaceC0057a f(String str, c.b.a.a.c cVar, int i) {
        int i2 = this.f1693d;
        this.f1693d = i2 + 1;
        return new c.a(i2, str, cVar, g(i, -1));
    }

    public c.b.a.a.d.b g(int i, int i2) {
        return new g(this.f1690a, this.f1692c, i);
    }
}
