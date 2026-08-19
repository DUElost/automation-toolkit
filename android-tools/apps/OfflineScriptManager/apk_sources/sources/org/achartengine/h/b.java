package org.achartengine.h;

import android.graphics.Typeface;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class b implements Serializable {
    private static final Typeface I = Typeface.create(Typeface.SERIF, 0);
    private boolean H;
    private Typeface f;
    private int g;
    private boolean h;

    /* renamed from: b  reason: collision with root package name */
    private String f2796b = BuildConfig.FLAVOR;

    /* renamed from: c  reason: collision with root package name */
    private float f2797c = 15.0f;

    /* renamed from: d  reason: collision with root package name */
    private String f2798d = I.toString();
    private int e = 0;
    private boolean i = true;
    private int j = -3355444;
    private int k = -3355444;
    private boolean l = true;
    private boolean m = true;
    private int n = -3355444;
    private float o = 10.0f;
    private boolean p = true;
    private float q = 12.0f;
    private boolean r = false;
    private boolean s = false;
    private boolean t = false;
    private boolean u = false;
    private boolean v = false;
    private List<c> w = new ArrayList();
    private boolean x = true;
    private int y = 0;
    private int[] z = {20, 30, 10, 20};
    private float A = 1.0f;
    private boolean B = false;
    private float C = 1.5f;
    private boolean D = false;
    private float E = 1.0f;
    private boolean F = false;
    private int G = 15;

    public boolean A() {
        throw null;
    }

    public boolean B() {
        return this.i;
    }

    public boolean C() {
        return this.u;
    }

    public boolean D() {
        return this.v;
    }

    public boolean E() {
        return this.s;
    }

    public boolean F() {
        return this.t;
    }

    public boolean G() {
        return this.l;
    }

    public boolean H() {
        return this.p;
    }

    public boolean I() {
        return this.m;
    }

    public boolean J() {
        return this.B;
    }

    public boolean K() {
        throw null;
    }

    public void L(boolean z) {
        this.h = z;
    }

    public void M(int i) {
        a0(i);
        b0(i);
    }

    public void N(int i) {
        this.g = i;
    }

    public void O(String str) {
        this.f2796b = str;
    }

    public void P(float f) {
        this.f2797c = f;
    }

    public void Q(int i) {
        this.n = i;
    }

    public void R(float f) {
        this.o = f;
    }

    public void S(float f) {
        this.q = f;
    }

    public void T(int[] iArr) {
        this.z = iArr;
    }

    public void U(float f) {
        this.A = f;
    }

    public void V(boolean z) {
        this.i = z;
    }

    public void W(boolean z) {
        X(z);
        Y(z);
    }

    public void X(boolean z) {
        this.s = z;
    }

    public void Y(boolean z) {
        this.t = z;
    }

    public void Z(boolean z) {
        this.l = z;
    }

    public void a(c cVar) {
        this.w.add(cVar);
    }

    public void a0(int i) {
        this.k = i;
    }

    public int b() {
        return this.g;
    }

    public void b0(int i) {
        this.j = i;
    }

    public String c() {
        return this.f2796b;
    }

    public void c0(boolean z) {
        this.B = z;
    }

    public float d() {
        return this.f2797c;
    }

    public int e() {
        return this.n;
    }

    public float f() {
        return this.o;
    }

    public int g() {
        return this.y;
    }

    public float h() {
        return this.q;
    }

    public int[] i() {
        return this.z;
    }

    public float j() {
        return this.E;
    }

    public float k() {
        return this.A;
    }

    public int l() {
        return this.G;
    }

    public c m(int i) {
        return this.w.get(i);
    }

    public int n() {
        return this.w.size();
    }

    public Typeface o() {
        return this.f;
    }

    public String p() {
        return this.f2798d;
    }

    public int q() {
        return this.e;
    }

    public int r() {
        return this.k;
    }

    public int s() {
        return this.j;
    }

    public float t() {
        return this.C;
    }

    public boolean u() {
        return this.x;
    }

    public boolean v() {
        return this.h;
    }

    public boolean w() {
        return this.F;
    }

    public boolean x() {
        return this.D;
    }

    public boolean y() {
        return this.r;
    }

    public boolean z() {
        return this.H;
    }
}
