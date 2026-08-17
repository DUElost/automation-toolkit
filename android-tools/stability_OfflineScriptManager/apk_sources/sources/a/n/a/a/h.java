package a.n.a.a;

import a.f.e.b;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PathMeasure;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.Rect;
import android.graphics.Shader;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.VectorDrawable;
import android.os.Build;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
import java.io.IOException;
import java.util.ArrayDeque;
import java.util.ArrayList;
import jxl.SheetSettings;
import org.xmlpull.v1.XmlPullParser;
/* loaded from: classes.dex */
public class h extends a.n.a.a.g {
    static final PorterDuff.Mode k = PorterDuff.Mode.SRC_IN;

    /* renamed from: c  reason: collision with root package name */
    private C0020h f346c;

    /* renamed from: d  reason: collision with root package name */
    private PorterDuffColorFilter f347d;
    private ColorFilter e;
    private boolean f;
    private boolean g;
    private final float[] h;
    private final Matrix i;
    private final Rect j;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b extends f {
        public b() {
        }

        public b(b bVar) {
            super(bVar);
        }

        private void f(TypedArray typedArray) {
            String string = typedArray.getString(0);
            if (string != null) {
                this.f354b = string;
            }
            String string2 = typedArray.getString(1);
            if (string2 != null) {
                this.f353a = a.f.e.b.d(string2);
            }
        }

        @Override // a.n.a.a.h.f
        public boolean c() {
            return true;
        }

        public void e(Resources resources, AttributeSet attributeSet, Resources.Theme theme, XmlPullParser xmlPullParser) {
            if (androidx.core.content.c.g.h(xmlPullParser, "pathData")) {
                TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, a.n.a.a.a.f332d);
                f(i);
                i.recycle();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class c extends f {

        /* renamed from: d  reason: collision with root package name */
        private int[] f348d;
        androidx.core.content.c.b e;
        float f;
        androidx.core.content.c.b g;
        float h;
        int i;
        float j;
        float k;
        float l;
        float m;
        Paint.Cap n;
        Paint.Join o;
        float p;

        public c() {
            this.f = 0.0f;
            this.h = 1.0f;
            this.i = 0;
            this.j = 1.0f;
            this.k = 0.0f;
            this.l = 1.0f;
            this.m = 0.0f;
            this.n = Paint.Cap.BUTT;
            this.o = Paint.Join.MITER;
            this.p = 4.0f;
        }

        public c(c cVar) {
            super(cVar);
            this.f = 0.0f;
            this.h = 1.0f;
            this.i = 0;
            this.j = 1.0f;
            this.k = 0.0f;
            this.l = 1.0f;
            this.m = 0.0f;
            this.n = Paint.Cap.BUTT;
            this.o = Paint.Join.MITER;
            this.p = 4.0f;
            this.f348d = cVar.f348d;
            this.e = cVar.e;
            this.f = cVar.f;
            this.h = cVar.h;
            this.g = cVar.g;
            this.i = cVar.i;
            this.j = cVar.j;
            this.k = cVar.k;
            this.l = cVar.l;
            this.m = cVar.m;
            this.n = cVar.n;
            this.o = cVar.o;
            this.p = cVar.p;
        }

        private Paint.Cap e(int i, Paint.Cap cap) {
            return i != 0 ? i != 1 ? i != 2 ? cap : Paint.Cap.SQUARE : Paint.Cap.ROUND : Paint.Cap.BUTT;
        }

        private Paint.Join f(int i, Paint.Join join) {
            return i != 0 ? i != 1 ? i != 2 ? join : Paint.Join.BEVEL : Paint.Join.ROUND : Paint.Join.MITER;
        }

        private void h(TypedArray typedArray, XmlPullParser xmlPullParser, Resources.Theme theme) {
            this.f348d = null;
            if (androidx.core.content.c.g.h(xmlPullParser, "pathData")) {
                String string = typedArray.getString(0);
                if (string != null) {
                    this.f354b = string;
                }
                String string2 = typedArray.getString(2);
                if (string2 != null) {
                    this.f353a = a.f.e.b.d(string2);
                }
                this.g = androidx.core.content.c.g.c(typedArray, xmlPullParser, theme, "fillColor", 1, 0);
                this.j = androidx.core.content.c.g.d(typedArray, xmlPullParser, "fillAlpha", 12, this.j);
                this.n = e(androidx.core.content.c.g.e(typedArray, xmlPullParser, "strokeLineCap", 8, -1), this.n);
                this.o = f(androidx.core.content.c.g.e(typedArray, xmlPullParser, "strokeLineJoin", 9, -1), this.o);
                this.p = androidx.core.content.c.g.d(typedArray, xmlPullParser, "strokeMiterLimit", 10, this.p);
                this.e = androidx.core.content.c.g.c(typedArray, xmlPullParser, theme, "strokeColor", 3, 0);
                this.h = androidx.core.content.c.g.d(typedArray, xmlPullParser, "strokeAlpha", 11, this.h);
                this.f = androidx.core.content.c.g.d(typedArray, xmlPullParser, "strokeWidth", 4, this.f);
                this.l = androidx.core.content.c.g.d(typedArray, xmlPullParser, "trimPathEnd", 6, this.l);
                this.m = androidx.core.content.c.g.d(typedArray, xmlPullParser, "trimPathOffset", 7, this.m);
                this.k = androidx.core.content.c.g.d(typedArray, xmlPullParser, "trimPathStart", 5, this.k);
                this.i = androidx.core.content.c.g.e(typedArray, xmlPullParser, "fillType", 13, this.i);
            }
        }

        @Override // a.n.a.a.h.e
        public boolean a() {
            return this.g.i() || this.e.i();
        }

        @Override // a.n.a.a.h.e
        public boolean b(int[] iArr) {
            return this.e.j(iArr) | this.g.j(iArr);
        }

        public void g(Resources resources, AttributeSet attributeSet, Resources.Theme theme, XmlPullParser xmlPullParser) {
            TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, a.n.a.a.a.f331c);
            h(i, xmlPullParser, theme);
            i.recycle();
        }

        float getFillAlpha() {
            return this.j;
        }

        int getFillColor() {
            return this.g.e();
        }

        float getStrokeAlpha() {
            return this.h;
        }

        int getStrokeColor() {
            return this.e.e();
        }

        float getStrokeWidth() {
            return this.f;
        }

        float getTrimPathEnd() {
            return this.l;
        }

        float getTrimPathOffset() {
            return this.m;
        }

        float getTrimPathStart() {
            return this.k;
        }

        void setFillAlpha(float f) {
            this.j = f;
        }

        void setFillColor(int i) {
            this.g.k(i);
        }

        void setStrokeAlpha(float f) {
            this.h = f;
        }

        void setStrokeColor(int i) {
            this.e.k(i);
        }

        void setStrokeWidth(float f) {
            this.f = f;
        }

        void setTrimPathEnd(float f) {
            this.l = f;
        }

        void setTrimPathOffset(float f) {
            this.m = f;
        }

        void setTrimPathStart(float f) {
            this.k = f;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class d extends e {

        /* renamed from: a  reason: collision with root package name */
        final Matrix f349a;

        /* renamed from: b  reason: collision with root package name */
        final ArrayList<e> f350b;

        /* renamed from: c  reason: collision with root package name */
        float f351c;

        /* renamed from: d  reason: collision with root package name */
        private float f352d;
        private float e;
        private float f;
        private float g;
        private float h;
        private float i;
        final Matrix j;
        int k;
        private int[] l;
        private String m;

        public d() {
            super();
            this.f349a = new Matrix();
            this.f350b = new ArrayList<>();
            this.f351c = 0.0f;
            this.f352d = 0.0f;
            this.e = 0.0f;
            this.f = 1.0f;
            this.g = 1.0f;
            this.h = 0.0f;
            this.i = 0.0f;
            this.j = new Matrix();
            this.m = null;
        }

        public d(d dVar, a.d.a<String, Object> aVar) {
            super();
            f bVar;
            this.f349a = new Matrix();
            this.f350b = new ArrayList<>();
            this.f351c = 0.0f;
            this.f352d = 0.0f;
            this.e = 0.0f;
            this.f = 1.0f;
            this.g = 1.0f;
            this.h = 0.0f;
            this.i = 0.0f;
            Matrix matrix = new Matrix();
            this.j = matrix;
            this.m = null;
            this.f351c = dVar.f351c;
            this.f352d = dVar.f352d;
            this.e = dVar.e;
            this.f = dVar.f;
            this.g = dVar.g;
            this.h = dVar.h;
            this.i = dVar.i;
            this.l = dVar.l;
            String str = dVar.m;
            this.m = str;
            this.k = dVar.k;
            if (str != null) {
                aVar.put(str, this);
            }
            matrix.set(dVar.j);
            ArrayList<e> arrayList = dVar.f350b;
            for (int i = 0; i < arrayList.size(); i++) {
                e eVar = arrayList.get(i);
                if (eVar instanceof d) {
                    this.f350b.add(new d((d) eVar, aVar));
                } else {
                    if (eVar instanceof c) {
                        bVar = new c((c) eVar);
                    } else if (!(eVar instanceof b)) {
                        throw new IllegalStateException("Unknown object in the tree!");
                    } else {
                        bVar = new b((b) eVar);
                    }
                    this.f350b.add(bVar);
                    String str2 = bVar.f354b;
                    if (str2 != null) {
                        aVar.put(str2, bVar);
                    }
                }
            }
        }

        private void d() {
            this.j.reset();
            this.j.postTranslate(-this.f352d, -this.e);
            this.j.postScale(this.f, this.g);
            this.j.postRotate(this.f351c, 0.0f, 0.0f);
            this.j.postTranslate(this.h + this.f352d, this.i + this.e);
        }

        private void e(TypedArray typedArray, XmlPullParser xmlPullParser) {
            this.l = null;
            this.f351c = androidx.core.content.c.g.d(typedArray, xmlPullParser, "rotation", 5, this.f351c);
            this.f352d = typedArray.getFloat(1, this.f352d);
            this.e = typedArray.getFloat(2, this.e);
            this.f = androidx.core.content.c.g.d(typedArray, xmlPullParser, "scaleX", 3, this.f);
            this.g = androidx.core.content.c.g.d(typedArray, xmlPullParser, "scaleY", 4, this.g);
            this.h = androidx.core.content.c.g.d(typedArray, xmlPullParser, "translateX", 6, this.h);
            this.i = androidx.core.content.c.g.d(typedArray, xmlPullParser, "translateY", 7, this.i);
            String string = typedArray.getString(0);
            if (string != null) {
                this.m = string;
            }
            d();
        }

        @Override // a.n.a.a.h.e
        public boolean a() {
            for (int i = 0; i < this.f350b.size(); i++) {
                if (this.f350b.get(i).a()) {
                    return true;
                }
            }
            return false;
        }

        @Override // a.n.a.a.h.e
        public boolean b(int[] iArr) {
            boolean z = false;
            for (int i = 0; i < this.f350b.size(); i++) {
                z |= this.f350b.get(i).b(iArr);
            }
            return z;
        }

        public void c(Resources resources, AttributeSet attributeSet, Resources.Theme theme, XmlPullParser xmlPullParser) {
            TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, a.n.a.a.a.f330b);
            e(i, xmlPullParser);
            i.recycle();
        }

        public String getGroupName() {
            return this.m;
        }

        public Matrix getLocalMatrix() {
            return this.j;
        }

        public float getPivotX() {
            return this.f352d;
        }

        public float getPivotY() {
            return this.e;
        }

        public float getRotation() {
            return this.f351c;
        }

        public float getScaleX() {
            return this.f;
        }

        public float getScaleY() {
            return this.g;
        }

        public float getTranslateX() {
            return this.h;
        }

        public float getTranslateY() {
            return this.i;
        }

        public void setPivotX(float f) {
            if (f != this.f352d) {
                this.f352d = f;
                d();
            }
        }

        public void setPivotY(float f) {
            if (f != this.e) {
                this.e = f;
                d();
            }
        }

        public void setRotation(float f) {
            if (f != this.f351c) {
                this.f351c = f;
                d();
            }
        }

        public void setScaleX(float f) {
            if (f != this.f) {
                this.f = f;
                d();
            }
        }

        public void setScaleY(float f) {
            if (f != this.g) {
                this.g = f;
                d();
            }
        }

        public void setTranslateX(float f) {
            if (f != this.h) {
                this.h = f;
                d();
            }
        }

        public void setTranslateY(float f) {
            if (f != this.i) {
                this.i = f;
                d();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static abstract class e {
        private e() {
        }

        public boolean a() {
            return false;
        }

        public boolean b(int[] iArr) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static abstract class f extends e {

        /* renamed from: a  reason: collision with root package name */
        protected b.C0005b[] f353a;

        /* renamed from: b  reason: collision with root package name */
        String f354b;

        /* renamed from: c  reason: collision with root package name */
        int f355c;

        public f() {
            super();
            this.f353a = null;
        }

        public f(f fVar) {
            super();
            this.f353a = null;
            this.f354b = fVar.f354b;
            this.f355c = fVar.f355c;
            this.f353a = a.f.e.b.f(fVar.f353a);
        }

        public boolean c() {
            return false;
        }

        public void d(Path path) {
            path.reset();
            b.C0005b[] c0005bArr = this.f353a;
            if (c0005bArr != null) {
                b.C0005b.e(c0005bArr, path);
            }
        }

        public b.C0005b[] getPathData() {
            return this.f353a;
        }

        public String getPathName() {
            return this.f354b;
        }

        public void setPathData(b.C0005b[] c0005bArr) {
            if (a.f.e.b.b(this.f353a, c0005bArr)) {
                a.f.e.b.j(this.f353a, c0005bArr);
            } else {
                this.f353a = a.f.e.b.f(c0005bArr);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class g {
        private static final Matrix q = new Matrix();

        /* renamed from: a  reason: collision with root package name */
        private final Path f356a;

        /* renamed from: b  reason: collision with root package name */
        private final Path f357b;

        /* renamed from: c  reason: collision with root package name */
        private final Matrix f358c;

        /* renamed from: d  reason: collision with root package name */
        Paint f359d;
        Paint e;
        private PathMeasure f;
        private int g;
        final d h;
        float i;
        float j;
        float k;
        float l;
        int m;
        String n;
        Boolean o;
        final a.d.a<String, Object> p;

        public g() {
            this.f358c = new Matrix();
            this.i = 0.0f;
            this.j = 0.0f;
            this.k = 0.0f;
            this.l = 0.0f;
            this.m = SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
            this.n = null;
            this.o = null;
            this.p = new a.d.a<>();
            this.h = new d();
            this.f356a = new Path();
            this.f357b = new Path();
        }

        public g(g gVar) {
            this.f358c = new Matrix();
            this.i = 0.0f;
            this.j = 0.0f;
            this.k = 0.0f;
            this.l = 0.0f;
            this.m = SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
            this.n = null;
            this.o = null;
            a.d.a<String, Object> aVar = new a.d.a<>();
            this.p = aVar;
            this.h = new d(gVar.h, aVar);
            this.f356a = new Path(gVar.f356a);
            this.f357b = new Path(gVar.f357b);
            this.i = gVar.i;
            this.j = gVar.j;
            this.k = gVar.k;
            this.l = gVar.l;
            this.g = gVar.g;
            this.m = gVar.m;
            this.n = gVar.n;
            String str = gVar.n;
            if (str != null) {
                aVar.put(str, this);
            }
            this.o = gVar.o;
        }

        private static float a(float f, float f2, float f3, float f4) {
            return (f * f4) - (f2 * f3);
        }

        private void c(d dVar, Matrix matrix, Canvas canvas, int i, int i2, ColorFilter colorFilter) {
            dVar.f349a.set(matrix);
            dVar.f349a.preConcat(dVar.j);
            canvas.save();
            for (int i3 = 0; i3 < dVar.f350b.size(); i3++) {
                e eVar = dVar.f350b.get(i3);
                if (eVar instanceof d) {
                    c((d) eVar, dVar.f349a, canvas, i, i2, colorFilter);
                } else if (eVar instanceof f) {
                    d(dVar, (f) eVar, canvas, i, i2, colorFilter);
                }
            }
            canvas.restore();
        }

        private void d(d dVar, f fVar, Canvas canvas, int i, int i2, ColorFilter colorFilter) {
            float f = i / this.k;
            float f2 = i2 / this.l;
            float min = Math.min(f, f2);
            Matrix matrix = dVar.f349a;
            this.f358c.set(matrix);
            this.f358c.postScale(f, f2);
            float e = e(matrix);
            if (e == 0.0f) {
                return;
            }
            fVar.d(this.f356a);
            Path path = this.f356a;
            this.f357b.reset();
            if (fVar.c()) {
                this.f357b.addPath(path, this.f358c);
                canvas.clipPath(this.f357b);
                return;
            }
            c cVar = (c) fVar;
            float f3 = cVar.k;
            if (f3 != 0.0f || cVar.l != 1.0f) {
                float f4 = cVar.m;
                float f5 = (f3 + f4) % 1.0f;
                float f6 = (cVar.l + f4) % 1.0f;
                if (this.f == null) {
                    this.f = new PathMeasure();
                }
                this.f.setPath(this.f356a, false);
                float length = this.f.getLength();
                float f7 = f5 * length;
                float f8 = f6 * length;
                path.reset();
                if (f7 > f8) {
                    this.f.getSegment(f7, length, path, true);
                    this.f.getSegment(0.0f, f8, path, true);
                } else {
                    this.f.getSegment(f7, f8, path, true);
                }
                path.rLineTo(0.0f, 0.0f);
            }
            this.f357b.addPath(path, this.f358c);
            if (cVar.g.l()) {
                androidx.core.content.c.b bVar = cVar.g;
                if (this.e == null) {
                    Paint paint = new Paint(1);
                    this.e = paint;
                    paint.setStyle(Paint.Style.FILL);
                }
                Paint paint2 = this.e;
                if (bVar.h()) {
                    Shader f9 = bVar.f();
                    f9.setLocalMatrix(this.f358c);
                    paint2.setShader(f9);
                    paint2.setAlpha(Math.round(cVar.j * 255.0f));
                } else {
                    paint2.setColor(h.a(bVar.e(), cVar.j));
                }
                paint2.setColorFilter(colorFilter);
                this.f357b.setFillType(cVar.i == 0 ? Path.FillType.WINDING : Path.FillType.EVEN_ODD);
                canvas.drawPath(this.f357b, paint2);
            }
            if (cVar.e.l()) {
                androidx.core.content.c.b bVar2 = cVar.e;
                if (this.f359d == null) {
                    Paint paint3 = new Paint(1);
                    this.f359d = paint3;
                    paint3.setStyle(Paint.Style.STROKE);
                }
                Paint paint4 = this.f359d;
                Paint.Join join = cVar.o;
                if (join != null) {
                    paint4.setStrokeJoin(join);
                }
                Paint.Cap cap = cVar.n;
                if (cap != null) {
                    paint4.setStrokeCap(cap);
                }
                paint4.setStrokeMiter(cVar.p);
                if (bVar2.h()) {
                    Shader f10 = bVar2.f();
                    f10.setLocalMatrix(this.f358c);
                    paint4.setShader(f10);
                    paint4.setAlpha(Math.round(cVar.h * 255.0f));
                } else {
                    paint4.setColor(h.a(bVar2.e(), cVar.h));
                }
                paint4.setColorFilter(colorFilter);
                paint4.setStrokeWidth(cVar.f * min * e);
                canvas.drawPath(this.f357b, paint4);
            }
        }

        private float e(Matrix matrix) {
            float[] fArr = {0.0f, 1.0f, 1.0f, 0.0f};
            matrix.mapVectors(fArr);
            float a2 = a(fArr[0], fArr[1], fArr[2], fArr[3]);
            float max = Math.max((float) Math.hypot(fArr[0], fArr[1]), (float) Math.hypot(fArr[2], fArr[3]));
            if (max > 0.0f) {
                return Math.abs(a2) / max;
            }
            return 0.0f;
        }

        public void b(Canvas canvas, int i, int i2, ColorFilter colorFilter) {
            c(this.h, q, canvas, i, i2, colorFilter);
        }

        public boolean f() {
            if (this.o == null) {
                this.o = Boolean.valueOf(this.h.a());
            }
            return this.o.booleanValue();
        }

        public boolean g(int[] iArr) {
            return this.h.b(iArr);
        }

        public float getAlpha() {
            return getRootAlpha() / 255.0f;
        }

        public int getRootAlpha() {
            return this.m;
        }

        public void setAlpha(float f) {
            setRootAlpha((int) (f * 255.0f));
        }

        public void setRootAlpha(int i) {
            this.m = i;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: a.n.a.a.h$h  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0020h extends Drawable.ConstantState {

        /* renamed from: a  reason: collision with root package name */
        int f360a;

        /* renamed from: b  reason: collision with root package name */
        g f361b;

        /* renamed from: c  reason: collision with root package name */
        ColorStateList f362c;

        /* renamed from: d  reason: collision with root package name */
        PorterDuff.Mode f363d;
        boolean e;
        Bitmap f;
        ColorStateList g;
        PorterDuff.Mode h;
        int i;
        boolean j;
        boolean k;
        Paint l;

        public C0020h() {
            this.f362c = null;
            this.f363d = h.k;
            this.f361b = new g();
        }

        public C0020h(C0020h c0020h) {
            this.f362c = null;
            this.f363d = h.k;
            if (c0020h != null) {
                this.f360a = c0020h.f360a;
                g gVar = new g(c0020h.f361b);
                this.f361b = gVar;
                if (c0020h.f361b.e != null) {
                    gVar.e = new Paint(c0020h.f361b.e);
                }
                if (c0020h.f361b.f359d != null) {
                    this.f361b.f359d = new Paint(c0020h.f361b.f359d);
                }
                this.f362c = c0020h.f362c;
                this.f363d = c0020h.f363d;
                this.e = c0020h.e;
            }
        }

        public boolean a(int i, int i2) {
            return i == this.f.getWidth() && i2 == this.f.getHeight();
        }

        public boolean b() {
            return !this.k && this.g == this.f362c && this.h == this.f363d && this.j == this.e && this.i == this.f361b.getRootAlpha();
        }

        public void c(int i, int i2) {
            if (this.f == null || !a(i, i2)) {
                this.f = Bitmap.createBitmap(i, i2, Bitmap.Config.ARGB_8888);
                this.k = true;
            }
        }

        public void d(Canvas canvas, ColorFilter colorFilter, Rect rect) {
            canvas.drawBitmap(this.f, (Rect) null, rect, e(colorFilter));
        }

        public Paint e(ColorFilter colorFilter) {
            if (f() || colorFilter != null) {
                if (this.l == null) {
                    Paint paint = new Paint();
                    this.l = paint;
                    paint.setFilterBitmap(true);
                }
                this.l.setAlpha(this.f361b.getRootAlpha());
                this.l.setColorFilter(colorFilter);
                return this.l;
            }
            return null;
        }

        public boolean f() {
            return this.f361b.getRootAlpha() < 255;
        }

        public boolean g() {
            return this.f361b.f();
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public int getChangingConfigurations() {
            return this.f360a;
        }

        public boolean h(int[] iArr) {
            boolean g = this.f361b.g(iArr);
            this.k |= g;
            return g;
        }

        public void i() {
            this.g = this.f362c;
            this.h = this.f363d;
            this.i = this.f361b.getRootAlpha();
            this.j = this.e;
            this.k = false;
        }

        public void j(int i, int i2) {
            this.f.eraseColor(0);
            this.f361b.b(new Canvas(this.f), i, i2, null);
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable() {
            return new h(this);
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources) {
            return new h(this);
        }
    }

    /* loaded from: classes.dex */
    private static class i extends Drawable.ConstantState {

        /* renamed from: a  reason: collision with root package name */
        private final Drawable.ConstantState f364a;

        public i(Drawable.ConstantState constantState) {
            this.f364a = constantState;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public boolean canApplyTheme() {
            return this.f364a.canApplyTheme();
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public int getChangingConfigurations() {
            return this.f364a.getChangingConfigurations();
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable() {
            h hVar = new h();
            hVar.f345b = (VectorDrawable) this.f364a.newDrawable();
            return hVar;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources) {
            h hVar = new h();
            hVar.f345b = (VectorDrawable) this.f364a.newDrawable(resources);
            return hVar;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources, Resources.Theme theme) {
            h hVar = new h();
            hVar.f345b = (VectorDrawable) this.f364a.newDrawable(resources, theme);
            return hVar;
        }
    }

    h() {
        this.g = true;
        this.h = new float[9];
        this.i = new Matrix();
        this.j = new Rect();
        this.f346c = new C0020h();
    }

    h(C0020h c0020h) {
        this.g = true;
        this.h = new float[9];
        this.i = new Matrix();
        this.j = new Rect();
        this.f346c = c0020h;
        this.f347d = j(this.f347d, c0020h.f362c, c0020h.f363d);
    }

    static int a(int i2, float f2) {
        return (i2 & 16777215) | (((int) (Color.alpha(i2) * f2)) << 24);
    }

    public static h b(Resources resources, int i2, Resources.Theme theme) {
        int next;
        if (Build.VERSION.SDK_INT >= 24) {
            h hVar = new h();
            hVar.f345b = androidx.core.content.c.f.a(resources, i2, theme);
            new i(hVar.f345b.getConstantState());
            return hVar;
        }
        try {
            XmlResourceParser xml = resources.getXml(i2);
            AttributeSet asAttributeSet = Xml.asAttributeSet(xml);
            while (true) {
                next = xml.next();
                if (next == 2 || next == 1) {
                    break;
                }
            }
            if (next == 2) {
                return c(resources, xml, asAttributeSet, theme);
            }
            throw new org.xmlpull.v1.a("No start tag found");
        } catch (IOException | org.xmlpull.v1.a e2) {
            Log.e("VectorDrawableCompat", "parser error", e2);
            return null;
        }
    }

    public static h c(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        h hVar = new h();
        hVar.inflate(resources, xmlPullParser, attributeSet, theme);
        return hVar;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private void e(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        int i2;
        int i3;
        b bVar;
        C0020h c0020h = this.f346c;
        g gVar = c0020h.f361b;
        ArrayDeque arrayDeque = new ArrayDeque();
        arrayDeque.push(gVar.h);
        int eventType = xmlPullParser.getEventType();
        int depth = xmlPullParser.getDepth() + 1;
        boolean z = true;
        while (eventType != 1 && (xmlPullParser.getDepth() >= depth || eventType != 3)) {
            if (eventType == 2) {
                String name = xmlPullParser.getName();
                d dVar = (d) arrayDeque.peek();
                if ("path".equals(name)) {
                    c cVar = new c();
                    cVar.g(resources, attributeSet, theme, xmlPullParser);
                    dVar.f350b.add(cVar);
                    if (cVar.getPathName() != null) {
                        gVar.p.put(cVar.getPathName(), cVar);
                    }
                    z = false;
                    bVar = cVar;
                } else if ("clip-path".equals(name)) {
                    b bVar2 = new b();
                    bVar2.e(resources, attributeSet, theme, xmlPullParser);
                    dVar.f350b.add(bVar2);
                    String pathName = bVar2.getPathName();
                    bVar = bVar2;
                    if (pathName != null) {
                        gVar.p.put(bVar2.getPathName(), bVar2);
                        bVar = bVar2;
                    }
                } else if ("group".equals(name)) {
                    d dVar2 = new d();
                    dVar2.c(resources, attributeSet, theme, xmlPullParser);
                    dVar.f350b.add(dVar2);
                    arrayDeque.push(dVar2);
                    if (dVar2.getGroupName() != null) {
                        gVar.p.put(dVar2.getGroupName(), dVar2);
                    }
                    i2 = c0020h.f360a;
                    i3 = dVar2.k;
                    c0020h.f360a = i3 | i2;
                }
                i2 = c0020h.f360a;
                i3 = bVar.f355c;
                c0020h.f360a = i3 | i2;
            } else if (eventType == 3 && "group".equals(xmlPullParser.getName())) {
                arrayDeque.pop();
            }
            eventType = xmlPullParser.next();
        }
        if (z) {
            throw new org.xmlpull.v1.a("no path defined");
        }
    }

    private boolean f() {
        return Build.VERSION.SDK_INT >= 17 && isAutoMirrored() && androidx.core.graphics.drawable.a.f(this) == 1;
    }

    private static PorterDuff.Mode g(int i2, PorterDuff.Mode mode) {
        if (i2 != 3) {
            if (i2 != 5) {
                if (i2 != 9) {
                    switch (i2) {
                        case 14:
                            return PorterDuff.Mode.MULTIPLY;
                        case 15:
                            return PorterDuff.Mode.SCREEN;
                        case 16:
                            return PorterDuff.Mode.ADD;
                        default:
                            return mode;
                    }
                }
                return PorterDuff.Mode.SRC_ATOP;
            }
            return PorterDuff.Mode.SRC_IN;
        }
        return PorterDuff.Mode.SRC_OVER;
    }

    private void i(TypedArray typedArray, XmlPullParser xmlPullParser) {
        C0020h c0020h = this.f346c;
        g gVar = c0020h.f361b;
        c0020h.f363d = g(androidx.core.content.c.g.e(typedArray, xmlPullParser, "tintMode", 6, -1), PorterDuff.Mode.SRC_IN);
        ColorStateList colorStateList = typedArray.getColorStateList(1);
        if (colorStateList != null) {
            c0020h.f362c = colorStateList;
        }
        c0020h.e = androidx.core.content.c.g.a(typedArray, xmlPullParser, "autoMirrored", 5, c0020h.e);
        gVar.k = androidx.core.content.c.g.d(typedArray, xmlPullParser, "viewportWidth", 7, gVar.k);
        float d2 = androidx.core.content.c.g.d(typedArray, xmlPullParser, "viewportHeight", 8, gVar.l);
        gVar.l = d2;
        if (gVar.k <= 0.0f) {
            throw new org.xmlpull.v1.a(typedArray.getPositionDescription() + "<vector> tag requires viewportWidth > 0");
        } else if (d2 <= 0.0f) {
            throw new org.xmlpull.v1.a(typedArray.getPositionDescription() + "<vector> tag requires viewportHeight > 0");
        } else {
            gVar.i = typedArray.getDimension(3, gVar.i);
            float dimension = typedArray.getDimension(2, gVar.j);
            gVar.j = dimension;
            if (gVar.i <= 0.0f) {
                throw new org.xmlpull.v1.a(typedArray.getPositionDescription() + "<vector> tag requires width > 0");
            } else if (dimension <= 0.0f) {
                throw new org.xmlpull.v1.a(typedArray.getPositionDescription() + "<vector> tag requires height > 0");
            } else {
                gVar.setAlpha(androidx.core.content.c.g.d(typedArray, xmlPullParser, "alpha", 4, gVar.getAlpha()));
                String string = typedArray.getString(0);
                if (string != null) {
                    gVar.n = string;
                    gVar.p.put(string, gVar);
                }
            }
        }
    }

    @Override // android.graphics.drawable.Drawable
    public boolean canApplyTheme() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.b(drawable);
            return false;
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Object d(String str) {
        return this.f346c.f361b.p.get(str);
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.draw(canvas);
            return;
        }
        copyBounds(this.j);
        if (this.j.width() <= 0 || this.j.height() <= 0) {
            return;
        }
        ColorFilter colorFilter = this.e;
        if (colorFilter == null) {
            colorFilter = this.f347d;
        }
        canvas.getMatrix(this.i);
        this.i.getValues(this.h);
        float abs = Math.abs(this.h[0]);
        float abs2 = Math.abs(this.h[4]);
        float abs3 = Math.abs(this.h[1]);
        float abs4 = Math.abs(this.h[3]);
        if (abs3 != 0.0f || abs4 != 0.0f) {
            abs = 1.0f;
            abs2 = 1.0f;
        }
        int min = Math.min(2048, (int) (this.j.width() * abs));
        int min2 = Math.min(2048, (int) (this.j.height() * abs2));
        if (min <= 0 || min2 <= 0) {
            return;
        }
        int save = canvas.save();
        Rect rect = this.j;
        canvas.translate(rect.left, rect.top);
        if (f()) {
            canvas.translate(this.j.width(), 0.0f);
            canvas.scale(-1.0f, 1.0f);
        }
        this.j.offsetTo(0, 0);
        this.f346c.c(min, min2);
        if (!this.g) {
            this.f346c.j(min, min2);
        } else if (!this.f346c.b()) {
            this.f346c.j(min, min2);
            this.f346c.i();
        }
        this.f346c.d(canvas, colorFilter, this.j);
        canvas.restoreToCount(save);
    }

    @Override // android.graphics.drawable.Drawable
    public int getAlpha() {
        Drawable drawable = this.f345b;
        return drawable != null ? androidx.core.graphics.drawable.a.d(drawable) : this.f346c.f361b.getRootAlpha();
    }

    @Override // android.graphics.drawable.Drawable
    public int getChangingConfigurations() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getChangingConfigurations() : super.getChangingConfigurations() | this.f346c.getChangingConfigurations();
    }

    @Override // android.graphics.drawable.Drawable
    public Drawable.ConstantState getConstantState() {
        if (this.f345b == null || Build.VERSION.SDK_INT < 24) {
            this.f346c.f360a = getChangingConfigurations();
            return this.f346c;
        }
        return new i(this.f345b.getConstantState());
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicHeight() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getIntrinsicHeight() : (int) this.f346c.f361b.j;
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicWidth() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getIntrinsicWidth() : (int) this.f346c.f361b.i;
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            return drawable.getOpacity();
        }
        return -3;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void h(boolean z) {
        this.g = z;
    }

    @Override // android.graphics.drawable.Drawable
    public void inflate(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.inflate(resources, xmlPullParser, attributeSet);
        } else {
            inflate(resources, xmlPullParser, attributeSet, null);
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void inflate(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.g(drawable, resources, xmlPullParser, attributeSet, theme);
            return;
        }
        C0020h c0020h = this.f346c;
        c0020h.f361b = new g();
        TypedArray i2 = androidx.core.content.c.g.i(resources, theme, attributeSet, a.n.a.a.a.f329a);
        i(i2, xmlPullParser);
        i2.recycle();
        c0020h.f360a = getChangingConfigurations();
        c0020h.k = true;
        e(resources, xmlPullParser, attributeSet, theme);
        this.f347d = j(this.f347d, c0020h.f362c, c0020h.f363d);
    }

    @Override // android.graphics.drawable.Drawable
    public void invalidateSelf() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.invalidateSelf();
        } else {
            super.invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Drawable
    public boolean isAutoMirrored() {
        Drawable drawable = this.f345b;
        return drawable != null ? androidx.core.graphics.drawable.a.h(drawable) : this.f346c.e;
    }

    @Override // android.graphics.drawable.Drawable
    public boolean isStateful() {
        C0020h c0020h;
        ColorStateList colorStateList;
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.isStateful() : super.isStateful() || ((c0020h = this.f346c) != null && (c0020h.g() || ((colorStateList = this.f346c.f362c) != null && colorStateList.isStateful())));
    }

    PorterDuffColorFilter j(PorterDuffColorFilter porterDuffColorFilter, ColorStateList colorStateList, PorterDuff.Mode mode) {
        if (colorStateList == null || mode == null) {
            return null;
        }
        return new PorterDuffColorFilter(colorStateList.getColorForState(getState(), 0), mode);
    }

    @Override // android.graphics.drawable.Drawable
    public Drawable mutate() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.mutate();
            return this;
        }
        if (!this.f && super.mutate() == this) {
            this.f346c = new C0020h(this.f346c);
            this.f = true;
        }
        return this;
    }

    @Override // android.graphics.drawable.Drawable
    protected void onBoundsChange(Rect rect) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.setBounds(rect);
        }
    }

    @Override // android.graphics.drawable.Drawable
    protected boolean onStateChange(int[] iArr) {
        PorterDuff.Mode mode;
        Drawable drawable = this.f345b;
        if (drawable != null) {
            return drawable.setState(iArr);
        }
        boolean z = false;
        C0020h c0020h = this.f346c;
        ColorStateList colorStateList = c0020h.f362c;
        if (colorStateList != null && (mode = c0020h.f363d) != null) {
            this.f347d = j(this.f347d, colorStateList, mode);
            invalidateSelf();
            z = true;
        }
        if (c0020h.g() && c0020h.h(iArr)) {
            invalidateSelf();
            return true;
        }
        return z;
    }

    @Override // android.graphics.drawable.Drawable
    public void scheduleSelf(Runnable runnable, long j) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.scheduleSelf(runnable, j);
        } else {
            super.scheduleSelf(runnable, j);
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i2) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.setAlpha(i2);
        } else if (this.f346c.f361b.getRootAlpha() != i2) {
            this.f346c.f361b.setRootAlpha(i2);
            invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void setAutoMirrored(boolean z) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.j(drawable, z);
        } else {
            this.f346c.e = z;
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.setColorFilter(colorFilter);
            return;
        }
        this.e = colorFilter;
        invalidateSelf();
    }

    @Override // android.graphics.drawable.Drawable, androidx.core.graphics.drawable.b
    public void setTint(int i2) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.n(drawable, i2);
        } else {
            setTintList(ColorStateList.valueOf(i2));
        }
    }

    @Override // android.graphics.drawable.Drawable, androidx.core.graphics.drawable.b
    public void setTintList(ColorStateList colorStateList) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.o(drawable, colorStateList);
            return;
        }
        C0020h c0020h = this.f346c;
        if (c0020h.f362c != colorStateList) {
            c0020h.f362c = colorStateList;
            this.f347d = j(this.f347d, colorStateList, c0020h.f363d);
            invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Drawable, androidx.core.graphics.drawable.b
    public void setTintMode(PorterDuff.Mode mode) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.p(drawable, mode);
            return;
        }
        C0020h c0020h = this.f346c;
        if (c0020h.f363d != mode) {
            c0020h.f363d = mode;
            this.f347d = j(this.f347d, c0020h.f362c, mode);
            invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Drawable
    public boolean setVisible(boolean z, boolean z2) {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.setVisible(z, z2) : super.setVisible(z, z2);
    }

    @Override // android.graphics.drawable.Drawable
    public void unscheduleSelf(Runnable runnable) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.unscheduleSelf(runnable);
        } else {
            super.unscheduleSelf(runnable);
        }
    }
}
