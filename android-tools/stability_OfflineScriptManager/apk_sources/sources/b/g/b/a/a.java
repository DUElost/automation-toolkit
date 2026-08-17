package b.g.b.a;

import java.math.BigInteger;
import java.util.Arrays;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    public byte[] f1633a = new byte[0];

    /* renamed from: b  reason: collision with root package name */
    public j[] f1634b = null;

    /* renamed from: b.g.b.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private abstract class AbstractC0054a implements j {
        private AbstractC0054a(a aVar) {
        }

        /* synthetic */ AbstractC0054a(a aVar, AbstractC0054a abstractC0054a) {
            this(aVar);
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || getClass() != obj.getClass()) {
                return false;
            }
            j jVar = (j) obj;
            return clear() == jVar.clear() && a() == jVar.a();
        }

        public String toString() {
            return "P(" + clear() + "|" + a() + ")";
        }
    }

    /* loaded from: classes.dex */
    private class b extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private byte f1635a;

        /* renamed from: b  reason: collision with root package name */
        private byte f1636b;

        public b(a aVar, int i, long j) {
            super(aVar, null);
            this.f1635a = (byte) i;
            this.f1636b = (byte) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1636b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1635a;
        }
    }

    /* loaded from: classes.dex */
    private class c extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private byte f1637a;

        /* renamed from: b  reason: collision with root package name */
        private int f1638b;

        public c(a aVar, int i, long j) {
            super(aVar, null);
            this.f1637a = (byte) i;
            this.f1638b = (int) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1638b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1637a;
        }
    }

    /* loaded from: classes.dex */
    private class d extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private byte f1639a;

        /* renamed from: b  reason: collision with root package name */
        private long f1640b;

        public d(a aVar, int i, long j) {
            super(aVar, null);
            this.f1639a = (byte) i;
            this.f1640b = j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1640b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1639a;
        }
    }

    /* loaded from: classes.dex */
    private class e extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private byte f1641a;

        /* renamed from: b  reason: collision with root package name */
        private short f1642b;

        public e(a aVar, int i, long j) {
            super(aVar, null);
            this.f1641a = (byte) i;
            this.f1642b = (short) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1642b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1641a;
        }
    }

    /* loaded from: classes.dex */
    private class f extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private int f1643a;

        /* renamed from: b  reason: collision with root package name */
        private byte f1644b;

        public f(a aVar, int i, long j) {
            super(aVar, null);
            this.f1643a = i;
            this.f1644b = (byte) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1644b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1643a;
        }
    }

    /* loaded from: classes.dex */
    private class g extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private int f1645a;

        /* renamed from: b  reason: collision with root package name */
        private int f1646b;

        public g(a aVar, int i, long j) {
            super(aVar, null);
            this.f1645a = i;
            this.f1646b = (int) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1646b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1645a;
        }
    }

    /* loaded from: classes.dex */
    private class h extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private int f1647a;

        /* renamed from: b  reason: collision with root package name */
        private long f1648b;

        public h(a aVar, int i, long j) {
            super(aVar, null);
            this.f1647a = i;
            this.f1648b = j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1648b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1647a;
        }
    }

    /* loaded from: classes.dex */
    private class i extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private int f1649a;

        /* renamed from: b  reason: collision with root package name */
        private short f1650b;

        public i(a aVar, int i, long j) {
            super(aVar, null);
            this.f1649a = i;
            this.f1650b = (short) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1650b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1649a;
        }
    }

    /* loaded from: classes.dex */
    public interface j {
        long a();

        int clear();
    }

    /* loaded from: classes.dex */
    private class k extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private short f1651a;

        /* renamed from: b  reason: collision with root package name */
        private byte f1652b;

        public k(a aVar, int i, long j) {
            super(aVar, null);
            this.f1651a = (short) i;
            this.f1652b = (byte) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1652b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1651a;
        }
    }

    /* loaded from: classes.dex */
    private class l extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private short f1653a;

        /* renamed from: b  reason: collision with root package name */
        private int f1654b;

        public l(a aVar, int i, long j) {
            super(aVar, null);
            this.f1653a = (short) i;
            this.f1654b = (int) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1654b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1653a;
        }
    }

    /* loaded from: classes.dex */
    private class m extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private short f1655a;

        /* renamed from: b  reason: collision with root package name */
        private long f1656b;

        public m(a aVar, int i, long j) {
            super(aVar, null);
            this.f1655a = (short) i;
            this.f1656b = j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1656b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1655a;
        }
    }

    /* loaded from: classes.dex */
    private class n extends AbstractC0054a {

        /* renamed from: a  reason: collision with root package name */
        private short f1657a;

        /* renamed from: b  reason: collision with root package name */
        private short f1658b;

        public n(a aVar, int i, long j) {
            super(aVar, null);
            this.f1657a = (short) i;
            this.f1658b = (short) j;
        }

        @Override // b.g.b.a.a.j
        public long a() {
            return this.f1658b;
        }

        @Override // b.g.b.a.a.j
        public int clear() {
            return this.f1657a;
        }
    }

    public j a(int i2, long j2) {
        if (i2 <= 127) {
            return j2 <= 127 ? new b(this, i2, j2) : j2 <= 32767 ? new e(this, i2, j2) : j2 <= 2147483647L ? new c(this, i2, j2) : new d(this, i2, j2);
        }
        int i3 = (j2 > 127L ? 1 : (j2 == 127L ? 0 : -1));
        return i2 <= 32767 ? i3 <= 0 ? new k(this, i2, j2) : j2 <= 32767 ? new n(this, i2, j2) : j2 <= 2147483647L ? new l(this, i2, j2) : new m(this, i2, j2) : i3 <= 0 ? new f(this, i2, j2) : j2 <= 32767 ? new i(this, i2, j2) : j2 <= 2147483647L ? new g(this, i2, j2) : new h(this, i2, j2);
    }

    public int b() {
        int length = this.f1633a.length;
        j[] jVarArr = this.f1634b;
        return (jVarArr == null || jVarArr.length <= 0) ? length : length + 2 + (jVarArr.length * 6);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || a.class != obj.getClass()) {
            return false;
        }
        a aVar = (a) obj;
        if (new BigInteger(this.f1633a).equals(new BigInteger(aVar.f1633a))) {
            j[] jVarArr = this.f1634b;
            j[] jVarArr2 = aVar.f1634b;
            return jVarArr == null ? jVarArr2 == null : Arrays.equals(jVarArr, jVarArr2);
        }
        return false;
    }

    public int hashCode() {
        byte[] bArr = this.f1633a;
        int hashCode = (bArr != null ? Arrays.hashCode(bArr) : 0) * 31;
        j[] jVarArr = this.f1634b;
        return hashCode + (jVarArr != null ? Arrays.hashCode(jVarArr) : 0);
    }

    public String toString() {
        return "Entry{iv=" + b.c.a.c.a(this.f1633a) + ", pairs=" + Arrays.toString(this.f1634b) + '}';
    }
}
