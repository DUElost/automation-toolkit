package c.c.a.l;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;
import java.util.regex.Pattern;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
class d extends c.c.a.l.a {
    public static Pattern k = Pattern.compile("[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F]");
    protected Map<Class<? extends Object>, c.c.a.k.i> j;

    /* loaded from: classes.dex */
    private class a implements Iterable<Object> {

        /* renamed from: b  reason: collision with root package name */
        private Iterator<Object> f1815b;

        public a(d dVar, Iterator<Object> it) {
            this.f1815b = it;
        }

        @Override // java.lang.Iterable
        public Iterator<Object> iterator() {
            return this.f1815b;
        }
    }

    /* loaded from: classes.dex */
    protected class b implements c.c.a.l.b {
        protected b() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            return d.this.h(c.c.a.k.i.p, Arrays.asList((Object[]) obj), null);
        }
    }

    /* loaded from: classes.dex */
    protected class c implements c.c.a.l.b {
        protected c() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            return d.this.f(c.c.a.k.i.m, Boolean.TRUE.equals(obj) ? "true" : "false");
        }
    }

    /* renamed from: c.c.a.l.d$d  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    protected class C0063d implements c.c.a.l.b {
        protected C0063d() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            return d.this.g(c.c.a.k.i.i, String.valueOf(c.c.a.i.a.a.a.a((byte[]) obj)), '|');
        }
    }

    /* loaded from: classes.dex */
    protected class e implements c.c.a.l.b {
        protected e() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            Calendar calendar;
            Object valueOf;
            String sb;
            if (obj instanceof Calendar) {
                calendar = (Calendar) obj;
            } else {
                calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
                calendar.setTime((Date) obj);
            }
            int i = calendar.get(1);
            int i2 = calendar.get(2) + 1;
            int i3 = calendar.get(5);
            int i4 = calendar.get(11);
            int i5 = calendar.get(12);
            int i6 = calendar.get(13);
            int i7 = calendar.get(14);
            StringBuilder sb2 = new StringBuilder(String.valueOf(i));
            while (sb2.length() < 4) {
                sb2.insert(0, "0");
            }
            sb2.append("-");
            if (i2 < 10) {
                sb2.append("0");
            }
            sb2.append(String.valueOf(i2));
            sb2.append("-");
            if (i3 < 10) {
                sb2.append("0");
            }
            sb2.append(String.valueOf(i3));
            sb2.append("T");
            if (i4 < 10) {
                sb2.append("0");
            }
            sb2.append(String.valueOf(i4));
            sb2.append(":");
            if (i5 < 10) {
                sb2.append("0");
            }
            sb2.append(String.valueOf(i5));
            sb2.append(":");
            if (i6 < 10) {
                sb2.append("0");
            }
            sb2.append(String.valueOf(i6));
            if (i7 > 0) {
                sb2.append(i7 < 10 ? ".00" : i7 < 100 ? ".0" : ".");
                sb2.append(String.valueOf(i7));
            }
            if (TimeZone.getTimeZone("UTC").equals(calendar.getTimeZone())) {
                sb = "Z";
            } else {
                int offset = calendar.getTimeZone().getOffset(calendar.get(0), calendar.get(1), calendar.get(2), calendar.get(5), calendar.get(7), calendar.get(14)) / 60000;
                int i8 = offset / 60;
                int i9 = offset % 60;
                StringBuilder sb3 = new StringBuilder();
                sb3.append(i8 > 0 ? "+" : BuildConfig.FLAVOR);
                sb3.append(i8);
                sb3.append(":");
                if (i9 < 10) {
                    valueOf = "0" + i9;
                } else {
                    valueOf = Integer.valueOf(i9);
                }
                sb3.append(valueOf);
                sb = sb3.toString();
            }
            sb2.append(sb);
            d dVar = d.this;
            return dVar.g(dVar.l(obj.getClass(), c.c.a.k.i.l), sb2.toString(), null);
        }
    }

    /* loaded from: classes.dex */
    protected class f implements c.c.a.l.b {
        protected f() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            c.c.a.k.i iVar = new c.c.a.k.i((Class<? extends Object>) obj.getClass());
            d dVar = d.this;
            return dVar.f(dVar.l(obj.getClass(), iVar), ((Enum) obj).name());
        }
    }

    /* loaded from: classes.dex */
    protected class g implements c.c.a.l.b {
        protected g() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            Iterator it = (Iterator) obj;
            d dVar = d.this;
            return dVar.h(dVar.l(obj.getClass(), c.c.a.k.i.p), new a(d.this, it), null);
        }
    }

    /* loaded from: classes.dex */
    protected class h implements c.c.a.l.b {
        protected h() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            d dVar = d.this;
            return dVar.h(dVar.l(obj.getClass(), c.c.a.k.i.p), (List) obj, null);
        }
    }

    /* loaded from: classes.dex */
    protected class i implements c.c.a.l.b {
        protected i() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            d dVar = d.this;
            return dVar.e(dVar.l(obj.getClass(), c.c.a.k.i.q), (Map) obj, null);
        }
    }

    /* loaded from: classes.dex */
    protected class j implements c.c.a.l.b {
        protected j() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            return d.this.f(c.c.a.k.i.n, "null");
        }
    }

    /* loaded from: classes.dex */
    protected class k implements c.c.a.l.b {
        protected k() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            c.c.a.k.i iVar;
            String obj2;
            if ((obj instanceof Byte) || (obj instanceof Short) || (obj instanceof Integer) || (obj instanceof Long) || (obj instanceof BigInteger)) {
                iVar = c.c.a.k.i.j;
                obj2 = obj.toString();
            } else {
                Number number = (Number) obj;
                iVar = c.c.a.k.i.k;
                obj2 = number.equals(Double.valueOf(Double.NaN)) ? ".NaN" : number.equals(Double.valueOf(Double.POSITIVE_INFINITY)) ? ".inf" : number.equals(Double.valueOf(Double.NEGATIVE_INFINITY)) ? "-.inf" : number.toString();
            }
            d dVar = d.this;
            return dVar.f(dVar.l(obj.getClass(), iVar), obj2);
        }
    }

    /* loaded from: classes.dex */
    protected class l implements c.c.a.l.b {
        protected l() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            LinkedHashMap linkedHashMap = new LinkedHashMap();
            for (Object obj2 : (Set) obj) {
                linkedHashMap.put(obj2, null);
            }
            d dVar = d.this;
            return dVar.e(dVar.l(obj.getClass(), c.c.a.k.i.f), linkedHashMap, null);
        }
    }

    /* loaded from: classes.dex */
    protected class m implements c.c.a.l.b {
        protected m() {
        }

        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            Character ch;
            c.c.a.k.i iVar = c.c.a.k.i.o;
            String obj2 = obj.toString();
            if (d.k.matcher(obj2).find()) {
                iVar = c.c.a.k.i.i;
                obj2 = String.valueOf(c.c.a.i.a.a.a.a(obj2.getBytes()));
                ch = '|';
            } else {
                ch = null;
            }
            return d.this.g(iVar, obj2, ch);
        }
    }

    public d() {
        this.f1811b = new j();
        this.f1810a.put(String.class, new m());
        this.f1810a.put(Boolean.class, new c());
        this.f1810a.put(Character.class, new m());
        this.f1810a.put(byte[].class, new C0063d());
        this.f1812c.put(Number.class, new k());
        this.f1812c.put(List.class, new h());
        this.f1812c.put(Map.class, new i());
        this.f1812c.put(Set.class, new l());
        this.f1812c.put(Iterator.class, new g());
        this.f1812c.put(new Object[0].getClass(), new b());
        this.f1812c.put(Date.class, new e());
        this.f1812c.put(Enum.class, new f());
        this.f1812c.put(Calendar.class, new e());
        this.j = new HashMap();
    }

    protected c.c.a.k.i l(Class<?> cls, c.c.a.k.i iVar) {
        return this.j.containsKey(cls) ? this.j.get(cls) : iVar;
    }
}
