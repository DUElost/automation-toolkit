package c.c.a.k;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
/* loaded from: classes.dex */
public final class i implements Comparable<i> {

    /* renamed from: c  reason: collision with root package name */
    public static final i f1807c = new i("tag:yaml.org,2002:yaml");

    /* renamed from: d  reason: collision with root package name */
    public static final i f1808d = new i("tag:yaml.org,2002:value");
    public static final i e = new i("tag:yaml.org,2002:merge");
    public static final i f = new i("tag:yaml.org,2002:set");
    public static final i g = new i("tag:yaml.org,2002:pairs");
    public static final i h = new i("tag:yaml.org,2002:omap");
    public static final i i = new i("tag:yaml.org,2002:binary");
    public static final i j;
    public static final i k;
    public static final i l;
    public static final i m;
    public static final i n;
    public static final i o;
    public static final i p;
    public static final i q;
    public static final Map<i, Set<Class<?>>> r;

    /* renamed from: b  reason: collision with root package name */
    private final String f1809b;

    static {
        i iVar = new i("tag:yaml.org,2002:int");
        j = iVar;
        i iVar2 = new i("tag:yaml.org,2002:float");
        k = iVar2;
        i iVar3 = new i("tag:yaml.org,2002:timestamp");
        l = iVar3;
        m = new i("tag:yaml.org,2002:bool");
        n = new i("tag:yaml.org,2002:null");
        o = new i("tag:yaml.org,2002:str");
        p = new i("tag:yaml.org,2002:seq");
        q = new i("tag:yaml.org,2002:map");
        HashMap hashMap = new HashMap();
        r = hashMap;
        HashSet hashSet = new HashSet();
        hashSet.add(Double.class);
        hashSet.add(Float.class);
        hashSet.add(BigDecimal.class);
        hashMap.put(iVar2, hashSet);
        HashSet hashSet2 = new HashSet();
        hashSet2.add(Integer.class);
        hashSet2.add(Long.class);
        hashSet2.add(BigInteger.class);
        hashMap.put(iVar, hashSet2);
        HashSet hashSet3 = new HashSet();
        hashSet3.add(Date.class);
        hashSet3.add(java.sql.Date.class);
        hashSet3.add(Timestamp.class);
        hashMap.put(iVar3, hashSet3);
    }

    public i(Class<? extends Object> cls) {
        Objects.requireNonNull(cls, "Class for tag must be provided.");
        this.f1809b = "tag:yaml.org,2002:" + c.c.a.p.b.a(cls.getName());
    }

    public i(String str) {
        Objects.requireNonNull(str, "Tag must be provided.");
        if (str.length() == 0) {
            throw new IllegalArgumentException("Tag must not be empty.");
        }
        if (str.trim().length() != str.length()) {
            throw new IllegalArgumentException("Tag must not contain leading or trailing spaces.");
        }
        this.f1809b = c.c.a.p.b.a(str);
    }

    @Override // java.lang.Comparable
    /* renamed from: a */
    public int compareTo(i iVar) {
        return this.f1809b.compareTo(iVar.b());
    }

    public String b() {
        return this.f1809b;
    }

    public boolean c(Class<? extends Object> cls) {
        String str = this.f1809b;
        return str.equals("tag:yaml.org,2002:" + cls.getName());
    }

    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (obj instanceof i) {
            return this.f1809b.equals(((i) obj).b());
        }
        if ((obj instanceof String) && this.f1809b.equals(obj.toString())) {
            System.err.println("Comparing Tag and String is deprecated.");
            return true;
        }
        return false;
    }

    public int hashCode() {
        return this.f1809b.hashCode();
    }

    public String toString() {
        return this.f1809b;
    }
}
