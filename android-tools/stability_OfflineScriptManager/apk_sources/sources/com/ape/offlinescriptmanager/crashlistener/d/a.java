package com.ape.offlinescriptmanager.crashlistener.d;

import android.graphics.Bitmap;
import android.net.Uri;
import java.util.Date;
/* loaded from: classes.dex */
public class a implements Comparable<a> {

    /* renamed from: b  reason: collision with root package name */
    private String f1960b;

    /* renamed from: c  reason: collision with root package name */
    private Uri f1961c;

    /* renamed from: d  reason: collision with root package name */
    private Bitmap f1962d;
    private Date e;
    private boolean f;

    public a(String str, Uri uri, Bitmap bitmap, Date date) {
        this.f = false;
        this.f1960b = str;
        this.f1961c = uri;
        this.f1962d = bitmap;
        this.e = date;
    }

    public a(boolean z, Date date) {
        this.f = false;
        this.f = z;
        this.e = date;
    }

    public boolean a() {
        return this.f;
    }

    @Override // java.lang.Comparable
    /* renamed from: b */
    public int compareTo(a aVar) {
        return e().compareTo(aVar.e());
    }

    public Uri c() {
        return this.f1961c;
    }

    public String d() {
        return this.f1960b;
    }

    public Date e() {
        return this.e;
    }

    public Bitmap f() {
        return this.f1962d;
    }
}
