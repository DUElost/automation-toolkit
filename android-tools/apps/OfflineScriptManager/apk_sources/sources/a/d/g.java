package a.d;

import java.util.ConcurrentModificationException;
import java.util.Map;
/* loaded from: classes.dex */
public class g<K, V> {
    static Object[] e;
    static int f;
    static Object[] g;
    static int h;

    /* renamed from: b  reason: collision with root package name */
    int[] f99b;

    /* renamed from: c  reason: collision with root package name */
    Object[] f100c;

    /* renamed from: d  reason: collision with root package name */
    int f101d;

    public g() {
        this.f99b = c.f77a;
        this.f100c = c.f79c;
        this.f101d = 0;
    }

    public g(int i) {
        if (i == 0) {
            this.f99b = c.f77a;
            this.f100c = c.f79c;
        } else {
            a(i);
        }
        this.f101d = 0;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public g(g<K, V> gVar) {
        this();
        if (gVar != 0) {
            j(gVar);
        }
    }

    private void a(int i) {
        if (i == 8) {
            synchronized (a.class) {
                Object[] objArr = g;
                if (objArr != null) {
                    this.f100c = objArr;
                    g = (Object[]) objArr[0];
                    this.f99b = (int[]) objArr[1];
                    objArr[1] = null;
                    objArr[0] = null;
                    h--;
                    return;
                }
            }
        } else if (i == 4) {
            synchronized (a.class) {
                Object[] objArr2 = e;
                if (objArr2 != null) {
                    this.f100c = objArr2;
                    e = (Object[]) objArr2[0];
                    this.f99b = (int[]) objArr2[1];
                    objArr2[1] = null;
                    objArr2[0] = null;
                    f--;
                    return;
                }
            }
        }
        this.f99b = new int[i];
        this.f100c = new Object[i << 1];
    }

    private static int b(int[] iArr, int i, int i2) {
        try {
            return c.a(iArr, i, i2);
        } catch (ArrayIndexOutOfBoundsException unused) {
            throw new ConcurrentModificationException();
        }
    }

    private static void d(int[] iArr, Object[] objArr, int i) {
        if (iArr.length == 8) {
            synchronized (a.class) {
                if (h < 10) {
                    objArr[0] = g;
                    objArr[1] = iArr;
                    for (int i2 = (i << 1) - 1; i2 >= 2; i2--) {
                        objArr[i2] = null;
                    }
                    g = objArr;
                    h++;
                }
            }
        } else if (iArr.length == 4) {
            synchronized (a.class) {
                if (f < 10) {
                    objArr[0] = e;
                    objArr[1] = iArr;
                    for (int i3 = (i << 1) - 1; i3 >= 2; i3--) {
                        objArr[i3] = null;
                    }
                    e = objArr;
                    f++;
                }
            }
        }
    }

    public void c(int i) {
        int i2 = this.f101d;
        int[] iArr = this.f99b;
        if (iArr.length < i) {
            Object[] objArr = this.f100c;
            a(i);
            if (this.f101d > 0) {
                System.arraycopy(iArr, 0, this.f99b, 0, i2);
                System.arraycopy(objArr, 0, this.f100c, 0, i2 << 1);
            }
            d(iArr, objArr, i2);
        }
        if (this.f101d != i2) {
            throw new ConcurrentModificationException();
        }
    }

    public void clear() {
        int i = this.f101d;
        if (i > 0) {
            int[] iArr = this.f99b;
            Object[] objArr = this.f100c;
            this.f99b = c.f77a;
            this.f100c = c.f79c;
            this.f101d = 0;
            d(iArr, objArr, i);
        }
        if (this.f101d > 0) {
            throw new ConcurrentModificationException();
        }
    }

    public boolean containsKey(Object obj) {
        return f(obj) >= 0;
    }

    public boolean containsValue(Object obj) {
        return h(obj) >= 0;
    }

    int e(Object obj, int i) {
        int i2 = this.f101d;
        if (i2 == 0) {
            return -1;
        }
        int b2 = b(this.f99b, i2, i);
        if (b2 >= 0 && !obj.equals(this.f100c[b2 << 1])) {
            int i3 = b2 + 1;
            while (i3 < i2 && this.f99b[i3] == i) {
                if (obj.equals(this.f100c[i3 << 1])) {
                    return i3;
                }
                i3++;
            }
            for (int i4 = b2 - 1; i4 >= 0 && this.f99b[i4] == i; i4--) {
                if (obj.equals(this.f100c[i4 << 1])) {
                    return i4;
                }
            }
            return ~i3;
        }
        return b2;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof g) {
            g gVar = (g) obj;
            if (size() != gVar.size()) {
                return false;
            }
            for (int i = 0; i < this.f101d; i++) {
                try {
                    K i2 = i(i);
                    V m = m(i);
                    Object obj2 = gVar.get(i2);
                    if (m == null) {
                        if (obj2 != null || !gVar.containsKey(i2)) {
                            return false;
                        }
                    } else if (!m.equals(obj2)) {
                        return false;
                    }
                } catch (ClassCastException | NullPointerException unused) {
                    return false;
                }
            }
            return true;
        }
        if (obj instanceof Map) {
            Map map = (Map) obj;
            if (size() != map.size()) {
                return false;
            }
            for (int i3 = 0; i3 < this.f101d; i3++) {
                try {
                    K i4 = i(i3);
                    V m2 = m(i3);
                    Object obj3 = map.get(i4);
                    if (m2 == null) {
                        if (obj3 != null || !map.containsKey(i4)) {
                            return false;
                        }
                    } else if (!m2.equals(obj3)) {
                        return false;
                    }
                } catch (ClassCastException | NullPointerException unused2) {
                }
            }
            return true;
        }
        return false;
    }

