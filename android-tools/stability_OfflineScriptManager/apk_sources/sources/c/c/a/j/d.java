package c.c.a.j;

import java.beans.PropertyDescriptor;
/* loaded from: classes.dex */
public class d extends c {
    private final PropertyDescriptor g;
    private final boolean h;
    private final boolean i;

    public d(PropertyDescriptor propertyDescriptor) {
        super(propertyDescriptor.getName(), propertyDescriptor.getPropertyType(), propertyDescriptor.getReadMethod() == null ? null : propertyDescriptor.getReadMethod().getGenericReturnType());
        this.g = propertyDescriptor;
        this.h = propertyDescriptor.getReadMethod() != null;
        this.i = propertyDescriptor.getWriteMethod() != null;
    }

    @Override // c.c.a.j.e
    public Object b(Object obj) {
        try {
            this.g.getReadMethod().setAccessible(true);
            return this.g.getReadMethod().invoke(obj, new Object[0]);
        } catch (Exception e) {
            throw new c.c.a.g.b("Unable to find getter for property '" + this.g.getName() + "' on object " + obj + ":" + e);
        }
    }

    @Override // c.c.a.j.e
    public boolean f() {
        return this.h;
    }

    @Override // c.c.a.j.e
    public boolean g() {
        return this.i;
    }
}
