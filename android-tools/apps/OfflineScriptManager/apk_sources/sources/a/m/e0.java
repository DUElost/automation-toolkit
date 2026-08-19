package a.m;

import android.util.Log;
import android.view.View;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class e0 extends h0 {

    /* renamed from: a  reason: collision with root package name */
    private static Method f270a;

    /* renamed from: b  reason: collision with root package name */
    private static boolean f271b;

    /* renamed from: c  reason: collision with root package name */
    private static Method f272c;

    /* renamed from: d  reason: collision with root package name */
    private static boolean f273d;

    private void h() {
        if (f273d) {
            return;
        }
        try {
            Method declaredMethod = View.class.getDeclaredMethod("getTransitionAlpha", new Class[0]);
            f272c = declaredMethod;
            declaredMethod.setAccessible(true);
        } catch (NoSuchMethodException e) {
            Log.i("ViewUtilsApi19", "Failed to retrieve getTransitionAlpha method", e);
        }
        f273d = true;
    }

    private void i() {
        if (f271b) {
            return;
        }
        try {
            Method declaredMethod = View.class.getDeclaredMethod("setTransitionAlpha", Float.TYPE);
            f270a = declaredMethod;
            declaredMethod.setAccessible(true);
        } catch (NoSuchMethodException e) {
            Log.i("ViewUtilsApi19", "Failed to retrieve setTransitionAlpha method", e);
        }
        f271b = true;
    }

    @Override // a.m.h0
    public void a(View view) {
    }

    @Override // a.m.h0
    public float b(View view) {
        h();
        Method method = f272c;
        if (method != null) {
            try {
                return ((Float) method.invoke(view, new Object[0])).floatValue();
            } catch (IllegalAccessException unused) {
            } catch (InvocationTargetException e) {
                throw new RuntimeException(e.getCause());
            }
        }
        return super.b(view);
    }

    @Override // a.m.h0
    public void c(View view) {
    }

    @Override // a.m.h0
    public void e(View view, float f) {
        i();
        Method method = f270a;
        if (method == null) {
            view.setAlpha(f);
            return;
        }
        try {
            method.invoke(view, Float.valueOf(f));
        } catch (IllegalAccessException unused) {
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e.getCause());
        }
    }
}
