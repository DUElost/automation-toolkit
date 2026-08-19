package c.d;

import d.c;
import d.e;
import d.j;
import d.k;
import d.l;
import java.io.Closeable;
import java.nio.charset.Charset;
import java.util.concurrent.atomic.AtomicBoolean;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    public static final Charset f1846a;

    /* renamed from: c.d.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0066a implements Closeable {

        /* renamed from: b  reason: collision with root package name */
        private final AtomicBoolean f1847b = new AtomicBoolean(false);

        /* renamed from: c  reason: collision with root package name */
        private final c f1848c;

        protected C0066a(int i) {
            this.f1848c = l.c(i);
        }

        public b b(int i) {
            return new b(this, i);
        }

        @Override // java.io.Closeable, java.lang.AutoCloseable
        public void close() {
            e();
        }

        public void e() {
            if (this.f1847b.compareAndSet(false, true)) {
                this.f1848c.s();
            }
        }
    }

    /* loaded from: classes.dex */
    public static class b implements Closeable {

        /* renamed from: b  reason: collision with root package name */
        private final c f1849b;

        /* renamed from: c  reason: collision with root package name */
        private final j f1850c;

        /* renamed from: d  reason: collision with root package name */
        private final AtomicBoolean f1851d = new AtomicBoolean(false);

        protected b(C0066a c0066a, int i) {
            c cVar = c0066a.f1848c;
            this.f1849b = cVar;
            this.f1850c = cVar.g(i);
        }

        private void b() {
            int P0 = this.f1850c.P0();
            if (P0 != 0 && P0 != 35) {
                throw new c.d.b(P0);
            }
        }

        private boolean s(int i, Object obj) {
            try {
                return this.f1850c.g1(i, obj) & (this.f1850c.P0() != 22);
            } catch (k.a unused) {
                return false;
            }
        }

        public boolean a(String str) {
            boolean O0 = this.f1850c.O0(str);
            b();
            return O0;
        }

        @Override // java.io.Closeable, java.lang.AutoCloseable
        public void close() {
            if (this.f1851d.compareAndSet(false, true)) {
                this.f1850c.close();
            }
        }

        public boolean e(String str) {
            return h(str.getBytes(a.f1846a), 0);
        }

        public boolean h(byte[] bArr, int i) {
            if (this.f1850c.f1(new e(bArr), i)) {
                return true;
            }
            b();
            return false;
        }

        public boolean m(String str) {
            return h(str.getBytes(a.f1846a), 2);
        }

        public boolean q(int i) {
            return s(23, Integer.valueOf(i));
        }

        public String toString() {
            return this.f1850c.toString();
        }
    }

    static {
        byte[] bArr = l.f2558a;
        byte[] bArr2 = l.f2559b;
        byte[] bArr3 = l.f2561d;
        byte[] bArr4 = l.e;
        byte[] bArr5 = l.f;
        f1846a = l.f2560c;
    }

    public static C0066a a(int i) {
        return new C0066a(i);
    }
}
