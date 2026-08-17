package com.github.johnkil.print;

import android.graphics.Typeface;
/* loaded from: classes.dex */
public class a {

    /* renamed from: c  reason: collision with root package name */
    private static a f2255c;

    /* renamed from: a  reason: collision with root package name */
    private final Typeface f2256a;

    /* renamed from: b  reason: collision with root package name */
    private final boolean f2257b;

    private a() {
        this(null);
    }

    private a(Typeface typeface) {
        this.f2256a = typeface;
        this.f2257b = typeface != null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static a a() {
        if (f2255c == null) {
            f2255c = new a();
        }
        return f2255c;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Typeface b() {
        return this.f2256a;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean c() {
        return this.f2257b;
    }
}
