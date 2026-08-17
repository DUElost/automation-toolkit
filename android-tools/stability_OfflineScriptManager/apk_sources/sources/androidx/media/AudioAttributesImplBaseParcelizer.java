package androidx.media;
/* loaded from: classes.dex */
public final class AudioAttributesImplBaseParcelizer {
    public static c read(androidx.versionedparcelable.a aVar) {
        c cVar = new c();
        cVar.f1093a = aVar.k(cVar.f1093a, 1);
        cVar.f1094b = aVar.k(cVar.f1094b, 2);
        cVar.f1095c = aVar.k(cVar.f1095c, 3);
        cVar.f1096d = aVar.k(cVar.f1096d, 4);
        return cVar;
    }

    public static void write(c cVar, androidx.versionedparcelable.a aVar) {
        aVar.s(false, false);
        aVar.w(cVar.f1093a, 1);
        aVar.w(cVar.f1094b, 2);
        aVar.w(cVar.f1095c, 3);
        aVar.w(cVar.f1096d, 4);
    }
}
