package b.b.a.b.b;

import b.b.a.a.d.f;
import com.ape.offlinescriptmanager.utils.g;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/* loaded from: classes.dex */
public class b {

    /* renamed from: b  reason: collision with root package name */
    private static b f1426b;

    /* renamed from: a  reason: collision with root package name */
    private List<f> f1427a = new ArrayList();

    private b() {
        b();
    }

    private boolean a(File file) {
        com.ape.offlinescriptmanager.utils.m.f fVar = new com.ape.offlinescriptmanager.utils.m.f();
        try {
            fVar.c(c(file));
            f B = fVar.B();
            if (B != null) {
                B.p(file.getAbsolutePath());
                this.f1427a.add(B);
                return true;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    private InputStream c(File file) {
        return new BufferedInputStream(new FileInputStream(file));
    }

    public static synchronized b d() {
        b bVar;
        synchronized (b.class) {
            if (f1426b == null) {
                f1426b = new b();
            }
            bVar = f1426b;
        }
        return bVar;
    }

    private File[] g() {
        return g.z(com.ape.offlinescriptmanager.utils.f.a().j().getPath());
    }

    public boolean b() {
        File[] g = g();
        if (g != null) {
            for (File file : g) {
                a(file);
            }
        }
        com.ape.offlinescriptmanager.utils.b.h(new SimpleDateFormat("MM yyyy").format(new Date(System.currentTimeMillis())));
        com.ape.offlinescriptmanager.utils.b.h("Load Task Xml Finish!");
        return true;
    }

    public f e(File file) {
        com.ape.offlinescriptmanager.utils.m.f fVar = new com.ape.offlinescriptmanager.utils.m.f();
        f fVar2 = null;
        try {
            fVar.c(c(file));
            fVar2 = fVar.B();
            if (fVar2 != null) {
                fVar2.p(file.getAbsolutePath());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fVar2;
    }

    public List<f> f() {
        return this.f1427a;
    }
}
