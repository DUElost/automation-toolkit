package org.achartengine;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.os.Build;
import android.os.Handler;
import android.view.MotionEvent;
import android.view.View;
import org.achartengine.f.i;
/* loaded from: classes.dex */
public class b extends View {
    private static final int s = Color.argb(175, 150, 150, 150);

    /* renamed from: b  reason: collision with root package name */
    private org.achartengine.f.a f2766b;

    /* renamed from: c  reason: collision with root package name */
    private org.achartengine.h.b f2767c;

    /* renamed from: d  reason: collision with root package name */
    private Rect f2768d;
    private Handler e;
    private RectF f;
    private Bitmap g;
    private Bitmap h;
    private Bitmap i;
    private int j;
    private org.achartengine.i.e k;
    private org.achartengine.i.e l;
    private org.achartengine.i.b m;
    private Paint n;
    private c o;
    private float p;
    private float q;
    private boolean r;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            b.this.invalidate();
        }
    }

    public b(Context context, org.achartengine.f.a aVar) {
        super(context);
        int i;
        this.f2768d = new Rect();
        this.f = new RectF();
        this.j = 50;
        this.n = new Paint();
        this.f2766b = aVar;
        this.e = new Handler();
        org.achartengine.f.a aVar2 = this.f2766b;
        this.f2767c = aVar2 instanceof i ? ((i) aVar2).B() : ((org.achartengine.f.e) aVar2).r();
        if (this.f2767c.J()) {
            this.g = BitmapFactory.decodeStream(b.class.getResourceAsStream("image/zoom_in.png"));
            this.h = BitmapFactory.decodeStream(b.class.getResourceAsStream("image/zoom_out.png"));
            this.i = BitmapFactory.decodeStream(b.class.getResourceAsStream("image/zoom-1.png"));
        }
        org.achartengine.h.b bVar = this.f2767c;
        if ((bVar instanceof org.achartengine.h.d) && ((org.achartengine.h.d) bVar).i0() == 0) {
            ((org.achartengine.h.d) this.f2767c).d1(this.n.getColor());
        }
        if ((this.f2767c.K() && this.f2767c.J()) || this.f2767c.x()) {
            this.k = new org.achartengine.i.e(this.f2766b, true, this.f2767c.t());
            this.l = new org.achartengine.i.e(this.f2766b, false, this.f2767c.t());
            this.m = new org.achartengine.i.b(this.f2766b);
        }
        try {
            i = Integer.valueOf(Build.VERSION.SDK).intValue();
        } catch (Exception unused) {
            i = 7;
        }
        this.o = i < 7 ? new e(this, this.f2766b) : new d(this, this.f2766b);
    }

    public void a() {
        this.e.post(new a());
    }

    public void b() {
        org.achartengine.i.e eVar = this.k;
        if (eVar != null) {
            eVar.e(0);
            a();
        }
    }

    public void c() {
        org.achartengine.i.e eVar = this.l;
        if (eVar != null) {
            eVar.e(0);
            a();
        }
    }

    public void d() {
        org.achartengine.i.b bVar = this.m;
        if (bVar != null) {
            bVar.e();
            this.k.g();
            a();
        }
    }

    public org.achartengine.f.a getChart() {
        return this.f2766b;
    }

    public org.achartengine.g.b getCurrentSeriesAndPoint() {
        return this.f2766b.m(new org.achartengine.g.a(this.p, this.q));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public RectF getZoomRectangle() {
        return this.f;
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        int i;
        super.onDraw(canvas);
        canvas.getClipBounds(this.f2768d);
        Rect rect = this.f2768d;
        int i2 = rect.top;
        int i3 = rect.left;
        int width = rect.width();
        int height = this.f2768d.height();
        if (this.f2767c.z()) {
            width = getMeasuredWidth();
            height = getMeasuredHeight();
            i2 = 0;
            i3 = 0;
        }
        this.f2766b.b(canvas, i3, i2, width, height, this.n);
        org.achartengine.h.b bVar = this.f2767c;
        if (bVar != null && bVar.K() && this.f2767c.J()) {
            this.n.setColor(s);
            int max = Math.max(this.j, Math.min(width, height) / 7);
            this.j = max;
            float f = i2 + height;
            float f2 = i3 + width;
            this.f.set(i - (max * 3), f - (max * 0.775f), f2, f);
            RectF rectF = this.f;
            int i4 = this.j;
            canvas.drawRoundRect(rectF, i4 / 3, i4 / 3, this.n);
            int i5 = this.j;
            float f3 = f - (i5 * 0.625f);
            canvas.drawBitmap(this.g, f2 - (i5 * 2.75f), f3, (Paint) null);
            canvas.drawBitmap(this.h, f2 - (this.j * 1.75f), f3, (Paint) null);
            canvas.drawBitmap(this.i, f2 - (this.j * 0.75f), f3, (Paint) null);
        }
        this.r = true;
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (motionEvent.getAction() == 0) {
            this.p = motionEvent.getX();
            this.q = motionEvent.getY();
        }
        org.achartengine.h.b bVar = this.f2767c;
        if (bVar != null && this.r && ((bVar.A() || this.f2767c.K()) && this.o.a(motionEvent))) {
            return true;
        }
        return super.onTouchEvent(motionEvent);
    }

    public void setZoomRate(float f) {
        org.achartengine.i.e eVar = this.k;
        if (eVar == null || this.l == null) {
            return;
        }
        eVar.h(f);
        this.l.h(f);
    }
}
