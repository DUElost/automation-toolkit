package b.b.a.b.b;

import com.ape.offlinescriptmanager.utils.f;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.m.h;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public class a {

    /* renamed from: c  reason: collision with root package name */
    private static a f1423c;

    /* renamed from: a  reason: collision with root package name */
    private Map<String, b.b.a.a.a.a> f1424a = new HashMap();

    /* renamed from: b  reason: collision with root package name */
    private List<b.b.a.a.a.a> f1425b = null;

    private a() {
        a();
    }

    private void c(b.b.a.a.a.a aVar, File file) {
        String parent = file.getParent();
        String name = file.getName();
        String substring = name.substring(0, name.lastIndexOf("."));
        if (!substring.toLowerCase().endsWith("test")) {
            com.ape.offlinescriptmanager.utils.b.i("uiautomator2 xml file name is not \"test\" end,can not find app apk: %s", file.getAbsolutePath());
            return;
        }
        String str = substring.substring(0, substring.toLowerCase().lastIndexOf("test")) + ".apk";
        File file2 = new File(parent, str);
        if (!file2.exists()) {
            com.ape.offlinescriptmanager.utils.b.i("uiautomator2 have no app apk file, please manual install: %s", file2.getAbsolutePath());
        }
        aVar.f = str;
    }

    public static synchronized a d() {
        a aVar;
        synchronized (a.class) {
            if (f1423c == null) {
                f1423c = new a();
            }
            aVar = f1423c;
        }
        return aVar;
    }

    private boolean f(File file) {
        String parent = file.getParent();
        String name = file.getName();
        String property = System.getProperties().getProperty("file.separator");
        File file2 = new File(parent + property + (name.substring(0, name.indexOf(".")) + ".jar"));
        if (!file2.exists()) {
            file2 = new File(parent + property + (name.substring(0, name.indexOf(".")) + ".apk"));
        }
        return file2.exists();
    }

    public void a() {
        StringBuilder sb;
        String path;
        if (this.f1425b == null) {
            this.f1425b = new ArrayList();
        }
        this.f1425b.clear();
        this.f1424a.clear();
        File c2 = f.a().c();
        if (c2.exists()) {
            File[] z = g.z(c2.getPath());
            if (z != null) {
                for (File file : z) {
                    if (f(file)) {
                        b(file);
                    } else if (!file.getName().equals(new File("/sdcard/UiAutomatorTestData.xml").getName())) {
                        com.ape.offlinescriptmanager.utils.b.c("have xml file, no jar file or apk file path=" + file.getAbsolutePath());
                    }
                }
                return;
            }
            sb = new StringBuilder();
            sb.append("no xml file dir=");
            path = c2.getPath();
        } else {
            sb = new StringBuilder();
            sb.append("test jar dir is not exist path=");
            path = c2.getAbsolutePath();
        }
        sb.append(path);
        com.ape.offlinescriptmanager.utils.b.c(sb.toString());
    }

    public void b(File file) {
        try {
            h hVar = new h();
            hVar.b(file);
            b.b.a.a.a.a f = hVar.f();
            f.f1339b = file.getParent();
            f.f1341d = file.getName();
            String str = f.f1338a;
            if (str != null && str.equalsIgnoreCase("uiautomator2")) {
                c(f, file);
            }
            this.f1425b.add(f);
            this.f1424a.put(f.f1340c.toLowerCase(), f);
        } catch (Exception e) {
            String str2 = file + "  " + e.getMessage();
            com.ape.offlinescriptmanager.utils.b.c(str2);
            try {
                throw new Exception(str2);
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    public List<b.b.a.a.a.a> e() {
        return this.f1425b;
    }
}
