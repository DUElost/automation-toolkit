package org.achartengine.h;

import android.graphics.Color;
import android.graphics.Paint;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class d extends b {
    private String J;
    private String[] K;
    private float L;
    private double[] M;
    private double[] N;
    private double[] O;
    private double[] P;
    private int Q;
    private int R;
    private a S;
    private Map<Double, String> T;
    private Map<Integer, Map<Double, String>> U;
    private boolean V;
    private boolean W;
    private boolean X;
    private boolean Y;
    private int Z;
    private double[] a0;
    private double[] b0;
    private float c0;
    private float d0;
    private Map<Integer, double[]> e0;
    private float f0;
    private int[] g0;
    private int h0;
    private Paint.Align i0;
    private Paint.Align[] j0;
    private float k0;
    private float l0;
    private float m0;
    private Paint.Align[] n0;
    private int o0;
    private int[] p0;
    private boolean q0;
    private NumberFormat r0;
    private double s0;
    private double t0;

    /* loaded from: classes.dex */
    public enum a {
        HORIZONTAL(0),
        VERTICAL(90);
        

        /* renamed from: b  reason: collision with root package name */
        private int f2804b;

        a(int i) {
            this.f2804b = 0;
            this.f2804b = i;
        }

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static a[] valuesCustom() {
            a[] valuesCustom = values();
            int length = valuesCustom.length;
            a[] aVarArr = new a[length];
            System.arraycopy(valuesCustom, 0, aVarArr, 0, length);
            return aVarArr;
        }

        public int a() {
            return this.f2804b;
        }
    }

    public d() {
        this(1);
    }

    public d(int i) {
        this.J = BuildConfig.FLAVOR;
        this.L = 12.0f;
        this.Q = 5;
        this.R = 5;
        this.S = a.HORIZONTAL;
        this.T = new HashMap();
        this.U = new LinkedHashMap();
        this.V = true;
        this.W = true;
        this.X = true;
        this.Y = true;
        this.Z = 0;
        this.e0 = new LinkedHashMap();
        this.f0 = 3.0f;
        this.i0 = Paint.Align.CENTER;
        this.k0 = 0.0f;
        this.l0 = 0.0f;
        this.m0 = 2.0f;
        this.o0 = -3355444;
        this.p0 = new int[]{-3355444};
        this.q0 = true;
        this.s0 = 0.0d;
        this.t0 = 0.0d;
        this.h0 = i;
        N0(i);
    }

    @Override // org.achartengine.h.b
    public boolean A() {
        return V0() || W0();
    }

    public int A0() {
        return this.R;
    }

    public Paint.Align B0(int i) {
        return this.j0[i];
    }

    public float C0() {
        return this.d0;
    }

    public int D0(int i) {
        return this.p0[i];
    }

    public float E0() {
        return this.l0;
    }

    public float F0() {
        return this.m0;
    }

    public synchronized String G0(Double d2, int i) {
        return this.U.get(Integer.valueOf(i)).get(d2);
    }

    public synchronized Double[] H0(int i) {
        return (Double[]) this.U.get(Integer.valueOf(i)).keySet().toArray(new Double[0]);
    }

    public String I0() {
        return J0(0);
    }

    public String J0(int i) {
        return this.K[i];
    }

    @Override // org.achartengine.h.b
    public boolean K() {
        return Y0() || Z0();
    }

    public double K0() {
        return this.s0;
    }

    public double L0() {
        return this.t0;
    }

    public double[] M0() {
        return this.b0;
    }

    public void N0(int i) {
        this.K = new String[i];
        this.j0 = new Paint.Align[i];
        this.n0 = new Paint.Align[i];
        this.p0 = new int[i];
        this.M = new double[i];
        this.N = new double[i];
        this.O = new double[i];
        this.P = new double[i];
        this.g0 = new int[i];
        for (int i2 = 0; i2 < i; i2++) {
            this.p0[i2] = -3355444;
            this.g0[i2] = Color.argb(75, 200, 200, 200);
            O0(i2);
        }
    }

    public void O0(int i) {
        double[] dArr = this.M;
        dArr[i] = Double.MAX_VALUE;
        double[] dArr2 = this.N;
        dArr2[i] = -1.7976931348623157E308d;
        double[] dArr3 = this.O;
        dArr3[i] = Double.MAX_VALUE;
        double[] dArr4 = this.P;
        dArr4[i] = -1.7976931348623157E308d;
        this.e0.put(Integer.valueOf(i), new double[]{dArr[i], dArr2[i], dArr3[i], dArr4[i]});
        this.K[i] = BuildConfig.FLAVOR;
        this.U.put(Integer.valueOf(i), new HashMap());
        this.j0[i] = Paint.Align.CENTER;
        this.n0[i] = Paint.Align.LEFT;
    }

    public boolean P0() {
        return Q0(0);
    }

    public boolean Q0(int i) {
        return this.e0.get(Integer.valueOf(i)) != null;
    }

    public boolean R0(int i) {
        return this.N[i] != -1.7976931348623157E308d;
    }

    public boolean S0(int i) {
        return this.P[i] != -1.7976931348623157E308d;
    }

    public boolean T0(int i) {
        return this.M[i] != Double.MAX_VALUE;
    }

    public boolean U0(int i) {
        return this.O[i] != Double.MAX_VALUE;
    }

    public boolean V0() {
        return this.V;
    }

    public boolean W0() {
        return this.W;
    }

    public boolean X0() {
        return this.q0;
    }

    public boolean Y0() {
        return this.X;
    }

    public boolean Z0() {
        return this.Y;
    }

    public void a1(float f) {
        this.L = f;
    }

    public void b1(int i) {
        c1(i, 0);
    }

    public void c1(int i, int i2) {
        this.g0[i2] = i;
    }

    public synchronized void d0(double d2, String str) {
        this.T.put(Double.valueOf(d2), str);
    }

    public void d1(int i) {
        this.Z = i;
    }

    public float e0() {
        return this.L;
    }

    public void e1(boolean z, boolean z2) {
        this.V = z;
        this.W = z2;
    }

    public int f0(int i) {
        return this.g0[i];
    }

    public void f1(float f) {
        this.f0 = f;
    }

    public double[] g0(int i) {
        return this.e0.get(Integer.valueOf(i));
    }

    public void g1(double[] dArr, int i) {
        k1(dArr[0], i);
        i1(dArr[1], i);
        s1(dArr[2], i);
        q1(dArr[3], i);
    }

    public NumberFormat h0() {
        return this.r0;
    }

    public void h1(double d2) {
        i1(d2, 0);
    }

    public int i0() {
        return this.Z;
    }

    public void i1(double d2, int i) {
        if (!R0(i)) {
            this.e0.get(Integer.valueOf(i))[1] = d2;
        }
        this.N[i] = d2;
    }

    public a j0() {
        return this.S;
    }

    public void j1(double d2) {
        k1(d2, 0);
    }

    public double[] k0() {
        return this.a0;
    }

    public void k1(double d2, int i) {
        if (!T0(i)) {
            this.e0.get(Integer.valueOf(i))[0] = d2;
        }
        this.M[i] = d2;
    }

    public float l0() {
        return this.f0;
    }

    public void l1(int i) {
        this.Q = i;
    }

    public int m0() {
        return this.h0;
    }

    public void m1(int i) {
        this.o0 = i;
    }

    public double n0(int i) {
        return this.N[i];
    }

    public void n1(boolean z) {
        this.q0 = z;
    }

    public double o0(int i) {
        return this.M[i];
    }

    public void o1(String str) {
        this.J = str;
    }

    public int p0() {
        return this.Q;
    }

    public void p1(double d2) {
        q1(d2, 0);
    }

    public Paint.Align q0() {
        return this.i0;
    }

    public void q1(double d2, int i) {
        if (!S0(i)) {
            this.e0.get(Integer.valueOf(i))[3] = d2;
        }
        this.P[i] = d2;
    }

    public float r0() {
        return this.c0;
    }

    public void r1(double d2) {
        s1(d2, 0);
    }

    public int s0() {
        return this.o0;
    }

    public void s1(double d2, int i) {
        if (!U0(i)) {
            this.e0.get(Integer.valueOf(i))[2] = d2;
        }
        this.O[i] = d2;
    }

    public float t0() {
        return this.k0;
    }

    public void t1(int i) {
        this.R = i;
    }

    public synchronized String u0(Double d2) {
        return this.T.get(d2);
    }

    public void u1(Paint.Align align) {
        v1(align, 0);
    }

    public synchronized Double[] v0() {
        return (Double[]) this.T.keySet().toArray(new Double[0]);
    }

    public void v1(Paint.Align align, int i) {
        this.j0[i] = align;
    }

    public String w0() {
        return this.J;
    }

    public void w1(int i, int i2) {
        this.p0[i] = i2;
    }

    public Paint.Align x0(int i) {
        return this.n0[i];
    }

    public void x1(String str) {
        y1(str, 0);
    }

    public double y0(int i) {
        return this.P[i];
    }

    public void y1(String str, int i) {
        this.K[i] = str;
    }

    public double z0(int i) {
        return this.O[i];
    }

    public void z1(boolean z, boolean z2) {
        this.X = z;
        this.Y = z2;
    }
}
