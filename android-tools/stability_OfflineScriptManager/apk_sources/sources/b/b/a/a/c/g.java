package b.b.a.a.c;

import android.util.Log;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
/* loaded from: classes.dex */
public class g {

    /* renamed from: b  reason: collision with root package name */
    private static g f1383b;

    /* renamed from: a  reason: collision with root package name */
    private f f1384a = null;

    private g() {
    }

    public static synchronized g a() {
        g gVar;
        synchronized (g.class) {
            if (f1383b == null) {
                f1383b = new g();
            }
            gVar = f1383b;
        }
        return gVar;
    }

    public f b() {
        return this.f1384a;
    }

    public boolean c(File file) {
        com.ape.offlinescriptmanager.utils.m.b bVar = new com.ape.offlinescriptmanager.utils.m.b();
        try {
            bVar.c(new BufferedInputStream(new FileInputStream(file)));
            this.f1384a = bVar.r();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean d(String str) {
        File file = new File(str);
        if (!file.exists() || file.length() == 0) {
            com.ape.offlinescriptmanager.utils.b.d("have no xml file = %s", str);
            Log.e("RunTaskManage", String.format("have no xml file = %s", str));
            return false;
        }
        return c(file);
    }
}
