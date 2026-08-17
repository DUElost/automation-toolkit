package b.a.a.q;

import a.d.g;
import android.content.Context;
import android.graphics.Typeface;
/* loaded from: classes.dex */
public class c {

    /* renamed from: a  reason: collision with root package name */
    private static final g<String, Typeface> f1337a = new g<>();

    public static Typeface a(Context context, String str) {
        g<String, Typeface> gVar = f1337a;
        synchronized (gVar) {
            if (gVar.containsKey(str)) {
                return gVar.get(str);
            }
            try {
                Typeface createFromAsset = Typeface.createFromAsset(context.getAssets(), String.format("fonts/%s", str));
                gVar.put(str, createFromAsset);
                return createFromAsset;
            } catch (RuntimeException unused) {
                return null;
            }
        }
    }
}
