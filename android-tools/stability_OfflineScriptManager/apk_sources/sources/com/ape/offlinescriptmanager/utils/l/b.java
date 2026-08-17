package com.ape.offlinescriptmanager.utils.l;

import android.util.Log;
import java.nio.charset.Charset;
import java.util.ArrayList;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class b implements a {

    /* renamed from: a  reason: collision with root package name */
    private boolean f2085a = true;

    /* renamed from: b  reason: collision with root package name */
    private String f2086b = null;

    /* renamed from: c  reason: collision with root package name */
    private final ArrayList<String> f2087c = new ArrayList<>();

    @Override // com.ape.offlinescriptmanager.utils.l.a
    public final void b(byte[] bArr, int i, int i2) {
        if (a()) {
            return;
        }
        String str = new String(bArr, i, i2, Charset.forName("UTF-8"));
        Log.i("TAG", "addOutput: " + str);
        String replaceAll = str.replaceAll("[^a-zA-Z0-9一-\u9fff\\s\\p{Punct}\\n]", BuildConfig.FLAVOR);
        Log.i("TAG", "after: " + replaceAll);
        if (this.f2086b != null) {
            replaceAll = this.f2086b + replaceAll;
            this.f2086b = null;
        }
        this.f2087c.clear();
        int i3 = 0;
        while (true) {
            int indexOf = replaceAll.indexOf("\r\n", i3);
            if (indexOf == -1) {
                break;
            }
            String substring = replaceAll.substring(i3, indexOf);
            if (this.f2085a) {
                substring = substring.trim();
            }
            this.f2087c.add(substring);
            i3 = indexOf + 2;
        }
        this.f2086b = replaceAll.substring(i3);
        if (this.f2087c.isEmpty()) {
            return;
        }
        ArrayList<String> arrayList = this.f2087c;
        d((String[]) arrayList.toArray(new String[arrayList.size()]));
    }

    public void c() {
    }

    public abstract void d(String[] strArr);

    @Override // com.ape.offlinescriptmanager.utils.l.a
    public final void flush() {
        String str = this.f2086b;
        if (str != null) {
            d(new String[]{str});
        }
        c();
    }
}
