package b.e.a.i.d.c;

import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
@g(objectTypeIndication = 64, tags = {5})
/* loaded from: classes.dex */
public class a extends b.e.a.i.d.c.b {
    public static Map<Integer, Integer> X = new HashMap();
    public static Map<Integer, String> Y = new HashMap();
    public int A;
    public int B;
    public boolean C;
    public boolean D;
    public boolean E;
    public int F;
    public boolean G;
    public int H;
    public int I;
    public int J;
    public int K;
    public int L;
    public int M;
    public int N;
    public int O;
    public int P;
    public int Q;
    public int R;
    public int S;
    public int T;
    public int U;
    public boolean V;
    byte[] W;

    /* renamed from: d  reason: collision with root package name */
    public int f1555d;
    public int e;
    public int f;
    public int g;
    public int h;
    public int i;
    public boolean j;
    public boolean k;
    public int m;
    public int n;
    public int o;
    public int p;
    public int q;
    public int r;
    public int v;
    public int w;
    public int x;
    public int y;
    public int z;
    public int l = -1;
    public int s = -1;
    public int t = -1;
    public int u = -1;

    /* renamed from: b.e.a.i.d.c.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0052a {

        /* renamed from: a  reason: collision with root package name */
        public boolean f1556a;

        public C0052a(int i, c cVar) {
            int i2;
            cVar.b();
            cVar.b();
            cVar.b();
            cVar.b();
            boolean b2 = cVar.b();
            this.f1556a = b2;
            if (b2) {
                cVar.b();
                cVar.b();
                a(i, cVar);
            }
            while (cVar.a(4) != 0) {
                int a2 = cVar.a(4);
                if (a2 == 15) {
                    i2 = cVar.a(8);
                    a2 += i2;
                } else {
                    i2 = 0;
                }
                if (i2 == 255) {
                    a2 += cVar.a(16);
                }
                for (int i3 = 0; i3 < a2; i3++) {
                    cVar.a(8);
                }
            }
        }

