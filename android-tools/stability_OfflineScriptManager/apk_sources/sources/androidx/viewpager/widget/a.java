package androidx.viewpager.widget;

import android.database.DataSetObservable;
import android.database.DataSetObserver;
import android.os.Parcelable;
import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public abstract class a {

    /* renamed from: a  reason: collision with root package name */
    private final DataSetObservable f1301a = new DataSetObservable();

    public abstract void a(ViewGroup viewGroup, int i, Object obj);

    public abstract void b(ViewGroup viewGroup);

    public abstract int c();

    public int d(Object obj) {
        return -1;
    }

    public CharSequence e(int i) {
        return null;
    }

    public float f(int i) {
        return 1.0f;
    }

    public abstract Object g(ViewGroup viewGroup, int i);

    public abstract boolean h(View view, Object obj);

    public void i(DataSetObserver dataSetObserver) {
        this.f1301a.registerObserver(dataSetObserver);
    }

    public abstract void j(Parcelable parcelable, ClassLoader classLoader);

    public abstract Parcelable k();

    public abstract void l(ViewGroup viewGroup, int i, Object obj);

    /* JADX INFO: Access modifiers changed from: package-private */
    public void m(DataSetObserver dataSetObserver) {
        synchronized (this) {
        }
    }

    public abstract void n(ViewGroup viewGroup);

    public void o(DataSetObserver dataSetObserver) {
        this.f1301a.unregisterObserver(dataSetObserver);
    }
}
