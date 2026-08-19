package b.e.a.j;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class j {

    /* renamed from: a  reason: collision with root package name */
    static Pattern f1608a = Pattern.compile("(....|\\.\\.)(\\[(.*)\\])?");

    public static <T extends b.c.a.i.b> T a(b.e.a.b bVar, String str) {
        List f = f(bVar, str, true);
        if (f.isEmpty()) {
            return null;
        }
        return (T) f.get(0);
    }

    public static <T extends b.c.a.i.b> List<T> b(b.c.a.i.b bVar, String str) {
        return c(bVar, str, false);
    }

    private static <T extends b.c.a.i.b> List<T> c(b.c.a.i.b bVar, String str, boolean z) {
        return g(bVar, str, z);
    }

    public static <T extends b.c.a.i.b> List<T> d(b.c.a.i.e eVar, String str) {
        return e(eVar, str, false);
    }

    private static <T extends b.c.a.i.b> List<T> e(b.c.a.i.e eVar, String str, boolean z) {
        return g(eVar, str, z);
    }

    private static <T extends b.c.a.i.b> List<T> f(b.e.a.b bVar, String str, boolean z) {
        return g(bVar, str, z);
    }

    private static <T extends b.c.a.i.b> List<T> g(Object obj, String str, boolean z) {
        String str2;
        if (str.startsWith("/")) {
            String substring = str.substring(1);
            while (obj instanceof b.c.a.i.b) {
                obj = ((b.c.a.i.b) obj).getParent();
            }
            str = substring;
        }
        if (str.length() == 0) {
            if (obj instanceof b.c.a.i.b) {
                return Collections.singletonList((b.c.a.i.b) obj);
            }
            throw new RuntimeException("Result of path expression seems to be the root container. This is not allowed!");
        }
        int i = 0;
        if (str.contains("/")) {
            str2 = str.substring(str.indexOf(47) + 1);
            str = str.substring(0, str.indexOf(47));
        } else {
            str2 = BuildConfig.FLAVOR;
        }
        Matcher matcher = f1608a.matcher(str);
        if (!matcher.matches()) {
            throw new RuntimeException(String.valueOf(str) + " is invalid path.");
        }
        String group = matcher.group(1);
        if ("..".equals(group)) {
            return obj instanceof b.c.a.i.b ? e(((b.c.a.i.b) obj).getParent(), str2, z) : Collections.emptyList();
        } else if (obj instanceof b.c.a.i.e) {
            int parseInt = matcher.group(2) != null ? Integer.parseInt(matcher.group(3)) : -1;
            LinkedList linkedList = new LinkedList();
            for (b.c.a.i.b bVar : ((b.c.a.i.e) obj).e()) {
                if (bVar.getType().matches(group)) {
                    if (parseInt == -1 || parseInt == i) {
                        linkedList.addAll(c(bVar, str2, z));
                    }
                    i++;
                }
                if (z || parseInt >= 0) {
                    if (!linkedList.isEmpty()) {
                        return linkedList;
                    }
                }
            }
            return linkedList;
        } else {
            return Collections.emptyList();
        }
    }
}
