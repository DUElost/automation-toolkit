package b.f.a.j;

import java.io.File;
import java.io.FileFilter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
/* loaded from: classes.dex */
public class c {
    public static List<File> a(String str, FileFilter fileFilter) {
        File[] listFiles = new File(str).listFiles(fileFilter);
        if (listFiles == null) {
            return new ArrayList();
        }
        List<File> asList = Arrays.asList(listFiles);
        Collections.sort(asList, new b());
        return asList;
    }

    public static String b(long j) {
        double d2;
        if (j <= 0) {
            return "0";
        }
        int log10 = (int) (Math.log10(j) / Math.log10(1024.0d));
        return new DecimalFormat("#").format(d2 / Math.pow(1024.0d, log10)) + " " + new String[]{"B", "KB", "MB", "GB", "TB"}[log10];
    }
}
