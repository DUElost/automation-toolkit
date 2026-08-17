package a.m;

import android.graphics.Matrix;
import android.graphics.Rect;
import android.os.Build;
import android.util.Log;
import android.util.Property;
import android.view.View;
import java.lang.reflect.Field;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class d0 {

    /* renamed from: a  reason: collision with root package name */
    private static final h0 f260a;

    /* renamed from: b  reason: collision with root package name */
    private static Field f261b;

    /* renamed from: c  reason: collision with root package name */
    private static boolean f262c;

    /* renamed from: d  reason: collision with root package name */
    static final Property<View, Float> f263d;

    /* loaded from: classes.dex */
    static class a extends Property<View, Float> {
        a(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public Float get(View view) {
            return Float.valueOf(d0.d(view));
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(View view, Float f) {
            d0.h(view, f.floatValue());
        }
    }

    /* loaded from: classes.dex */
    static class b extends Property<View, Rect> {
        b(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public Rect get(View view) {
            return a.f.l.r.j(view);
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(View view, Rect rect) {
            a.f.l.r.U(view, rect);
        }
    }

    static {
        int i = Build.VERSION.SDK_INT;
        f260a = i >= 22 ? new g0() : i >= 21 ? new f0() : i >= 19 ? new e0() : new h0();
        f263d = new a(Float.class, "translationAlpha");
        new b(Rect.class, "clipBounds");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void a(View view) {
        f260a.a(view);
    }

    private static void b() {
        if (f262c) {
            return;
        }
        try {
            Field declaredField = View.class.getDeclaredField("mViewFlags");
            f261b = declaredField;
            declaredField.setAccessible(true);
        } catch (NoSuchFieldException unused) {
            Log.i("ViewUtils", "fetchViewFlagsField: ");
        }
        f262c = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static c0 c(View view) {
        return Build.VERSION.SDK_INT >= 18 ? new b0(view) : a0.e(view);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static float d(View view) {
        return f260a.b(view);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static l0 e(View view) {
        return Build.VERSION.SDK_INT >= 18 ? new k0(view) : new j0(view.getWindowToken());
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void f(View view) {
        f260a.c(view);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void g(View view, int i, int i2, int i3, int i4) {
        f260a.d(view, i, i2, i3, i4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void h(View view, float f) {
        f260a.e(view, f);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void i(View view, int i) {
        b();
        Field field = f261b;
        if (field != null) {
            try {
                f261b.setInt(view, i | (field.getInt(view) & (-13)));
            } catch (IllegalAccessException unused) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void j(View view, Matrix matrix) {
        f260a.f(view, matrix);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void k(View view, Matrix matrix) {
        f260a.g(view, matrix);
    }
}
