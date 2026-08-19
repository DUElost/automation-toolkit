package d.n.i;

import d.f;
import d.l;
import d.n.e;
import d.r.d;
import d.s.g;
import java.io.PrintStream;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
/* loaded from: classes.dex */
public abstract class a {

    /* renamed from: a  reason: collision with root package name */
    protected final f f2609a;

    /* renamed from: b  reason: collision with root package name */
    private d.s.a f2610b;

    /* renamed from: c  reason: collision with root package name */
    private d.s.a f2611c;

    /* renamed from: d  reason: collision with root package name */
    public final e f2612d = new e();
    public final e e = new e();
    protected final d.n.f f;
    private final d.n.j.a g;
    protected String h;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: d.n.i.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0108a implements e.a {
        C0108a() {
        }

        @Override // d.n.e.a
        public int a(String str, byte[] bArr, String str2) {
            if ("Identity".equals(str)) {
                a aVar = a.this;
                if (aVar.f2609a.t) {
                    aVar.v(bArr);
                    return 0;
                }
            }
            return "Socket-Type".equals(str) ? !d.a(a.this.f2609a.j, str2) ? 22 : 0 : a.this.r(str, bArr) == -1 ? -1 : 0;
        }
    }

    /* loaded from: classes.dex */
    public enum b {
        HANDSHAKING,
        READY,
        ERROR;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static b[] valuesCustom() {
            b[] valuesCustom = values();
            int length = valuesCustom.length;
            b[] bVarArr = new b[length];
            System.arraycopy(valuesCustom, 0, bVarArr, 0, length);
            return bVarArr;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public a(d.n.f fVar, d.n.j.a aVar, f fVar2) {
        this.f = fVar;
        this.f2609a = fVar2;
        this.g = aVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void v(byte[] bArr) {
        this.f2610b = d.s.a.b(bArr);
    }

    private void w(byte[] bArr) {
        this.f2611c = d.s.a.b(bArr);
        this.f2612d.d("User-Id", new String(bArr, l.f2560c));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void b(ByteBuffer byteBuffer, String str, String str2) {
        c(byteBuffer, str, str2.getBytes(l.f2560c));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void c(ByteBuffer byteBuffer, String str, byte[] bArr) {
        byte[] bytes = str.getBytes(l.f2560c);
        int length = bytes.length;
        int length2 = bArr == null ? 0 : bArr.length;
        byteBuffer.put((byte) length);
        byteBuffer.put(bytes);
        g.d(byteBuffer, length2);
        if (bArr != null) {
            byteBuffer.put(bArr);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void d(d.e eVar, String str, String str2) {
        e(eVar, str, str2.getBytes(l.f2560c));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void e(d.e eVar, String str, byte[] bArr) {
        byte[] bytes = str.getBytes(l.f2560c);
        int length = bytes.length;
        int length2 = bArr == null ? 0 : bArr.length;
        eVar.p((byte) length);
        eVar.u(bytes);
        g.e(eVar, length2);
        if (bArr != null) {
            eVar.u(bArr);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void f(d.e eVar, String str) {
        eVar.p((byte) str.length());
        eVar.u(str.getBytes(l.f2560c));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public boolean g(ByteBuffer byteBuffer, byte[] bArr, int i, int i2) {
        if (i2 > bArr.length) {
            return false;
        }
        boolean z = true;
        for (int i3 = 0; i3 < i2; i3++) {
            z = byteBuffer.get(i3 + i) == bArr[i3];
            if (!z) {
                break;
            }
        }
        return z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public boolean h(d.e eVar, String str, boolean z) {
        if (eVar.B() < str.length() + (z ? 1 : 0)) {
            return false;
        }
        boolean z2 = !z || eVar.e(0) == str.length();
        if (z2) {
            for (int i = z ? 1 : 0; i < str.length(); i++) {
                z2 = eVar.e(i) == str.charAt(i - (z ? 1 : 0));
                if (!z2) {
                    break;
                }
            }
        }
        return z2;
    }

    public d.e i(d.e eVar) {
        return eVar;
    }

    public void j() {
    }

    public d.e k(d.e eVar) {
        return eVar;
    }

    public final d.s.a l() {
        return this.f2611c;
    }

    public abstract int m(d.e eVar);

    /* JADX INFO: Access modifiers changed from: protected */
    public final int n(ByteBuffer byteBuffer, int i, boolean z) {
        return (z ? this.f2612d : this.e).c(byteBuffer, i, new C0108a());
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final int o(d.e eVar, int i, boolean z) {
        return n(eVar.a(), i, z);
    }

    public final d.e p() {
        d.s.a aVar = this.f2610b;
        d.e eVar = new d.e(aVar == null ? 0 : aVar.e());
        eVar.v(this.f2610b.d(), 0, this.f2610b.e());
        eVar.y(64);
        return eVar;
    }

    public abstract int q(d.e eVar);

    protected int r(String str, byte[] bArr) {
        return 0;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void s(String str) {
        PrintStream printStream = System.out;
        printStream.println(this.f + " " + str);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* JADX WARN: Code restructure failed: missing block: B:10:0x0030, code lost:
        return 156384820;
     */
    /* JADX WARN: Code restructure failed: missing block: B:9:0x002d, code lost:
        s(r0);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final int t() {
        /*
            Method dump skipped, instructions count: 256
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: d.n.i.a.t():int");
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void u(d.n.i.b bVar, boolean z) {
        d.e eVar = new d.e();
        eVar.y(1);
        this.f.U0(eVar);
        d.e eVar2 = new d.e(3);
        eVar2.y(1);
        Charset charset = l.f2560c;
        eVar2.u("1.0".getBytes(charset));
        this.f.U0(eVar2);
        d.e eVar3 = new d.e(1);
        eVar3.y(1);
        eVar3.u("1".getBytes(charset));
        this.f.U0(eVar3);
        d.e eVar4 = new d.e(this.f2609a.D.length());
        eVar4.y(1);
        eVar4.u(this.f2609a.D.getBytes(charset));
        this.f.U0(eVar4);
        byte[] bytes = this.g.b().getBytes(charset);
        d.e eVar5 = new d.e(bytes.length);
        eVar5.y(1);
        eVar5.u(bytes);
        this.f.U0(eVar5);
        d.e eVar6 = new d.e(this.f2609a.f2550d);
        eVar6.y(1);
        f fVar = this.f2609a;
        eVar6.v(fVar.e, 0, fVar.f2550d);
        this.f.U0(eVar6);
        d.e eVar7 = new d.e(bVar.name().length());
        eVar7.u(bVar.name().getBytes(charset));
        if (z) {
            eVar7.y(1);
        }
        this.f.U0(eVar7);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final String x(int i) {
        return d.g(this.f2609a.j);
    }

    public abstract b y();

    public abstract int z();
}
