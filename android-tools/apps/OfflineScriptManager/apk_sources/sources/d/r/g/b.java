package d.r.g;

import java.nio.ByteBuffer;
import java.util.HashSet;
import java.util.Set;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class b {

    /* renamed from: b  reason: collision with root package name */
    private int f2708b = 0;

    /* renamed from: c  reason: collision with root package name */
    private int f2709c = 0;

    /* renamed from: d  reason: collision with root package name */
    private int f2710d = 0;

    /* renamed from: a  reason: collision with root package name */
    private Set<d.p.b> f2707a = null;
    private b[] e = null;

    /* loaded from: classes.dex */
    public interface a {
        void a(d.p.b bVar, byte[] bArr, int i, f fVar);
    }

    private boolean b(d.e eVar, int i, int i2, d.p.b bVar) {
        b bVar2;
        if (i2 == 0) {
            Set<d.p.b> set = this.f2707a;
            boolean z = set == null;
            if (set == null) {
                this.f2707a = new HashSet();
            }
            this.f2707a.add(bVar);
            return z;
        }
        byte e = eVar.e(i);
        int i3 = this.f2708b;
        if (e < i3 || e >= this.f2709c + i3) {
            int i4 = this.f2709c;
            if (i4 == 0) {
                this.f2708b = e;
                this.f2709c = 1;
                this.e = null;
            } else if (i4 == 1) {
                b bVar3 = this.e[0];
                int i5 = (i3 < e ? e - i3 : i3 - e) + 1;
                this.f2709c = i5;
                this.e = new b[i5];
                int min = Math.min(i3, (int) e);
                this.f2708b = min;
                this.e[i3 - min] = bVar3;
            } else if (i3 < e) {
                int i6 = (e - i3) + 1;
                this.f2709c = i6;
                this.e = f(this.e, i6, true);
            } else {
                int i7 = (i3 + i4) - e;
                this.f2709c = i7;
                this.e = f(this.e, i7, false);
                this.f2708b = e;
            }
        }
        if (this.f2709c == 1) {
            if (this.e == null) {
                this.e = r2;
                b[] bVarArr = {new b()};
                this.f2710d++;
            }
            bVar2 = this.e[0];
        } else {
            b[] bVarArr2 = this.e;
            int i8 = this.f2708b;
            if (bVarArr2[e - i8] == null) {
                bVarArr2[e - i8] = new b();
                this.f2710d++;
            }
            bVar2 = bVarArr2[e - i8];
        }
        return bVar2.b(eVar, i + 1, i2 - 1, bVar);
    }

    private boolean d() {
        return this.f2707a == null && this.f2710d == 0;
    }

    private b[] f(b[] bVarArr, int i, boolean z) {
        return (b[]) d.s.e.e(b.class, bVarArr, i, z);
    }

    private boolean i(d.e eVar, int i, int i2, d.p.b bVar) {
        int i3;
        int i4;
        int i5;
        int i6;
        if (i2 == 0) {
            Set<d.p.b> set = this.f2707a;
            if (set != null) {
                set.remove(bVar);
                if (this.f2707a.isEmpty()) {
                    this.f2707a = null;
                }
            }
            return this.f2707a == null;
        }
        byte e = eVar.e(i);
        int i7 = this.f2709c;
        if (i7 == 0 || e < (i3 = this.f2708b) || e >= i3 + i7) {
            return false;
        }
        b bVar2 = i7 == 1 ? this.e[0] : this.e[e - i3];
        if (bVar2 == null) {
            return false;
        }
        boolean i8 = bVar2.i(eVar, i + 1, i2 - 1, bVar);
        if (bVar2.d()) {
            int i9 = this.f2709c;
            if (i9 == 1) {
                this.e = null;
                this.f2709c = 0;
                this.f2710d--;
            } else {
                b[] bVarArr = this.e;
                int i10 = this.f2708b;
                bVarArr[e - i10] = null;
                int i11 = this.f2710d - 1;
                this.f2710d = i11;
                if (i11 == 1) {
                    int i12 = 0;
                    while (i12 < this.f2709c && this.e[i12] == null) {
                        i12++;
                    }
                    this.f2708b += i12;
                    this.f2709c = 1;
                    this.e = new b[]{this.e[i12]};
                } else if (e == i10) {
                    int i13 = 1;
                    while (true) {
                        i6 = this.f2709c;
                        if (i13 < i6 && this.e[i13] == null) {
                            i13++;
                        }
                    }
                    this.f2708b += i13;
                    int i14 = i6 - i13;
                    this.f2709c = i14;
                    this.e = f(this.e, i14, true);
                } else if (e == (i10 + i9) - 1) {
                    while (true) {
                        i5 = this.f2709c;
                        i4 = (i4 < i5 && this.e[(i5 + (-1)) - i4] == null) ? i4 + 1 : 1;
                    }
                    int i15 = i5 - i4;
                    this.f2709c = i15;
                    this.e = f(this.e, i15, false);
                }
            }
        }
        return i8;
    }

    private boolean j(d.p.b bVar, byte[] bArr, int i, int i2, a aVar, f fVar) {
        int i3;
        int i4;
        int i5;
        int i6;
        int i7;
        byte[] bArr2 = bArr;
        Set<d.p.b> set = this.f2707a;
        if (set != null && set.remove(bVar) && this.f2707a.isEmpty()) {
            aVar.a(null, bArr2, i, fVar);
            this.f2707a = null;
        }
        int i8 = i2;
        if (i >= i8) {
            i8 = i + 256;
            bArr2 = d.s.e.d(bArr2, i8);
        }
        int i9 = i8;
        int i10 = this.f2709c;
        if (i10 == 0) {
            return true;
        }
        int i11 = 0;
        if (i10 == 1) {
            bArr2[i] = (byte) this.f2708b;
            this.e[0].j(bVar, bArr2, i + 1, i9, aVar, fVar);
            if (this.e[0].d()) {
                this.e = null;
                this.f2709c = 0;
                this.f2710d--;
            }
            return true;
        }
        int i12 = this.f2708b;
        int i13 = (i10 + i12) - 1;
        int i14 = i12;
        int i15 = 0;
        while (true) {
            i3 = this.f2709c;
            if (i15 == i3) {
                break;
            }
            bArr2[i] = (byte) (this.f2708b + i15);
            b[] bVarArr = this.e;
            if (bVarArr[i15] != null) {
                i4 = i15;
                int i16 = i14;
                int i17 = i13;
                i7 = i11;
                bVarArr[i15].j(bVar, bArr2, i + 1, i9, aVar, fVar);
                if (this.e[i4].d()) {
                    this.e[i4] = null;
                    this.f2710d--;
                    i5 = i16;
                    i6 = i17;
                } else {
                    int i18 = this.f2708b;
                    i13 = i4 + i18 < i17 ? i4 + i18 : i17;
                    i5 = i16;
                    if (i4 + i18 > i5) {
                        i14 = i4 + i18;
                        i15 = i4 + 1;
                        i11 = i7;
                    }
                    i14 = i5;
                    i15 = i4 + 1;
                    i11 = i7;
                }
            } else {
                i4 = i15;
                i5 = i14;
                i6 = i13;
                i7 = i11;
            }
            i13 = i6;
            i14 = i5;
            i15 = i4 + 1;
            i11 = i7;
        }
        int i19 = this.f2710d;
        if (i19 == 0) {
            this.e = null;
            this.f2709c = i11;
        } else {
            if (i19 == 1) {
                b[] bVarArr2 = new b[1];
                bVarArr2[i11] = this.e[i13 - this.f2708b];
                this.e = bVarArr2;
                this.f2709c = 1;
            } else {
                int i20 = this.f2708b;
                if (i13 > i20 || i14 < (i3 + i20) - 1) {
                    b[] bVarArr3 = this.e;
                    int i21 = (i14 - i13) + 1;
                    this.f2709c = i21;
                    b[] bVarArr4 = new b[i21];
                    this.e = bVarArr4;
                    System.arraycopy(bVarArr3, i13 - i20, bVarArr4, i11, i21);
                }
            }
            this.f2708b = i13;
        }
        return true;
    }

    public boolean a(d.e eVar, d.p.b bVar) {
        return b(eVar, 1, eVar.B() - 1, bVar);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean c(d.p.b bVar) {
        return b(null, 0, 0, bVar);
    }

    public void e(ByteBuffer byteBuffer, int i, a aVar, f fVar) {
        b bVar = this;
        int i2 = 0;
        while (true) {
            Set<d.p.b> set = bVar.f2707a;
            if (set != null) {
                for (d.p.b bVar2 : set) {
                    aVar.a(bVar2, null, 0, fVar);
                }
            }
            if (i == 0 || bVar.f2709c == 0) {
                return;
            }
            byte b2 = byteBuffer.get(i2);
            int i3 = bVar.f2709c;
            if (i3 != 1) {
                int i4 = bVar.f2708b;
                if (b2 < i4 || b2 >= i3 + i4) {
                    return;
                }
                b[] bVarArr = bVar.e;
                if (bVarArr[b2 - i4] == null) {
                    return;
                }
                bVar = bVarArr[b2 - i4];
            } else if (b2 != bVar.f2708b) {
                return;
            } else {
                bVar = bVar.e[0];
            }
            i2++;
            i--;
        }
    }

    public boolean g(d.e eVar, d.p.b bVar) {
        return i(eVar, 1, eVar.B() - 1, bVar);
    }

    public boolean h(d.p.b bVar, a aVar, f fVar) {
        return j(bVar, new byte[0], 0, 0, aVar, fVar);
    }
}
