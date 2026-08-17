package androidx.versionedparcelable;

import android.os.Parcel;
import android.os.Parcelable;
import android.util.SparseIntArray;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
class b extends a {

    /* renamed from: a  reason: collision with root package name */
    private final SparseIntArray f1280a;

    /* renamed from: b  reason: collision with root package name */
    private final Parcel f1281b;

    /* renamed from: c  reason: collision with root package name */
    private final int f1282c;

    /* renamed from: d  reason: collision with root package name */
    private final int f1283d;
    private final String e;
    private int f;
    private int g;

    /* JADX INFO: Access modifiers changed from: package-private */
    public b(Parcel parcel) {
        this(parcel, parcel.dataPosition(), parcel.dataSize(), BuildConfig.FLAVOR);
    }

    b(Parcel parcel, int i, int i2, String str) {
        this.f1280a = new SparseIntArray();
        this.f = -1;
        this.g = 0;
        this.f1281b = parcel;
        this.f1282c = i;
        this.f1283d = i2;
        this.g = i;
        this.e = str;
    }

    private int F(int i) {
        int readInt;
        do {
            int i2 = this.g;
            if (i2 >= this.f1283d) {
                return -1;
            }
            this.f1281b.setDataPosition(i2);
            int readInt2 = this.f1281b.readInt();
            readInt = this.f1281b.readInt();
            this.g += readInt2;
        } while (readInt != i);
        return this.f1281b.dataPosition();
    }

    @Override // androidx.versionedparcelable.a
    public void a() {
        int i = this.f;
        if (i >= 0) {
            int i2 = this.f1280a.get(i);
            int dataPosition = this.f1281b.dataPosition();
            this.f1281b.setDataPosition(i2);
            this.f1281b.writeInt(dataPosition - i2);
            this.f1281b.setDataPosition(dataPosition);
        }
    }

    @Override // androidx.versionedparcelable.a
    protected a b() {
        Parcel parcel = this.f1281b;
        int dataPosition = parcel.dataPosition();
        int i = this.g;
        if (i == this.f1282c) {
            i = this.f1283d;
        }
        return new b(parcel, dataPosition, i, this.e + "  ");
    }

    @Override // androidx.versionedparcelable.a
    public byte[] f() {
        int readInt = this.f1281b.readInt();
        if (readInt < 0) {
            return null;
        }
        byte[] bArr = new byte[readInt];
        this.f1281b.readByteArray(bArr);
        return bArr;
    }

    @Override // androidx.versionedparcelable.a
    public boolean h(int i) {
        int F = F(i);
        if (F == -1) {
            return false;
        }
        this.f1281b.setDataPosition(F);
        return true;
    }

    @Override // androidx.versionedparcelable.a
    public int j() {
        return this.f1281b.readInt();
    }

    @Override // androidx.versionedparcelable.a
    public <T extends Parcelable> T l() {
        return (T) this.f1281b.readParcelable(b.class.getClassLoader());
    }

    @Override // androidx.versionedparcelable.a
    public String n() {
        return this.f1281b.readString();
    }

    @Override // androidx.versionedparcelable.a
    public void r(int i) {
        a();
        this.f = i;
        this.f1280a.put(i, this.f1281b.dataPosition());
        v(0);
        v(i);
    }

    @Override // androidx.versionedparcelable.a
    public void t(byte[] bArr) {
        if (bArr == null) {
            this.f1281b.writeInt(-1);
            return;
        }
        this.f1281b.writeInt(bArr.length);
        this.f1281b.writeByteArray(bArr);
    }

    @Override // androidx.versionedparcelable.a
    public void v(int i) {
        this.f1281b.writeInt(i);
    }

    @Override // androidx.versionedparcelable.a
    public void x(Parcelable parcelable) {
        this.f1281b.writeParcelable(parcelable, 0);
    }

    @Override // androidx.versionedparcelable.a
    public void z(String str) {
        this.f1281b.writeString(str);
    }
}
