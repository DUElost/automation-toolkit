package a.d;
/* loaded from: classes.dex */
public class h<E> implements Cloneable {
    private static final Object f = new Object();

    /* renamed from: b  reason: collision with root package name */
    private boolean f102b;

    /* renamed from: c  reason: collision with root package name */
    private int[] f103c;

    /* renamed from: d  reason: collision with root package name */
    private Object[] f104d;
    private int e;

    public h() {
        this(10);
    }

    public h(int i) {
        this.f102b = false;
        if (i == 0) {
            this.f103c = c.f77a;
            this.f104d = c.f79c;
        } else {
            int e = c.e(i);
            this.f103c = new int[e];
            this.f104d = new Object[e];
        }
        this.e = 0;
    }

    private void e() {
        int i = this.e;
        int[] iArr = this.f103c;
        Object[] objArr = this.f104d;
        int i2 = 0;
        for (int i3 = 0; i3 < i; i3++) {
            Object obj = objArr[i3];
            if (obj != f) {
                if (i3 != i2) {
                    iArr[i2] = iArr[i3];
                    objArr[i2] = obj;
                    objArr[i3] = null;
                }
                i2++;
            }
        }
        this.f102b = false;
        this.e = i2;
    }

    public void a(int i, E e) {
        int i2 = this.e;
        if (i2 != 0 && i <= this.f103c[i2 - 1]) {
            j(i, e);
            return;
        }
        if (this.f102b && i2 >= this.f103c.length) {
            e();
        }
        int i3 = this.e;
        if (i3 >= this.f103c.length) {
            int e2 = c.e(i3 + 1);
            int[] iArr = new int[e2];
            Object[] objArr = new Object[e2];
            int[] iArr2 = this.f103c;
            System.arraycopy(iArr2, 0, iArr, 0, iArr2.length);
            Object[] objArr2 = this.f104d;
            System.arraycopy(objArr2, 0, objArr, 0, objArr2.length);
            this.f103c = iArr;
            this.f104d = objArr;
        }
        this.f103c[i3] = i;
        this.f104d[i3] = e;
        this.e = i3 + 1;
    }

    public void b() {
        int i = this.e;
        Object[] objArr = this.f104d;
        for (int i2 = 0; i2 < i; i2++) {
            objArr[i2] = null;
        }
        this.e = 0;
        this.f102b = false;
    }

    /* renamed from: c */
    public h<E> clone() {
        try {
            h<E> hVar = (h) super.clone();
            hVar.f103c = (int[]) this.f103c.clone();
            hVar.f104d = (Object[]) this.f104d.clone();
            return hVar;
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e);
        }
    }

    public void d(int i) {
        int a2 = c.a(this.f103c, this.e, i);
        if (a2 >= 0) {
            Object[] objArr = this.f104d;
            Object obj = objArr[a2];
            Object obj2 = f;
            if (obj != obj2) {
                objArr[a2] = obj2;
                this.f102b = true;
            }
        }
    }

    public E f(int i) {
        return g(i, null);
    }

    public E g(int i, E e) {
        int a2 = c.a(this.f103c, this.e, i);
        if (a2 >= 0) {
            Object[] objArr = this.f104d;
            if (objArr[a2] != f) {
                return (E) objArr[a2];
            }
        }
        return e;
    }

    public int h(int i) {
        if (this.f102b) {
            e();
        }
        return c.a(this.f103c, this.e, i);
    }

    public int i(int i) {
        if (this.f102b) {
            e();
        }
        return this.f103c[i];
    }

    public void j(int i, E e) {
        int a2 = c.a(this.f103c, this.e, i);
        if (a2 >= 0) {
            this.f104d[a2] = e;
            return;
        }
        int i2 = ~a2;
        int i3 = this.e;
        if (i2 < i3) {
            Object[] objArr = this.f104d;
            if (objArr[i2] == f) {
                this.f103c[i2] = i;
                objArr[i2] = e;
                return;
            }
        }
        if (this.f102b && i3 >= this.f103c.length) {
            e();
            i2 = ~c.a(this.f103c, this.e, i);
        }
        int i4 = this.e;
        if (i4 >= this.f103c.length) {
            int e2 = c.e(i4 + 1);
            int[] iArr = new int[e2];
            Object[] objArr2 = new Object[e2];
            int[] iArr2 = this.f103c;
            System.arraycopy(iArr2, 0, iArr, 0, iArr2.length);
            Object[] objArr3 = this.f104d;
            System.arraycopy(objArr3, 0, objArr2, 0, objArr3.length);
            this.f103c = iArr;
            this.f104d = objArr2;
        }
        int i5 = this.e;
        if (i5 - i2 != 0) {
            int[] iArr3 = this.f103c;
            int i6 = i2 + 1;
            System.arraycopy(iArr3, i2, iArr3, i6, i5 - i2);
            Object[] objArr4 = this.f104d;
            System.arraycopy(objArr4, i2, objArr4, i6, this.e - i2);
        }
        this.f103c[i2] = i;
        this.f104d[i2] = e;
        this.e++;
    }

    public void k(int i) {
        d(i);
    }

    public int l() {
        if (this.f102b) {
            e();
        }
        return this.e;
    }

    public E m(int i) {
        if (this.f102b) {
            e();
        }
        return (E) this.f104d[i];
    }

    public String toString() {
        if (l() <= 0) {
            return "{}";
        }
        StringBuilder sb = new StringBuilder(this.e * 28);
        sb.append('{');
        for (int i = 0; i < this.e; i++) {
            if (i > 0) {
                sb.append(", ");
            }
            sb.append(i(i));
            sb.append('=');
            E m = m(i);
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
