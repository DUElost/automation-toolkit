package org.achartengine.h;

import android.graphics.Color;
import android.graphics.Paint;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class e extends c {
    private boolean l;
    private Paint.Align o;
    private float p;
    private float q;
    private Paint.Align r;
    private int s;
    private boolean g = false;
    private List<a> h = new ArrayList();
    private org.achartengine.f.d i = org.achartengine.f.d.POINT;
    private float j = 1.0f;
    private float k = 1.0f;
    private int m = 100;
    private float n = 10.0f;

    /* loaded from: classes.dex */
    public static class a implements Serializable {

        /* renamed from: b  reason: collision with root package name */
        private final EnumC0120a f2805b;

        /* renamed from: c  reason: collision with root package name */
        private int f2806c = Color.argb(125, 0, 0, 200);

        /* renamed from: d  reason: collision with root package name */
        private int[] f2807d;

        /* renamed from: org.achartengine.h.e$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public enum EnumC0120a {
            NONE,
            BOUNDS_ALL,
            BOUNDS_BELOW,
            BOUNDS_ABOVE,
            BELOW,
            ABOVE;

            /* renamed from: values  reason: to resolve conflict with enum method */
            public static EnumC0120a[] valuesCustom() {
                EnumC0120a[] valuesCustom = values();
                int length = valuesCustom.length;
                EnumC0120a[] enumC0120aArr = new EnumC0120a[length];
                System.arraycopy(valuesCustom, 0, enumC0120aArr, 0, length);
                return enumC0120aArr;
            }
        }

        public a(EnumC0120a enumC0120a) {
            this.f2805b = enumC0120a;
        }

        public int a() {
            return this.f2806c;
        }

        public int[] b() {
            return this.f2807d;
        }

        public EnumC0120a c() {
            return this.f2805b;
        }

        public void d(int i) {
            this.f2806c = i;
        }
    }

    public e() {
        Paint.Align align = Paint.Align.CENTER;
        this.o = align;
        this.p = 5.0f;
        this.q = 10.0f;
        this.r = align;
        this.s = -3355444;
    }

    public void h(a aVar) {
        this.h.add(aVar);
    }

    public int i() {
        return this.s;
    }

    public Paint.Align j() {
        return this.r;
    }

    public float k() {
        return this.q;
    }

    public float l() {
        return this.p;
    }

    public Paint.Align m() {
        return this.o;
    }

    public float n() {
        return this.n;
    }

    public int o() {
        return this.m;
    }

    public a[] p() {
        return (a[]) this.h.toArray(new a[0]);
    }

    public float q() {
        return this.k;
    }

    public float r() {
        return this.j;
    }

    public org.achartengine.f.d s() {
        return this.i;
    }

    public boolean t() {
        return this.l;
    }

    public boolean u() {
        return this.g;
    }

    public void v(boolean z) {
        this.g = z;
    }

    public void w(float f) {
        this.k = f;
    }

    public void x(org.achartengine.f.d dVar) {
        this.i = dVar;
    }
}
