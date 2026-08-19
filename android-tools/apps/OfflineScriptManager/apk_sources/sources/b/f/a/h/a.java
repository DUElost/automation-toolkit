package b.f.a.h;

import java.io.File;
import java.io.FileFilter;
/* loaded from: classes.dex */
public class a implements FileFilter {

    /* renamed from: a  reason: collision with root package name */
    private String[] f1622a;

    public a(String[] strArr) {
        this.f1622a = strArr;
    }

    @Override // java.io.FileFilter
    public boolean accept(File file) {
        String[] strArr;
        if (file.isDirectory() || (strArr = this.f1622a) == null || strArr.length <= 0) {
            return true;
        }
        for (int i = 0; i < this.f1622a.length; i++) {
            if (file.getName().endsWith(this.f1622a[i].toLowerCase()) || file.getName().endsWith(this.f1622a[i].toUpperCase())) {
                return true;
            }
        }
        return false;
    }
}
