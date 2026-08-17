package com.github.johnkil.print;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import com.github.johnkil.print.b;
/* loaded from: classes.dex */
class c {
    /* JADX INFO: Access modifiers changed from: package-private */
    public static b a(Context context, AttributeSet attributeSet, boolean z) {
        b.C0095b c0095b = new b.C0095b(context);
        if (attributeSet != null) {
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, d.PrintView);
            int i = d.PrintView_iconText;
            if (obtainStyledAttributes.hasValue(i)) {
                c0095b.e(obtainStyledAttributes.getString(i));
            }
            if (!z) {
                int i2 = d.PrintView_iconFont;
                if (obtainStyledAttributes.hasValue(i2)) {
                    c0095b.c(e.a(context.getAssets(), obtainStyledAttributes.getString(i2)));
                }
            }
            int i3 = d.PrintView_iconColor;
            if (obtainStyledAttributes.hasValue(i3)) {
                c0095b.b(obtainStyledAttributes.getColorStateList(i3));
            }
            c0095b.d(0, obtainStyledAttributes.getDimensionPixelSize(d.PrintView_iconSize, 0));
            obtainStyledAttributes.recycle();
        }
        return c0095b.a();
    }
}
