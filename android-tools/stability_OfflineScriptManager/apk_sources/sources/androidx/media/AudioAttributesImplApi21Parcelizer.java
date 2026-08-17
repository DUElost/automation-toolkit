package androidx.media;

import android.media.AudioAttributes;
/* loaded from: classes.dex */
public final class AudioAttributesImplApi21Parcelizer {
    public static b read(androidx.versionedparcelable.a aVar) {
        b bVar = new b();
        bVar.f1091a = (AudioAttributes) aVar.m(bVar.f1091a, 1);
        bVar.f1092b = aVar.k(bVar.f1092b, 2);
        return bVar;
    }

    public static void write(b bVar, androidx.versionedparcelable.a aVar) {
        aVar.s(false, false);
        aVar.y(bVar.f1091a, 1);
        aVar.w(bVar.f1092b, 2);
    }
}
