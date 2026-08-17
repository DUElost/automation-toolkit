package com.google.android.material.internal;

import a.f.l.r;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.accessibility.AccessibilityEvent;
import android.widget.Checkable;
import android.widget.ImageButton;
import androidx.appcompat.widget.k;
/* loaded from: classes.dex */
public class CheckableImageButton extends k implements Checkable {
    private static final int[] e = {16842912};

    /* renamed from: d  reason: collision with root package name */
    private boolean f2348d;

    /* loaded from: classes.dex */
    class a extends a.f.l.a {
        a() {
        }

        @Override // a.f.l.a
        public void d(View view, AccessibilityEvent accessibilityEvent) {
            super.d(view, accessibilityEvent);
            accessibilityEvent.setChecked(CheckableImageButton.this.isChecked());
        }

        @Override // a.f.l.a
        public void e(View view, a.f.l.a0.c cVar) {
            super.e(view, cVar);
            cVar.u(true);
            cVar.v(CheckableImageButton.this.isChecked());
        }
    }

    public CheckableImageButton(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.imageButtonStyle);
    }

    public CheckableImageButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        r.O(this, new a());
    }

    @Override // android.widget.Checkable
    public boolean isChecked() {
        return this.f2348d;
    }

    @Override // android.widget.ImageView, android.view.View
    public int[] onCreateDrawableState(int i) {
        if (this.f2348d) {
            int[] iArr = e;
            return ImageButton.mergeDrawableStates(super.onCreateDrawableState(i + iArr.length), iArr);
        }
        return super.onCreateDrawableState(i);
    }

    @Override // android.widget.Checkable
    public void setChecked(boolean z) {
        if (this.f2348d != z) {
            this.f2348d = z;
            refreshDrawableState();
            sendAccessibilityEvent(2048);
        }
    }

    @Override // android.widget.Checkable
    public void toggle() {
        setChecked(!this.f2348d);
    }
}
