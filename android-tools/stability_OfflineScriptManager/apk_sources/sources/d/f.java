package d;

import d.n.j.h.b;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class f {
    public final List<b.a> A = new ArrayList();
    public d.n.i.b B;
    public boolean C;
    public String D;
    public String E;
    public String F;
    public byte[] G;
    public byte[] H;
    public byte[] I;
    public int J;
    public boolean K;
    public int L;
    public Class<? extends d.n.h.e> M;
    public Class<? extends d.n.h.f> N;
    public d.o.a O;
    public final d.s.c P;

    /* renamed from: a  reason: collision with root package name */
    public int f2547a;

    /* renamed from: b  reason: collision with root package name */
    public int f2548b;

    /* renamed from: c  reason: collision with root package name */
    public long f2549c;

    /* renamed from: d  reason: collision with root package name */
    public byte f2550d;
    public byte[] e;
    String f;
    public int g;
    public int h;
    public int i;
    public int j;
    public int k;
    public int l;
    public int m;
    public int n;
    public long o;
    int p;
    public boolean q;
    public boolean r;
    public boolean s;
    public boolean t;
    public boolean u;
    public String v;
    public int w;
    public int x;
    public int y;
    public int z;

    public f() {
        new ArrayList();
        d.n.i.b bVar = d.n.i.b.NULL;
        this.B = bVar;
        this.D = BuildConfig.FLAVOR;
        this.P = new d.s.c();
        this.f2547a = 1000;
        this.f2548b = 1000;
        this.f2549c = 0L;
        this.f2550d = (byte) 0;
        this.g = 0;
        this.h = 0;
        this.i = 0;
        this.j = -1;
        this.k = -1;
        this.l = 100;
        this.m = 0;
        this.n = 100;
        this.o = -1L;
        this.p = -1;
        this.q = false;
        this.r = true;
        this.t = false;
        this.u = false;
        this.w = -1;
        this.x = -1;
        this.y = -1;
        this.z = -1;
        this.B = bVar;
        this.C = false;
        this.J = 0;
        this.K = false;
        this.L = 30000;
        byte[] bArr = new byte[0];
        this.e = bArr;
        this.f2550d = (byte) bArr.length;
        this.G = new byte[32];
        this.H = new byte[32];
        this.I = new byte[32];
        this.O = new d.o.d(b.MSG_ALLOCATION_HEAP_THRESHOLD.a());
    }

    private d.o.a a(Class<?> cls) {
        try {
            return (d.o.a) cls.asSubclass(d.o.a.class).newInstance();
        } catch (IllegalAccessException e) {
            throw new IllegalArgumentException(e);
        } catch (InstantiationException e2) {
            throw new IllegalArgumentException(e2);
        }
    }

    private <T> Class<? extends T> b(Object obj, Class<T> cls) {
        return ((Class) obj).asSubclass(cls);
    }

    public static boolean c(int i, Object obj) {
        if (obj instanceof Boolean) {
            return ((Boolean) obj).booleanValue();
        }
        if (obj instanceof Integer) {
            return ((Integer) obj).intValue() != 0;
        }
        throw new IllegalArgumentException(obj + " is neither an integer or a boolean for option " + i);
    }

    public static byte[] d(int i, Object obj) {
        if (obj instanceof String) {
            return ((String) obj).getBytes(l.f2560c);
        }
        if (obj instanceof byte[]) {
            return (byte[]) obj;
        }
        throw new IllegalArgumentException(obj + " is neither a string or an array of bytes for option " + i);
    }

    public static String e(int i, Object obj) {
        if (obj instanceof String) {
            return (String) obj;
        }
        if (obj instanceof byte[]) {
            return new String((byte[]) obj, l.f2560c);
        }
        throw new IllegalArgumentException(obj + " is neither a string or an array of bytes for option " + i);
    }

    /* JADX WARN: Removed duplicated region for block: B:19:0x0054  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private byte[] f(int r6, java.lang.Object r7, d.s.f<java.lang.Boolean> r8) {
        /*
            r5 = this;
            r0 = 0
            if (r7 != 0) goto L9
            java.lang.Boolean r6 = java.lang.Boolean.FALSE
            r8.b(r6)
            return r0
        L9:
            boolean r1 = r7 instanceof byte[]
            r2 = 32
            r3 = 0
            if (r1 == 0) goto L22
            r1 = r7
            byte[] r1 = (byte[]) r1
            int r4 = r1.length
            if (r4 != r2) goto L22
            java.lang.Boolean r6 = java.lang.Boolean.TRUE
            r8.b(r6)
            d.s.c r6 = r5.P
            r6.c(r3)
            r0 = r1
            goto L52
        L22:
            java.lang.String r6 = e(r6, r7)
            int r7 = r6.length()
            r1 = 40
            if (r7 != r1) goto L3d
            byte[] r0 = d.s.h.a(r6)
        L32:
            java.lang.Boolean r6 = java.lang.Boolean.TRUE
            r8.b(r6)
            d.s.c r6 = r5.P
            r6.c(r3)
            goto L52
        L3d:
            if (r7 != r2) goto L46
            java.nio.charset.Charset r7 = d.l.f2560c
            byte[] r0 = r6.getBytes(r7)
            goto L32
        L46:
            java.lang.Boolean r6 = java.lang.Boolean.FALSE
            r8.b(r6)
            d.s.c r6 = r5.P
            r7 = 22
            r6.c(r7)
        L52:
            if (r0 == 0) goto L58
            d.n.i.b r6 = d.n.i.b.CURVE
            r5.B = r6
        L58:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: d.f.f(int, java.lang.Object, d.s.f):byte[]");
    }

    public boolean g(int i, Object obj) {
        d.s.f<Boolean> fVar = new d.s.f<>(Boolean.FALSE);
        if (i == 4) {
            this.f2549c = ((Long) obj).longValue();
            return true;
        } else if (i == 5) {
            byte[] d2 = d(i, obj);
            if (d2 == null || d2.length > 255) {
                throw new IllegalArgumentException("identity must not be null or less than 255 " + obj);
            }
            byte[] copyOf = Arrays.copyOf(d2, d2.length);
            this.e = copyOf;
            this.f2550d = (byte) copyOf.length;
            return true;
        } else if (i == 8) {
            ((Integer) obj).intValue();
            return true;
        } else if (i == 9) {
            ((Integer) obj).intValue();
            return true;
        } else if (i == 11) {
            this.g = ((Integer) obj).intValue();
            return true;
        } else if (i == 12) {
            this.h = ((Integer) obj).intValue();
            return true;
        } else if (i == 27) {
            ((Integer) obj).intValue();
            return true;
        } else if (i == 28) {
            this.p = ((Integer) obj).intValue();
            return true;
        } else if (i == 54) {
            this.K = c(i, obj);
            return true;
        } else if (i == 55) {
            String e = e(i, obj);
            if (e != null && e.length() < 256) {
                this.D = e;
                return true;
            }
            throw new IllegalArgumentException("zap domain length shall be < 256 : " + obj);
        } else {
            switch (i) {
                case 17:
                    this.k = ((Integer) obj).intValue();
                    return true;
                case 18:
                    int intValue = ((Integer) obj).intValue();
                    this.l = intValue;
                    if (intValue >= -1) {
                        return true;
                    }
                    throw new IllegalArgumentException("reconnectIvl " + obj);
                case 19:
                    this.n = ((Integer) obj).intValue();
                    return true;
                default:
                    switch (i) {
                        case 21:
                            int intValue2 = ((Integer) obj).intValue();
                            this.m = intValue2;
                            if (intValue2 >= 0) {
                                return true;
                            }
                            throw new IllegalArgumentException("reconnectIvlMax " + obj);
                        case 22:
                            this.o = ((Long) obj).longValue();
                            return true;
                        case 23:
                            int intValue3 = ((Integer) obj).intValue();
                            this.f2547a = intValue3;
                            if (intValue3 >= 0) {
                                return true;
                            }
                            throw new IllegalArgumentException("sendHwm " + obj);
                        case 24:
                            int intValue4 = ((Integer) obj).intValue();
                            this.f2548b = intValue4;
                            if (intValue4 >= 0) {
                                return true;
                            }
                            throw new IllegalArgumentException("recvHwm " + obj);
                        case 25:
                            ((Integer) obj).intValue();
                            return true;
                        default:
                            switch (i) {
                                case 31:
                                    return g(42, Boolean.valueOf(!c(i, obj)));
                                case 42:
                                    this.q = c(i, obj);
                                    return true;
                                case 44:
                                    boolean c2 = c(i, obj);
                                    this.C = c2;
                                    this.B = c2 ? d.n.i.b.PLAIN : d.n.i.b.NULL;
                                    return true;
                                case 45:
                                    if (obj == null) {
                                        this.B = d.n.i.b.NULL;
                                        this.C = false;
                                        return true;
                                    }
                                    this.E = e(i, obj);
                                    this.C = false;
                                    this.B = d.n.i.b.PLAIN;
                                    return true;
                                case 46:
                                    if (obj == null) {
                                        this.B = d.n.i.b.NULL;
                                        this.C = false;
                                        return true;
                                    }
                                    this.F = e(i, obj);
                                    this.C = false;
                                    this.B = d.n.i.b.PLAIN;
                                    return true;
                                case 47:
                                    boolean c3 = c(i, obj);
                                    this.C = c3;
                                    this.B = c3 ? d.n.i.b.CURVE : d.n.i.b.NULL;
                                    return true;
                                case 48:
                                    this.G = f(i, obj, fVar);
                                    return fVar.a().booleanValue();
                                case 49:
                                    this.H = f(i, obj, fVar);
                                    return fVar.a().booleanValue();
                                case 50:
                                    byte[] f = f(i, obj, fVar);
                                    this.I = f;
                                    if (f == null) {
                                        this.C = false;
                                    }
                                    return fVar.a().booleanValue();
                                case 57:
                                    this.i = ((Integer) obj).intValue();
                                    return true;
                                case 1001:
                                    Class<? extends d.n.h.f> b2 = b(obj, d.n.h.f.class);
                                    this.N = b2;
                                    if (b2 == null) {
                                        return false;
                                    }
                                    this.u = true;
                                    return true;
                                case 1002:
                                    Class<? extends d.n.h.e> b3 = b(obj, d.n.h.e.class);
                                    this.M = b3;
                                    if (b3 == null) {
                                        return false;
                                    }
                                    this.u = true;
                                    return true;
                                case 1003:
                                    if (obj instanceof String) {
                                        try {
                                            this.O = a(Class.forName((String) obj));
                                            return true;
                                        } catch (ClassNotFoundException e2) {
                                            throw new IllegalArgumentException(e2);
                                        }
                                    } else if (obj instanceof Class) {
                                        this.O = a((Class) obj);
                                        return true;
                                    } else if (obj instanceof d.o.a) {
                                        this.O = (d.o.a) obj;
                                        return true;
                                    } else {
                                        return false;
                                    }
                                case 1004:
                                    this.O = new d.o.d(((Integer) obj).intValue());
                                    return true;
                                case 1039:
                                    this.r = c(i, obj);
                                    return true;
                                default:
                                    switch (i) {
                                        case 34:
                                            int intValue5 = ((Number) obj).intValue();
                                            this.w = intValue5;
                                            if (intValue5 == -1 || intValue5 == 0 || intValue5 == 1) {
                                                return true;
                                            }
                                            throw new IllegalArgumentException("tcpKeepAlive only accepts one of -1,0,1 " + obj);
                                        case 35:
                                        case 36:
                                        case 37:
                                            return false;
                                        case 38:
                                            String e3 = e(i, obj);
                                            if (e3 == null) {
                                                this.A.clear();
                                            } else if (e3.length() == 0 || e3.length() > 255) {
                                                throw new IllegalArgumentException("tcp_accept_filter " + obj);
                                            } else {
                                                this.A.add(new b.a(e3, this.q));
                                            }
                                            return true;
                                        case 39:
                                            this.r = !c(i, obj);
                                            return true;
                                        default:
                                            switch (i) {
                                                case 62:
                                                    this.C = c(i, obj);
                                                    this.B = d.n.i.b.GSSAPI;
                                                    return true;
                                                case 63:
                                                    e(i, obj);
                                                    this.B = d.n.i.b.GSSAPI;
                                                    return true;
                                                case 64:
                                                    e(i, obj);
                                                    this.B = d.n.i.b.GSSAPI;
                                                    return true;
                                                case 65:
                                                    c(i, obj);
                                                    return true;
                                                case 66:
                                                    int intValue6 = ((Integer) obj).intValue();
                                                    this.L = intValue6;
                                                    if (intValue6 >= 0) {
                                                        return true;
                                                    }
                                                    throw new IllegalArgumentException("handshakeIvl only accept positive values " + obj);
                                                case 67:
                                                    this.v = e(i, obj);
                                                    return true;
                                                default:
                                                    throw new IllegalArgumentException("Unknown Option " + i);
                                            }
                                    }
                            }
                    }
            }
        }
    }
}
