package androidx.fragment.app;

import android.os.Parcel;
import android.os.Parcelable;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class FragmentManagerState implements Parcelable {
    public static final Parcelable.Creator<FragmentManagerState> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    FragmentState[] f937b;

    /* renamed from: c  reason: collision with root package name */
    int[] f938c;

    /* renamed from: d  reason: collision with root package name */
    BackStackState[] f939d;
    int e;
    int f;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<FragmentManagerState> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public FragmentManagerState createFromParcel(Parcel parcel) {
            return new FragmentManagerState(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public FragmentManagerState[] newArray(int i) {
            return new FragmentManagerState[i];
        }
    }

    public FragmentManagerState() {
        this.e = -1;
    }

    public FragmentManagerState(Parcel parcel) {
        this.e = -1;
        this.f937b = (FragmentState[]) parcel.createTypedArray(FragmentState.CREATOR);
        this.f938c = parcel.createIntArray();
        this.f939d = (BackStackState[]) parcel.createTypedArray(BackStackState.CREATOR);
        this.e = parcel.readInt();
        this.f = parcel.readInt();
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeTypedArray(this.f937b, i);
        parcel.writeIntArray(this.f938c);
        parcel.writeTypedArray(this.f939d, i);
        parcel.writeInt(this.e);
        parcel.writeInt(this.f);
    }
}
