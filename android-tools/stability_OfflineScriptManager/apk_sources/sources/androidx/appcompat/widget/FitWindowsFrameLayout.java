package androidx.appcompat.widget;

import android.content.Context;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.widget.FrameLayout;
import androidx.appcompat.widget.b0;
/* loaded from: classes.dex */
public class FitWindowsFrameLayout extends FrameLayout implements b0 {

    /* renamed from: b  reason: collision with root package name */
    private b0.a f614b;

    public FitWindowsFrameLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    @Override // android.view.View
    protected boolean fitSystemWindows(Rect rect) {
        b0.a aVar = this.f614b;
        if (aVar != null) {
            aVar.a(rect);
        }
        return super.fitSystemWindows(rect);
    }

    @Override // androidx.appcompat.widget.b0
    public void setOnFitSystemWindowsListener(b0.a aVar) {
        this.f614b = aVar;
    }
}
