package com.ape.offlinescriptmanager.screenrecorder.folderpicker;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.preference.Preference;
/* loaded from: classes.dex */
public class SavedStateHandler extends Preference.BaseSavedState {
    public static final Parcelable.Creator<SavedStateHandler> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    public final String f2051b;

    /* renamed from: c  reason: collision with root package name */
    public final Bundle f2052c;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<SavedStateHandler> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public SavedStateHandler createFromParcel(Parcel parcel) {
            return new SavedStateHandler(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public SavedStateHandler[] newArray(int i) {
            return new SavedStateHandler[i];
        }
    }

    public SavedStateHandler(Parcel parcel) {
        super(parcel);
        this.f2051b = parcel.readString();
        this.f2052c = parcel.readBundle();
    }

    public SavedStateHandler(Parcelable parcelable, String str, Bundle bundle) {
        super(parcelable);
        this.f2051b = str;
        this.f2052c = bundle;
    }

    @Override // android.view.AbsSavedState, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeString(this.f2051b);
        parcel.writeBundle(this.f2052c);
    }
}
