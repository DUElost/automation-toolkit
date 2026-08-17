package androidx.media;

import java.util.Arrays;
/* loaded from: classes.dex */
class c implements a {

    /* renamed from: a  reason: collision with root package name */
    int f1093a = 0;

    /* renamed from: b  reason: collision with root package name */
    int f1094b = 0;

    /* renamed from: c  reason: collision with root package name */
    int f1095c = 0;

    /* renamed from: d  reason: collision with root package name */
    int f1096d = -1;

    public int a() {
        return this.f1094b;
    }

    public int b() {
        int i = this.f1095c;
        int c2 = c();
        if (c2 == 6) {
            i |= 4;
        } else if (c2 == 7) {
            i |= 1;
        }
        return i & 273;
    }

    public int c() {
        int i = this.f1096d;
        return i != -1 ? i : AudioAttributesCompat.a(false, this.f1095c, this.f1093a);
    }

    public int d() {
        return this.f1093a;
    }

    public boolean equals(Object obj) {
        if (obj instanceof c) {
            c cVar = (c) obj;
            return this.f1094b == cVar.a() && this.f1095c == cVar.b() && this.f1093a == cVar.d() && this.f1096d == cVar.f1096d;
        }
        return false;
    }

    public int hashCode() {
        return Arrays.hashCode(new Object[]{Integer.valueOf(this.f1094b), Integer.valueOf(this.f1095c), Integer.valueOf(this.f1093a), Integer.valueOf(this.f1096d)});
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("AudioAttributesCompat:");
        if (this.f1096d != -1) {
            sb.append(" stream=");
            sb.append(this.f1096d);
            sb.append(" derived");
        }
        sb.append(" usage=");
        sb.append(AudioAttributesCompat.b(this.f1093a));
        sb.append(" content=");
        sb.append(this.f1094b);
        sb.append(" flags=0x");
        sb.append(Integer.toHexString(this.f1095c).toUpperCase());
        return sb.toString();
    }
}
