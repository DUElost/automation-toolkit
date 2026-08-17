package com.ape.offlinescriptmanager.crashlistener;

import android.app.ActivityManager;
import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.projection.MediaProjectionManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.Toast;
import androidx.viewpager.widget.ViewPager;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.j;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.tabs.TabLayout;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class CrashListenerActivity extends androidx.appcompat.app.c {
    public static final String u = CrashListenerActivity.class.getSimpleName();
    private com.ape.offlinescriptmanager.screenrecorder.b q;
    private FloatingActionButton r;
    private TabLayout s;
    private ViewPager t;

    /* loaded from: classes.dex */
    class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (CrashListenerActivity.this.O(CrashListenerService.class)) {
                Toast.makeText(CrashListenerActivity.this, "listener already running", 0).show();
                return;
            }
            CrashListenerActivity.this.Q();
            CrashListenerService.k(CrashListenerActivity.this.getApplicationContext());
        }
    }

    /* loaded from: classes.dex */
    class b implements View.OnLongClickListener {
        b() {
        }

        @Override // android.view.View.OnLongClickListener
        public boolean onLongClick(View view) {
            Toast.makeText(CrashListenerActivity.this, (int) R.string.fab_record_hint, 0).show();
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements ViewPager.j {
        c() {
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void c(int i, float f, int i2) {
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void f(int i) {
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void j(int i) {
            if (i == 0) {
                CrashListenerActivity.this.r.t();
            } else if (i != 1) {
            } else {
                CrashListenerActivity.this.r.k();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements DialogInterface.OnClickListener {
        d() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            androidx.core.app.a.j(CrashListenerActivity.this, new String[]{"android.permission.WRITE_EXTERNAL_STORAGE"}, 11000);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e extends androidx.legacy.app.b {
        private final List<Fragment> g;
        private final List<String> h;

        e(CrashListenerActivity crashListenerActivity, FragmentManager fragmentManager) {
            super(fragmentManager);
            this.g = new ArrayList();
            this.h = new ArrayList();
        }

        @Override // androidx.viewpager.widget.a
        public int c() {
            return this.g.size();
        }

        @Override // androidx.viewpager.widget.a
        public int d(Object obj) {
            return super.d(obj);
        }

        @Override // androidx.viewpager.widget.a
        public CharSequence e(int i) {
            return this.h.get(i);
        }

        @Override // androidx.legacy.app.b
        public Fragment p(int i) {
            return this.g.get(i);
        }

        void q(Fragment fragment, String str) {
            this.g.add(fragment);
            this.h.add(str);
        }
    }

    public static void N(Context context, SharedPreferences sharedPreferences) {
        File file = new File(sharedPreferences.getString(context.getString(R.string.crash_save_location_key), g.t()));
        if (!Environment.getExternalStorageState().equals("mounted") || file.isDirectory()) {
            return;
        }
        file.mkdirs();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean O(Class<?> cls) {
        for (ActivityManager.RunningServiceInfo runningServiceInfo : ((ActivityManager) getSystemService("activity")).getRunningServices(Integer.MAX_VALUE)) {
            if (cls.getName().equals(runningServiceInfo.service.getClassName())) {
                return true;
            }
        }
        return false;
    }

    private void T(ViewPager viewPager) {
        e eVar = new e(this, getFragmentManager());
        eVar.q(new com.ape.offlinescriptmanager.crashlistener.c(), getString(R.string.tab_settings_title));
        eVar.q(new com.ape.offlinescriptmanager.crashlistener.a(), getString(R.string.tab_picture_title));
        viewPager.setAdapter(eVar);
        viewPager.c(new c());
    }

    public void P() {
        ((com.ape.offlinescriptmanager.crashlistener.a) ((e) this.t.getAdapter()).p(1)).k();
        Log.d("SCREENRECORDER", "reached main act");
    }

    public void Q() {
        if (Build.VERSION.SDK_INT < 21) {
            return;
        }
        androidx.core.content.a.a(this, "android.permission.RECORD_AUDIO");
        startActivityForResult(((MediaProjectionManager) getSystemService("media_projection")).createScreenCaptureIntent(), 11100);
    }

    public boolean R() {
        if (androidx.core.content.a.a(this, "android.permission.WRITE_EXTERNAL_STORAGE") != 0) {
            new AlertDialog.Builder(this).setTitle(getString(R.string.storage_permission_request_title)).setMessage(getString(R.string.storage_permission_request_summary)).setNeutralButton(getString(R.string.ok), new d()).setCancelable(false).create().show();
            return false;
        }
        return true;
    }

    public void S(com.ape.offlinescriptmanager.screenrecorder.b bVar) {
        this.q = bVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, android.app.Activity
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityReenter(i2, intent);
        if (i2 == 0 && i == 11100) {
            Toast.makeText(this, getString(R.string.screen_recording_permission_denied), 0).show();
        } else {
            com.ape.offlinescriptmanager.crashlistener.b.j(intent);
        }
    }

    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        j.b(u, "onCreate");
        setContentView(R.layout.activity_screenrecorder);
        ViewPager viewPager = (ViewPager) findViewById(R.id.viewpager);
        this.t = viewPager;
        T(viewPager);
        TabLayout tabLayout = (TabLayout) findViewById(R.id.tabs);
        this.s = tabLayout;
        tabLayout.setupWithViewPager(this.t);
        PreferenceManager.getDefaultSharedPreferences(this);
        R();
        this.r = (FloatingActionButton) findViewById(R.id.fab);
        if (O(CrashListenerService.class)) {
            Log.d("SCREENRECORDER", "service is running");
        }
        this.r.setOnClickListener(new a());
        this.r.setOnLongClickListener(new b());
    }

    @Override // androidx.fragment.app.b, android.app.Activity, androidx.core.app.a.b
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        super.onRequestPermissionsResult(i, strArr, iArr);
        if (i == 11000) {
            if (iArr.length <= 0 || iArr[0] == 0) {
                j.a(u, "write storage Permission granted");
            } else {
                j.a(u, "write storage Permission Denied");
                this.r.setEnabled(false);
            }
        }
        com.ape.offlinescriptmanager.screenrecorder.b bVar = this.q;
        if (bVar != null) {
            bVar.a(i, strArr, iArr);
        }
    }
}
