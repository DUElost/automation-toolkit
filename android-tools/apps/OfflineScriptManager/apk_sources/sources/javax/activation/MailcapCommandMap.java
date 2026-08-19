package javax.activation;

import com.sun.activation.registries.LogSupport;
import com.sun.activation.registries.MailcapFile;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
/* loaded from: classes.dex */
public class MailcapCommandMap extends CommandMap {
    private static final int PROG = 0;
    private static MailcapFile defDB;
    private MailcapFile[] DB;

    public MailcapCommandMap() {
        ArrayList arrayList = new ArrayList(5);
        arrayList.add(null);
        LogSupport.log("MailcapCommandMap: load HOME");
        try {
            String property = System.getProperty("user.home");
            if (property != null) {
                MailcapFile loadFile = loadFile(String.valueOf(property) + File.separator + ".mailcap");
                if (loadFile != null) {
                    arrayList.add(loadFile);
                }
            }
        } catch (SecurityException unused) {
        }
        LogSupport.log("MailcapCommandMap: load SYS");
        try {
            StringBuilder sb = new StringBuilder(String.valueOf(System.getProperty("java.home")));
            String str = File.separator;
            sb.append(str);
            sb.append("lib");
            sb.append(str);
            sb.append("mailcap");
            MailcapFile loadFile2 = loadFile(sb.toString());
            if (loadFile2 != null) {
                arrayList.add(loadFile2);
            }
        } catch (SecurityException unused2) {
        }
        LogSupport.log("MailcapCommandMap: load JAR");
        loadAllResources(arrayList, "mailcap");
        LogSupport.log("MailcapCommandMap: load DEF");
        synchronized (MailcapCommandMap.class) {
            if (defDB == null) {
                defDB = loadResource("mailcap.default");
            }
        }
        MailcapFile mailcapFile = defDB;
        if (mailcapFile != null) {
            arrayList.add(mailcapFile);
        }
        MailcapFile[] mailcapFileArr = new MailcapFile[arrayList.size()];
        this.DB = mailcapFileArr;
        this.DB = (MailcapFile[]) arrayList.toArray(mailcapFileArr);
    }

    public MailcapCommandMap(InputStream inputStream) {
        this();
        LogSupport.log("MailcapCommandMap: load PROG");
        MailcapFile[] mailcapFileArr = this.DB;
        if (mailcapFileArr[0] == null) {
            try {
                mailcapFileArr[0] = new MailcapFile(inputStream);
            } catch (IOException unused) {
            }
        }
    }

    public MailcapCommandMap(String str) {
        this();
        if (LogSupport.isLoggable()) {
            LogSupport.log("MailcapCommandMap: load PROG from " + str);
        }
        MailcapFile[] mailcapFileArr = this.DB;
        if (mailcapFileArr[0] == null) {
            mailcapFileArr[0] = new MailcapFile(str);
        }
    }

    private void appendCmdsToList(Map map, List list) {
        for (String str : map.keySet()) {
            for (String str2 : (List) map.get(str)) {
                list.add(new CommandInfo(str, str2));
            }
        }
    }

    private void appendPrefCmdsToList(Map map, List list) {
        for (String str : map.keySet()) {
            if (!checkForVerb(list, str)) {
                list.add(new CommandInfo(str, (String) ((List) map.get(str)).get(0)));
            }
        }
    }

    private boolean checkForVerb(List list, String str) {
        Iterator it = list.iterator();
        while (it.hasNext()) {
            if (((CommandInfo) it.next()).getCommandName().equals(str)) {
                return true;
            }
        }
        return false;
    }

