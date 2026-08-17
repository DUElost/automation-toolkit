package a.m;

import android.os.IBinder;
/* loaded from: classes.dex */
class j0 implements l0 {

    /* renamed from: a  reason: collision with root package name */
    private final IBinder f288a;

    /* JADX INFO: Access modifiers changed from: package-private */
    public j0(IBinder iBinder) {
        this.f288a = iBinder;
    }

    public boolean equals(Object obj) {
        return (obj instanceof j0) && ((j0) obj).f288a.equals(this.f288a);
    }

    public int hashCode() {
        return this.f288a.hashCode();
    }
}
