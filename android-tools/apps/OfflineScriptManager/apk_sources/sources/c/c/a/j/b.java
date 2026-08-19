package c.c.a.j;

import java.lang.reflect.Field;
/* loaded from: classes.dex */
public class b extends c {
    private final Field g;

    public b(Field field) {
        super(field.getName(), field.getType(), field.getGenericType());
        this.g = field;
        field.setAccessible(true);
    }

    @Override // c.c.a.j.e
    public Object b(Object obj) {
        try {
            return this.g.get(obj);
        } catch (Exception e) {
            throw new c.c.a.g.b("Unable to access field " + this.g.getName() + " on object " + obj + " : " + e);
        }
    }
}
