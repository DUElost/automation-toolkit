package com.ape.offlinescriptmanager.crashlistener;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.EditTextPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.util.Log;
import android.view.View;
import android.widget.Toast;
import com.ape.offlinescriptmanager.screenrecorder.folderpicker.FolderChooser;
import com.ape.offlinescriptmanager.utils.g;
import com.google.android.material.snackbar.Snackbar;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class c extends PreferenceFragment implements com.ape.offlinescriptmanager.screenrecorder.b, com.ape.offlinescriptmanager.screenrecorder.folderpicker.b, SharedPreferences.OnSharedPreferenceChangeListener {

    /* renamed from: b  reason: collision with root package name */
    SharedPreferences f1954b;

    /* renamed from: c  reason: collision with root package name */
    private FolderChooser f1955c;

    /* renamed from: d  reason: collision with root package name */
    CrashListenerActivity f1956d;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements DialogInterface.OnClickListener {
        a() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            c.this.g();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements DialogInterface.OnClickListener {
        b() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            CrashListenerActivity crashListenerActivity = c.this.f1956d;
            if (crashListenerActivity != null) {
                crashListenerActivity.R();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.crashlistener.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0073c implements View.OnClickListener {
        View$OnClickListenerC0073c() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            CrashListenerActivity crashListenerActivity = c.this.f1956d;
            if (crashListenerActivity != null) {
                crashListenerActivity.R();
            }
        }
    }

    private void e() {
        if (getActivity() == null || !(getActivity() instanceof CrashListenerActivity)) {
            return;
        }
        CrashListenerActivity crashListenerActivity = (CrashListenerActivity) getActivity();
        this.f1956d = crashListenerActivity;
        crashListenerActivity.S(this);
    }

    private void f() {
        new AlertDialog.Builder(this.f1956d).setTitle(R.string.alert_permission_denied_title).setMessage(R.string.alert_permission_denied_message).setPositiveButton(17039379, new b()).setNegativeButton(17039369, new a()).setIconAttribute(16843605).setCancelable(false).create().show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g() {
        Snackbar w = Snackbar.w(getActivity().findViewById(R.id.fab), R.string.snackbar_storage_permission_message, -2);
        w.y(R.string.snackbar_storage_permission_action_enable, new View$OnClickListenerC0073c());
        w.s();
    }

    @Override // com.ape.offlinescriptmanager.screenrecorder.b
    public void a(int i, String[] strArr, int[] iArr) {
        if (i != 11000) {
            return;
        }
        if (iArr.length > 0 && iArr[0] == -1) {
            Log.d("SCREENRECORDER", "Storage permission denied. Requesting again");
            this.f1955c.setEnabled(false);
            f();
        } else if (iArr.length <= 0 || iArr[0] != 0) {
        } else {
            this.f1955c.setEnabled(true);
        }
    }

    @Override // com.ape.offlinescriptmanager.screenrecorder.folderpicker.b
    public void b() {
        Log.d("SCREENRECORDER", "In screen_recorder_settings fragment");
        if (getActivity() == null || !(getActivity() instanceof CrashListenerActivity)) {
            return;
        }
        ((CrashListenerActivity) getActivity()).P();
    }

    public String d() {
        String string = this.f1954b.getString(getString(R.string.crash_file_name_key), "yyyyMMdd_hhmmss");
        String string2 = this.f1954b.getString(getString(R.string.crash_file_name_prefix_key), getString(R.string.crash_listener_prefix_default));
        return string2 + "_" + string;
    }

    @Override // android.preference.PreferenceFragment, android.app.Fragment
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
    }

    @Override // android.preference.PreferenceFragment, android.app.Fragment
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        addPreferencesFromResource(R.xml.crash_listener_settings);
        e();
        String t = g.t();
        this.f1954b = getPreferenceScreen().getSharedPreferences();
        ((EditTextPreference) findPreference(getString(R.string.crash_listener_interval_time_key))).setSummary(this.f1954b.getString(getString(R.string.crash_listener_interval_time_key), "200"));
        FolderChooser folderChooser = (FolderChooser) findPreference(getString(R.string.crash_save_location_key));
        this.f1955c = folderChooser;
        folderChooser.o(this.f1954b.getString(getString(R.string.crash_save_location_key), t));
        this.f1955c.setSummary(this.f1954b.getString(getString(R.string.crash_save_location_key), t));
        ((ListPreference) findPreference(getString(R.string.crash_file_name_key))).setSummary(d());
        ((EditTextPreference) findPreference(getString(R.string.crash_file_name_prefix_key))).setSummary(this.f1954b.getString(getString(R.string.crash_file_name_prefix_key), getString(R.string.crash_listener_prefix_default)));
        this.f1955c.p(this);
    }

    @Override // android.app.Fragment
    public void onPause() {
        super.onPause();
        getPreferenceScreen().getSharedPreferences().unregisterOnSharedPreferenceChangeListener(this);
    }

    @Override // android.app.Fragment
    public void onResume() {
        super.onResume();
        getPreferenceScreen().getSharedPreferences().registerOnSharedPreferenceChangeListener(this);
    }

    @Override // android.content.SharedPreferences.OnSharedPreferenceChangeListener
    public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String str) {
        Preference findPreference = findPreference(str);
        if (findPreference == null) {
            return;
        }
        switch (findPreference.getTitleRes()) {
            case R.string.preference_filename_format_title /* 2131690091 */:
                findPreference.setSummary(d());
                return;
            case R.string.preference_filename_prefix_title /* 2131690092 */:
                EditTextPreference editTextPreference = (EditTextPreference) findPreference;
                editTextPreference.setSummary(editTextPreference.getText());
                ((ListPreference) findPreference(getString(R.string.crash_file_name_key))).setSummary(d());
                return;
            case R.string.preference_listener_interval_time_title /* 2131690101 */:
                EditTextPreference editTextPreference2 = (EditTextPreference) findPreference;
                if (Long.valueOf(editTextPreference2.getText()).longValue() <= 0) {
                    Toast.makeText(editTextPreference2.getContext(), "input interval must more then 0", 0).show();
                    return;
                } else {
                    editTextPreference2.setSummary(editTextPreference2.getText());
                    return;
                }
            default:
                return;
        }
    }
}
