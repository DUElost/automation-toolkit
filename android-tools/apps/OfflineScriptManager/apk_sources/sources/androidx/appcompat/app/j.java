package androidx.appcompat.app;

import android.annotation.SuppressLint;
import android.content.Context;
import android.location.Location;
import android.location.LocationManager;
import android.util.Log;
import java.util.Calendar;
/* loaded from: classes.dex */
class j {

    /* renamed from: d  reason: collision with root package name */
    private static j f505d;

    /* renamed from: a  reason: collision with root package name */
    private final Context f506a;

    /* renamed from: b  reason: collision with root package name */
    private final LocationManager f507b;

    /* renamed from: c  reason: collision with root package name */
    private final a f508c = new a();

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        boolean f509a;

        /* renamed from: b  reason: collision with root package name */
        long f510b;

        /* renamed from: c  reason: collision with root package name */
        long f511c;

        /* renamed from: d  reason: collision with root package name */
        long f512d;
        long e;
        long f;

        a() {
        }
    }

    j(Context context, LocationManager locationManager) {
        this.f506a = context;
        this.f507b = locationManager;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static j a(Context context) {
        if (f505d == null) {
            Context applicationContext = context.getApplicationContext();
            f505d = new j(applicationContext, (LocationManager) applicationContext.getSystemService("location"));
        }
        return f505d;
    }

    @SuppressLint({"MissingPermission"})
    private Location b() {
        Location c2 = androidx.core.content.b.b(this.f506a, "android.permission.ACCESS_COARSE_LOCATION") == 0 ? c("network") : null;
        Location c3 = androidx.core.content.b.b(this.f506a, "android.permission.ACCESS_FINE_LOCATION") == 0 ? c("gps") : null;
        return (c3 == null || c2 == null) ? c3 != null ? c3 : c2 : c3.getTime() > c2.getTime() ? c3 : c2;
    }

    private Location c(String str) {
        try {
            if (this.f507b.isProviderEnabled(str)) {
                return this.f507b.getLastKnownLocation(str);
            }
            return null;
        } catch (Exception e) {
            Log.d("TwilightManager", "Failed to get last known location", e);
            return null;
        }
    }

    private boolean e() {
        return this.f508c.f > System.currentTimeMillis();
    }

    private void f(Location location) {
        long j;
        a aVar = this.f508c;
        long currentTimeMillis = System.currentTimeMillis();
        i b2 = i.b();
        b2.a(currentTimeMillis - 86400000, location.getLatitude(), location.getLongitude());
        long j2 = b2.f502a;
        b2.a(currentTimeMillis, location.getLatitude(), location.getLongitude());
        boolean z = b2.f504c == 1;
        long j3 = b2.f503b;
        long j4 = b2.f502a;
        b2.a(86400000 + currentTimeMillis, location.getLatitude(), location.getLongitude());
        long j5 = b2.f503b;
        if (j3 == -1 || j4 == -1) {
            j = 43200000 + currentTimeMillis;
        } else {
            j = (currentTimeMillis > j4 ? 0 + j5 : currentTimeMillis > j3 ? 0 + j4 : 0 + j3) + 60000;
        }
        aVar.f509a = z;
        aVar.f510b = j2;
        aVar.f511c = j3;
        aVar.f512d = j4;
        aVar.e = j5;
        aVar.f = j;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean d() {
        a aVar = this.f508c;
        if (e()) {
            return aVar.f509a;
        }
        Location b2 = b();
        if (b2 != null) {
            f(b2);
            return aVar.f509a;
        }
        Log.i("TwilightManager", "Could not get last known location. This is probably because the app does not have any location permissions. Falling back to hardcoded sunrise/sunset values.");
        int i = Calendar.getInstance().get(11);
        return i < 6 || i >= 22;
    }
}
