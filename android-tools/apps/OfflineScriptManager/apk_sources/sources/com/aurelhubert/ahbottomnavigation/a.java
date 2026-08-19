package com.aurelhubert.ahbottomnavigation;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a {

    /* renamed from: b  reason: collision with root package name */
    private Drawable f2239b;

    /* renamed from: d  reason: collision with root package name */
    private int f2241d;
    private int e;
    private int f;

    /* renamed from: a  reason: collision with root package name */
    private String f2238a = BuildConfig.FLAVOR;

    /* renamed from: c  reason: collision with root package name */
    private int f2240c = -7829368;

    public a(int i, int i2, int i3) {
        this.f2241d = 0;
        this.e = 0;
        this.f = 0;
        this.f2241d = i;
        this.e = i2;
        this.f = i3;
    }

    public int a(Context context) {
        int i = this.f;
        return i != 0 ? androidx.core.content.a.b(context, i) : this.f2240c;
    }

    public Drawable b(Context context) {
        if (this.e != 0) {
            try {
                return a.n.a.a.h.b(context.getResources(), this.e, null);
            } catch (Resources.NotFoundException unused) {
                return androidx.core.content.a.d(context, this.e);
            }
        }
        return this.f2239b;
    }

    public String c(Context context) {
        int i = this.f2241d;
        return i != 0 ? context.getString(i) : this.f2238a;
    }
}
