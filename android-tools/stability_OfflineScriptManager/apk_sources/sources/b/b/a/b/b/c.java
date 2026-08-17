package b.b.a.b.b;

import b.b.a.a.e.e;
import com.ape.offlinescriptmanager.utils.m.d;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
/* loaded from: classes.dex */
public class c {

    /* renamed from: b  reason: collision with root package name */
    private static c f1428b;

    /* renamed from: a  reason: collision with root package name */
    private e f1429a;

    private c() {
        new LinkedHashMap();
        e();
    }

    private boolean a(File file) {
        d dVar = new d();
        try {
            dVar.c(b(file));
            e y = dVar.y();
            this.f1429a = y;
            if (y != null) {
                y.f();
                this.f1429a.e();
                return true;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    private InputStream b(File file) {
        return new BufferedInputStream(new FileInputStream(file));
    }

    public static synchronized c c() {
        c cVar;
        synchronized (c.class) {
            if (f1428b == null) {
                f1428b = new c();
            }
            cVar = f1428b;
        }
        return cVar;
    }

    public e d() {
        return this.f1429a;
    }

    public void e() {
        File file = new File("/sdcard/UiAutomatorTestData.xml");
        if (file.exists()) {
            a(file);
        }
    }
}
