package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.ActionMode;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.AutoCompleteTextView;
/* loaded from: classes.dex */
public class c extends AutoCompleteTextView implements a.f.l.q {

    /* renamed from: d  reason: collision with root package name */
    private static final int[] f661d = {16843126};

    /* renamed from: b  reason: collision with root package name */
    private final d f662b;

    /* renamed from: c  reason: collision with root package name */
    private final u f663c;

    public c(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.autoCompleteTextViewStyle);
    }

    public c(Context context, AttributeSet attributeSet, int i) {
        super(n0.b(context), attributeSet, i);
        q0 t = q0.t(getContext(), attributeSet, f661d, i, 0);
        if (t.q(0)) {
            setDropDownBackgroundDrawable(t.f(0));
        }
        t.u();
        d dVar = new d(this);
        this.f662b = dVar;
        dVar.e(attributeSet, i);
        u uVar = new u(this);
        this.f663c = uVar;
        uVar.k(attributeSet, i);
        uVar.b();
    }

    @Override // android.widget.TextView, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        d dVar = this.f662b;
        if (dVar != null) {
            dVar.b();
        }
        u uVar = this.f663c;
        if (uVar != null) {
            uVar.b();
        }
    }

    @Override // a.f.l.q
    public ColorStateList getSupportBackgroundTintList() {
        d dVar = this.f662b;
        if (dVar != null) {
            return dVar.c();
        }
        return null;
    }

    @Override // a.f.l.q
    public PorterDuff.Mode getSupportBackgroundTintMode() {
        d dVar = this.f662b;
        if (dVar != null) {
            return dVar.d();
        }
        return null;
    }

    @Override // android.widget.TextView, android.view.View
    public InputConnection onCreateInputConnection(EditorInfo editorInfo) {
        InputConnection onCreateInputConnection = super.onCreateInputConnection(editorInfo);
        j.a(onCreateInputConnection, editorInfo, this);
        return onCreateInputConnection;
    }

    @Override // android.view.View
    public void setBackgroundDrawable(Drawable drawable) {
        super.setBackgroundDrawable(drawable);
        d dVar = this.f662b;
        if (dVar != null) {
            dVar.f(drawable);
        }
    }

    @Override // android.view.View
    public void setBackgroundResource(int i) {
        super.setBackgroundResource(i);
        d dVar = this.f662b;
        if (dVar != null) {
            dVar.g(i);
        }
    }

    @Override // android.widget.TextView
    public void setCustomSelectionActionModeCallback(ActionMode.Callback callback) {
        super.setCustomSelectionActionModeCallback(androidx.core.widget.i.p(this, callback));
    }

    @Override // android.widget.AutoCompleteTextView
    public void setDropDownBackgroundResource(int i) {
        setDropDownBackgroundDrawable(a.a.k.a.a.d(getContext(), i));
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintList(ColorStateList colorStateList) {
        d dVar = this.f662b;
        if (dVar != null) {
            dVar.i(colorStateList);
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintMode(PorterDuff.Mode mode) {
        d dVar = this.f662b;
        if (dVar != null) {
            dVar.j(mode);
        }
    }

    @Override // android.widget.TextView
    public void setTextAppearance(Context context, int i) {
        super.setTextAppearance(context, i);
        u uVar = this.f663c;
        if (uVar != null) {
            uVar.n(context, i);
        }
    }
}
