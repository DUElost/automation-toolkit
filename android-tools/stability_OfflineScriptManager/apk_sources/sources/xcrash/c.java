package xcrash;

import java.io.File;
import java.io.FilenameFilter;
import java.io.RandomAccessFile;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.atomic.AtomicInteger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class c {
    private static final c m = new c();

    /* renamed from: a  reason: collision with root package name */
    private String f2830a = "placeholder";

    /* renamed from: b  reason: collision with root package name */
    private String f2831b = ".clean.xcrash";

    /* renamed from: c  reason: collision with root package name */
    private String f2832c = ".dirty.xcrash";

    /* renamed from: d  reason: collision with root package name */
    private String f2833d = null;
    private int e = 0;
    private int f = 0;
    private int g = 0;
    private int h = 1;
    private int i = 0;
    private int j = 0;
    private int k = 0;
    private AtomicInteger l = new AtomicInteger();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements FilenameFilter {
        a() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            StringBuilder sb = new StringBuilder();
            sb.append(c.this.f2830a);
            sb.append("_");
            return str.startsWith(sb.toString()) && str.endsWith(c.this.f2832c);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            c.this.h();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: xcrash.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0122c extends TimerTask {
        C0122c() {
        }

        @Override // java.util.TimerTask, java.lang.Runnable
        public void run() {
            c.this.h();
        }
    }

    /* loaded from: classes.dex */
    class d implements FilenameFilter {
        d() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            StringBuilder sb = new StringBuilder();
            sb.append(c.this.f2830a);
            sb.append("_");
            return str.startsWith(sb.toString()) && str.endsWith(c.this.f2831b);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements FilenameFilter {
        e() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            StringBuilder sb = new StringBuilder();
            sb.append(c.this.f2830a);
            sb.append("_");
            return str.startsWith(sb.toString()) && str.endsWith(c.this.f2831b);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements FilenameFilter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ String f2839a;

        f(c cVar, String str) {
            this.f2839a = str;
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            return str.startsWith("tombstone_") && str.endsWith(this.f2839a);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g implements Comparator<File> {
        g(c cVar) {
        }

        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(File file, File file2) {
            return file.getName().compareTo(file2.getName());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h implements FilenameFilter {
        h() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            StringBuilder sb = new StringBuilder();
            sb.append(c.this.f2830a);
            sb.append("_");
            return str.startsWith(sb.toString()) && str.endsWith(c.this.f2831b);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class i implements FilenameFilter {
        i() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            StringBuilder sb = new StringBuilder();
            sb.append(c.this.f2830a);
            sb.append("_");
            return str.startsWith(sb.toString()) && str.endsWith(c.this.f2832c);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class j implements FilenameFilter {
        j() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            StringBuilder sb = new StringBuilder();
            sb.append(c.this.f2830a);
            sb.append("_");
            return str.startsWith(sb.toString()) && str.endsWith(c.this.f2831b);
        }
    }

    private c() {
    }

    /* JADX WARN: Removed duplicated region for block: B:36:0x00b0 A[Catch: Exception -> 0x00b3, TRY_ENTER, TRY_LEAVE, TryCatch #6 {Exception -> 0x00b3, blocks: (B:36:0x00b0, B:21:0x0090), top: B:57:0x0006 }] */
    /* JADX WARN: Removed duplicated region for block: B:53:0x00b5 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private boolean f(java.io.File r17) {
        /*
            r16 = this;
            r1 = r16
            r0 = 1024(0x400, float:1.435E-42)
            r2 = 0
            r3 = 0
            byte[] r4 = new byte[r0]     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            java.util.Arrays.fill(r4, r2)     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            int r5 = r1.j     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            long r5 = (long) r5     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            long r7 = r17.length()     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            int r9 = r1.j     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            int r9 = r9 * r0
            long r9 = (long) r9     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            int r0 = (r7 > r9 ? 1 : (r7 == r9 ? 0 : -1))
            r9 = 0
            r11 = 1024(0x400, double:5.06E-321)
            if (r0 <= 0) goto L29
            long r5 = r7 / r11
            long r13 = r7 % r11
            int r0 = (r13 > r9 ? 1 : (r13 == r9 ? 0 : -1))
            if (r0 == 0) goto L29
            r13 = 1
            long r5 = r5 + r13
        L29:
            java.io.FileOutputStream r13 = new java.io.FileOutputStream     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            java.io.File r0 = r17.getAbsoluteFile()     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            r13.<init>(r0, r2)     // Catch: java.lang.Throwable -> L9e java.lang.Exception -> La0
            r0 = r2
        L33:
            long r14 = (long) r0
            int r3 = (r14 > r5 ? 1 : (r14 == r5 ? 0 : -1))
            if (r3 >= 0) goto L50
            int r0 = r0 + 1
            long r14 = (long) r0
            int r3 = (r14 > r5 ? 1 : (r14 == r5 ? 0 : -1))
            if (r3 != 0) goto L4c
            long r14 = r7 % r11
            int r3 = (r14 > r9 ? 1 : (r14 == r9 ? 0 : -1))
            if (r3 == 0) goto L4c
            long r14 = r7 % r11
            int r3 = (int) r14     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r13.write(r4, r2, r3)     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            goto L33
        L4c:
            r13.write(r4)     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            goto L33
        L50:
            r13.flush()     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            java.util.Locale r0 = java.util.Locale.US     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            java.lang.String r3 = "%s/%s_%020d%s"
            r4 = 4
            java.lang.Object[] r4 = new java.lang.Object[r4]     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            java.lang.String r5 = r1.f2833d     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r4[r2] = r5     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            java.lang.String r5 = r1.f2830a     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r6 = 1
            r4[r6] = r5     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r5 = 2
            java.util.Date r6 = new java.util.Date     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r6.<init>()     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            long r6 = r6.getTime()     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r8 = 1000(0x3e8, double:4.94E-321)
            long r6 = r6 * r8
            int r8 = r16.m()     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            long r8 = (long) r8     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            long r6 = r6 + r8
            java.lang.Long r6 = java.lang.Long.valueOf(r6)     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r4[r5] = r6     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r5 = 3
            java.lang.String r6 = r1.f2831b     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r4[r5] = r6     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            java.lang.String r0 = java.lang.String.format(r0, r3, r4)     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            java.io.File r3 = new java.io.File     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r3.<init>(r0)     // Catch: java.lang.Throwable -> L96 java.lang.Exception -> L99
            r4 = r17
            boolean r2 = r4.renameTo(r3)     // Catch: java.lang.Exception -> L94 java.lang.Throwable -> L96
            r13.close()     // Catch: java.lang.Exception -> Lb3
            goto Lb3
        L94:
            r0 = move-exception
            goto L9c
        L96:
            r0 = move-exception
            r3 = r13
            goto Lb9
        L99:
            r0 = move-exception
            r4 = r17
        L9c:
            r3 = r13
            goto La3
        L9e:
            r0 = move-exception
            goto Lb9
        La0:
            r0 = move-exception
            r4 = r17
        La3:
            xcrash.f r5 = xcrash.j.a()     // Catch: java.lang.Throwable -> L9e
            java.lang.String r6 = "xcrash"
            java.lang.String r7 = "FileManager cleanTheDirtyFile failed"
            r5.d(r6, r7, r0)     // Catch: java.lang.Throwable -> L9e
            if (r3 == 0) goto Lb3
            r3.close()     // Catch: java.lang.Exception -> Lb3
        Lb3:
            if (r2 != 0) goto Lb8
            r17.delete()     // Catch: java.lang.Exception -> Lb8
        Lb8:
            return r2
        Lb9:
            if (r3 == 0) goto Lbe
            r3.close()     // Catch: java.lang.Exception -> Lbe
        Lbe:
            throw r0
        */
        throw new UnsupportedOperationException("Method not decompiled: xcrash.c.f(java.io.File):boolean");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        if (xcrash.i.a(this.f2833d)) {
            File file = new File(this.f2833d);
            try {
                j(file);
            } catch (Exception e2) {
                xcrash.j.a().d("xcrash", "FileManager doMaintainTombstone failed", e2);
            }
            try {
                i(file);
            } catch (Exception e3) {
                xcrash.j.a().d("xcrash", "FileManager doMaintainPlaceholder failed", e3);
            }
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:28:0x0086 A[LOOP:0: B:9:0x0020->B:28:0x0086, LOOP_END] */
    /* JADX WARN: Removed duplicated region for block: B:50:0x008a A[EDGE_INSN: B:50:0x008a->B:30:0x008a ?: BREAK  , SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void i(java.io.File r19) {
        /*
            r18 = this;
            r0 = r18
            r1 = r19
            xcrash.c$h r2 = new xcrash.c$h
            r2.<init>()
            java.io.File[] r2 = r1.listFiles(r2)
            if (r2 != 0) goto L10
            return
        L10:
            xcrash.c$i r3 = new xcrash.c$i
            r3.<init>()
            java.io.File[] r3 = r1.listFiles(r3)
            if (r3 != 0) goto L1c
            return
        L1c:
            int r4 = r2.length
            int r5 = r3.length
            r6 = 0
            r7 = r6
        L20:
            int r8 = r0.i
            if (r4 >= r8) goto L88
            r8 = 2
            if (r5 <= 0) goto L38
            int r9 = r5 + (-1)
            r9 = r3[r9]
            boolean r9 = r0.f(r9)
            if (r9 == 0) goto L33
            int r4 = r4 + 1
        L33:
            int r5 = r5 + (-1)
        L35:
            r17 = r7
            goto L7e
        L38:
            java.io.File r9 = new java.io.File     // Catch: java.lang.Exception -> L35
            java.util.Locale r10 = java.util.Locale.US     // Catch: java.lang.Exception -> L35
            java.lang.String r11 = "%s/%s_%020d%s"
            r12 = 4
            java.lang.Object[] r12 = new java.lang.Object[r12]     // Catch: java.lang.Exception -> L35
            java.lang.String r13 = r0.f2833d     // Catch: java.lang.Exception -> L35
            r12[r6] = r13     // Catch: java.lang.Exception -> L35
            java.lang.String r13 = r0.f2830a     // Catch: java.lang.Exception -> L35
            r14 = 1
            r12[r14] = r13     // Catch: java.lang.Exception -> L35
            java.util.Date r13 = new java.util.Date     // Catch: java.lang.Exception -> L35
            r13.<init>()     // Catch: java.lang.Exception -> L35
            long r13 = r13.getTime()     // Catch: java.lang.Exception -> L35
            r15 = 1000(0x3e8, double:4.94E-321)
            long r13 = r13 * r15
            int r15 = r18.m()     // Catch: java.lang.Exception -> L35
            r17 = r7
            long r6 = (long) r15
            long r13 = r13 + r6
            java.lang.Long r6 = java.lang.Long.valueOf(r13)     // Catch: java.lang.Exception -> L7e
            r12[r8] = r6     // Catch: java.lang.Exception -> L7e
            r6 = 3
            java.lang.String r7 = r0.f2832c     // Catch: java.lang.Exception -> L7e
            r12[r6] = r7     // Catch: java.lang.Exception -> L7e
            java.lang.String r6 = java.lang.String.format(r10, r11, r12)     // Catch: java.lang.Exception -> L7e
            r9.<init>(r6)     // Catch: java.lang.Exception -> L7e
            boolean r6 = r9.createNewFile()     // Catch: java.lang.Exception -> L7e
            if (r6 == 0) goto L7e
            boolean r6 = r0.f(r9)     // Catch: java.lang.Exception -> L7e
            if (r6 == 0) goto L7e
            int r4 = r4 + 1
        L7e:
            int r7 = r17 + 1
            int r6 = r0.i
            int r6 = r6 * r8
            if (r7 <= r6) goto L86
            goto L8a
        L86:
            r6 = 0
            goto L20
        L88:
            r17 = r7
        L8a:
            if (r7 <= 0) goto L9e
            xcrash.c$j r2 = new xcrash.c$j
            r2.<init>()
            java.io.File[] r2 = r1.listFiles(r2)
            xcrash.c$a r3 = new xcrash.c$a
            r3.<init>()
            java.io.File[] r3 = r1.listFiles(r3)
        L9e:
            if (r2 == 0) goto Lb4
            int r1 = r2.length
            int r4 = r0.i
            if (r1 <= r4) goto Lb4
            r1 = 0
        La6:
            int r4 = r2.length
            int r5 = r0.i
            int r4 = r4 - r5
            if (r1 >= r4) goto Lb4
            r4 = r2[r1]
            r4.delete()
            int r1 = r1 + 1
            goto La6
        Lb4:
            if (r3 == 0) goto Lc2
            int r1 = r3.length
            r6 = 0
        Lb8:
            if (r6 >= r1) goto Lc2
            r2 = r3[r6]
            r2.delete()
            int r6 = r6 + 1
            goto Lb8
        Lc2:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: xcrash.c.i(java.io.File):void");
    }

    private void j(File file) {
        k(file, ".native.xcrash", this.f);
        k(file, ".java.xcrash", this.e);
        k(file, ".anr.xcrash", this.g);
        k(file, ".trace.xcrash", this.h);
    }

    private boolean k(File file, String str, int i2) {
        File[] listFiles = file.listFiles(new f(this, str));
        boolean z = true;
        if (listFiles != null && listFiles.length > i2) {
            if (i2 > 0) {
                Arrays.sort(listFiles, new g(this));
            }
            for (int i3 = 0; i3 < listFiles.length - i2; i3++) {
                if (!q(listFiles[i3])) {
                    z = false;
                }
            }
        }
        return z;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static c l() {
        return m;
    }

    private int m() {
        int incrementAndGet = this.l.incrementAndGet();
        if (incrementAndGet >= 999) {
            this.l.set(0);
        }
        return incrementAndGet;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean e(String str, String str2) {
        RandomAccessFile randomAccessFile;
        RandomAccessFile randomAccessFile2 = null;
        try {
            try {
                randomAccessFile = new RandomAccessFile(str, "rws");
            } catch (Exception e2) {
                e = e2;
            }
        } catch (Throwable th) {
            th = th;
        }
        try {
            long j2 = 0;
            if (randomAccessFile.length() > 0) {
                MappedByteBuffer map = randomAccessFile.getChannel().map(FileChannel.MapMode.READ_ONLY, 0L, randomAccessFile.length());
                long length = randomAccessFile.length();
                while (length > 0 && map.get(((int) length) - 1) == 0) {
                    length--;
                }
                j2 = length;
            }
            randomAccessFile.seek(j2);
            randomAccessFile.write(str2.getBytes("UTF-8"));
            try {
                randomAccessFile.close();
            } catch (Exception unused) {
            }
            return true;
        } catch (Exception e3) {
            e = e3;
            randomAccessFile2 = randomAccessFile;
            xcrash.j.a().d("xcrash", "FileManager appendText failed", e);
            if (randomAccessFile2 != null) {
                try {
                    randomAccessFile2.close();
                } catch (Exception unused2) {
                }
            }
            return false;
        } catch (Throwable th2) {
            th = th2;
            randomAccessFile2 = randomAccessFile;
            if (randomAccessFile2 != null) {
                try {
                    randomAccessFile2.close();
                } catch (Exception unused3) {
                }
            }
            throw th;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public File g(String str) {
        String str2 = this.f2833d;
        if (str2 != null && xcrash.i.a(str2)) {
            File file = new File(str);
            File[] listFiles = new File(this.f2833d).listFiles(new d());
            if (listFiles != null) {
                for (int length = listFiles.length; length > 0; length--) {
                    File file2 = listFiles[length - 1];
                    try {
                    } catch (Exception e2) {
                        xcrash.j.a().d("xcrash", "FileManager createLogFile by renameTo failed", e2);
                    }
                    if (file2.renameTo(file)) {
                        return file;
                    }
                    file2.delete();
                }
            }
            try {
                if (file.createNewFile()) {
                    return file;
                }
                xcrash.j.a().b("xcrash", "FileManager createLogFile by createNewFile failed, file already exists");
                return null;
            } catch (Exception e3) {
                xcrash.j.a().d("xcrash", "FileManager createLogFile by createNewFile failed", e3);
                return null;
            }
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void n(String str, int i2, int i3, int i4, int i5, int i6, int i7) {
        File[] listFiles;
        this.f2833d = str;
        this.e = i2;
        this.f = i3;
        this.g = i4;
        this.i = i5;
        this.j = i6;
        this.k = i7;
        try {
            File file = new File(str);
            if (file.exists() && file.isDirectory() && (listFiles = file.listFiles()) != null) {
                int i8 = 0;
                int i9 = 0;
                int i10 = 0;
                int i11 = 0;
                int i12 = 0;
                int i13 = 0;
                for (File file2 : listFiles) {
                    if (file2.isFile()) {
                        String name = file2.getName();
                        if (!name.startsWith("tombstone_")) {
                            if (name.startsWith(this.f2830a + "_")) {
                                if (name.endsWith(this.f2831b)) {
                                    i12++;
                                } else if (name.endsWith(this.f2832c)) {
                                    i13++;
                                }
                            }
                        } else if (name.endsWith(".java.xcrash")) {
                            i8++;
                        } else if (name.endsWith(".native.xcrash")) {
                            i9++;
                        } else if (name.endsWith(".anr.xcrash")) {
                            i10++;
                        } else if (name.endsWith(".trace.xcrash")) {
                            i11++;
                        }
                    }
                }
                int i14 = this.e;
                if (i8 > i14 || i9 > this.f || i10 > this.g || i11 > this.h || i12 != this.i || i13 != 0) {
                    if (i8 <= i14 + 10) {
                        int i15 = this.f;
                        if (i9 <= i15 + 10) {
                            int i16 = this.g;
                            if (i10 <= i16 + 10) {
                                int i17 = this.h;
                                if (i11 <= i17 + 10) {
                                    int i18 = this.i;
                                    if (i12 <= i18 + 10 && i13 <= 10) {
                                        if (i8 > i14 || i9 > i15 || i10 > i16 || i11 > i17 || i12 > i18 || i13 > 0) {
                                            this.k = 0;
                                            return;
                                        }
                                        return;
                                    }
                                }
                            }
                        }
                    }
                    h();
                }
                this.k = -1;
            }
        } catch (Exception e2) {
            xcrash.j.a().d("xcrash", "FileManager init failed", e2);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o() {
        int i2;
        if (this.f2833d == null || (i2 = this.k) < 0) {
            return;
        }
        try {
            if (i2 == 0) {
                new Thread(new b(), "xcrash_file_mgr").start();
            } else {
                new Timer("xcrash_file_mgr").schedule(new C0122c(), this.k);
            }
        } catch (Exception e2) {
            xcrash.j.a().d("xcrash", "FileManager maintain start failed", e2);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean p() {
        if (xcrash.i.a(this.f2833d)) {
            try {
                return k(new File(this.f2833d), ".anr.xcrash", this.g);
            } catch (Exception e2) {
                xcrash.j.a().d("xcrash", "FileManager maintainAnr failed", e2);
                return false;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean q(File file) {
        if (file == null) {
            return false;
        }
        if (this.f2833d == null || this.i <= 0) {
            try {
                return file.delete();
            } catch (Exception unused) {
                return false;
            }
        }
        try {
            File[] listFiles = new File(this.f2833d).listFiles(new e());
            if (listFiles != null && listFiles.length >= this.i) {
                try {
                    return file.delete();
                } catch (Exception unused2) {
                    return false;
                }
            }
            File file2 = new File(String.format(Locale.US, "%s/%s_%020d%s", this.f2833d, this.f2830a, Long.valueOf((new Date().getTime() * 1000) + m()), this.f2832c));
            if (file.renameTo(file2)) {
                return f(file2);
            }
            try {
                return file.delete();
            } catch (Exception unused3) {
                return false;
            }
        } catch (Exception e2) {
            xcrash.j.a().d("xcrash", "FileManager recycleLogFile failed", e2);
            try {
                return file.delete();
            } catch (Exception unused4) {
                return false;
            }
        }
    }
}
