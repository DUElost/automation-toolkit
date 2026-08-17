package com.ape.offlinescriptmanager.utils.l;

import android.content.Context;
import android.media.MediaScannerConnection;
import android.os.Build;
import android.os.Environment;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class f extends Thread {

    /* renamed from: b  reason: collision with root package name */
    private Context f2093b;

    /* renamed from: c  reason: collision with root package name */
    private String f2094c = BuildConfig.FLAVOR;

    /* renamed from: d  reason: collision with root package name */
    private volatile boolean f2095d = false;
    private b.b.a.a.b.d e = null;
    private ArrayList<b.b.a.a.c.h> f = new ArrayList<>();
    private b.b.a.a.c.f g = null;
    private a h;

    /* loaded from: classes.dex */
    public interface a {
        void a(b.b.a.a.c.c cVar);

        b.b.a.a.b.h b(b.b.a.a.b.h hVar);

        void c(b.b.a.a.c.f fVar);

        b.b.a.a.b.h d(b.b.a.a.b.h hVar);

        void e(b.b.a.a.c.f fVar);
    }

    public f(a aVar) {
        this.h = aVar;
    }

    private void a() {
        b.b.a.a.b.d dVar = this.e;
        if (dVar != null) {
            dVar.a();
        }
        com.ape.offlinescriptmanager.utils.b.h("close real result xml end");
    }

    private void b(ArrayList<b.b.a.a.c.h> arrayList, ArrayList<b.b.a.a.c.h> arrayList2) {
        arrayList2.clear();
        for (int i = 0; i < arrayList.size(); i++) {
            arrayList2.add(arrayList.get(i));
        }
    }

    private b.b.a.a.b.h d(b.b.a.a.c.h hVar) {
        if (hVar.f().size() > 0) {
            b.b.a.a.b.h hVar2 = new b.b.a.a.b.h();
            hVar2.m(hVar.getName());
            long m = com.ape.offlinescriptmanager.utils.g.m();
            hVar2.n(m);
            hVar2.l(m);
            hVar2.a("regression", String.valueOf(hVar.d()));
            hVar2.o(b.b.a.a.b.g.RUNNING);
            return hVar2;
        }
        return null;
    }

    private void e(b.b.a.a.c.h hVar) {
        int g = this.g.g();
        for (int i = 0; i < g; i++) {
            hVar.i(hVar.d() + 1);
            b.b.a.a.b.h m = m(hVar);
            if (this.f2095d || m.j() == b.b.a.a.b.g.PASS) {
                return;
            }
        }
    }

    private void f(b.b.a.a.b.h hVar) {
        if (hVar == null) {
            return;
        }
        p(hVar);
        if ((hVar.j().equals(b.b.a.a.b.g.FAILURE) || hVar.j().equals(b.b.a.a.b.g.ERROR) || hVar.j().equals(b.b.a.a.b.g.INCOMPLETE)) && this.g.e()) {
            o();
        }
    }

    private void g() {
        this.f2094c = Build.SERIAL;
    }

    private void h() {
        com.ape.offlinescriptmanager.utils.b.h("load task xml file start");
        if (!b.b.a.a.c.g.a().d("/sdcard/runtask.xml")) {
            com.ape.offlinescriptmanager.utils.b.c("load task xml file fail");
        }
        com.ape.offlinescriptmanager.utils.b.h("load task xml file end");
    }

    private void i(b.b.a.a.c.h hVar, b.b.a.a.b.h hVar2) {
        if (hVar2 == null || hVar2.j() == b.b.a.a.b.g.PASS || this.g.f() != 1) {
            return;
        }
        if (this.g.d() == 1) {
            e(hVar);
        } else if (this.g.d() == 0) {
            hVar.i(hVar.d() + 1);
            this.f.add(hVar);
        }
    }

    private void j() {
        if (this.g.f() == 1 && this.g.d() == 0) {
            int g = this.g.g();
            ArrayList<b.b.a.a.c.h> arrayList = new ArrayList<>();
            for (int i = 0; i < g && this.f.size() > 0; i++) {
                b(this.f, arrayList);
                this.f.clear();
                com.ape.offlinescriptmanager.utils.b.i("failure have %d, regression test %d times start", Integer.valueOf(arrayList.size()), Integer.valueOf(i));
                n(arrayList);
                com.ape.offlinescriptmanager.utils.b.i("failure regression test %d times end", Integer.valueOf(i));
                if (this.f2095d) {
                    return;
                }
            }
            this.f.clear();
        }
    }

    private void k() {
        b.b.a.a.c.f z = com.ape.offlinescriptmanager.view.c.e.c.z();
        this.g = z;
        if (z == null) {
            z = b.b.a.a.c.g.a().b();
        }
        this.g = z;
        if (z == null) {
            o();
            com.ape.offlinescriptmanager.utils.b.h("Task is null. return");
            return;
        }
        this.h.c(z);
        for (int i = 0; i < this.g.a() && !this.f2095d; i++) {
            n(this.g.h());
            j();
        }
    }

    private void l(b.b.a.a.c.c cVar, b.b.a.a.b.h hVar) {
        for (int i = 0; i < cVar.a() && !this.f2095d; i++) {
            b.b.a.a.b.b c2 = cVar.c(this.f2094c);
            c2.a(hVar);
            this.h.a(cVar);
            cVar.g();
            Context context = this.f2093b;
            if (context != null) {
                MediaScannerConnection.scanFile(context, new String[]{Environment.getExternalStorageDirectory().toString()}, null, null);
            }
            cVar.e(c2);
        }
    }

    private b.b.a.a.b.h m(b.b.a.a.c.h hVar) {
        com.ape.offlinescriptmanager.utils.g.P();
        b.b.a.a.b.h d2 = d(hVar);
        this.h.b(d2);
        List<b.b.a.a.c.c> f = hVar.f();
        for (int i = 0; i < f.size() && !this.f2095d; i++) {
            try {
                l(f.get(i), d2);
            } catch (Exception e) {
                d2.o(b.b.a.a.b.g.INCOMPLETE);
                e.printStackTrace();
            }
        }
        f(this.h.d(d2));
        return d2;
    }

    private void n(List<b.b.a.a.c.h> list) {
        for (int i = 0; i < list.size(); i++) {
            b.b.a.a.b.h hVar = null;
            b.b.a.a.c.h hVar2 = list.get(i);
            if (hVar2.g()) {
                Log.i("TaskSuitRun", String.format("runTestPoints: -------------------- %s ", hVar2.getName()));
                for (int i2 = 0; i2 < hVar2.a() && !this.f2095d; i2++) {
                    hVar = m(hVar2);
                }
                if (this.f2095d) {
                    return;
                }
                i(hVar2, hVar);
            }
        }
    }

    private void p(b.b.a.a.b.h hVar) {
        b.b.a.a.b.d dVar = this.e;
        if (dVar != null) {
            dVar.g(hVar);
        }
    }

    public void c(String str, b.b.a.a.c.f fVar) {
        if (this.e == null) {
            this.e = new b.b.a.a.b.d();
        }
        this.e.c(str, fVar);
    }

    public void o() {
        this.f2095d = true;
        Log.v("TaskSuitRun", "setStop");
    }

    @Override // java.lang.Thread, java.lang.Runnable
    public void run() {
        try {
            try {
                this.f2095d = false;
                g();
                com.ape.offlinescriptmanager.utils.h.b().c();
                h();
                k();
                a();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } finally {
            this.f2095d = true;
            this.h.e(this.g);
        }
    }
}
