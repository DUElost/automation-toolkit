package android.support.v4.os;

import android.os.Bundle;
import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.os.a;
/* loaded from: classes.dex */
public class ResultReceiver implements Parcelable {
    public static final Parcelable.Creator<ResultReceiver> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    final Handler f409b = null;

    /* renamed from: c  reason: collision with root package name */
    android.support.v4.os.a f410c;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<ResultReceiver> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public ResultReceiver createFromParcel(Parcel parcel) {
            return new ResultReceiver(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public ResultReceiver[] newArray(int i) {
            return new ResultReceiver[i];
        }
    }

    /* loaded from: classes.dex */
    class b extends a.AbstractBinderC0024a {
        b() {
        }

        @Override // android.support.v4.os.a
        public void n(int i, Bundle bundle) {
            ResultReceiver resultReceiver = ResultReceiver.this;
            Handler handler = resultReceiver.f409b;
            if (handler != null) {
                handler.post(new c(i, bundle));
            } else {
                resultReceiver.a(i, bundle);
            }
        }
    }

    /* loaded from: classes.dex */
    class c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final int f412b;

        /* renamed from: c  reason: collision with root package name */
        final Bundle f413c;

        c(int i, Bundle bundle) {
            this.f412b = i;
            this.f413c = bundle;
        }

        @Override // java.lang.Runnable
        public void run() {
            ResultReceiver.this.a(this.f412b, this.f413c);
        }
    }

    ResultReceiver(Parcel parcel) {
        this.f410c = a.AbstractBinderC0024a.p(parcel.readStrongBinder());
    }

    protected void a(int i, Bundle bundle) {
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        synchronized (this) {
            if (this.f410c == null) {
                this.f410c = new b();
            }
            parcel.writeStrongBinder(this.f410c.asBinder());
        }
    }
}
