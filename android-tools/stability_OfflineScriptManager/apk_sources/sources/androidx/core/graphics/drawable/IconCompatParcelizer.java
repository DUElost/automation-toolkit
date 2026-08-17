package androidx.core.graphics.drawable;

import android.content.res.ColorStateList;
/* loaded from: classes.dex */
public class IconCompatParcelizer {
    public static IconCompat read(androidx.versionedparcelable.a aVar) {
        IconCompat iconCompat = new IconCompat();
        iconCompat.f878a = aVar.k(iconCompat.f878a, 1);
        iconCompat.f880c = aVar.g(iconCompat.f880c, 2);
        iconCompat.f881d = aVar.m(iconCompat.f881d, 3);
        iconCompat.e = aVar.k(iconCompat.e, 4);
        iconCompat.f = aVar.k(iconCompat.f, 5);
        iconCompat.g = (ColorStateList) aVar.m(iconCompat.g, 6);
        iconCompat.i = aVar.o(iconCompat.i, 7);
        iconCompat.e();
        return iconCompat;
    }

    public static void write(IconCompat iconCompat, androidx.versionedparcelable.a aVar) {
        aVar.s(true, true);
        iconCompat.f(aVar.e());
        aVar.w(iconCompat.f878a, 1);
        aVar.u(iconCompat.f880c, 2);
        aVar.y(iconCompat.f881d, 3);
        aVar.w(iconCompat.e, 4);
        aVar.w(iconCompat.f, 5);
        aVar.y(iconCompat.g, 6);
        aVar.A(iconCompat.i, 7);
    }
}
