package com.afollestad.materialdialogs.internal;

import android.content.res.ColorStateList;
import android.graphics.drawable.Drawable;
import b.a.a.e;
/* loaded from: classes.dex */
public class d {
    private static d w;

    /* renamed from: a  reason: collision with root package name */
    public boolean f1872a = false;

    /* renamed from: b  reason: collision with root package name */
    public int f1873b = 0;

    /* renamed from: c  reason: collision with root package name */
    public int f1874c = 0;

    /* renamed from: d  reason: collision with root package name */
    public ColorStateList f1875d = null;
    public ColorStateList e = null;
    public ColorStateList f = null;
    public int g = 0;
    public int h = 0;
    public Drawable i = null;
    public int j = 0;
    public int k = 0;
    public ColorStateList l = null;
    public int m = 0;
    public int n = 0;
    public int o = 0;
    public int p = 0;
    public int q = 0;
    public e r;
    public e s;
    public e t;
    public e u;
    public e v;

    public d() {
        e eVar = e.START;
        this.r = eVar;
        this.s = eVar;
        this.t = e.END;
        this.u = eVar;
        this.v = eVar;
    }

    public static d a() {
        return b(true);
    }

    public static d b(boolean z) {
        if (w == null && z) {
            w = new d();
        }
        return w;
    }
}
