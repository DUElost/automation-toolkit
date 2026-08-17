package b.e.a.i.d.c;

import java.lang.reflect.Modifier;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
/* loaded from: classes.dex */
public class l {

    /* renamed from: a  reason: collision with root package name */
    protected static Logger f1574a = Logger.getLogger(l.class.getName());

    /* renamed from: b  reason: collision with root package name */
    protected static Map<Integer, Map<Integer, Class<? extends b>>> f1575b = new HashMap();

    static {
        HashSet<Class<? extends b>> hashSet = new HashSet();
        hashSet.add(f.class);
        hashSet.add(n.class);
        hashSet.add(b.class);
        hashSet.add(i.class);
        hashSet.add(k.class);
        hashSet.add(m.class);
        hashSet.add(a.class);
        hashSet.add(j.class);
        hashSet.add(h.class);
        hashSet.add(e.class);
        for (Class<? extends b> cls : hashSet) {
            g gVar = (g) cls.getAnnotation(g.class);
            int[] tags = gVar.tags();
            int objectTypeIndication = gVar.objectTypeIndication();
            Map<Integer, Class<? extends b>> map = f1575b.get(Integer.valueOf(objectTypeIndication));
            if (map == null) {
                map = new HashMap<>();
            }
            for (int i : tags) {
                map.put(Integer.valueOf(i), cls);
            }
            f1575b.put(Integer.valueOf(objectTypeIndication), map);
        }
    }

    public static b a(int i, ByteBuffer byteBuffer) {
        b oVar;
        int n = b.c.a.e.n(byteBuffer);
        Map<Integer, Class<? extends b>> map = f1575b.get(Integer.valueOf(i));
        if (map == null) {
            map = f1575b.get(-1);
        }
        Class<? extends b> cls = map.get(Integer.valueOf(n));
        if (cls == null || cls.isInterface() || Modifier.isAbstract(cls.getModifiers())) {
            Logger logger = f1574a;
            logger.warning("No ObjectDescriptor found for objectTypeIndication " + Integer.toHexString(i) + " and tag " + Integer.toHexString(n) + " found: " + cls);
            oVar = new o();
        } else {
            try {
                oVar = cls.newInstance();
            } catch (Exception e) {
                Logger logger2 = f1574a;
                Level level = Level.SEVERE;
                logger2.log(level, "Couldn't instantiate BaseDescriptor class " + cls + " for objectTypeIndication " + i + " and tag " + n, (Throwable) e);
                throw new RuntimeException(e);
            }
        }
        oVar.d(n, byteBuffer);
        return oVar;
    }
}
