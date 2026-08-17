package a.m;

import android.view.View;
import android.view.WindowId;
/* loaded from: classes.dex */
class k0 implements l0 {

    /* renamed from: a  reason: collision with root package name */
    private final WindowId f290a;

    /* JADX INFO: Access modifiers changed from: package-private */
    public k0(View view) {
        this.f290a = view.getWindowId();
    }

    public boolean equals(Object obj) {
        return (obj instanceof k0) && ((k0) obj).f290a.equals(this.f290a);
    }

    public int hashCode() {
        return this.f290a.hashCode();
    }
}
