package com.google.android.material.internal;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.ImageButton;
/* loaded from: classes.dex */
public class h extends ImageButton {

    /* renamed from: b  reason: collision with root package name */
    private int f2367b;

    public h(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public h(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f2367b = getVisibility();
    }

    public final void b(int i, boolean z) {
        super.setVisibility(i);
        if (z) {
            this.f2367b = i;
        }
    }

    public final int getUserSetVisibility() {
        return this.f2367b;
    }

    @Override // android.widget.ImageView, android.view.View
    public void setVisibility(int i) {
        b(i, true);
    }
}
