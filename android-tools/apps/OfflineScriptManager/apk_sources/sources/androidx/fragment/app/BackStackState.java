package androidx.fragment.app;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import android.util.Log;
import androidx.fragment.app.a;
import java.util.ArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class BackStackState implements Parcelable {
    public static final Parcelable.Creator<BackStackState> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    final int[] f923b;

    /* renamed from: c  reason: collision with root package name */
    final int f924c;

    /* renamed from: d  reason: collision with root package name */
    final int f925d;
    final String e;
    final int f;
    final int g;
    final CharSequence h;
    final int i;
    final CharSequence j;
    final ArrayList<String> k;
    final ArrayList<String> l;
    final boolean m;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<BackStackState> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public BackStackState createFromParcel(Parcel parcel) {
            return new BackStackState(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public BackStackState[] newArray(int i) {
            return new BackStackState[i];
        }
    }

    public BackStackState(Parcel parcel) {
        this.f923b = parcel.createIntArray();
        this.f924c = parcel.readInt();
        this.f925d = parcel.readInt();
        this.e = parcel.readString();
        this.f = parcel.readInt();
        this.g = parcel.readInt();
        this.h = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.i = parcel.readInt();
        this.j = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.k = parcel.createStringArrayList();
        this.l = parcel.createStringArrayList();
        this.m = parcel.readInt() != 0;
    }

    public BackStackState(androidx.fragment.app.a aVar) {
        int size = aVar.f953b.size();
        this.f923b = new int[size * 6];
        if (!aVar.i) {
            throw new IllegalStateException("Not on back stack");
        }
        int i = 0;
        for (int i2 = 0; i2 < size; i2++) {
            a.C0034a c0034a = aVar.f953b.get(i2);
            int[] iArr = this.f923b;
            int i3 = i + 1;
            iArr[i] = c0034a.f956a;
            int i4 = i3 + 1;
            Fragment fragment = c0034a.f957b;
            iArr[i3] = fragment != null ? fragment.f : -1;
            int i5 = i4 + 1;
            iArr[i4] = c0034a.f958c;
            int i6 = i5 + 1;
            iArr[i5] = c0034a.f959d;
            int i7 = i6 + 1;
            iArr[i6] = c0034a.e;
            i = i7 + 1;
            iArr[i7] = c0034a.f;
        }
        this.f924c = aVar.g;
        this.f925d = aVar.h;
        this.e = aVar.k;
        this.f = aVar.m;
        this.g = aVar.n;
        this.h = aVar.o;
        this.i = aVar.p;
        this.j = aVar.q;
        this.k = aVar.r;
        this.l = aVar.s;
        this.m = aVar.t;
    }

    public androidx.fragment.app.a a(g gVar) {
        androidx.fragment.app.a aVar = new androidx.fragment.app.a(gVar);
        int i = 0;
        int i2 = 0;
        while (true) {
            int[] iArr = this.f923b;
            if (i >= iArr.length) {
                aVar.g = this.f924c;
                aVar.h = this.f925d;
                aVar.k = this.e;
                aVar.m = this.f;
                aVar.i = true;
                aVar.n = this.g;
                aVar.o = this.h;
                aVar.p = this.i;
                aVar.q = this.j;
                aVar.r = this.k;
                aVar.s = this.l;
                aVar.t = this.m;
                aVar.k(1);
                return aVar;
            }
            a.C0034a c0034a = new a.C0034a();
            int i3 = i + 1;
            c0034a.f956a = iArr[i];
            if (g.F) {
                Log.v("FragmentManager", "Instantiate " + aVar + " op #" + i2 + " base fragment #" + this.f923b[i3]);
            }
            int i4 = i3 + 1;
            int i5 = this.f923b[i3];
            c0034a.f957b = i5 >= 0 ? gVar.f.get(i5) : null;
            int[] iArr2 = this.f923b;
            int i6 = i4 + 1;
            int i7 = iArr2[i4];
            c0034a.f958c = i7;
            int i8 = i6 + 1;
            int i9 = iArr2[i6];
            c0034a.f959d = i9;
            int i10 = i8 + 1;
            int i11 = iArr2[i8];
            c0034a.e = i11;
            int i12 = iArr2[i10];
            c0034a.f = i12;
            aVar.f954c = i7;
            aVar.f955d = i9;
            aVar.e = i11;
            aVar.f = i12;
            aVar.j(c0034a);
            i2++;
            i = i10 + 1;
        }
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeIntArray(this.f923b);
        parcel.writeInt(this.f924c);
        parcel.writeInt(this.f925d);
        parcel.writeString(this.e);
        parcel.writeInt(this.f);
        parcel.writeInt(this.g);
        TextUtils.writeToParcel(this.h, parcel, 0);
        parcel.writeInt(this.i);
        TextUtils.writeToParcel(this.j, parcel, 0);
        parcel.writeStringList(this.k);
        parcel.writeStringList(this.l);
        parcel.writeInt(this.m ? 1 : 0);
    }
}
