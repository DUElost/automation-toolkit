package org.achartengine;

import android.graphics.RectF;
import android.view.MotionEvent;
import org.achartengine.f.i;
/* loaded from: classes.dex */
public class e implements c {

    /* renamed from: a  reason: collision with root package name */
    private org.achartengine.h.b f2774a;

    /* renamed from: b  reason: collision with root package name */
    private float f2775b;

    /* renamed from: c  reason: collision with root package name */
    private float f2776c;

    /* renamed from: d  reason: collision with root package name */
    private RectF f2777d;
    private org.achartengine.i.c e;
    private b f;

    public e(b bVar, org.achartengine.f.a aVar) {
        this.f2777d = new RectF();
        this.f = bVar;
        this.f2777d = bVar.getZoomRectangle();
        this.f2774a = aVar instanceof i ? ((i) aVar).B() : ((org.achartengine.f.e) aVar).r();
        if (this.f2774a.A()) {
            this.e = new org.achartengine.i.c(aVar);
        }
    }

    @Override // org.achartengine.c
    public boolean a(MotionEvent motionEvent) {
        int action = motionEvent.getAction();
        if (this.f2774a == null || action != 2) {
            if (action == 0) {
                this.f2775b = motionEvent.getX();
                this.f2776c = motionEvent.getY();
                org.achartengine.h.b bVar = this.f2774a;
                if (bVar != null && bVar.K() && this.f2777d.contains(this.f2775b, this.f2776c)) {
                    float f = this.f2775b;
                    RectF rectF = this.f2777d;
                    if (f < rectF.left + (rectF.width() / 3.0f)) {
                        this.f.b();
                    } else {
                        float f2 = this.f2775b;
                        RectF rectF2 = this.f2777d;
                        if (f2 < rectF2.left + ((rectF2.width() * 2.0f) / 3.0f)) {
                            this.f.c();
                        } else {
                            this.f.d();
                        }
                    }
                    return true;
                }
            } else if (action == 1) {
                this.f2775b = 0.0f;
                this.f2776c = 0.0f;
            }
        } else if (this.f2775b >= 0.0f || this.f2776c >= 0.0f) {
            float x = motionEvent.getX();
            float y = motionEvent.getY();
            if (this.f2774a.A()) {
                this.e.e(this.f2775b, this.f2776c, x, y);
            }
            this.f2775b = x;
            this.f2776c = y;
            this.f.a();
            return true;
        }
        return !this.f2774a.w();
    }
}
