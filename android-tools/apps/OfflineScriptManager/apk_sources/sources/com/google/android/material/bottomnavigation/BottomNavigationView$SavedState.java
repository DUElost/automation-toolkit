package com.google.android.material.bottomnavigation;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.customview.view.AbsSavedState;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class BottomNavigationView$SavedState extends AbsSavedState {
    public static final Parcelable.Creator<BottomNavigationView$SavedState> CREATOR = new a();

    /* renamed from: d  reason: collision with root package name */
    Bundle f2313d;

    /* loaded from: classes.dex */
    static class a implements Parcelable.ClassLoaderCreator<BottomNavigationView$SavedState> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public BottomNavigationView$SavedState createFromParcel(Parcel parcel) {
            return new BottomNavigationView$SavedState(parcel, null);
        }

        @Override // android.os.Parcelable.ClassLoaderCreator
        /* renamed from: b */
        public BottomNavigationView$SavedState createFromParcel(Parcel parcel, ClassLoader classLoader) {
            return new BottomNavigationView$SavedState(parcel, classLoader);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: c */
        public BottomNavigationView$SavedState[] newArray(int i) {
            return new BottomNavigationView$SavedState[i];
        }
    }

    public BottomNavigationView$SavedState(Parcel parcel, ClassLoader classLoader) {
        super(parcel, classLoader);
        b(parcel, classLoader);
    }

    private void b(Parcel parcel, ClassLoader classLoader) {
        this.f2313d = parcel.readBundle(classLoader);
    }

    @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeBundle(this.f2313d);
    }
}
