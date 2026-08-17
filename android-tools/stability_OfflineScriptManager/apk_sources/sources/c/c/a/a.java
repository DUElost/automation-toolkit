package c.c.a;

import c.c.a.f.e;
import c.c.a.k.i;
import java.util.Map;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private c f1711a = c.PLAIN;

    /* renamed from: b  reason: collision with root package name */
    private EnumC0058a f1712b = EnumC0058a.AUTO;

    /* renamed from: c  reason: collision with root package name */
    private boolean f1713c = false;

    /* renamed from: d  reason: collision with root package name */
    private boolean f1714d = true;
    private boolean e = false;
    private int f = 2;
    private int g = 80;
    private b h = b.UNIX;
    private boolean i = false;
    private boolean j = false;
    private i k = null;
    private d l = null;
    private Map<String, String> m = null;
    private Boolean n = Boolean.FALSE;

    /* renamed from: c.c.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0058a {
        FLOW(Boolean.TRUE),
        BLOCK(Boolean.FALSE),
        AUTO(null);
        

        /* renamed from: b  reason: collision with root package name */
        private Boolean f1717b;

        EnumC0058a(Boolean bool) {
            this.f1717b = bool;
        }

        public Boolean a() {
            return this.f1717b;
        }

        @Override // java.lang.Enum
        public String toString() {
            return "Flow style: '" + this.f1717b + "'";
        }
    }

    /* loaded from: classes.dex */
    public enum b {
        WIN("\r\n"),
        MAC("\r"),
        UNIX("\n");
        

        /* renamed from: b  reason: collision with root package name */
        private String f1720b;

        b(String str) {
            this.f1720b = str;
        }

        public String a() {
            return this.f1720b;
        }

        @Override // java.lang.Enum
        public String toString() {
            return "Line break: " + name();
        }
    }

    /* loaded from: classes.dex */
    public enum c {
        DOUBLE_QUOTED(new Character('\"')),
        SINGLE_QUOTED(new Character('\'')),
        LITERAL(new Character('|')),
        FOLDED(new Character('>')),
        PLAIN(null);
        

        /* renamed from: b  reason: collision with root package name */
        private Character f1723b;

        c(Character ch) {
            this.f1723b = ch;
        }

        public static c a(Character ch) {
            if (ch == null) {
                return PLAIN;
            }
            char charValue = ch.charValue();
            if (charValue != '\"') {
                if (charValue != '\'') {
                    if (charValue != '>') {
                        if (charValue == '|') {
                            return LITERAL;
                        }
                        throw new c.c.a.g.b("Unknown scalar style character: " + ch);
                    }
                    return FOLDED;
                }
                return SINGLE_QUOTED;
            }
            return DOUBLE_QUOTED;
        }

        public Character b() {
            return this.f1723b;
        }

        @Override // java.lang.Enum
        public String toString() {
            return "Scalar style: '" + this.f1723b + "'";
        }
    }

    /* loaded from: classes.dex */
    public enum d {
        V1_0(new Integer[]{1, 0}),
        V1_1(new Integer[]{1, 1});
        

        /* renamed from: b  reason: collision with root package name */
        private Integer[] f1726b;

        d(Integer[] numArr) {
            this.f1726b = numArr;
        }

        public Integer[] a() {
            return this.f1726b;
        }

        @Override // java.lang.Enum
        public String toString() {
            return "Version: " + this.f1726b[0] + "." + this.f1726b[1];
        }
    }

    public c a(e eVar, c cVar) {
        return cVar;
    }

    public EnumC0058a b() {
        return this.f1712b;
    }

    public c c() {
        return this.f1711a;
    }

    public i d() {
        return this.k;
    }

    public int e() {
        return this.f;
    }

    public b f() {
        return this.h;
    }

    public Map<String, String> g() {
        return this.m;
    }

    public d h() {
        return this.l;
    }

    public int i() {
        return this.g;
    }

    public boolean j() {
        return this.e;
    }

    public boolean k() {
        return this.f1714d;
    }

    public boolean l() {
        return this.f1713c;
    }

    public boolean m() {
        return this.j;
    }

    public boolean n() {
        return this.i;
    }

    public boolean o() {
        return this.n.booleanValue();
    }
}
