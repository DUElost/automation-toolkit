package androidx.cardview.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import androidx.cardview.widget.g;
/* loaded from: classes.dex */
class c implements e {

    /* renamed from: a  reason: collision with root package name */
    final RectF f803a = new RectF();

    /* loaded from: classes.dex */
    class a implements g.a {
        a() {
        }

        @Override // androidx.cardview.widget.g.a
        public void a(Canvas canvas, RectF rectF, float f, Paint paint) {
            float f2 = 2.0f * f;
            float width = (rectF.width() - f2) - 1.0f;
            float height = (rectF.height() - f2) - 1.0f;
            if (f >= 1.0f) {
                float f3 = f + 0.5f;
                float f4 = -f3;
                c.this.f803a.set(f4, f4, f3, f3);
                int save = canvas.save();
                canvas.translate(rectF.left + f3, rectF.top + f3);
                canvas.drawArc(c.this.f803a, 180.0f, 90.0f, true, paint);
                canvas.translate(width, 0.0f);
                canvas.rotate(90.0f);
                canvas.drawArc(c.this.f803a, 180.0f, 90.0f, true, paint);
                canvas.translate(height, 0.0f);
                canvas.rotate(90.0f);
                canvas.drawArc(c.this.f803a, 180.0f, 90.0f, true, paint);
                canvas.translate(width, 0.0f);
                canvas.rotate(90.0f);
                canvas.drawArc(c.this.f803a, 180.0f, 90.0f, true, paint);
                canvas.restoreToCount(save);
                float f5 = rectF.top;
                canvas.drawRect((rectF.left + f3) - 1.0f, f5, (rectF.right - f3) + 1.0f, f5 + f3, paint);
                float f6 = rectF.bottom;
                canvas.drawRect((rectF.left + f3) - 1.0f, f6 - f3, (rectF.right - f3) + 1.0f, f6, paint);
            }
            canvas.drawRect(rectF.left, rectF.top + f, rectF.right, rectF.bottom - f, paint);
        }
    }

    private g o(Context context, ColorStateList colorStateList, float f, float f2, float f3) {
        return new g(context.getResources(), colorStateList, f, f2, f3);
    }

    private g p(d dVar) {
        return (g) dVar.d();
    }

    @Override // androidx.cardview.widget.e
    public float a(d dVar) {
        return p(dVar).i();
    }

    @Override // androidx.cardview.widget.e
    public float b(d dVar) {
        return p(dVar).g();
    }

    @Override // androidx.cardview.widget.e
    public float c(d dVar) {
        return p(dVar).j();
    }

    @Override // androidx.cardview.widget.e
    public float d(d dVar) {
        return p(dVar).k();
    }

    @Override // androidx.cardview.widget.e
    public void e(d dVar) {
    }

    @Override // androidx.cardview.widget.e
    public ColorStateList f(d dVar) {
        return p(dVar).f();
    }

    @Override // androidx.cardview.widget.e
    public void g(d dVar, float f) {
        p(dVar).r(f);
    }

    @Override // androidx.cardview.widget.e
    public void h(d dVar, Context context, ColorStateList colorStateList, float f, float f2, float f3) {
        g o = o(context, colorStateList, f, f2, f3);
        o.m(dVar.g());
        dVar.f(o);
        q(dVar);
    }

    @Override // androidx.cardview.widget.e
    public void i(d dVar, float f) {
        p(dVar).p(f);
        q(dVar);
    }

    @Override // androidx.cardview.widget.e
    public void j(d dVar) {
        p(dVar).m(dVar.g());
        q(dVar);
    }

    @Override // androidx.cardview.widget.e
    public void k(d dVar, ColorStateList colorStateList) {
        p(dVar).o(colorStateList);
    }

    @Override // androidx.cardview.widget.e
    public float l(d dVar) {
        return p(dVar).l();
    }

    @Override // androidx.cardview.widget.e
    public void m(d dVar, float f) {
        p(dVar).q(f);
        q(dVar);
    }

    @Override // androidx.cardview.widget.e
    public void n() {
        g.r = new a();
    }

    public void q(d dVar) {
        Rect rect = new Rect();
        p(dVar).h(rect);
        dVar.e((int) Math.ceil(d(dVar)), (int) Math.ceil(c(dVar)));
        dVar.a(rect.left, rect.top, rect.right, rect.bottom);
    }
}
