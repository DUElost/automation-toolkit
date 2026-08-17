package com.ape.offlinescriptmanager.batterytool.e;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.f;
import androidx.fragment.app.i;
import java.util.List;
/* loaded from: classes.dex */
public class b extends i {
    List<Fragment> e;

    public b(f fVar, List<Fragment> list) {
        super(fVar);
        this.e = list;
    }

    @Override // androidx.viewpager.widget.a
    public int c() {
        return this.e.size();
    }

    @Override // androidx.fragment.app.i
    public Fragment p(int i) {
        return this.e.get(i);
    }
}
