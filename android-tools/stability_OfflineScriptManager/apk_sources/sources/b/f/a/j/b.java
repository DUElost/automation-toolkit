package b.f.a.j;

import java.io.File;
import java.util.Comparator;
/* loaded from: classes.dex */
public class b implements Comparator<File> {
    @Override // java.util.Comparator
    /* renamed from: a */
    public int compare(File file, File file2) {
        if (file == file2) {
            return 0;
        }
        if (file.isDirectory() && file2.isFile()) {
            return -1;
        }
        if (file.isFile() && file2.isDirectory()) {
            return 1;
        }
        return file.getName().compareToIgnoreCase(file2.getName());
    }
}
