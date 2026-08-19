package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.ActionMode;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Button;
/* loaded from: classes.dex */
public class e extends Button implements a.f.l.q, androidx.core.widget.b {

    /* renamed from: b  reason: collision with root package name */
    private final d f678b;

    /* renamed from: c  reason: collision with root package name */
    private final u f679c;

    public e(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.buttonStyle);
    }

    public e(Context context, AttributeSet attributeSet, int i) {
        super(n0.b(context), attributeSet, i);
        d dVar = new d(this);
        this.f678b = dVar;
        dVar.e(attributeSet, i);
        u uVar = new u(this);
        this.f679c = uVar;
        uVar.k(attributeSet, i);
        uVar.b();
    }

    @Override // android.widget.TextView, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        d dVar = this.f678b;
        if (dVar != null) {
            dVar.b();
        }
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.b();
        }
    }

    @Override // android.widget.TextView
    public int getAutoSizeMaxTextSize() {
        if (androidx.core.widget.b.f905a) {
            return super.getAutoSizeMaxTextSize();
        }
        u uVar = this.f679c;
        if (uVar != null) {
            return uVar.e();
        }
        return -1;
    }

    @Override // android.widget.TextView
    public int getAutoSizeMinTextSize() {
        if (androidx.core.widget.b.f905a) {
            return super.getAutoSizeMinTextSize();
        }
        u uVar = this.f679c;
        if (uVar != null) {
            return uVar.f();
        }
        return -1;
    }

    @Override // android.widget.TextView
    public int getAutoSizeStepGranularity() {
        if (androidx.core.widget.b.f905a) {
            return super.getAutoSizeStepGranularity();
        }
        u uVar = this.f679c;
        if (uVar != null) {
            return uVar.g();
        }
        return -1;
    }

    @Override // android.widget.TextView
    public int[] getAutoSizeTextAvailableSizes() {
        if (androidx.core.widget.b.f905a) {
            return super.getAutoSizeTextAvailableSizes();
        }
        u uVar = this.f679c;
        return uVar != null ? uVar.h() : new int[0];
    }

    @Override // android.widget.TextView
    public int getAutoSizeTextType() {
        if (androidx.core.widget.b.f905a) {
            return super.getAutoSizeTextType() == 1 ? 1 : 0;
        }
        u uVar = this.f679c;
        if (uVar != null) {
            return uVar.i();
        }
        return 0;
    }

    @Override // a.f.l.q
    public ColorStateList getSupportBackgroundTintList() {
        d dVar = this.f678b;
        if (dVar != null) {
            return dVar.c();
        }
        return null;
    }

    @Override // a.f.l.q
    public PorterDuff.Mode getSupportBackgroundTintMode() {
        d dVar = this.f678b;
        if (dVar != null) {
            return dVar.d();
        }
        return null;
    }

    @Override // android.view.View
    public void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        super.onInitializeAccessibilityEvent(accessibilityEvent);
        accessibilityEvent.setClassName(Button.class.getName());
    }

    @Override // android.view.View
    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo) {
        super.onInitializeAccessibilityNodeInfo(accessibilityNodeInfo);
        accessibilityNodeInfo.setClassName(Button.class.getName());
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.widget.TextView, android.view.View
    public void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.m(z, i, i2, i3, i4);
        }
    }

    @Override // android.widget.TextView
    protected void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        super.onTextChanged(charSequence, i, i2, i3);
        u uVar = this.f679c;
        if (uVar == null || androidx.core.widget.b.f905a || !uVar.j()) {
            return;
        }
        this.f679c.c();
    }

    @Override // android.widget.TextView
    public void setAutoSizeTextTypeUniformWithConfiguration(int i, int i2, int i3, int i4) {
        if (androidx.core.widget.b.f905a) {
            super.setAutoSizeTextTypeUniformWithConfiguration(i, i2, i3, i4);
            return;
        }
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.p(i, i2, i3, i4);
        }
    }

    @Override // android.widget.TextView
    public void setAutoSizeTextTypeUniformWithPresetSizes(int[] iArr, int i) {
        if (androidx.core.widget.b.f905a) {
            super.setAutoSizeTextTypeUniformWithPresetSizes(iArr, i);
            return;
        }
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.q(iArr, i);
        }
    }

    @Override // android.widget.TextView
    public void setAutoSizeTextTypeWithDefaults(int i) {
        if (androidx.core.widget.b.f905a) {
            super.setAutoSizeTextTypeWithDefaults(i);
            return;
        }
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.r(i);
        }
    }

    @Override // android.view.View
    public void setBackgroundDrawable(Drawable drawable) {
        super.setBackgroundDrawable(drawable);
        d dVar = this.f678b;
        if (dVar != null) {
            dVar.f(drawable);
        }
    }

    @Override // android.view.View
    public void setBackgroundResource(int i) {
        super.setBackgroundResource(i);
        d dVar = this.f678b;
        if (dVar != null) {
            dVar.g(i);
        }
    }

    @Override // android.widget.TextView
    public void setCustomSelectionActionModeCallback(ActionMode.Callback callback) {
        super.setCustomSelectionActionModeCallback(androidx.core.widget.i.p(this, callback));
    }

    public void setSupportAllCaps(boolean z) {
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.o(z);
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintList(ColorStateList colorStateList) {
        d dVar = this.f678b;
        if (dVar != null) {
            dVar.i(colorStateList);
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintMode(PorterDuff.Mode mode) {
        d dVar = this.f678b;
        if (dVar != null) {
            dVar.j(mode);
        }
    }

    @Override // android.widget.TextView
    public void setTextAppearance(Context context, int i) {
        super.setTextAppearance(context, i);
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.n(context, i);
        }
    }

    @Override // android.widget.TextView
    public void setTextSize(int i, float f) {
        if (androidx.core.widget.b.f905a) {
            super.setTextSize(i, f);
            return;
        }
        u uVar = this.f679c;
        if (uVar != null) {
            uVar.s(i, f);
        }
    }
}
