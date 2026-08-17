package android.support.v4.media;

import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.media.d;
import android.support.v4.media.e;
import android.text.TextUtils;
/* loaded from: classes.dex */
public final class MediaDescriptionCompat implements Parcelable {
    public static final Parcelable.Creator<MediaDescriptionCompat> CREATOR = new a();

    /* renamed from: b  reason: collision with root package name */
    private final String f370b;

    /* renamed from: c  reason: collision with root package name */
    private final CharSequence f371c;

    /* renamed from: d  reason: collision with root package name */
    private final CharSequence f372d;
    private final CharSequence e;
    private final Bitmap f;
    private final Uri g;
    private final Bundle h;
    private final Uri i;
    private Object j;

    /* loaded from: classes.dex */
    static class a implements Parcelable.Creator<MediaDescriptionCompat> {
        a() {
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: a */
        public MediaDescriptionCompat createFromParcel(Parcel parcel) {
            return Build.VERSION.SDK_INT < 21 ? new MediaDescriptionCompat(parcel) : MediaDescriptionCompat.a(d.a(parcel));
        }

        @Override // android.os.Parcelable.Creator
        /* renamed from: b */
        public MediaDescriptionCompat[] newArray(int i) {
            return new MediaDescriptionCompat[i];
        }
    }

    /* loaded from: classes.dex */
    public static final class b {

        /* renamed from: a  reason: collision with root package name */
        private String f373a;

        /* renamed from: b  reason: collision with root package name */
        private CharSequence f374b;

        /* renamed from: c  reason: collision with root package name */
        private CharSequence f375c;

        /* renamed from: d  reason: collision with root package name */
        private CharSequence f376d;
        private Bitmap e;
        private Uri f;
        private Bundle g;
        private Uri h;

        public MediaDescriptionCompat a() {
            return new MediaDescriptionCompat(this.f373a, this.f374b, this.f375c, this.f376d, this.e, this.f, this.g, this.h);
        }

        public b b(CharSequence charSequence) {
            this.f376d = charSequence;
            return this;
        }

        public b c(Bundle bundle) {
            this.g = bundle;
            return this;
        }

        public b d(Bitmap bitmap) {
            this.e = bitmap;
            return this;
        }

        public b e(Uri uri) {
            this.f = uri;
            return this;
        }

        public b f(String str) {
            this.f373a = str;
            return this;
        }

        public b g(Uri uri) {
            this.h = uri;
            return this;
        }

        public b h(CharSequence charSequence) {
            this.f375c = charSequence;
            return this;
        }

        public b i(CharSequence charSequence) {
            this.f374b = charSequence;
            return this;
        }
    }

    MediaDescriptionCompat(Parcel parcel) {
        this.f370b = parcel.readString();
        this.f371c = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.f372d = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.e = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        ClassLoader classLoader = MediaDescriptionCompat.class.getClassLoader();
        this.f = (Bitmap) parcel.readParcelable(classLoader);
        this.g = (Uri) parcel.readParcelable(classLoader);
        this.h = parcel.readBundle(classLoader);
        this.i = (Uri) parcel.readParcelable(classLoader);
    }

    MediaDescriptionCompat(String str, CharSequence charSequence, CharSequence charSequence2, CharSequence charSequence3, Bitmap bitmap, Uri uri, Bundle bundle, Uri uri2) {
        this.f370b = str;
        this.f371c = charSequence;
        this.f372d = charSequence2;
        this.e = charSequence3;
        this.f = bitmap;
        this.g = uri;
        this.h = bundle;
        this.i = uri2;
    }

