package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
/* loaded from: classes.dex */
public abstract class e extends a {

    /* renamed from: b  reason: collision with root package name */
    protected org.achartengine.h.b f2784b;

    /* renamed from: c  reason: collision with root package name */
    protected int f2785c;

    /* renamed from: d  reason: collision with root package name */
    protected int f2786d;

    @Override // org.achartengine.f.a
    public void e(Canvas canvas, org.achartengine.h.c cVar, float f, float f2, int i, Paint paint) {
        canvas.drawRect(f, f2 - 5.0f, f + 10.0f, f2 + 5.0f, paint);
    }

    @Override // org.achartengine.f.a
    public int k(int i) {
        return 10;
    }

    public int p() {
        return this.f2785c;
    }

    public int q() {
        return this.f2786d;
    }

    public org.achartengine.h.b r() {
        return this.f2784b;
    }

    public void s(int i) {
        this.f2785c = i;
    }

    public void t(int i) {
        this.f2786d = i;
    }
}
