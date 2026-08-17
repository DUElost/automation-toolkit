package com.ape.offlinescriptmanager.utils.l;

import android.util.Log;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/* loaded from: classes.dex */
public class c extends b {

    /* renamed from: d  reason: collision with root package name */
    private boolean f2088d;
    private boolean e;
    private boolean f;
    private boolean g;
    private StringBuilder h;
    private final Collection<b.b.a.a.b.b> i;
    private List<String> j;

    public c(b.b.a.a.b.b bVar) {
        this(Collections.singletonList(bVar));
    }

    public c(Collection<b.b.a.a.b.b> collection) {
        this.f2088d = false;
        this.e = false;
        this.f = false;
        this.g = false;
        this.h = null;
        this.i = new ArrayList(collection);
    }

    private void e(String str) {
        StringBuilder sb = this.h;
        if (sb != null) {
            sb.append("\n");
        } else {
            this.h = new StringBuilder();
        }
        this.h.append(str);
    }

    private String f() {
        StringBuilder sb = this.h;
        return sb != null ? sb.toString() : "No trace info...\nPlease check if the testcase run is exist.\n请检查用例是否存在于脚本中。";
    }

    private void h(String str) {
        int i;
        if (!this.e) {
            for (b.b.a.a.b.b bVar : this.i) {
                bVar.b();
            }
            this.e = true;
        }
        if (this.f || str.contains("INSTRUMENTATION_FAILED: ")) {
            if (str.startsWith("Failure in")) {
                this.g = true;
                if (!str.contains(":")) {
                    return;
                }
                i = 10;
            } else if (str.startsWith("Error in")) {
                this.g = true;
                if (!str.contains(":")) {
                    return;
                }
                i = 8;
            } else if (this.j.toString().contains("INSTRUMENTATION_FAILED: ")) {
                for (b.b.a.a.b.b bVar2 : this.i) {
                    bVar2.d("\n脚本中无对应用例，请重新确认");
                    bVar2.c();
                }
                return;
            } else if (str.startsWith("INSTRUMENTATION_STATUS: ")) {
                i(str, 24);
                return;
            } else if (str.startsWith("INSTRUMENTATION_STATUS_CODE: ")) {
                if (j(str) == -1) {
                    for (b.b.a.a.b.b bVar3 : this.i) {
                        bVar3.d(f());
                        bVar3.c();
                    }
                    return;
                }
                return;
            } else if (str.startsWith("Test results for InstrumentationTestRunner")) {
                this.g = false;
                String trim = str.substring(str.indexOf("=") + 1).trim();
                for (b.b.a.a.b.b bVar4 : this.i) {
                    if (trim.equals(".F") || trim.equals(".E")) {
                        bVar4.d(f());
                    }
                    bVar4.c();
                }
                return;
            } else if (str.startsWith("FAILURES!")) {
                for (b.b.a.a.b.b bVar5 : this.i) {
                    bVar5.d(f());
                    bVar5.c();
                }
                return;
            } else if (str.startsWith("OK ")) {
                for (b.b.a.a.b.b bVar6 : this.i) {
                    bVar6.c();
                }
                return;
            } else if (!str.contains("INSTRUMENTATION_RESULT: ")) {
                if (str.startsWith("INSTRUMENTATION_CODE: ")) {
                    if (this.h.length() > 0) {
                        for (b.b.a.a.b.b bVar7 : this.i) {
                            bVar7.d(f());
                            bVar7.c();
                        }
                    }
                } else if (str.startsWith("Time: ")) {
                    k(str);
                } else if (!this.g) {
                    return;
                }
                this.g = false;
                return;
            } else {
                if (str.contains("shortMsg=")) {
                    this.g = true;
                }
                if (!this.g) {
                    return;
                }
            }
            str.substring(i, str.indexOf(":")).trim();
            return;
        }
        if (str.indexOf(":") != -1) {
            str.substring(0, str.indexOf(":")).trim();
            this.f = true;
        }
        if (str.indexOf("INSTRUMENTATION_RESULT: ") == -1 || str.indexOf("shortMsg=") == -1) {
            return;
        }
        this.g = true;
        e(str);
    }

    private void i(String str, int i) {
        int indexOf = str.indexOf("=", i);
        if (indexOf != -1) {
            String trim = str.substring(i, indexOf).trim();
            String l = l(str, indexOf + 1);
            if (trim.equals("Error")) {
                e(l);
            }
        }
    }

    private int j(String str) {
        try {
            return Integer.parseInt(str.substring(29).trim());
        } catch (NumberFormatException unused) {
            return -1;
        }
    }

    private void k(String str) {
        Matcher matcher = Pattern.compile(String.format("%s\\s*([\\d\\.]+)", "Time: ")).matcher(str);
        if (!matcher.find()) {
            com.ape.offlinescriptmanager.utils.b.i("%s %s", "RobotiumResultParser", String.format("Unexpected time format %1$s", str));
            return;
        }
        try {
            Float.parseFloat(matcher.group(1));
        } catch (NumberFormatException unused) {
            com.ape.offlinescriptmanager.utils.b.i("%s %s", "RobotiumResultParser", String.format("Unexpected time format %1$s", str));
        }
    }

    private String l(String str, int i) {
        return str.substring(i);
    }

    @Override // com.ape.offlinescriptmanager.utils.l.a
    public boolean a() {
        return this.f2088d;
    }

    @Override // com.ape.offlinescriptmanager.utils.l.b
    public void d(String[] strArr) {
        this.j = Arrays.asList(strArr);
        for (String str : strArr) {
            h(str);
            Log.i("RobotiumResultParser", "processNewLines: " + str);
        }
    }

    public void g(String str) {
        if (str == null) {
            str = "Unknown error";
        }
        com.ape.offlinescriptmanager.utils.b.i("%s %s", "RobotiumResultParser", String.format("test run failed: '%1$s'", str));
        for (b.b.a.a.b.b bVar : this.i) {
            if (!this.e) {
                bVar.b();
            }
            bVar.d(str);
            bVar.c();
        }
        this.e = true;
    }
}
