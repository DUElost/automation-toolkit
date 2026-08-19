package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.util.TypedValue;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class l0 {

    /* renamed from: a  reason: collision with root package name */
    private static final ThreadLocal<TypedValue> f726a = new ThreadLocal<>();

    /* renamed from: b  reason: collision with root package name */
    static final int[] f727b = {-16842910};

    /* renamed from: c  reason: collision with root package name */
    static final int[] f728c = {16842908};

    /* renamed from: d  reason: collision with root package name */
    static final int[] f729d = {16842919};
    static final int[] e = {16842912};
    static final int[] f = new int[0];
    private static final int[] g = new int[1];

    public static int a(Context context, int i) {
        ColorStateList d2 = d(context, i);
        if (d2 == null || !d2.isStateful()) {
            TypedValue e2 = e();
            context.getTheme().resolveAttribute(16842803, e2, true);
            return c(context, i, e2.getFloat());
        }
        return d2.getColorForState(f727b, d2.getDefaultColor());
    }

    public static int b(Context context, int i) {
        int[] iArr = g;
        iArr[0] = i;
        q0 s = q0.s(context, null, iArr);
        try {
            return s.b(0, 0);
        } finally {
            s.u();
        }
    }

    static int c(Context context, int i, float f2) {
        int b2 = b(context, i);
        return a.f.e.a.d(b2, Math.round(Color.alpha(b2) * f2));
    }

    public static ColorStateList d(Context context, int i) {
        int[] iArr = g;
        iArr[0] = i;
        q0 s = q0.s(context, null, iArr);
        try {
            return s.c(0);
        } finally {
            s.u();
        }
    }

    private static TypedValue e() {
        ThreadLocal<TypedValue> threadLocal = f726a;
        TypedValue typedValue = threadLocal.get();
        if (typedValue == null) {
            TypedValue typedValue2 = new TypedValue();
            threadLocal.set(typedValue2);
            return typedValue2;
        }
        return typedValue;
    }
}
