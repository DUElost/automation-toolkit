package a.m;

import android.util.Log;
import android.view.ViewGroup;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
/* loaded from: classes.dex */
class z {

    /* renamed from: a  reason: collision with root package name */
    private static Method f327a;

    /* renamed from: b  reason: collision with root package name */
    private static boolean f328b;

    private static void a() {
        if (f328b) {
            return;
        }
        try {
            Method declaredMethod = ViewGroup.class.getDeclaredMethod("suppressLayout", Boolean.TYPE);
            f327a = declaredMethod;
            declaredMethod.setAccessible(true);
        } catch (NoSuchMethodException e) {
            Log.i("ViewUtilsApi18", "Failed to retrieve suppressLayout method", e);
        }
        f328b = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void b(ViewGroup viewGroup, boolean z) {
        String str;
        a();
        Method method = f327a;
        if (method != null) {
            try {
                method.invoke(viewGroup, Boolean.valueOf(z));
            } catch (IllegalAccessException e) {
                e = e;
                str = "Failed to invoke suppressLayout method";
                Log.i("ViewUtilsApi18", str, e);
            } catch (InvocationTargetException e2) {
                e = e2;
                str = "Error invoking suppressLayout method";
                Log.i("ViewUtilsApi18", str, e);
            }
        }
    }
}
