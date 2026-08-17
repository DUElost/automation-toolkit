package com.google.android.material.internal;

import android.graphics.Outline;
/* loaded from: classes.dex */
public class b extends a {
    @Override // android.graphics.drawable.Drawable
    public void getOutline(Outline outline) {
        copyBounds(this.f2352b);
        outline.setOval(this.f2352b);
    }
}
