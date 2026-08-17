package life.knowledge4.videotrimmer.view;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.View;
import life.knowledge4.videotrimmer.g.b;
/* loaded from: classes.dex */
public class ProgressBarView extends View implements b, life.knowledge4.videotrimmer.g.a {

    /* renamed from: b  reason: collision with root package name */
    private int f2749b;

    /* renamed from: c  reason: collision with root package name */
    private int f2750c;

    /* renamed from: d  reason: collision with root package name */
    private final Paint f2751d;
    private final Paint e;
    private Rect f;
    private Rect g;

    public ProgressBarView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public ProgressBarView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f2751d = new Paint();
        this.e = new Paint();
        h();
    }

    private void f(Canvas canvas) {
        Rect rect = this.f;
        if (rect != null) {
            canvas.drawRect(rect, this.f2751d);
        }
    }

    private void g(Canvas canvas) {
        Rect rect = this.g;
        if (rect != null) {
            canvas.drawRect(rect, this.e);
        }
    }

    private void h() {
        int b2 = androidx.core.content.a.b(getContext(), life.knowledge4.videotrimmer.a.progress_color);
        int b3 = androidx.core.content.a.b(getContext(), life.knowledge4.videotrimmer.a.background_progress_color);
        this.f2749b = getContext().getResources().getDimensionPixelOffset(life.knowledge4.videotrimmer.b.progress_video_line_height);
        this.f2751d.setAntiAlias(true);
        this.f2751d.setColor(b3);
        this.e.setAntiAlias(true);
        this.e.setColor(b2);
    }

    private void i(int i, float f) {
        Rect rect;
        if (this.f == null) {
            this.f = new Rect(0, 0, this.f2750c, this.f2749b);
        }
        int i2 = (int) ((this.f2750c * f) / 100.0f);
        if (i == 0) {
            Rect rect2 = this.f;
            rect = new Rect(i2, rect2.top, rect2.right, rect2.bottom);
        } else {
            Rect rect3 = this.f;
            rect = new Rect(rect3.left, rect3.top, i2, rect3.bottom);
        }
        this.f = rect;
        c(0, 0, 0.0f);
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void a(RangeSeekBarView rangeSeekBarView, int i, float f) {
        i(i, f);
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void b(RangeSeekBarView rangeSeekBarView, int i, float f) {
        i(i, f);
    }

    @Override // life.knowledge4.videotrimmer.g.a
    public void c(int i, int i2, float f) {
        if (f == 0.0f) {
            Rect rect = this.f;
            this.g = new Rect(0, rect.top, 0, rect.bottom);
        } else {
            Rect rect2 = this.f;
            this.g = new Rect(rect2.left, rect2.top, (int) ((this.f2750c * f) / 100.0f), rect2.bottom);
        }
        invalidate();
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void d(RangeSeekBarView rangeSeekBarView, int i, float f) {
        i(i, f);
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void e(RangeSeekBarView rangeSeekBarView, int i, float f) {
        i(i, f);
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        f(canvas);
        g(canvas);
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        this.f2750c = View.resolveSizeAndState(getPaddingLeft() + getPaddingRight() + getSuggestedMinimumWidth(), i, 1);
        setMeasuredDimension(this.f2750c, View.resolveSizeAndState(getPaddingBottom() + getPaddingTop() + this.f2749b, i2, 1));
    }
}
