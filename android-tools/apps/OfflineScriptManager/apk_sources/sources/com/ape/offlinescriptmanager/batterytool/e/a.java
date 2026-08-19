package com.ape.offlinescriptmanager.batterytool.e;

import android.os.Bundle;
import android.view.View;
import android.widget.HorizontalScrollView;
import android.widget.TabHost;
import android.widget.Toolbar;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTabHost;
import androidx.viewpager.widget.ViewPager;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public abstract class a extends androidx.fragment.app.b implements ViewPager.j, TabHost.OnTabChangeListener {
    public Toolbar n;
    public FragmentTabHost o;
    public ViewPager p;
    public List<Fragment> q = new ArrayList();
    private HorizontalScrollView r;

    public abstract void B();

    @Override // androidx.viewpager.widget.ViewPager.j
    public void c(int i, float f, int i2) {
    }

    @Override // androidx.viewpager.widget.ViewPager.j
    public void f(int i) {
    }

    @Override // androidx.viewpager.widget.ViewPager.j
    public void j(int i) {
        this.o.setCurrentTab(i);
        View childAt = this.o.getTabWidget().getChildAt(i);
        this.r.scrollTo(((int) childAt.getX()) - (childAt.getWidth() / 2), (int) childAt.getY());
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_fragment_base);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        this.n = toolbar;
        toolbar.setTitle(R.string.app_name_string);
        setActionBar(this.n);
        this.r = (HorizontalScrollView) findViewById(R.id.horizontalScrollView);
        ViewPager viewPager = (ViewPager) findViewById(R.id.pager);
        this.p = viewPager;
        viewPager.c(this);
        FragmentTabHost fragmentTabHost = (FragmentTabHost) findViewById(16908306);
        this.o = fragmentTabHost;
        fragmentTabHost.g(this, s(), 16908305);
        this.o.setOnTabChangedListener(this);
        B();
    }

    @Override // android.widget.TabHost.OnTabChangeListener
    public void onTabChanged(String str) {
        this.p.setCurrentItem(this.o.getCurrentTab());
    }
}
