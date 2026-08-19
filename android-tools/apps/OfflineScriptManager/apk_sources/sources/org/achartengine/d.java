package org.achartengine;

import android.graphics.RectF;
import android.view.MotionEvent;
import org.achartengine.f.i;
/* loaded from: classes.dex */
public class d implements c {

    /* renamed from: a  reason: collision with root package name */
    private org.achartengine.h.b f2770a;

    /* renamed from: b  reason: collision with root package name */
    private float f2771b;

    /* renamed from: c  reason: collision with root package name */
    private float f2772c;

    /* renamed from: d  reason: collision with root package name */
    private float f2773d;
    private float e;
    private org.achartengine.i.c f;
    private org.achartengine.i.e g;
    private b h;

    public d(b bVar, org.achartengine.f.a aVar) {
        new RectF();
        this.h = bVar;
        bVar.getZoomRectangle();
        this.f2770a = aVar instanceof i ? ((i) aVar).B() : ((org.achartengine.f.e) aVar).r();
        if (this.f2770a.A()) {
            this.f = new org.achartengine.i.c(aVar);
        }
        if (this.f2770a.K()) {
            this.g = new org.achartengine.i.e(aVar, true, 1.0f);
        }
    }

    private void b(float f, int i) {
        float min = Math.min(Math.max(f, 0.9f), 1.1f);
        double d2 = min;
        if (d2 <= 0.9d || d2 >= 1.1d) {
            return;
        }
        this.g.h(min);
        this.g.e(i);
    }

    @Override // org.achartengine.c
    public boolean a(MotionEvent motionEvent) {
        float f;
        int action = motionEvent.getAction();
        if (this.f2770a == null || action != 2) {
            if (action == 0) {
                this.f2771b = motionEvent.getX(0);
                f = motionEvent.getY(0);
            } else if (action == 1 || action == 6) {
                this.f2771b = 0.0f;
                this.f2772c = 0.0f;
                this.f2773d = 0.0f;
                this.e = 0.0f;
                if (action == 6) {
                    f = -1.0f;
                    this.f2771b = -1.0f;
                }
            }
            this.f2772c = f;
        } else if (this.f2771b >= 0.0f || this.f2772c >= 0.0f) {
            float x = motionEvent.getX(0);
            float y = motionEvent.getY(0);
            if (motionEvent.getPointerCount() > 1 && ((this.f2773d >= 0.0f || this.e >= 0.0f) && this.f2770a.K())) {
                float x2 = motionEvent.getX(1);
                float y2 = motionEvent.getY(1);
                float abs = Math.abs(x - x2);
                float abs2 = Math.abs(y - y2);
                float abs3 = Math.abs(this.f2771b - this.f2773d);
                float abs4 = Math.abs(this.f2772c - this.e);
                float abs5 = Math.abs(y - this.f2772c) / Math.abs(x - this.f2771b);
                float abs6 = Math.abs(y2 - this.e) / Math.abs(x2 - this.f2773d);
                double d2 = abs5;
                if (d2 <= 0.25d && abs6 <= 0.25d) {
                    b(abs / abs3, 1);
                } else if (d2 < 3.73d || abs6 < 3.73d) {
                    b(Math.abs(x - this.f2771b) >= Math.abs(y - this.f2772c) ? abs / abs3 : abs2 / abs4, 0);
                } else {
                    b(abs2 / abs4, 2);
                }
                this.f2773d = x2;
                this.e = y2;
            } else if (this.f2770a.A()) {
                this.f.e(this.f2771b, this.f2772c, x, y);
                this.f2773d = 0.0f;
                this.e = 0.0f;
            }
            this.f2771b = x;
            this.f2772c = y;
            this.h.a();
            return true;
        }
        return !this.f2770a.w();
    }
}
