package d.r.g;
/* loaded from: classes.dex */
class e {

    /* renamed from: b  reason: collision with root package name */
    private byte f2712b = 0;

    /* renamed from: c  reason: collision with root package name */
    private int f2713c = 0;

    /* renamed from: d  reason: collision with root package name */
    private int f2714d = 0;

    /* renamed from: a  reason: collision with root package name */
    private int f2711a = 0;
    e[] e = null;

    /* loaded from: classes.dex */
    public interface a {
        void a(byte[] bArr, int i, d.p.b bVar);
    }

    private void c(byte[] bArr, int i, int i2, a aVar, d.p.b bVar) {
        if (this.f2711a > 0) {
            aVar.a(bArr, i, bVar);
        }
        if (i >= i2) {
            i2 = i + 256;
            bArr = d.s.e.d(bArr, i2);
        }
        int i3 = this.f2713c;
        if (i3 == 0) {
            return;
        }
        if (i3 == 1) {
            bArr[i] = this.f2712b;
            this.e[0].c(bArr, 1 + i, i2, aVar, bVar);
            return;
        }
        for (int i4 = 0; i4 != this.f2713c; i4++) {
            bArr[i] = (byte) (this.f2712b + i4);
            e[] eVarArr = this.e;
            if (eVarArr[i4] != null) {
                eVarArr[i4].c(bArr, i + 1, i2, aVar, bVar);
            }
        }
    }

    private boolean d() {
        return this.f2711a == 0 && this.f2714d == 0;
    }

    private e[] e(e[] eVarArr, int i, boolean z) {
        return (e[]) d.s.e.e(e.class, eVarArr, i, z);
    }

    public boolean a(d.e eVar, int i, int i2) {
        e eVar2;
        if (i2 == 0) {
            int i3 = this.f2711a + 1;
            this.f2711a = i3;
            return i3 == 1;
        }
        byte e = eVar.e(i);
        byte b2 = this.f2712b;
        if (e < b2 || e >= this.f2713c + b2) {
            int i4 = this.f2713c;
            if (i4 == 0) {
                this.f2712b = e;
                this.f2713c = 1;
                this.e = null;
            } else if (i4 == 1) {
                e eVar3 = this.e[0];
                int i5 = (b2 < e ? e - b2 : b2 - e) + 1;
                this.f2713c = i5;
                this.e = new e[i5];
                byte min = (byte) Math.min((int) b2, (int) e);
                this.f2712b = min;
                this.e[b2 - min] = eVar3;
            } else if (b2 < e) {
                int i6 = (e - b2) + 1;
                this.f2713c = i6;
                this.e = e(this.e, i6, true);
            } else {
                int i7 = (b2 + i4) - e;
                this.f2713c = i7;
                this.e = e(this.e, i7, false);
                this.f2712b = e;
            }
        }
        if (this.f2713c == 1) {
            if (this.e == null) {
                this.e = r2;
                e[] eVarArr = {new e()};
                this.f2714d++;
            }
            eVar2 = this.e[0];
        } else {
            e[] eVarArr2 = this.e;
            byte b3 = this.f2712b;
            if (eVarArr2[e - b3] == null) {
                eVarArr2[e - b3] = new e();
                this.f2714d++;
            }
            eVar2 = eVarArr2[e - b3];
        }
        return eVar2.a(eVar, i + 1, i2 - 1);
    }

    public void b(a aVar, d.p.b bVar) {
        c(null, 0, 0, aVar, bVar);
    }

    public boolean f(d.e eVar, int i, int i2) {
        byte b2;
        int i3;
        int i4 = 1;
        if (i2 == 0) {
            int i5 = this.f2711a;
            if (i5 == 0) {
                return false;
            }
            int i6 = i5 - 1;
            this.f2711a = i6;
            return i6 == 0;
        }
        byte e = eVar.e(i);
        int i7 = this.f2713c;
        if (i7 == 0 || e < (b2 = this.f2712b) || e >= b2 + i7) {
            return false;
        }
        e eVar2 = i7 == 1 ? this.e[0] : this.e[e - b2];
        if (eVar2 == null) {
            return false;
        }
        boolean f = eVar2.f(eVar, i + 1, i2 - 1);
        if (eVar2.d()) {
            int i8 = this.f2713c;
            e eVar3 = null;
            if (i8 == 1) {
                this.e = null;
                this.f2713c = 0;
                this.f2714d--;
            } else {
                e[] eVarArr = this.e;
                byte b3 = this.f2712b;
                eVarArr[e - b3] = null;
                int i9 = this.f2714d - 1;
                this.f2714d = i9;
                if (i9 == 1) {
                    if (e == b3) {
                        eVar3 = eVarArr[i8 - 1];
                        this.f2712b = (byte) (b3 + (i8 - 1));
                    } else if (e == (b3 + i8) - 1) {
                        eVar3 = eVarArr[0];
                    }
                    this.e = new e[]{eVar3};
                    this.f2713c = 1;
                } else if (e == b3) {
                    int i10 = 1;
                    while (true) {
                        i3 = this.f2713c;
                        if (i10 >= i3) {
                            break;
                        } else if (this.e[i10] != null) {
                            b3 = (byte) (i10 + this.f2712b);
                            break;
                        } else {
                            i10++;
                        }
                    }
                    int i11 = i3 - (b3 - this.f2712b);
                    this.f2713c = i11;
                    this.e = e(this.e, i11, true);
                    this.f2712b = b3;
                } else if (e == (b3 + i8) - 1) {
                    while (true) {
                        int i12 = this.f2713c;
                        if (i4 >= i12) {
                            break;
                        } else if (this.e[(i12 - 1) - i4] != null) {
                            i8 = i12 - i4;
                            break;
                        } else {
                            i4++;
                        }
                    }
                    this.f2713c = i8;
                    this.e = e(this.e, i8, false);
                }
            }
        }
        return f;
    }
}
