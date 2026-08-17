package androidx.lifecycle;

import androidx.lifecycle.e;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
class a {

    /* renamed from: c  reason: collision with root package name */
    static a f1065c = new a();

    /* renamed from: a  reason: collision with root package name */
    private final Map<Class, C0038a> f1066a = new HashMap();

    /* renamed from: b  reason: collision with root package name */
    private final Map<Class, Boolean> f1067b = new HashMap();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: androidx.lifecycle.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0038a {

        /* renamed from: a  reason: collision with root package name */
        final Map<e.a, List<b>> f1068a = new HashMap();

        /* renamed from: b  reason: collision with root package name */
        final Map<b, e.a> f1069b;

        C0038a(Map<b, e.a> map) {
            this.f1069b = map;
            for (Map.Entry<b, e.a> entry : map.entrySet()) {
                e.a value = entry.getValue();
                List<b> list = this.f1068a.get(value);
                if (list == null) {
                    list = new ArrayList<>();
                    this.f1068a.put(value, list);
                }
                list.add(entry.getKey());
            }
        }

        private static void b(List<b> list, g gVar, e.a aVar, Object obj) {
            if (list != null) {
                for (int size = list.size() - 1; size >= 0; size--) {
                    list.get(size).a(gVar, aVar, obj);
                }
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void a(g gVar, e.a aVar, Object obj) {
            b(this.f1068a.get(aVar), gVar, aVar, obj);
            b(this.f1068a.get(e.a.ON_ANY), gVar, aVar, obj);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        final int f1070a;

        /* renamed from: b  reason: collision with root package name */
        final Method f1071b;

        b(int i, Method method) {
            this.f1070a = i;
            this.f1071b = method;
            method.setAccessible(true);
        }

        void a(g gVar, e.a aVar, Object obj) {
            try {
                int i = this.f1070a;
                if (i == 0) {
                    this.f1071b.invoke(obj, new Object[0]);
                } else if (i == 1) {
                    this.f1071b.invoke(obj, gVar);
                } else if (i != 2) {
                } else {
                    this.f1071b.invoke(obj, gVar, aVar);
                }
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            } catch (InvocationTargetException e2) {
                throw new RuntimeException("Failed to call observer method", e2.getCause());
            }
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || b.class != obj.getClass()) {
                return false;
            }
            b bVar = (b) obj;
            return this.f1070a == bVar.f1070a && this.f1071b.getName().equals(bVar.f1071b.getName());
        }

        public int hashCode() {
            return (this.f1070a * 31) + this.f1071b.getName().hashCode();
        }
    }

    a() {
    }

    private C0038a a(Class cls, Method[] methodArr) {
        int i;
        C0038a c2;
        Class superclass = cls.getSuperclass();
        HashMap hashMap = new HashMap();
        if (superclass != null && (c2 = c(superclass)) != null) {
            hashMap.putAll(c2.f1069b);
        }
        for (Class<?> cls2 : cls.getInterfaces()) {
            for (Map.Entry<b, e.a> entry : c(cls2).f1069b.entrySet()) {
                e(hashMap, entry.getKey(), entry.getValue(), cls);
            }
        }
        if (methodArr == null) {
            methodArr = b(cls);
        }
        boolean z = false;
        for (Method method : methodArr) {
            n nVar = (n) method.getAnnotation(n.class);
            if (nVar != null) {
                Class<?>[] parameterTypes = method.getParameterTypes();
                if (parameterTypes.length <= 0) {
                    i = 0;
                } else if (!parameterTypes[0].isAssignableFrom(g.class)) {
                    throw new IllegalArgumentException("invalid parameter type. Must be one and instanceof LifecycleOwner");
                } else {
                    i = 1;
                }
                e.a value = nVar.value();
                if (parameterTypes.length > 1) {
                    if (!parameterTypes[1].isAssignableFrom(e.a.class)) {
                        throw new IllegalArgumentException("invalid parameter type. second arg must be an event");
                    }
                    if (value != e.a.ON_ANY) {
                        throw new IllegalArgumentException("Second arg is supported only for ON_ANY value");
                    }
                    i = 2;
                }
                if (parameterTypes.length > 2) {
                    throw new IllegalArgumentException("cannot have more than 2 params");
                }
                e(hashMap, new b(i, method), value, cls);
                z = true;
            }
        }
        C0038a c0038a = new C0038a(hashMap);
        this.f1066a.put(cls, c0038a);
        this.f1067b.put(cls, Boolean.valueOf(z));
        return c0038a;
    }

    private Method[] b(Class cls) {
        try {
            return cls.getDeclaredMethods();
        } catch (NoClassDefFoundError e) {
            throw new IllegalArgumentException("The observer class has some methods that use newer APIs which are not available in the current OS version. Lifecycles cannot access even other methods so you should make sure that your observer classes only access framework classes that are available in your min API level OR use lifecycle:compiler annotation processor.", e);
        }
    }

    private void e(Map<b, e.a> map, b bVar, e.a aVar, Class cls) {
        e.a aVar2 = map.get(bVar);
        if (aVar2 == null || aVar == aVar2) {
            if (aVar2 == null) {
                map.put(bVar, aVar);
                return;
            }
            return;
        }
        Method method = bVar.f1071b;
        throw new IllegalArgumentException("Method " + method.getName() + " in " + cls.getName() + " already declared with different @OnLifecycleEvent value: previous value " + aVar2 + ", new value " + aVar);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public C0038a c(Class cls) {
        C0038a c0038a = this.f1066a.get(cls);
        return c0038a != null ? c0038a : a(cls, null);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean d(Class cls) {
        if (this.f1067b.containsKey(cls)) {
            return this.f1067b.get(cls).booleanValue();
        }
        Method[] b2 = b(cls);
        for (Method method : b2) {
            if (((n) method.getAnnotation(n.class)) != null) {
                a(cls, b2);
                return true;
            }
        }
        this.f1067b.put(cls, Boolean.FALSE);
        return false;
    }
}
