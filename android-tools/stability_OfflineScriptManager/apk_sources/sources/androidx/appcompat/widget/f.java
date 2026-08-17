package androidx.appcompat.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.ActionMode;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.CheckedTextView;
/* loaded from: classes.dex */
public class f extends CheckedTextView {

    /* renamed from: c  reason: collision with root package name */
    private static final int[] f689c = {16843016};

    /* renamed from: b  reason: collision with root package name */
    private final u f690b;

    public f(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 16843720);
    }

    public f(Context context, AttributeSet attributeSet, int i) {
        super(n0.b(context), attributeSet, i);
        u uVar = new u(this);
        this.f690b = uVar;
        uVar.k(attributeSet, i);
        uVar.b();
        q0 t = q0.t(getContext(), attributeSet, f689c, i, 0);
        setCheckMarkDrawable(t.f(0));
        t.u();
    }

    @Override // android.widget.CheckedTextView, android.widget.TextView, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        u uVar = this.f690b;
        if (uVar != null) {
            uVar.b();
        }
    }

    @Override // android.widget.TextView, android.view.View
    public InputConnection onCreateInputConnection(EditorInfo editorInfo) {
        InputConnection onCreateInputConnection = super.onCreateInputConnection(editorInfo);
        j.a(onCreateInputConnection, editorInfo, this);
        return onCreateInputConnection;
    }

    @Override // android.widget.CheckedTextView
    public void setCheckMarkDrawable(int i) {
        setCheckMarkDrawable(a.a.k.a.a.d(getContext(), i));
    }

    @Override // android.widget.TextView
    public void setCustomSelectionActionModeCallback(ActionMode.Callback callback) {
        super.setCustomSelectionActionModeCallback(androidx.core.widget.i.p(this, callback));
    }

    @Override // android.widget.TextView
    public void setTextAppearance(Context context, int i) {
        super.setTextAppearance(context, i);
        u uVar = this.f690b;
        if (uVar != null) {
            uVar.n(context, i);
        }
    }
}
