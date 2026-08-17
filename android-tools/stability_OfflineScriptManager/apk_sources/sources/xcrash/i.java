package xcrash;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Build;
import android.os.Debug;
import android.os.Process;
import android.text.TextUtils;
import java.io.File;
import java.io.FilenameFilter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
class i {

    /* renamed from: a  reason: collision with root package name */
    private static final String[] f2847a = {"/data/local/su", "/data/local/bin/su", "/data/local/xbin/su", "/system/xbin/su", "/system/bin/su", "/system/bin/.ext/su", "/system/bin/failsafe/su", "/system/sd/xbin/su", "/system/usr/we-need-root/su", "/sbin/su", "/su/bin/su"};

    /* loaded from: classes.dex */
    static class a implements FilenameFilter {
        a() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            return TextUtils.isDigitsOnly(str);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean a(String str) {
        File file = new File(str);
        try {
            if (file.exists()) {
                return file.isDirectory();
            }
            file.mkdirs();
            return file.exists() && file.isDirectory();
        } catch (Exception unused) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean b(Context context, long j) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService("activity");
        if (activityManager == null) {
            return false;
        }
        int myPid = Process.myPid();
        long j2 = j / 500;
        for (int i = 0; i < j2; i++) {
            List<ActivityManager.ProcessErrorStateInfo> processesInErrorState = activityManager.getProcessesInErrorState();
            if (processesInErrorState != null) {
                for (ActivityManager.ProcessErrorStateInfo processErrorStateInfo : processesInErrorState) {
                    if (processErrorStateInfo.pid == myPid && processErrorStateInfo.condition == 2) {
                        return true;
                    }
                }
            }
            try {
                Thread.sleep(500L);
            } catch (Exception unused) {
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String c() {
        if (Build.VERSION.SDK_INT >= 21) {
            return TextUtils.join(",", Build.SUPPORTED_ABIS);
        }
        String str = Build.CPU_ABI;
        String str2 = Build.CPU_ABI2;
        if (TextUtils.isEmpty(str2)) {
            return str;
        }
        return str + "," + str2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String d(Context context) {
        String str;
        try {
            str = context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionName;
        } catch (Exception unused) {
            str = null;
        }
        return TextUtils.isEmpty(str) ? "unknown" : str;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String e() {
        int myPid = Process.myPid();
        StringBuilder sb = new StringBuilder("open files:\n");
        try {
            File[] listFiles = new File("/proc/" + myPid + "/fd").listFiles(new a());
            if (listFiles != null) {
                int i = 0;
                for (File file : listFiles) {
                    String str = null;
                    try {
                        str = file.getCanonicalPath();
                    } catch (Exception unused) {
                    }
                    sb.append("    fd ");
                    sb.append(file.getName());
                    sb.append(": ");
                    if (TextUtils.isEmpty(str)) {
                        str = "???";
                    }
                    sb.append(str);
                    sb.append('\n');
                    i++;
                    if (i > 1024) {
                        break;
                    }
                }
                if (listFiles.length > 1024) {
                    sb.append("    ......\n");
                }
                sb.append("    (number of FDs: ");
                sb.append(listFiles.length);
                sb.append(")\n");
            }
        } catch (Exception unused2) {
        }
        sb.append('\n');
        return sb.toString();
    }

    /* JADX WARN: Code restructure failed: missing block: B:19:0x0059, code lost:
        if (r2 == null) goto L18;
     */
    /* JADX WARN: Not initialized variable reg: 2, insn: 0x0062: MOVE  (r1 I:??[OBJECT, ARRAY]) = (r2 I:??[OBJECT, ARRAY]), block:B:24:0x0062 */
    /* JADX WARN: Removed duplicated region for block: B:33:0x0065 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static java.lang.String f(java.lang.String r8) {
        /*
            java.lang.StringBuilder r0 = new java.lang.StringBuilder
            r0.<init>()
            r1 = 0
            java.io.BufferedReader r2 = new java.io.BufferedReader     // Catch: java.lang.Throwable -> L34 java.lang.Exception -> L36
            java.io.FileReader r3 = new java.io.FileReader     // Catch: java.lang.Throwable -> L34 java.lang.Exception -> L36
            r3.<init>(r8)     // Catch: java.lang.Throwable -> L34 java.lang.Exception -> L36
            r2.<init>(r3)     // Catch: java.lang.Throwable -> L34 java.lang.Exception -> L36
        L10:
            java.lang.String r1 = r2.readLine()     // Catch: java.lang.Exception -> L32 java.lang.Throwable -> L61
            if (r1 == 0) goto L2e
            java.lang.String r1 = r1.trim()     // Catch: java.lang.Exception -> L32 java.lang.Throwable -> L61
            int r3 = r1.length()     // Catch: java.lang.Exception -> L32 java.lang.Throwable -> L61
            if (r3 <= 0) goto L10
            java.lang.String r3 = "  "
            r0.append(r3)     // Catch: java.lang.Exception -> L32 java.lang.Throwable -> L61
            r0.append(r1)     // Catch: java.lang.Exception -> L32 java.lang.Throwable -> L61
            java.lang.String r1 = "\n"
            r0.append(r1)     // Catch: java.lang.Exception -> L32 java.lang.Throwable -> L61
            goto L10
        L2e:
            r2.close()     // Catch: java.lang.Exception -> L5c
            goto L5c
        L32:
            r1 = move-exception
            goto L3a
        L34:
            r8 = move-exception
            goto L63
        L36:
            r2 = move-exception
            r7 = r2
            r2 = r1
            r1 = r7
        L3a:
            xcrash.f r3 = xcrash.j.a()     // Catch: java.lang.Throwable -> L61
            java.lang.String r4 = "xcrash"
            java.lang.StringBuilder r5 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L61
            r5.<init>()     // Catch: java.lang.Throwable -> L61
            java.lang.String r6 = "Util getInfo("
            r5.append(r6)     // Catch: java.lang.Throwable -> L61
            r5.append(r8)     // Catch: java.lang.Throwable -> L61
            java.lang.String r8 = ") failed"
            r5.append(r8)     // Catch: java.lang.Throwable -> L61
            java.lang.String r8 = r5.toString()     // Catch: java.lang.Throwable -> L61
            r3.c(r4, r8, r1)     // Catch: java.lang.Throwable -> L61
            if (r2 == 0) goto L5c
            goto L2e
        L5c:
            java.lang.String r8 = r0.toString()
            return r8
        L61:
            r8 = move-exception
            r1 = r2
        L63:
            if (r1 == 0) goto L68
            r1.close()     // Catch: java.lang.Exception -> L68
        L68:
            throw r8
        */
        throw new UnsupportedOperationException("Method not decompiled: xcrash.i.f(java.lang.String):java.lang.String");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String g(Date date, Date date2, String str, String str2, String str3) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ", Locale.US);
        StringBuilder sb = new StringBuilder();
        sb.append("*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***\nTombstone maker: 'xCrash 2.4.3'\nCrash type: '");
        sb.append(str);
        sb.append("'\n");
        sb.append("Start time: '");
        sb.append(simpleDateFormat.format(date));
        sb.append("'\n");
        sb.append("Crash time: '");
        sb.append(simpleDateFormat.format(date2));
        sb.append("'\n");
        sb.append("App ID: '");
        sb.append(str2);
        sb.append("'\n");
        sb.append("App version: '");
        sb.append(str3);
        sb.append("'\n");
        sb.append("Rooted: '");
        sb.append(m() ? "Yes" : "No");
        sb.append("'\n");
        sb.append("API level: '");
        sb.append(Build.VERSION.SDK_INT);
        sb.append("'\n");
        sb.append("OS version: '");
        sb.append(Build.VERSION.RELEASE);
        sb.append("'\n");
        sb.append("ABI list: '");
        sb.append(c());
        sb.append("'\n");
        sb.append("Manufacturer: '");
        sb.append(Build.MANUFACTURER);
        sb.append("'\n");
        sb.append("Brand: '");
        sb.append(Build.BRAND);
        sb.append("'\n");
        sb.append("Model: '");
        sb.append(Build.MODEL);
        sb.append("'\n");
        sb.append("Build fingerprint: '");
        sb.append(Build.FINGERPRINT);
        sb.append("'\n");
        return sb.toString();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String h(int i, int i2, int i3) {
        int myPid = Process.myPid();
        StringBuilder sb = new StringBuilder();
        sb.append("logcat:\n");
        if (i > 0) {
            i(myPid, sb, "main", i, 'D');
        }
        if (i2 > 0) {
            i(myPid, sb, "system", i2, 'W');
        }
        if (i3 > 0) {
            i(myPid, sb, "events", i2, 'I');
        }
        sb.append("\n");
        return sb.toString();
    }

    /* JADX WARN: Removed duplicated region for block: B:45:0x00e9 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void i(int r9, java.lang.StringBuilder r10, java.lang.String r11, int r12, char r13) {
        /*
            Method dump skipped, instructions count: 237
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: xcrash.i.i(int, java.lang.StringBuilder, java.lang.String, int, char):void");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String j() {
        int myPid = Process.myPid();
        return "memory info:\n System Summary (From: /proc/meminfo)\n" + f("/proc/meminfo") + "-\n Process Status (From: /proc/PID/status)\n" + f("/proc/" + myPid + "/status") + "-\n Process Limits (From: /proc/PID/limits)\n" + f("/proc/" + myPid + "/limits") + "-\n" + k() + "\n";
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String k() {
        String format;
        String format2;
        StringBuilder sb = new StringBuilder();
        sb.append(" Process Summary (From: android.os.Debug.MemoryInfo)\n");
        Locale locale = Locale.US;
        sb.append(String.format(locale, "%21s %8s\n", BuildConfig.FLAVOR, "Pss(KB)"));
        sb.append(String.format(locale, "%21s %8s\n", BuildConfig.FLAVOR, "------"));
        try {
            Debug.MemoryInfo memoryInfo = new Debug.MemoryInfo();
            Debug.getMemoryInfo(memoryInfo);
            int i = Build.VERSION.SDK_INT;
            if (i >= 23) {
                sb.append(String.format(locale, "%21s %8s\n", "Java Heap:", memoryInfo.getMemoryStat("summary.java-heap")));
                sb.append(String.format(locale, "%21s %8s\n", "Native Heap:", memoryInfo.getMemoryStat("summary.native-heap")));
                sb.append(String.format(locale, "%21s %8s\n", "Code:", memoryInfo.getMemoryStat("summary.code")));
                sb.append(String.format(locale, "%21s %8s\n", "Stack:", memoryInfo.getMemoryStat("summary.stack")));
                sb.append(String.format(locale, "%21s %8s\n", "Graphics:", memoryInfo.getMemoryStat("summary.graphics")));
                sb.append(String.format(locale, "%21s %8s\n", "Private Other:", memoryInfo.getMemoryStat("summary.private-other")));
                sb.append(String.format(locale, "%21s %8s\n", "System:", memoryInfo.getMemoryStat("summary.system")));
                format2 = String.format(locale, "%21s %8s %21s %8s\n", "TOTAL:", memoryInfo.getMemoryStat("summary.total-pss"), "TOTAL SWAP:", memoryInfo.getMemoryStat("summary.total-swap"));
            } else {
                sb.append(String.format(locale, "%21s %8s\n", "Java Heap:", "~ " + memoryInfo.dalvikPrivateDirty));
                sb.append(String.format(locale, "%21s %8s\n", "Native Heap:", String.valueOf(memoryInfo.nativePrivateDirty)));
                sb.append(String.format(locale, "%21s %8s\n", "Private Other:", "~ " + memoryInfo.otherPrivateDirty));
                if (i >= 19) {
                    format = String.format(locale, "%21s %8s\n", "System:", String.valueOf((memoryInfo.getTotalPss() - memoryInfo.getTotalPrivateDirty()) - memoryInfo.getTotalPrivateClean()));
                } else {
                    format = String.format(locale, "%21s %8s\n", "System:", "~ " + (memoryInfo.getTotalPss() - memoryInfo.getTotalPrivateDirty()));
                }
                sb.append(format);
                format2 = String.format(locale, "%21s %8s\n", "TOTAL:", String.valueOf(memoryInfo.getTotalPss()));
            }
            sb.append(format2);
        } catch (Exception e) {
            j.a().c("xcrash", "Util getProcessMemoryInfo failed", e);
        }
        return sb.toString();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static String l(Context context, int i) {
        try {
            ActivityManager activityManager = (ActivityManager) context.getSystemService("activity");
            if (activityManager != null) {
                for (ActivityManager.RunningAppProcessInfo runningAppProcessInfo : activityManager.getRunningAppProcesses()) {
                    if (runningAppProcessInfo.pid == i) {
                        return runningAppProcessInfo.processName;
                    }
                }
                return null;
            }
            return null;
        } catch (Exception unused) {
            return null;
        }
    }

    static boolean m() {
        try {
            for (String str : f2847a) {
                if (new File(str).exists()) {
                    return true;
                }
            }
        } catch (Exception unused) {
        }
        return false;
    }
}
