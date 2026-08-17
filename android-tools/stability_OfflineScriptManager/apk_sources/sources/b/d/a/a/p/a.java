package b.d.a.a.p;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
/* loaded from: classes.dex */
public class a {
    public static ColorStateList a(Context context, TypedArray typedArray, int i) {
        int resourceId;
        ColorStateList c2;
        return (!typedArray.hasValue(i) || (resourceId = typedArray.getResourceId(i, 0)) == 0 || (c2 = a.a.k.a.a.c(context, resourceId)) == null) ? typedArray.getColorStateList(i) : c2;
    }

    public static Drawable b(Context context, TypedArray typedArray, int i) {
        int resourceId;
        Drawable d2;
        return (!typedArray.hasValue(i) || (resourceId = typedArray.getResourceId(i, 0)) == 0 || (d2 = a.a.k.a.a.d(context, resourceId)) == null) ? typedArray.getDrawable(i) : d2;
    }
}
