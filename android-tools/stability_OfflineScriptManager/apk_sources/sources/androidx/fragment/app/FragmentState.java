package androidx.fragment.app;

import android.content.Context;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.Log;
import androidx.lifecycle.r;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class FragmentState implements Parcelable {
    public static final Parcelable.Creator<FragmentState> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    final String f940b;

    /* renamed from: c  reason: collision with root package name */
    final int f941c;

    /* renamed from: d  reason: collision with root package name */
    final boolean f942d;
    final int e;
    final int f;
    final String g;
    final boolean h;
    final boolean i;
    final Bundle j;
    final boolean k;
    Bundle l;
    Fragment m;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<FragmentState> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public FragmentState createFromParcel(Parcel parcel) {
            return new FragmentState(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public FragmentState[] newArray(int i) {
            return new FragmentState[i];
        }
    }

    FragmentState(Parcel parcel) {
        this.f940b = parcel.readString();
        this.f941c = parcel.readInt();
        this.f942d = parcel.readInt() != 0;
        this.e = parcel.readInt();
        this.f = parcel.readInt();
        this.g = parcel.readString();
        this.h = parcel.readInt() != 0;
        this.i = parcel.readInt() != 0;
        this.j = parcel.readBundle();
        this.k = parcel.readInt() != 0;
        this.l = parcel.readBundle();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public FragmentState(Fragment fragment) {
        this.f940b = fragment.getClass().getName();
        this.f941c = fragment.f;
        this.f942d = fragment.n;
        this.e = fragment.y;
        this.f = fragment.z;
        this.g = fragment.A;
        this.h = fragment.D;
        this.i = fragment.C;
        this.j = fragment.h;
        this.k = fragment.B;
    }

    public Fragment a(e eVar, c cVar, Fragment fragment, h hVar, r rVar) {
        if (this.m == null) {
            Context e = eVar.e();
            Bundle bundle = this.j;
            if (bundle != null) {
                bundle.setClassLoader(e.getClassLoader());
            }
            this.m = cVar != null ? cVar.a(e, this.f940b, this.j) : Fragment.H(e, this.f940b, this.j);
            Bundle bundle2 = this.l;
            if (bundle2 != null) {
                bundle2.setClassLoader(e.getClassLoader());
                this.m.f927c = this.l;
            }
            this.m.b1(this.f941c, fragment);
            Fragment fragment2 = this.m;
            fragment2.n = this.f942d;
            fragment2.p = true;
            fragment2.y = this.e;
            fragment2.z = this.f;
            fragment2.A = this.g;
            fragment2.D = this.h;
            fragment2.C = this.i;
            fragment2.B = this.k;
            fragment2.s = eVar.f970d;
            if (g.F) {
                Log.v("FragmentManager", "Instantiated fragment " + this.m);
            }
        }
        Fragment fragment3 = this.m;
        fragment3.v = hVar;
        fragment3.w = rVar;
        return fragment3;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.f940b);
        parcel.writeInt(this.f941c);
        parcel.writeInt(this.f942d ? 1 : 0);
        parcel.writeInt(this.e);
        parcel.writeInt(this.f);
        parcel.writeString(this.g);
        parcel.writeInt(this.h ? 1 : 0);
        parcel.writeInt(this.i ? 1 : 0);
        parcel.writeBundle(this.j);
        parcel.writeInt(this.k ? 1 : 0);
        parcel.writeBundle(this.l);
    }
}
