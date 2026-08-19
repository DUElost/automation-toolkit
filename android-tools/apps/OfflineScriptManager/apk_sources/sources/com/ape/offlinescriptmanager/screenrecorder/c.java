package com.ape.offlinescriptmanager.screenrecorder;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.preference.CheckBoxPreference;
import android.preference.EditTextPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.Toast;
import com.ape.offlinescriptmanager.screenrecorder.ScreenRecorderActivity;
import com.ape.offlinescriptmanager.screenrecorder.folderpicker.FolderChooser;
import com.google.android.material.snackbar.Snackbar;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class c extends PreferenceFragment implements SharedPreferences.OnSharedPreferenceChangeListener, com.ape.offlinescriptmanager.screenrecorder.b, com.ape.offlinescriptmanager.screenrecorder.folderpicker.b, ScreenRecorderActivity.e {

    /* renamed from: b  reason: collision with root package name */
    SharedPreferences f2016b;

    /* renamed from: c  reason: collision with root package name */
    private CheckBoxPreference f2017c;

    /* renamed from: d  reason: collision with root package name */
    private CheckBoxPreference f2018d;
    private FolderChooser e;
    private ScreenRecorderActivity f;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (c.this.f != null) {
                c.this.f.T();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements DialogInterface.OnClickListener {
        b() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            c.this.n();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.screenrecorder.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class DialogInterface$OnClickListenerC0077c implements DialogInterface.OnClickListener {
        DialogInterface$OnClickListenerC0077c() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            if (c.this.f != null) {
                c.this.f.T();
            }
        }
    }

    private float e(float f) {
        return f / 1048576.0f;
    }

    private String g(String str) {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        ((WindowManager) getActivity().getSystemService("window")).getDefaultDisplay().getMetrics(displayMetrics);
        String[] split = str.split("x");
        int i = displayMetrics.widthPixels;
        int i2 = displayMetrics.heightPixels;
        if (i >= Integer.parseInt(split[0]) || i2 >= Integer.parseInt(split[1])) {
            return str;
        }
        ArrayList arrayList = new ArrayList(Arrays.asList(getResources().getStringArray(R.array.resolutionValues)));
        Iterator it = arrayList.iterator();
        while (it.hasNext()) {
            String str2 = (String) it.next();
            if (str2.contains(String.valueOf(i))) {
                Toast.makeText(getActivity(), getString(R.string.large_resolution_selected_toast, str2), 0).show();
                return str2;
            }
        }
        return (String) arrayList.get(0);
    }

    private String h(String str, String str2) {
        return this.f2016b.getString(str, str2);
    }

    private void j() {
        ScreenRecorderActivity screenRecorderActivity = this.f;
        if (screenRecorderActivity == null || Build.VERSION.SDK_INT < 23) {
            Log.d("SCREENRECORDER", "API is < 23");
        } else {
            screenRecorderActivity.U();
        }
    }

    private void k() {
        if (getActivity() == null || !(getActivity() instanceof ScreenRecorderActivity)) {
            return;
        }
        ScreenRecorderActivity screenRecorderActivity = (ScreenRecorderActivity) getActivity();
        this.f = screenRecorderActivity;
        screenRecorderActivity.V(this);
    }

    private void l() {
        if (getActivity() == null || !(getActivity() instanceof ScreenRecorderActivity)) {
            return;
        }
        ScreenRecorderActivity screenRecorderActivity = (ScreenRecorderActivity) getActivity();
        this.f = screenRecorderActivity;
        screenRecorderActivity.W(this);
    }

    private void m() {
        new AlertDialog.Builder(this.f).setTitle(R.string.alert_permission_denied_title).setMessage(R.string.alert_permission_denied_message).setPositiveButton(17039379, new DialogInterface$OnClickListenerC0077c()).setNegativeButton(17039369, new b()).setIconAttribute(16843605).setCancelable(false).create().show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void n() {
        Snackbar w = Snackbar.w(getActivity().findViewById(R.id.fab), R.string.snackbar_storage_permission_message, -2);
        w.y(R.string.snackbar_storage_permission_action_enable, new a());
        w.s();
    }

    private void o(ListPreference listPreference) {
        String g = g(h(getString(R.string.res_key), "1440x2560"));
        listPreference.setValue(g);
        listPreference.setSummary(g);
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // com.ape.offlinescriptmanager.screenrecorder.b
    public void a(int i, String[] strArr, int[] iArr) {
        switch (i) {
            case 1000:
                if (iArr.length > 0 && iArr[0] == -1) {
                    Log.d("SCREENRECORDER", "Storage permission denied. Requesting again");
                    this.e.setEnabled(false);
                    m();
                    return;
                } else if (iArr.length <= 0 || iArr[0] != 0) {
                    return;
                } else {
                    this.e.setEnabled(true);
                    return;
                }
            case 1001:
                if (iArr.length <= 0 || iArr[0] != 0) {
                    Log.d("SCREENRECORDER", "Record audio permission denied");
                    this.f2017c.setChecked(false);
                    return;
                }
                Log.d("SCREENRECORDER", "Record audio permission granted.");
                this.f2017c.setChecked(true);
                return;
            case 1002:
                if (iArr.length > 0 && iArr[0] == 0) {
                    Log.d("SCREENRECORDER", "System Windows permission granted");
                    this.f2018d.setChecked(true);
                    break;
                } else {
                    Log.d("SCREENRECORDER", "System Windows permission denied");
                    this.f2018d.setChecked(false);
                    break;
                }
                break;
        }
        Log.d("SCREENRECORDER", "Unknown permission request with request code: " + i);
    }

    @Override // com.ape.offlinescriptmanager.screenrecorder.folderpicker.b
    public void b() {
        Log.d("SCREENRECORDER", "In screen_recorder_settings fragment");
        if (getActivity() == null || !(getActivity() instanceof ScreenRecorderActivity)) {
            return;
        }
        ((ScreenRecorderActivity) getActivity()).R();
    }

    public String f() {
        String string = this.f2016b.getString(getString(R.string.filename_key), "yyyyMMdd_hhmmss");
        String string2 = this.f2016b.getString(getString(R.string.fileprefix_key), "recording");
        return string2 + "_" + string;
    }

    public void i() {
        ScreenRecorderActivity screenRecorderActivity = this.f;
        if (screenRecorderActivity != null) {
            screenRecorderActivity.S();
        }
    }

    @Override // android.preference.PreferenceFragment, android.app.Fragment
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
    }

    @Override // android.preference.PreferenceFragment, android.app.Fragment
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        addPreferencesFromResource(R.xml.screen_recorder_settings);
        l();
        k();
        String path = new File(com.ape.offlinescriptmanager.screenrecorder.a.f2012a).getPath();
        this.f2016b = getPreferenceScreen().getSharedPreferences();
        this.f2017c = (CheckBoxPreference) findPreference(getString(R.string.audiorec_key));
        this.e = (FolderChooser) findPreference(getString(R.string.savelocation_key));
        this.f2018d = (CheckBoxPreference) findPreference(getString(R.string.preference_floating_control_key));
        this.e.o(h(getString(R.string.savelocation_key), path));
        o((ListPreference) findPreference(getString(R.string.res_key)));
        ((ListPreference) findPreference(getString(R.string.fps_key))).setSummary(h(getString(R.string.fps_key), "30"));
        float e = e(Integer.parseInt(h(getString(R.string.bitrate_key), "7130317")));
        ((ListPreference) findPreference(getString(R.string.bitrate_key))).setSummary(e + " Mbps");
        this.e.setSummary(h(getString(R.string.savelocation_key), path));
        ((ListPreference) findPreference(getString(R.string.filename_key))).setSummary(f());
        ((EditTextPreference) findPreference(getString(R.string.fileprefix_key))).setSummary(h(getString(R.string.fileprefix_key), "recording"));
        if (this.f2017c.isChecked()) {
            i();
        }
        if (this.f2018d.isChecked()) {
            j();
        }
        this.e.p(this);
    }

    @Override // android.app.Fragment
    public void onPause() {
        super.onPause();
        getPreferenceScreen().getSharedPreferences().unregisterOnSharedPreferenceChangeListener(this);
    }

    @Override // android.app.Fragment
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
    }

    @Override // android.app.Fragment
    public void onResume() {
        super.onResume();
        getPreferenceScreen().getSharedPreferences().registerOnSharedPreferenceChangeListener(this);
    }

    @Override // android.content.SharedPreferences.OnSharedPreferenceChangeListener
    public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String str) {
        String str2;
        Preference findPreference = findPreference(str);
        if (findPreference == null) {
            return;
        }
        switch (findPreference.getTitleRes()) {
            case R.string.preference_audio_record_title /* 2131690088 */:
                i();
                return;
            case R.string.preference_bit_title /* 2131690090 */:
                str2 = e(Integer.parseInt(h(getString(R.string.bitrate_key), "7130317"))) + " Mbps";
                break;
            case R.string.preference_filename_format_title /* 2131690091 */:
                str2 = f();
                break;
            case R.string.preference_filename_prefix_title /* 2131690092 */:
                EditTextPreference editTextPreference = (EditTextPreference) findPreference;
                editTextPreference.setSummary(editTextPreference.getText());
                ((ListPreference) findPreference(getString(R.string.filename_key))).setSummary(f());
                return;
            case R.string.preference_floating_control_title /* 2131690098 */:
                j();
                return;
            case R.string.preference_resolution_title /* 2131690103 */:
                o((ListPreference) findPreference);
                return;
            default:
                return;
        }
        findPreference.setSummary(str2);
    }
}