    private DataContentHandler getDataContentHandler(String str) {
        StringBuilder sb;
        Class<?> cls;
        if (LogSupport.isLoggable()) {
            LogSupport.log("    got content-handler");
        }
        if (LogSupport.isLoggable()) {
            LogSupport.log("      class " + str);
        }
        try {
            ClassLoader contextClassLoader = SecuritySupport.getContextClassLoader();
            if (contextClassLoader == null) {
                contextClassLoader = getClass().getClassLoader();
            }
            try {
                cls = contextClassLoader.loadClass(str);
            } catch (Exception unused) {
                cls = Class.forName(str);
            }
            if (cls != null) {
                return (DataContentHandler) cls.newInstance();
            }
            return null;
        } catch (ClassNotFoundException e) {
            e = e;
            if (LogSupport.isLoggable()) {
                sb = new StringBuilder("Can't load DCH ");
                sb.append(str);
                LogSupport.log(sb.toString(), e);
                return null;
            }
            return null;
        } catch (IllegalAccessException e2) {
            e = e2;
            if (LogSupport.isLoggable()) {
                sb = new StringBuilder("Can't load DCH ");
                sb.append(str);
                LogSupport.log(sb.toString(), e);
                return null;
            }
            return null;
        } catch (InstantiationException e3) {
            e = e3;
            if (LogSupport.isLoggable()) {
                sb = new StringBuilder("Can't load DCH ");
                sb.append(str);
                LogSupport.log(sb.toString(), e);
                return null;
            }
            return null;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:52:0x00ca, code lost:
        if (r5 != null) goto L55;
     */
    /* JADX WARN: Removed duplicated region for block: B:71:0x00fb  */
    /* JADX WARN: Removed duplicated region for block: B:99:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void loadAllResources(java.util.List r10, java.lang.String r11) {
        /*
            Method dump skipped, instructions count: 286
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: javax.activation.MailcapCommandMap.loadAllResources(java.util.List, java.lang.String):void");
    }

    private MailcapFile loadFile(String str) {
        try {
            return new MailcapFile(str);
        } catch (IOException unused) {
            return null;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:14:0x0046, code lost:
        if (r2 != null) goto L21;
     */
    /* JADX WARN: Code restructure failed: missing block: B:35:0x0083, code lost:
        if (r2 != null) goto L21;
     */
    /* JADX WARN: Not initialized variable reg: 2, insn: 0x0088: MOVE  (r1 I:??[OBJECT, ARRAY]) = (r2 I:??[OBJECT, ARRAY]), block:B:39:0x0088 */
    /* JADX WARN: Removed duplicated region for block: B:49:0x008b A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private com.sun.activation.registries.MailcapFile loadResource(java.lang.String r7) {
        /*
            r6 = this;
            java.lang.String r0 = "MailcapCommandMap: can't load "
            r1 = 0
            java.lang.Class r2 = r6.getClass()     // Catch: java.lang.Throwable -> L50 java.lang.SecurityException -> L52 java.io.IOException -> L6c
            java.io.InputStream r2 = javax.activation.SecuritySupport.getResourceAsStream(r2, r7)     // Catch: java.lang.Throwable -> L50 java.lang.SecurityException -> L52 java.io.IOException -> L6c
            if (r2 == 0) goto L2f
            com.sun.activation.registries.MailcapFile r3 = new com.sun.activation.registries.MailcapFile     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            r3.<init>(r2)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            boolean r4 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            if (r4 == 0) goto L29
            java.lang.StringBuilder r4 = new java.lang.StringBuilder     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            java.lang.String r5 = "MailcapCommandMap: successfully loaded mailcap file: "
            r4.<init>(r5)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            r4.append(r7)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            java.lang.String r4 = r4.toString()     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            com.sun.activation.registries.LogSupport.log(r4)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
        L29:
            if (r2 == 0) goto L2e
            r2.close()     // Catch: java.io.IOException -> L2e
        L2e:
            return r3
        L2f:
            boolean r3 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            if (r3 == 0) goto L46
            java.lang.StringBuilder r3 = new java.lang.StringBuilder     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            java.lang.String r4 = "MailcapCommandMap: not loading mailcap file: "
            r3.<init>(r4)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            r3.append(r7)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            java.lang.String r3 = r3.toString()     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            com.sun.activation.registries.LogSupport.log(r3)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
        L46:
            if (r2 == 0) goto L86
        L48:
            r2.close()     // Catch: java.io.IOException -> L86
            goto L86
        L4c:
            r3 = move-exception
            goto L54
        L4e:
            r3 = move-exception
            goto L6e
        L50:
            r7 = move-exception
            goto L89
        L52:
            r3 = move-exception
            r2 = r1
        L54:
            boolean r4 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.Throwable -> L87
            if (r4 == 0) goto L69
            java.lang.StringBuilder r4 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L87
            r4.<init>(r0)     // Catch: java.lang.Throwable -> L87
            r4.append(r7)     // Catch: java.lang.Throwable -> L87
            java.lang.String r7 = r4.toString()     // Catch: java.lang.Throwable -> L87
            com.sun.activation.registries.LogSupport.log(r7, r3)     // Catch: java.lang.Throwable -> L87
        L69:
            if (r2 == 0) goto L86
            goto L48
        L6c:
            r3 = move-exception
            r2 = r1
        L6e:
            boolean r4 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.Throwable -> L87
            if (r4 == 0) goto L83
            java.lang.StringBuilder r4 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L87
            r4.<init>(r0)     // Catch: java.lang.Throwable -> L87
            r4.append(r7)     // Catch: java.lang.Throwable -> L87
            java.lang.String r7 = r4.toString()     // Catch: java.lang.Throwable -> L87
            com.sun.activation.registries.LogSupport.log(r7, r3)     // Catch: java.lang.Throwable -> L87
        L83:
            if (r2 == 0) goto L86
            goto L48
        L86:
            return r1
        L87:
            r7 = move-exception
            r1 = r2
        L89:
            if (r1 == 0) goto L8e
            r1.close()     // Catch: java.io.IOException -> L8e
        L8e:
            throw r7
        */
        throw new UnsupportedOperationException("Method not decompiled: javax.activation.MailcapCommandMap.loadResource(java.lang.String):com.sun.activation.registries.MailcapFile");
    }

    public synchronized void addMailcap(String str) {
        LogSupport.log("MailcapCommandMap: add to PROG");
        MailcapFile[] mailcapFileArr = this.DB;
        if (mailcapFileArr[0] == null) {
            mailcapFileArr[0] = new MailcapFile();
        }
        this.DB[0].appendToMailcap(str);
    }

    /* JADX WARN: Code restructure failed: missing block: B:11:0x0027, code lost:
        r1 = 0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:12:0x0028, code lost:
        r2 = r4.DB;
     */
    /* JADX WARN: Code restructure failed: missing block: B:13:0x002b, code lost:
        if (r1 < r2.length) goto L36;
     */
    /* JADX WARN: Code restructure failed: missing block: B:16:0x002f, code lost:
        return null;
     */
    /* JADX WARN: Code restructure failed: missing block: B:18:0x0032, code lost:
        if (r2[r1] != null) goto L41;
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x0039, code lost:
        if (com.sun.activation.registries.LogSupport.isLoggable() == false) goto L44;
     */
    /* JADX WARN: Code restructure failed: missing block: B:22:0x003b, code lost:
        com.sun.activation.registries.LogSupport.log("  search fallback DB #" + r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:23:0x004c, code lost:
        r2 = r4.DB[r1].getMailcapFallbackList(r5);
     */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x0054, code lost:
        if (r2 == null) goto L55;
     */
    /* JADX WARN: Code restructure failed: missing block: B:25:0x0056, code lost:
        r2 = (java.util.List) r2.get("content-handler");
     */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x005e, code lost:
        if (r2 == null) goto L54;
     */
    /* JADX WARN: Code restructure failed: missing block: B:27:0x0060, code lost:
        r2 = getDataContentHandler((java.lang.String) r2.get(0));
     */
    /* JADX WARN: Code restructure failed: missing block: B:28:0x006a, code lost:
        if (r2 == null) goto L53;
     */
    /* JADX WARN: Code restructure failed: missing block: B:30:0x006d, code lost:
        return r2;
     */
    /* JADX WARN: Code restructure failed: missing block: B:31:0x006e, code lost:
        r1 = r1 + 1;
     */
    @Override // javax.activation.CommandMap
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public synchronized javax.activation.DataContentHandler createDataContentHandler(java.lang.String r5) {
        /*
            r4 = this;
            monitor-enter(r4)
            boolean r0 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.Throwable -> Lb3
            if (r0 == 0) goto L18
            java.lang.StringBuilder r0 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r1 = "MailcapCommandMap: createDataContentHandler for "
            r0.<init>(r1)     // Catch: java.lang.Throwable -> Lb3
            r0.append(r5)     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r0 = r0.toString()     // Catch: java.lang.Throwable -> Lb3
            com.sun.activation.registries.LogSupport.log(r0)     // Catch: java.lang.Throwable -> Lb3
        L18:
            if (r5 == 0) goto L20
            java.util.Locale r0 = java.util.Locale.ENGLISH     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r5 = r5.toLowerCase(r0)     // Catch: java.lang.Throwable -> Lb3
        L20:
            r0 = 0
            r1 = r0
        L22:
            com.sun.activation.registries.MailcapFile[] r2 = r4.DB     // Catch: java.lang.Throwable -> Lb3
            int r3 = r2.length     // Catch: java.lang.Throwable -> Lb3
            if (r1 < r3) goto L71
            r1 = r0
        L28:
            com.sun.activation.registries.MailcapFile[] r2 = r4.DB     // Catch: java.lang.Throwable -> Lb3
            int r3 = r2.length     // Catch: java.lang.Throwable -> Lb3
            if (r1 < r3) goto L30
            r5 = 0
            monitor-exit(r4)
            return r5
        L30:
            r2 = r2[r1]     // Catch: java.lang.Throwable -> Lb3
            if (r2 != 0) goto L35
            goto L6e
        L35:
            boolean r2 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto L4c
            java.lang.StringBuilder r2 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r3 = "  search fallback DB #"
            r2.<init>(r3)     // Catch: java.lang.Throwable -> Lb3
            r2.append(r1)     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r2 = r2.toString()     // Catch: java.lang.Throwable -> Lb3
            com.sun.activation.registries.LogSupport.log(r2)     // Catch: java.lang.Throwable -> Lb3
        L4c:
            com.sun.activation.registries.MailcapFile[] r2 = r4.DB     // Catch: java.lang.Throwable -> Lb3
            r2 = r2[r1]     // Catch: java.lang.Throwable -> Lb3
            java.util.Map r2 = r2.getMailcapFallbackList(r5)     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto L6e
            java.lang.String r3 = "content-handler"
            java.lang.Object r2 = r2.get(r3)     // Catch: java.lang.Throwable -> Lb3
            java.util.List r2 = (java.util.List) r2     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto L6e
            java.lang.Object r2 = r2.get(r0)     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r2 = (java.lang.String) r2     // Catch: java.lang.Throwable -> Lb3
            javax.activation.DataContentHandler r2 = r4.getDataContentHandler(r2)     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto L6e
            monitor-exit(r4)
            return r2
        L6e:
            int r1 = r1 + 1
            goto L28
        L71:
            r2 = r2[r1]     // Catch: java.lang.Throwable -> Lb3
            if (r2 != 0) goto L76
            goto Laf
        L76:
            boolean r2 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto L8d
            java.lang.StringBuilder r2 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r3 = "  search DB #"
            r2.<init>(r3)     // Catch: java.lang.Throwable -> Lb3
            r2.append(r1)     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r2 = r2.toString()     // Catch: java.lang.Throwable -> Lb3
            com.sun.activation.registries.LogSupport.log(r2)     // Catch: java.lang.Throwable -> Lb3
        L8d:
            com.sun.activation.registries.MailcapFile[] r2 = r4.DB     // Catch: java.lang.Throwable -> Lb3
            r2 = r2[r1]     // Catch: java.lang.Throwable -> Lb3
            java.util.Map r2 = r2.getMailcapList(r5)     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto Laf
            java.lang.String r3 = "content-handler"
            java.lang.Object r2 = r2.get(r3)     // Catch: java.lang.Throwable -> Lb3
            java.util.List r2 = (java.util.List) r2     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto Laf
            java.lang.Object r2 = r2.get(r0)     // Catch: java.lang.Throwable -> Lb3
            java.lang.String r2 = (java.lang.String) r2     // Catch: java.lang.Throwable -> Lb3
            javax.activation.DataContentHandler r2 = r4.getDataContentHandler(r2)     // Catch: java.lang.Throwable -> Lb3
            if (r2 == 0) goto Laf
            monitor-exit(r4)
            return r2
        Laf:
            int r1 = r1 + 1
            goto L22
        Lb3:
            r5 = move-exception
            monitor-exit(r4)
            throw r5
        */
        throw new UnsupportedOperationException("Method not decompiled: javax.activation.MailcapCommandMap.createDataContentHandler(java.lang.String):javax.activation.DataContentHandler");
    }

    @Override // javax.activation.CommandMap
    public synchronized CommandInfo[] getAllCommands(String str) {
        ArrayList arrayList;
        Map mailcapFallbackList;
        Map mailcapList;
        arrayList = new ArrayList();
        if (str != null) {
            str = str.toLowerCase(Locale.ENGLISH);
        }
        int i = 0;
        int i2 = 0;
        while (true) {
            MailcapFile[] mailcapFileArr = this.DB;
            if (i2 >= mailcapFileArr.length) {
                break;
            }
            if (mailcapFileArr[i2] != null && (mailcapList = mailcapFileArr[i2].getMailcapList(str)) != null) {
                appendCmdsToList(mailcapList, arrayList);
            }
            i2++;
        }
        while (true) {
            MailcapFile[] mailcapFileArr2 = this.DB;
            if (i >= mailcapFileArr2.length) {
            } else {
                if (mailcapFileArr2[i] != null && (mailcapFallbackList = mailcapFileArr2[i].getMailcapFallbackList(str)) != null) {
                    appendCmdsToList(mailcapFallbackList, arrayList);
                }
                i++;
            }
        }
        return (CommandInfo[]) arrayList.toArray(new CommandInfo[arrayList.size()]);
    }

    @Override // javax.activation.CommandMap
    public synchronized CommandInfo getCommand(String str, String str2) {
        Map mailcapFallbackList;
        List list;
        String str3;
        Map mailcapList;
        List list2;
        String str4;
        if (str != null) {
            try {
                str = str.toLowerCase(Locale.ENGLISH);
            } catch (Throwable th) {
                throw th;
            }
        }
        int i = 0;
        while (true) {
            MailcapFile[] mailcapFileArr = this.DB;
            if (i >= mailcapFileArr.length) {
                int i2 = 0;
                while (true) {
                    MailcapFile[] mailcapFileArr2 = this.DB;
                    if (i2 >= mailcapFileArr2.length) {
                        return null;
                    }
                    if (mailcapFileArr2[i2] != null && (mailcapFallbackList = mailcapFileArr2[i2].getMailcapFallbackList(str)) != null && (list = (List) mailcapFallbackList.get(str2)) != null && (str3 = (String) list.get(0)) != null) {
                        return new CommandInfo(str2, str3);
                    }
                    i2++;
                }
            } else {
                if (mailcapFileArr[i] != null && (mailcapList = mailcapFileArr[i].getMailcapList(str)) != null && (list2 = (List) mailcapList.get(str2)) != null && (str4 = (String) list2.get(0)) != null) {
                    return new CommandInfo(str2, str4);
                }
                i++;
            }
        }
    }

    @Override // javax.activation.CommandMap
    public synchronized String[] getMimeTypes() {
        ArrayList arrayList;
        String[] mimeTypes;
        arrayList = new ArrayList();
        int i = 0;
        while (true) {
            MailcapFile[] mailcapFileArr = this.DB;
            if (i < mailcapFileArr.length) {
                if (mailcapFileArr[i] != null && (mimeTypes = mailcapFileArr[i].getMimeTypes()) != null) {
                    for (int i2 = 0; i2 < mimeTypes.length; i2++) {
                        if (!arrayList.contains(mimeTypes[i2])) {
                            arrayList.add(mimeTypes[i2]);
                        }
                    }
                }
                i++;
            }
        }
        return (String[]) arrayList.toArray(new String[arrayList.size()]);
    }

    public synchronized String[] getNativeCommands(String str) {
        ArrayList arrayList;
        String[] nativeCommands;
        arrayList = new ArrayList();
        if (str != null) {
            str = str.toLowerCase(Locale.ENGLISH);
        }
        int i = 0;
        while (true) {
            MailcapFile[] mailcapFileArr = this.DB;
            if (i < mailcapFileArr.length) {
                if (mailcapFileArr[i] != null && (nativeCommands = mailcapFileArr[i].getNativeCommands(str)) != null) {
                    for (int i2 = 0; i2 < nativeCommands.length; i2++) {
                        if (!arrayList.contains(nativeCommands[i2])) {
                            arrayList.add(nativeCommands[i2]);
                        }
                    }
                }
                i++;
            }
        }
        return (String[]) arrayList.toArray(new String[arrayList.size()]);
    }

    @Override // javax.activation.CommandMap
    public synchronized CommandInfo[] getPreferredCommands(String str) {
        ArrayList arrayList;
        Map mailcapFallbackList;
        Map mailcapList;
        arrayList = new ArrayList();
        if (str != null) {
            str = str.toLowerCase(Locale.ENGLISH);
        }
        int i = 0;
        int i2 = 0;
        while (true) {
            MailcapFile[] mailcapFileArr = this.DB;
            if (i2 >= mailcapFileArr.length) {
                break;
            }
            if (mailcapFileArr[i2] != null && (mailcapList = mailcapFileArr[i2].getMailcapList(str)) != null) {
                appendPrefCmdsToList(mailcapList, arrayList);
            }
            i2++;
        }
        while (true) {
            MailcapFile[] mailcapFileArr2 = this.DB;
            if (i >= mailcapFileArr2.length) {
            } else {
                if (mailcapFileArr2[i] != null && (mailcapFallbackList = mailcapFileArr2[i].getMailcapFallbackList(str)) != null) {
                    appendPrefCmdsToList(mailcapFallbackList, arrayList);
                }
                i++;
            }
        }
        return (CommandInfo[]) arrayList.toArray(new CommandInfo[arrayList.size()]);
    }
}
