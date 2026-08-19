package c.c.a.h;

import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class f {
    public f(c.c.a.g.a aVar, c.c.a.g.a aVar2) {
    }

    protected String a() {
        return BuildConfig.FLAVOR;
    }

    public boolean equals(Object obj) {
        if (obj instanceof f) {
            return toString().equals(obj.toString());
        }
        return false;
    }

    public String toString() {
        return "<" + getClass().getName() + "(" + a() + ")>";
    }
}
