package b.b.a.a.b;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class d {

    /* renamed from: b  reason: collision with root package name */
    private OutputStream f1349b = null;

    /* renamed from: c  reason: collision with root package name */
    private OutputStreamWriter f1350c = null;

    /* renamed from: a  reason: collision with root package name */
    private com.ape.offlinescriptmanager.utils.f f1348a = com.ape.offlinescriptmanager.utils.f.a();

    private OutputStream b(File file, String str) {
        File g = com.ape.offlinescriptmanager.utils.g.g(BuildConfig.FLAVOR, ".xml", str, file);
        com.ape.offlinescriptmanager.utils.b.h(String.format("Created xml report file at %s", g.getAbsolutePath()));
        return new FileOutputStream(g);
    }

    private String d(String str) {
        if (str == null) {
            return null;
        }
        return str.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&apos;");
    }

    private void e(OutputStreamWriter outputStreamWriter, f fVar) {
        StringBuilder sb;
        String str = (((((("  <testcase type=\"" + fVar.x() + "\" ") + "serialnumber=\"" + fVar.u() + "\" ") + "devicename=\"" + fVar.p() + "\" ") + "command=\"" + d(fVar.b()) + "\" ") + "package=\"" + d(fVar.s()) + "\" ") + "classname=\"" + fVar.a() + "\" ") + "name=\"" + fVar.r() + "\" ";
        String str2 = ((str + "time=\"" + (fVar.q() - fVar.w()) + "\" ") + "starttime=\"" + fVar.w() + "\" ") + "endtime=\"" + fVar.q() + "\"";
        if (com.ape.offlinescriptmanager.utils.g.C(fVar.t())) {
            sb = new StringBuilder();
            sb.append(str2);
            sb.append(">\n");
        } else {
            sb = new StringBuilder();
            sb.append(str2);
            sb.append(" screenshot=\"");
            sb.append(fVar.t());
            sb.append("\">\n");
        }
        String sb2 = sb.toString();
        if (!g.PASS.equals(fVar.o())) {
            String str3 = fVar.o().equals(g.FAILURE) ? "failure" : "error";
            sb2 = ((sb2 + "    <" + str3 + ">") + f(fVar.v()) + "\n") + "    </" + str3 + ">\n";
        }
        this.f1350c.write(sb2 + "  </testcase>\n");
    }

    private String f(String str) {
        if (str == null) {
            return null;
        }
        return str.replace("\u0000", "<\\0>");
    }

    public void a() {
        OutputStreamWriter outputStreamWriter = this.f1350c;
        if (outputStreamWriter != null) {
            try {
                try {
                    outputStreamWriter.write("</testpoints>\n");
                    this.f1350c.flush();
                    this.f1350c.close();
                } catch (IOException e) {
                    com.ape.offlinescriptmanager.utils.b.c(e.getMessage());
                }
            } finally {
                this.f1350c = null;
                com.ape.offlinescriptmanager.utils.g.d(this.f1349b);
            }
        }
    }

    public File c(String str, b.b.a.a.c.f fVar) {
        File h = this.f1348a.h(str);
        if (!h.exists()) {
            h.mkdirs();
        }
        try {
            try {
                this.f1349b = b(h, "TESTS-RealResult-TestPoints");
                this.f1350c = new OutputStreamWriter(this.f1349b, "utf-8");
                this.f1350c.write("<testpoints taskname=\"" + fVar.getName() + "\" >\n");
                this.f1350c.flush();
                return h;
            } catch (IOException unused) {
                com.ape.offlinescriptmanager.utils.b.c("Failed to create xml file");
                com.ape.offlinescriptmanager.utils.g.d(this.f1349b);
                return h;
            }
        } catch (Throwable unused2) {
            return h;
        }
    }

    public void g(h hVar) {
        StringBuilder sb;
        try {
            if (this.f1350c != null) {
                String str = (("<testpoint id=\"" + hVar.f() + "\" ") + "name=\"" + d(hVar.g()) + "\" ") + "tests=\"" + hVar.k().size() + "\" ";
                if (hVar.j() != g.FAILURE) {
                    sb = new StringBuilder();
                    sb.append(str);
                    sb.append("failures=\"0\" ");
                } else {
                    sb = new StringBuilder();
                    sb.append(str);
                    sb.append("failures=\"1\" ");
                }
                String str2 = ((sb.toString() + "time=\"" + hVar.d() + "\" ") + "starttime=\"" + hVar.i() + "\" ") + "endtime=\"" + hVar.e() + "\" ";
                if (hVar.h().get("startbattery") != null) {
                    str2 = str2 + "startbattery=\"" + hVar.h().get("startbattery") + "\" ";
                }
                if (hVar.h().get("stopbattery") != null) {
                    str2 = str2 + "stopbattery=\"" + hVar.h().get("stopbattery") + "\" ";
                }
                if (hVar.h().get("regression") != null) {
                    str2 = str2 + "regression=\"" + hVar.h().get("regression") + "\" ";
                }
                this.f1350c.write(str2 + ">\n");
                Iterator<c> it = hVar.k().iterator();
                while (it.hasNext()) {
                    e(this.f1350c, (f) it.next());
                }
                this.f1350c.write("</testpoint>\n");
                this.f1350c.flush();
                this.f1349b.flush();
            }
        } catch (IOException e) {
            com.ape.offlinescriptmanager.utils.b.c(e.getMessage());
        }
    }
}
