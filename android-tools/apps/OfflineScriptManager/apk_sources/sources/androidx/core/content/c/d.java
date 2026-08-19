package androidx.core.content.c;

import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.LinearGradient;
import android.graphics.RadialGradient;
import android.graphics.Shader;
import android.graphics.SweepGradient;
import android.util.AttributeSet;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class d {

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static final class a {

        /* renamed from: a  reason: collision with root package name */
        final int[] f872a;

        /* renamed from: b  reason: collision with root package name */
        final float[] f873b;

        a(int i, int i2) {
            this.f872a = new int[]{i, i2};
            this.f873b = new float[]{0.0f, 1.0f};
        }

        a(int i, int i2, int i3) {
            this.f872a = new int[]{i, i2, i3};
            this.f873b = new float[]{0.0f, 0.5f, 1.0f};
        }

        a(List<Integer> list, List<Float> list2) {
            int size = list.size();
            this.f872a = new int[size];
            this.f873b = new float[size];
            for (int i = 0; i < size; i++) {
                this.f872a[i] = list.get(i).intValue();
                this.f873b[i] = list2.get(i).floatValue();
            }
        }
    }

    private static a a(a aVar, int i, int i2, boolean z, int i3) {
        return aVar != null ? aVar : z ? new a(i, i3, i2) : new a(i, i2);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static Shader b(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        String name = xmlPullParser.getName();
        if (!name.equals("gradient")) {
            throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": invalid gradient color tag " + name);
        }
        TypedArray i = g.i(resources, theme, attributeSet, a.f.d.GradientColor);
        float d2 = g.d(i, xmlPullParser, "startX", a.f.d.GradientColor_android_startX, 0.0f);
        float d3 = g.d(i, xmlPullParser, "startY", a.f.d.GradientColor_android_startY, 0.0f);
        float d4 = g.d(i, xmlPullParser, "endX", a.f.d.GradientColor_android_endX, 0.0f);
        float d5 = g.d(i, xmlPullParser, "endY", a.f.d.GradientColor_android_endY, 0.0f);
        float d6 = g.d(i, xmlPullParser, "centerX", a.f.d.GradientColor_android_centerX, 0.0f);
        float d7 = g.d(i, xmlPullParser, "centerY", a.f.d.GradientColor_android_centerY, 0.0f);
        int e = g.e(i, xmlPullParser, "type", a.f.d.GradientColor_android_type, 0);
        int b2 = g.b(i, xmlPullParser, "startColor", a.f.d.GradientColor_android_startColor, 0);
        boolean h = g.h(xmlPullParser, "centerColor");
        int b3 = g.b(i, xmlPullParser, "centerColor", a.f.d.GradientColor_android_centerColor, 0);
        int b4 = g.b(i, xmlPullParser, "endColor", a.f.d.GradientColor_android_endColor, 0);
        int e2 = g.e(i, xmlPullParser, "tileMode", a.f.d.GradientColor_android_tileMode, 0);
        float d8 = g.d(i, xmlPullParser, "gradientRadius", a.f.d.GradientColor_android_gradientRadius, 0.0f);
        i.recycle();
        a a2 = a(c(resources, xmlPullParser, attributeSet, theme), b2, b4, h, b3);
        if (e != 1) {
            return e != 2 ? new LinearGradient(d2, d3, d4, d5, a2.f872a, a2.f873b, d(e2)) : new SweepGradient(d6, d7, a2.f872a, a2.f873b);
        } else if (d8 > 0.0f) {
            return new RadialGradient(d6, d7, d8, a2.f872a, a2.f873b, d(e2));
        } else {
            throw new org.xmlpull.v1.a("<gradient> tag requires 'gradientRadius' attribute with radial type");
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:21:0x0085, code lost:
        throw new org.xmlpull.v1.a(r10.getPositionDescription() + ": <item> tag requires a 'color' attribute and a 'offset' attribute!");
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static androidx.core.content.c.d.a c(android.content.res.Resources r9, org.xmlpull.v1.XmlPullParser r10, android.util.AttributeSet r11, android.content.res.Resources.Theme r12) {
        /*
            int r0 = r10.getDepth()
            r1 = 1
            int r0 = r0 + r1
            java.util.ArrayList r2 = new java.util.ArrayList
            r3 = 20
            r2.<init>(r3)
            java.util.ArrayList r4 = new java.util.ArrayList
            r4.<init>(r3)
        L12:
            int r3 = r10.next()
            if (r3 == r1) goto L86
            int r5 = r10.getDepth()
            if (r5 >= r0) goto L21
            r6 = 3
            if (r3 == r6) goto L86
        L21:
            r6 = 2
            if (r3 == r6) goto L25
            goto L12
        L25:
            if (r5 > r0) goto L12
            java.lang.String r3 = r10.getName()
            java.lang.String r5 = "item"
            boolean r3 = r3.equals(r5)
            if (r3 != 0) goto L34
            goto L12
        L34:
            int[] r3 = a.f.d.GradientColorItem
            android.content.res.TypedArray r3 = androidx.core.content.c.g.i(r9, r12, r11, r3)
            int r5 = a.f.d.GradientColorItem_android_color
            boolean r6 = r3.hasValue(r5)
            int r7 = a.f.d.GradientColorItem_android_offset
            boolean r8 = r3.hasValue(r7)
            if (r6 == 0) goto L66
            if (r8 == 0) goto L66
            r6 = 0
            int r5 = r3.getColor(r5, r6)
            r6 = 0
            float r6 = r3.getFloat(r7, r6)
            r3.recycle()
            java.lang.Integer r3 = java.lang.Integer.valueOf(r5)
            r4.add(r3)
            java.lang.Float r3 = java.lang.Float.valueOf(r6)
            r2.add(r3)
            goto L12
        L66:
            org.xmlpull.v1.a r9 = new org.xmlpull.v1.a
            java.lang.StringBuilder r11 = new java.lang.StringBuilder
            r11.<init>()
            java.lang.String r10 = r10.getPositionDescription()
            r11.append(r10)
            java.lang.String r10 = ": <item> tag requires a 'color' attribute and a 'offset' "
            r11.append(r10)
            java.lang.String r10 = "attribute!"
            r11.append(r10)
            java.lang.String r10 = r11.toString()
            r9.<init>(r10)
            throw r9
        L86:
            int r9 = r4.size()
            if (r9 <= 0) goto L92
            androidx.core.content.c.d$a r9 = new androidx.core.content.c.d$a
            r9.<init>(r4, r2)
            return r9
        L92:
            r9 = 0
            return r9
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.core.content.c.d.c(android.content.res.Resources, org.xmlpull.v1.XmlPullParser, android.util.AttributeSet, android.content.res.Resources$Theme):androidx.core.content.c.d$a");
    }

    private static Shader.TileMode d(int i) {
        return i != 1 ? i != 2 ? Shader.TileMode.CLAMP : Shader.TileMode.MIRROR : Shader.TileMode.REPEAT;
    }
}
