package org.achartengine;

import android.content.Context;
import org.achartengine.f.g;
import org.achartengine.f.h;
/* loaded from: classes.dex */
public class a {
    private static void a(org.achartengine.g.d dVar, org.achartengine.h.d dVar2) {
        if (dVar == null || dVar2 == null || dVar.d() != dVar2.n()) {
            throw new IllegalArgumentException("Dataset and renderer should be not null and should have the same number of series");
        }
    }

    public static final b b(Context context, org.achartengine.g.d dVar, org.achartengine.h.d dVar2, String str) {
        a(dVar, dVar2);
        g gVar = new g(dVar, dVar2);
        gVar.N(str);
        return new b(context, gVar);
    }

    public static final b c(Context context, org.achartengine.g.d dVar, org.achartengine.h.d dVar2, String str) {
        a(dVar, dVar2);
        h hVar = new h(dVar, dVar2);
        hVar.M(str);
        return new b(context, hVar);
    }
}
