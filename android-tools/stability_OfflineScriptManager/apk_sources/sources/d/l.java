package d;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.SelectableChannel;
import java.nio.charset.Charset;
/* loaded from: classes.dex */
public class l {

    /* renamed from: a  reason: collision with root package name */
    public static final byte[] f2558a = new byte[0];

    /* renamed from: b  reason: collision with root package name */
    public static final byte[] f2559b = new byte[0];

    /* renamed from: c  reason: collision with root package name */
    public static final Charset f2560c;

    /* renamed from: d  reason: collision with root package name */
    public static final byte[] f2561d;
    public static final byte[] e;
    public static final byte[] f;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        public final int f2562a;

        /* renamed from: b  reason: collision with root package name */
        public final String f2563b;

        /* renamed from: c  reason: collision with root package name */
        public final Object f2564c;

        /* renamed from: d  reason: collision with root package name */
        private final int f2565d;

        public a(int i, String str, Object obj) {
            this.f2562a = i;
            this.f2563b = str;
            this.f2564c = obj;
            this.f2565d = obj instanceof Integer ? 1 : obj instanceof SelectableChannel ? 2 : 0;
        }

        public boolean a(j jVar) {
            int length = this.f2563b.length() + 5 + 1;
            if (this.f2565d == 1) {
                length += 4;
            }
            ByteBuffer order = ByteBuffer.allocate(length).order(ByteOrder.BIG_ENDIAN);
            order.putInt(this.f2562a);
            order.put((byte) this.f2563b.length());
            order.put(this.f2563b.getBytes(l.f2560c));
            order.put((byte) this.f2565d);
            if (this.f2565d == 1) {
                order.putInt(((Integer) this.f2564c).intValue());
            }
            order.flip();
            return jVar.f1(new e(order), 0);
        }
    }

    static {
        Charset forName = Charset.forName("UTF-8");
        f2560c = forName;
        f2561d = "PAUSE".getBytes(forName);
        e = "RESUME".getBytes(forName);
        f = "TERMINATE".getBytes(forName);
    }

    private static void a(c cVar) {
        if (cVar == null || !cVar.a()) {
            throw new IllegalStateException();
        }
    }

    public static c b() {
        return new c();
    }

    public static c c(int i) {
        if (i >= 0) {
            c b2 = b();
            d(b2, 1, i);
            return b2;
        }
        throw new IllegalArgumentException("io_threads must not be negative");
    }

    public static void d(c cVar, int i, int i2) {
        a(cVar);
        cVar.r(i, i2);
    }
}
