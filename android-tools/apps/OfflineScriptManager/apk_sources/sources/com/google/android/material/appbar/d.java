package com.google.android.material.appbar;

import a.f.l.r;
import android.view.View;
/* loaded from: classes.dex */
class d {

    /* renamed from: a  reason: collision with root package name */
    private final View f2285a;

    /* renamed from: b  reason: collision with root package name */
    private int f2286b;

    /* renamed from: c  reason: collision with root package name */
    private int f2287c;

    /* renamed from: d  reason: collision with root package name */
    private int f2288d;
    private int e;

    public d(View view) {
        this.f2285a = view;
    }

    private void e() {
        View view = this.f2285a;
        r.I(view, this.f2288d - (view.getTop() - this.f2286b));
        View view2 = this.f2285a;
        r.H(view2, this.e - (view2.getLeft() - this.f2287c));
    }

    public int a() {
        return this.f2288d;
    }

    public void b() {
        this.f2286b = this.f2285a.getTop();
        this.f2287c = this.f2285a.getLeft();
        e();
    }

    public boolean c(int i) {
        if (this.e != i) {
            this.e = i;
            e();
            return true;
        }
        return false;
    }

    public boolean d(int i) {
        if (this.f2288d != i) {
            this.f2288d = i;
            e();
            return true;
        }
        return false;
    }
}
