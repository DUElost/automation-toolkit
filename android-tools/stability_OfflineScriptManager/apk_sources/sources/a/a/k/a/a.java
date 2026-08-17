package a.a.k.a;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.Log;
import android.util.SparseArray;
import android.util.TypedValue;
import androidx.appcompat.widget.h;
import java.util.WeakHashMap;
/* loaded from: classes.dex */
public final class a {

    /* renamed from: a  reason: collision with root package name */
    private static final ThreadLocal<TypedValue> f0a = new ThreadLocal<>();

    /* renamed from: b  reason: collision with root package name */
    private static final WeakHashMap<Context, SparseArray<C0000a>> f1b = new WeakHashMap<>(0);

    /* renamed from: c  reason: collision with root package name */
    private static final Object f2c = new Object();

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: a.a.k.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0000a {

        /* renamed from: a  reason: collision with root package name */
        final ColorStateList f3a;

        /* renamed from: b  reason: collision with root package name */
        final Configuration f4b;

        C0000a(ColorStateList colorStateList, Configuration configuration) {
            this.f3a = colorStateList;
            this.f4b = configuration;
        }
    }

    private static void a(Context context, int i, ColorStateList colorStateList) {
        synchronized (f2c) {
            WeakHashMap<Context, SparseArray<C0000a>> weakHashMap = f1b;
            SparseArray<C0000a> sparseArray = weakHashMap.get(context);
            if (sparseArray == null) {
                sparseArray = new SparseArray<>();
                weakHashMap.put(context, sparseArray);
            }
            sparseArray.append(i, new C0000a(colorStateList, context.getResources().getConfiguration()));
        }
    }

    private static ColorStateList b(Context context, int i) {
        C0000a c0000a;
        synchronized (f2c) {
            SparseArray<C0000a> sparseArray = f1b.get(context);
            if (sparseArray != null && sparseArray.size() > 0 && (c0000a = sparseArray.get(i)) != null) {
                if (c0000a.f4b.equals(context.getResources().getConfiguration())) {
                    return c0000a.f3a;
                }
                sparseArray.remove(i);
            }
            return null;
        }
    }

    public static ColorStateList c(Context context, int i) {
        if (Build.VERSION.SDK_INT >= 23) {
            return context.getColorStateList(i);
        }
        ColorStateList b2 = b(context, i);
        if (b2 != null) {
            return b2;
        }
        ColorStateList f = f(context, i);
        if (f != null) {
            a(context, i, f);
            return f;
        }
        return androidx.core.content.a.c(context, i);
    }

    public static Drawable d(Context context, int i) {
        return h.n().p(context, i);
    }

    private static TypedValue e() {
        ThreadLocal<TypedValue> threadLocal = f0a;
        TypedValue typedValue = threadLocal.get();
        if (typedValue == null) {
            TypedValue typedValue2 = new TypedValue();
            threadLocal.set(typedValue2);
            return typedValue2;
        }
        return typedValue;
    }

    private static ColorStateList f(Context context, int i) {
        if (g(context, i)) {
            return null;
        }
        Resources resources = context.getResources();
        try {
            return androidx.core.content.c.a.a(resources, resources.getXml(i), context.getTheme());
        } catch (Exception e) {
            Log.e("AppCompatResources", "Failed to inflate ColorStateList, leaving it to the framework", e);
            return null;
        }
    }

    private static boolean g(Context context, int i) {
        Resources resources = context.getResources();
        TypedValue e = e();
        resources.getValue(i, e, true);
        int i2 = e.type;
        return i2 >= 28 && i2 <= 31;
    }
}