    /* JADX WARN: Removed duplicated region for block: B:20:0x0069  */
    /* JADX WARN: Removed duplicated region for block: B:21:0x006d  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static android.support.v4.media.MediaDescriptionCompat a(java.lang.Object r9) {
        /*
            r0 = 0
            if (r9 == 0) goto L7e
            int r1 = android.os.Build.VERSION.SDK_INT
            r2 = 21
            if (r1 < r2) goto L7e
            android.support.v4.media.MediaDescriptionCompat$b r2 = new android.support.v4.media.MediaDescriptionCompat$b
            r2.<init>()
            java.lang.String r3 = android.support.v4.media.d.f(r9)
            r2.f(r3)
            java.lang.CharSequence r3 = android.support.v4.media.d.h(r9)
            r2.i(r3)
            java.lang.CharSequence r3 = android.support.v4.media.d.g(r9)
            r2.h(r3)
            java.lang.CharSequence r3 = android.support.v4.media.d.b(r9)
            r2.b(r3)
            android.graphics.Bitmap r3 = android.support.v4.media.d.d(r9)
            r2.d(r3)
            android.net.Uri r3 = android.support.v4.media.d.e(r9)
            r2.e(r3)
            android.os.Bundle r3 = android.support.v4.media.d.c(r9)
            java.lang.String r4 = "android.support.v4.media.description.MEDIA_URI"
            if (r3 == 0) goto L4a
            android.support.v4.media.session.MediaSessionCompat.a(r3)
            android.os.Parcelable r5 = r3.getParcelable(r4)
            android.net.Uri r5 = (android.net.Uri) r5
            goto L4b
        L4a:
            r5 = r0
        L4b:
            if (r5 == 0) goto L63
            java.lang.String r6 = "android.support.v4.media.description.NULL_BUNDLE_FLAG"
            boolean r7 = r3.containsKey(r6)
            if (r7 == 0) goto L5d
            int r7 = r3.size()
            r8 = 2
            if (r7 != r8) goto L5d
            goto L64
        L5d:
            r3.remove(r4)
            r3.remove(r6)
        L63:
            r0 = r3
        L64:
            r2.c(r0)
            if (r5 == 0) goto L6d
            r2.g(r5)
            goto L78
        L6d:
            r0 = 23
            if (r1 < r0) goto L78
            android.net.Uri r0 = android.support.v4.media.e.a(r9)
            r2.g(r0)
        L78:
            android.support.v4.media.MediaDescriptionCompat r0 = r2.a()
            r0.j = r9
        L7e:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.v4.media.MediaDescriptionCompat.a(java.lang.Object):android.support.v4.media.MediaDescriptionCompat");
    }

    public Object b() {
        int i;
        Object obj = this.j;
        if (obj != null || (i = Build.VERSION.SDK_INT) < 21) {
            return obj;
        }
        Object b2 = d.a.b();
        d.a.g(b2, this.f370b);
        d.a.i(b2, this.f371c);
        d.a.h(b2, this.f372d);
        d.a.c(b2, this.e);
        d.a.e(b2, this.f);
        d.a.f(b2, this.g);
        Bundle bundle = this.h;
        if (i < 23 && this.i != null) {
            if (bundle == null) {
                bundle = new Bundle();
                bundle.putBoolean("android.support.v4.media.description.NULL_BUNDLE_FLAG", true);
            }
            bundle.putParcelable("android.support.v4.media.description.MEDIA_URI", this.i);
        }
        d.a.d(b2, bundle);
        if (i >= 23) {
            e.a.a(b2, this.i);
        }
        Object a2 = d.a.a(b2);
        this.j = a2;
        return a2;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public String toString() {
        return ((Object) this.f371c) + ", " + ((Object) this.f372d) + ", " + ((Object) this.e);
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (Build.VERSION.SDK_INT >= 21) {
            d.i(b(), parcel, i);
            return;
        }
        parcel.writeString(this.f370b);
        TextUtils.writeToParcel(this.f371c, parcel, i);
        TextUtils.writeToParcel(this.f372d, parcel, i);
        TextUtils.writeToParcel(this.e, parcel, i);
        parcel.writeParcelable(this.f, i);
        parcel.writeParcelable(this.g, i);
        parcel.writeBundle(this.h);
        parcel.writeParcelable(this.i, i);
    }
}
