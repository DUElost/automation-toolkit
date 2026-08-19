package c.c.a.m;

import c.c.a.k.e;
import c.c.a.k.i;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
/* loaded from: classes.dex */
public class a {

    /* renamed from: b  reason: collision with root package name */
    public static final Pattern f1828b = Pattern.compile("^(?:yes|Yes|YES|no|No|NO|true|True|TRUE|false|False|FALSE|on|On|ON|off|Off|OFF)$");

    /* renamed from: c  reason: collision with root package name */
    public static final Pattern f1829c = Pattern.compile("^([-+]?(\\.[0-9]+|[0-9_]+(\\.[0-9_]*)?)([eE][-+]?[0-9]+)?|[-+]?[0-9][0-9_]*(?::[0-5]?[0-9])+\\.[0-9_]*|[-+]?\\.(?:inf|Inf|INF)|\\.(?:nan|NaN|NAN))$");

    /* renamed from: d  reason: collision with root package name */
    public static final Pattern f1830d = Pattern.compile("^(?:[-+]?0b[0-1_]+|[-+]?0[0-7_]+|[-+]?(?:0|[1-9][0-9_]*)|[-+]?0x[0-9a-fA-F_]+|[-+]?[1-9][0-9_]*(?::[0-5]?[0-9])+)$");
    public static final Pattern e = Pattern.compile("^(?:<<)$");
    public static final Pattern f = Pattern.compile("^(?:~|null|Null|NULL| )$");
    public static final Pattern g = Pattern.compile("^$");
    public static final Pattern h = Pattern.compile("^(?:[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9][0-9][0-9]-[0-9][0-9]?-[0-9][0-9]?(?:[Tt]|[ \t]+)[0-9][0-9]?:[0-9][0-9]:[0-9][0-9](?:\\.[0-9]*)?(?:[ \t]*(?:Z|[-+][0-9][0-9]?(?::[0-9][0-9])?))?)$");
    public static final Pattern i = Pattern.compile("^(?:=)$");
    public static final Pattern j = Pattern.compile("^(?:!|&|\\*)$");

    /* renamed from: a  reason: collision with root package name */
    protected Map<Character, List<b>> f1831a;

    /* renamed from: c.c.a.m.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static /* synthetic */ class C0064a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1832a;

        static {
            int[] iArr = new int[e.values().length];
            f1832a = iArr;
            try {
                iArr[e.scalar.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1832a[e.sequence.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
        }
    }

    public a() {
        this(true);
    }

    public a(boolean z) {
        this.f1831a = new HashMap();
        if (z) {
            b();
        }
    }

    public void a(i iVar, Pattern pattern, String str) {
        if (str == null) {
            List<b> list = this.f1831a.get(null);
            if (list == null) {
                list = new ArrayList<>();
                this.f1831a.put(null, list);
            }
            list.add(new b(iVar, pattern));
            return;
        }
        for (char c2 : str.toCharArray()) {
            Character ch = new Character(c2);
            if (ch.charValue() == 0) {
                ch = null;
            }
            List<b> list2 = this.f1831a.get(ch);
            if (list2 == null) {
                list2 = new ArrayList<>();
                this.f1831a.put(ch, list2);
            }
            list2.add(new b(iVar, pattern));
        }
    }

    protected void b() {
        a(i.m, f1828b, "yYnNtTfFoO");
        a(i.j, f1830d, "-+0123456789");
        a(i.k, f1829c, "-+0123456789.");
        a(i.e, e, "<");
        i iVar = i.n;
        a(iVar, f, "~nN\u0000");
        a(iVar, g, null);
        a(i.l, h, "0123456789");
        a(i.f1808d, i, "=");
        a(i.f1807c, j, "!&*");
    }

    public i c(e eVar, String str, boolean z) {
        Map<Character, List<b>> map;
        if (eVar == e.scalar && z) {
            char c2 = 0;
            if (str.length() == 0) {
                map = this.f1831a;
            } else {
                map = this.f1831a;
                c2 = str.charAt(0);
            }
            List<b> list = map.get(Character.valueOf(c2));
            if (list != null) {
                for (b bVar : list) {
                    i b2 = bVar.b();
                    if (bVar.a().matcher(str).matches()) {
                        return b2;
                    }
                }
            }
            if (this.f1831a.containsKey(null)) {
                for (b bVar2 : this.f1831a.get(null)) {
                    i b3 = bVar2.b();
                    if (bVar2.a().matcher(str).matches()) {
                        return b3;
                    }
                }
            }
        }
        int i2 = C0064a.f1832a[eVar.ordinal()];
        return i2 != 1 ? i2 != 2 ? i.q : i.p : i.o;
    }
}
