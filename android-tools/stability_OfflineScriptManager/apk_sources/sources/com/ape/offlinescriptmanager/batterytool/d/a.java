package com.ape.offlinescriptmanager.batterytool.d;

import android.widget.BaseAdapter;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public abstract class a<T> extends BaseAdapter {

    /* renamed from: b  reason: collision with root package name */
    private List<T> f1898b;

    public a(List<T> list) {
        this.f1898b = new ArrayList();
        this.f1898b = list;
    }

    @Override // android.widget.Adapter
    public int getCount() {
        return this.f1898b.size();
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        return this.f1898b.get(i);
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }
}
