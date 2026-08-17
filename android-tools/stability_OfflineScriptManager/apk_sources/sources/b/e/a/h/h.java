package b.e.a.h;

import java.util.Date;
/* loaded from: classes.dex */
public class h implements Cloneable {

    /* renamed from: b  reason: collision with root package name */
    private String f1533b = "eng";

    /* renamed from: c  reason: collision with root package name */
    private long f1534c;

    /* renamed from: d  reason: collision with root package name */
    private Date f1535d;
    private b.e.a.j.h e;
    private double f;
    private double g;
    private float h;
    private long i;
    private int j;
    int k;

    public h() {
        new Date();
        this.f1535d = new Date();
        this.e = b.e.a.j.h.j;
        this.i = 1L;
        this.j = 0;
    }

    public Date a() {
        return this.f1535d;
    }

    public int b() {
        return this.j;
    }

    public double c() {
        return this.g;
    }

    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException unused) {
            return null;
        }
    }

    public String d() {
        return this.f1533b;
    }

    public int e() {
        return this.k;
    }

    public b.e.a.j.h f() {
        return this.e;
    }

    public long g() {
        return this.f1534c;
    }

    public long h() {
        return this.i;
    }

    public float i() {
        return this.h;
    }

    public double j() {
        return this.f;
    }

    public void k(Date date) {
        this.f1535d = date;
    }

    public void l(double d2) {
        this.g = d2;
    }

    public void m(String str) {
        this.f1533b = str;
    }

    public void n(int i) {
        this.k = i;
    }

    public void o(b.e.a.j.h hVar) {
        this.e = hVar;
    }

    public void p(Date date) {
    }

    public void q(long j) {
        this.f1534c = j;
    }

    public void r(long j) {
        this.i = j;
    }

    public void s(float f) {
        this.h = f;
    }

    public void t(double d2) {
        this.f = d2;
    }
}
