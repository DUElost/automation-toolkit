package b.a.a.q;

import android.content.Context;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.IBinder;
import android.util.TypedValue;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import b.a.a.e;
import b.a.a.f;
/* loaded from: classes.dex */
public class a {

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: b.a.a.q.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class RunnableC0045a implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ f f1334b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ f.d f1335c;

        RunnableC0045a(f fVar, f.d dVar) {
            this.f1334b = fVar;
            this.f1335c = dVar;
        }

        @Override // java.lang.Runnable
        public void run() {
            this.f1334b.h().requestFocus();
            InputMethodManager inputMethodManager = (InputMethodManager) this.f1335c.e().getSystemService("input_method");
            if (inputMethodManager != null) {
                inputMethodManager.showSoftInput(this.f1334b.h(), 1);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static /* synthetic */ class b {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1336a;

        static {
            int[] iArr = new int[e.values().length];
            f1336a = iArr;
            try {
                iArr[e.CENTER.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1336a[e.END.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
        }
    }

    public static int a(int i, float f) {
        return Color.argb(Math.round(Color.alpha(i) * f), Color.red(i), Color.green(i), Color.blue(i));
    }

    public static ColorStateList b(Context context, int i) {
        int l = l(context, 16842806);
        if (i == 0) {
            i = l;
        }
        return new ColorStateList(new int[][]{new int[]{-16842910}, new int[0]}, new int[]{a(i, 0.4f), i});
    }

    public static int c(Context context, int i) {
        return androidx.core.content.a.b(context, i);
    }

    public static int d(Context context) {
        return a(g(l(context, 16842806)) ? -16777216 : -1, 0.3f);
    }

    private static int e(e eVar) {
        int i = b.f1336a[eVar.ordinal()];
        int i2 = 1;
        if (i != 1) {
            i2 = 2;
            if (i != 2) {
                return 0;
            }
        }
        return i2;
    }

    public static void f(DialogInterface dialogInterface, f.d dVar) {
        InputMethodManager inputMethodManager;
        f fVar = (f) dialogInterface;
        if (fVar.h() == null || (inputMethodManager = (InputMethodManager) dVar.e().getSystemService("input_method")) == null) {
            return;
        }
        View currentFocus = fVar.getCurrentFocus();
        IBinder windowToken = currentFocus != null ? currentFocus.getWindowToken() : fVar.j().getWindowToken();
        if (windowToken != null) {
            inputMethodManager.hideSoftInputFromWindow(windowToken, 0);
        }
    }

    public static boolean g(int i) {
        return 1.0d - ((((((double) Color.red(i)) * 0.299d) + (((double) Color.green(i)) * 0.587d)) + (((double) Color.blue(i)) * 0.114d)) / 255.0d) >= 0.5d;
    }

    public static <T> boolean h(T t, T[] tArr) {
        if (tArr != null && tArr.length != 0) {
            for (T t2 : tArr) {
                if (t2.equals(t)) {
                    return true;
                }
            }
        }
        return false;
    }

    public static ColorStateList i(Context context, int i, ColorStateList colorStateList) {
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(new int[]{i});
        try {
            TypedValue peekValue = obtainStyledAttributes.peekValue(0);
            if (peekValue == null) {
                return colorStateList;
            }
            int i2 = peekValue.type;
            if (i2 < 28 || i2 > 31) {
                ColorStateList colorStateList2 = obtainStyledAttributes.getColorStateList(0);
                return colorStateList2 != null ? colorStateList2 : colorStateList;
            }
            return b(context, peekValue.data);
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    public static boolean j(Context context, int i) {
        return k(context, i, false);
    }

    public static boolean k(Context context, int i, boolean z) {
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(new int[]{i});
        try {
            return obtainStyledAttributes.getBoolean(0, z);
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    public static int l(Context context, int i) {
        return m(context, i, 0);
    }

    public static int m(Context context, int i, int i2) {
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(new int[]{i});
        try {
            return obtainStyledAttributes.getColor(0, i2);
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    public static int n(Context context, int i) {
        return o(context, i, -1);
    }

    private static int o(Context context, int i, int i2) {
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(new int[]{i});
        try {
            return obtainStyledAttributes.getDimensionPixelSize(0, i2);
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    public static Drawable p(Context context, int i) {
        return q(context, i, null);
    }

    private static Drawable q(Context context, int i, Drawable drawable) {
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(new int[]{i});
        try {
            Drawable drawable2 = obtainStyledAttributes.getDrawable(0);
            if (drawable2 != null || drawable == null) {
                drawable = drawable2;
            }
            return drawable;
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    public static e r(Context context, int i, e eVar) {
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(new int[]{i});
        try {
            int i2 = obtainStyledAttributes.getInt(0, e(eVar));
            return i2 != 1 ? i2 != 2 ? e.START : e.END : e.CENTER;
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    public static String s(Context context, int i) {
        TypedValue typedValue = new TypedValue();
        context.getTheme().resolveAttribute(i, typedValue, true);
        return (String) typedValue.string;
    }

    public static void t(View view, Drawable drawable) {
        if (Build.VERSION.SDK_INT < 16) {
            view.setBackgroundDrawable(drawable);
        } else {
            view.setBackground(drawable);
        }
    }

    public static void u(DialogInterface dialogInterface, f.d dVar) {
        f fVar = (f) dialogInterface;
        if (fVar.h() == null) {
            return;
        }
        fVar.h().post(new RunnableC0045a(fVar, dVar));
    }
}
