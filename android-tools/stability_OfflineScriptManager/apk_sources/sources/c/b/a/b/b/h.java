package c.b.a.b.b;

import java.lang.reflect.Modifier;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
class h {
    static h g;
    static h h;
    static h i;

    /* renamed from: a  reason: collision with root package name */
    boolean f1707a = true;

    /* renamed from: b  reason: collision with root package name */
    boolean f1708b = true;

    /* renamed from: c  reason: collision with root package name */
    boolean f1709c = false;

    /* renamed from: d  reason: collision with root package name */
    boolean f1710d = false;
    boolean e = false;
    int f;

    static {
        h hVar = new h();
        g = hVar;
        hVar.f1707a = true;
        hVar.f1708b = false;
        hVar.f1709c = false;
        hVar.f1710d = false;
        hVar.e = true;
        hVar.f = 0;
        h hVar2 = new h();
        h = hVar2;
        hVar2.f1707a = true;
        hVar2.f1708b = true;
        hVar2.f1709c = false;
        hVar2.f1710d = false;
        hVar2.e = false;
        hVar.f = 1;
        h hVar3 = new h();
        i = hVar3;
        hVar3.f1707a = false;
        hVar3.f1708b = true;
        hVar3.f1709c = false;
        hVar3.f1710d = true;
        hVar3.e = false;
        hVar3.f = 2;
    }

    h() {
    }

    public void a(StringBuffer stringBuffer, Class[] clsArr) {
        String str;
        if (clsArr == null) {
            return;
        }
        if (this.f1708b) {
            stringBuffer.append("(");
            c(stringBuffer, clsArr);
            str = ")";
        } else {
            str = clsArr.length == 0 ? "()" : "(..)";
        }
        stringBuffer.append(str);
    }

    public void b(StringBuffer stringBuffer, Class[] clsArr) {
        if (!this.f1709c || clsArr == null || clsArr.length == 0) {
            return;
        }
        stringBuffer.append(" throws ");
        c(stringBuffer, clsArr);
    }

    public void c(StringBuffer stringBuffer, Class[] clsArr) {
        for (int i2 = 0; i2 < clsArr.length; i2++) {
            if (i2 > 0) {
                stringBuffer.append(", ");
            }
            stringBuffer.append(g(clsArr[i2]));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String d(String str) {
        int lastIndexOf = str.lastIndexOf(45);
        return lastIndexOf == -1 ? str : str.substring(lastIndexOf + 1);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String e(int i2) {
        if (this.f1710d) {
            String modifier = Modifier.toString(i2);
            if (modifier.length() == 0) {
                return BuildConfig.FLAVOR;
            }
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(modifier);
            stringBuffer.append(" ");
            return stringBuffer.toString();
        }
        return BuildConfig.FLAVOR;
    }

    public String f(Class cls, String str) {
        return h(cls, str, this.e);
    }

    public String g(Class cls) {
        return h(cls, cls.getName(), this.f1707a);
    }

    String h(Class cls, String str, boolean z) {
        if (cls == null) {
            return "ANONYMOUS";
        }
        if (!cls.isArray()) {
            return z ? i(str).replace('$', '.') : str.replace('$', '.');
        }
        Class<?> componentType = cls.getComponentType();
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(h(componentType, componentType.getName(), z));
        stringBuffer.append("[]");
        return stringBuffer.toString();
    }

    String i(String str) {
        int lastIndexOf = str.lastIndexOf(46);
        return lastIndexOf == -1 ? str : str.substring(lastIndexOf + 1);
    }
}
