package c.c.a.f;

import c.c.a.a;
import java.io.Writer;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.regex.Pattern;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public final class b implements c.c.a.f.a {
    private static final Map<Character, String> B;
    public static final char[] C;
    private static final Map<String, String> D;
    private static final Pattern E;
    private static final Pattern F;
    private c.c.a.a A;

    /* renamed from: a  reason: collision with root package name */
    private final Writer f1737a;
    private boolean i;
    private Boolean p;
    private Boolean q;
    private boolean r;
    private int s;
    private int t;
    private char[] u;
    private Map<String, String> v;
    private String w;
    private String x;
    private c.c.a.f.e y;
    private Character z;

    /* renamed from: b  reason: collision with root package name */
    private final c.c.a.p.a<c.c.a.f.d> f1738b = new c.c.a.p.a<>(100);

    /* renamed from: c  reason: collision with root package name */
    private c.c.a.f.d f1739c = new s();

    /* renamed from: d  reason: collision with root package name */
    private final Queue<c.c.a.h.f> f1740d = new ArrayBlockingQueue(100);
    private c.c.a.h.f e = null;
    private final c.c.a.p.a<Integer> f = new c.c.a.p.a<>(10);
    private Integer g = null;
    private int h = 0;
    private boolean j = false;
    private boolean k = false;
    private int l = 0;
    private boolean m = true;
    private boolean n = true;
    private boolean o = false;

    /* renamed from: c.c.a.f.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private class C0061b implements c.c.a.f.d {

        /* renamed from: a  reason: collision with root package name */
        private boolean f1741a;

        public C0061b(boolean z) {
            this.f1741a = z;
        }

        @Override // c.c.a.f.d
        public void a() {
            if (!this.f1741a && (b.this.e instanceof c.c.a.h.h)) {
                b bVar = b.this;
                bVar.g = (Integer) bVar.f.a();
                b bVar2 = b.this;
                bVar2.f1739c = (c.c.a.f.d) bVar2.f1738b.a();
                return;
            }
            b.this.X();
            if (b.this.z()) {
                b.this.f1738b.b(new c());
                b.this.H(false, false, true, true);
                return;
            }
            b.this.Y("?", true, false, true);
            b.this.f1738b.b(new d());
            b.this.H(false, false, true, false);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class c implements c.c.a.f.d {
        private c() {
        }

        @Override // c.c.a.f.d
        public void a() {
            b.this.Y(":", false, false, false);
            b.this.f1738b.b(new C0061b(false));
            b.this.H(false, false, true, false);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d implements c.c.a.f.d {
        private d() {
        }

        @Override // c.c.a.f.d
        public void a() {
            b.this.X();
            b.this.Y(":", true, false, true);
            b.this.f1738b.b(new C0061b(false));
            b.this.H(false, false, true, false);
        }
    }

    /* loaded from: classes.dex */
    private class e implements c.c.a.f.d {

        /* renamed from: a  reason: collision with root package name */
        private boolean f1745a;

        public e(boolean z) {
            this.f1745a = z;
        }

        @Override // c.c.a.f.d
        public void a() {
            if (this.f1745a || !(b.this.e instanceof c.c.a.h.l)) {
                b.this.X();
                b.this.Y("-", true, false, true);
                b.this.f1738b.b(new e(false));
                b.this.H(false, true, false, false);
                return;
            }
            b bVar = b.this;
            bVar.g = (Integer) bVar.f.a();
            b bVar2 = b.this;
            bVar2.f1739c = (c.c.a.f.d) bVar2.f1738b.a();
        }
    }

    /* loaded from: classes.dex */
    private class f implements c.c.a.f.d {
        private f() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (!(b.this.e instanceof c.c.a.h.d)) {
                throw new c.c.a.f.c("expected DocumentEndEvent, but got " + b.this.e);
            }
            b.this.X();
            if (((c.c.a.h.d) b.this.e).b()) {
                b.this.Y("...", true, false, false);
                b.this.X();
            }
            b.this.J();
            b bVar = b.this;
            bVar.f1739c = new h(false);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class g implements c.c.a.f.d {
        private g() {
        }

        @Override // c.c.a.f.d
        public void a() {
            b.this.f1738b.b(new f());
            b.this.H(true, false, false, false);
        }
    }

    /* loaded from: classes.dex */
    private class h implements c.c.a.f.d {

        /* renamed from: a  reason: collision with root package name */
        private boolean f1749a;

        public h(boolean z) {
            this.f1749a = z;
        }

        /*  JADX ERROR: JadxRuntimeException in pass: InlineMethods
            jadx.core.utils.exceptions.JadxRuntimeException: Failed to process method for inline: c.c.a.f.b.t(c.c.a.f.b, java.lang.String):java.lang.String
            	at jadx.core.dex.visitors.InlineMethods.processInvokeInsn(InlineMethods.java:76)
            	at jadx.core.dex.visitors.InlineMethods.visit(InlineMethods.java:51)
            Caused by: java.lang.NullPointerException
            	at jadx.core.dex.instructions.args.RegisterArg.sameRegAndSVar(RegisterArg.java:173)
            	at jadx.core.dex.instructions.args.InsnArg.isSameVar(InsnArg.java:269)
            	at jadx.core.dex.visitors.MarkMethodsForInline.isSyntheticAccessPattern(MarkMethodsForInline.java:118)
            	at jadx.core.dex.visitors.MarkMethodsForInline.inlineMth(MarkMethodsForInline.java:86)
            	at jadx.core.dex.visitors.MarkMethodsForInline.process(MarkMethodsForInline.java:53)
            	at jadx.core.dex.visitors.InlineMethods.processInvokeInsn(InlineMethods.java:65)
            	... 1 more
            */
        @Override // c.c.a.f.d
        public void a() {
            /*
                Method dump skipped, instructions count: 298
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.h.a():void");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class i implements c.c.a.f.d {
        private i() {
        }

        @Override // c.c.a.f.d
        public void a() {
            new C0061b(true).a();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class j implements c.c.a.f.d {
        private j() {
        }

        @Override // c.c.a.f.d
        public void a() {
            new e(true).a();
        }
    }

    /* loaded from: classes.dex */
    private class k implements c.c.a.f.d {
        private k() {
        }

        @Override // c.c.a.f.d
        public void a() {
            new h(true).a();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class l implements c.c.a.f.d {
        private l() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (b.this.e instanceof c.c.a.h.h) {
                b bVar = b.this;
                bVar.g = (Integer) bVar.f.a();
                b.i(b.this);
                b.this.Y("}", false, false, false);
                b bVar2 = b.this;
                bVar2.f1739c = (c.c.a.f.d) bVar2.f1738b.a();
                return;
            }
            if (b.this.p.booleanValue() || b.this.l > b.this.t || b.this.q.booleanValue()) {
                b.this.X();
            }
            if (!b.this.p.booleanValue() && b.this.z()) {
                b.this.f1738b.b(new o());
                b.this.H(false, false, true, true);
                return;
            }
            b.this.Y("?", true, false, false);
            b.this.f1738b.b(new p());
            b.this.H(false, false, true, false);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class m implements c.c.a.f.d {
        private m() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (b.this.e instanceof c.c.a.h.l) {
                b bVar = b.this;
                bVar.g = (Integer) bVar.f.a();
                b.i(b.this);
                b.this.Y("]", false, false, false);
                b bVar2 = b.this;
                bVar2.f1739c = (c.c.a.f.d) bVar2.f1738b.a();
                return;
            }
            if (b.this.p.booleanValue() || b.this.l > b.this.t || b.this.q.booleanValue()) {
                b.this.X();
            }
            b.this.f1738b.b(new q());
            b.this.H(false, true, false, false);
        }
    }

    /* loaded from: classes.dex */
    private class n implements c.c.a.f.d {
        private n() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (b.this.e instanceof c.c.a.h.h) {
                b bVar = b.this;
                bVar.g = (Integer) bVar.f.a();
                b.i(b.this);
                if (b.this.p.booleanValue()) {
                    b.this.Y(",", false, false, false);
                    b.this.X();
                }
                if (b.this.q.booleanValue()) {
                    b.this.X();
                }
                b.this.Y("}", false, false, false);
                b bVar2 = b.this;
                bVar2.f1739c = (c.c.a.f.d) bVar2.f1738b.a();
                return;
            }
            b.this.Y(",", false, false, false);
            if (b.this.p.booleanValue() || b.this.l > b.this.t || b.this.q.booleanValue()) {
                b.this.X();
            }
            if (!b.this.p.booleanValue() && b.this.z()) {
                b.this.f1738b.b(new o());
                b.this.H(false, false, true, true);
                return;
            }
            b.this.Y("?", true, false, false);
            b.this.f1738b.b(new p());
            b.this.H(false, false, true, false);
        }
    }

    /* loaded from: classes.dex */
    private class o implements c.c.a.f.d {
        private o() {
        }

        @Override // c.c.a.f.d
        public void a() {
            b.this.Y(":", false, false, false);
            b.this.f1738b.b(new n());
            b.this.H(false, false, true, false);
        }
    }

    /* loaded from: classes.dex */
    private class p implements c.c.a.f.d {
        private p() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (b.this.p.booleanValue() || b.this.l > b.this.t || b.this.q.booleanValue()) {
                b.this.X();
            }
            b.this.Y(":", true, false, false);
            b.this.f1738b.b(new n());
            b.this.H(false, false, true, false);
        }
    }

    /* loaded from: classes.dex */
    private class q implements c.c.a.f.d {
        private q() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (!(b.this.e instanceof c.c.a.h.l)) {
                b.this.Y(",", false, false, false);
                if (b.this.p.booleanValue() || b.this.l > b.this.t || b.this.q.booleanValue()) {
                    b.this.X();
                }
                b.this.f1738b.b(new q());
                b.this.H(false, true, false, false);
                return;
            }
            b bVar = b.this;
            bVar.g = (Integer) bVar.f.a();
            b.i(b.this);
            if (b.this.p.booleanValue()) {
                b.this.Y(",", false, false, false);
                b.this.X();
            }
            b.this.Y("]", false, false, false);
            if (b.this.q.booleanValue()) {
                b.this.X();
            }
            b bVar2 = b.this;
            bVar2.f1739c = (c.c.a.f.d) bVar2.f1738b.a();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class r implements c.c.a.f.d {
        private r() {
        }

        @Override // c.c.a.f.d
        public void a() {
            throw new c.c.a.f.c("expecting nothing, but got " + b.this.e);
        }
    }

    /* loaded from: classes.dex */
    private class s implements c.c.a.f.d {
        private s() {
        }

        @Override // c.c.a.f.d
        public void a() {
            if (b.this.e instanceof c.c.a.h.o) {
                b.this.e0();
                b bVar = b.this;
                bVar.f1739c = new k();
                return;
            }
            throw new c.c.a.f.c("expected StreamStartEvent, but got " + b.this.e);
        }
    }

    static {
        HashMap hashMap = new HashMap();
        B = hashMap;
        C = new char[]{' '};
        hashMap.put(new Character((char) 0), "0");
        hashMap.put(new Character((char) 7), "a");
        hashMap.put(new Character('\b'), "b");
        hashMap.put(new Character('\t'), "t");
        hashMap.put(new Character('\n'), "n");
        hashMap.put(new Character((char) 11), "v");
        hashMap.put(new Character('\f'), "f");
        hashMap.put(new Character('\r'), "r");
        hashMap.put(new Character((char) 27), "e");
        hashMap.put(new Character('\"'), "\"");
        hashMap.put(new Character('\\'), "\\");
        hashMap.put(new Character((char) 133), "N");
        hashMap.put(new Character((char) 160), "_");
        hashMap.put(new Character((char) 8232), "L");
        hashMap.put(new Character((char) 8233), "P");
        LinkedHashMap linkedHashMap = new LinkedHashMap();
        D = linkedHashMap;
        linkedHashMap.put("!", "!");
        linkedHashMap.put("tag:yaml.org,2002:", "!!");
        E = Pattern.compile("^![-_\\w]*!$");
        F = Pattern.compile("^[-_\\w]*$");
    }

    public b(Writer writer, c.c.a.a aVar) {
        this.f1737a = writer;
        this.p = Boolean.valueOf(aVar.l());
        this.q = Boolean.valueOf(aVar.o());
        this.r = aVar.k();
        this.s = 2;
        if (aVar.e() > 1 && aVar.e() < 10) {
            this.s = aVar.e();
        }
        this.t = 80;
        if (aVar.i() > this.s * 2) {
            this.t = aVar.i();
        }
        this.u = aVar.f().a().toCharArray();
        this.v = new LinkedHashMap();
        this.w = null;
        this.x = null;
        this.y = null;
        this.z = null;
        this.A = aVar;
    }

    /* JADX WARN: Code restructure failed: missing block: B:22:0x004d, code lost:
        if (r1.f1764c == false) goto L23;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private java.lang.Character A() {
        /*
            r4 = this;
            c.c.a.h.f r0 = r4.e
            c.c.a.h.k r0 = (c.c.a.h.k) r0
            c.c.a.f.e r1 = r4.y
            if (r1 != 0) goto L12
            java.lang.String r1 = r0.f()
            c.c.a.f.e r1 = r4.v(r1)
            r4.y = r1
        L12:
            java.lang.Character r1 = r0.d()
            r2 = 34
            if (r1 == 0) goto L24
            java.lang.Character r1 = r0.d()
            char r1 = r1.charValue()
            if (r1 == r2) goto L2c
        L24:
            java.lang.Boolean r1 = r4.p
            boolean r1 = r1.booleanValue()
            if (r1 == 0) goto L31
        L2c:
            java.lang.Character r0 = java.lang.Character.valueOf(r2)
            return r0
        L31:
            java.lang.Character r1 = r0.d()
            if (r1 != 0) goto L63
            c.c.a.h.g r1 = r0.c()
            boolean r1 = r1.b()
            if (r1 == 0) goto L63
            boolean r1 = r4.k
            if (r1 == 0) goto L4f
            c.c.a.f.e r1 = r4.y
            boolean r3 = r1.f1763b
            if (r3 != 0) goto L63
            boolean r1 = r1.f1764c
            if (r1 != 0) goto L63
        L4f:
            int r1 = r4.h
            if (r1 == 0) goto L59
            c.c.a.f.e r3 = r4.y
            boolean r3 = r3.f1765d
            if (r3 != 0) goto L61
        L59:
            if (r1 != 0) goto L63
            c.c.a.f.e r1 = r4.y
            boolean r1 = r1.e
            if (r1 == 0) goto L63
        L61:
            r0 = 0
            return r0
        L63:
            java.lang.Character r1 = r0.d()
            if (r1 == 0) goto L94
            java.lang.Character r1 = r0.d()
            char r1 = r1.charValue()
            r3 = 124(0x7c, float:1.74E-43)
            if (r1 == r3) goto L81
            java.lang.Character r1 = r0.d()
            char r1 = r1.charValue()
            r3 = 62
            if (r1 != r3) goto L94
        L81:
            int r1 = r4.h
            if (r1 != 0) goto L94
            boolean r1 = r4.k
            if (r1 != 0) goto L94
            c.c.a.f.e r1 = r4.y
            boolean r1 = r1.g
            if (r1 == 0) goto L94
            java.lang.Character r0 = r0.d()
            return r0
        L94:
            java.lang.Character r1 = r0.d()
            r3 = 39
            if (r1 == 0) goto La6
            java.lang.Character r0 = r0.d()
            char r0 = r0.charValue()
            if (r0 != r3) goto Lb9
        La6:
            c.c.a.f.e r0 = r4.y
            boolean r1 = r0.f
            if (r1 == 0) goto Lb9
            boolean r1 = r4.k
            if (r1 == 0) goto Lb4
            boolean r0 = r0.f1764c
            if (r0 != 0) goto Lb9
        Lb4:
            java.lang.Character r0 = java.lang.Character.valueOf(r3)
            return r0
        Lb9:
            java.lang.Character r0 = java.lang.Character.valueOf(r2)
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.A():java.lang.Character");
    }

    private String B(String str) {
        String str2;
        StringBuilder sb = new StringBuilder();
        c.c.a.n.a aVar = c.c.a.n.a.f1835d;
        if (aVar.b(str.charAt(0), " ")) {
            sb.append(this.s);
        }
        if (!aVar.c(str.charAt(str.length() - 1))) {
            str2 = (str.length() == 1 || aVar.a(str.charAt(str.length() + (-2)))) ? "+" : "+";
            return sb.toString();
        }
        str2 = "-";
        sb.append(str2);
        return sb.toString();
    }

    private void C() {
        if (((c.c.a.h.j) this.e).b() == null) {
            throw new c.c.a.f.c("anchor is not specified for alias");
        }
        S("*");
        this.f1739c = this.f1738b.a();
    }

    private void D() {
        K(false, false);
        this.f1739c = new i();
    }

    private void E() {
        K(false, this.j && !this.n);
        this.f1739c = new j();
    }

    private void F() {
        Y("{", true, true, false);
        this.h++;
        K(true, false);
        if (this.q.booleanValue()) {
            X();
        }
        this.f1739c = new l();
    }

    private void G() {
        Y("[", true, true, false);
        this.h++;
        K(true, false);
        if (this.q.booleanValue()) {
            X();
        }
        this.f1739c = new m();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void H(boolean z, boolean z2, boolean z3, boolean z4) {
        this.i = z;
        this.j = z3;
        this.k = z4;
        c.c.a.h.f fVar = this.e;
        if (fVar instanceof c.c.a.h.a) {
            C();
        } else if (!(fVar instanceof c.c.a.h.k) && !(fVar instanceof c.c.a.h.c)) {
            throw new c.c.a.f.c("expected NodeEvent, but got " + this.e);
        } else {
            S("&");
            U();
            c.c.a.h.f fVar2 = this.e;
            if (fVar2 instanceof c.c.a.h.k) {
                I();
            } else if (fVar2 instanceof c.c.a.h.m) {
                if (this.h != 0 || this.p.booleanValue() || ((c.c.a.h.m) this.e).c().booleanValue() || y()) {
                    G();
                } else {
                    E();
                }
            } else if (this.h != 0 || this.p.booleanValue() || ((c.c.a.h.i) this.e).c().booleanValue() || x()) {
                F();
            } else {
                D();
            }
        }
    }

    private void I() {
        K(true, false);
        T();
        this.g = this.f.a();
        this.f1739c = this.f1738b.a();
    }

    private void K(boolean z, boolean z2) {
        int intValue;
        this.f.b(this.g);
        Integer num = this.g;
        if (num == null) {
            intValue = z ? this.s : 0;
        } else if (z2) {
            return;
        } else {
            intValue = num.intValue() + this.s;
        }
        this.g = Integer.valueOf(intValue);
    }

    private boolean L(int i2) {
        Iterator<c.c.a.h.f> it = this.f1740d.iterator();
        it.next();
        int i3 = 0;
        while (it.hasNext()) {
            c.c.a.h.f next = it.next();
            if ((next instanceof c.c.a.h.e) || (next instanceof c.c.a.h.c)) {
                i3++;
                continue;
            } else if ((next instanceof c.c.a.h.d) || (next instanceof c.c.a.h.b)) {
                i3--;
                continue;
            } else if (next instanceof c.c.a.h.n) {
                i3 = -1;
                continue;
            } else {
                continue;
            }
            if (i3 < 0) {
                return false;
            }
        }
        return this.f1740d.size() < i2 + 1;
    }

    private boolean M() {
        int i2;
        if (this.f1740d.isEmpty()) {
            return true;
        }
        c.c.a.h.f peek = this.f1740d.peek();
        if (peek instanceof c.c.a.h.e) {
            return L(1);
        }
        if (peek instanceof c.c.a.h.m) {
            i2 = 2;
        } else if (!(peek instanceof c.c.a.h.i)) {
            return false;
        } else {
            i2 = 3;
        }
        return L(i2);
    }

    static String N(String str) {
        if (str.length() != 0) {
            if (F.matcher(str).matches()) {
                return str;
            }
            throw new c.c.a.f.c("invalid character in the anchor: " + str);
        }
        throw new c.c.a.f.c("anchor must not be empty");
    }

    private String O(String str) {
        StringBuilder sb;
        if (str.length() != 0) {
            if ("!".equals(str)) {
                return str;
            }
            String str2 = null;
            for (String str3 : this.v.keySet()) {
                if (str.startsWith(str3) && ("!".equals(str3) || str3.length() < str.length())) {
                    str2 = str3;
                }
            }
            if (str2 != null) {
                str = str.substring(str2.length());
                str2 = this.v.get(str2);
            }
            int length = str.length();
            String substring = length > 0 ? str.substring(0, length) : BuildConfig.FLAVOR;
            if (str2 != null) {
                sb = new StringBuilder();
                sb.append(str2);
            } else {
                sb = new StringBuilder();
                sb.append("!<");
                sb.append(substring);
                substring = ">";
            }
            sb.append(substring);
            return sb.toString();
        }
        throw new c.c.a.f.c("tag must not be empty");
    }

    private String P(String str) {
        if (str.length() != 0) {
            if (str.charAt(0) != '!' || str.charAt(str.length() - 1) != '!') {
                throw new c.c.a.f.c("tag handle must start and end with '!': " + str);
            } else if ("!".equals(str) || E.matcher(str).matches()) {
                return str;
            } else {
                throw new c.c.a.f.c("invalid character in the tag handle: " + str);
            }
        }
        throw new c.c.a.f.c("tag handle must not be empty");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public String Q(String str) {
        if (str.length() != 0) {
            StringBuilder sb = new StringBuilder();
            int i2 = str.charAt(0) == '!' ? 1 : 0;
            while (i2 < str.length()) {
                i2++;
            }
            if (i2 > 0) {
                sb.append(str.substring(0, i2));
            }
            return sb.toString();
        }
        throw new c.c.a.f.c("tag prefix must not be empty");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public String R(Integer[] numArr) {
        Integer num = numArr[0];
        Integer num2 = numArr[1];
        if (num.intValue() == 1) {
            return num.toString() + "." + num2.toString();
        }
        throw new c.c.a.f.c("unsupported YAML version: " + numArr[0] + "." + numArr[1]);
    }

    private void S(String str) {
        c.c.a.h.j jVar = (c.c.a.h.j) this.e;
        if (jVar.b() == null) {
            this.w = null;
            return;
        }
        if (this.w == null) {
            String b2 = jVar.b();
            N(b2);
            this.w = b2;
        }
        Y(str + this.w, true, false, false);
        this.w = null;
    }

    private void T() {
        c.c.a.h.k kVar = (c.c.a.h.k) this.e;
        if (this.y == null) {
            this.y = v(kVar.f());
        }
        if (this.z == null) {
            this.z = A();
        }
        c.c.a.a aVar = this.A;
        c.c.a.f.e eVar = this.y;
        a.c a2 = a.c.a(this.z);
        aVar.a(eVar, a2);
        Character b2 = a2.b();
        this.z = b2;
        boolean z = !this.k;
        if (b2 == null) {
            b0(this.y.f1762a, z);
        } else {
            char charValue = b2.charValue();
            if (charValue == '\"') {
                V(this.y.f1762a, z);
            } else if (charValue == '\'') {
                c0(this.y.f1762a, z);
            } else if (charValue == '>') {
                W(this.y.f1762a);
            } else if (charValue == '|') {
                a0(this.y.f1762a);
            }
        }
        this.y = null;
        this.z = null;
    }

    private void U() {
        String e2;
        c.c.a.h.f fVar = this.e;
        if (fVar instanceof c.c.a.h.k) {
            c.c.a.h.k kVar = (c.c.a.h.k) fVar;
            e2 = kVar.e();
            if (this.z == null) {
                this.z = A();
            }
            if ((!this.p.booleanValue() || e2 == null) && ((this.z == null && kVar.c().b()) || (this.z != null && kVar.c().a()))) {
                this.x = null;
                return;
            } else if (kVar.c().b() && e2 == null) {
                this.x = null;
                e2 = "!";
            }
        } else {
            c.c.a.h.c cVar = (c.c.a.h.c) fVar;
            e2 = cVar.e();
            if ((!this.p.booleanValue() || e2 == null) && cVar.d()) {
                this.x = null;
                return;
            }
        }
        if (e2 == null) {
            throw new c.c.a.f.c("tag is not specified");
        }
        if (this.x == null) {
            this.x = O(e2);
        }
        Y(this.x, true, false, false);
        this.x = null;
    }

    private void V(String str, boolean z) {
        String valueOf;
        String str2;
        StringBuilder sb;
        int length;
        String substring;
        String str3;
        Y("\"", true, false, false);
        int i2 = 0;
        int i3 = 0;
        while (i2 <= str.length()) {
            Character valueOf2 = i2 < str.length() ? Character.valueOf(str.charAt(i2)) : null;
            if (valueOf2 == null || "\"\\\u0085\u2028\u2029\ufeff".indexOf(valueOf2.charValue()) != -1 || ' ' > valueOf2.charValue() || valueOf2.charValue() > '~') {
                if (i3 < i2) {
                    int i4 = i2 - i3;
                    this.l += i4;
                    this.f1737a.write(str, i3, i4);
                    i3 = i2;
                }
                if (valueOf2 != null) {
                    Map<Character, String> map = B;
                    if (map.containsKey(new Character(valueOf2.charValue()))) {
                        sb = new StringBuilder();
                        sb.append("\\");
                        substring = map.get(new Character(valueOf2.charValue()));
                    } else if (this.r) {
                        valueOf = String.valueOf(valueOf2);
                        this.l += valueOf.length();
                        this.f1737a.write(valueOf);
                        i3 = i2 + 1;
                    } else {
                        if (valueOf2.charValue() <= 255) {
                            str2 = "0" + Integer.toString(valueOf2.charValue(), 16);
                            sb = new StringBuilder();
                            sb.append("\\x");
                            length = str2.length() - 2;
                        } else {
                            str2 = "000" + Integer.toString(valueOf2.charValue(), 16);
                            sb = new StringBuilder();
                            sb.append("\\u");
                            length = str2.length() - 4;
                        }
                        substring = str2.substring(length);
                    }
                    sb.append(substring);
                    valueOf = sb.toString();
                    this.l += valueOf.length();
                    this.f1737a.write(valueOf);
                    i3 = i2 + 1;
                }
            }
            if (i2 > 0 && i2 < str.length() - 1 && ((valueOf2.charValue() == ' ' || i3 >= i2) && this.l + (i2 - i3) > this.t && z)) {
                if (i3 >= i2) {
                    str3 = "\\";
                } else {
                    str3 = str.substring(i3, i2) + "\\";
                }
                if (i3 < i2) {
                    i3 = i2;
                }
                this.l += str3.length();
                this.f1737a.write(str3);
                X();
                this.m = false;
                this.n = false;
                if (str.charAt(i3) == ' ') {
                    this.l++;
                    this.f1737a.write("\\");
                }
            }
            i2++;
        }
        Y("\"", false, false, false);
    }

    private void Z(String str) {
        this.m = true;
        this.n = true;
        this.l = 0;
        if (str == null) {
            this.f1737a.write(this.u);
        } else {
            this.f1737a.write(str);
        }
    }

    static /* synthetic */ Boolean c(b bVar) {
        return bVar.p;
    }

    /* JADX WARN: Code restructure failed: missing block: B:20:0x003b, code lost:
        if (r5 != r17.length()) goto L30;
     */
    /* JADX WARN: Code restructure failed: missing block: B:39:0x0082, code lost:
        if (r8 < r5) goto L32;
     */
    /* JADX WARN: Removed duplicated region for block: B:44:0x0095  */
    /* JADX WARN: Removed duplicated region for block: B:46:0x00a6  */
    /* JADX WARN: Removed duplicated region for block: B:55:0x00b1 A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void c0(java.lang.String r17, boolean r18) {
        /*
            r16 = this;
            r0 = r16
            r1 = r17
            java.lang.String r2 = "'"
            r3 = 1
            r4 = 0
            r0.Y(r2, r3, r4, r4)
            r5 = r4
            r6 = r5
            r7 = r6
            r8 = r7
        Lf:
            int r9 = r17.length()
            if (r5 > r9) goto Lb5
            int r9 = r17.length()
            if (r5 >= r9) goto L20
            char r9 = r1.charAt(r5)
            goto L21
        L20:
            r9 = r4
        L21:
            r10 = 32
            if (r6 == 0) goto L3e
            if (r9 == 0) goto L29
            if (r9 == r10) goto L91
        L29:
            int r11 = r8 + 1
            if (r11 != r5) goto L84
            int r11 = r0.l
            int r12 = r0.t
            if (r11 <= r12) goto L84
            if (r18 == 0) goto L84
            if (r8 == 0) goto L84
            int r11 = r17.length()
            if (r5 == r11) goto L84
            goto L74
        L3e:
            if (r7 == 0) goto L78
            if (r9 == 0) goto L4a
            c.c.a.n.a r11 = c.c.a.n.a.f1835d
            boolean r11 = r11.c(r9)
            if (r11 == 0) goto L91
        L4a:
            char r11 = r1.charAt(r8)
            r12 = 0
            r13 = 10
            if (r11 != r13) goto L56
            r0.Z(r12)
        L56:
            java.lang.String r8 = r1.substring(r8, r5)
            char[] r8 = r8.toCharArray()
            int r11 = r8.length
            r14 = r4
        L60:
            if (r14 >= r11) goto L74
            char r15 = r8[r14]
            if (r15 != r13) goto L6a
            r0.Z(r12)
            goto L71
        L6a:
            java.lang.String r15 = java.lang.String.valueOf(r15)
            r0.Z(r15)
        L71:
            int r14 = r14 + 1
            goto L60
        L74:
            r16.X()
            goto L90
        L78:
            c.c.a.n.a r11 = c.c.a.n.a.f1835d
            java.lang.String r12 = "\u0000 '"
            boolean r11 = r11.b(r9, r12)
            if (r11 == 0) goto L91
            if (r8 >= r5) goto L91
        L84:
            int r11 = r5 - r8
            int r12 = r0.l
            int r12 = r12 + r11
            r0.l = r12
            java.io.Writer r12 = r0.f1737a
            r12.write(r1, r8, r11)
        L90:
            r8 = r5
        L91:
            r11 = 39
            if (r9 != r11) goto La4
            int r8 = r0.l
            int r8 = r8 + 2
            r0.l = r8
            java.io.Writer r8 = r0.f1737a
            java.lang.String r11 = "''"
            r8.write(r11)
            int r8 = r5 + 1
        La4:
            if (r9 == 0) goto Lb1
            if (r9 != r10) goto Laa
            r6 = r3
            goto Lab
        Laa:
            r6 = r4
        Lab:
            c.c.a.n.a r7 = c.c.a.n.a.f1835d
            boolean r7 = r7.a(r9)
        Lb1:
            int r5 = r5 + 1
            goto Lf
        Lb5:
            r0.Y(r2, r4, r4, r4)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.c0(java.lang.String, boolean):void");
    }

    static /* synthetic */ boolean d(b bVar) {
        return bVar.w();
    }

    static /* synthetic */ int i(b bVar) {
        int i2 = bVar.h;
        bVar.h = i2 - 1;
        return i2;
    }

    static /* synthetic */ c.c.a.f.d j(b bVar, c.c.a.f.d dVar) {
        bVar.f1739c = dVar;
        return dVar;
    }

    static /* synthetic */ boolean o(b bVar) {
        return bVar.o;
    }

    /*  JADX ERROR: NullPointerException in pass: MarkMethodsForInline
        java.lang.NullPointerException
        	at jadx.core.dex.instructions.args.RegisterArg.sameRegAndSVar(RegisterArg.java:173)
        	at jadx.core.dex.instructions.args.InsnArg.isSameVar(InsnArg.java:269)
        	at jadx.core.dex.visitors.MarkMethodsForInline.isSyntheticAccessPattern(MarkMethodsForInline.java:118)
        	at jadx.core.dex.visitors.MarkMethodsForInline.inlineMth(MarkMethodsForInline.java:86)
        	at jadx.core.dex.visitors.MarkMethodsForInline.process(MarkMethodsForInline.java:53)
        	at jadx.core.dex.visitors.MarkMethodsForInline.visit(MarkMethodsForInline.java:37)
        */
    static /* synthetic */ java.lang.String t(c.c.a.f.b r0, java.lang.String r1) {
        /*
            r0.P(r1)
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.t(c.c.a.f.b, java.lang.String):java.lang.String");
    }

    static /* synthetic */ String u(b bVar, String str) {
        return bVar.Q(str);
    }

    /* JADX WARN: Code restructure failed: missing block: B:37:0x007c, code lost:
        if (r6 != false) goto L31;
     */
    /* JADX WARN: Code restructure failed: missing block: B:51:0x009f, code lost:
        if (r14 != false) goto L31;
     */
    /* JADX WARN: Code restructure failed: missing block: B:52:0x00a1, code lost:
        r0 = true;
        r5 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:74:0x00d8, code lost:
        if (r20.r == false) goto L51;
     */
    /* JADX WARN: Removed duplicated region for block: B:102:0x0121 A[ADDED_TO_REGION] */
    /* JADX WARN: Removed duplicated region for block: B:108:0x0133  */
    /* JADX WARN: Removed duplicated region for block: B:55:0x00ab  */
    /* JADX WARN: Removed duplicated region for block: B:81:0x00e7  */
    /* JADX WARN: Removed duplicated region for block: B:89:0x00fb  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private c.c.a.f.e v(java.lang.String r21) {
        /*
            Method dump skipped, instructions count: 403
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.v(java.lang.String):c.c.a.f.e");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean w() {
        if (!(this.e instanceof c.c.a.h.e) || this.f1740d.isEmpty()) {
            return false;
        }
        c.c.a.h.f peek = this.f1740d.peek();
        if (peek instanceof c.c.a.h.k) {
            c.c.a.h.k kVar = (c.c.a.h.k) peek;
            return kVar.b() == null && kVar.e() == null && kVar.c() != null && kVar.f() == BuildConfig.FLAVOR;
        }
        return false;
    }

    private boolean x() {
        return (this.e instanceof c.c.a.h.i) && !this.f1740d.isEmpty() && (this.f1740d.peek() instanceof c.c.a.h.h);
    }

    private boolean y() {
        return (this.e instanceof c.c.a.h.m) && !this.f1740d.isEmpty() && (this.f1740d.peek() instanceof c.c.a.h.l);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code restructure failed: missing block: B:37:0x0089, code lost:
        if (r0.f1764c == false) goto L39;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean z() {
        /*
            r5 = this;
            c.c.a.h.f r0 = r5.e
            boolean r1 = r0 instanceof c.c.a.h.j
            r2 = 0
            if (r1 == 0) goto L28
            c.c.a.h.j r0 = (c.c.a.h.j) r0
            java.lang.String r0 = r0.b()
            if (r0 == 0) goto L28
            java.lang.String r0 = r5.w
            if (r0 != 0) goto L20
            c.c.a.h.f r0 = r5.e
            c.c.a.h.j r0 = (c.c.a.h.j) r0
            java.lang.String r0 = r0.b()
            N(r0)
            r5.w = r0
        L20:
            java.lang.String r0 = r5.w
            int r0 = r0.length()
            int r0 = r0 + r2
            goto L29
        L28:
            r0 = r2
        L29:
            r1 = 0
            c.c.a.h.f r3 = r5.e
            boolean r4 = r3 instanceof c.c.a.h.k
            if (r4 == 0) goto L37
            c.c.a.h.k r3 = (c.c.a.h.k) r3
            java.lang.String r1 = r3.e()
            goto L41
        L37:
            boolean r4 = r3 instanceof c.c.a.h.c
            if (r4 == 0) goto L41
            c.c.a.h.c r3 = (c.c.a.h.c) r3
            java.lang.String r1 = r3.e()
        L41:
            if (r1 == 0) goto L54
            java.lang.String r3 = r5.x
            if (r3 != 0) goto L4d
            java.lang.String r1 = r5.O(r1)
            r5.x = r1
        L4d:
            java.lang.String r1 = r5.x
            int r1 = r1.length()
            int r0 = r0 + r1
        L54:
            c.c.a.h.f r1 = r5.e
            boolean r3 = r1 instanceof c.c.a.h.k
            if (r3 == 0) goto L73
            c.c.a.f.e r3 = r5.y
            if (r3 != 0) goto L6a
            c.c.a.h.k r1 = (c.c.a.h.k) r1
            java.lang.String r1 = r1.f()
            c.c.a.f.e r1 = r5.v(r1)
            r5.y = r1
        L6a:
            c.c.a.f.e r1 = r5.y
            java.lang.String r1 = r1.f1762a
            int r1 = r1.length()
            int r0 = r0 + r1
        L73:
            r1 = 128(0x80, float:1.794E-43)
            if (r0 >= r1) goto L98
            c.c.a.h.f r0 = r5.e
            boolean r1 = r0 instanceof c.c.a.h.a
            if (r1 != 0) goto L97
            boolean r0 = r0 instanceof c.c.a.h.k
            if (r0 == 0) goto L8b
            c.c.a.f.e r0 = r5.y
            boolean r1 = r0.f1763b
            if (r1 != 0) goto L8b
            boolean r0 = r0.f1764c
            if (r0 == 0) goto L97
        L8b:
            boolean r0 = r5.y()
            if (r0 != 0) goto L97
            boolean r0 = r5.x()
            if (r0 == 0) goto L98
        L97:
            r2 = 1
        L98:
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.z():boolean");
    }

    void J() {
        this.f1737a.flush();
    }

    /* JADX WARN: Code restructure failed: missing block: B:36:0x008c, code lost:
        if (r8 != 0) goto L47;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    void W(java.lang.String r15) {
        /*
            Method dump skipped, instructions count: 220
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.W(java.lang.String):void");
    }

    void X() {
        int i2;
        Integer num = this.g;
        int intValue = num != null ? num.intValue() : 0;
        if (!this.n || (i2 = this.l) > intValue || (i2 == intValue && !this.m)) {
            Z(null);
        }
        int i3 = this.l;
        if (i3 < intValue) {
            this.m = true;
            int i4 = intValue - i3;
            char[] cArr = new char[i4];
            for (int i5 = 0; i5 < i4; i5++) {
                cArr[i5] = ' ';
            }
            this.l = intValue;
            this.f1737a.write(cArr);
        }
    }

    void Y(String str, boolean z, boolean z2, boolean z3) {
        boolean z4 = true;
        if (!this.m && z) {
            this.l++;
            this.f1737a.write(C);
        }
        this.m = z2;
        if (!this.n || !z3) {
            z4 = false;
        }
        this.n = z4;
        this.l += str.length();
        this.o = false;
        this.f1737a.write(str);
    }

    @Override // c.c.a.f.a
    public void a(c.c.a.h.f fVar) {
        this.f1740d.add(fVar);
        while (!M()) {
            this.e = this.f1740d.poll();
            this.f1739c.a();
            this.e = null;
        }
    }

    void a0(String str) {
        char[] charArray;
        String B2 = B(str);
        boolean z = true;
        Y("|" + B2, true, false, false);
        if (B2.length() > 0 && B2.charAt(B2.length() - 1) == '+') {
            this.o = true;
        }
        Z(null);
        int i2 = 0;
        int i3 = 0;
        while (i2 <= str.length()) {
            char charAt = i2 < str.length() ? str.charAt(i2) : (char) 0;
            if (z) {
                if (charAt == 0 || c.c.a.n.a.f1835d.c(charAt)) {
                    for (char c2 : str.substring(i3, i2).toCharArray()) {
                        if (c2 == '\n') {
                            Z(null);
                        } else {
                            Z(String.valueOf(c2));
                        }
                    }
                    if (charAt != 0) {
                        X();
                    }
                    i3 = i2;
                }
            } else if (charAt == 0 || c.c.a.n.a.f1835d.a(charAt)) {
                this.f1737a.write(str, i3, i2 - i3);
                if (charAt == 0) {
                    Z(null);
                }
                i3 = i2;
            }
            if (charAt != 0) {
                z = c.c.a.n.a.f1835d.a(charAt);
            }
            i2++;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:25:0x0049, code lost:
        if (r15 != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:43:0x0090, code lost:
        if (c.c.a.n.a.f1835d.a(r6) == false) goto L28;
     */
    /* JADX WARN: Removed duplicated region for block: B:47:0x00a1  */
    /* JADX WARN: Removed duplicated region for block: B:55:0x00ac A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    void b0(java.lang.String r14, boolean r15) {
        /*
            r13 = this;
            boolean r0 = r13.i
            r1 = 1
            if (r0 == 0) goto L7
            r13.o = r1
        L7:
            int r0 = r14.length()
            if (r0 != 0) goto Le
            return
        Le:
            boolean r0 = r13.m
            if (r0 != 0) goto L1e
            int r0 = r13.l
            int r0 = r0 + r1
            r13.l = r0
            java.io.Writer r0 = r13.f1737a
            char[] r2 = c.c.a.f.b.C
            r0.write(r2)
        L1e:
            r0 = 0
            r13.m = r0
            r13.n = r0
            r2 = r0
            r3 = r2
            r4 = r3
            r5 = r4
        L27:
            int r6 = r14.length()
            if (r2 > r6) goto Lb0
            int r6 = r14.length()
            if (r2 >= r6) goto L38
            char r6 = r14.charAt(r2)
            goto L39
        L38:
            r6 = r0
        L39:
            r7 = 32
            if (r3 == 0) goto L4c
            if (r6 == r7) goto L9f
            int r8 = r5 + 1
            if (r8 != r2) goto L92
            int r8 = r13.l
            int r9 = r13.t
            if (r8 <= r9) goto L92
            if (r15 == 0) goto L92
            goto L80
        L4c:
            if (r4 == 0) goto L88
            c.c.a.n.a r8 = c.c.a.n.a.f1835d
            boolean r8 = r8.c(r6)
            if (r8 == 0) goto L9f
            char r8 = r14.charAt(r5)
            r9 = 0
            r10 = 10
            if (r8 != r10) goto L62
            r13.Z(r9)
        L62:
            java.lang.String r5 = r14.substring(r5, r2)
            char[] r5 = r5.toCharArray()
            int r8 = r5.length
            r11 = r0
        L6c:
            if (r11 >= r8) goto L80
            char r12 = r5[r11]
            if (r12 != r10) goto L76
            r13.Z(r9)
            goto L7d
        L76:
            java.lang.String r12 = java.lang.String.valueOf(r12)
            r13.Z(r12)
        L7d:
            int r11 = r11 + 1
            goto L6c
        L80:
            r13.X()
            r13.m = r0
            r13.n = r0
            goto L9e
        L88:
            if (r6 == 0) goto L92
            c.c.a.n.a r8 = c.c.a.n.a.f1835d
            boolean r8 = r8.a(r6)
            if (r8 == 0) goto L9f
        L92:
            int r8 = r2 - r5
            int r9 = r13.l
            int r9 = r9 + r8
            r13.l = r9
            java.io.Writer r9 = r13.f1737a
            r9.write(r14, r5, r8)
        L9e:
            r5 = r2
        L9f:
            if (r6 == 0) goto Lac
            if (r6 != r7) goto La5
            r3 = r1
            goto La6
        La5:
            r3 = r0
        La6:
            c.c.a.n.a r4 = c.c.a.n.a.f1835d
            boolean r4 = r4.a(r6)
        Lac:
            int r2 = r2 + 1
            goto L27
        Lb0:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: c.c.a.f.b.b0(java.lang.String, boolean):void");
    }

    void d0() {
        J();
    }

    void e0() {
    }

    void f0(String str, String str2) {
        this.f1737a.write("%TAG ");
        this.f1737a.write(str);
        this.f1737a.write(C);
        this.f1737a.write(str2);
        Z(null);
    }

    void g0(String str) {
        this.f1737a.write("%YAML ");
        this.f1737a.write(str);
        Z(null);
    }
}
