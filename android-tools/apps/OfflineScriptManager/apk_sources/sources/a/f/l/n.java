package a.f.l;

import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public class n {

    /* renamed from: a  reason: collision with root package name */
    private int f192a;

    public n(ViewGroup viewGroup) {
    }

    public int a() {
        return this.f192a;
    }

    public void b(View view, View view2, int i) {
        c(view, view2, i, 0);
    }

    public void c(View view, View view2, int i, int i2) {
        this.f192a = i;
    }

    public void d(View view, int i) {
        this.f192a = 0;
    }
}
