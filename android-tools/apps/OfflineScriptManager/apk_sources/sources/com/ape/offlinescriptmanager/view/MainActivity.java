package com.ape.offlinescriptmanager.view;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import androidx.appcompat.widget.Toolbar;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.f;
import androidx.fragment.app.i;
import androidx.viewpager.widget.ViewPager;
import com.aurelhubert.ahbottomnavigation.AHBottomNavigation;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
import xcrash.j;
/* loaded from: classes.dex */
public class MainActivity extends androidx.appcompat.app.c implements Toolbar.f, b.b.a.b.a {
    private static final String x = MainActivity.class.getSimpleName();
    private ViewPager q;
    private AHBottomNavigation r;
    private Toolbar s;
    private Fragment t;
    private Fragment u;
    private String v = "tab_task";
    private String w = "tab_result";

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements ViewPager.j {
        a() {
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void c(int i, float f, int i2) {
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void f(int i) {
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void j(int i) {
            String str = MainActivity.x;
            Log.i(str, "onPageSelected = " + i);
            MainActivity.this.r.m(i, false);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements AHBottomNavigation.g {
        b() {
        }

        @Override // com.aurelhubert.ahbottomnavigation.AHBottomNavigation.g
        public boolean a(int i, boolean z) {
            String str = MainActivity.x;
            Log.i(str, "onTabSelected = " + i + " wasSelected = " + z);
            if (z) {
                return true;
            }
            MainActivity.this.q.setCurrentItem(i);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class c extends i {
        private List<Fragment> e;

        public c(f fVar, List<Fragment> list) {
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

    private List<Fragment> O(Bundle bundle) {
        Fragment d2;
        ArrayList arrayList = new ArrayList();
        if (bundle == null) {
            this.t = com.ape.offlinescriptmanager.view.c.b.m1();
            d2 = com.ape.offlinescriptmanager.view.b.a.m1();
        } else {
            this.t = s().d(bundle.getString(this.v));
            d2 = s().d(bundle.getString(this.w));
        }
        this.u = d2;
        arrayList.add(this.t);
        arrayList.add(this.u);
        return arrayList;
    }

    private void P() {
        this.r = (AHBottomNavigation) findViewById(R.id.main_bottom_navigation);
        ArrayList arrayList = new ArrayList();
        com.aurelhubert.ahbottomnavigation.a aVar = new com.aurelhubert.ahbottomnavigation.a(R.string.task, R.drawable.ic_reorder_white_24dp, R.color.accent);
        com.aurelhubert.ahbottomnavigation.a aVar2 = new com.aurelhubert.ahbottomnavigation.a(R.string.result, R.drawable.ic_assignment_white_24dp, R.color.accent);
        arrayList.add(aVar);
        arrayList.add(aVar2);
        this.r.f(arrayList);
        this.r.setDefaultBackgroundColor(androidx.core.content.a.b(this, R.color.white));
        this.r.setAccentColor(androidx.core.content.a.b(this, R.color.accent));
        this.r.setInactiveColor(androidx.core.content.a.b(this, R.color.accent_pressed));
        this.r.setOnTabSelectedListener(new b());
    }

    private void Q(Bundle bundle) {
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        this.s = toolbar;
        I(toolbar);
        this.s.setOnMenuItemClickListener(this);
        P();
        R(bundle);
    }

    private void R(Bundle bundle) {
        ViewPager viewPager = (ViewPager) findViewById(R.id.main_pager);
        this.q = viewPager;
        viewPager.setOffscreenPageLimit(1);
        this.q.setAdapter(new c(s(), O(bundle)));
        this.q.c(new a());
    }

    @Override // android.app.Activity, android.view.ContextThemeWrapper, android.content.ContextWrapper
    protected void attachBaseContext(Context context) {
        super.attachBaseContext(context);
        j.b(this);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Q(bundle);
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, android.app.Activity
    public void onDestroy() {
        super.onDestroy();
    }

    @Override // androidx.appcompat.widget.Toolbar.f
    public boolean onMenuItemClick(MenuItem menuItem) {
        if (menuItem.getItemId() != R.id.action_search) {
            return true;
        }
        com.ape.offlinescriptmanager.utils.a.c(this).f("uiautomator");
        if (com.ape.offlinescriptmanager.utils.a.c(this).d(RunTaskService.class)) {
            Log.v(x, "stop service");
            return true;
        }
        Log.v(x, "start service");
        RunTaskService.q(this);
        return true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        bundle.putString(this.v, this.t.E());
        bundle.putString(this.w, this.u.E());
    }
}