    public int f(Object obj) {
        return obj == null ? g() : e(obj, obj.hashCode());
    }

    int g() {
        int i = this.f101d;
        if (i == 0) {
            return -1;
        }
        int b2 = b(this.f99b, i, 0);
        if (b2 >= 0 && this.f100c[b2 << 1] != null) {
            int i2 = b2 + 1;
            while (i2 < i && this.f99b[i2] == 0) {
                if (this.f100c[i2 << 1] == null) {
                    return i2;
                }
                i2++;
            }
            for (int i3 = b2 - 1; i3 >= 0 && this.f99b[i3] == 0; i3--) {
                if (this.f100c[i3 << 1] == null) {
                    return i3;
                }
            }
            return ~i2;
        }
        return b2;
    }

    public V get(Object obj) {
        int f2 = f(obj);
        if (f2 >= 0) {
            return (V) this.f100c[(f2 << 1) + 1];
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int h(Object obj) {
        int i = this.f101d * 2;
        Object[] objArr = this.f100c;
        if (obj == null) {
            for (int i2 = 1; i2 < i; i2 += 2) {
                if (objArr[i2] == null) {
                    return i2 >> 1;
                }
            }
            return -1;
        }
        for (int i3 = 1; i3 < i; i3 += 2) {
            if (obj.equals(objArr[i3])) {
                return i3 >> 1;
            }
        }
        return -1;
    }

    public int hashCode() {
        int[] iArr = this.f99b;
        Object[] objArr = this.f100c;
        int i = this.f101d;
        int i2 = 1;
        int i3 = 0;
        int i4 = 0;
        while (i3 < i) {
            Object obj = objArr[i2];
            i4 += (obj == null ? 0 : obj.hashCode()) ^ iArr[i3];
            i3++;
            i2 += 2;
        }
        return i4;
    }

    public K i(int i) {
        return (K) this.f100c[i << 1];
    }

    public boolean isEmpty() {
        return this.f101d <= 0;
    }

    public void j(g<? extends K, ? extends V> gVar) {
        int i = gVar.f101d;
        c(this.f101d + i);
        if (this.f101d != 0) {
            for (int i2 = 0; i2 < i; i2++) {
                put(gVar.i(i2), gVar.m(i2));
            }
        } else if (i > 0) {
            System.arraycopy(gVar.f99b, 0, this.f99b, 0, i);
            System.arraycopy(gVar.f100c, 0, this.f100c, 0, i << 1);
            this.f101d = i;
        }
    }

    public V k(int i) {
        Object[] objArr = this.f100c;
        int i2 = i << 1;
        V v = (V) objArr[i2 + 1];
        int i3 = this.f101d;
        int i4 = 0;
        if (i3 <= 1) {
            d(this.f99b, objArr, i3);
            this.f99b = c.f77a;
            this.f100c = c.f79c;
        } else {
            int i5 = i3 - 1;
            int[] iArr = this.f99b;
            if (iArr.length <= 8 || i3 >= iArr.length / 3) {
                if (i < i5) {
                    int i6 = i + 1;
                    int i7 = i5 - i;
                    System.arraycopy(iArr, i6, iArr, i, i7);
                    Object[] objArr2 = this.f100c;
                    System.arraycopy(objArr2, i6 << 1, objArr2, i2, i7 << 1);
                }
                Object[] objArr3 = this.f100c;
                int i8 = i5 << 1;
                objArr3[i8] = null;
                objArr3[i8 + 1] = null;
            } else {
                a(i3 > 8 ? i3 + (i3 >> 1) : 8);
                if (i3 != this.f101d) {
                    throw new ConcurrentModificationException();
                }
                if (i > 0) {
                    System.arraycopy(iArr, 0, this.f99b, 0, i);
                    System.arraycopy(objArr, 0, this.f100c, 0, i2);
                }
                if (i < i5) {
                    int i9 = i + 1;
                    int i10 = i5 - i;
                    System.arraycopy(iArr, i9, this.f99b, i, i10);
                    System.arraycopy(objArr, i9 << 1, this.f100c, i2, i10 << 1);
                }
            }
            i4 = i5;
        }
        if (i3 == this.f101d) {
            this.f101d = i4;
            return v;
        }
        throw new ConcurrentModificationException();
    }

    public V l(int i, V v) {
        int i2 = (i << 1) + 1;
        Object[] objArr = this.f100c;
        V v2 = (V) objArr[i2];
        objArr[i2] = v;
        return v2;
    }

    public V m(int i) {
        return (V) this.f100c[(i << 1) + 1];
    }

    public V put(K k, V v) {
        int i;
        int e2;
        int i2 = this.f101d;
        if (k == null) {
            e2 = g();
            i = 0;
        } else {
            int hashCode = k.hashCode();
            i = hashCode;
            e2 = e(k, hashCode);
        }
        if (e2 >= 0) {
            int i3 = (e2 << 1) + 1;
            Object[] objArr = this.f100c;
            V v2 = (V) objArr[i3];
            objArr[i3] = v;
            return v2;
        }
        int i4 = ~e2;
        int[] iArr = this.f99b;
        if (i2 >= iArr.length) {
            int i5 = 4;
            if (i2 >= 8) {
                i5 = (i2 >> 1) + i2;
            } else if (i2 >= 4) {
                i5 = 8;
            }
            Object[] objArr2 = this.f100c;
            a(i5);
            if (i2 != this.f101d) {
                throw new ConcurrentModificationException();
            }
            int[] iArr2 = this.f99b;
            if (iArr2.length > 0) {
                System.arraycopy(iArr, 0, iArr2, 0, iArr.length);
                System.arraycopy(objArr2, 0, this.f100c, 0, objArr2.length);
            }
            d(iArr, objArr2, i2);
        }
        if (i4 < i2) {
            int[] iArr3 = this.f99b;
            int i6 = i4 + 1;
            System.arraycopy(iArr3, i4, iArr3, i6, i2 - i4);
            Object[] objArr3 = this.f100c;
            System.arraycopy(objArr3, i4 << 1, objArr3, i6 << 1, (this.f101d - i4) << 1);
        }
        int i7 = this.f101d;
        if (i2 == i7) {
            int[] iArr4 = this.f99b;
            if (i4 < iArr4.length) {
                iArr4[i4] = i;
                Object[] objArr4 = this.f100c;
                int i8 = i4 << 1;
                objArr4[i8] = k;
                objArr4[i8 + 1] = v;
                this.f101d = i7 + 1;
                return null;
            }
        }
        throw new ConcurrentModificationException();
    }

    public V remove(Object obj) {
        int f2 = f(obj);
        if (f2 >= 0) {
            return k(f2);
        }
        return null;
    }

    public int size() {
        return this.f101d;
    }

    public String toString() {
        if (isEmpty()) {
            return "{}";
        }
        StringBuilder sb = new StringBuilder(this.f101d * 28);
        sb.append('{');
        for (int i = 0; i < this.f101d; i++) {
            if (i > 0) {
                sb.append(", ");
            }
            K i2 = i(i);
            if (i2 != this) {
                sb.append(i2);
            } else {
                sb.append("(this Map)");
            }
            sb.append('=');
            V m = m(i);
            if (m != this) {
                sb.append(m);
            } else {
                sb.append("(this Map)");
            }
        }
        sb.append('}');
        return sb.toString();
    }
}
