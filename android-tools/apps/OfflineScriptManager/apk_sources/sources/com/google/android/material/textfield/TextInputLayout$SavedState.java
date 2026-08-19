package com.google.android.material.textfield;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import androidx.customview.view.AbsSavedState;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class TextInputLayout$SavedState extends AbsSavedState {
    public static final Parcelable.Creator<TextInputLayout$SavedState> CREATOR = new a();

    /* renamed from: d  reason: collision with root package name */
    CharSequence f2436d;
    boolean e;

    /* loaded from: classes.dex */
    static class a implements Parcelable.ClassLoaderCreator<TextInputLayout$SavedState> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public TextInputLayout$SavedState createFromParcel(Parcel parcel) {
            return new TextInputLayout$SavedState(parcel, null);
        }

        @Override // android.os.Parcelable.ClassLoaderCreator
        /* renamed from: b */
        public TextInputLayout$SavedState createFromParcel(Parcel parcel, ClassLoader classLoader) {
            return new TextInputLayout$SavedState(parcel, classLoader);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: c */
        public TextInputLayout$SavedState[] newArray(int i) {
            return new TextInputLayout$SavedState[i];
        }
    }

    TextInputLayout$SavedState(Parcel parcel, ClassLoader classLoader) {
        super(parcel, classLoader);
        this.f2436d = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.e = parcel.readInt() == 1;
    }

    public String toString() {
        return "TextInputLayout.SavedState{" + Integer.toHexString(System.identityHashCode(this)) + " error=" + ((Object) this.f2436d) + "}";
    }

    @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        TextUtils.writeToParcel(this.f2436d, parcel, i);
        parcel.writeInt(this.e ? 1 : 0);
    }
}
