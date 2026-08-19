package com.ape.offlinescriptmanager.batterytool;

import android.app.AlertDialog;
import android.content.Context;
import android.content.CursorLoader;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTabHost;
import com.ape.offlinescriptmanager.crashlistener.CrashListenerActivity;
import com.ape.offlinescriptmanager.utils.MyApplication;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.k;
import com.ape.offlinescriptmanager.view.AboutActivity;
import com.ape.offlinescriptmanager.view.UploadActivity;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class BatteryActivity extends com.ape.offlinescriptmanager.batterytool.e.a {
    private SharedPreferences s;
    private com.ape.offlinescriptmanager.utils.a t;
    private Context u;
    private int[] v = {R.string.function_test_fragment_title, R.string.percentage_fragment_title, R.string.voltage_fragment_title, R.string.temperature_fragment_title};

    /* loaded from: classes.dex */
    class a implements DialogInterface.OnClickListener {
        a() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            BatteryActivity.this.t.a();
            Toast.makeText(BatteryActivity.this.u, (int) R.string.clear_over, 0).show();
        }
    }

    /* loaded from: classes.dex */
    class b implements DialogInterface.OnClickListener {
        b(BatteryActivity batteryActivity) {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
        }
    }

    /* loaded from: classes.dex */
    class c implements DialogInterface.OnClickListener {
        c() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            BatteryActivity.this.finish();
        }
    }

    /* loaded from: classes.dex */
    class d implements DialogInterface.OnClickListener {
        d(BatteryActivity batteryActivity) {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
        }
    }

    @Override // com.ape.offlinescriptmanager.batterytool.e.a
    public void B() {
        Fragment o1;
        int i = 0;
        int i2 = 0;
        while (true) {
            int[] iArr = this.v;
            if (i2 >= iArr.length) {
                break;
            }
            FragmentTabHost fragmentTabHost = this.o;
            fragmentTabHost.a(fragmentTabHost.newTabSpec(getString(iArr[i2])).setIndicator(getString(this.v[i2])), Fragment.class, null);
            i2++;
        }
        while (true) {
            int[] iArr2 = this.v;
            if (i >= iArr2.length) {
                this.p.setAdapter(new com.ape.offlinescriptmanager.batterytool.e.b(s(), this.q));
                if (this.v.length == 1) {
                    this.o.getTabWidget().setVisibility(8);
                    return;
                }
                return;
            }
            switch (iArr2[i]) {
                case R.string.function_test_fragment_title /* 2131689600 */:
                    o1 = com.ape.offlinescriptmanager.view.c.a.o1();
                    Bundle bundle = new Bundle();
                    bundle.putString("TASK", "/sdcard/runtask.xml");
                    o1.Z0(bundle);
                    break;
                case R.string.percentage_fragment_title /* 2131690085 */:
                    o1 = new com.ape.offlinescriptmanager.batterytool.a();
                    break;
                case R.string.temperature_fragment_title /* 2131690211 */:
                    o1 = new com.ape.offlinescriptmanager.batterytool.b();
                    break;
                case R.string.voltage_fragment_title /* 2131690226 */:
                    o1 = new com.ape.offlinescriptmanager.batterytool.c();
                    break;
                default:
                    o1 = null;
                    break;
            }
            this.q.add(o1);
            i++;
        }
    }

    @Override // androidx.fragment.app.b, android.app.Activity
    public void onBackPressed() {
        if (!getSharedPreferences("xuhang_data", 0).getBoolean("isRunning", false)) {
            super.onBackPressed();
            return;
        }
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.str_running_notice_title).setMessage(R.string.str_running_notice_message);
        builder.setPositiveButton(17039370, new c());
        builder.setNegativeButton(17039360, new d(this));
        builder.create().show();
    }

    @Override // com.ape.offlinescriptmanager.batterytool.e.a, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.u = getApplicationContext();
        this.t = new com.ape.offlinescriptmanager.utils.a(this.u);
        SharedPreferences sharedPreferences = getSharedPreferences("update_data", 0);
        this.s = sharedPreferences;
        if (sharedPreferences.getBoolean("isUpdating", false)) {
            return;
        }
        Toast.makeText(this.u, (int) R.string.show_updating_message, 0).show();
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_battery, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        Intent intent;
        int itemId = menuItem.getItemId();
        if (itemId == R.id.about) {
            intent = new Intent(this, AboutActivity.class);
        } else if (itemId != R.id.result_upload) {
            switch (itemId) {
                case R.id.battery_menu_clear /* 2131296304 */:
                    g.I(this, R.string.alert_message, new a(), new b(this));
                    break;
                case R.id.battery_menu_crash_listen /* 2131296305 */:
                    intent = new Intent(this, CrashListenerActivity.class);
                    break;
                case R.id.battery_menu_export /* 2131296306 */:
                    if (!this.t.e(2L)) {
                        this.t.j(this.u);
                        break;
                    } else {
                        this.t.h("com.ape.offlinescriptmanager.pref", "export_data_no_empty", false);
                        new com.ape.offlinescriptmanager.batterytool.g.b(this, g.x(), true, true).execute(new Void[0]);
                        break;
                    }
                case R.id.battery_menu_hop /* 2131296307 */:
                    CursorLoader cursorLoader = new CursorLoader(this, com.ape.offlinescriptmanager.database.b.f1973a, com.ape.offlinescriptmanager.database.b.f1974b, null, null, "_id ASC");
                    Cursor loadInBackground = cursorLoader.loadInBackground();
                    if (loadInBackground != null) {
                        try {
                            if (loadInBackground.getCount() > 0) {
                                startActivity(new Intent(this, HopDataShowActivity.class));
                                if (loadInBackground != null && !loadInBackground.isClosed()) {
                                    loadInBackground.close();
                                    break;
                                }
                            }
                        } finally {
                            cursorLoader.cancelLoad();
                            if (loadInBackground != null && !loadInBackground.isClosed()) {
                                loadInBackground.close();
                            }
                        }
                    }
                    Toast.makeText(this, (int) R.string.hop_data_null, 0).show();
                    if (loadInBackground != null) {
                        loadInBackground.close();
                    }
                    break;
            }
            return super.onOptionsItemSelected(menuItem);
        } else {
            intent = new Intent(this, UploadActivity.class);
        }
        startActivity(intent);
        return super.onOptionsItemSelected(menuItem);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, android.app.Activity
    public void onResume() {
        super.onResume();
        new k(this).b();
        MyApplication.a().b("长按可修改Task参数");
    }
}
