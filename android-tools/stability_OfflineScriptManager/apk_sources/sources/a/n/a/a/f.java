package a.n.a.a;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Path;
import android.graphics.PathMeasure;
import android.util.AttributeSet;
import android.view.InflateException;
import android.view.animation.Interpolator;
import org.xmlpull.v1.XmlPullParser;
/* loaded from: classes.dex */
public class f implements Interpolator {

    /* renamed from: a  reason: collision with root package name */
    private float[] f343a;

    /* renamed from: b  reason: collision with root package name */
    private float[] f344b;

    public f(Context context, AttributeSet attributeSet, XmlPullParser xmlPullParser) {
        this(context.getResources(), context.getTheme(), attributeSet, xmlPullParser);
    }

    public f(Resources resources, Resources.Theme theme, AttributeSet attributeSet, XmlPullParser xmlPullParser) {
        TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, a.l);
        d(i, xmlPullParser);
        i.recycle();
    }

    private void a(float f, float f2, float f3, float f4) {
        Path path = new Path();
        path.moveTo(0.0f, 0.0f);
        path.cubicTo(f, f2, f3, f4, 1.0f, 1.0f);
        b(path);
    }

    private void b(Path path) {
        int i = 0;
        PathMeasure pathMeasure = new PathMeasure(path, false);
        float length = pathMeasure.getLength();
        int min = Math.min(3000, ((int) (length / 0.002f)) + 1);
        if (min <= 0) {
            throw new IllegalArgumentException("The Path has a invalid length " + length);
        }
        this.f343a = new float[min];
        this.f344b = new float[min];
        float[] fArr = new float[2];
        for (int i2 = 0; i2 < min; i2++) {
            pathMeasure.getPosTan((i2 * length) / (min - 1), fArr, null);
            this.f343a[i2] = fArr[0];
            this.f344b[i2] = fArr[1];
        }
        if (Math.abs(this.f343a[0]) <= 1.0E-5d && Math.abs(this.f344b[0]) <= 1.0E-5d) {
            int i3 = min - 1;
            if (Math.abs(this.f343a[i3] - 1.0f) <= 1.0E-5d && Math.abs(this.f344b[i3] - 1.0f) <= 1.0E-5d) {
                float f = 0.0f;
                int i4 = 0;
                while (i < min) {
                    float[] fArr2 = this.f343a;
                    int i5 = i4 + 1;
                    float f2 = fArr2[i4];
                    if (f2 < f) {
                        throw new IllegalArgumentException("The Path cannot loop back on itself, x :" + f2);
                    }
                    fArr2[i] = f2;
                    i++;
                    f = f2;
                    i4 = i5;
                }
                if (pathMeasure.nextContour()) {
                    throw new IllegalArgumentException("The Path should be continuous, can't have 2+ contours");
                }
                return;
            }
        }
        StringBuilder sb = new StringBuilder();
        sb.append("The Path must start at (0,0) and end at (1,1) start: ");
        sb.append(this.f343a[0]);
        sb.append(",");
        sb.append(this.f344b[0]);
        sb.append(" end:");
        int i6 = min - 1;
        sb.append(this.f343a[i6]);
        sb.append(",");
        sb.append(this.f344b[i6]);
        throw new IllegalArgumentException(sb.toString());
    }

    private void c(float f, float f2) {
        Path path = new Path();
        path.moveTo(0.0f, 0.0f);
        path.quadTo(f, f2, 1.0f, 1.0f);
        b(path);
    }

    private void d(TypedArray typedArray, XmlPullParser xmlPullParser) {
        if (androidx.core.content.c.g.h(xmlPullParser, "pathData")) {
            String g = androidx.core.content.c.g.g(typedArray, xmlPullParser, "pathData", 4);
            Path e = a.f.e.b.e(g);
            if (e != null) {
                b(e);
                return;
            }
            throw new InflateException("The path is null, which is created from " + g);
        } else if (!androidx.core.content.c.g.h(xmlPullParser, "controlX1")) {
            throw new InflateException("pathInterpolator requires the controlX1 attribute");
        } else {
            if (!androidx.core.content.c.g.h(xmlPullParser, "controlY1")) {
                throw new InflateException("pathInterpolator requires the controlY1 attribute");
            }
            float d2 = androidx.core.content.c.g.d(typedArray, xmlPullParser, "controlX1", 0, 0.0f);
            float d3 = androidx.core.content.c.g.d(typedArray, xmlPullParser, "controlY1", 1, 0.0f);
            boolean h = androidx.core.content.c.g.h(xmlPullParser, "controlX2");
            if (h != androidx.core.content.c.g.h(xmlPullParser, "controlY2")) {
                throw new InflateException("pathInterpolator requires both controlX2 and controlY2 for cubic Beziers.");
            }
            if (h) {
                a(d2, d3, androidx.core.content.c.g.d(typedArray, xmlPullParser, "controlX2", 2, 0.0f), androidx.core.content.c.g.d(typedArray, xmlPullParser, "controlY2", 3, 0.0f));
            } else {
                c(d2, d3);
            }
        }
    }

    @Override // android.animation.TimeInterpolator
    public float getInterpolation(float f) {
        if (f <= 0.0f) {
            return 0.0f;
        }
        if (f >= 1.0f) {
            return 1.0f;
        }
        int i = 0;
        int length = this.f343a.length - 1;
        while (length - i > 1) {
            int i2 = (i + length) / 2;
            if (f < this.f343a[i2]) {
                length = i2;
            } else {
                i = i2;
            }
        }
        float[] fArr = this.f343a;
        float f2 = fArr[length] - fArr[i];
        if (f2 == 0.0f) {
            return this.f344b[i];
        }
        float[] fArr2 = this.f344b;
        float f3 = fArr2[i];
        return f3 + (((f - fArr[i]) / f2) * (fArr2[length] - f3));
    }
}
