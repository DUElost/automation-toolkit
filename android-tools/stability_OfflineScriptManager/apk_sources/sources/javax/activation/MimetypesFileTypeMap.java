package javax.activation;

import com.sun.activation.registries.LogSupport;
import com.sun.activation.registries.MimeTypeFile;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Vector;
/* loaded from: classes.dex */
public class MimetypesFileTypeMap extends FileTypeMap {
    private static final int PROG = 0;
    private static MimeTypeFile defDB = null;
    private static String defaultType = "application/octet-stream";
    private MimeTypeFile[] DB;

    public MimetypesFileTypeMap() {
        Vector vector = new Vector(5);
        vector.addElement(null);
        LogSupport.log("MimetypesFileTypeMap: load HOME");
        try {
            String property = System.getProperty("user.home");
            if (property != null) {
                MimeTypeFile loadFile = loadFile(String.valueOf(property) + File.separator + ".mime.types");
                if (loadFile != null) {
                    vector.addElement(loadFile);
                }
            }
        } catch (SecurityException unused) {
        }
        LogSupport.log("MimetypesFileTypeMap: load SYS");
        try {
            StringBuilder sb = new StringBuilder(String.valueOf(System.getProperty("java.home")));
            String str = File.separator;
            sb.append(str);
            sb.append("lib");
            sb.append(str);
            sb.append("mime.types");
            MimeTypeFile loadFile2 = loadFile(sb.toString());
            if (loadFile2 != null) {
                vector.addElement(loadFile2);
            }
        } catch (SecurityException unused2) {
        }
        LogSupport.log("MimetypesFileTypeMap: load JAR");
        loadAllResources(vector, "mime.types");
        LogSupport.log("MimetypesFileTypeMap: load DEF");
        synchronized (MimetypesFileTypeMap.class) {
            if (defDB == null) {
                defDB = loadResource("/mimetypes.default");
            }
        }
        MimeTypeFile mimeTypeFile = defDB;
        if (mimeTypeFile != null) {
            vector.addElement(mimeTypeFile);
        }
        MimeTypeFile[] mimeTypeFileArr = new MimeTypeFile[vector.size()];
        this.DB = mimeTypeFileArr;
        vector.copyInto(mimeTypeFileArr);
    }

    public MimetypesFileTypeMap(InputStream inputStream) {
        this();
        try {
            this.DB[0] = new MimeTypeFile(inputStream);
        } catch (IOException unused) {
        }
    }

    public MimetypesFileTypeMap(String str) {
        this();
        this.DB[0] = new MimeTypeFile(str);
    }

    /* JADX WARN: Code restructure failed: missing block: B:52:0x00ca, code lost:
        if (r5 != null) goto L55;
     */
    /* JADX WARN: Removed duplicated region for block: B:71:0x00fb  */
    /* JADX WARN: Removed duplicated region for block: B:96:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void loadAllResources(java.util.Vector r10, java.lang.String r11) {
        /*
            Method dump skipped, instructions count: 280
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: javax.activation.MimetypesFileTypeMap.loadAllResources(java.util.Vector, java.lang.String):void");
    }

    private MimeTypeFile loadFile(String str) {
        try {
            return new MimeTypeFile(str);
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
    private com.sun.activation.registries.MimeTypeFile loadResource(java.lang.String r7) {
        /*
            r6 = this;
            java.lang.String r0 = "MimetypesFileTypeMap: can't load "
            r1 = 0
            java.lang.Class r2 = r6.getClass()     // Catch: java.lang.Throwable -> L50 java.lang.SecurityException -> L52 java.io.IOException -> L6c
            java.io.InputStream r2 = javax.activation.SecuritySupport.getResourceAsStream(r2, r7)     // Catch: java.lang.Throwable -> L50 java.lang.SecurityException -> L52 java.io.IOException -> L6c
            if (r2 == 0) goto L2f
            com.sun.activation.registries.MimeTypeFile r3 = new com.sun.activation.registries.MimeTypeFile     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            r3.<init>(r2)     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            boolean r4 = com.sun.activation.registries.LogSupport.isLoggable()     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            if (r4 == 0) goto L29
            java.lang.StringBuilder r4 = new java.lang.StringBuilder     // Catch: java.lang.SecurityException -> L4c java.io.IOException -> L4e java.lang.Throwable -> L87
            java.lang.String r5 = "MimetypesFileTypeMap: successfully loaded mime types file: "
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
            java.lang.String r4 = "MimetypesFileTypeMap: not loading mime types file: "
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
        throw new UnsupportedOperationException("Method not decompiled: javax.activation.MimetypesFileTypeMap.loadResource(java.lang.String):com.sun.activation.registries.MimeTypeFile");
    }

    public synchronized void addMimeTypes(String str) {
        MimeTypeFile[] mimeTypeFileArr = this.DB;
        if (mimeTypeFileArr[0] == null) {
            mimeTypeFileArr[0] = new MimeTypeFile();
        }
        this.DB[0].appendToRegistry(str);
    }

    @Override // javax.activation.FileTypeMap
    public String getContentType(File file) {
        return getContentType(file.getName());
    }

    @Override // javax.activation.FileTypeMap
    public synchronized String getContentType(String str) {
        String mIMETypeString;
        int lastIndexOf = str.lastIndexOf(".");
        if (lastIndexOf < 0) {
            return defaultType;
        }
        String substring = str.substring(lastIndexOf + 1);
        if (substring.length() == 0) {
            return defaultType;
        }
        int i = 0;
        while (true) {
            MimeTypeFile[] mimeTypeFileArr = this.DB;
            if (i >= mimeTypeFileArr.length) {
                return defaultType;
            }
            if (mimeTypeFileArr[i] != null && (mIMETypeString = mimeTypeFileArr[i].getMIMETypeString(substring)) != null) {
                return mIMETypeString;
            }
            i++;
        }
    }
}
