package com.ape.offlinescriptmanager.screenrecorder;

import android.annotation.TargetApi;
import android.app.ActivityManager;
import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.DialogInterface;
import android.content.Intent;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;
import androidx.viewpager.widget.ViewPager;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.tabs.TabLayout;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class ScreenRecorderActivity extends androidx.appcompat.app.c {
    private com.ape.offlinescriptmanager.screenrecorder.b q;
    private MediaProjection r;
    private MediaProjectionManager s;
    private FloatingActionButton t;
    private TabLayout u;
    private ViewPager v;

    /* loaded from: classes.dex */
    class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (ScreenRecorderActivity.this.r == null && !ScreenRecorderActivity.this.Q(RecorderService.class)) {
                ScreenRecorderActivity screenRecorderActivity = ScreenRecorderActivity.this;
                screenRecorderActivity.startActivityForResult(screenRecorderActivity.s.createScreenCaptureIntent(), 1003);
            } else if (ScreenRecorderActivity.this.Q(RecorderService.class)) {
                Toast.makeText(ScreenRecorderActivity.this, "Screen already recording", 0).show();
            }
        }
    }

    /* loaded from: classes.dex */
    class b implements View.OnLongClickListener {
        b() {
        }

        @Override // android.view.View.OnLongClickListener
        public boolean onLongClick(View view) {
            Toast.makeText(ScreenRecorderActivity.this, (int) R.string.fab_record_hint, 0).show();
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
                ScreenRecorderActivity.this.t.t();
            } else if (i != 1) {
            } else {
                ScreenRecorderActivity.this.t.k();
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
            androidx.core.app.a.j(ScreenRecorderActivity.this, new String[]{"android.permission.WRITE_EXTERNAL_STORAGE"}, 1000);
        }
    }

    /* loaded from: classes.dex */
    public interface e {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f extends androidx.legacy.app.b {
        private final List<Fragment> g;
        private final List<String> h;

        f(ScreenRecorderActivity screenRecorderActivity, FragmentManager fragmentManager) {
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

    public static void P() {
        File file = new File(com.ape.offlinescriptmanager.screenrecorder.a.f2012a);
        if (!Environment.getExternalStorageState().equals("mounted") || file.isDirectory()) {
            return;
        }
        file.mkdirs();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean Q(Class<?> cls) {
        for (ActivityManager.RunningServiceInfo runningServiceInfo : ((ActivityManager) getSystemService("activity")).getRunningServices(Integer.MAX_VALUE)) {
            if (cls.getName().equals(runningServiceInfo.service.getClassName())) {
                return true;
            }
        }
        return false;
    }

    @TargetApi(23)
    private void X() {
        if (Build.VERSION.SDK_INT < 23) {
            this.q.a(1002, new String[]{"System Windows Permission"}, new int[]{0});
        } else if (Settings.canDrawOverlays(this)) {
            this.q.a(1002, new String[]{"System Windows Permission"}, new int[]{0});
        } else {
            this.q.a(1002, new String[]{"System Windows Permission"}, new int[]{-1});
        }
    }

    private void Y(ViewPager viewPager) {
        f fVar = new f(this, getFragmentManager());
        fVar.q(new com.ape.offlinescriptmanager.screenrecorder.c(), getString(R.string.tab_settings_title));
        fVar.q(new com.ape.offlinescriptmanager.screenrecorder.d(), getString(R.string.tab_videos_title));
        viewPager.setAdapter(fVar);
        viewPager.c(new c());
    }

    public void R() {
        ((com.ape.offlinescriptmanager.screenrecorder.d) ((f) this.v.getAdapter()).p(1)).k();
        Log.d("SCREENRECORDER", "reached main act");
    }

    public void S() {
        if (androidx.core.content.a.a(this, "android.permission.RECORD_AUDIO") != 0) {
            androidx.core.app.a.j(this, new String[]{"android.permission.RECORD_AUDIO"}, 1001);
        }
    }

    public boolean T() {
        if (androidx.core.content.a.a(this, "android.permission.WRITE_EXTERNAL_STORAGE") != 0) {
            new AlertDialog.Builder(this).setTitle(getString(R.string.storage_permission_request_title)).setMessage(getString(R.string.storage_permission_request_summary)).setNeutralButton(getString(R.string.ok), new d()).setCancelable(false).create().show();
            return false;
        }
        return true;
    }

    @TargetApi(23)
    public void U() {
        if (Settings.canDrawOverlays(this)) {
            return;
        }
        startActivityForResult(new Intent("android.settings.action.MANAGE_OVERLAY_PERMISSION", Uri.parse("package:" + getPackageName())), 1002);
    }

    public void V(e eVar) {
    }

    public void W(com.ape.offlinescriptmanager.screenrecorder.b bVar) {
        this.q = bVar;
    }

    @Override // androidx.fragment.app.b, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == 1002) {
            X();
        } else if (i2 == 0 && i == 1003) {
            Toast.makeText(this, getString(R.string.screen_recording_permission_denied), 0).show();
        } else {
            Intent intent2 = new Intent(this, RecorderService.class);
            intent2.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.startrecording");
            intent2.putExtra("recorder_intent_data", intent);
            intent2.putExtra("recorder_intent_result", i2);
            if (Build.VERSION.SDK_INT >= 26) {
                startForegroundService(intent2);
            }
            finish();
        }
    }

    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_screenrecorder);
        ViewPager viewPager = (ViewPager) findViewById(R.id.viewpager);
        this.v = viewPager;
        Y(viewPager);
        TabLayout tabLayout = (TabLayout) findViewById(R.id.tabs);
        this.u = tabLayout;
        tabLayout.setupWithViewPager(this.v);
        PreferenceManager.getDefaultSharedPreferences(this);
        T();
        if (getIntent().getAction() != null && getIntent().getAction().equals(getString(R.string.app_shortcut_action))) {
            startActivityForResult(this.s.createScreenCaptureIntent(), 1003);
            return;
        }
        this.t = (FloatingActionButton) findViewById(R.id.fab);
        if (Q(RecorderService.class)) {
            Log.d("SCREENRECORDER", "service is running");
        }
        this.t.setOnClickListener(new a());
        this.t.setOnLongClickListener(new b());
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.about, menu);
        return true;
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        Intent intent;
        int itemId = menuItem.getItemId();
        if (itemId == R.id.about) {
            intent = new Intent(this, AboutActivity.class);
        } else if (itemId != R.id.privacy_policy) {
            return super.onOptionsItemSelected(menuItem);
        } else {
            intent = new Intent(this, PrivacyPolicy.class);
        }
        startActivity(intent);
        return true;
    }

    @Override // androidx.fragment.app.b, android.app.Activity, androidx.core.app.a.b
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        super.onRequestPermissionsResult(i, strArr, iArr);
        if (i == 1000) {
            if (iArr.length <= 0 || iArr[0] == 0) {
                Log.d("SCREENRECORDER", "write storage Permission granted");
                P();
            } else {
                Log.d("SCREENRECORDER", "write storage Permission Denied");
                this.t.setEnabled(false);
            }
        }
        com.ape.offlinescriptmanager.screenrecorder.b bVar = this.q;
        if (bVar != null) {
            bVar.a(i, strArr, iArr);
        }
    }

    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, android.app.Activity
    protected void onStart() {
        super.onStart();
    }

    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, android.app.Activity
    protected void onStop() {
        super.onStop();
    }
}
