package a.f.k;
/* loaded from: classes.dex */
public class e<T> implements d<T> {

    /* renamed from: a  reason: collision with root package name */
    private final Object[] f168a;

    /* renamed from: b  reason: collision with root package name */
    private int f169b;

    public e(int i) {
        if (i <= 0) {
            throw new IllegalArgumentException("The max pool size must be > 0");
        }
        this.f168a = new Object[i];
    }

    private boolean c(T t) {
        for (int i = 0; i < this.f169b; i++) {
            if (this.f168a[i] == t) {
                return true;
            }
        }
        return false;
    }

    @Override // a.f.k.d
    public boolean a(T t) {
        if (c(t)) {
            throw new IllegalStateException("Already in the pool!");
        }
        int i = this.f169b;
        Object[] objArr = this.f168a;
        if (i < objArr.length) {
            objArr[i] = t;
            this.f169b = i + 1;
            return true;
        }
        return false;
    }

    @Override // a.f.k.d
    public T b() {
        int i = this.f169b;
        if (i > 0) {
            int i2 = i - 1;
            Object[] objArr = this.f168a;
            T t = (T) objArr[i2];
            objArr[i2] = null;
            this.f169b = i - 1;
            return t;
        }
        return null;
    }
}
