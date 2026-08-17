package c.c.a.p;

import java.nio.charset.Charset;
import java.nio.charset.CodingErrorAction;
/* loaded from: classes.dex */
public abstract class b {

    /* renamed from: a  reason: collision with root package name */
    private static final c.c.a.i.b.a.a.a.a.a.a f1845a;

    static {
        Charset.forName("UTF-8").newDecoder().onMalformedInput(CodingErrorAction.REPORT);
        f1845a = new c.c.a.i.b.a.a.a.a.a.b("-_.!~*'()@:$&,;=[]/", false);
    }

    public static String a(String str) {
        return f1845a.a(str);
    }
}
