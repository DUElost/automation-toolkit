package androidx.core.app;

import android.app.Notification;
import android.app.PendingIntent;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.Bundle;
import android.widget.RemoteViews;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class g {

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        final Bundle f837a;

        /* renamed from: b  reason: collision with root package name */
        private final j[] f838b;

        /* renamed from: c  reason: collision with root package name */
        private final j[] f839c;

        /* renamed from: d  reason: collision with root package name */
        private boolean f840d;
        boolean e;
        private final int f;
        public int g;
        public CharSequence h;
        public PendingIntent i;

        public a(int i, CharSequence charSequence, PendingIntent pendingIntent) {
            this(i, charSequence, pendingIntent, new Bundle(), null, null, true, 0, true);
        }

        a(int i, CharSequence charSequence, PendingIntent pendingIntent, Bundle bundle, j[] jVarArr, j[] jVarArr2, boolean z, int i2, boolean z2) {
            this.e = true;
            this.g = i;
            this.h = b.d(charSequence);
            this.i = pendingIntent;
            this.f837a = bundle == null ? new Bundle() : bundle;
            this.f838b = jVarArr;
            this.f839c = jVarArr2;
            this.f840d = z;
            this.f = i2;
            this.e = z2;
        }

        public PendingIntent a() {
            return this.i;
        }

        public boolean b() {
            return this.f840d;
        }

        public j[] c() {
            return this.f839c;
        }

        public Bundle d() {
            return this.f837a;
        }

        public int e() {
            return this.g;
        }

        public j[] f() {
            return this.f838b;
        }

        public int g() {
            return this.f;
        }

        public boolean h() {
            return this.e;
        }

        public CharSequence i() {
            return this.h;
        }
    }

    /* loaded from: classes.dex */
    public static class b {
        String A;
        Bundle B;
        int C;
        int D;
        Notification E;
        RemoteViews F;
        RemoteViews G;
        RemoteViews H;
        String I;
        int J;
        String K;
        long L;
        int M;
        Notification N;
        @Deprecated
        public ArrayList<String> O;

        /* renamed from: a  reason: collision with root package name */
        public Context f841a;

        /* renamed from: b  reason: collision with root package name */
        public ArrayList<a> f842b;

        /* renamed from: c  reason: collision with root package name */
        ArrayList<a> f843c;

        /* renamed from: d  reason: collision with root package name */
        CharSequence f844d;
        CharSequence e;
        PendingIntent f;
        PendingIntent g;
        RemoteViews h;
        Bitmap i;
        CharSequence j;
        int k;
        int l;
        boolean m;
        boolean n;
        c o;
        CharSequence p;
        CharSequence[] q;
        int r;
        int s;
        boolean t;
        String u;
        boolean v;
        String w;
        boolean x;
        boolean y;
        boolean z;

        @Deprecated
        public b(Context context) {
            this(context, null);
        }

        public b(Context context, String str) {
            this.f842b = new ArrayList<>();
            this.f843c = new ArrayList<>();
            this.m = true;
            this.x = false;
            this.C = 0;
            this.D = 0;
            this.J = 0;
            this.M = 0;
            Notification notification = new Notification();
            this.N = notification;
            this.f841a = context;
            this.I = str;
            notification.when = System.currentTimeMillis();
            this.N.audioStreamType = -1;
            this.l = 0;
            this.O = new ArrayList<>();
        }

        protected static CharSequence d(CharSequence charSequence) {
            return (charSequence != null && charSequence.length() > 5120) ? charSequence.subSequence(0, 5120) : charSequence;
        }

        private Bitmap e(Bitmap bitmap) {
            if (bitmap == null || Build.VERSION.SDK_INT >= 27) {
                return bitmap;
            }
            Resources resources = this.f841a.getResources();
            int dimensionPixelSize = resources.getDimensionPixelSize(a.f.b.compat_notification_large_icon_max_width);
            int dimensionPixelSize2 = resources.getDimensionPixelSize(a.f.b.compat_notification_large_icon_max_height);
            if (bitmap.getWidth() > dimensionPixelSize || bitmap.getHeight() > dimensionPixelSize2) {
                double min = Math.min(dimensionPixelSize / Math.max(1, bitmap.getWidth()), dimensionPixelSize2 / Math.max(1, bitmap.getHeight()));
                return Bitmap.createScaledBitmap(bitmap, (int) Math.ceil(bitmap.getWidth() * min), (int) Math.ceil(bitmap.getHeight() * min), true);
            }
            return bitmap;
        }

        private void j(int i, boolean z) {
            Notification notification;
            int i2;
            if (z) {
                notification = this.N;
                i2 = i | notification.flags;
            } else {
                notification = this.N;
                i2 = (~i) & notification.flags;
            }
            notification.flags = i2;
        }

        public b a(int i, CharSequence charSequence, PendingIntent pendingIntent) {
            this.f842b.add(new a(i, charSequence, pendingIntent));
            return this;
        }

        public Notification b() {
            return new h(this).b();
        }

        public Bundle c() {
            if (this.B == null) {
                this.B = new Bundle();
            }
            return this.B;
        }

        public b f(boolean z) {
            j(16, z);
            return this;
        }

        public b g(PendingIntent pendingIntent) {
            this.f = pendingIntent;
            return this;
        }

        public b h(CharSequence charSequence) {
            this.e = d(charSequence);
            return this;
        }

        public b i(CharSequence charSequence) {
            this.f844d = d(charSequence);
            return this;
        }

        public b k(Bitmap bitmap) {
            this.i = e(bitmap);
            return this;
        }

        public b l(int i) {
            this.N.icon = i;
            return this;
        }
    }

    /* loaded from: classes.dex */
    public static abstract class c {
        public abstract void a(Bundle bundle);

        public abstract void b(f fVar);

        public abstract RemoteViews c(f fVar);

        public abstract RemoteViews d(f fVar);

        public abstract RemoteViews e(f fVar);
    }

    public static Bundle a(Notification notification) {
        int i = Build.VERSION.SDK_INT;
        if (i >= 19) {
            return notification.extras;
        }
        if (i >= 16) {
            return i.c(notification);
        }
        return null;
    }
}
