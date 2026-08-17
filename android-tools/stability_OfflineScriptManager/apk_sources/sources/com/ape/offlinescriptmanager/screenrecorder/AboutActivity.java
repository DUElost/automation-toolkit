package com.ape.offlinescriptmanager.screenrecorder;

import android.os.Bundle;
import android.text.Html;
import android.text.Spanned;
import android.view.MenuItem;
import android.widget.TextView;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class AboutActivity extends androidx.appcompat.app.c {
    public static Spanned L(String str) {
        return Html.fromHtml(str, 0);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        androidx.appcompat.app.a C = C();
        if (C != null) {
            C.s(true);
        }
        setContentView(R.layout.activity_screenrecorder_about);
        ((TextView) findViewById(R.id.icon_credit_tv)).setText(getString(R.string.app_icon_credit_Niko, new Object[]{"Niko Hörkkö", "http://nikosite.net"}));
        ((TextView) findViewById(R.id.video_editor_lib_credit_tv)).setText(getString(R.string.video_editor_library_credit, new Object[]{"knowledge4life", "https://github.com/knowledge4life/k4l-video-trimmer", "MIT Opensource License"}));
        ((TextView) findViewById(R.id.analytics_lib_credit_tv)).setText(getString(R.string.analytics_library_credit, new Object[]{"Countly", "https://github.com/Countly/countly-sdk-android", "MIT Opensource License"}));
        ((TextView) findViewById(R.id.opensource_info_tv)).setText(getString(R.string.opensource_info, new Object[]{"https://github.com/vijai1996/screenrecorder", "GNU AGPLv3"}));
        ((TextView) findViewById(R.id.versionTxt)).setText(L("Copyright &copy; orpheusdroid 2014-2016\n" + getResources().getString(R.string.app_name) + " V1.2.2"));
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        if (menuItem.getItemId() != 16908332) {
            return super.onOptionsItemSelected(menuItem);
        }
        finish();
        return true;
    }
}
