package com.ape.offlinescriptmanager.screenrecorder.e;

import android.graphics.Bitmap;
import android.net.Uri;
import java.util.Date;
/* loaded from: classes.dex */
public class a implements Comparable<a> {

    /* renamed from: b  reason: collision with root package name */
    private String f2032b;

    /* renamed from: c  reason: collision with root package name */
    private Uri f2033c;

    /* renamed from: d  reason: collision with root package name */
    private Bitmap f2034d;
    private Date e;
    private boolean f;

    public a(String str, Uri uri, Bitmap bitmap, Date date) {
        this.f = false;
        this.f2032b = str;
        this.f2033c = uri;
        this.f2034d = bitmap;
        this.e = date;
    }

    public a(boolean z, Date date) {
        this.f = false;
        this.f = z;
        this.e = date;
    }

    @Override // java.lang.Comparable
    /* renamed from: a */
    public int compareTo(a aVar) {
        return d().compareTo(aVar.d());
    }

    public Uri b() {
        return this.f2033c;
    }

    public String c() {
        return this.f2032b;
    }

    public Date d() {
        return this.e;
    }

    public Bitmap e() {
        return this.f2034d;
    }

    public boolean f() {
        return this.f;
    }
}
