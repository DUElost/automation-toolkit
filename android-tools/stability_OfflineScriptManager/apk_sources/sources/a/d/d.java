package a.d;
/* loaded from: classes.dex */
public class d<E> implements Cloneable {
    private static final Object f = new Object();

    /* renamed from: b  reason: collision with root package name */
    private boolean f80b;

    /* renamed from: c  reason: collision with root package name */
    private long[] f81c;

    /* renamed from: d  reason: collision with root package name */
    private Object[] f82d;
    private int e;

    public d() {
        this(10);
    }

    public d(int i) {
        this.f80b = false;
        if (i == 0) {
            this.f81c = c.f78b;
            this.f82d = c.f79c;
        } else {
            int f2 = c.f(i);
            this.f81c = new long[f2];
            this.f82d = new Object[f2];
        }
        this.e = 0;
    }

    private void e() {
        int i = this.e;
        long[] jArr = this.f81c;
        Object[] objArr = this.f82d;
        int i2 = 0;
        for (int i3 = 0; i3 < i; i3++) {
            Object obj = objArr[i3];
            if (obj != f) {
                if (i3 != i2) {
                    jArr[i2] = jArr[i3];
                    objArr[i2] = obj;
                    objArr[i3] = null;
                }
                i2++;
            }
        }
        this.f80b = false;
        this.e = i2;
    }

    public void a(long j, E e) {
        int i = this.e;
        if (i != 0 && j <= this.f81c[i - 1]) {
            j(j, e);
            return;
        }
        if (this.f80b && i >= this.f81c.length) {
            e();
        }
        int i2 = this.e;
        if (i2 >= this.f81c.length) {
            int f2 = c.f(i2 + 1);
            long[] jArr = new long[f2];
            Object[] objArr = new Object[f2];
            long[] jArr2 = this.f81c;
            System.arraycopy(jArr2, 0, jArr, 0, jArr2.length);
            Object[] objArr2 = this.f82d;
            System.arraycopy(objArr2, 0, objArr, 0, objArr2.length);
            this.f81c = jArr;
            this.f82d = objArr;
        }
        this.f81c[i2] = j;
        this.f82d[i2] = e;
        this.e = i2 + 1;
    }

    public void b() {
        int i = this.e;
        Object[] objArr = this.f82d;
        for (int i2 = 0; i2 < i; i2++) {
            objArr[i2] = null;
        }
        this.e = 0;
        this.f80b = false;
    }

    /* renamed from: c */
    public d<E> clone() {
        try {
            d<E> dVar = (d) super.clone();
            dVar.f81c = (long[]) this.f81c.clone();
            dVar.f82d = (Object[]) this.f82d.clone();
            return dVar;
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e);
        }
    }

    public void d(long j) {
        int b2 = c.b(this.f81c, this.e, j);
        if (b2 >= 0) {
            Object[] objArr = this.f82d;
            Object obj = objArr[b2];
            Object obj2 = f;
            if (obj != obj2) {
                objArr[b2] = obj2;
                this.f80b = true;
            }
        }
    }

    public E f(long j) {
        return g(j, null);
    }

    public E g(long j, E e) {
        int b2 = c.b(this.f81c, this.e, j);
        if (b2 >= 0) {
            Object[] objArr = this.f82d;
            if (objArr[b2] != f) {
                return (E) objArr[b2];
            }
        }
        return e;
    }

    public int h(long j) {
        if (this.f80b) {
            e();
        }
        return c.b(this.f81c, this.e, j);
    }

    public long i(int i) {
        if (this.f80b) {
            e();
        }
        return this.f81c[i];
    }

    public void j(long j, E e) {
        int b2 = c.b(this.f81c, this.e, j);
        if (b2 >= 0) {
            this.f82d[b2] = e;
            return;
        }
        int i = ~b2;
        int i2 = this.e;
        if (i < i2) {
            Object[] objArr = this.f82d;
            if (objArr[i] == f) {
                this.f81c[i] = j;
                objArr[i] = e;
                return;
            }
        }
        if (this.f80b && i2 >= this.f81c.length) {
            e();
            i = ~c.b(this.f81c, this.e, j);
        }
        int i3 = this.e;
        if (i3 >= this.f81c.length) {
            int f2 = c.f(i3 + 1);
            long[] jArr = new long[f2];
            Object[] objArr2 = new Object[f2];
            long[] jArr2 = this.f81c;
            System.arraycopy(jArr2, 0, jArr, 0, jArr2.length);
            Object[] objArr3 = this.f82d;
            System.arraycopy(objArr3, 0, objArr2, 0, objArr3.length);
            this.f81c = jArr;
            this.f82d = objArr2;
        }
        int i4 = this.e;
        if (i4 - i != 0) {
            long[] jArr3 = this.f81c;
            int i5 = i + 1;
            System.arraycopy(jArr3, i, jArr3, i5, i4 - i);
            Object[] objArr4 = this.f82d;
            System.arraycopy(objArr4, i, objArr4, i5, this.e - i);
        }
        this.f81c[i] = j;
        this.f82d[i] = e;
        this.e++;
    }

    public void k(int i) {
        Object[] objArr = this.f82d;
        Object obj = objArr[i];
        Object obj2 = f;
        if (obj != obj2) {
            objArr[i] = obj2;
            this.f80b = true;
        }
    }

    public int l() {
        if (this.f80b) {
            e();
        }
        return this.e;
    }

    public E m(int i) {
        if (this.f80b) {
            e();
        }
        return (E) this.f82d[i];
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
