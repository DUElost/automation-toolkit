package androidx.appcompat.view.menu;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.widget.q0;
/* loaded from: classes.dex */
public final class ExpandedMenuView extends ListView implements h.b, p, AdapterView.OnItemClickListener {

    /* renamed from: d  reason: collision with root package name */
    private static final int[] f521d = {16842964, 16843049};

    /* renamed from: b  reason: collision with root package name */
    private h f522b;

    /* renamed from: c  reason: collision with root package name */
    private int f523c;

    public ExpandedMenuView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 16842868);
    }

    public ExpandedMenuView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet);
        setOnItemClickListener(this);
        q0 t = q0.t(context, attributeSet, f521d, i, 0);
        if (t.q(0)) {
            setBackgroundDrawable(t.f(0));
        }
        if (t.q(1)) {
            setDivider(t.f(1));
        }
        t.u();
    }

    @Override // androidx.appcompat.view.menu.h.b
    public boolean a(j jVar) {
        return this.f522b.L(jVar, 0);
    }

    @Override // androidx.appcompat.view.menu.p
    public void b(h hVar) {
        this.f522b = hVar;
    }

    public int getWindowAnimations() {
        return this.f523c;
    }

    @Override // android.widget.ListView, android.widget.AbsListView, android.widget.AdapterView, android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        setChildrenDrawingCacheEnabled(false);
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView adapterView, View view, int i, long j) {
        a((j) getAdapter().getItem(i));
    }
}
