package c.c.a.j;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
/* loaded from: classes.dex */
public class f {

    /* renamed from: a  reason: collision with root package name */
    private final Map<Class<?>, Map<String, e>> f1791a = new HashMap();

    /* renamed from: b  reason: collision with root package name */
    private final Map<Class<?>, Set<e>> f1792b = new HashMap();

    /* renamed from: c  reason: collision with root package name */
    private c.c.a.j.a f1793c = c.c.a.j.a.DEFAULT;

    /* renamed from: d  reason: collision with root package name */
    private boolean f1794d = false;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static /* synthetic */ class a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1795a;

        static {
            int[] iArr = new int[c.c.a.j.a.values().length];
            f1795a = iArr;
            try {
                iArr[c.c.a.j.a.FIELD.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
        }
    }

    protected Set<e> a(Class<? extends Object> cls, c.c.a.j.a aVar) {
        TreeSet treeSet = new TreeSet();
        for (e eVar : d(cls, aVar).values()) {
            if (eVar.f() && (this.f1794d || eVar.g())) {
                treeSet.add(eVar);
            }
        }
        return treeSet;
    }

    public Set<e> b(Class<? extends Object> cls) {
        return c(cls, this.f1793c);
    }

    public Set<e> c(Class<? extends Object> cls, c.c.a.j.a aVar) {
        if (this.f1792b.containsKey(cls)) {
            return this.f1792b.get(cls);
        }
        Set<e> a2 = a(cls, aVar);
        this.f1792b.put(cls, a2);
        return a2;
    }

    protected Map<String, e> d(Class<?> cls, c.c.a.j.a aVar) {
        Field[] declaredFields;
        PropertyDescriptor[] propertyDescriptors;
        Field[] declaredFields2;
        if (this.f1791a.containsKey(cls)) {
            return this.f1791a.get(cls);
        }
        LinkedHashMap linkedHashMap = new LinkedHashMap();
        boolean z = false;
        if (a.f1795a[aVar.ordinal()] != 1) {
            for (PropertyDescriptor propertyDescriptor : Introspector.getBeanInfo(cls).getPropertyDescriptors()) {
                Method readMethod = propertyDescriptor.getReadMethod();
                if (readMethod == null || !readMethod.getName().equals("getClass")) {
                    linkedHashMap.put(propertyDescriptor.getName(), new d(propertyDescriptor));
                }
            }
            boolean z2 = false;
            for (Class<?> cls2 = cls; cls2 != null; cls2 = cls2.getSuperclass()) {
                for (Field field : cls2.getDeclaredFields()) {
                    int modifiers = field.getModifiers();
                    if (!Modifier.isStatic(modifiers) && !Modifier.isTransient(modifiers)) {
                        if (Modifier.isPublic(modifiers)) {
                            linkedHashMap.put(field.getName(), new b(field));
                        } else {
                            z2 = true;
                        }
                    }
                }
            }
            z = z2;
        } else {
            for (Class<?> cls3 = cls; cls3 != null; cls3 = cls3.getSuperclass()) {
                for (Field field2 : cls3.getDeclaredFields()) {
                    int modifiers2 = field2.getModifiers();
                    if (!Modifier.isStatic(modifiers2) && !Modifier.isTransient(modifiers2) && !linkedHashMap.containsKey(field2.getName())) {
                        linkedHashMap.put(field2.getName(), new b(field2));
                    }
                }
            }
        }
        if (!linkedHashMap.isEmpty() || !z) {
            this.f1791a.put(cls, linkedHashMap);
            return linkedHashMap;
        }
        throw new c.c.a.g.b("No JavaBean properties found in " + cls.getName());
    }

    public void e(boolean z) {
        if (this.f1794d != z) {
            this.f1794d = z;
            this.f1792b.clear();
        }
    }
}
