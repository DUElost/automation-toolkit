package d.s;
/* loaded from: classes.dex */
public final class c {

    /* renamed from: a  reason: collision with root package name */
    private static final ThreadLocal<Integer> f2722a = new a();

    /* loaded from: classes.dex */
    class a extends ThreadLocal<Integer> {
        a() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* renamed from: a */
        public Integer initialValue() {
            return 0;
        }
    }

    public int a() {
        return f2722a.get().intValue();
    }

    public boolean b(int i) {
        return a() == i;
    }

    public void c(int i) {
        f2722a.set(Integer.valueOf(i));
    }

    public String toString() {
        return "Errno[" + a() + "]";
    }
}
