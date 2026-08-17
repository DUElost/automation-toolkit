package com.aurelhubert.ahbottomnavigation.notification;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class AHNotification implements Parcelable {
    public static final Parcelable.Creator<AHNotification> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    private String f2252b;

    /* renamed from: c  reason: collision with root package name */
    private int f2253c;

    /* renamed from: d  reason: collision with root package name */
    private int f2254d;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<AHNotification> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public AHNotification createFromParcel(Parcel parcel) {
            return new AHNotification(parcel, null);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public AHNotification[] newArray(int i) {
            return new AHNotification[i];
        }
    }

    public AHNotification() {
    }

    private AHNotification(Parcel parcel) {
        this.f2252b = parcel.readString();
        this.f2253c = parcel.readInt();
        this.f2254d = parcel.readInt();
    }

    /* synthetic */ AHNotification(Parcel parcel, a aVar) {
        this(parcel);
    }

    public static List<AHNotification> a(int i) {
        ArrayList arrayList = new ArrayList();
        for (int i2 = 0; i2 < i; i2++) {
            arrayList.add(new AHNotification());
        }
        return arrayList;
    }

    public int b() {
        return this.f2254d;
    }

    public String c() {
        return this.f2252b;
    }

    public int d() {
        return this.f2253c;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public boolean e() {
        return TextUtils.isEmpty(this.f2252b);
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.f2252b);
        parcel.writeInt(this.f2253c);
        parcel.writeInt(this.f2254d);
    }
}
