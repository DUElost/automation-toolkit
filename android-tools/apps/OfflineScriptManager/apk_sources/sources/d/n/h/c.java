package d.n.h;
/* loaded from: classes.dex */
public abstract class c extends d {
    protected final Runnable h;
    protected final Runnable i;

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            c.this.i();
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            c.this.h();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c(d.s.c cVar, int i) {
        super(cVar, i);
        this.h = new a();
        this.i = new b();
    }

    protected abstract void h();

    protected abstract void i();
}