        public void a(int i, c cVar) {
            int i2;
            switch (i) {
                case 1:
                case 2:
                    i2 = 1;
                    break;
                case 3:
                    i2 = 2;
                    break;
                case 4:
                case 5:
                case 6:
                    i2 = 3;
                    break;
                case 7:
                    i2 = 4;
                    break;
                default:
                    i2 = 0;
                    break;
            }
            for (int i3 = 0; i3 < i2; i3++) {
                new b(a.this, cVar);
            }
        }
    }

    /* loaded from: classes.dex */
    public class b {

        /* renamed from: a  reason: collision with root package name */
        public boolean f1558a;

        /* renamed from: b  reason: collision with root package name */
        public boolean f1559b;

        public b(a aVar, c cVar) {
            cVar.b();
            cVar.a(4);
            cVar.a(4);
            cVar.a(3);
            cVar.a(2);
            this.f1558a = cVar.b();
            this.f1559b = cVar.b();
            if (this.f1558a) {
                cVar.a(2);
                cVar.b();
                cVar.a(2);
            }
            if (this.f1559b) {
                cVar.a(2);
                cVar.a(2);
                cVar.b();
            }
            cVar.b();
        }
    }

    static {
        X.put(0, 96000);
        X.put(1, 88200);
        X.put(2, 64000);
        X.put(3, 48000);
        X.put(4, 44100);
        X.put(5, 32000);
        X.put(6, 24000);
        X.put(7, 22050);
        X.put(8, 16000);
        X.put(9, 12000);
        X.put(10, 11025);
        X.put(11, 8000);
        Y.put(1, "AAC main");
        Y.put(2, "AAC LC");
        Y.put(3, "AAC SSR");
        Y.put(4, "AAC LTP");
        Y.put(5, "SBR");
        Y.put(6, "AAC Scalable");
        Y.put(7, "TwinVQ");
        Y.put(8, "CELP");
        Y.put(9, "HVXC");
        Y.put(10, "(reserved)");
        Y.put(11, "(reserved)");
        Y.put(12, "TTSI");
        Y.put(13, "Main synthetic");
        Y.put(14, "Wavetable synthesis");
        Y.put(15, "General MIDI");
        Y.put(16, "Algorithmic Synthesis and Audio FX");
        Y.put(17, "ER AAC LC");
        Y.put(18, "(reserved)");
        Y.put(19, "ER AAC LTP");
        Y.put(20, "ER AAC Scalable");
        Y.put(21, "ER TwinVQ");
        Y.put(22, "ER BSAC");
        Y.put(23, "ER AAC LD");
        Y.put(24, "ER CELP");
        Y.put(25, "ER HVXC");
        Y.put(26, "ER HILN");
        Y.put(27, "ER Parametric");
        Y.put(28, "SSC");
        Y.put(29, "PS");
        Y.put(30, "MPEG Surround");
        Y.put(31, "(escape)");
        Y.put(32, "Layer-1");
        Y.put(33, "Layer-2");
        Y.put(34, "Layer-3");
        Y.put(35, "DST");
        Y.put(36, "ALS");
        Y.put(37, "SLS");
        Y.put(38, "SLS non-core");
        Y.put(39, "ER AAC ELD");
        Y.put(40, "SMR Simple");
        Y.put(41, "SMR Main");
    }

    public a() {
        this.f1560a = 5;
    }

    private int g() {
        int i = (this.w == 1 ? 16 : 2) + 1;
        if (this.h != 0) {
            int i2 = this.f1555d;
            if (i2 == 6 || i2 == 20) {
                i += 3;
            }
            if (this.y == 1) {
                if (i2 == 22) {
                    i = i + 5 + 11;
                }
                if (i2 == 17 || i2 == 19 || i2 == 20 || i2 == 23) {
                    i = i + 1 + 1 + 1;
                }
                i++;
                if (this.F == 1) {
                    throw new RuntimeException("Not implemented");
                }
            }
            return i;
        }
        throw new UnsupportedOperationException("can't parse program_config_element yet");
    }

    private int h(c cVar) {
        int a2 = cVar.a(5);
        return a2 == 31 ? cVar.a(6) + 32 : a2;
    }

    private void i(int i, int i2, int i3, c cVar) {
        this.K = cVar.a(1);
        this.L = cVar.a(2);
        int a2 = cVar.a(1);
        this.M = a2;
        if (a2 == 1) {
            this.N = cVar.a(1);
        }
    }

    private void j(int i, int i2, int i3, c cVar) {
        this.v = cVar.a(1);
        int a2 = cVar.a(1);
        this.w = a2;
        if (a2 == 1) {
            this.x = cVar.a(14);
        }
        this.y = cVar.a(1);
        if (i2 == 0) {
            throw new UnsupportedOperationException("can't parse program_config_element yet");
        }
        if (i3 == 6 || i3 == 20) {
            this.z = cVar.a(3);
        }
        if (this.y == 1) {
            if (i3 == 22) {
                this.A = cVar.a(5);
                this.B = cVar.a(11);
            }
            if (i3 == 17 || i3 == 19 || i3 == 20 || i3 == 23) {
                this.C = cVar.b();
                this.D = cVar.b();
                this.E = cVar.b();
            }
            int a3 = cVar.a(1);
            this.F = a3;
            if (a3 == 1) {
                throw new RuntimeException("not yet implemented");
            }
        }
        this.G = true;
    }

    private void k(int i, int i2, int i3, c cVar) {
        this.O = cVar.a(1);
        this.P = cVar.a(8);
        this.Q = cVar.a(4);
        this.R = cVar.a(12);
        this.S = cVar.a(2);
    }

    private void l(int i, int i2, int i3, c cVar) {
        int a2 = cVar.a(1);
        this.T = a2;
        if (a2 == 1) {
            this.U = cVar.a(2);
        }
    }

    private void m(int i, int i2, int i3, c cVar) {
        int a2 = cVar.a(2);
        this.I = a2;
        if (a2 != 1) {
            i(i, i2, i3, cVar);
        }
        if (this.I != 0) {
            k(i, i2, i3, cVar);
        }
        this.J = cVar.a(1);
        this.V = true;
    }

    private void n(int i, int i2, int i3, c cVar) {
        int a2 = cVar.a(1);
        this.H = a2;
        if (a2 == 1) {
            m(i, i2, i3, cVar);
        } else {
            l(i, i2, i3, cVar);
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:69:0x011b  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private java.nio.ByteBuffer p() {
        /*
            Method dump skipped, instructions count: 500
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: b.e.a.i.d.c.a.p():java.nio.ByteBuffer");
    }

    private void q(int i, d dVar) {
        int i2 = 5;
        if (i >= 32) {
            dVar.a(31, 5);
            i -= 32;
            i2 = 6;
        }
        dVar.a(i, i2);
    }

    private void r(d dVar) {
        dVar.a(this.v, 1);
        dVar.a(this.w, 1);
        if (this.w == 1) {
            dVar.a(this.x, 14);
        }
        dVar.a(this.y, 1);
        if (this.h == 0) {
            throw new UnsupportedOperationException("can't parse program_config_element yet");
        }
        int i = this.f1555d;
        if (i == 6 || i == 20) {
            dVar.a(this.z, 3);
        }
        if (this.y == 1) {
            if (this.f1555d == 22) {
                dVar.a(this.A, 5);
                dVar.a(this.B, 11);
            }
            int i2 = this.f1555d;
            if (i2 == 17 || i2 == 19 || i2 == 20 || i2 == 23) {
                dVar.b(this.C);
                dVar.b(this.D);
                dVar.b(this.E);
            }
            dVar.a(this.F, 1);
            if (this.F == 1) {
                throw new RuntimeException("not yet implemented");
            }
        }
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        int i = (this.e > 30 ? 11 : 5) + 4;
        if (this.f == 15) {
            i += 24;
        }
        int i2 = i + 4;
        int i3 = this.f1555d;
        if (i3 == 5 || i3 == 29) {
            i2 += 4;
            if (this.l == 15) {
                i2 += 24;
            }
        }
        if (i3 == 22) {
            i2 += 4;
        }
        if (this.G) {
            i2 += g();
        }
        int i4 = this.u;
        if (i4 >= 0) {
            i2 += 11;
            if (i4 == 695) {
                i2 += 5;
                int i5 = this.i;
                if (i5 > 30) {
                    i2 += 6;
                }
                if (i5 == 5) {
                    i2++;
                    if (this.j) {
                        i2 += 4;
                        if (this.l == 15) {
                            i2 += 24;
                        }
                        int i6 = this.t;
                        if (i6 >= 0) {
                            i2 += 11;
                            if (i6 == 1352) {
                                i2++;
                            }
                        }
                    }
                }
                if (i5 == 22) {
                    int i7 = i2 + 1;
                    if (this.j) {
                        i7 += 4;
                        if (this.l == 15) {
                            i7 += 24;
                        }
                    }
                    i2 = i7 + 4;
                }
            }
        }
        return (int) Math.ceil(i2 / 8.0d);
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        ByteBuffer slice = byteBuffer.slice();
        slice.limit(this.f1561b);
        byteBuffer.position(byteBuffer.position() + this.f1561b);
        byte[] bArr = new byte[this.f1561b];
        this.W = bArr;
        slice.get(bArr);
        slice.rewind();
        c cVar = new c(slice);
        int h = h(cVar);
        this.f1555d = h;
        this.e = h;
        int a2 = cVar.a(4);
        this.f = a2;
        if (a2 == 15) {
            this.g = cVar.a(24);
        }
        this.h = cVar.a(4);
        int i = this.f1555d;
        if (i == 5 || i == 29) {
            this.i = 5;
            this.j = true;
            if (i == 29) {
                this.k = true;
            }
            int a3 = cVar.a(4);
            this.l = a3;
            if (a3 == 15) {
                this.m = cVar.a(24);
            }
            int h2 = h(cVar);
            this.f1555d = h2;
            if (h2 == 22) {
                this.n = cVar.a(4);
            }
        } else {
            this.i = 0;
        }
        int i2 = this.f1555d;
        switch (i2) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 6:
            case 7:
            case 17:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
                j(this.f, this.h, i2, cVar);
                break;
            case 8:
                throw new UnsupportedOperationException("can't parse CelpSpecificConfig yet");
            case 9:
                throw new UnsupportedOperationException("can't parse HvxcSpecificConfig yet");
            case 12:
                throw new UnsupportedOperationException("can't parse TTSSpecificConfig yet");
            case 13:
            case 14:
            case 15:
            case 16:
                throw new UnsupportedOperationException("can't parse StructuredAudioSpecificConfig yet");
            case 24:
                throw new UnsupportedOperationException("can't parse ErrorResilientCelpSpecificConfig yet");
            case 25:
                throw new UnsupportedOperationException("can't parse ErrorResilientHvxcSpecificConfig yet");
            case 26:
            case 27:
                n(this.f, this.h, i2, cVar);
                break;
            case 28:
                throw new UnsupportedOperationException("can't parse SSCSpecificConfig yet");
            case 30:
                this.o = cVar.a(1);
                throw new UnsupportedOperationException("can't parse SpatialSpecificConfig yet");
            case 32:
            case 33:
            case 34:
                throw new UnsupportedOperationException("can't parse MPEG_1_2_SpecificConfig yet");
            case 35:
                throw new UnsupportedOperationException("can't parse DSTSpecificConfig yet");
            case 36:
                this.p = cVar.a(5);
                throw new UnsupportedOperationException("can't parse ALSSpecificConfig yet");
            case 37:
            case 38:
                throw new UnsupportedOperationException("can't parse SLSSpecificConfig yet");
            case 39:
                new C0052a(this.h, cVar);
                break;
            case 40:
            case 41:
                throw new UnsupportedOperationException("can't parse SymbolicMusicSpecificConfig yet");
        }
        int i3 = this.f1555d;
        if (i3 != 17 && i3 != 39) {
            switch (i3) {
                case 19:
                case 20:
                case 21:
                case 22:
                case 23:
                case 24:
                case 25:
                case 26:
                case 27:
                    break;
                default:
                    if (this.i != 5 || cVar.c() < 16) {
                    }
                    int a4 = cVar.a(11);
                    this.s = a4;
                    this.u = a4;
                    if (a4 == 695) {
                        int h3 = h(cVar);
                        this.i = h3;
                        if (h3 == 5) {
                            boolean b2 = cVar.b();
                            this.j = b2;
                            if (b2) {
                                int a5 = cVar.a(4);
                                this.l = a5;
                                if (a5 == 15) {
                                    this.m = cVar.a(24);
                                }
                                if (cVar.c() >= 12) {
                                    int a6 = cVar.a(11);
                                    this.s = a6;
                                    this.t = a6;
                                    if (a6 == 1352) {
                                        this.k = cVar.b();
                                    }
                                }
                            }
                        }
                        if (this.i == 22) {
                            boolean b3 = cVar.b();
                            this.j = b3;
                            if (b3) {
                                int a7 = cVar.a(4);
                                this.l = a7;
                                if (a7 == 15) {
                                    this.m = cVar.a(24);
                                }
                            }
                            this.n = cVar.a(4);
                            return;
                        }
                        return;
                    }
                    return;
            }
        }
        int a8 = cVar.a(2);
        this.q = a8;
        if (a8 == 2 || a8 == 3) {
            throw new UnsupportedOperationException("can't parse ErrorProtectionSpecificConfig yet");
        }
        if (a8 == 3) {
            int a9 = cVar.a(1);
            this.r = a9;
            if (a9 == 0) {
                throw new RuntimeException("not implemented");
            }
        }
        if (this.i != 5) {
        }
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || a.class != obj.getClass()) {
            return false;
        }
        a aVar = (a) obj;
        return this.D == aVar.D && this.C == aVar.C && this.E == aVar.E && this.f1555d == aVar.f1555d && this.h == aVar.h && this.x == aVar.x && this.w == aVar.w && this.r == aVar.r && this.q == aVar.q && this.M == aVar.M && this.i == aVar.i && this.n == aVar.n && this.y == aVar.y && this.F == aVar.F && this.m == aVar.m && this.l == aVar.l && this.p == aVar.p && this.v == aVar.v && this.G == aVar.G && this.S == aVar.S && this.T == aVar.T && this.U == aVar.U && this.R == aVar.R && this.P == aVar.P && this.O == aVar.O && this.Q == aVar.Q && this.L == aVar.L && this.K == aVar.K && this.H == aVar.H && this.z == aVar.z && this.B == aVar.B && this.A == aVar.A && this.J == aVar.J && this.I == aVar.I && this.V == aVar.V && this.k == aVar.k && this.o == aVar.o && this.g == aVar.g && this.f == aVar.f && this.j == aVar.j && this.s == aVar.s && this.N == aVar.N && Arrays.equals(this.W, aVar.W);
    }

    public int hashCode() {
        byte[] bArr = this.W;
        return ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((bArr != null ? Arrays.hashCode(bArr) : 0) * 31) + this.f1555d) * 31) + this.f) * 31) + this.g) * 31) + this.h) * 31) + this.i) * 31) + (this.j ? 1 : 0)) * 31) + (this.k ? 1 : 0)) * 31) + this.l) * 31) + this.m) * 31) + this.n) * 31) + this.o) * 31) + this.p) * 31) + this.q) * 31) + this.r) * 31) + this.s) * 31) + this.v) * 31) + this.w) * 31) + this.x) * 31) + this.y) * 31) + this.z) * 31) + this.A) * 31) + this.B) * 31) + (this.C ? 1 : 0)) * 31) + (this.D ? 1 : 0)) * 31) + (this.E ? 1 : 0)) * 31) + this.F) * 31) + (this.G ? 1 : 0)) * 31) + this.H) * 31) + this.I) * 31) + this.J) * 31) + this.K) * 31) + this.L) * 31) + this.M) * 31) + this.N) * 31) + this.O) * 31) + this.P) * 31) + this.Q) * 31) + this.R) * 31) + this.S) * 31) + this.T) * 31) + this.U) * 31) + (this.V ? 1 : 0);
    }

    public ByteBuffer o() {
        ByteBuffer allocate = ByteBuffer.allocate(b());
        b.c.a.f.j(allocate, this.f1560a);
        f(allocate, a());
        allocate.put(p());
        return (ByteBuffer) allocate.rewind();
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("AudioSpecificConfig");
        sb.append("{configBytes=");
        sb.append(b.c.a.c.a(this.W));
        sb.append(", audioObjectType=");
        sb.append(this.f1555d);
        sb.append(" (");
        sb.append(Y.get(Integer.valueOf(this.f1555d)));
        sb.append(")");
        sb.append(", samplingFrequencyIndex=");
        sb.append(this.f);
        sb.append(" (");
        sb.append(X.get(Integer.valueOf(this.f)));
        sb.append(")");
        sb.append(", samplingFrequency=");
        sb.append(this.g);
        sb.append(", channelConfiguration=");
        sb.append(this.h);
        if (this.i > 0) {
            sb.append(", extensionAudioObjectType=");
            sb.append(this.i);
            sb.append(" (");
            sb.append(Y.get(Integer.valueOf(this.i)));
            sb.append(")");
            sb.append(", sbrPresentFlag=");
            sb.append(this.j);
            sb.append(", psPresentFlag=");
            sb.append(this.k);
            sb.append(", extensionSamplingFrequencyIndex=");
            sb.append(this.l);
            sb.append(" (");
            sb.append(X.get(Integer.valueOf(this.l)));
            sb.append(")");
            sb.append(", extensionSamplingFrequency=");
            sb.append(this.m);
            sb.append(", extensionChannelConfiguration=");
            sb.append(this.n);
        }
        sb.append(", syncExtensionType=");
        sb.append(this.s);
        if (this.G) {
            sb.append(", frameLengthFlag=");
            sb.append(this.v);
            sb.append(", dependsOnCoreCoder=");
            sb.append(this.w);
            sb.append(", coreCoderDelay=");
            sb.append(this.x);
            sb.append(", extensionFlag=");
            sb.append(this.y);
            sb.append(", layerNr=");
            sb.append(this.z);
            sb.append(", numOfSubFrame=");
            sb.append(this.A);
            sb.append(", layer_length=");
            sb.append(this.B);
            sb.append(", aacSectionDataResilienceFlag=");
            sb.append(this.C);
            sb.append(", aacScalefactorDataResilienceFlag=");
            sb.append(this.D);
            sb.append(", aacSpectralDataResilienceFlag=");
            sb.append(this.E);
            sb.append(", extensionFlag3=");
            sb.append(this.F);
        }
        if (this.V) {
            sb.append(", isBaseLayer=");
            sb.append(this.H);
            sb.append(", paraMode=");
            sb.append(this.I);
            sb.append(", paraExtensionFlag=");
            sb.append(this.J);
            sb.append(", hvxcVarMode=");
            sb.append(this.K);
            sb.append(", hvxcRateMode=");
            sb.append(this.L);
            sb.append(", erHvxcExtensionFlag=");
            sb.append(this.M);
            sb.append(", var_ScalableFlag=");
            sb.append(this.N);
            sb.append(", hilnQuantMode=");
            sb.append(this.O);
            sb.append(", hilnMaxNumLine=");
            sb.append(this.P);
            sb.append(", hilnSampleRateCode=");
            sb.append(this.Q);
            sb.append(", hilnFrameLength=");
            sb.append(this.R);
            sb.append(", hilnContMode=");
            sb.append(this.S);
            sb.append(", hilnEnhaLayer=");
            sb.append(this.T);
            sb.append(", hilnEnhaQuantMode=");
            sb.append(this.U);
        }
        sb.append('}');
        return sb.toString();
    }
}
