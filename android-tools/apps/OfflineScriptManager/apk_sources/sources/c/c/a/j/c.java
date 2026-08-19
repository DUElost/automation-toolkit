package c.c.a.j;

import java.lang.reflect.Array;
import java.lang.reflect.GenericArrayType;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
/* loaded from: classes.dex */
public abstract class c extends e {

    /* renamed from: d  reason: collision with root package name */
    private Type f1788d;
    private boolean e;
    private Class<?>[] f;

    public c(String str, Class<?> cls, Type type) {
        super(str, cls);
        this.f1788d = type;
        this.e = type == null;
    }

    @Override // c.c.a.j.e
    public Class<?>[] c() {
        if (!this.e) {
            Type type = this.f1788d;
            if (type instanceof ParameterizedType) {
                Type[] actualTypeArguments = ((ParameterizedType) type).getActualTypeArguments();
                if (actualTypeArguments.length > 0) {
                    this.f = new Class[actualTypeArguments.length];
                    for (int i = 0; i < actualTypeArguments.length; i++) {
                        if (!(actualTypeArguments[i] instanceof Class)) {
                            if (!(actualTypeArguments[i] instanceof ParameterizedType)) {
                                if (actualTypeArguments[i] instanceof GenericArrayType) {
                                    Type genericComponentType = ((GenericArrayType) actualTypeArguments[i]).getGenericComponentType();
                                    if (genericComponentType instanceof Class) {
                                        this.f[i] = Array.newInstance((Class) genericComponentType, 0).getClass();
                                    }
                                }
                                this.f = null;
                                break;
                            }
                            this.f[i] = (Class) ((ParameterizedType) actualTypeArguments[i]).getRawType();
                        } else {
                            this.f[i] = (Class) actualTypeArguments[i];
                        }
                    }
                }
            } else if (type instanceof GenericArrayType) {
                Type genericComponentType2 = ((GenericArrayType) type).getGenericComponentType();
                if (genericComponentType2 instanceof Class) {
                    this.f = new Class[]{(Class) genericComponentType2};
                }
            } else if ((type instanceof Class) && ((Class) type).isArray()) {
                this.f = r0;
                Class<?>[] clsArr = {e().getComponentType()};
            }
            this.e = true;
        }
        return this.f;
    }
}
