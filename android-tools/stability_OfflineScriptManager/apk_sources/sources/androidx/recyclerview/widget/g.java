package androidx.recyclerview.widget;

import android.view.View;
import androidx.recyclerview.widget.RecyclerView;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class g {

    /* renamed from: b  reason: collision with root package name */
    int f1256b;

    /* renamed from: c  reason: collision with root package name */
    int f1257c;

    /* renamed from: d  reason: collision with root package name */
    int f1258d;
    int e;
    boolean h;
    boolean i;

    /* renamed from: a  reason: collision with root package name */
    boolean f1255a = true;
    int f = 0;
    int g = 0;

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean a(RecyclerView.z zVar) {
        int i = this.f1257c;
        return i >= 0 && i < zVar.b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View b(RecyclerView.v vVar) {
        View o = vVar.o(this.f1257c);
        this.f1257c += this.f1258d;
        return o;
    }

    public String toString() {
        return "LayoutState{mAvailable=" + this.f1256b + ", mCurrentPosition=" + this.f1257c + ", mItemDirection=" + this.f1258d + ", mLayoutDirection=" + this.e + ", mStartLine=" + this.f + ", mEndLine=" + this.g + '}';
    }
}
