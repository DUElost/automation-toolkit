package life.knowledge4.videotrimmer.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import java.util.ArrayList;
import java.util.List;
import life.knowledge4.videotrimmer.g.b;
/* loaded from: classes.dex */
public class RangeSeekBarView extends View {

    /* renamed from: b  reason: collision with root package name */
    private int f2752b;

    /* renamed from: c  reason: collision with root package name */
    private List<a> f2753c;

    /* renamed from: d  reason: collision with root package name */
    private List<b> f2754d;
    private float e;
    private float f;
    private float g;
    private int h;
    private float i;
    private float j;
    private float k;
    private boolean l;
    private final Paint m;
    private final Paint n;
    private int o;

    public RangeSeekBarView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public RangeSeekBarView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.m = new Paint();
        this.n = new Paint();
        this.o = 0;
        i();
    }

    private void b(int i) {
        if (i >= this.f2753c.size() || this.f2753c.isEmpty()) {
            return;
        }
        a aVar = this.f2753c.get(i);
        aVar.n(p(i, aVar.g()));
    }

    private void c(int i) {
        if (i >= this.f2753c.size() || this.f2753c.isEmpty()) {
            return;
        }
        a aVar = this.f2753c.get(i);
        aVar.o(o(i, aVar.f()));
        l(this, i, aVar.g());
    }

    private void d(a aVar, a aVar2, float f, boolean z) {
        if (z && f < 0.0f) {
            if (aVar2.f() - (aVar.f() + f) > this.e) {
                aVar2.n(aVar.f() + f + this.e);
                q(1, aVar2.f());
            }
        } else if (z || f <= 0.0f || (aVar2.f() + f) - aVar.f() <= this.e) {
        } else {
            aVar.n((aVar2.f() + f) - this.e);
            q(0, aVar.f());
        }
    }

    private void e(Canvas canvas) {
        Rect rect;
        if (this.f2753c.isEmpty()) {
            return;
        }
        for (a aVar : this.f2753c) {
            int d2 = aVar.d();
            float f = aVar.f();
            if (d2 == 0) {
                float paddingLeft = f + getPaddingLeft();
                if (paddingLeft > this.i) {
                    float f2 = this.f;
                    rect = new Rect((int) f2, 0, (int) (paddingLeft + f2), this.f2752b);
                    canvas.drawRect(rect, this.m);
                }
            } else {
                float paddingRight = f - getPaddingRight();
                if (paddingRight < this.j) {
                    rect = new Rect((int) paddingRight, 0, (int) (this.h - this.f), this.f2752b);
                    canvas.drawRect(rect, this.m);
                }
            }
        }
    }

    private void f(Canvas canvas) {
        Bitmap a2;
        float f;
        if (this.f2753c.isEmpty()) {
            return;
        }
        for (a aVar : this.f2753c) {
            if (aVar.d() == 0) {
                a2 = aVar.a();
                f = aVar.f() + getPaddingLeft();
            } else {
                a2 = aVar.a();
                f = aVar.f() - getPaddingRight();
            }
            canvas.drawBitmap(a2, f, getPaddingTop() + this.f2752b, (Paint) null);
        }
    }

    private int g(float f) {
        int i = -1;
        if (!this.f2753c.isEmpty()) {
            for (int i2 = 0; i2 < this.f2753c.size(); i2++) {
                float f2 = this.f2753c.get(i2).f() + this.f;
                if (f >= this.f2753c.get(i2).f() && f <= f2) {
                    i = this.f2753c.get(i2).d();
                }
            }
        }
        return i;
    }

    private float h(int i) {
        return this.f2753c.get(i).g();
    }

    private void i() {
        List<a> j = a.j(getResources());
        this.f2753c = j;
        this.f = a.i(j);
        this.g = a.c(this.f2753c);
        this.k = 100.0f;
        this.f2752b = getContext().getResources().getDimensionPixelOffset(life.knowledge4.videotrimmer.b.frames_video_height);
        setFocusable(true);
        setFocusableInTouchMode(true);
        this.l = true;
        int b2 = androidx.core.content.a.b(getContext(), life.knowledge4.videotrimmer.a.shadow_color);
        this.m.setAntiAlias(true);
        this.m.setColor(b2);
        this.m.setAlpha(177);
        int b3 = androidx.core.content.a.b(getContext(), life.knowledge4.videotrimmer.a.line_color);
        this.n.setAntiAlias(true);
        this.n.setColor(b3);
        this.n.setAlpha(200);
    }

    private void k(RangeSeekBarView rangeSeekBarView, int i, float f) {
        List<b> list = this.f2754d;
        if (list == null) {
            return;
        }
        for (b bVar : list) {
            bVar.e(rangeSeekBarView, i, f);
        }
    }

    private void l(RangeSeekBarView rangeSeekBarView, int i, float f) {
        List<b> list = this.f2754d;
        if (list == null) {
            return;
        }
        for (b bVar : list) {
            bVar.a(rangeSeekBarView, i, f);
        }
    }

    private void m(RangeSeekBarView rangeSeekBarView, int i, float f) {
        List<b> list = this.f2754d;
        if (list == null) {
            return;
        }
        for (b bVar : list) {
            bVar.b(rangeSeekBarView, i, f);
        }
    }

    private void n(RangeSeekBarView rangeSeekBarView, int i, float f) {
        List<b> list = this.f2754d;
        if (list == null) {
            return;
        }
        for (b bVar : list) {
            bVar.d(rangeSeekBarView, i, f);
        }
    }

    private float o(int i, float f) {
        float f2 = this.j;
        float f3 = (f * 100.0f) / f2;
        return i == 0 ? f3 + ((((this.f * f3) / 100.0f) * 100.0f) / f2) : f3 - (((((100.0f - f3) * this.f) / 100.0f) * 100.0f) / f2);
    }

    private float p(int i, float f) {
        float f2 = (this.j * f) / 100.0f;
        return i == 0 ? f2 - ((f * this.f) / 100.0f) : f2 + (((100.0f - f) * this.f) / 100.0f);
    }

    private void q(int i, float f) {
        this.f2753c.get(i).n(f);
        c(i);
        invalidate();
    }

    public void a(b bVar) {
        if (this.f2754d == null) {
            this.f2754d = new ArrayList();
        }
        this.f2754d.add(bVar);
    }

    public List<a> getThumbs() {
        return this.f2753c;
    }

    public void j() {
        this.e = this.f2753c.get(1).f() - this.f2753c.get(0).f();
        n(this, 0, this.f2753c.get(0).g());
        n(this, 1, this.f2753c.get(1).g());
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        e(canvas);
        f(canvas);
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        this.h = View.resolveSizeAndState(getPaddingLeft() + getPaddingRight() + getSuggestedMinimumWidth(), i, 1);
        setMeasuredDimension(this.h, View.resolveSizeAndState(getPaddingBottom() + getPaddingTop() + ((int) this.g) + this.f2752b, i2, 1));
        this.i = 0.0f;
        this.j = this.h - this.f;
        if (this.l) {
            for (int i3 = 0; i3 < this.f2753c.size(); i3++) {
                a aVar = this.f2753c.get(i3);
                float f = i3;
                aVar.o(this.k * f);
                aVar.n(this.j * f);
            }
            int i4 = this.o;
            k(this, i4, h(i4));
            this.l = false;
        }
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        float f;
        float x = motionEvent.getX();
        int action = motionEvent.getAction();
        if (action == 0) {
            int g = g(x);
            this.o = g;
            if (g == -1) {
                return false;
            }
            a aVar = this.f2753c.get(g);
            aVar.m(x);
            m(this, this.o, aVar.g());
            return true;
        } else if (action == 1) {
            int i = this.o;
            if (i == -1) {
                return false;
            }
            n(this, this.o, this.f2753c.get(i).g());
            return true;
        } else if (action != 2) {
            return false;
        } else {
            a aVar2 = this.f2753c.get(this.o);
            a aVar3 = this.f2753c.get(this.o == 0 ? 1 : 0);
            float e = x - aVar2.e();
            float f2 = aVar2.f() + e;
            if (this.o == 0) {
                if (aVar2.h() + f2 >= aVar3.f()) {
                    f = aVar3.f() - aVar2.h();
                    aVar2.n(f);
                } else {
                    float f3 = this.i;
                    if (f2 <= f3) {
                        aVar2.n(f3);
                    } else {
                        d(aVar2, aVar3, e, true);
                        aVar2.n(aVar2.f() + e);
                        aVar2.m(x);
                    }
                }
            } else if (f2 <= aVar3.f() + aVar3.h()) {
                f = aVar3.f() + aVar2.h();
                aVar2.n(f);
            } else {
                float f4 = this.j;
                if (f2 >= f4) {
                    aVar2.n(f4);
                } else {
                    d(aVar3, aVar2, e, false);
                    aVar2.n(aVar2.f() + e);
                    aVar2.m(x);
                }
            }
            q(this.o, aVar2.f());
            invalidate();
            return true;
        }
    }

    public void r(int i, float f) {
        this.f2753c.get(i).o(f);
        b(i);
        invalidate();
    }
}
