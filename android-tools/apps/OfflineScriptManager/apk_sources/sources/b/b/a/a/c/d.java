package b.b.a.a.c;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class d implements c {

    /* renamed from: b  reason: collision with root package name */
    private String f1374b;

    /* renamed from: a  reason: collision with root package name */
    private int f1373a = 0;

    /* renamed from: c  reason: collision with root package name */
    private ArrayList<a> f1375c = new ArrayList<>();

    private String i(Process process) {
        String readLine;
        BufferedReader bufferedReader = null;
        String str = null;
        try {
            BufferedReader bufferedReader2 = new BufferedReader(new InputStreamReader(process.getErrorStream()));
            do {
                try {
                    readLine = bufferedReader2.readLine();
                    if (readLine == null) {
                        break;
                    }
                    if (str == null) {
                        str = BuildConfig.FLAVOR;
                    }
                    str = str + readLine;
                } catch (Throwable th) {
                    th = th;
                    bufferedReader = bufferedReader2;
                    com.ape.offlinescriptmanager.utils.g.e(bufferedReader);
                    throw th;
                }
            } while (!readLine.startsWith("error:"));
            com.ape.offlinescriptmanager.utils.g.e(bufferedReader2);
            return str;
        } catch (Throwable th2) {
            th = th2;
        }
    }

    private String j(String str) {
        String a2 = com.ape.offlinescriptmanager.utils.h.b().a(str);
        return a2 != null ? a2 : str;
    }

    private void k(b.b.a.a.b.b bVar, String str) {
        try {
            StringBuffer stringBuffer = new StringBuffer();
            Process i = com.ape.offlinescriptmanager.utils.g.i(str);
            String i2 = i(i);
            boolean o = o(i, stringBuffer);
            if (!o && i2 != null && i2.indexOf("KB/s") == -1) {
                bVar.d(str + "  " + i2);
            }
            if (o || stringBuffer.toString().isEmpty()) {
                return;
            }
            bVar.d(str + "  " + stringBuffer.toString());
        } catch (IOException e) {
            bVar.d(str + "  " + e.getMessage());
        }
    }

    private String l() {
        String a2;
        StringBuilder sb;
        String str;
        String j;
        StringBuilder sb2;
        String str2;
        String str3;
        String property = System.getProperties().getProperty("file.separator");
        if (!this.f1374b.equalsIgnoreCase("shell rm -rf")) {
            if (this.f1374b.equalsIgnoreCase("push")) {
                j = a.a(this.f1375c, "devicepath");
                String j2 = j(a.a(this.f1375c, "localpath"));
                if (j == null || j2 == null) {
                    return null;
                }
                if (property.equals("/")) {
                    sb2 = new StringBuilder();
                    sb2.append("cp ");
                    sb2.append(j2);
                    str3 = " ";
                    sb2.append(str3);
                    sb2.append(j);
                } else {
                    sb2 = new StringBuilder();
                    sb2.append("cp \"");
                    sb2.append(j2);
                    str2 = "\" \"";
                    sb2.append(str2);
                    sb2.append(j);
                    sb2.append("\"");
                }
            } else if (this.f1374b.equalsIgnoreCase("install -r")) {
                j = j(a.a(this.f1375c, "localpath"));
                if (j == null) {
                    return null;
                }
                if (property.equals("/")) {
                    sb2 = new StringBuilder();
                    str3 = "pm install -r ";
                    sb2.append(str3);
                    sb2.append(j);
                } else {
                    sb2 = new StringBuilder();
                    str2 = "pm install -r \"";
                    sb2.append(str2);
                    sb2.append(j);
                    sb2.append("\"");
                }
            } else {
                if (this.f1374b.equalsIgnoreCase("uninstall")) {
                    a2 = a.a(this.f1375c, "package");
                    if (a2 == null) {
                        return null;
                    }
                    sb = new StringBuilder();
                    str = "pm uninstall ";
                } else if (!this.f1374b.equalsIgnoreCase("shell am") || (a2 = a.a(this.f1375c, "parameter")) == null) {
                    return null;
                } else {
                    sb = new StringBuilder();
                    str = "am ";
                }
                sb.append(str);
                sb.append(a2);
            }
            return sb2.toString();
        }
        String a3 = a.a(this.f1375c, "devicepath");
        if (a3 == null) {
            return null;
        }
        sb = new StringBuilder();
        sb.append("rm -rf \"");
        sb.append(a3);
        sb.append("\"");
        return sb.toString();
    }

    private boolean o(Process process, StringBuffer stringBuffer) {
        String readLine;
        BufferedReader bufferedReader = null;
        try {
            BufferedReader bufferedReader2 = new BufferedReader(new InputStreamReader(process.getInputStream()));
            do {
                try {
                    readLine = bufferedReader2.readLine();
                    if (readLine == null) {
                        com.ape.offlinescriptmanager.utils.g.e(bufferedReader2);
                        return false;
                    } else if (readLine.matches("Success")) {
                        process.destroy();
                        com.ape.offlinescriptmanager.utils.g.e(bufferedReader2);
                        return true;
                    } else if (readLine.startsWith("Failure")) {
                        stringBuffer.append(readLine);
                        process.destroy();
                        com.ape.offlinescriptmanager.utils.g.e(bufferedReader2);
                        return false;
                    } else if (readLine.startsWith("error:")) {
                        stringBuffer.append(readLine);
                        process.destroy();
                        com.ape.offlinescriptmanager.utils.g.e(bufferedReader2);
                        return false;
                    }
                } catch (Throwable th) {
                    th = th;
                    bufferedReader = bufferedReader2;
                    com.ape.offlinescriptmanager.utils.g.e(bufferedReader);
                    throw th;
                }
            } while (!readLine.matches("waiting for device"));
            process.destroy();
            com.ape.offlinescriptmanager.utils.g.e(bufferedReader2);
            return false;
        } catch (Throwable th2) {
            th = th2;
        }
    }

    @Override // b.b.a.a.c.c
    public int a() {
        return this.f1373a;
    }

    @Override // b.b.a.a.c.c
    public String b() {
        return null;
    }

    @Override // b.b.a.a.c.c
    public b.b.a.a.b.b c(String str) {
        String l = l();
        if (l == null) {
            l = this.f1374b;
        }
        return new b.b.a.a.b.a(l, str);
    }

    @Override // b.b.a.a.c.c
    public void d(boolean z) {
    }

    @Override // b.b.a.a.c.c
    public void e(b.b.a.a.b.b bVar) {
        bVar.b();
        String l = l();
        if (this.f1374b == null) {
            bVar.d("can not process this command");
        } else {
            com.ape.offlinescriptmanager.utils.b.i("rum cmd %s", l);
            k(bVar, l);
        }
        bVar.c();
    }

    @Override // b.b.a.a.c.c
    public boolean f() {
        return false;
    }

    @Override // b.b.a.a.c.c
    public boolean g() {
        return true;
    }

    public void h(a aVar) {
        this.f1375c.add(aVar);
    }

    public void m(String str) {
        this.f1374b = str;
    }

    public void n(int i) {
        this.f1373a = i;
    }
}
