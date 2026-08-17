package androidx.lifecycle;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class j {

    /* renamed from: a  reason: collision with root package name */
    private static Map<Class, Integer> f1083a = new HashMap();

    /* renamed from: b  reason: collision with root package name */
    private static Map<Class, List<Constructor<? extends c>>> f1084b = new HashMap();

    private static c a(Constructor<? extends c> constructor, Object obj) {
        try {
            return constructor.newInstance(obj);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (InstantiationException e2) {
            throw new RuntimeException(e2);
        } catch (InvocationTargetException e3) {
            throw new RuntimeException(e3);
        }
    }

    private static Constructor<? extends c> b(Class<?> cls) {
        try {
            Package r0 = cls.getPackage();
            String canonicalName = cls.getCanonicalName();
            String name = r0 != null ? r0.getName() : BuildConfig.FLAVOR;
            if (!name.isEmpty()) {
                canonicalName = canonicalName.substring(name.length() + 1);
            }
            String c2 = c(canonicalName);
            if (!name.isEmpty()) {
                c2 = name + "." + c2;
            }
            Constructor declaredConstructor = Class.forName(c2).getDeclaredConstructor(cls);
            if (!declaredConstructor.isAccessible()) {
                declaredConstructor.setAccessible(true);
            }
            return declaredConstructor;
        } catch (ClassNotFoundException unused) {
            return null;
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }

    public static String c(String str) {
        return str.replace(".", "_") + "_LifecycleAdapter";
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static d d(Object obj) {
        if (obj instanceof b) {
            return new FullLifecycleObserverAdapter((b) obj);
        }
        if (obj instanceof d) {
            return (d) obj;
        }
        Class<?> cls = obj.getClass();
        if (e(cls) == 2) {
            List<Constructor<? extends c>> list = f1084b.get(cls);
            if (list.size() == 1) {
                return new SingleGeneratedAdapterObserver(a(list.get(0), obj));
            }
            c[] cVarArr = new c[list.size()];
            for (int i = 0; i < list.size(); i++) {
                cVarArr[i] = a(list.get(i), obj);
            }
            return new CompositeGeneratedAdaptersObserver(cVarArr);
        }
        return new ReflectiveGenericLifecycleObserver(obj);
    }

    private static int e(Class<?> cls) {
        if (f1083a.containsKey(cls)) {
            return f1083a.get(cls).intValue();
        }
        int g = g(cls);
        f1083a.put(cls, Integer.valueOf(g));
        return g;
    }

    private static boolean f(Class<?> cls) {
        return cls != null && f.class.isAssignableFrom(cls);
    }

    private static int g(Class<?> cls) {
        Class<?>[] interfaces;
        if (cls.getCanonicalName() == null) {
            return 1;
        }
        Constructor<? extends c> b2 = b(cls);
        if (b2 != null) {
            f1084b.put(cls, Collections.singletonList(b2));
            return 2;
        } else if (a.f1065c.d(cls)) {
            return 1;
        } else {
            Class<? super Object> superclass = cls.getSuperclass();
            ArrayList arrayList = null;
            if (f(superclass)) {
                if (e(superclass) == 1) {
                    return 1;
                }
                arrayList = new ArrayList(f1084b.get(superclass));
            }
            for (Class<?> cls2 : cls.getInterfaces()) {
                if (f(cls2)) {
                    if (e(cls2) == 1) {
                        return 1;
                    }
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.addAll(f1084b.get(cls2));
                }
            }
            if (arrayList != null) {
                f1084b.put(cls, arrayList);
                return 2;
            }
            return 1;
        }
    }
}
