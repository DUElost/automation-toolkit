package com.google.android.material.bottomnavigation;

import android.os.Parcel;
import android.os.Parcelable;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class BottomNavigationPresenter$SavedState implements Parcelable {
    public static final Parcelable.Creator<BottomNavigationPresenter$SavedState> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    int f2312b;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<BottomNavigationPresenter$SavedState> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public BottomNavigationPresenter$SavedState createFromParcel(Parcel parcel) {
            return new BottomNavigationPresenter$SavedState(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public BottomNavigationPresenter$SavedState[] newArray(int i) {
            return new BottomNavigationPresenter$SavedState[i];
        }
    }

    BottomNavigationPresenter$SavedState() {
    }

    BottomNavigationPresenter$SavedState(Parcel parcel) {
        this.f2312b = parcel.readInt();
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeInt(this.f2312b);
    }
}
